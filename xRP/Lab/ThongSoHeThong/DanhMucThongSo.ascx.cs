using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;

namespace xRP.Lab.ThongSoHeThong
{
    public partial class DanhMucThongSo : System.Web.UI.UserControl
    {
        public string CountItem = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData();
            }
        }
        protected void BindData()
        {
            List<xRPDAL.Sys_ThongSoHeThong> danhMucThongSo = new xRPDataContext().Sys_ThongSoHeThongs.ToList();
           
            colPage.PageSize = 10;
            colPage.DataSource = danhMucThongSo;
            colPage.BindToControl = rptThongSoHeThong;
            rptThongSoHeThong.DataSource = colPage.DataSourcePaged;
            rptThongSoHeThong.DataBind();
        }

        protected void ltrRefresh_Click(object sender, EventArgs e)
        {

        }
    }
}