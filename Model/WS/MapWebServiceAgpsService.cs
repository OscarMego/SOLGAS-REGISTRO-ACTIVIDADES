using System.Configuration;

/// <remarks/>
// CODEGEN: The optional WSDL extension element 'PolicyReference' from namespace 'http://schemas.xmlsoap.org/ws/2004/09/policy' was not handled.
// CODEGEN: The optional WSDL extension element 'PolicyReference' from namespace 'http://schemas.xmlsoap.org/ws/2004/09/policy' was not handled.
// CODEGEN: The optional WSDL extension element 'PolicyReference' from namespace 'http://schemas.xmlsoap.org/ws/2004/09/policy' was not handled.
// CODEGEN: The optional WSDL extension element 'PolicyReference' from namespace 'http://schemas.xmlsoap.org/ws/2004/09/policy' was not handled.
// CODEGEN: The optional WSDL extension element 'PolicyReference' from namespace 'http://schemas.xmlsoap.org/ws/2004/09/policy' was not handled.
// CODEGEN: The optional WSDL extension element 'PolicyReference' from namespace 'http://schemas.xmlsoap.org/ws/2004/09/policy' was not handled.
// CODEGEN: The optional WSDL extension element 'PolicyReference' from namespace 'http://schemas.xmlsoap.org/ws/2004/09/policy' was not handled.
// CODEGEN: The optional WSDL extension element 'PolicyReference' from namespace 'http://schemas.xmlsoap.org/ws/2004/09/policy' was not handled.
// CODEGEN: The optional WSDL extension element 'PolicyReference' from namespace 'http://schemas.xmlsoap.org/ws/2004/09/policy' was not handled.
// CODEGEN: The optional WSDL extension element 'PolicyReference' from namespace 'http://schemas.xmlsoap.org/ws/2004/09/policy' was not handled.
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.42")]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
[System.Web.Services.WebServiceBindingAttribute(Name = "MapWebServiceAgpsPortBinding", Namespace = "http://ws/")]
public partial class MapWebServiceAgpsService : System.Web.Services.Protocols.SoapHttpClientProtocol
{
    private System.Threading.SendOrPostCallback GenerarMapaFileOperationCompleted;

    private System.Threading.SendOrPostCallback generaCodigoOperationCompleted;

    private System.Threading.SendOrPostCallback ObtieneUnaDireccionOperationCompleted;

    private System.Threading.SendOrPostCallback ObetenerDireccionesOperationCompleted;

    private System.Threading.SendOrPostCallback ObetenerMapaOperationCompleted;

    private System.Threading.SendOrPostCallback ActualizamapaubicacionOperationCompleted;

    private System.Threading.SendOrPostCallback ActualizamapazoomOperationCompleted;

    private System.Threading.SendOrPostCallback ActualizamapazoomXYOperationCompleted;

    private System.Threading.SendOrPostCallback EncuadrarmapaXYOperationCompleted;

    private System.Threading.SendOrPostCallback EncuadrarmapaAllPointsOperationCompleted;

    /// <remarks/>
    public MapWebServiceAgpsService()
    {
        this.Url = ConfigurationManager.AppSettings["URL_DIRECCION"];
    }

    /// <remarks/>
    public event GenerarMapaFileCompletedEventHandler GenerarMapaFileCompleted;

    /// <remarks/>
    public event generaCodigoCompletedEventHandler generaCodigoCompleted;

    /// <remarks/>
    public event ObtieneUnaDireccionCompletedEventHandler ObtieneUnaDireccionCompleted;

    /// <remarks/>
    public event ObetenerDireccionesCompletedEventHandler ObetenerDireccionesCompleted;

    /// <remarks/>
    public event ObetenerMapaCompletedEventHandler ObetenerMapaCompleted;

    /// <remarks/>
    public event ActualizamapaubicacionCompletedEventHandler ActualizamapaubicacionCompleted;

    /// <remarks/>
    public event ActualizamapazoomCompletedEventHandler ActualizamapazoomCompleted;

    /// <remarks/>
    public event ActualizamapazoomXYCompletedEventHandler ActualizamapazoomXYCompleted;

    /// <remarks/>
    public event EncuadrarmapaXYCompletedEventHandler EncuadrarmapaXYCompleted;

    /// <remarks/>
    public event EncuadrarmapaAllPointsCompletedEventHandler EncuadrarmapaAllPointsCompleted;

    /// <remarks/>
    [System.Web.Services.Protocols.SoapDocumentMethodAttribute("", RequestNamespace = "http://ws/", ResponseNamespace = "http://ws/", Use = System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle = System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
    public void GenerarMapaFile([System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)] vectorPuntosEntity arg0, [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)] string arg1)
    {
        this.Invoke("GenerarMapaFile", new object[] {
                    arg0,
                    arg1});
    }

