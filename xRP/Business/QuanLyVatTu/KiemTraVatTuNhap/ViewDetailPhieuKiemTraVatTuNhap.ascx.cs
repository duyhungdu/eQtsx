using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;
using System.Web.Script.Serialization;

namespace xRP.Business.QuanLyVatTu.KiemTraVatTuNhap
{
    public partial class ViewDetailPhieuKiemTraVatTuNhap : System.Web.UI.UserControl
    {
        public string ID_PhieuNhap { get; set; }
        private Qlvt_PhieuNhap currentPhieuNhap = null;
        protected int CurrentTinhTrang = 0;
        protected xRPDataContext dts = new xRPDataContext();
        protected string DataChiTiet = "";
        protected string DataVatTu = "";
        public string KieuVatTu = ((int)EnumPhieuNhap.KieuVatTu.VatTuNhap).ToString();

        protected void Page_Load(object sender, EventArgs e)
        {

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
                ltTitle.Text = "Tạo phiếu nhập";
                this.txtNgayNhap.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now);
                //Lấy từ trong bảng Sys_ThongSoHeThong ra quy tắc sinh mã gán vào biến partern
                //string partern = dts.Sys_ThongSoHeThongs.Where(t => t.ThongSo == "MaPhieuNhap").FirstOrDefault().GiaTri;
                //var lastRow = dts.Qlvt_PhieuNhaps.OrderByDescending(t => t.ID).Take(1).FirstOrDefault();
                //int maxValue = lastRow == null ? 1 : lastRow.ID + 1;

            }
            ltPrint.Text = "<li class=\"menu-item icon-only\" id=\"btn-print\"><input type=\"button\" title=\"In\" class=\"menu-bar-item-button icon icon-printer\" id=\"btnPrint\"   /></li>";
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
                    if (this.currentPhieuNhap.TinhTrang < 2)
                        ltTitle.Text = "Chỉnh sửa phiếu kiểm tra vật tư nhập: " + this.currentPhieuNhap.MaHieuPhieuNhap;
                    else
                        ltTitle.Text = "Xem phiếu kiểm tra vật tư nhập: " + this.currentPhieuNhap.MaHieuPhieuNhap;
                    if (this.currentPhieuNhap.Xoa.HasValue && this.currentPhieuNhap.Xoa.Value)
                        Response.Redirect(Util.SERVER_NAME + "/Business/QuanLyVatTu/Default.aspx?page=pn", false);
                    //btnCancel.Visible = this.currentPhieuNhap.Xoa.HasValue && this.currentPhieuNhap.Xoa.Value;
                    pnChiTietVatTu.Visible = true;

                    this.txtMaPhieu.Text = this.currentPhieuNhap.MaHieuPhieuNhap;
                    this.txtNgayNhap.Text = string.Format("{0:dd/MM/yyyy}", this.currentPhieuNhap.NgayNhap);

                    if (this.currentPhieuNhap.MaNhaCungCap.HasValue)
                    {
                        var ncc = dts.Qlvt_NhaCungCaps.Where(t => t.ID == this.currentPhieuNhap.MaNhaCungCap.Value).FirstOrDefault();
                        if (ncc != null)
                            this.txtTenNhaCungCap.Text = ncc.MaHieuNhaCungCap.Trim() + " - " + ncc.TenNhaCungCap;

                    }
                    if (this.currentPhieuNhap.MaKhoVatTu.HasValue)
                    {
                        var kc = dts.Qlvt_KhoVatTus.Where(t => t.ID == this.currentPhieuNhap.MaKhoVatTu.Value).FirstOrDefault();
                        if (kc != null)
                            this.txtKhoChua.Text = kc.MaHieuKho.Trim() + " - " + kc.TenKhoVatTu;

                    }
                    if (this.currentPhieuNhap.MaTinhChatNhapXuat.HasValue)
                    {
                        var tc = dts.Qlvt_TinhChatNhapXuats.Where(t => t.ID == this.currentPhieuNhap.MaTinhChatNhapXuat.Value).FirstOrDefault();
                        if (tc != null)
                            this.ddlTinhChat.Text = tc.TenTinhChatNhapXuat;
                        if (this.currentPhieuNhap.MaTinhChatNhapXuat.Value == 29 && this.currentPhieuNhap.MaPhieuXuat.HasValue)
                        {
                            var phieuxuat = dts.Qlvt_PhieuXuats.FirstOrDefault(t => t.ID == this.currentPhieuNhap.MaPhieuXuat.Value);
                            if (phieuxuat != null)
                                this.txtTheoPhieuXuat.InnerHtml = phieuxuat.MaHieuPhieuXuat;
                        }
                    }

