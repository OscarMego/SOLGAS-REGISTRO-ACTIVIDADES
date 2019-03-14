using System;
using System.Collections.Generic;
using System.Text;

namespace Model.bean
{
    public class FotoBean
    {


        public Byte[] foto { get; set; }
        public String titulo { get; set; }
        public String idFoto { get; set; }
        


        public FotoBean()
        {
            titulo = "";
        }

    }
}
