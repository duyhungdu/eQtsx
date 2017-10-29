using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;

namespace xRP.Administrator.QuanLyDonHang.DonHang
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string page = "";
            if (Request.QueryString["page"] != null)
            {
                page = Request.QueryString["page"];
                switch (page)
                {
                    case "dsdonhang": LoadDanhSachDonHang(); break;
                    case "addoreditdonhang": AddOrEditDonHang(); break;
                }
            }
        }
        protected void LoadXuLyDonHang()
        {
            Administrator.QuanLyDonHang.DonHang.XuLyDonHang.XuLyDonHang xulydonhang = (Administrator.QuanLyDonHang.DonHang.XuLyDonHang.XuLyDonHang)this.Page.LoadControl("~/Administrator/QuanLyDonHang/DonHang/XuLyDonHang/XuLyDonHang.ascx");
            plcContent.Controls.Add(xulydonhang);
        }
        protected void LoadDanhSachDonHang()
        {
            Administrator.QuanLyDonHang.DonHang.DanhMucDonHang danhDonHang = (Administrator.QuanLyDonHang.DonHang.DanhMucDonHang)this.Page.LoadControl("~/Administrator/QuanLyDonHang/DonHang/DanhMucDonHang.ascx");
            plcContent.Controls.Add(danhDonHang);
        }
        protected void AddOrEditDonHang()
        {
            Administrator.QuanLyDonHang.DonHang.AddOrEditDonHang danhDonHang = (Administrator.QuanLyDonHang.DonHang.AddOrEditDonHang)this.Page.LoadControl("~/Administrator/QuanLyDonHang/DonHang/AddOrEditDonHang.ascx");
            plcContent.Controls.Add(danhDonHang);
        }
        protected void LoadCongDoanSanXuat()
        {
            Administrator.QuanLyDonHang.DonHang.XuLyDonHang.CongDoanSanXuatGiay congdoansanxuat = (Administrator.QuanLyDonHang.DonHang.XuLyDonHang.CongDoanSanXuatGiay)this.Page.LoadControl("~/Administrator/QuanLyDonHang/DonHang/XuLyDonHang/CongDoanSanXuatGiay.ascx");
            plcContent.Controls.Add(congdoansanxuat);
        }
        protected void ChonCoCauGiay()
        {
            Administrator.QuanLyDonHang.DonHang.XuLyDonHang.ChonCoCauGiay choncocaugiay = (Administrator.QuanLyDonHang.DonHang.XuLyDonHang.ChonCoCauGiay)this.Page.LoadControl("~/Administrator/QuanLyDonHang/DonHang/XuLyDonHang/ChonCoCauGiay.ascx");
            plcContent.Controls.Add(choncocaugiay);
        }
        protected void DinhMucVatTu()
        {
            Administrator.QuanLyDonHang.DonHang.XuLyDonHang.DinhMucVatTu dinhmucvattu = (Administrator.QuanLyDonHang.DonHang.XuLyDonHang.DinhMucVatTu)this.Page.LoadControl("~/Administrator/QuanLyDonHang/DonHang/XuLyDonHang/DinhMucVatTu.ascx");
            plcContent.Controls.Add(dinhmucvattu);
        }
        /// <summary>
        /// Thêm mới hoặc sửa đơn hàng
        /// </summary>
        /// <param name="itemID"></param>
        /// <param name="maKhachHang"></param>
        /// <param name="maDonHang"></param>
        /// <param name="ngayDatHang"></param>
        /// <param name="ngayGiaoHang"></param>
        /// <param name="tinhTrang"></param>
        /// <param name="ghiChu"></param>
        /// <returns></returns>
        [WebMethod]
        public static string AddOrUpdateDonHang(int ID, int MaHieuKhachHang, string MaHieuDonHang,
            string NgayDatHang, string NgayGiaoHang, int TinhTrang, string GhiChu)
        {
            string returnMessage = "";

            try
            {
                DateTime dtNgayDatHang = DateTime.ParseExact(NgayDatHang, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                DateTime dtNgayGiaoHang = DateTime.ParseExact(NgayGiaoHang, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                xRPDataContext dts = new xRPDataContext();
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                int? id = ID;
                if (ID == 0)
                    returnMessage = dts.Sp_Qldh_DonHang_Add_Edit_Deli("ADD", (int?)null, MaHieuKhachHang, dts.fc_SinhMa("MADONHANG", "*"), dtNgayDatHang, dtNgayGiaoHang, TinhTrang, GhiChu,"", user.UserId, user.UserId, ref id, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                else
                    returnMessage = dts.Sp_Qldh_DonHang_Add_Edit_Deli("EDIT", ID, MaHieuKhachHang, MaHieuDonHang, dtNgayDatHang, dtNgayGiaoHang, TinhTrang, GhiChu, "", user.UserId, user.UserId, ref id, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                dts.Dispose();
                if (!string.IsNullOrEmpty(returnMessage))
                    return returnMessage;
                return id.HasValue ? id.Value.ToString() : "";
            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message;
            }
        }
        [WebMethod]
        public static string XoaDonHang(int ID)
        {
            try
            {
                xRPDataContext dts = new xRPDataContext();

                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();

                var result = dts.Sp_Qldh_DonHang_Deli("DEL1", ID, user.UserId, "", "").FirstOrDefault();
                if (result != null && !string.IsNullOrEmpty(result.Column1)) return result.Column1;
                return "";
            }
            catch (Exception)
            {
                return "ERROR";
            }
        }

        [WebMethod]
        public static string HuyXuLyDonHang(int ID)
        {
            try
            {
                xRPDataContext dts = new xRPDataContext();

                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();

                var result = dts.Sp_Qldh_DonHang_Huy_XuLy(ID, user.UserId, Util.GetServerName(), Util.GetIP()).FirstOrDefault();
                if (result != null && !string.IsNullOrEmpty(result.Column1)) return result.Column1;
                return "";
            }
            catch (Exception)
            {
                return "ERROR";
            }
        }
        [WebMethod]
        public static string HuyXuLyMatHang(int ID)
        {
            try
            {
                xRPDataContext dts = new xRPDataContext();

                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();

                var result = dts.Sp_Qldh_MatHang_Huy_XuLy(ID, user.UserId, Util.GetServerName(), Util.GetIP()).FirstOrDefault();
                if (result != null && !string.IsNullOrEmpty(result.Column1)) return result.Column1;
                return "";
            }
            catch (Exception)
            {
                return "ERROR";
            }
        }

        [WebMethod]
        public static string GetHangHoa(int IDDonHang)
        {
            List<xRPDAL.Sp_Qldh_MatHang_SelectResult> hh = new xRPDataContext().Sp_Qldh_MatHang_Select(2, (int?)null, IDDonHang, 0, (int?)null, "").ToList();
            hh = hh.OrderBy(t => t.NgayTao).ToList();
            string data = new JavaScriptSerializer().Serialize(hh);
            return data;
        }
        /// <summary>
        /// Hàm lấy về các công đoạn sản xuất của mặt hàng
        /// </summary>
        /// <param name="IDDonHang"></param>
        /// <author>phamkhuong102</author>
        /// <date>2015-01-13</date>
        /// <returns></returns>


        [WebMethod]
        public static string AddOrUpdateChiTietDonHang(int ID, string MaHieuMatHang, string MaHangTheoDon, int IDDonHang, string TenMatHang, string NgayGiaoHang,
            float SoLuong, int IDDonViTinh, int SoLuongMau, string MauSacMatNgoai, float ChieuDai, float ChieuRong, float ChieuCao, int IDLoaiKichThuoc,
            int IDLoaiSanPham, int SoLop, int? TongDao, double? ChatDai, double? Xa, int? IDLoaiGiay, float KhoGiay, double DinhLuong, int? LoaiSongSanXuat,
            int? LoaiSongXuatBan, double Tai, double Le, int? SoLuongTam, int? SoLuongHop, float DienTichSanXuat, float DienTichXuatBan, int CongDoanCuoi,
            int DonGia, float ThanhTien, string GhiChu, int[] DSLoaiSong)
        {
            string returnMessage = "";

            try
            {

                xRPDataContext dts = new xRPDataContext();
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                int? id = ID;
                DateTime dtNgayGiaoHang = DateTime.ParseExact(NgayGiaoHang, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                if (ID == 0)
                    returnMessage = dts.Sp_Qldh_MatHang_Add_Edit_Deli("ADD", (int?)null, MaHieuMatHang, IDDonHang, TenMatHang, dtNgayGiaoHang, SoLuong, IDDonViTinh,
                        SoLuongMau, MauSacMatNgoai, ChieuDai, ChieuRong, ChieuCao, IDLoaiKichThuoc, IDLoaiSanPham, SoLop, TongDao,
                        ChatDai, Xa, null, KhoGiay, DinhLuong, LoaiSongSanXuat, LoaiSongXuatBan, Tai, Le, SoLuongTam, SoLuongHop,
                        DienTichSanXuat, DienTichXuatBan, CongDoanCuoi, DonGia, ThanhTien,
                        GhiChu, MaHangTheoDon, 0, user.UserId, user.UserId, ref id, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                else
                    returnMessage = dts.Sp_Qldh_MatHang_Add_Edit_Deli("EDIT", ID, MaHieuMatHang, IDDonHang, TenMatHang, dtNgayGiaoHang, SoLuong, IDDonViTinh,
                        SoLuongMau, MauSacMatNgoai, ChieuDai, ChieuRong, ChieuCao, IDLoaiKichThuoc, IDLoaiSanPham, SoLop, TongDao,
                        ChatDai, Xa, null, KhoGiay, DinhLuong, LoaiSongSanXuat, LoaiSongXuatBan, Tai, Le, SoLuongTam, SoLuongHop,
                        DienTichSanXuat, DienTichXuatBan, CongDoanCuoi, DonGia, ThanhTien,
                        GhiChu, MaHangTheoDon, 0, user.UserId, user.UserId, ref id, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                if (id.HasValue && id.Value > 0)
                {
                    int? idsong = 0;
                    var delList = dts.Sp_Qldh_MatHangTheoSong_Select(0, (int?)null, 0, 1).Where(t => t.IDMatHang == id.Value && !DSLoaiSong.Contains(t.IDSong.Value));
                    foreach (var ls in delList)
                    {
                        dts.Sp_Qldh_MatHangTheoSong_Deli("DEL0", ls.ID, user.UserId, Util.GetIP(), Util.GetPCName());
                    }
                    foreach (int ls in DSLoaiSong)
                    {
                        var y = dts.Sp_Qldh_MatHangTheoSong_Select(0, (int?)null, 0, 1).Where(t => t.IDMatHang.Value == id.Value && t.IDSong.Value == ls).FirstOrDefault();
                        if (y == null)
                            dts.Sp_Qldh_MatHangTheoSong_Add_Edit_Deli("ADD", (int?)null, id.Value, ls, user.UserId, user.UserId, ref idsong, Util.GetIP(), Util.GetPCName());
                        else
                            dts.Sp_Qldh_MatHangTheoSong_Add_Edit_Deli("EDIT", y.ID, id.Value, ls, y.MaNguoiTao.Value, user.UserId, ref idsong, Util.GetIP(), Util.GetPCName());
                    }
                }
                dts.Dispose();
                if (!string.IsNullOrEmpty(returnMessage))
                    return returnMessage;
            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message;
            }
            return "SUCCESS";
        }

        [WebMethod]
        public static string DeleteHangHoa(int ID)
        {
            try
            {
                xRPDataContext dts = new xRPDataContext();
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                var result = dts.Sp_Qldh_MatHang_Deli("DEL1", ID, user.UserId, "", "").FirstOrDefault();
                if (result != null && !string.IsNullOrEmpty(result.Column1)) return result.Column1;
                return "SUCCESS";
            }
            catch (Exception)
            {
                return "ERROR";
            }
        }
    }

}