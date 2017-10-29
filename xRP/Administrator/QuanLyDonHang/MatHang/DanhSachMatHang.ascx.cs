using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;

namespace xRP.Administrator.QuanLyDonHang.MatHang
{
    public partial class DanhSachMatHang : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtTimKiem.Focus();
            if (!IsPostBack)
            {
                Binddata("");
            }
        }
        public void Binddata(string key)
        {
            xRPDataContext dataContext = new xRPDataContext();
            List<Sp_Qldh_MatHang_Select_1Result> listLoaiSanPham = new List<Sp_Qldh_MatHang_Select_1Result>();
            if (!string.IsNullOrEmpty(key))
            {
                listLoaiSanPham = dataContext.Sp_Qldh_MatHang_Select_1(key).ToList();
            }
            else
            {
                listLoaiSanPham = dataContext.Sp_Qldh_MatHang_Select_1(null).ToList();

            }
            colPage.MaxPages = 10000;
            colPage.PageSize = 10;
            colPage.DataSource = listLoaiSanPham;
            colPage.BindToControl = rptDanhMucHeSoTongGiao;
            rptDanhMucHeSoTongGiao.DataSource = colPage.DataSourcePaged;
            rptDanhMucHeSoTongGiao.DataBind();
        }
        protected void btnSeach_Click(object sender, EventArgs e)
        {
            Binddata(txtTimKiem.Text);
        }
    }
}