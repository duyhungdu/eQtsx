using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;

namespace xRP.Business.QuanLyVatTu.NhapThanhPham
{
    public partial class AddOrEditNhapThanhPham : System.Web.UI.UserControl
    {

        public string ID_PhieuNhap { get; set; }
        private Qlvt_PhieuNhap currentPhieuNhap = null;
        protected int CurrentTinhTrang = 0;
        protected xRPDataContext dts = new xRPDataContext();
        protected string DataChiTiet = "";
        protected string DataVatTu = "";
        protected string DataTinhChatNhapXuat = "";
        public string KieuVatTu = ((int)EnumPhieuNhap.KieuVatTu.NhapThanhPham).ToString();


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var listTinhChat = dts.Sp_Qlvt_TinhChatNhapXuat_Select(0, (int?)null, 0, 1).Where(t => t.PhanLoaiNhapXuat == 1);
                DataTinhChatNhapXuat = new JavaScriptSerializer().Serialize(listTinhChat);
                listTinhChat = dts.Sp_Qlvt_TinhChatNhapXuat_Select(0, (int?)null, 0, 1).Where(t => t.PhanLoaiNhapXuat == 1);
                foreach (var x in listTinhChat)
                {
                    ddlTinhChat.Items.Add(new ListItem(x.TenTinhChatNhapXuat, x.ID.ToString()));
                }
            }

