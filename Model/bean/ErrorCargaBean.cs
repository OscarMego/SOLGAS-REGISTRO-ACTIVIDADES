using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model.bean
{
 public   class ErrorCargaBean
    {

        public ErrorCargaBean()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public ErrorCargaBean(int _id, string _descripcionError)
        {
            id = _id;
            descripcionError = _descripcionError;
        }

        public int id;
        public string descripcionError;

        public int Id
        {
            get { return id; }
            set { id = value; }
        }

        public string DescripcionError
        {
            get { return descripcionError; }
            set { descripcionError = value; }
        }
    }
}