    /// <remarks/>
    public System.IAsyncResult BeginGenerarMapaFile(vectorPuntosEntity arg0, string arg1, System.AsyncCallback callback, object asyncState)
    {
        return this.BeginInvoke("GenerarMapaFile", new object[] {
                    arg0,
                    arg1}, callback, asyncState);
    }

    /// <remarks/>
    public void EndGenerarMapaFile(System.IAsyncResult asyncResult)
    {
        this.EndInvoke(asyncResult);
    }

    /// <remarks/>
    public void GenerarMapaFileAsync(vectorPuntosEntity arg0, string arg1)
    {
        this.GenerarMapaFileAsync(arg0, arg1, null);
    }

    /// <remarks/>
    public void GenerarMapaFileAsync(vectorPuntosEntity arg0, string arg1, object userState)
    {
        if ((this.GenerarMapaFileOperationCompleted == null))
        {
            this.GenerarMapaFileOperationCompleted = new System.Threading.SendOrPostCallback(this.OnGenerarMapaFileOperationCompleted);
        }
        this.InvokeAsync("GenerarMapaFile", new object[] {
                    arg0,
                    arg1}, this.GenerarMapaFileOperationCompleted, userState);
    }

    private void OnGenerarMapaFileOperationCompleted(object arg)
    {
        if ((this.GenerarMapaFileCompleted != null))
        {
            System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
            this.GenerarMapaFileCompleted(this, new System.ComponentModel.AsyncCompletedEventArgs(invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
        }
    }

    /// <remarks/>
    [System.Web.Services.Protocols.SoapDocumentMethodAttribute("", RequestNamespace = "http://ws/", ResponseNamespace = "http://ws/", Use = System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle = System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
    [return: System.Xml.Serialization.XmlElementAttribute("return", Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public string generaCodigo([System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)] string arg0, [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)] string arg1, [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)] string arg2)
    {
        object[] results = this.Invoke("generaCodigo", new object[] {
                    arg0,
                    arg1,
                    arg2});
        return ((string)(results[0]));
    }

    /// <remarks/>
    public System.IAsyncResult BegingeneraCodigo(string arg0, string arg1, string arg2, System.AsyncCallback callback, object asyncState)
    {
        return this.BeginInvoke("generaCodigo", new object[] {
                    arg0,
                    arg1,
                    arg2}, callback, asyncState);
    }

    /// <remarks/>
    public string EndgeneraCodigo(System.IAsyncResult asyncResult)
    {
        object[] results = this.EndInvoke(asyncResult);
        return ((string)(results[0]));
    }

    /// <remarks/>
    public void generaCodigoAsync(string arg0, string arg1, string arg2)
    {
        this.generaCodigoAsync(arg0, arg1, arg2, null);
    }

    /// <remarks/>
    public void generaCodigoAsync(string arg0, string arg1, string arg2, object userState)
    {
        if ((this.generaCodigoOperationCompleted == null))
        {
            this.generaCodigoOperationCompleted = new System.Threading.SendOrPostCallback(this.OngeneraCodigoOperationCompleted);
        }
        this.InvokeAsync("generaCodigo", new object[] {
                    arg0,
                    arg1,
                    arg2}, this.generaCodigoOperationCompleted, userState);
    }

    private void OngeneraCodigoOperationCompleted(object arg)
    {
        if ((this.generaCodigoCompleted != null))
        {
            System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
            this.generaCodigoCompleted(this, new generaCodigoCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
        }
    }

    /// <remarks/>
    [System.Web.Services.Protocols.SoapDocumentMethodAttribute("", RequestNamespace = "http://ws/", ResponseNamespace = "http://ws/", Use = System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle = System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
    [return: System.Xml.Serialization.XmlElementAttribute("return", Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public string ObtieneUnaDireccion([System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)] string arg0, [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)] string arg1, [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)] string arg2)
    {
        object[] results = this.Invoke("ObtieneUnaDireccion", new object[] {
                    arg0,
                    arg1,
                    arg2});
        return ((string)(results[0]));
    }

    /// <remarks/>
    public System.IAsyncResult BeginObtieneUnaDireccion(string arg0, string arg1, string arg2, System.AsyncCallback callback, object asyncState)
    {
        return this.BeginInvoke("ObtieneUnaDireccion", new object[] {
                    arg0,
                    arg1,
                    arg2}, callback, asyncState);
    }

    /// <remarks/>
    public string EndObtieneUnaDireccion(System.IAsyncResult asyncResult)
    {
        object[] results = this.EndInvoke(asyncResult);
        return ((string)(results[0]));
    }

    /// <remarks/>
    public void ObtieneUnaDireccionAsync(string arg0, string arg1, string arg2)
    {
        this.ObtieneUnaDireccionAsync(arg0, arg1, arg2, null);
    }

    /// <remarks/>
    public void ObtieneUnaDireccionAsync(string arg0, string arg1, string arg2, object userState)
    {
        if ((this.ObtieneUnaDireccionOperationCompleted == null))
        {
            this.ObtieneUnaDireccionOperationCompleted = new System.Threading.SendOrPostCallback(this.OnObtieneUnaDireccionOperationCompleted);
        }
        this.InvokeAsync("ObtieneUnaDireccion", new object[] {
                    arg0,
                    arg1,
                    arg2}, this.ObtieneUnaDireccionOperationCompleted, userState);
    }

    private void OnObtieneUnaDireccionOperationCompleted(object arg)
    {
        if ((this.ObtieneUnaDireccionCompleted != null))
        {
            System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
            this.ObtieneUnaDireccionCompleted(this, new ObtieneUnaDireccionCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
        }
    }

    /// <remarks/>
    [System.Web.Services.Protocols.SoapDocumentMethodAttribute("", RequestNamespace = "http://ws/", ResponseNamespace = "http://ws/", Use = System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle = System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
    [return: System.Xml.Serialization.XmlElementAttribute("return", Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public vectorDireccionesEntity ObetenerDirecciones([System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)] vectorPuntosLonLatEntity arg0)
    {
        object[] results = this.Invoke("ObetenerDirecciones", new object[] {
                    arg0});
        return ((vectorDireccionesEntity)(results[0]));
    }

    /// <remarks/>
    public System.IAsyncResult BeginObetenerDirecciones(vectorPuntosLonLatEntity arg0, System.AsyncCallback callback, object asyncState)
    {
        return this.BeginInvoke("ObetenerDirecciones", new object[] {
                    arg0}, callback, asyncState);
    }

    /// <remarks/>
    public vectorDireccionesEntity EndObetenerDirecciones(System.IAsyncResult asyncResult)
    {
        object[] results = this.EndInvoke(asyncResult);
        return ((vectorDireccionesEntity)(results[0]));
    }

    /// <remarks/>
    public void ObetenerDireccionesAsync(vectorPuntosLonLatEntity arg0)
    {
        this.ObetenerDireccionesAsync(arg0, null);
    }

    /// <remarks/>
    public void ObetenerDireccionesAsync(vectorPuntosLonLatEntity arg0, object userState)
    {
        if ((this.ObetenerDireccionesOperationCompleted == null))
        {
            this.ObetenerDireccionesOperationCompleted = new System.Threading.SendOrPostCallback(this.OnObetenerDireccionesOperationCompleted);
        }
        this.InvokeAsync("ObetenerDirecciones", new object[] {
                    arg0}, this.ObetenerDireccionesOperationCompleted, userState);
    }

    private void OnObetenerDireccionesOperationCompleted(object arg)
    {
        if ((this.ObetenerDireccionesCompleted != null))
        {
            System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
            this.ObetenerDireccionesCompleted(this, new ObetenerDireccionesCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
        }
    }

    /// <remarks/>
    [System.Web.Services.Protocols.SoapDocumentMethodAttribute("", RequestNamespace = "http://ws/", ResponseNamespace = "http://ws/", Use = System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle = System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
    [return: System.Xml.Serialization.XmlElementAttribute("return", Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public imagenEntity ObetenerMapa([System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)] vectorPuntosEntity arg0, [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)] int arg1, [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)] int arg2)
    {
        object[] results = this.Invoke("ObetenerMapa", new object[] {
                    arg0,
                    arg1,
                    arg2});
        return ((imagenEntity)(results[0]));
    }

    /// <remarks/>
    public System.IAsyncResult BeginObetenerMapa(vectorPuntosEntity arg0, int arg1, int arg2, System.AsyncCallback callback, object asyncState)
    {
        return this.BeginInvoke("ObetenerMapa", new object[] {
                    arg0,
                    arg1,
                    arg2}, callback, asyncState);
    }

    /// <remarks/>
    public imagenEntity EndObetenerMapa(System.IAsyncResult asyncResult)
    {
        object[] results = this.EndInvoke(asyncResult);
        return ((imagenEntity)(results[0]));
    }

    /// <remarks/>
    public void ObetenerMapaAsync(vectorPuntosEntity arg0, int arg1, int arg2)
    {
        this.ObetenerMapaAsync(arg0, arg1, arg2, null);
    }

    /// <remarks/>
    public void ObetenerMapaAsync(vectorPuntosEntity arg0, int arg1, int arg2, object userState)
    {
        if ((this.ObetenerMapaOperationCompleted == null))
        {
            this.ObetenerMapaOperationCompleted = new System.Threading.SendOrPostCallback(this.OnObetenerMapaOperationCompleted);
        }
        this.InvokeAsync("ObetenerMapa", new object[] {
                    arg0,
                    arg1,
                    arg2}, this.ObetenerMapaOperationCompleted, userState);
    }

    private void OnObetenerMapaOperationCompleted(object arg)
    {
        if ((this.ObetenerMapaCompleted != null))
        {
            System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
            this.ObetenerMapaCompleted(this, new ObetenerMapaCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
        }
    }

    /// <remarks/>
    [System.Web.Services.Protocols.SoapDocumentMethodAttribute("", RequestNamespace = "http://ws/", ResponseNamespace = "http://ws/", Use = System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle = System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
    [return: System.Xml.Serialization.XmlElementAttribute("return", Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public imagenEntity Actualizamapaubicacion([System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)] accionEntity arg0)
    {
        object[] results = this.Invoke("Actualizamapaubicacion", new object[] {
                    arg0});
        return ((imagenEntity)(results[0]));
    }

    /// <remarks/>
    public System.IAsyncResult BeginActualizamapaubicacion(accionEntity arg0, System.AsyncCallback callback, object asyncState)
    {
        return this.BeginInvoke("Actualizamapaubicacion", new object[] {
                    arg0}, callback, asyncState);
    }

    /// <remarks/>
    public imagenEntity EndActualizamapaubicacion(System.IAsyncResult asyncResult)
    {
        object[] results = this.EndInvoke(asyncResult);
        return ((imagenEntity)(results[0]));
    }

    /// <remarks/>
    public void ActualizamapaubicacionAsync(accionEntity arg0)
    {
        this.ActualizamapaubicacionAsync(arg0, null);
    }

    /// <remarks/>
    public void ActualizamapaubicacionAsync(accionEntity arg0, object userState)
    {
        if ((this.ActualizamapaubicacionOperationCompleted == null))
        {
            this.ActualizamapaubicacionOperationCompleted = new System.Threading.SendOrPostCallback(this.OnActualizamapaubicacionOperationCompleted);
        }
        this.InvokeAsync("Actualizamapaubicacion", new object[] {
                    arg0}, this.ActualizamapaubicacionOperationCompleted, userState);
    }

    private void OnActualizamapaubicacionOperationCompleted(object arg)
    {
        if ((this.ActualizamapaubicacionCompleted != null))
        {
            System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
            this.ActualizamapaubicacionCompleted(this, new ActualizamapaubicacionCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
        }
    }

    /// <remarks/>
    [System.Web.Services.Protocols.SoapDocumentMethodAttribute("", RequestNamespace = "http://ws/", ResponseNamespace = "http://ws/", Use = System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle = System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
    [return: System.Xml.Serialization.XmlElementAttribute("return", Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public imagenEntity Actualizamapazoom([System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)] accionEntity arg0)
    {
        object[] results = this.Invoke("Actualizamapazoom", new object[] {
                    arg0});
        return ((imagenEntity)(results[0]));
    }

    /// <remarks/>
    public System.IAsyncResult BeginActualizamapazoom(accionEntity arg0, System.AsyncCallback callback, object asyncState)
    {
        return this.BeginInvoke("Actualizamapazoom", new object[] {
                    arg0}, callback, asyncState);
    }

    /// <remarks/>
    public imagenEntity EndActualizamapazoom(System.IAsyncResult asyncResult)
    {
        object[] results = this.EndInvoke(asyncResult);
        return ((imagenEntity)(results[0]));
    }

    /// <remarks/>
    public void ActualizamapazoomAsync(accionEntity arg0)
    {
        this.ActualizamapazoomAsync(arg0, null);
    }

    /// <remarks/>
    public void ActualizamapazoomAsync(accionEntity arg0, object userState)
    {
        if ((this.ActualizamapazoomOperationCompleted == null))
        {
            this.ActualizamapazoomOperationCompleted = new System.Threading.SendOrPostCallback(this.OnActualizamapazoomOperationCompleted);
        }
        this.InvokeAsync("Actualizamapazoom", new object[] {
                    arg0}, this.ActualizamapazoomOperationCompleted, userState);
    }

    private void OnActualizamapazoomOperationCompleted(object arg)
    {
        if ((this.ActualizamapazoomCompleted != null))
        {
            System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
            this.ActualizamapazoomCompleted(this, new ActualizamapazoomCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
        }
    }

    /// <remarks/>
    [System.Web.Services.Protocols.SoapDocumentMethodAttribute("", RequestNamespace = "http://ws/", ResponseNamespace = "http://ws/", Use = System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle = System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
    [return: System.Xml.Serialization.XmlElementAttribute("return", Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public imagenEntity ActualizamapazoomXY([System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)] accionEntity arg0, [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)] string arg1, [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)] string arg2)
    {
        object[] results = this.Invoke("ActualizamapazoomXY", new object[] {
                    arg0,
                    arg1,
                    arg2});
        return ((imagenEntity)(results[0]));
    }

    /// <remarks/>
    public System.IAsyncResult BeginActualizamapazoomXY(accionEntity arg0, string arg1, string arg2, System.AsyncCallback callback, object asyncState)
    {
        return this.BeginInvoke("ActualizamapazoomXY", new object[] {
                    arg0,
                    arg1,
                    arg2}, callback, asyncState);
    }

    /// <remarks/>
    public imagenEntity EndActualizamapazoomXY(System.IAsyncResult asyncResult)
    {
        object[] results = this.EndInvoke(asyncResult);
        return ((imagenEntity)(results[0]));
    }

    /// <remarks/>
    public void ActualizamapazoomXYAsync(accionEntity arg0, string arg1, string arg2)
    {
        this.ActualizamapazoomXYAsync(arg0, arg1, arg2, null);
    }

    /// <remarks/>
    public void ActualizamapazoomXYAsync(accionEntity arg0, string arg1, string arg2, object userState)
    {
        if ((this.ActualizamapazoomXYOperationCompleted == null))
        {
            this.ActualizamapazoomXYOperationCompleted = new System.Threading.SendOrPostCallback(this.OnActualizamapazoomXYOperationCompleted);
        }
        this.InvokeAsync("ActualizamapazoomXY", new object[] {
                    arg0,
                    arg1,
                    arg2}, this.ActualizamapazoomXYOperationCompleted, userState);
    }

    private void OnActualizamapazoomXYOperationCompleted(object arg)
    {
        if ((this.ActualizamapazoomXYCompleted != null))
        {
            System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
            this.ActualizamapazoomXYCompleted(this, new ActualizamapazoomXYCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
        }
    }

    /// <remarks/>
    [System.Web.Services.Protocols.SoapDocumentMethodAttribute("", RequestNamespace = "http://ws/", ResponseNamespace = "http://ws/", Use = System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle = System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
    [return: System.Xml.Serialization.XmlElementAttribute("return", Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public imagenEntity EncuadrarmapaXY([System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)] accionEntity arg0, [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)] string arg1, [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)] string arg2)
    {
        object[] results = this.Invoke("EncuadrarmapaXY", new object[] {
                    arg0,
                    arg1,
                    arg2});
        return ((imagenEntity)(results[0]));
    }

    /// <remarks/>
    public System.IAsyncResult BeginEncuadrarmapaXY(accionEntity arg0, string arg1, string arg2, System.AsyncCallback callback, object asyncState)
    {
        return this.BeginInvoke("EncuadrarmapaXY", new object[] {
                    arg0,
                    arg1,
                    arg2}, callback, asyncState);
    }

    /// <remarks/>
    public imagenEntity EndEncuadrarmapaXY(System.IAsyncResult asyncResult)
    {
        object[] results = this.EndInvoke(asyncResult);
        return ((imagenEntity)(results[0]));
    }

    /// <remarks/>
    public void EncuadrarmapaXYAsync(accionEntity arg0, string arg1, string arg2)
    {
        this.EncuadrarmapaXYAsync(arg0, arg1, arg2, null);
    }

    /// <remarks/>
    public void EncuadrarmapaXYAsync(accionEntity arg0, string arg1, string arg2, object userState)
    {
        if ((this.EncuadrarmapaXYOperationCompleted == null))
        {
            this.EncuadrarmapaXYOperationCompleted = new System.Threading.SendOrPostCallback(this.OnEncuadrarmapaXYOperationCompleted);
        }
        this.InvokeAsync("EncuadrarmapaXY", new object[] {
                    arg0,
                    arg1,
                    arg2}, this.EncuadrarmapaXYOperationCompleted, userState);
    }

    private void OnEncuadrarmapaXYOperationCompleted(object arg)
    {
        if ((this.EncuadrarmapaXYCompleted != null))
        {
            System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
            this.EncuadrarmapaXYCompleted(this, new EncuadrarmapaXYCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
        }
    }

    /// <remarks/>
    [System.Web.Services.Protocols.SoapDocumentMethodAttribute("", RequestNamespace = "http://ws/", ResponseNamespace = "http://ws/", Use = System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle = System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
    [return: System.Xml.Serialization.XmlElementAttribute("return", Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public imagenEntity EncuadrarmapaAllPoints([System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)] accionEntity arg0)
    {
        object[] results = this.Invoke("EncuadrarmapaAllPoints", new object[] {
                    arg0});
        return ((imagenEntity)(results[0]));
    }

    /// <remarks/>
    public System.IAsyncResult BeginEncuadrarmapaAllPoints(accionEntity arg0, System.AsyncCallback callback, object asyncState)
    {
        return this.BeginInvoke("EncuadrarmapaAllPoints", new object[] {
                    arg0}, callback, asyncState);
    }

    /// <remarks/>
    public imagenEntity EndEncuadrarmapaAllPoints(System.IAsyncResult asyncResult)
    {
        object[] results = this.EndInvoke(asyncResult);
        return ((imagenEntity)(results[0]));
    }

    /// <remarks/>
    public void EncuadrarmapaAllPointsAsync(accionEntity arg0)
    {
        this.EncuadrarmapaAllPointsAsync(arg0, null);
    }

    /// <remarks/>
    public void EncuadrarmapaAllPointsAsync(accionEntity arg0, object userState)
    {
        if ((this.EncuadrarmapaAllPointsOperationCompleted == null))
        {
            this.EncuadrarmapaAllPointsOperationCompleted = new System.Threading.SendOrPostCallback(this.OnEncuadrarmapaAllPointsOperationCompleted);
        }
        this.InvokeAsync("EncuadrarmapaAllPoints", new object[] {
                    arg0}, this.EncuadrarmapaAllPointsOperationCompleted, userState);
    }

    private void OnEncuadrarmapaAllPointsOperationCompleted(object arg)
    {
        if ((this.EncuadrarmapaAllPointsCompleted != null))
        {
            System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
            this.EncuadrarmapaAllPointsCompleted(this, new EncuadrarmapaAllPointsCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
        }
    }

    /// <remarks/>
    public new void CancelAsync(object userState)
    {
        base.CancelAsync(userState);
    }
}

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.42")]
[System.SerializableAttribute()]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
[System.Xml.Serialization.XmlTypeAttribute(Namespace = "http://ws/")]
public partial class vectorPuntosEntity
{
    private long idField;

    private bool idFieldSpecified;

    private puntoEntity[] vectorPuntosField;

    /// <remarks/>
    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public long id
    {
        get
        {
            return this.idField;
        }
        set
        {
            this.idField = value;
        }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlIgnoreAttribute()]
    public bool idSpecified
    {
        get
        {
            return this.idFieldSpecified;
        }
        set
        {
            this.idFieldSpecified = value;
        }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlElementAttribute("vectorPuntos", Form = System.Xml.Schema.XmlSchemaForm.Unqualified, IsNullable = true)]
    public puntoEntity[] vectorPuntos
    {
        get
        {
            return this.vectorPuntosField;
        }
        set
        {
            this.vectorPuntosField = value;
        }
    }
}

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.42")]
[System.SerializableAttribute()]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
[System.Xml.Serialization.XmlTypeAttribute(Namespace = "http://ws/")]
public partial class puntoEntity
{
    private string etiquetaField;

    private long idField;

    private bool idFieldSpecified;

    private string latitudField;

    private string longitudField;

    private string radioCirculoField;

    /// <remarks/>
    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public string etiqueta
    {
        get
        {
            return this.etiquetaField;
        }
        set
        {
            this.etiquetaField = value;
        }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public long id
    {
        get
        {
            return this.idField;
        }
        set
        {
            this.idField = value;
        }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlIgnoreAttribute()]
    public bool idSpecified
    {
        get
        {
            return this.idFieldSpecified;
        }
        set
        {
            this.idFieldSpecified = value;
        }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public string latitud
    {
        get
        {
            return this.latitudField;
        }
        set
        {
            this.latitudField = value;
        }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public string longitud
    {
        get
        {
            return this.longitudField;
        }
        set
        {
            this.longitudField = value;
        }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public string radioCirculo
    {
        get
        {
            return this.radioCirculoField;
        }
        set
        {
            this.radioCirculoField = value;
        }
    }
}

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.42")]
[System.SerializableAttribute()]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
[System.Xml.Serialization.XmlTypeAttribute(Namespace = "http://ws/")]
public partial class accionEntity
{
    private string accionField;

    private long idField;

    private bool idFieldSpecified;

    /// <remarks/>
    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public string accion
    {
        get
        {
            return this.accionField;
        }
        set
        {
            this.accionField = value;
        }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public long id
    {
        get
        {
            return this.idField;
        }
        set
        {
            this.idField = value;
        }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlIgnoreAttribute()]
    public bool idSpecified
    {
        get
        {
            return this.idFieldSpecified;
        }
        set
        {
            this.idFieldSpecified = value;
        }
    }
}

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.42")]
[System.SerializableAttribute()]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
[System.Xml.Serialization.XmlTypeAttribute(Namespace = "http://ws/")]
public partial class imagenEntity
{
    private string errorMensajeField;

    private long idField;

    private bool idFieldSpecified;

    private byte[] imagenField;

    /// <remarks/>
    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public string errorMensaje
    {
        get
        {
            return this.errorMensajeField;
        }
        set
        {
            this.errorMensajeField = value;
        }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public long id
    {
        get
        {
            return this.idField;
        }
        set
        {
            this.idField = value;
        }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlIgnoreAttribute()]
    public bool idSpecified
    {
        get
        {
            return this.idFieldSpecified;
        }
        set
        {
            this.idFieldSpecified = value;
        }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified, DataType = "base64Binary")]
    public byte[] imagen
    {
        get
        {
            return this.imagenField;
        }
        set
        {
            this.imagenField = value;
        }
    }
}

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.42")]
[System.SerializableAttribute()]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
[System.Xml.Serialization.XmlTypeAttribute(Namespace = "http://ws/")]
public partial class direccionEntity
{
    private string direccionField;

    private long idField;

    private bool idFieldSpecified;

    private string ptnField;

    /// <remarks/>
    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public string direccion
    {
        get
        {
            return this.direccionField;
        }
        set
        {
            this.direccionField = value;
        }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public long id
    {
        get
        {
            return this.idField;
        }
        set
        {
            this.idField = value;
        }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlIgnoreAttribute()]
    public bool idSpecified
    {
        get
        {
            return this.idFieldSpecified;
        }
        set
        {
            this.idFieldSpecified = value;
        }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public string ptn
    {
        get
        {
            return this.ptnField;
        }
        set
        {
            this.ptnField = value;
        }
    }
}

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.42")]
[System.SerializableAttribute()]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
[System.Xml.Serialization.XmlTypeAttribute(Namespace = "http://ws/")]
public partial class vectorDireccionesEntity
{
    private long idField;

    private bool idFieldSpecified;

    private direccionEntity[] vectorDireccionesField;

    /// <remarks/>
    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public long id
    {
        get
        {
            return this.idField;
        }
        set
        {
            this.idField = value;
        }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlIgnoreAttribute()]
    public bool idSpecified
    {
        get
        {
            return this.idFieldSpecified;
        }
        set
        {
            this.idFieldSpecified = value;
        }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlElementAttribute("vectorDirecciones", Form = System.Xml.Schema.XmlSchemaForm.Unqualified, IsNullable = true)]
    public direccionEntity[] vectorDirecciones
    {
        get
        {
            return this.vectorDireccionesField;
        }
        set
        {
            this.vectorDireccionesField = value;
        }
    }
}

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.42")]
[System.SerializableAttribute()]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
[System.Xml.Serialization.XmlTypeAttribute(Namespace = "http://ws/")]
public partial class puntoLonLatEntity
{
    private long idField;

    private bool idFieldSpecified;

    private string latitudField;

    private string longitudField;

    private string ptnField;

    /// <remarks/>
    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public long id
    {
        get
        {
            return this.idField;
        }
        set
        {
            this.idField = value;
        }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlIgnoreAttribute()]
    public bool idSpecified
    {
        get
        {
            return this.idFieldSpecified;
        }
        set
        {
            this.idFieldSpecified = value;
        }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public string latitud
    {
        get
        {
            return this.latitudField;
        }
        set
        {
            this.latitudField = value;
        }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public string longitud
    {
        get
        {
            return this.longitudField;
        }
        set
        {
            this.longitudField = value;
        }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public string ptn
    {
        get
        {
            return this.ptnField;
        }
        set
        {
            this.ptnField = value;
        }
    }
}

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.42")]
[System.SerializableAttribute()]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
[System.Xml.Serialization.XmlTypeAttribute(Namespace = "http://ws/")]
public partial class vectorPuntosLonLatEntity
{
    private long idField;

    private bool idFieldSpecified;

    private puntoLonLatEntity[] vectorPuntosLonLatField;

    /// <remarks/>
    [System.Xml.Serialization.XmlElementAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
    public long id
    {
        get
        {
            return this.idField;
        }
        set
        {
            this.idField = value;
        }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlIgnoreAttribute()]
    public bool idSpecified
    {
        get
        {
            return this.idFieldSpecified;
        }
        set
        {
            this.idFieldSpecified = value;
        }
    }

    /// <remarks/>
    [System.Xml.Serialization.XmlElementAttribute("vectorPuntosLonLat", Form = System.Xml.Schema.XmlSchemaForm.Unqualified, IsNullable = true)]
    public puntoLonLatEntity[] vectorPuntosLonLat
    {
        get
        {
            return this.vectorPuntosLonLatField;
        }
        set
        {
            this.vectorPuntosLonLatField = value;
        }
    }
}

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.42")]
public delegate void GenerarMapaFileCompletedEventHandler(object sender, System.ComponentModel.AsyncCompletedEventArgs e);

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.42")]
public delegate void generaCodigoCompletedEventHandler(object sender, generaCodigoCompletedEventArgs e);

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.42")]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
public partial class generaCodigoCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs
{
    private object[] results;

    internal generaCodigoCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState)
        :
            base(exception, cancelled, userState)
    {
        this.results = results;
    }

    /// <remarks/>
    public string Result
    {
        get
        {
            this.RaiseExceptionIfNecessary();
            return ((string)(this.results[0]));
        }
    }
}

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.42")]
public delegate void ObtieneUnaDireccionCompletedEventHandler(object sender, ObtieneUnaDireccionCompletedEventArgs e);

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.42")]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
public partial class ObtieneUnaDireccionCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs
{
    private object[] results;

    internal ObtieneUnaDireccionCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState)
        :
            base(exception, cancelled, userState)
    {
        this.results = results;
    }

    /// <remarks/>
    public string Result
    {
        get
        {
            this.RaiseExceptionIfNecessary();
            return ((string)(this.results[0]));
        }
    }
}

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.42")]
public delegate void ObetenerDireccionesCompletedEventHandler(object sender, ObetenerDireccionesCompletedEventArgs e);

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.42")]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
public partial class ObetenerDireccionesCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs
{
    private object[] results;

    internal ObetenerDireccionesCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState)
        :
            base(exception, cancelled, userState)
    {
        this.results = results;
    }

    /// <remarks/>
    public vectorDireccionesEntity Result
    {
        get
        {
            this.RaiseExceptionIfNecessary();
            return ((vectorDireccionesEntity)(this.results[0]));
        }
    }
}

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.42")]
public delegate void ObetenerMapaCompletedEventHandler(object sender, ObetenerMapaCompletedEventArgs e);

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.42")]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
public partial class ObetenerMapaCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs
{
    private object[] results;

    internal ObetenerMapaCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState)
        :
            base(exception, cancelled, userState)
    {
        this.results = results;
    }

    /// <remarks/>
    public imagenEntity Result
    {
        get
        {
            this.RaiseExceptionIfNecessary();
            return ((imagenEntity)(this.results[0]));
        }
    }
}

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.42")]
public delegate void ActualizamapaubicacionCompletedEventHandler(object sender, ActualizamapaubicacionCompletedEventArgs e);

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.42")]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
public partial class ActualizamapaubicacionCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs
{
    private object[] results;

    internal ActualizamapaubicacionCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState)
        :
            base(exception, cancelled, userState)
    {
        this.results = results;
    }

    /// <remarks/>
    public imagenEntity Result
    {
        get
        {
            this.RaiseExceptionIfNecessary();
            return ((imagenEntity)(this.results[0]));
        }
    }
}

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.42")]
public delegate void ActualizamapazoomCompletedEventHandler(object sender, ActualizamapazoomCompletedEventArgs e);

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.42")]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
public partial class ActualizamapazoomCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs
{
    private object[] results;

    internal ActualizamapazoomCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState)
        :
            base(exception, cancelled, userState)
    {
        this.results = results;
    }

    /// <remarks/>
    public imagenEntity Result
    {
        get
        {
            this.RaiseExceptionIfNecessary();
            return ((imagenEntity)(this.results[0]));
        }
    }
}

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.42")]
public delegate void ActualizamapazoomXYCompletedEventHandler(object sender, ActualizamapazoomXYCompletedEventArgs e);

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.42")]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
public partial class ActualizamapazoomXYCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs
{
    private object[] results;

    internal ActualizamapazoomXYCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState)
        :
            base(exception, cancelled, userState)
    {
        this.results = results;
    }

    /// <remarks/>
    public imagenEntity Result
    {
        get
        {
            this.RaiseExceptionIfNecessary();
            return ((imagenEntity)(this.results[0]));
        }
    }
}

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.42")]
public delegate void EncuadrarmapaXYCompletedEventHandler(object sender, EncuadrarmapaXYCompletedEventArgs e);

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.42")]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
public partial class EncuadrarmapaXYCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs
{
    private object[] results;

    internal EncuadrarmapaXYCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState)
        :
            base(exception, cancelled, userState)
    {
        this.results = results;
    }

    /// <remarks/>
    public imagenEntity Result
    {
        get
        {
            this.RaiseExceptionIfNecessary();
            return ((imagenEntity)(this.results[0]));
        }
    }
}

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.42")]
public delegate void EncuadrarmapaAllPointsCompletedEventHandler(object sender, EncuadrarmapaAllPointsCompletedEventArgs e);

/// <remarks/>
[System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "2.0.50727.42")]
[System.Diagnostics.DebuggerStepThroughAttribute()]
[System.ComponentModel.DesignerCategoryAttribute("code")]
public partial class EncuadrarmapaAllPointsCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs
{
    private object[] results;

    internal EncuadrarmapaAllPointsCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState)
        :
            base(exception, cancelled, userState)
    {
        this.results = results;
    }

    /// <remarks/>
    public imagenEntity Result
    {
        get
        {
            this.RaiseExceptionIfNecessary();
            return ((imagenEntity)(this.results[0]));
        }
    }
}