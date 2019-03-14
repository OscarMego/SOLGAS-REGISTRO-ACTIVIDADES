using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Diagnostics;
using System.Reflection;
using System.Web.Script.Serialization;

namespace Controller.functions
{
    public class ExceptionUtils
    {
        public static String getHtmlErrorPage(Exception ex)
        {
            String html =   "<style type='text/css' media='all'>@import '" + HttpContext.Current.Server.MapPath("~") + "css/Forms.css';</style> " +
                            "<style> " +
                            ".content-box-top { float:left; padding:0px; margin:15px; width:98%; } " +
                            ".content-box-footer { position: absolute; bottom: 0; left: 0; width: 100%; height:50px; background-color:#F00;	} " +
                            ".content-box-footer p { float:left; margin: 12px 0px 0px 15px; padding: 0px; color:#FFF; " +
                            "                        font-family:Arial, Helvetica, sans-serif; font-size:22px; font-weight:bold;     } " +
                            ".content-box-footer img { float:right; margin-right:10px; margin-top: 2px;	} " +
                            ".cell-label{ float:left; padding:0px; margin:0px; width:98%;  } " +
                            ".cell-label p { float:left; padding:0px; margin:0px; font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; color:#F00; }" +
                            ".cell-content{ float:left; padding:0px; margin:0px; width:97%;	} " +
                            ".cell-content p { padding:0px; margin:0px 0px 5px 0px; font-family:Arial, Helvetica, sans-serif; font-size:12px;  } " +
                            ".cell-content #box{ padding:10px; margin:3px 0px 0px 0px; max-height:210px; background-color:#EEEEEE;} " +
                            ".cell-content #content{ padding:0px; margin:0px; font-family:Arial, Helvetica, sans-serif; font-size:12px; max-height:210px; overflow: auto;   } " +
                            "</style> " +
                            "<div class='content-box-top'> " +
                            " <div> " +
                            "     <div class='cell-label'><p>Offending URL:</p></div> " +
                            "     <div class='cell-content'><p>" + HttpContext.Current.Request.Url.ToString() + "</p></div> " +
                            " </div> " +
                            " <div> " +
                            "     <div class='cell-label'><p>Source:</p></div> " +
                            "     <div class='cell-content'><p>" + ex.Source + "</p></div> " +
                            " </div> " +
                            " <div> " +
                            "     <div class='cell-label'><p>Message:</p></div> " +
                            "     <div class='cell-content'><p>" + ex.Message + "</p></div> " +
                            " </div> " +
                            " <div> " +
                            "     <div class='cell-label'><p>Stack trace:</p></div> " +
                            "     <div class='cell-content'><div id='box'><div id='content'>" + ExceptionUtils.GenerateFormattedStackTrace(ExceptionUtils.GenerateExceptionStack(ex)).Trim() + "</div></div></div></div> " +
                            " </div> " +
                            "</div> ";
                            //"<div class='content-box-footer'><p>Error de Servidor</p><img src='images/logo_top_nextel.png' /></div> ";
            return html;
        }

        public static String errorDescripctionToJSON(Exception ex)
        {
            String strUrl = HttpContext.Current.Request.Url.ToString();
            String strSource = ex.Source;
            String strMessage = ex.Message;
            String strStack = ExceptionUtils.GenerateFormattedStackTrace(ExceptionUtils.GenerateExceptionStack(ex)).Trim();

            JavaScriptSerializer js = new JavaScriptSerializer();
            ErrorBean errorBean = new ErrorBean();
            errorBean.url = strUrl;
            errorBean.source = strSource;
            errorBean.message = strMessage;
            errorBean.stack = strStack;

            return js.Serialize(errorBean);

        }



        // reverse the stack
        private static Stack<Exception> GenerateExceptionStack(Exception exception)
        {
            var exceptionStack = new Stack<Exception>();

            // create exception stack
            for (Exception e = exception; e != null; e = e.InnerException)
            {
                exceptionStack.Push(e);
            }

            return exceptionStack;
        }

        // render stack
        private static String GenerateFormattedStackTrace(Stack<Exception> exceptionStack)
        {
            StringBuilder trace = new StringBuilder();

            try
            {
                // loop through exception stack
                while (exceptionStack.Count != 0)
                {
                    //trace.Append("\r\n");

                    // render exception type and message
                    Exception ex = exceptionStack.Pop();
                    trace.Append("[" + ex.GetType().Name);
                    if (!string.IsNullOrEmpty(ex.Message))
                    {
                        trace.Append(":" + ex.Message);
                    }
                    trace.Append("]\r\n");

                    // Load stack trace
                    StackTrace stackTrace = new StackTrace(ex, true);
                    for (int frame = 0; frame < stackTrace.FrameCount; frame++)
                    {
                        StackFrame stackFrame = stackTrace.GetFrame(frame);
                        MethodBase method = stackFrame.GetMethod();
                        Type declaringType = method.DeclaringType;
                        string declaringNamespace = "";

                        // get declaring type information
                        if (declaringType != null)
                        {
                            declaringNamespace = declaringType.Namespace ?? "";
                        }

                        // add namespace
                        if (!string.IsNullOrEmpty(declaringNamespace))
                        {
                            declaringNamespace += ".";
                        }

                        // add method
                        if (declaringType == null)
                        {
                            trace.Append(" " + method.Name + "(");
                        }
                        else
                        {
                            trace.Append(" " + declaringNamespace + declaringType.Name + "." + method.Name + "(");
                        }

                        // get parameter information
                        ParameterInfo[] parameters = method.GetParameters();
                        for (int paramIndex = 0; paramIndex < parameters.Length; paramIndex++)
                        {
                            trace.Append(((paramIndex != 0) ? "," : "") + parameters[paramIndex].ParameterType.Name + " " + parameters[paramIndex].Name);
                        }
                        trace.Append(")");


                        // get information
                        string fileName = stackFrame.GetFileName() ?? "";

                        if (!string.IsNullOrEmpty(fileName))
                        {
                            trace.Append(string.Concat(new object[] { " in ", fileName, ":", stackFrame.GetFileLineNumber() }));
                        }
                        else
                        {
                            trace.Append(" + " + stackFrame.GetNativeOffset());
                        }

                        trace.Append("\r\n");
                    }
                }
            }
            catch
            {
            }

            if (trace.Length == 0)
            {
                trace.Append("[stack trace unavailable]");
            }

            // return html safe stack trace
            return HttpUtility.HtmlEncode(trace.ToString()).Replace(Environment.NewLine, "<br>");
        }

        private class ErrorBean
        {   public String url { get; set; }
            public String source { get; set; }
            public String message { get; set; }
            public String stack { get; set; }
        }

    }
}
