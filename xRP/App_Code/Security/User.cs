using System;
using System.Collections.Generic;
//using System.Linq;
using System.Web;

namespace xRP.Security
{
    public class User
    {
        public int ID { get; set; }
        public string UserName { get; set; }
        public string Email { get; set; }

        public bool IsApproved { get; set; }

        public bool IsLockedOut { get; set; }
        public bool IsOnline { get; set; }

    }
}