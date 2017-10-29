using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPRepository;

namespace xRP.Administrator.QuanLyDonHang.KhachHang
{
    public partial class DanhMucKhachHang : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtTimKiem.Focus();
            if (!IsPostBack)
            {
                Binddata("");
            }
        }
        public void Binddata(string keyword)
        {

            Qldh_KhachHangReposity khachhangReposity = new Qldh_KhachHangReposity();
            if (string.IsNullOrEmpty(keyword))
            {
                var lstKhachHang = khachhangReposity.GetDanhSachKhachHang(0, 0, 0, null, keyword);
                colPage.MaxPages = 10000;
                colPage.PageSize = 10; // số items hiển thị trên một trang.
                colPage.DataSource = lstKhachHang;
                colPage.BindToControl = rptDanhMucHeSoTongGiao;
                rptDanhMucHeSoTongGiao.DataSource = colPage.DataSourcePaged;
                rptDanhMucHeSoTongGiao.DataBind();
            }
            else
            {
                var lstKhachHang = khachhangReposity.GetDanhSachKhachHang(-1, 0, 0, null, keyword);
                colPage.MaxPages = 10000;
                colPage.PageSize = 10; // số items hiển thị trên một trang.
                colPage.DataSource = lstKhachHang;
                colPage.BindToControl = rptDanhMucHeSoTongGiao;
                rptDanhMucHeSoTongGiao.DataSource = colPage.DataSourcePaged;
                rptDanhMucHeSoTongGiao.DataBind();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Binddata(txtTimKiem.Text);
        }
    }
}