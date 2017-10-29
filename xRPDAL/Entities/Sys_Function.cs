using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace xRPDAL
{
    public partial class Sys_Function : IDbTable
    {
        public DateTime ModifiedOn { get; set; }
        //phamkhuong102
        public bool Selected { get; set; }
        public int? RoleFunctionId { get; set; }
        //End
    }
}
