using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.bean
{
    public class GraficoBean
    {
        public String Titulo { get; set; }
        public String SubTitulo { get; set; }
        public List<GraficoItemBean> items { get; set; }
        public List<GraficoItemBean> grupo { get; set; }
        public List<GraficoItem2Bean> itemsArr { get; set; }
        public String[] categorias { get; set; }
    }
    public class GraficoItemBean
    {
        public String[] categorias { get; set; }
        public String id { get; set; }
        public String drilldown { get; set; }
        public String name { get; set; }
        public decimal y { get; set; }
        public List<GraficoItemBean> data { get; set; }
        public List<GraficoItem2Bean> dataArr { get; set; }
    }
    public class GraficoItem2Bean
    {
        public String[] categorias { get; set; }
        public String id { get; set; }
        public String drilldown { get; set; }
        public String name { get; set; }
        public decimal[] data { get; set; }
        public decimal y { get; set; }
    }
}
