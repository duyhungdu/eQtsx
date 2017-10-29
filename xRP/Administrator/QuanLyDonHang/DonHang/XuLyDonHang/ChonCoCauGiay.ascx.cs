using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;

namespace xRP.Administrator.QuanLyDonHang.DonHang.XuLyDonHang
{
    public partial class ChonCoCauGiay : System.Web.UI.UserControl
    {
        public Sp_Qldh_MatHang_SelectResult matHang;
        public string MaLoaiKichThuoc = "";
        public double HeSoChatDai = 0, HeSoTongDao = 0;
        xRPDataContext dts = new xRPDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                txtSoLuongHop.Attributes.Add("data-field", "SoLuongHop");
                txtHeSoTongGiao.Attributes.Add("data-field", "HeSoTongDao");
                txtTongGiao.Attributes.Add("data-field", "TongDao");
                txtHeSoChatDai.Attributes.Add("data-field", "HeSoChatDai");
                txtChatDai.Attributes.Add("data-field", "ChatDai");
                txtXa.Attributes.Add("data-field", "Xa");
                txtSoLuongTam.Attributes.Add("data-field", "SoLuongTam");
                txtTai.Attributes.Add("data-field", "Tai");
                txtLe.Attributes.Add("data-field", "Le");
                txtKhoGiay.Attributes.Add("data-field", "KhoGiay");
                dropLoaiSong.Attributes.Add("data-field", "LoaiSongSanXuat");
                dropLoaiHop.DataSource = dts.Qldh_LoaiSanPhams;
                dropLoaiHop.DataTextField = "TenLoaiSanPham";
                dropLoaiHop.DataValueField = "ID";
                dropLoaiHop.DataBind();

                dropLoaiKichThuoc.DataSource = dts.Qldh_LoaiKichThuocs;
                dropLoaiKichThuoc.DataTextField = "LoaiKichThuoc";
                dropLoaiKichThuoc.DataValueField = "ID";
                dropLoaiKichThuoc.DataBind();
            }
            if (!string.IsNullOrEmpty(Request.Params["mathangid"]))
            {
                int temp = 0;
                if (int.TryParse(Request.Params["mathangid"], out temp))
                {
                    matHang = dts.Sp_Qldh_MatHang_Select(1, temp, (int?)null, 0, 1, "").FirstOrDefault();

                    if (matHang == null)
                        matHang = new Sp_Qldh_MatHang_SelectResult();
                    BindData();
                }
            }
        }
        private void BindData()
        {
            txtTenHang.Text = matHang.TenMatHang;
            //txtSoLuongHop.Text = 
            txtSoLuong.Text = matHang.SoLuong.HasValue ? matHang.SoLuong.Value.ToString() : "";
            txtSoLop.Text = matHang.SoLop.HasValue ? matHang.SoLop.Value.ToString() : "";
            txtSong.Text = matHang.TenSong;
            txtChieuDai.Text = matHang.ChieuDai.HasValue ? matHang.ChieuDai.Value.ToString() : "";
            txtChieuRong.Text = matHang.ChieuRong.HasValue ? matHang.ChieuRong.Value.ToString() : "";
            txtChieuCao.Text = matHang.ChieuCao.HasValue ? matHang.ChieuCao.Value.ToString() : "";
            dropLoaiHop.SelectedValue = matHang.IDLoaiSanPham.HasValue ? matHang.IDLoaiSanPham.Value.ToString() : "";
            dropLoaiKichThuoc.SelectedValue = matHang.IDLoaiKichThuoc.HasValue ? matHang.IDLoaiKichThuoc.Value.ToString() : "";
            int solop = matHang.SoLop.HasValue ? matHang.SoLop.Value : 0;

            

            dropLoaiSong.DataSource = (from t in dts.Sp_Qlsx_PhanLoaiSong_Select(0, (int?)null, null, 0, true, null)
                                       where t.SoLop == matHang.SoLop
                                       select new
                                       {
                                           ID = t.ID,
                                           MoTaCoCauGiay = t.KiHieuCoCauGiay.Trim() + "-" + t.MoTaCoCauGiay
                                       });
            dropLoaiSong.DataTextField = "MoTaCoCauGiay";
            dropLoaiSong.DataValueField = "ID";
            dropLoaiSong.DataBind();

            if (matHang.IDLoaiKichThuoc.HasValue)
            {
                var loaiKT = dts.Sp_Qldh_LoaiKichThuoc_Select(1, matHang.IDLoaiKichThuoc.Value, (int?)null, (int?)null, "").FirstOrDefault();
                MaLoaiKichThuoc = loaiKT == null ? "" : loaiKT.MaHieuKichThuoc.ToUpper().Trim();
                if (loaiKT != null && loaiKT.HeSoChatDai.HasValue)
                {
                    this.HeSoChatDai = loaiKT.HeSoChatDai.Value;
                }
            }
            var x = (from t in dts.Sp_Qldh_HeSoTongDao_Select(0, (int?)null, (int?)null, (int?)null, "") where t.IDLoaiKichThuoc == matHang.IDLoaiKichThuoc && t.SoLop == matHang.SoLop select t).FirstOrDefault();
            HeSoTongDao = x == null || !x.HeSoTongDao.HasValue ? 0 : x.HeSoTongDao.Value;
            
        }
    }
}