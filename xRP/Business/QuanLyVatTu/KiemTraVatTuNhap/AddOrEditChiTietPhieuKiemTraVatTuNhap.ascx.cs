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
    public partial class AddOrEditChiTietPhieuKiemTraVatTuNhap : System.Web.UI.UserControl
    {
        protected xRPDataContext dts = new xRPDataContext();
        public string ID_VatTu { set; get; }
        protected string DataVatTu = "{}";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtMaCuon.Attributes.Add("data-field", "MaCuon");
                txtTenVatTu.Attributes.Add("data-field", "TenVatTu");
                txtDonViTinh.Attributes.Add("data-field", "DonViTinh");
                txtGiaNhap.Attributes.Add("data-field", "DonGia");
                txtSoLuongDauCuon.Attributes.Add("data-field", "SoLuongDauCuon");
                txtSoLuongLamPhieu.Attributes.Add("data-field", "SoLuongLamPhieuNhap");
                txtDinhLuongTieuChuan.Attributes.Add("data-field", "DinhLuongTieuChuan");
                txtDinhLuongThucTe.Attributes.Add("data-field", "DinhLuongThucTe");
                txtKichThuocTieuChuan.Attributes.Add("data-field", "KichThuocTieuChuan");
                txtKichThuocThucTe.Attributes.Add("data-field", "KichThuocThucTe");
                txtChenhLechDinhLuong.Attributes.Add("data-field", "ChenhLechDinhLuong");
                txtDinhLuongTru.Attributes.Add("data-field", "DinhLuongTinhTru");
                txtTruKichThuoc.Attributes.Add("data-field", "TruThuaKichThuoc");
                txtKhoiLuongTru.Attributes.Add("data-field", "KhoiLuongTru");
                txtTruLoi.Attributes.Add("data-field", "TruLoi");
                txtSoLuongThucNhap.Attributes.Add("data-field", "SoLuongThucNhap");
                txtSoLuongChenhLech.Attributes.Add("data-field", "SoLuongChenhLechKhongTinh");
                txtThanhTien.Attributes.Add("data-field", "ThanhTien");
                txtGhiChu.Attributes.Add("data-field", "GhiChu");
            }
            if (Attributes["param"] != null)
            {
                string URL = Attributes["param"];
                ID_VatTu = Util.GetParam(URL, "id");
                if (ID_VatTu != "")
                {
                }
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
    }
}