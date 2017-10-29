using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;
using xRPRepository;

namespace xRP.Administrator.QuanLyDonHang.NhomKhachHang
{
    public partial class DanhMucNhomKhachHang : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Bindata();
        }
        public void Bindata()
        {
            Qldh_NhomKhachHangReposity nhomkhachhangreposity = new Qldh_NhomKhachHangReposity();
            var listNhomKhachHang = nhomkhachhangreposity.GetNhomKhachHang(0, null, 0, null,"");
            colPage.MaxPages = 10000;
            colPage.PageSize = 10; // số items hiển thị trên một trang.
            colPage.DataSource = listNhomKhachHang;
            colPage.BindToControl = rptDanhMucNhomKhachHang;
            rptDanhMucNhomKhachHang.DataSource = colPage.DataSourcePaged;
            rptDanhMucNhomKhachHang.DataBind();
        }
    }
}