using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Model
{
    public class Enumerados
    {
        public enum CodigoConfiguracion
        {
            MOD,
            FUN,
            COF
        }

        public enum FlagPermisoPerfil
        {
            CREAR,
            VER,
            EDITAR,
            ELIMINAR
        }

        public enum FlagHabilitado
        { 
            T,
            F
        }

        public enum DiaSemana
        {
            Lun = -64,
            Mar = -32,
            Mie = -16,
            Jue = -8,
            Vie = -4,
            Sab = -2,
            Dom = -1
        }
   
    }
}
