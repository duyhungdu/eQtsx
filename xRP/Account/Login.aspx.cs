using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;

namespace xRP.Account
{
    public partial class Login : System.Web.UI.Page
    {
        xRPDataContext dataContext = new xRPDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            Sys_ThongSoHeThong thongsohethong = (from ds in dataContext.Sys_ThongSoHeThongs where ds.ThongSo == "APPNAME" select ds).FirstOrDefault();
            if (thongsohethong != null)
            {
                ltName.Text = thongsohethong.GiaTri;
            }
            else
            {
                ltName.Text = "HỆ THỐNG XRP";
            }
            if (Request.Cookies["xrp_username"] != null)
            {
                txtEmail.Text = Request.Cookies["xrp_username"].Value;
                txtPassword.Focus();
            }
            else
            {
                txtEmail.Focus();
            }

        }

        protected void idSIButton9_Click(object sender, EventArgs e)
        {
            if (Membership.ValidateUser(txtEmail.Text, txtPassword.Text))
            {
                FormsAuthentication.SetAuthCookie(txtEmail.Text, chkRememberMe.Checked);

                HttpCookie username = new HttpCookie("xrp_username", txtEmail.Text);
                username.Expires.AddYears(10);
                Response.Cookies.Add(username);

                Page.Response.Redirect("~/");
            }
            else
            {
                Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "abc", "<script>alert('Sai tên đăng nhập hoặc mật khẩu. Vui lòng thử lại.');</script>");
                txtPassword.Focus();
                return;
            }
        }
    }
}