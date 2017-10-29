using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;


namespace xRP
{
    public partial class MasterBase : System.Web.UI.MasterPage
    {

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

            if (!IsPostBack)// Đang xuy nghĩ nên hay không bắt tại masterpage?? tạm thời đóng
            {
                var url = HttpContext.Current.Request.RawUrl.Trim('?');
                if (!string.IsNullOrEmpty(url) && url != "/")
                {
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
}
