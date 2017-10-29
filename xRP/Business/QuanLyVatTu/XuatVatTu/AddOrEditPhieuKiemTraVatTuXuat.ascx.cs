using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;
namespace xRP.Business.QuanLyVatTu.XuatVatTu
{
    public partial class AddOrEditPhieuKiemTraVatTuXuat : System.Web.UI.UserControl
    {
        public string ID_PhieuXuat { get; set; }
        private Qlvt_PhieuXuat currentPhieuXuat = null;
        protected xRPDataContext dts = new xRPDataContext();
        protected string DataChiTiet = "";
        protected string DataVatTu = "[]";
        public string KieuVatTu = ((int)EnumPhieuXuat.KieuVatTu.VatTuXuat).ToString();


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                foreach (var x in dts.Sp_Qlvt_TinhChatNhapXuat_Select(0, (int?)null, 0, 1).Where(t => t.PhanLoaiNhapXuat == 2))
                {
                    ddlTinhChat.Items.Add(new ListItem(x.TenTinhChatNhapXuat, x.ID.ToString()));
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
            ltTitle.Text = "Thêm phiếu xuất";

            ID_PhieuXuat = Request.QueryString["id"];
            if (ID_PhieuXuat == null) ID_PhieuXuat = "";
            if (ID_PhieuXuat != "" && ID_PhieuXuat != "0")
            {
                int id = 0;
                if (int.TryParse(ID_PhieuXuat, out id))
                    LoadData(id);
                else Response.Redirect(Util.SERVER_NAME + "/Business/QuanLyVatTu/Default.aspx?page=pn", false);
            }
            else
            {
                ID_PhieuXuat = "0";
                ltTitle.Text = "Tạo phiếu xuất";

                this.txtNgayXuat.Value = string.Format("{0:dd/MM/yyyy}", DateTime.Now);
                //Lấy từ trong bảng Sys_ThongSoHeThong ra quy tắc sinh mã gán vào biến partern
                //string partern = dts.Sys_ThongSoHeThongs.Where(t => t.ThongSo == "MaPhieuXuat").FirstOrDefault().GiaTri;

                //var lastRow = dts.Qlvt_PhieuXuats.OrderByDescending(t => t.ID).Take(1).FirstOrDefault();
                //int maxValue = lastRow == null ? 1 : lastRow.ID + 1;
                //this.txtMaPhieu.Text = Util.GenerateCode(partern, maxValue);
                //txtMaPhieu.Text = dts.fc_SinhMa("MAPHIEUXUAT", "*");
                if (ddlTinhChat.SelectedIndex >= 0)
                {
                    var tc = dts.Qlvt_TinhChatNhapXuats.Where(t => t.ID == int.Parse(ddlTinhChat.SelectedValue)).FirstOrDefault();
                    if (tc != null)
                        txtMaPhieu.Text = dts.fc_SinhMa(tc.MaTinhChatNhapXuat, "*");
                }
                bool khoExisted = false;
                if (!string.IsNullOrWhiteSpace(Request.QueryString["kho"]))
                {
                    int maKhoVatTu = 0;
                    if (int.TryParse(Request.QueryString["kho"], out maKhoVatTu))
                    {
                        this.slcKhoChua.Value = maKhoVatTu.ToString();
                        var kc = dts.Qlvt_KhoVatTus.Where(t => t.ID == maKhoVatTu).FirstOrDefault();
                        if (kc != null)
                        {
                            this.lblKhoChua.Text = kc.MaHieuKho.Trim() + " - " + kc.TenKhoVatTu;
                            khoExisted = true;
                        }
                    }
                }
                if (!khoExisted)
                    Response.Redirect(Util.SERVER_NAME + "/Business/QuanLyVatTu/Default.aspx?page=pn", false);
            }

            ltButtonNewChiTietVatTuXuat.Text = "<span class=\"menu-item icon-only\" id=\"btn-tao-moi-chi-tiet-kiem-tra-vat-tu-xuat\"><span class=\"icon icon-add\"></span><a href=\"javascript:void(0);\">Thêm mới vật tư xuất</a></span>";

        }

