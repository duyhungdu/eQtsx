using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPRepository;
using xRPDAL;

namespace xRP.Business.QuanLySanXuat.TaoLenhSanXuat
{
    public partial class CanhBaoVatTu : System.Web.UI.UserControl
    {
        xRPDataContext dataContext = new xRPDataContext();
        public string ID_YEUCAUSANXUAT = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            int yeucausanxuatID = 0;
            if (Attributes["param"] != null)
            {
                string URL = Attributes["param"];
                yeucausanxuatID = int.Parse(Util.GetParam(URL, "id"));
                ID_YEUCAUSANXUAT = yeucausanxuatID.ToString();
            }
            try
            {
                BindData(yeucausanxuatID);
            }
            catch
            { }
        }
        protected void BindData(int id)
        {
            var yeucausanxuat = dataContext.Sp_Qlsx_YeuCauSanXuat_Select(1, id, null, null, null, null, null, null).FirstOrDefault();
            if (yeucausanxuat != null)
            {


                txtMaHang.Text = yeucausanxuat.MaHieuMatHang;
                txtTenHang.Text = yeucausanxuat.TenMatHang;
                txtDonHang.Text = yeucausanxuat.MaHieuDonHang + " - " + yeucausanxuat.TenKhachHang;
                txtNgayDat.Text = yeucausanxuat.NgayDatHang != null ? yeucausanxuat.NgayDatHang.Value.ToString("dd/MM/yyyy") : "";
                txtNgayGiaoHang.Text = yeucausanxuat.NgayGiaoHang != null ? yeucausanxuat.NgayGiaoHang.Value.ToString("dd/MM/yyyy") : "";
                txtLoaiSanPham.Text = yeucausanxuat.TenLoaiSanPham;
                txtSoLuongDat.Text = Util.FormatMoney4(yeucausanxuat.SoLuong);
                txtLoaiKichThuoc.Text = yeucausanxuat.LoaiKichThuoc;
                txtKichThuoc.Text = Util.FormatMoney4(yeucausanxuat.ChieuDai) + " x " + Util.FormatMoney4(yeucausanxuat.ChieuRong) + " x " + Util.FormatMoney4(yeucausanxuat.ChieuCao);

                //Thong tin xu lý
                txtLoaiSong.Text = yeucausanxuat.KiHieuCoCauGiay.ToString() + " - " + yeucausanxuat.MoTaCoCauGiay;
                txtSoLop.Text = yeucausanxuat.SoLop.ToString();
                txtTongDao.Text = Util.FormatMoney3(yeucausanxuat.TongDao);
                txtChatDai.Text = Util.FormatMoney4(yeucausanxuat.ChatDai);
                txtTai.Text = yeucausanxuat.Tai.ToString();
                txtLe.Text = yeucausanxuat.Le.ToString();
                txtKhoGiay.Text = Util.FormatMoney6(yeucausanxuat.KhoGiay);
                try
                {
                    string ktttam = yeucausanxuat.KTTam;
                    string[] a = ktttam.Trim().Split('x');
                    if (a.Length == 2)
                    {
                        txtKichThuocTam.Text = Util.FormatMoney7(int.Parse(a[0])) + " x " + Util.FormatMoney7(int.Parse(a[1]));
                    }
                }
                catch
                {
                    txtKichThuocTam.Text = yeucausanxuat.KTTam;
                }

                txtSoLuongTam.Text = Util.FormatMoney3(yeucausanxuat.SoLuongTam);
                txtSoLuongHop.Text = Util.FormatMoney3(yeucausanxuat.SoLuongHop);
                txtDienTichXuatBan.Text = yeucausanxuat.DienTichXuatBan != null ? Math.Round(yeucausanxuat.DienTichXuatBan.Value, 2).ToString() : "";
                txtSoLuongSanXuat.Text = Util.FormatMoney3(yeucausanxuat.SoLuongCanSanXuat);
            }

            List<Sp_Qlsx_PhuongAnSanXuat_SelectResult> list = new List<Sp_Qlsx_PhuongAnSanXuat_SelectResult>();
            list = dataContext.Sp_Qlsx_PhuongAnSanXuat_Select(id,0).ToList();
            rptPhuongAnSanXuat.DataSource = list;
            rptPhuongAnSanXuat.DataBind();

            List<Sp_Qlsx_PhuongAnSanXuat_Select_2Result> list2 = new List<Sp_Qlsx_PhuongAnSanXuat_Select_2Result>();
            list2 = dataContext.Sp_Qlsx_PhuongAnSanXuat_Select_2(id,0).ToList();
            rptPAVT2.DataSource = list2;
            rptPAVT2.DataBind();

        }
    }
}