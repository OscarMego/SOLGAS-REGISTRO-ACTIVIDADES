using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Script.Serialization;

namespace Controller.functions
{
    public class JSONUtils
    {
        public static String serializeToJSON(Object obj)
        {   JavaScriptSerializer js = new JavaScriptSerializer();
            try
            {
                return js.Serialize(obj);
            }
            catch (Exception e) {
                return "";
            }
        }

    }
}
