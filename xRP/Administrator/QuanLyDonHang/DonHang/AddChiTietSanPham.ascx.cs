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
    public partial class AddChiTietSanPham : System.Web.UI.UserControl
    {
        protected xRPDataContext dts = new xRPDataContext();
        public string ID_HangHoa { set; get; }
        protected string DataHangHoa = "{}";
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                txtMaHang.Attributes.Add("data-field", "MaHieuMatHang");
                txtMaHangTheoDon.Attributes.Add("data-field", "MaHangTheoDon");
                txtDonViTinh.Attributes.Add("data-field", "DonViTinh");
                txtTenHang.Attributes.Add("data-field", "TenMatHang");
                txtSoLuong.Attributes.Add("data-field", "SoLuong");
                txtChieuDai.Attributes.Add("data-field", "ChieuDai");
                txtChieuRong.Attributes.Add("data-field", "ChieuRong");
                txtChieuCao.Attributes.Add("data-field", "ChieuCao");
                txtTai.Attributes.Add("data-field", "Tai");
                txtLe.Attributes.Add("data-field", "Le");
                dropLoaiKichThuoc.Attributes.Add("data-field", "LoaiKichThuoc");
                dropLoaiThung.Attributes.Add("data-field", "TenLoaiSanPham");
                txtSoLuongMau.Attributes.Add("data-field", "SoLuongMau");
                txtMauSacMatNgoai.Attributes.Add("data-field", "MauSacMatNgoai");
                txtSoLop.Attributes.Add("data-field", "SoLop");
                //DropLoaiGiay.Attributes.Add("data-field", "LoaiGiay");
                txtKhoGiay.Attributes.Add("data-field", "KhoGiay");
                txtDinhLuong.Attributes.Add("data-field", "DinhLuong");
                txtDienTichSanPham.Attributes.Add("data-field", "DienTichSanXuat");
                dropCongDoanKetThuc.Attributes.Add("data-field", "CongDoanCuoi");
                txtDonGia.Attributes.Add("data-field", "DonGia");
                txtThanhTien.Attributes.Add("data-field", "ThanhTien");
                txtGhiChu.Attributes.Add("data-field", "GhiChu");
                dropLoaiKichThuoc.DataSource = dts.Sp_Qldh_LoaiKichThuoc_Select(0, (int?)null, 0, 1,"");
                dropLoaiKichThuoc.DataTextField = "LoaiKichThuoc";
                dropLoaiKichThuoc.DataValueField = "ID";
                dropLoaiKichThuoc.DataBind();

                dropLoaiThung.DataSource = dts.Sp_Qldh_LoaiSanPham_Select(0, (int?)null, 0, 1, "");
                dropLoaiThung.DataTextField = "TenLoaiSanPham";
                dropLoaiThung.DataValueField = "ID";
                dropLoaiThung.DataBind();
                cblLoaiSong.DataSource =  dts.Sp_Qldh_DanhMucSong_Select(0, (int?)null, 0, 1, "");
                cblLoaiSong.DataTextField = "TenSong";
                cblLoaiSong.DataValueField = "ID";
                cblLoaiSong.DataBind();

                dropCongDoanKetThuc.DataSource = dts.Sp_Qlsx_CongDoan_Select(0, (int?)null, 0, null,"");
                dropCongDoanKetThuc.DataTextField = "TenCongDoan";
                dropCongDoanKetThuc.DataValueField = "ID";
                dropCongDoanKetThuc.DataBind();
 
            }

            if (Attributes["param"] != null)
            {
                string URL = Attributes["param"];
                ID_HangHoa = Util.GetParam(URL, "id");
            }
            
        }
    }
}