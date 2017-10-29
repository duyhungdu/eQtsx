using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;

namespace xRP.Administrator.QuanLyDonHang.DonHang
{
    public partial class AddOrEditDonHang : System.Web.UI.UserControl
    {
        public string ID_DonHang { get; set; }
        private Qldh_DonHang currentDonHang = null;
        protected int CurrentTinhTrang = 0;
        protected xRPDataContext dts = new xRPDataContext();
        protected string DataChiTiet = "";
        public string ListDonViTinh = "[]";
        public string ListLoaiSanPham = "[]";
        public string MaKhachHang = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            var listDonViTinh = dts.Sp_Qlvt_DonViTinh_Select(0, (int?)null, 0, 1, "");
            ListDonViTinh = new JavaScriptSerializer().Serialize(listDonViTinh);
            ListLoaiSanPham = new JavaScriptSerializer().Serialize(dts.Sp_Qldh_LoaiSanPham_Select(0, (int?) null, 0, 1,null));
           // ltRefresh.Text = "<li class=\"menu-item icon-only\" id=\"btn-refresh\"><input type=\"button\" class=\"menu-bar-item-button icon-refresh\" id=\"btnRefresh\" title=\"Tải lại dữ liệu\" onclick=\"BindKhachHang(); return false;\" /></li>";
            ID_DonHang = Request.QueryString["id"];
            if (string.IsNullOrEmpty(ID_DonHang)) ID_DonHang = "0";
            if (ID_DonHang != "" && ID_DonHang != "0")
            {
                int id = 0;
                if (int.TryParse(ID_DonHang, out id))
                    LoadData(id);
                else Response.Redirect(Util.SERVER_NAME + "/Business/QuanLyVatTu/Default.aspx?page=pn", false);
            }
            else
            {
                //ltTitle.Text = "Tạo phiếu nhập";
                this.txtNgayDatHang.Value = string.Format("{0:dd/MM/yyyy}", DateTime.Now);
                this.txtNgayGiaoHang.Value = string.Format("{0:dd/MM/yyyy}", DateTime.Now);
                //Lấy từ trong bảng Sys_ThongSoHeThong ra quy tắc sinh mã gán vào biến partern
                //string partern = dts.Sys_ThongSoHeThongs.Where(t => t.ThongSo == "MaDonhang").FirstOrDefault().GiaTri;
                //var lastRow = dts.Qldh_DonHangs.OrderByDescending(t => t.ID).Take(1).FirstOrDefault();
                //int maxValue = lastRow == null ? 1 : lastRow.ID + 1;
                //txtMaDonHang.Text = Util.GenerateCode(partern, maxValue);
                txtMaDonHang.Text = dts.fc_SinhMa("MADONHANG", "");
            }
            this.ddlTinhTrang.SelectedValue = this.CurrentTinhTrang.ToString();
            ltButtonNewChiTietVatTuNhap.Text = "<span class=\"menu-item icon-only\" id=\"btn-tao-moi-chi-tiet-kiem-tra-vat-tu-nhap\"><span class=\"icon icon-add\"></span><a href=\"javascript:OpenModal('-1');\">Thêm thông tin hàng hóa</a></span>";
            
        }

        private void LoadData(int id) {
            try
            {

                xRPDataContext dts = new xRPDataContext();
                this.currentDonHang = (from t in dts.Qldh_DonHangs where t.ID == id select t).FirstOrDefault();
                if (this.currentDonHang != null)
                {
                    ltPrint.Text = "<li class=\"menu-item icon-only\" id=\"btn-print\"><input type=\"button\" class=\"menu-bar-item-button icon-printer\" id=\"btnPrint\" title=\"In dữ liệu\" /></li>";
                    //ltTitle.Text = "Chỉnh sửa phiếu kiểm tra vật tư nhập: " + this.currentDonHang.MaHieuPhieuNhap;
                    if (this.currentDonHang.Xoa.HasValue && this.currentDonHang.Xoa.Value)
                        Response.Redirect(Util.SERVER_NAME + "/Administrator/QuanLyDonHang/DonHang/Default.aspx?page=dsdonhang", false);
                    //btnCancel.Visible = this.currentDonHang.Xoa.HasValue && this.currentDonHang.Xoa.Value;
                    pnChiTietVatTu.Visible = true;

                    this.txtMaDonHang.Text = this.currentDonHang.MaHieuDonHang;
                    this.txtNgayDatHang.Value = string.Format("{0:dd/MM/yyyy}", this.currentDonHang.NgayDatHang);
                    this.txtNgayGiaoHang.Value = string.Format("{0:dd/MM/yyyy}", this.currentDonHang.NgayGiaoHang);

                    this.slcTenKhachHang.Value = this.currentDonHang.MaKhachHang.HasValue ? this.currentDonHang.MaKhachHang.Value.ToString() : "";
                    if (this.currentDonHang.MaKhachHang.HasValue)
                    {
                        this.slcTenKhachHang.Value = this.currentDonHang.MaKhachHang.Value.ToString();
                        var kh = dts.Qldh_KhachHangs.Where(t => t.ID == this.currentDonHang.MaKhachHang.Value).FirstOrDefault();
                        if (kh != null)
                            this.txtTenKhachHang.Text = kh.MaHieuKhachHang.Trim() + " - "+ kh.TenKhachHang;

                    }
                    this.CurrentTinhTrang = this.currentDonHang.TinhTrang.HasValue ? this.currentDonHang.TinhTrang.Value : 0;
                    this.txtGhiChu.Text = this.currentDonHang.GhiChu;
                    if (this.currentDonHang.MaKhachHang.HasValue) {
                        this.MaKhachHang = this.currentDonHang.MaKhachHang.Value.ToString();
                    }


                    List<xRPDAL.Sp_Qldh_MatHang_SelectResult> dshh = new xRPDataContext().Sp_Qldh_MatHang_Select(2, (int?)null, currentDonHang.ID, 0, (int?)null, "").ToList();
                    bool canDelete = true;
                    foreach (var x in dshh)
                    {
                        if (x.TinhTrang != 0)
                        {//Co hang hoa da duoc xu ly
                            canDelete = false;
                        }
                    }
                    //ltDelete.Text = canDelete ? "<li class=\"menu-item icon-only\" id=\"btn-delete\"><input type=\"button\" class=\"menu-bar-item-button icon-printer\" id=\"btnDelete\" title=\"Xóa đơn hàng\" /></li>" : "";
                    ltUndoProcess.Text = !canDelete ? "<li class=\"menu-item icon-only\" id=\"btn-undoprocess\"><input type=\"button\" class=\"menu-bar-item-button icon-printer\" id=\"btnUndoProcess\" title=\"Hủy xử lý\" /></li>" : "";
                }
                else
                {
                    this.txtNgayDatHang.Value = string.Format("{0:dd/MM/yyyy}", DateTime.Now);
                    this.txtNgayGiaoHang.Value = string.Format("{0:dd/MM/yyyy}", DateTime.Now);
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.StackTrace);
                Response.Write(ex.Message);
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Administrator/QuanLyDonHang/DonHang/Default.aspx?page=dsdonhang", true);
        }
    }
}