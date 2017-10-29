using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPRepository;

namespace xRP.Administrator.QuanLyDonHang.HeSoTongGiao
{
    public partial class DanhMucHeSoTongGiao : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Binddata();
        }
        public void Binddata()
        {
            Qldh_HeSoTongGiaoReposity hesotonggiaoReposity = new Qldh_HeSoTongGiaoReposity();
            var lstHeSoTongGiao = hesotonggiaoReposity.GetHeSoTongGiao(0, 0, 0, null,"");
            colPage.MaxPages = 10000;
            colPage.PageSize = 10; // số items hiển thị trên một trang.
            colPage.DataSource = lstHeSoTongGiao;
            colPage.BindToControl = rptDanhMucHeSoTongGiao;
            rptDanhMucHeSoTongGiao.DataSource = colPage.DataSourcePaged;
            rptDanhMucHeSoTongGiao.DataBind();
        }
    }
}