using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;

namespace xRP.Business.QuanLyVatTu.NhapThanhPham
{
    public partial class DanhSachNhapThanhPham : System.Web.UI.UserControl
    {

        //protected int status = -1;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                datepicker1.Value = DateTime.Now.ToString("dd/MM/yyyy");
                datepicker.Value = DateTime.Now.AddMonths(-1).ToString("dd/MM/yyyy");
                BindGrid();
            }
        }

        private void BindGrid()
        {
            var dts = new xRPDataContext();
            var status = int.Parse(ddlTinhTrang.SelectedValue);
            if (searchbox.Value.Trim() == "")
            {
                DateTime dateFrom = DateTime.MinValue, dateTo = DateTime.Now;
                if (!DateTime.TryParseExact(datepicker.Value, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out dateFrom))
                {
                    dateFrom = DateTime.Now.AddMonths(-1);
                }
                if (!DateTime.TryParseExact(datepicker1.Value, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out dateTo))
                {
                    dateTo = DateTime.Now;
                }

                var x = dts.Sp_Qlvt_PhieuNhap_Select((int)EnumPhieuNhap.SelectTypes.All,
                    (int?)null, 0, (int?)null, (int?)null, null, (int?)null,
                    (int)(int)EnumPhieuNhap.KieuVatTu.NhapThanhPham, status < 0 || status > 2 ? (int?)null : status, dateFrom.AddDays(-1), dateTo.AddDays(1), null, " NgayTao DESC").ToList();
                colPage.DataSource = x;
                colPage.BindToControl = rptDanhMucLoaiVatTu;
                rptDanhMucLoaiVatTu.DataSource = colPage.DataSourcePaged;
                Sp_Qlvt_PhieuNhap_SelectResult ru = new Sp_Qlvt_PhieuNhap_SelectResult();
            }
            else
            {

                DateTime dateFrom = DateTime.MinValue, dateTo = DateTime.Now;
                if (!DateTime.TryParseExact(datepicker.Value, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out dateFrom))
                {
                    dateFrom = DateTime.Now.AddMonths(-1);
                }
                if (!DateTime.TryParseExact(datepicker1.Value, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out dateTo))
                {
                    dateTo = DateTime.Now;
                }

                var type = string.IsNullOrEmpty(searchbox.Value) == true ? (int)EnumPhieuNhap.SelectTypes.All : (int)EnumPhieuNhap.SelectTypes.Seach;
                var x = dts.Sp_Qlvt_PhieuNhap_Select(type,
                    (int?)null, 0, (int?)null, (int?)null, null, (int?)null,
                    (int)(int)EnumPhieuNhap.KieuVatTu.NhapThanhPham, status < 0 || status > 2 ? (int?)null : status, dateFrom.AddDays(-1), dateTo.AddDays(1), searchbox.Value.Trim(), " NgayTao DESC").ToList();
                colPage.DataSource = x;
                colPage.BindToControl = rptDanhMucLoaiVatTu;
                rptDanhMucLoaiVatTu.DataSource = colPage.DataSourcePaged;
            }
        }
        public string ConvertStatus(object status)
        {
            if (status == null) return "Chưa duyệt";
            string tinhTrang = "";
            switch (int.Parse(status.ToString()))
            {
                case 0:
                    tinhTrang = "Chưa duyệt";
                    break;
                case 1:
                    tinhTrang = "Đã duyệt";
                    break;
                case 2:
                    tinhTrang = "Duyệt";
                    break;
            }
            return tinhTrang;
        }

        protected void ddlTinhTrang_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindGrid();
        }

        protected void btnSeach_Click(object sender, EventArgs e)
        {
            BindGrid();
        }
        protected void rptDanhMucLoaiVatTu_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            Literal ltEdit = (Literal)e.Item.FindControl("ltEdit");
            Literal ltDelete = (Literal)e.Item.FindControl("ltDelete");
            Literal ltPrint = (Literal)e.Item.FindControl("ltPrint");
            Literal ltAccept = (Literal)e.Item.FindControl("ltAccept");
            Sp_Qlvt_PhieuNhap_SelectResult result = (Sp_Qlvt_PhieuNhap_SelectResult)e.Item.DataItem;

            if (result.TINHTRANG.Value == 0)
            {
                int tudong = result.TuDong != null ? result.TuDong.Value : 0;
                if (tudong == 0)
                {
                    ltEdit.Text = "<li class=\"menu-item\"><a title=\"Sửa\" href=\"" + Util.SERVER_NAME + "/Business/QuanLyVatTu/Default.aspx?page=cnntp&id=" + result.ID + "\"><span class=\"icon edit-icon\"></span><span class=\"text\">Sửa</span></a></li>";
                    ltAccept.Text = "<li><a title=\"Duyệt\" href=\"javascript:duyetPhieuNhap('" + result.ID + "');\"><span class=\"icon accept-icon\"></span><span class=\"text\">Duyệt</span></a></li>";
                    ltDelete.Text = "<li class=\"menu-item\"><a title=\"Xóa\" href=\"javascript:deletePhieuNhap('" + result.ID + "');\"><span class=\"icon delete-icon\"></span><span class=\"text\">Xóa</span></a></li>";
                    ltPrint.Text = "<li class=\"menu-item\"><a title=\"In\" href=\"" + Util.SERVER_NAME + "/Business/QuanLyVatTu/Default.aspx?page=ppntp&id=" + result.ID + "\"><span class=\"icon icon-printer\"></span><span class=\"text\">In</span></a></li>";
                }
                else
                {
                    ltPrint.Text = "<li class=\"menu-item\"><a title=\"In\" href=\"" + Util.SERVER_NAME + "/Business/QuanLyVatTu/Default.aspx?page=ppntp&id=" + result.ID + "\"><span class=\"icon icon-printer\"></span><span class=\"text\">In</span></a></li>";
                }
            }
            else
            {
                ltPrint.Text = "<li class=\"menu-item\"><a title=\"In\" href=\"" + Util.SERVER_NAME + "/Business/QuanLyVatTu/Default.aspx?page=ppntp&id=" + result.ID + "\"><span class=\"icon icon-printer\"></span><span class=\"text\">In</span></a></li>";
            }
            
        }
    }
}