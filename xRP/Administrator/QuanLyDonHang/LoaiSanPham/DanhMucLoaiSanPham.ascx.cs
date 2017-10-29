using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPRepository;

namespace xRP.Administrator.QuanLyDonHang.LoaiSanPham
{
    public partial class DanhMucLoaiSanPham : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Binddata();
        }
        public void Binddata()
        {
            Qldh_LoaiSanPhamRepostity loaisanphamReposity = new Qldh_LoaiSanPhamRepostity();
            var listLoaiSanPham = loaisanphamReposity.GetLoaiSanPham(0, null, 0, null,"");
            colPage.MaxPages = 10000;
            colPage.PageSize = 10;
            colPage.DataSource = listLoaiSanPham;
            colPage.BindToControl = rptDanhMucHeSoTongGiao;
            rptDanhMucHeSoTongGiao.DataSource = colPage.DataSourcePaged;
            rptDanhMucHeSoTongGiao.DataBind();
        }
    }
}