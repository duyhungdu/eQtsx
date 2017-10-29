using System;
using System.Collections.Generic;
using System.Linq;
using xRPDAL;
using xRPRepository;
using xRPUtil;
using System.Web;

/// <summary>
/// Summary description for GroupPermissionViewModel
/// </summary>
public class UserGroupViewModel
{
    public Sys_DanhMucNhom Group { get; set; }
    public bool IsChecked { get; set; }

}