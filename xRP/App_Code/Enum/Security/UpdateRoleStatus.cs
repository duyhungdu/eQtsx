using System;
using System.Collections.Generic;
using System.Web;

namespace xRP.Security
{
    public class UpdateRoleStatus
    {
        public bool IsSuccess { get; set; }
        public bool IsDuplicateName { get; set; }
        public bool IsDuplicateCode { get; set; }

    }
}