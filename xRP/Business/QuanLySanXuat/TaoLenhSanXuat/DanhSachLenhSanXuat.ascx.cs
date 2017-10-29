using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;
using xRPRepository;

namespace xRP.Business.QuanLySanXuat.TaoLenhSanXuat
{
    public partial class DanhSachLenhSanXuat : System.Web.UI.UserControl
    {
        protected Qlsx_LenhSanXuatRepository danhsachLenhSanXuatRepository = new Qlsx_LenhSanXuatRepository();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtNgaySanXuatTu.Text = DateTime.Now.AddMonths(-1).ToString("dd/MM/yyyy");
                txtNgaySanXuatDen.Text = DateTime.Now.AddDays(7).ToString("dd/MM/yyyy");
                BinddataDrop();
            }
        }
        public void BinddataDrop()
        {
            Qlsx_CongDoanRepository danhSachCongDoan = new Qlsx_CongDoanRepository();
            var lsData = danhSachCongDoan.GetAllCongDoan(0, null, 0, null);
            ddlCongDoan.DataSource = danhSachCongDoan.GetAllCongDoan(2, null, null, null);
            ddlCongDoan.DataBind();
            if (Request.QueryString["cd"] != null)
                ddlCongDoan.SelectedValue = Request.QueryString["cd"].ToString();
            BindData();
        }

        public void BindData()
        {
            //Chỗ này sai rồi, phải lấy từ thủ tục Sp_Qlsx_YeuCauSanXuatSelect         
            // Đã comfirrm lại với anh Hòa -phamkhuong102

            int? congDoanId = null;
            //int? khachHangId = null; 
            //int? donHangId = null;
            try
            {
                congDoanId = int.Parse(ddlCongDoan.SelectedItem.Value);
            }
            catch { }

            //if (!string.IsNullOrEmpty(txtKhachHangID.Text))
            //{
            //    try
            //    {
            //        khachHangId = int.Parse(slcKhachHangID.Value);
            //    }
            //    catch { }
            //}

            //if (!string.IsNullOrEmpty(txtDonHangID.Text))
            //{
            //    try
            //    {
            //        donHangId = int.Parse(slcDonHangID.Value);
            //    }
            //    catch { }
            //}
            DateTime? ngaySanXuatTu = null;
            DateTime? ngaySanXuatDen = null;

            try
            {
                if (!string.IsNullOrEmpty(txtNgaySanXuatTu.Text))
                    ngaySanXuatTu = DateTime.ParseExact(txtNgaySanXuatTu.Text, "dd/MM/yyyy", new CultureInfo("en-US"));
            }
            catch
            {
                ngaySanXuatTu = DateTime.Now.AddDays(-30);
            }
            try
            {
                if (!string.IsNullOrEmpty(txtNgaySanXuatDen.Text))
                    ngaySanXuatDen = DateTime.ParseExact(txtNgaySanXuatDen.Text, "dd/MM/yyyy", new CultureInfo("en-US"));
            }
            catch
            {
                ngaySanXuatDen = DateTime.Now;
            }
            var listLenhSanXuat = danhsachLenhSanXuatRepository.GetDanhSachLenhSanXuat(congDoanId, ngaySanXuatTu, ngaySanXuatDen).OrderByDescending(x => x.NgayTao).ToList();
            colPage.MaxPages = 10000;
            colPage.PageSize = 10; // số items hiển thị trên một trang.
            colPage.DataSource = listLenhSanXuat;
            colPage.BindToControl = rptLenhSanXuat;
            rptLenhSanXuat.DataSource = colPage.DataSourcePaged;
            rptLenhSanXuat.DataBind();
        }

        protected void ddlCongDoan_SelectedIndexChanged(object sender, EventArgs e)
        {

            BindData();
        }

        public string createBtnEdit(string status, string id)
        {
            var data = "";
            if (status == "Tạo lệnh")
            {
                data += "<li class=\"menu-item\" style=\"text-align: left\"   >";
                data += "<a id=\"edit-icon\" title=\"Sửa lệnh sản xuất\" href=\"javascript:onEditLenhSanXuat('" + id + "');\">";
                data += "<span class=\"icon edit-icon\"></span><span class=\"text\">Sửa</span></a>";
                data += "</li>";
            }
            return data;
        }

        protected void rptLenhSanXuat_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var item = e.Item.DataItem as Sp_Qlsx_LenhSanXuat_SelectResult;
                var data = "<p><a aria-expanded=\"false\" aria-controls=\"tinyDrop\" data-dropdown=\"tinyDrop" + item.ID + "\" class=\"button\">Chức năng</a></p>";
                data += "<ul aria-hidden=\"true\" tabindex=\"-1\" data-dropdown-content=\"\" class=\"f-dropdown\" id='tinyDrop" + item.ID + "'>";




                if (item.IDCongDoan == 1 && item.TinhTrang != -1)
                {
                    data += "<li class=\"menu-item\" style=\"text-align: left\">";
                    data += "<a id=\"create-icon\" title=\"Cập nhật phiếu yêu cầu vật tư\" href=\"javascript:onAddOrEditPhieuYeuCauVatTu('" + item.ID + "');\">";
                    data += "<span class=\"icon icon-kcs\"></span><span class=\"text\">Phiếu yêu cầu VT</span></a>";
                    data += " </li>";
                }
                if (item.MoTaTinhTrang == "Hoàn thành")
                {
                    //data += "<li class=\"menu-item\" style=\"text-align: left\">";
                    //data += "<a id=\"create-icon\" title=\"Kết chuyển\" href=\"javascript:onCopyLenhSanXuat('" + item.ID + "');\">";
                    //data += "<span class=\"icon icon-copy\"></span><span class=\"text\">Kết chuyển</span></a>";
                    //data += " </li>";

                    data += "<li class=\"menu-item\" style=\"text-align: left\" >";
                    data += "<a id=\"edit-icon\" title=\"Xem chi tiết lệnh sản xuất\" href=\"javascript:onDetailLenhSanXuat('" + item.ID + "');\">";
                    data += "<span class=\"icon edit-icon\"></span><span class=\"text\">Chi tiết</span></a>";
                    data += " </li>";

                    data += "<li class=\"menu-item\" style=\"text-align: left\">";
                    data += "<a id=\"printer-icon\" title=\"In lệnh sản xuất\" href=\"javascript:onPrintLenhSanXuat('" + item.ID + "');\">";
                    data += "<span class=\"icon icon-printer\"></span><span class=\"text\">In lệnh</span></a>";
                    data += "</li>";
                    data += " </ul>";
                    ((Literal)e.Item.FindControl("ltbFunction")).Text = data;

                    return;
                }
                else
                {


                    data += "<li class=\"menu-item\" style=\"text-align: left\" >";
                    data += "<a id=\"edit-icon\" title=\"Sửa lệnh sản xuất\" href=\"javascript:onEditLenhSanXuat('" + item.ID + "');\">";
                    data += "<span class=\"icon edit-icon\"></span><span class=\"text\">Sửa</span></a>";
                    data += " </li>";

                    if (item.TinhTrang != -1)
                    {
                        data += "<li class=\"menu-item\" style=\"text-align: left\">";
                        data += "<a id=\"update-icon\" title=\"Cập nhật kết quả sản xuất\" href=\"javascript:onUpdateKetQuaSanXuat('" + item.ID + "');\">";
                        data += "<span class=\"icon icon-kcs\"></span><span class=\"text\">Cập nhật kết quả</span></a>";
                        data += " </li>";

                        data += "<li class=\"menu-item\" style=\"text-align: left\">";
                        data += "<a id=\"printer-icon\" title=\"In lệnh sản xuất\" href=\"javascript:onPrintLenhSanXuat('" + item.ID + "');\">";
                        data += "<span class=\"icon icon-printer\"></span><span class=\"text\">In lệnh</span></a>";
                        data += "</li>";
                    }
                    else
                    {
                        data += "<li class=\"menu-item\" style=\"text-align: left\">";
                        data += "<a id=\"delete-icon\" title=\"Xóa lệnh sản xuất\" href=\"javascript:onDeleteLenhSanXuat('" + item.ID + "');\">";
                        data += "<span class=\"icon icon-delete\"></span><span class=\"text\">Xóa</span></a>";
                        data += "</li>";
                    }

                    data += " </ul>";

                    ((Literal)e.Item.FindControl("ltbFunction")).Text = data;
                    return;
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindData();
        }

    }
}