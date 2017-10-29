using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;

namespace xRP.Business.QuanLyVatTu.KiemTraVatTuNhap
{
    public partial class KCSKiemTraVatTuNhap : System.Web.UI.UserControl
    {
        public string ID_PhieuNhap { get; set; }
        private Qlvt_PhieuNhap currentPhieuNhap = null;
        protected xRPDataContext dts = new xRPDataContext();
        protected string DataChiTiet = "";
        protected string DataPhieuNhap = "";
        protected void Page_Load(object sender, EventArgs e) 
        {
            this.ltTitle.Text = "KCS phiếu nhập";
            ID_PhieuNhap = Request.Params["id"];
            if (ID_PhieuNhap != "" && ID_PhieuNhap != "0")
            {
                int id = 0;
                if (int.TryParse(ID_PhieuNhap, out id))
                    LoadData(id);
                else Response.Redirect(Util.SERVER_NAME + "/Business/QuanLyVatTu/Default.aspx?page=pktn", false);
            }
            else
                Response.Redirect(Util.SERVER_NAME + "/Business/QuanLyVatTu/Default.aspx?page=pktn", false);
        }

        private void LoadData(int id)
        {
            try
            {
                xRPDataContext dts = new xRPDataContext();
                this.currentPhieuNhap = (from t in dts.Qlvt_PhieuNhaps where t.ID == id select t).FirstOrDefault();
                if (this.currentPhieuNhap != null)
                {
                    if (this.currentPhieuNhap.Xoa.HasValue && this.currentPhieuNhap.Xoa.Value)
                        Response.Redirect(Util.SERVER_NAME + "/Business/QuanLyVatTu/Default.aspx?page=pn", false);
                    //btnCancel.Visible = this.currentPhieuNhap.Xoa.HasValue && this.currentPhieuNhap.Xoa.Value;
                    pnChiTietVatTu.Visible = true;

                    this.txtMaPhieu.Value = this.currentPhieuNhap.MaHieuPhieuNhap;
                    this.txtNgayNhap.Value = string.Format("{0:dd/MM/yyyy}", this.currentPhieuNhap.NgayNhap);

                    if (this.currentPhieuNhap.MaNhaCungCap.HasValue)
                    {
                        var ncc = dts.Qlvt_NhaCungCaps.Where(t => t.ID == this.currentPhieuNhap.MaNhaCungCap.Value).FirstOrDefault();
                        if (ncc != null)
                            this.txtTenNhaCungCap.Value = ncc.MaHieuNhaCungCap.Trim() + " - " + ncc.TenNhaCungCap;

                    }
                    if (this.currentPhieuNhap.MaKhoVatTu.HasValue)
                    {
                        var kc = dts.Qlvt_KhoVatTus.Where(t => t.ID == this.currentPhieuNhap.MaKhoVatTu.Value).FirstOrDefault();
                        if (kc != null)
                            this.txtKhoChua.Value = kc.TenKhoVatTu;

                    }
                    if (this.currentPhieuNhap.MaTinhChatNhapXuat.HasValue)
                    {
                        var kc = dts.Qlvt_TinhChatNhapXuats.Where(t => t.ID == this.currentPhieuNhap.MaTinhChatNhapXuat.Value).FirstOrDefault();
                        if (kc != null)
                            this.txtTinhChat.Value = kc.TenTinhChatNhapXuat;

                    }

                    this.txtGhiChu.Text = this.currentPhieuNhap.GhiChu;
                    var x = (from t in dts.Qlvt_VatTuNhaps where t.MaPhieuNhap == this.currentPhieuNhap.ID select t).ToList();
                    var listChiTiet = new System.Collections.ArrayList();

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
                    DataPhieuNhap = new JavaScriptSerializer().Serialize(new
                    {
                        itemID = this.currentPhieuNhap.ID,
                        ID = this.currentPhieuNhap.ID,
                        MaHieuPhieuNhap = this.currentPhieuNhap.MaHieuPhieuNhap,
                        NgayNhap = this.currentPhieuNhap.NgayNhap.Value.ToString("dd/MM/yyyy"),
                        MaNhaCungCap = this.currentPhieuNhap.MaNhaCungCap.Value,
                        MaKhoVatTu = this.currentPhieuNhap.MaKhoVatTu.Value,
                        MaTinhChatNhapXuat = this.currentPhieuNhap.MaTinhChatNhapXuat.Value,
                        KieuVatTu = this.currentPhieuNhap.KieuVatTu.Value,
                        TinhTrang = this.currentPhieuNhap.TinhTrang.Value,
                        GhiChu = this.currentPhieuNhap.GhiChu
                    });
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
            Response.Redirect(Util.SERVER_NAME + "/Business/QuanLyVatTu/Default.aspx?page=pktn", false);
        }
    }
}