            ID_PhieuNhap = Request.QueryString["id"];
            if (ID_PhieuNhap == null) ID_PhieuNhap = "";
            if (ID_PhieuNhap != "" && ID_PhieuNhap != "0")
            {
                int id = 0;
                if (int.TryParse(ID_PhieuNhap, out id))
                    LoadData(id);
                else Response.Redirect(Util.SERVER_NAME + "/Business/QuanLyVatTu/Default.aspx?page=pn", false);
            }
            else
            {
                ltTitle.Text = "Tạo phiếu nhập thành phẩm";
                this.txtNgayNhap.Value = string.Format("{0:dd/MM/yyyy}", DateTime.Now);
                //Lấy từ trong bảng Sys_ThongSoHeThong ra quy tắc sinh mã gán vào biến partern
                //string partern = dts.Sys_ThongSoHeThongs.Where(t => t.ThongSo == "MaPhieuNhap").FirstOrDefault().GiaTri;
                //var lastRow = dts.Qlvt_PhieuNhaps.OrderByDescending(t => t.ID).Take(1).FirstOrDefault();
                //int maxValue = lastRow == null ? 1 : lastRow.ID + 1;

                txtMaPhieu.Value = dts.fc_SinhMa("MAPHIEUNHAP", "*");
            }
            ltButtonNewChiTietVatTuNhap.Text = "<span class=\"menu-item icon-only\" id=\"btn-tao-moi-chi-tiet-kiem-tra-vat-tu-nhap\"><span class=\"icon icon-add\"></span><a href=\"javascript:void(0);\">Thêm mặt hàng nhập</a></span>";
            ltPrint.Text = "<li class=\"menu-item icon-only\" id=\"btn-print\"><input type=\"button\" title=\"In\" class=\"menu-bar-item-button icon icon-printer\" id=\"btnPrint\" /></li>";
            ltAccept.Text = "<li class=\"menu-item icon-only\" id=\"btn-accept\"><a title=\"Duyệt\" class=\"menu-bar-item-button icon icon-tfs-build-reason-batchedci\" href=\"javascript:duyetPhieuNhap('" + ID_PhieuNhap + "');\"></a></li>";
            switch (this.CurrentTinhTrang)
            {
                case 0:
                    this.lblTinhTrang.Text = "Chưa kiểm tra";
                    break;
                case 1:
                    this.lblTinhTrang.Text = "Đã kiểm tra";
                    break;
                case 2:
                    this.lblTinhTrang.Text = "Đã duyệt";
                    break;
            }
            if (ID_PhieuNhap == "" || ID_PhieuNhap == "0")
            {
                lblTinhTrang.Text = "";
                ltTinhTrang.Text = "";
                ltPrint.Text = "";
            }
            if (CurrentTinhTrang == 0)
            {
                ltPrint.Text = "";
            }
            if (CurrentTinhTrang == 0 || CurrentTinhTrang == 2)
            {
                ltAccept.Text = "";
            }
            var listVatTu = new System.Collections.ArrayList();
            foreach (var x in dts.Sp_Qlvt_VatTu_Select(0, (int?)null, (int?)null, null, (int?)null))
            {
                listVatTu.Add(
                    new
                    {
                        MaVatTu = x.MaHieuVatTu,
                        MaHieuLoaiVatTu = x.MaHieuLoaiVatTu.Trim()
                    });
            }
            DataVatTu = new JavaScriptSerializer().Serialize(listVatTu);
        }

        private void LoadData(int id)
        {
            try
            {

                xRPDataContext dts = new xRPDataContext();
                this.currentPhieuNhap = (from t in dts.Qlvt_PhieuNhaps where t.ID == id select t).FirstOrDefault();
                if (this.currentPhieuNhap != null)
                {
                    ltTitle.Text = "Chỉnh sửa phiếu nhập thành phẩm: " + this.currentPhieuNhap.MaHieuPhieuNhap;
                    if (this.currentPhieuNhap.Xoa.HasValue && this.currentPhieuNhap.Xoa.Value)
                        Response.Redirect(Util.SERVER_NAME + "/Business/QuanLyVatTu/Default.aspx?page=pn", false);
                    //btnCancel.Visible = this.currentPhieuNhap.Xoa.HasValue && this.currentPhieuNhap.Xoa.Value;
                    pnChiTietVatTu.Visible = true;

                    this.txtMaPhieu.Value = this.currentPhieuNhap.MaHieuPhieuNhap;
                    this.txtNgayNhap.Value = string.Format("{0:dd/MM/yyyy}", this.currentPhieuNhap.NgayNhap);

                    this.slcTenNhaCungCap.Value = this.currentPhieuNhap.MaNhaCungCap.HasValue ? this.currentPhieuNhap.MaNhaCungCap.Value.ToString() : "";
                    if (this.currentPhieuNhap.MaNhaCungCap.HasValue)
                    {
                        this.slcTenNhaCungCap.Value = this.currentPhieuNhap.MaNhaCungCap.Value.ToString();
                        var ncc = dts.Qlvt_NhaCungCaps.Where(t => t.ID == this.currentPhieuNhap.MaNhaCungCap.Value).FirstOrDefault();
                        if (ncc != null)
                            this.txtTenNhaCungCap.Value = ncc.MaHieuNhaCungCap.Trim() + " - " + ncc.TenNhaCungCap;

                    }
                    if (this.currentPhieuNhap.MaKhoVatTu.HasValue)
                    {
                        this.slcKhoChua.Value = this.currentPhieuNhap.MaKhoVatTu.Value.ToString();
                        var kc = dts.Qlvt_KhoVatTus.Where(t => t.ID == this.currentPhieuNhap.MaKhoVatTu.Value).FirstOrDefault();
                        if (kc != null)
                            this.txtKhoChua.Value = kc.MaHieuKho.Trim() + " - " + kc.TenKhoVatTu;

                    }
                    if (this.currentPhieuNhap.MaTinhChatNhapXuat.HasValue)
                    {
                        this.ddlTinhChat.SelectedValue = this.currentPhieuNhap.MaTinhChatNhapXuat.Value.ToString();
                        if (this.currentPhieuNhap.MaTinhChatNhapXuat.Value == 29 && this.currentPhieuNhap.MaPhieuXuat.HasValue)
                        {
                            this.slcPhieuXuat.Value = this.currentPhieuNhap.MaPhieuXuat.Value.ToString();
                            var phieuxuat = dts.Qlvt_PhieuXuats.FirstOrDefault(t => t.ID == this.currentPhieuNhap.MaPhieuXuat.Value);
                            if (phieuxuat != null)
                                this.txtTheoPhieuXuat.Text = phieuxuat.MaHieuPhieuXuat;
                        }
                    }

                    this.txtGhiChu.Text = this.currentPhieuNhap.GhiChu;
                    var x = (from t in dts.Qlvt_VatTuNhaps where t.MaPhieuNhap == this.currentPhieuNhap.ID select t).ToList();
                    var listChiTiet = new System.Collections.ArrayList();
                    this.CurrentTinhTrang = this.currentPhieuNhap.TinhTrang.HasValue ? this.currentPhieuNhap.TinhTrang.Value : 0;

                }
                else
                    this.txtNgayNhap.Value = string.Format("{0:dd/MM/yyyy}", DateTime.Now);
            }
            catch (Exception ex)
            {
                Response.Write(ex.StackTrace);
                Response.Write(ex.Message);
            }
        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect(Util.SERVER_NAME + "/Business/QuanLyVatTu/Default.aspx?page=ntp", false);
        }
    }
}