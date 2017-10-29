using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace xRPDAL
{
    public partial class Sys_Quyen : IDbTable
    {
        public DateTime ModifiedOn { get; set; }
        public bool IsGrant { get; set; }

    }
}
