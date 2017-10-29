using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace xRP
{
    public class DepartmentTreeNode
    {
        public int Level { get; set; }
        public int PositionID { get; set; }
        public string Name { get; set; }
        public bool IsChecked { get; set; }
        public int ID { get; set; }
    }
}