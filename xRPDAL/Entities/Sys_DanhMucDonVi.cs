using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


namespace xRPDAL
{
    public partial class Sys_DanhMucDonVi : IDbTable
    {
        public DateTime ModifiedOn { get; set; }

        public List<Sys_DanhMucDonVi> Childs { get; set; }
    }
    
}
