using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace xRP.Security
{
    public class CreateRoleStatus
    {
        public bool IsSuccess { get; set; }
        public bool IsDuplicateName { get; set; }
        public bool IsDuplicateCode { get; set; }

    }
}