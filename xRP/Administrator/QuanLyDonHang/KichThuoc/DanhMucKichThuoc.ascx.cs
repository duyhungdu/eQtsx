using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPRepository;

namespace xRP.Administrator.QuanLyDonHang.KichThuoc
{
    public partial class DanhMucKichThuoc : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Binddata();
        }
        public void Binddata()
        {
            Qldh_KichThuocReposity kichthuocReposity = new Qldh_KichThuocReposity();
            var lstKichThuoc = kichthuocReposity.GetLoaiKichThuoc(0, null, 0, null,"");
            colPage.MaxPages = 10000;
            colPage.PageSize = 10; // số items hiển thị trên một trang.
            colPage.DataSource = lstKichThuoc;
            colPage.BindToControl = rptDanhMucKichThuoc;
            rptDanhMucKichThuoc.DataSource = colPage.DataSourcePaged;
            rptDanhMucKichThuoc.DataBind();
        }
    }
}