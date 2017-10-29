using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;

namespace xRP.Business.QuanLySanXuat.YeuCauVatTu
{
    public partial class DanhSachVatTu : System.Web.UI.UserControl
    {
        protected int status = -1;
        public static string[] TinhTrangPhieu = { "Chưa duyệt", "Đã duyệt" };
        protected void Page_Load(object sender, EventArgs e)
        {
            var dts = new xRPDataContext();
            BindGrid();
        }

        private void BindGrid()
        {
            var dts = new xRPDataContext();
            var x = dts.Sp_Qlvt_VatTu_Select(0, null, null, null, null).ToList();
            colPage.DataSource = x;
            colPage.BindToControl = rptDanhMucLoaiVatTu;
            rptDanhMucLoaiVatTu.DataSource = colPage.DataSourcePaged;
        }

        protected void ddlTinhTrang_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!int.TryParse(ddlTinhTrang.SelectedValue, out status))
            {
                this.status = -1;
            }
            BindGrid();
        }

        protected void btnSeach_Click(object sender, EventArgs e)
        {
            BindGrid();
        }
    }
}