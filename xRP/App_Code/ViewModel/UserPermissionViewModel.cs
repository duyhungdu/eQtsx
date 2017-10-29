using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using xRPDAL;
using xRPRepository;
using xRPUtil;
using xRP.Security;

public class UserPermissionViewModel
{
    public Role Role { get; set; }
    public bool IsAssigned { get; set; }
    public bool IsGrant { get; set; }
    public bool IsDeny { get; set; }
    public bool IsInherit { get; set; }
    public bool IsOverride { get; set; }
    public bool IsOrphan { get; set; }

}