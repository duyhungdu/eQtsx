using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace xRPDAL
{
    public partial class Sys_CanBo : IDbTable
    {
        public DateTime ModifiedOn { get; set; }
        public string ChucVu { get; set; }
        public List<Sys_DanhMucDonVi> Departments { get; set; }
    }
}
