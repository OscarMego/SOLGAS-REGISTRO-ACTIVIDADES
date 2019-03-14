using Model.functions;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace Model
{
    public class CorreoModel
    {
        public static DataTable SelConfiguracionCorreo()
        {
            ArrayList alParameters = new ArrayList();

            return SqlConnector.getDataTable("spS_SelConfiguracionCorreo", alParameters);

        }

    }
}