        private void LoadData(int id)
        {
            try
            {

                xRPDataContext dts = new xRPDataContext();
                this.currentPhieuXuat = (from t in dts.Qlvt_PhieuXuats where t.ID == id select t).FirstOrDefault();

                if (this.currentPhieuXuat != null)
                {
                    ltPrint.Text = "<li class=\"menu-item icon-only\" id=\"Li1\"><input type=\"button\" class=\"menu-bar-item-button icon-printer\" id=\"btnPrint\" title=\"In dữ liệu\" /></li>";
                    ltAccept.Text = "<li class=\"menu-item icon-only\" id=\"btn-accept\"><a title=\"Duyệt\" class=\"menu-bar-item-button icon icon-tfs-build-reason-batchedci\" href=\"javascript:duyetPhieuXuat('" + ID_PhieuXuat + "');\"></a></li>";

                    ltTitle.Text = "Chỉnh sửa phiếu xuất: " + this.currentPhieuXuat.MaHieuPhieuXuat;
                    if (this.currentPhieuXuat.Xoa.HasValue && this.currentPhieuXuat.Xoa.Value)
                        Response.Redirect(Util.SERVER_NAME + "/Business/QuanLyVatTu/Default.aspx?page=pktx", false);

                    this.txtMaPhieu.Text = this.currentPhieuXuat.MaHieuPhieuXuat;
                    this.txtNgayXuat.Value = string.Format("{0:dd/MM/yyyy}", this.currentPhieuXuat.NgayXuat);


                    if (this.currentPhieuXuat.MaKhoVatTu.HasValue)
                    {
                        this.slcKhoChua.Value = this.currentPhieuXuat.MaKhoVatTu.Value.ToString();
                        var kc = dts.Qlvt_KhoVatTus.Where(t => t.ID == this.currentPhieuXuat.MaKhoVatTu.Value).FirstOrDefault();
                        if (kc != null)
                            this.lblKhoChua.Text = kc.MaHieuKho.Trim() + " - " + kc.TenKhoVatTu;
                    }

                    if (this.currentPhieuXuat.MaKhoVatTuDen.HasValue)
                    {
                        this.slcKhoDen.Value = this.currentPhieuXuat.MaKhoVatTuDen.Value.ToString();
                        var kd = dts.Qlvt_KhoVatTus.Where(t => t.ID == this.currentPhieuXuat.MaKhoVatTuDen.Value).FirstOrDefault();
                        if (kd != null)
                            this.txtKhoDen.Text = kd.MaHieuKho.Trim() + " - " + kd.TenKhoVatTu;
                    }

                    if (this.currentPhieuXuat.MaTinhChatNhapXuat.HasValue)
                    {
                        this.ddlTinhChat.SelectedValue = this.currentPhieuXuat.MaTinhChatNhapXuat.Value.ToString();
                        var tinhChat = dts.Sp_Qlvt_TinhChatNhapXuat_Select(1, currentPhieuXuat.MaTinhChatNhapXuat.Value, (int?)null, (int?)null).FirstOrDefault();

                        this.slcKhachHang.Value = this.currentPhieuXuat.MaDonViNhan.HasValue ? this.currentPhieuXuat.MaDonViNhan.Value.ToString() : "";
                        if (this.currentPhieuXuat.MaDonViNhan.HasValue && tinhChat != null && tinhChat.NoiBo.HasValue && tinhChat.NoiBo.Value)
                        {
                            var kh = dts.Sys_DanhMucDonVis.Where(t => t.ID == this.currentPhieuXuat.MaDonViNhan.Value).FirstOrDefault();
                            if (kh != null)
                                this.txtKhachHang.Value = (kh.MaHieuDonVi == null ? "" : (kh.MaHieuDonVi.Trim() + " - ")) + kh.TenDonVi;
                        }
                        if (this.currentPhieuXuat.MaDonViNhan.HasValue && tinhChat != null && tinhChat.NoiBo.HasValue && !tinhChat.NoiBo.Value)
                        {

                            var kh = dts.Qldh_KhachHangs.Where(t => t.ID == this.currentPhieuXuat.MaDonViNhan.Value).FirstOrDefault();
                            if (kh != null)
                                this.txtKhachHang.Value = kh.TenKhachHang;
                        }
                        if (this.currentPhieuXuat.MaDonViNhan.HasValue && tinhChat != null && tinhChat.TenTinhChatNhapXuat == "Xuất trả lại")
                        {
                            var kh = dts.Qlvt_NhaCungCaps.Where(t => t.ID == this.currentPhieuXuat.MaDonViNhan.Value).FirstOrDefault();
                            if (kh != null)
                                this.txtKhachHang.Value = kh.TenNhaCungCap;
                        }
                    }
                    this.txtGhiChu.Text = this.currentPhieuXuat.GhiChu;
                    if (this.currentPhieuXuat.TinhTrang == 1)
                        Response.Redirect("Default.aspx?page=vdktx&id=" + this.currentPhieuXuat.ID);
                }
                else
                    this.txtNgayXuat.Value = string.Format("{0:dd/MM/yyyy}", DateTime.Now);

            }
            catch (Exception ex)
            {
                Response.Write(ex.StackTrace);
                Response.Write(ex.Message);
            }

        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect(Util.SERVER_NAME + "/Business/QuanLyVatTu/Default.aspx?page=pktn", false);
        }
    }
}