using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace xRPDAL
{
    public partial class Sys_UserLog : IDbTable
    {
        public DateTime ModifiedOn { get; set; }
    }
}
