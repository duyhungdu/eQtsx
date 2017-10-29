using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;

namespace xRP.Administrator.QuanLyDonHang.DonHang
{
    public partial class DanhMucDonHang : System.Web.UI.UserControl
    {
        public string trang { get; set; }
        public string id_tinhchatnhapchat { get; set; }
        public string[] TinhTrang = { "Chưa xử lý", "Đã xử lý", "Hoàn thành" };
        public string display_button = "";
        xRPDataContext dts = new xRPDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                datepicker.Value = DateTime.Now.AddMonths(-1).ToString("dd/MM/yyyyy");
                datepicker1.Value = DateTime.Now.ToString("dd/MM/yyyyy");
            }
            if (Request.QueryString["trang"] != null)
            {
                trang = Request.QueryString["trang"].ToString();
            }
            if (Request.QueryString["idtinhchatnhapxuat"] != null)
            {
                id_tinhchatnhapchat = Request.QueryString["idtinhchatnhapxuat"].ToString();
            }
            BindGrid();
            if (Request.QueryString["page"].ToString() != "dsdonhang")
            {
                display_button = "display:none;";
            }
        }


        private void BindGrid()
        {
            if (txtTimKiem.Text.Trim() == "")
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
                var x = dts.Sp_Qldh_DonHang_Select(0, (int?)null, null, (int?)null, 0, dt1, dt2, null, " NgayDatHang DESC").ToList();
                //List<Sp_Qldh_DonHang_SelectResult> listDonHang = new List<Sp_Qldh_DonHang_SelectResult>();
                //var x = dts.Sp_Qldh_DonHang_Select(0, (int?)null, (int?)null, (int?)null, 0).OrderByDescending(t=>t.NgayTao).ToList();
                CollectionPager1.DataSource = x;
                CollectionPager1.BindToControl = rptDonHang;
                rptDonHang.DataSource = CollectionPager1.DataSourcePaged;
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
                var x = dts.Sp_Qldh_DonHang_Select(-1, (int?)null, null, (int?)null, 0, dt1, dt2, txtTimKiem.Text, " NgayDatHang DESC").ToList();
                CollectionPager1.DataSource = x;
                CollectionPager1.BindToControl = rptDonHang;
                rptDonHang.DataSource = CollectionPager1.DataSourcePaged;
            }
        }

        protected void rptDonHang_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

            Literal ltXuLy = (Literal)e.Item.FindControl("ltXuLyDonHang");
            Literal ltEdit = (Literal)e.Item.FindControl("ltEditItem");
            Literal ltDelete = (Literal)e.Item.FindControl("ltXoaDonHang");
            Literal ltUndoProcess = (Literal)e.Item.FindControl("ltUndoProcess");
            int iddonhang = 0;
            Sp_Qldh_DonHang_SelectResult donhang = (Sp_Qldh_DonHang_SelectResult)e.Item.DataItem;
            iddonhang = donhang.ID;
            if (Request.QueryString["page"].ToString() == "dsdonhang")
            {
                if (donhang != null)
                {
                    
                    List<xRPDAL.Sp_Qldh_MatHang_SelectResult> dshh = new xRPDataContext().Sp_Qldh_MatHang_Select(2, (int?)null, iddonhang, 0, (int?)null, "").ToList();
                    bool canDelete = true;
                    foreach (var x in dshh)
                    {
                        if (x.TinhTrang != 0)
                        {
                            canDelete = false;
                        }
                    }
                    if (ltEdit != null && canDelete)
                    {
                        ltEdit.Text = @"<li class='menu-item'>
                                                    <a href='/Administrator/QuanLyDonHang/DonHang/Default.aspx?page=addoreditdonhang&id=" + iddonhang + @"' title='Sửa đơn hàng'>
                                                        <span class='icon edit-icon'></span>
                                                        <span class='text'>Sửa</span></a></li>";
                    }
                    ltDelete.Text = canDelete ? "<li class=\"menu-item\"><a href=\"javascript:xoa('" + iddonhang + "');\" title=\"Xóa đơn hàng\"><span class=\"icon delete-icon\"></span><span class=\"text\">Xóa</span></a></li>" : "";
                   
                }
            }
            else
            {
                ltXuLy.Text = "<a href='/Business/QuanLySanXuat/Default.aspx?page=xldh&donhangid=" + ((Sp_Qldh_DonHang_SelectResult)e.Item.DataItem).ID + "' title='Xử lý đơn hàng'>" +
                    "<span class='icon icon-kcs'></span><span class='text'>Xử lý</span>" +
                    "</a>";
                List<xRPDAL.Sp_Qldh_MatHang_SelectResult> dshh = new xRPDataContext().Sp_Qldh_MatHang_Select(2, (int?)null, iddonhang, 0, (int?)null, "").ToList();
                bool canDelete = true;
                foreach (var x in dshh)
                {
                    if (x.TinhTrang != 0)
                    {
                        canDelete = false;
                    }
                }
                ltUndoProcess.Text = !canDelete ? "<li class=\"menu-item\"><a href=\"javascript:huyxuly('" + iddonhang + "');\" title=\"Hủy xử lý đơn hàng\"><span class=\"icon delete-icon\"></span><span class=\"text\">Hủy xử lý</span></a></li>" : "";

            }
        }
        protected void btTimKiem_Click(object sender, EventArgs e)
        {
            BindGrid();
        }
    }
}