using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;

namespace xRP.Business.QuanLyVatTu.KiemTraVatTuNhap
{
    public partial class DanhMucPhieuKiemTraVatTuNhap : System.Web.UI.UserControl
    {
        protected int status = -1;

        protected void Page_Load(object sender, EventArgs e)
        {

            datepicker1.Value = DateTime.Now.ToString("dd/MM/yyyy");
            datepicker.Value = DateTime.Now.AddMonths(-1).ToString("dd/MM/yyyy");
            BindGrid();
        }

        private void BindGrid()
        {
            var dts = new xRPDataContext();

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
                DateTime temp1 = dt1.AddDays(-1);
                DateTime temp2 = dt2.AddDays(1);

                var x = dts.Sp_Qlvt_PhieuNhap_Select((int)EnumPhieuNhap.SelectTypes.All, (int?)null, 0, (int?)null, (int?)null, null, (int?)null, 1, status < 0 || status > 2 ? (int?)null : status, temp1, temp2, null, " NgayTao DESC").ToList();
                colPage.DataSource = x;
                colPage.BindToControl = rptDanhMucLoaiVatTu;
                rptDanhMucLoaiVatTu.DataSource = colPage.DataSourcePaged;
                Sp_Qlvt_PhieuNhap_SelectResult ru = new Sp_Qlvt_PhieuNhap_SelectResult();


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
                DateTime temp1 = dt1.AddDays(-1);
                DateTime temp2 = dt2.AddDays(1);
                var x = dts.Sp_Qlvt_PhieuNhap_Select((int)EnumPhieuNhap.SelectTypes.Seach, (int?)null, 0, (int?)null, (int?)null, null, (int?)null, 1, status < 0 || status > 2 ? (int?)null : status, temp1, temp2, searchbox.Value.Trim(), " NgayTao DESC").ToList();
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
                    tinhTrang = "Chưa kiểm tra";
                    break;
                case 1:
                    tinhTrang = "Đã kiểm tra";
                    break;
                case 2:
                    tinhTrang = "Duyệt";
                    break;
            }
            return tinhTrang;
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
            Literal ltPrintNCC = (Literal)e.Item.FindControl("ltPrintNCC");
            Literal ltAccept = (Literal)e.Item.FindControl("ltAccept");
            Literal ltKCS = (Literal)e.Item.FindControl("ltKCS");
            Sp_Qlvt_PhieuNhap_SelectResult result = (Sp_Qlvt_PhieuNhap_SelectResult)e.Item.DataItem;
            if (result.TINHTRANG.Value < 2)
                ltEdit.Text = "<li class=\"menu-item\"><a title=\"Sửa\" href=\"" + Util.SERVER_NAME + "/Business/QuanLyVatTu/Default.aspx?page=aoepktn&id=" + result.ID + "\"><span class=\"icon edit-icon\"></span><span class=\"text\">Sửa</span></a></li>";
            else
                ltEdit.Text = "<li class=\"menu-item\"><a title=\"Sửa\" href=\"" + Util.SERVER_NAME + "/Business/QuanLyVatTu/Default.aspx?page=vdktn&id=" + result.ID + "\"><span class=\"icon edit-icon\"></span><span class=\"text\">Xem phiếu</span></a></li>";
            if (result.TINHTRANG.Value != 2)
                ltDelete.Text = "<li class=\"menu-item\"><a title=\"Xóa\" href=\"javascript:deletePhieuNhap('" + result.ID + "');\"><span class=\"icon delete-icon\"></span><span class=\"text\">Xóa</span></a></li>";
            ltPrint.Text = "<li class=\"menu-item\"><a title=\"In\" href=\"../../Business/QuanLyVatTu/Default.aspx?page=ppn&id=" + result.ID + "&type=1\"><span class=\"icon icon-printer\"></span><span class=\"text\">Phiếu nội bộ</span></a></li>";
            ltPrintNCC.Text = "<li class=\"menu-item\"><a title=\"In\" href=\"../../Business/QuanLyVatTu/Default.aspx?page=ppn&id=" + result.ID + "&type=2\"><span class=\"icon icon-printer\"></span><span class=\"text\">Phiếu cho NCC</span></a></li>";
            if (result.TINHTRANG.Value != 2)
                ltAccept.Text = "<li><a title=\"Duyệt\" href=\"javascript:duyetPhieuNhap('" + result.ID + "');\"><span class=\"icon accept-icon\"></span><span class=\"text\">Duyệt</span></a></li>";
            if (result.TINHTRANG.Value != 2)
                ltKCS.Text = "<li class=\"menu-item\"><a title=\"KCS\" href=\"" + Util.SERVER_NAME + "/Business/QuanLyVatTu/Default.aspx?page=kcsvtn&id=" + result.ID + "\"><span class=\"icon icon-kcs\"></span><span class=\"text\">KCS</span></a></li>";
        }
    }
}