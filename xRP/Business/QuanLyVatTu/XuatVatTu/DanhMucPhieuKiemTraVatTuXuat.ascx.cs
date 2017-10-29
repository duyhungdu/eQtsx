using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;

namespace xRP.Business.QuanLyVatTu.XuatVatTu
{
    public partial class DanhMucPhieuKiemTraVatTuXuat : System.Web.UI.UserControl
    {
        protected int status = -1;
        public static string[] TinhTrangPhieu = { "Chưa duyệt", "Đã duyệt" };
        protected void Page_Load(object sender, EventArgs e)
        {
            var dts = new xRPDataContext();
            datepicker1.Value = DateTime.Now.ToString("dd/MM/yyyy");
            datepicker.Value = DateTime.Now.AddMonths(-1).ToString("dd/MM/yyyy");
            BindGrid();
        }

        private void BindGrid()
        {
            var dts = new xRPDataContext();
            int status = int.Parse(ddlTinhTrang.SelectedValue);
            if (searchbox.Value.Trim() == "")
            {
                DateTime dt1 = DateTime.MinValue, dt2 = DateTime.Now;
                if (!DateTime.TryParseExact(datepicker.Value, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out dt1))
                {
                    datepicker.Value = DateTime.Now.AddMonths(-1).ToString("dd/MM/yyyy");
                }
                if (!DateTime.TryParseExact(datepicker1.Value, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out dt2))
                {
                    dt2 = DateTime.Now;
                }
                var x = dts.Sp_Qlvt_PhieuXuat_Select((int)EnumPhieuXuat.SelectType.All, null, 1, 0, status == -1 ? (int?)null : status, dt1, dt2, "", null).ToList();
                colPage.DataSource = x;
                colPage.BindToControl = rptDanhMucLoaiVatTu;
                rptDanhMucLoaiVatTu.DataSource = colPage.DataSourcePaged;
            }
            else
            {
                DateTime dt1 = DateTime.MinValue, dt2 = DateTime.Now;
                if (!DateTime.TryParseExact(datepicker.Value, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out dt1))
                {
                    datepicker.Value = DateTime.Now.AddMonths(-1).ToString("dd/MM/yyyy");
                }
                if (!DateTime.TryParseExact(datepicker1.Value, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out dt2))
                {
                    dt2 = DateTime.Now;
                }

                var x = dts.Sp_Qlvt_PhieuXuat_Select((int)EnumPhieuXuat.SelectType.Search, 1, (int?)null, 0, status == -1 ? (int?)null : status, dt1, dt2, searchbox.Value.Trim(), " NgayXuat DESC").ToList();
                colPage.DataSource = x;
                colPage.BindToControl = rptDanhMucLoaiVatTu;
                rptDanhMucLoaiVatTu.DataSource = colPage.DataSourcePaged;
            }
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

        protected void rptDanhMucLoaiVatTu_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            Literal ltEdit = (Literal)e.Item.FindControl("ltEdit");
            Literal ltView = (Literal)e.Item.FindControl("ltView");
            Literal ltDelete = (Literal)e.Item.FindControl("ltDelete");
            Literal ltPrint = (Literal)e.Item.FindControl("ltPrint");
            Literal ltAccept = (Literal)e.Item.FindControl("ltAccept");
            //sp_qlvt_phi
            Sp_Qlvt_PhieuXuat_SelectResult result = (Sp_Qlvt_PhieuXuat_SelectResult)e.Item.DataItem;
            ltPrint.Text = "<li class=\"menu-item\"><a title=\"In\" href=\"../../Business/QuanLyVatTu/Default.aspx?page=ppx&id=" + result.ID + "\"><span class=\"icon icon-printer\"></span><span class=\"text\">In</span></a></li>";
            if (result.TINHTRANG.Value != 1)
            {
                ltEdit.Text = "<li class=\"menu-item\"><a title=\"Sửa\" href=\"/Business/QuanLyVatTu/Default.aspx?page=aoepktx&id=" + result.ID + "\"><span class=\"icon edit-icon\"></span><span class=\"text\">Sửa</span></a></li>";
                ltDelete.Text = "<li class=\"menu-item\"><a title=\"Xóa\" href=\"javascript:deletePhieuXuat(" + result.ID + ");\"><span class=\"icon delete-icon\"></span><span class=\"text\">Xóa</span></a></li>";
                ltAccept.Text = "<li class=\"menu-item\"><a title=\"Duyệt\" href=\"javascript:duyetPhieuXuat('" + result.ID + "');\"><span class=\"icon accept-icon\"></span><span class=\"text\">Duyệt</span></a></li>";
            } else {
                ltEdit.Text = "<li class=\"menu-item\"><a title=\"Sửa\" href=\"/Business/QuanLyVatTu/Default.aspx?page=vdktx&id=" + result.ID + "\"><span class=\"icon edit-icon\"></span><span class=\"text\">Xem phiếu</span></a></li>";
            }
        }
    }
}