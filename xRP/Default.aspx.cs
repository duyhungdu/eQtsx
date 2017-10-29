using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
namespace xRP
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["page"] == null)
            {
                LoadControl();
            }
            else
            {
                LoadVersionInfo();
            }
        }
        protected void LoadVersionInfo()
        {
            Business.Home.VersionInfo version = (Business.Home.VersionInfo)this.Page.LoadControl("~/Business/Home/VersionInfo.ascx");
            plcContent.Controls.Add(version);
        }
        protected void LoadControl()
        {
            Business.Home.MainBox mainBox = (Business.Home.MainBox)this.Page.LoadControl("~/Business/Home/MainBox.ascx");
            plcContent.Controls.Add(mainBox);
        }
        [WebMethod]
        public static string AddControl(string url, string param)
        {
            string content = "";
            Page pg = new Page();
            UserControl uc = (UserControl)pg.LoadControl("~/" + url);
            uc.Attributes.Add("param", param);
            HtmlForm form = new HtmlForm();
            form.Controls.Add(uc);
            pg.Controls.Add(form);
            StringWriter sw = new StringWriter();
            HttpContext.Current.Server.Execute(pg, sw, true);
            content = sw.ToString();
            return content;
        }
    }
}