using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace xRP
{
    public partial class PageBase : System.Web.UI.Page
    {
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (!IsPostBack)//Comment lại để vào chức năng phân quyền sau đó bỏ conment để test
            {
                var url = HttpContext.Current.Request.RawUrl.Trim('?');
                switch (xRP.Security.Permission.CheckRedirect(url))
                {
                    case xRP.Security.Permission.FunctionRedirect.login:
                        Response.Redirect("/Account/Login.aspx");
                        break;
                    case xRP.Security.Permission.FunctionRedirect.role:
                        Response.Redirect("/404.htm");
                        break;
                    case xRP.Security.Permission.FunctionRedirect.func:
                        Response.Redirect("/Error.htm");
                        break;
                    case xRP.Security.Permission.FunctionRedirect.success: break;
                }
            }
        }
    }
}