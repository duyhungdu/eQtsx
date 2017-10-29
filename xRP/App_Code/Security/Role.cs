using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace xRP.Security
{
    public class Role
    {
        public string Name { get; set; }
        public Guid ID { get; set; }
        public bool IsGrant { get; set; }
        public string Code { get; set; }
        public string Description { get; set; }
        
    }
}