                    this.txtGhiChu.Text = this.currentPhieuNhap.GhiChu.Replace("\n","<br />");
                    var x = (from t in dts.Qlvt_VatTuNhaps where t.MaPhieuNhap == this.currentPhieuNhap.ID select t).ToList();
                    var listChiTiet = new System.Collections.ArrayList();
                    this.CurrentTinhTrang = this.currentPhieuNhap.TinhTrang.HasValue ? this.currentPhieuNhap.TinhTrang.Value : 0;


                    for (int i = 0; i < x.Count; i++)
                    {
                        var vt = x[i];
                        var vttype = dts.Qlvt_VatTus.Where(t => t.ID == vt.MaVatTu).FirstOrDefault();
                        if (vttype != null)
                            listChiTiet.Add(new
                            {
                                ID = vt.ID,
                                maVatTu = vttype.MaHieuVatTu,
                                tenVatTu = vttype.TenVatTu,
                                donViTinh = vt.IDDonViTinh,
                                tenDonViTinh = dts.Qlvt_DonViTinhs.Where(t => t.ID == vt.IDDonViTinh).FirstOrDefault().DonViTinh,
                                giaNhap = vt.DonGia.HasValue ? vt.DonGia.Value : 0,
                                soLuongThucNhap = vt.SoLuongThucNhap.HasValue ? vt.SoLuongThucNhap.Value : 0,
                                soLuongDauCuon = vt.SoLuongDauCuon.HasValue ? vt.SoLuongDauCuon.Value : 0,
                                soLuongLamPhieuNhap = vt.SoLuongLamPhieuNhap.HasValue ? vt.SoLuongLamPhieuNhap.Value : 0,
                                dinhLuongTieuChuan = vttype.DinhLuong,
                                dinhLuongThucTe = vt.DinhLuongThucTe.HasValue ? vt.DinhLuongThucTe.Value : 0,
                                kichThuocTieuChuan = vttype.KichThuocVatTu,
                                kichThuocThucTe = vt.KichThuocThucTe.HasValue ? vt.KichThuocThucTe.Value : 0,
                                chenhLechDinhLuong = vt.ChenhLechDinhLuong.HasValue ? vt.ChenhLechDinhLuong.Value : 0,
                                dinhLuongTinhTru = vt.DinhLuongTinhTru.HasValue ? vt.DinhLuongTinhTru.Value : 0,
                                truKichThuoc = vt.TruThuaKichThuoc.HasValue ? vt.TruThuaKichThuoc : 0,
                                khoiLuongTru = vt.KhoiLuongTru.HasValue ? vt.KhoiLuongTru.Value : 0,
                                truLoi = vt.TruLoi.HasValue ? vt.TruLoi.Value : 0,
                                soLuongChenhLechKhongTinh = vt.SoLuongChenhLechKhongTinh.HasValue ? vt.SoLuongChenhLechKhongTinh : 0,
                                thanhTien = vt.ThanhTien.HasValue ? vt.ThanhTien : 0,
                                ghiChu = vt.GhiChu
                            });
                    }
                    DataChiTiet = new JavaScriptSerializer().Serialize(listChiTiet);

                }
                else
                    this.txtNgayNhap.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now);
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