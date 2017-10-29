using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;
using xRPRepository;

namespace xRP.Administrator.QuanLyDonHang
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

                    #region danh mục sóng
                    case "dmsong": LoadDanhSachSong(); break;
                    #endregion danh mục sóng
                    #region Danh mục nhóm khách hàng
                    case "dmnkh": LoadDanhSachNhomKhachHang(); break;
                    #endregion Danh mục nhóm khách hàng
                    #region danh mục loại sản phẩm
                    case "dmlsp": LoadDanhSachLoaiSanPham(); break;
                    #endregion loại sản phẩm
                    #region danh mục kích thước
                    case "dmkt": LoadDanhSachKichThuoc(); break;
                    #endregion danh mục kích thước
                    #region danh mục khách hàng
                    case "dmkh": LoadDanhSachKhachHang(); break;
                    #endregion danh mục khách hàng
                    #region danh mục hệ số tổng giao
                    case "hstg": LoadDanhSachHeSoTongGiao(); break;
                    #endregion danh mục hệ số tổng giao
                    #region in phiếu đặt hàng
                    case "ppdathhang": LoadPhieuDatHang(); break;
                    #endregion in phiếu đặt hàng
                    #region báo cáo sản xuất giao hàng
                    case "bcghsx": LoadBaoCaoSanXuatGiaoHang(); break;
                    case "bcghsx2": LoadBaoCaoSanXuatGiaoHang2(); break;
                    #endregion báo cáo sản xuất giao hàng
                    #region in phiếu đặt hàng
                    case "dsmathang": LoadDanhSachMatHang(); break;
                    #endregion in phiếu đặt hàng
                }
            }
        }

        #region danh mục sóng
        protected void LoadDanhSachSong()
        {
            Administrator.QuanLyDonHang.Song.DanhMucSong danhmucsong = (Administrator.QuanLyDonHang.Song.DanhMucSong)this.Page.LoadControl("~/Administrator/QuanLyDonHang/Song/DanhMucSong.ascx");
            plcContent.Controls.Add(danhmucsong);
        }
        #endregion danh mục sóng
        #region danh mục nhóm khách hàng
        protected void LoadDanhSachNhomKhachHang()
        {
            Administrator.QuanLyDonHang.NhomKhachHang.DanhMucNhomKhachHang danhmucnhomkhachhang = (Administrator.QuanLyDonHang.NhomKhachHang.DanhMucNhomKhachHang)this.Page.LoadControl("~/Administrator/QuanLyDonHang/NhomKhachHang/DanhMucNhomKhachHang.ascx");
            plcContent.Controls.Add(danhmucnhomkhachhang);
        }
        #endregion danh mục nhóm khách hàng
        #region danh mục loại sản phẩm
        protected void LoadDanhSachLoaiSanPham()
        {
            Administrator.QuanLyDonHang.LoaiSanPham.DanhMucLoaiSanPham danhmucloaisanpham = (Administrator.QuanLyDonHang.LoaiSanPham.DanhMucLoaiSanPham)this.Page.LoadControl("~/Administrator/QuanLyDonHang/LoaiSanPham/DanhMucLoaiSanPham.ascx");
            plcContent.Controls.Add(danhmucloaisanpham);
        }
        #endregion  danh mục loại sản phẩm
        #region danh mục kích thước
        protected void LoadDanhSachKichThuoc()
        {
            Administrator.QuanLyDonHang.KichThuoc.DanhMucKichThuoc danhmuckichthuoc = (Administrator.QuanLyDonHang.KichThuoc.DanhMucKichThuoc)this.Page.LoadControl("~/Administrator/QuanLyDonHang/KichThuoc/DanhMucKichThuoc.ascx");
            plcContent.Controls.Add(danhmuckichthuoc);
        }

        protected void LoadDanhSachMatHang()
        {
            Administrator.QuanLyDonHang.MatHang.DanhSachMatHang DanhSachMatHang = (Administrator.QuanLyDonHang.MatHang.DanhSachMatHang)this.Page.LoadControl("~/Administrator/QuanLyDonHang/MatHang/DanhSachMatHang.ascx");
            plcContent.Controls.Add(DanhSachMatHang);
        }
        #endregion danh mục kích thước
        #region danh mục khách hàng
        protected void LoadDanhSachKhachHang()
        {
            Administrator.QuanLyDonHang.KhachHang.DanhMucKhachHang danhmuckhachhang = (Administrator.QuanLyDonHang.KhachHang.DanhMucKhachHang)this.Page.LoadControl("~/Administrator/QuanLyDonHang/KhachHang/DanhMucKhachHang.ascx");
            plcContent.Controls.Add(danhmuckhachhang);
        }
        #endregion danh mục khách hàng
        #region danh mục hệ số tổng giao
        protected void LoadDanhSachHeSoTongGiao()
        {
            Administrator.QuanLyDonHang.HeSoTongGiao.DanhMucHeSoTongGiao danhmuchesotonggiao = (Administrator.QuanLyDonHang.HeSoTongGiao.DanhMucHeSoTongGiao)this.Page.LoadControl("~/Administrator/QuanLyDonHang/HeSoTongGiao/DanhMucHeSoTongGiao.ascx");
            plcContent.Controls.Add(danhmuchesotonggiao);
        }
        #endregion hệ số tổng giao
        #region in phiếu đặt hàng
        protected void LoadPhieuDatHang()
        {
            //Report.ReportViewer reportViewDatHang = (Report.ReportViewer)this.Page.LoadControl("~/Report/ReportViewer.ascx");
            Report.XtraReportViewer reportViewDatHang = (Report.XtraReportViewer)this.Page.LoadControl("~/Report/XtraReportViewer.ascx");
            plcContent.Controls.Add(reportViewDatHang);
        }
        protected void LoadBaoCaoSanXuatGiaoHang()
        {
            Report.ReportViewer reportSanXuatGiaoHang = (Report.ReportViewer)this.Page.LoadControl("~/Report/ReportViewer.ascx");
            plcContent.Controls.Add(reportSanXuatGiaoHang);
        }
        protected void LoadBaoCaoSanXuatGiaoHang2()
        {
            Report.XtraReportViewer reportSanXuatGiaoHang = (Report.XtraReportViewer)this.Page.LoadControl("~/Report/XtraReportViewer.ascx");
            plcContent.Controls.Add(reportSanXuatGiaoHang);
        }

        #endregion in phiếu đặt hàng
        #region Hàm Thêm - Sửa khách hàng
        [WebMethod]
        public static string ThemKhachHang(string id, string maKhachHang, string tenKhachHang, string idNhomKhachHang,
            string diaChi, string dienthoaiLienHe, string fax, string email, string thongtinLienHe,
            string kichHoat, string ghiChu)
        {
            Guid currentUserID = Guid.NewGuid();
            string currentUser = "";
            #region Get current User
            MembershipUser membershipUser = Membership.GetUser(HttpContext.Current.User.Identity.Name);
            if (membershipUser != null)
            {
                currentUser = membershipUser.UserName;
                currentUserID = (Guid)membershipUser.ProviderUserKey;
            }
            #endregion get current User


            try
            {
                int? idd = int.Parse(id) == 0 || int.Parse(id) == -1 ? (int?)null : int.Parse(id);
                bool KichHoat = false;
                if (kichHoat == "1")
                {
                    KichHoat = true;
                }
                if (kichHoat == "0")
                {
                    KichHoat = false;
                }
                Qldh_KhachHangReposity khachhangReposity = new Qldh_KhachHangReposity();
                string return_message = "";
                if (int.Parse(id) == -1)
                {
                    return_message = khachhangReposity.ThemHoacSuaKhachHang("ADD", int.Parse(id), maKhachHang, tenKhachHang, int.Parse(idNhomKhachHang), diaChi, dienthoaiLienHe, fax, email, thongtinLienHe, KichHoat, ghiChu, currentUserID, idd, Util.GetIP(), Util.GetPCName());
                }
                if (int.Parse(id) > 0)
                {
                    return_message = khachhangReposity.ThemHoacSuaKhachHang("EDIT", int.Parse(id), maKhachHang, tenKhachHang, int.Parse(idNhomKhachHang), diaChi, dienthoaiLienHe, fax, email, thongtinLienHe, KichHoat, ghiChu, currentUserID, idd, Util.GetIP(), Util.GetPCName());
                }
                if (!string.IsNullOrEmpty(return_message))
                {
                    return return_message;
                }
            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message + ex.StackTrace;
            }
            return "SUCCESS";

        }
        #endregion Kết thúc Hàm Thêm mới - Sửa khách hàng
        #region Hàm Xóa khách hàng
        [WebMethod]
        public static string XoaKhachHang(int id)
        {
            try
            {
                Guid currentUserID = Guid.NewGuid();
                string currentUser = "";
                #region Get current User
                MembershipUser membershipUser = Membership.GetUser(HttpContext.Current.User.Identity.Name);
                if (membershipUser != null)
                {
                    currentUser = membershipUser.UserName;
                    currentUserID = (Guid)membershipUser.ProviderUserKey;
                }
                #endregion get current User
                //Initial data context variable, this class is declared in .dbml file in xRPDAL namespace
                Qldh_KhachHangReposity khachhangReposity = new Qldh_KhachHangReposity();

                khachhangReposity.XoaKhachHang(id, currentUserID, Util.GetIP(), Util.GetPCName());
            }
            catch (Exception)
            {
                return "ERROR";
            }
            return "SUCCESS";
        }
        #endregion Kết thúc hàm xóa khách hàng
        #region Hàm thêm - sửa sóng
        [WebMethod]
        public static string ThemSong(string id, string tenSong, string heSoTieuHao, string kichHoat, string ghiChu)
        {
            if (string.IsNullOrWhiteSpace(heSoTieuHao)) heSoTieuHao = "1";

            Guid currentUserID = Guid.NewGuid();
            string currentUser = "";
            #region Get current User
            MembershipUser membershipUser = Membership.GetUser(HttpContext.Current.User.Identity.Name);
            if (membershipUser != null)
            {
                currentUser = membershipUser.UserName;
                currentUserID = (Guid)membershipUser.ProviderUserKey;
            }
            #endregion get current User

            xRPDataContext dataContext = new xRPDataContext();
            Qldh_DanhMucSong qlvt = new Qldh_DanhMucSong();
            try
            {
                int? idd = int.Parse(id) == 0 || int.Parse(id) == -1 ? (int?)null : int.Parse(id);
                bool KichHoat = false;
                if (kichHoat == "1")
                {
                    KichHoat = true;
                }
                if (kichHoat == "0")
                {
                    KichHoat = false;
                }
                string result = null;
                if (int.Parse(id) == -1)
                {
                    result = dataContext.Sp_Qldh_DanhMucSong_Add_Edit_Deli("ADD", int.Parse(id), tenSong, double.Parse(heSoTieuHao), ghiChu, KichHoat, currentUserID, currentUserID, ref idd, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                }
                if (int.Parse(id) > 0)
                {
                    result = dataContext.Sp_Qldh_DanhMucSong_Add_Edit_Deli("EDIT", int.Parse(id), tenSong, double.Parse(heSoTieuHao), ghiChu, KichHoat, currentUserID, currentUserID, ref idd, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                }
                if (!string.IsNullOrEmpty(result))
                    return result;
            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message;
            }
            return "SUCCESS";

        }
        #endregion Kết thúc thêm - sửa sóng
        #region Hàm Xóa sóng
        [WebMethod]
        public static string XoaSong(int id)
        {
            try
            {
                Guid currentUserID = Guid.NewGuid();
                string currentUser = "";
                #region Get current User
                MembershipUser membershipUser = Membership.GetUser(HttpContext.Current.User.Identity.Name);
                if (membershipUser != null)
                {
                    currentUser = membershipUser.UserName;
                    currentUserID = (Guid)membershipUser.ProviderUserKey;
                }
                #endregion get current User
                //Initial data context variable, this class is declared in .dbml file in xRPDAL namespace
                xRPDataContext dts = new xRPDataContext();

                var result = dts.Sp_Qldh_DanhMucSong_Deli("DEL1", id, currentUserID, Util.GetIP(), Util.GetPCName());
            }
            catch (Exception)
            {
                return "ERROR";
            }
            return "SUCCESS";
        }
        #endregion Kết thúc hàm xóa sóng
        #region Hàm thêm - sửa nhóm khách hàng
        [WebMethod]
        public static string ThemNhomKhachHang(string id, string tenNhomKhachHang, string ghiChu, string kichHoat)
        {
            Guid currentUserID = Guid.NewGuid();
            string currentUser = "";
            #region Get current User
            MembershipUser membershipUser = Membership.GetUser(HttpContext.Current.User.Identity.Name);
            if (membershipUser != null)
            {
                currentUser = membershipUser.UserName;
                currentUserID = (Guid)membershipUser.ProviderUserKey;
            }
            #endregion get current User

            xRPDataContext tinhChatXuatNhap = new xRPDataContext();
            Qldh_NhomKhachHang qlvt = new Qldh_NhomKhachHang();
            bool KichHoat = false;
            if (kichHoat == "1")
            {
                KichHoat = true;
            }
            if (kichHoat == "0")
            {
                KichHoat = false;
            }
            try
            {
                int? idd = int.Parse(id) == 0 || int.Parse(id) == -1 ? (int?)null : int.Parse(id);
                string result = "";
                if (int.Parse(id) == -1)
                {
                    result = tinhChatXuatNhap.Sp_Qldh_NhomKhachHang_Add_Edit_Deli("ADD", int.Parse(id), tenNhomKhachHang, ghiChu, KichHoat, currentUserID, currentUserID, ref idd, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                }
                if (int.Parse(id) > 0)
                {
                    result = tinhChatXuatNhap.Sp_Qldh_NhomKhachHang_Add_Edit_Deli("EDIT", int.Parse(id), tenNhomKhachHang, ghiChu, KichHoat, currentUserID, currentUserID, ref idd, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                }
                if (!string.IsNullOrEmpty(result))
                {
                    return result;
                }
            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message + ex.StackTrace;
            }
            return "SUCCESS";

        }
        #endregion Kết thúc hàm thêm - sửa nhóm khách hàng
        #region Hàm xóa nhóm khách hàng
        [WebMethod]
        public static string XoaNhomKhachHang(int id)
        {
            try
            {
                Guid currentUserID = Guid.NewGuid();
                string currentUser = "";
                #region Get current User
                MembershipUser membershipUser = Membership.GetUser(HttpContext.Current.User.Identity.Name);
                if (membershipUser != null)
                {
                    currentUser = membershipUser.UserName;
                    currentUserID = (Guid)membershipUser.ProviderUserKey;
                }
                #endregion get current User
                //Initial data context variable, this class is declared in .dbml file in xRPDAL namespace
                xRPDataContext dts = new xRPDataContext();

                var result = dts.Sp_Qldh_NhomKhachHang_Deli("DEL1", id, currentUserID, Util.GetIP(), Util.GetPCName());
            }
            catch (Exception)
            {
                return "ERROR";
            }
            return "SUCCESS";
        }
        #endregion Kết thúc nhóm khách hàng
        #region Hàm thêm - sửa danh sách loại sản phẩm
        [WebMethod]
        public static string ThemLoaiSanPham(string id, string tenLoaiSanPham, string kichHoat, string congThuc, string ghiChu)
        {
            Guid currentUserID = Guid.NewGuid();
            string currentUser = "";
            #region Get current User
            MembershipUser membershipUser = Membership.GetUser(HttpContext.Current.User.Identity.Name);
            if (membershipUser != null)
            {
                currentUser = membershipUser.UserName;
                currentUserID = (Guid)membershipUser.ProviderUserKey;
            }
            #endregion get current User

            xRPDataContext dataContext = new xRPDataContext();
            Qldh_DanhMucSong qlvt = new Qldh_DanhMucSong();
            try
            {
                int? idd = int.Parse(id) == 0 || int.Parse(id) == -1 ? (int?)null : int.Parse(id);
                bool KichHoat = false;
                if (kichHoat == "1")
                {
                    KichHoat = true;
                }
                if (kichHoat == "0")
                {
                    KichHoat = false;
                }
                string result = "";
                if (int.Parse(id) == -1)
                {
                    result = dataContext.Sp_Qldh_LoaiSanPham_Add_Edit_Deli("ADD", int.Parse(id), tenLoaiSanPham, congThuc, ghiChu, KichHoat, currentUserID, currentUserID, ref idd, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                }
                if (int.Parse(id) > 0)
                {
                    result = dataContext.Sp_Qldh_LoaiSanPham_Add_Edit_Deli("EDIT", int.Parse(id), tenLoaiSanPham, congThuc, ghiChu, KichHoat, currentUserID, currentUserID, ref idd, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                }
                if (!string.IsNullOrEmpty(result))
                {
                    return result;
                }
            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message + ex.StackTrace;
            }
            return "SUCCESS";

        }
        #endregion Kết thúc thêm - sửa danh sách loại sản phẩm
        #region Hàm Xóa danh sách loại sản phẩm
        [WebMethod]
        public static string XoaLoaiSanPham(int id)
        {
            try
            {
                Guid currentUserID = Guid.NewGuid();
                string currentUser = "";
                #region Get current User
                MembershipUser membershipUser = Membership.GetUser(HttpContext.Current.User.Identity.Name);
                if (membershipUser != null)
                {
                    currentUser = membershipUser.UserName;
                    currentUserID = (Guid)membershipUser.ProviderUserKey;
                }
                #endregion get current User
                //Initial data context variable, this class is declared in .dbml file in xRPDAL namespace
                xRPDataContext dts = new xRPDataContext();

                var result = dts.Sp_Qldh_LoaiSanPham_Deli("DEL1", id, currentUserID, Util.GetIP(), Util.GetPCName());
            }
            catch (Exception)
            {
                return "ERROR";
            }
            return "SUCCESS";
        }
        #endregion Kết thúc danh sách loại sản phẩm
        #region Hàm thêm - sửa kích thước
        [WebMethod]
        public static string ThemKichThuoc(string id, string tenKichThuoc, string maKichThuoc, string heSoChatDai, string kichHoat, string ghiChu)
        {
            Guid currentUserID = Guid.NewGuid();
            string currentUser = "";
            #region Get current User
            MembershipUser membershipUser = Membership.GetUser(HttpContext.Current.User.Identity.Name);
            if (membershipUser != null)
            {
                currentUser = membershipUser.UserName;
                currentUserID = (Guid)membershipUser.ProviderUserKey;
            }
            #endregion get current User

            xRPDataContext dataContext = new xRPDataContext();
            Qldh_DanhMucSong qlvt = new Qldh_DanhMucSong();
            try
            {
                int? idd = int.Parse(id) == 0 || int.Parse(id) == -1 ? (int?)null : int.Parse(id);
                bool KichHoat = false;
                if (kichHoat == "1")
                {
                    KichHoat = true;
                }
                if (kichHoat == "0")
                {
                    KichHoat = false;
                }
                string result = "";
                if (int.Parse(id) == -1)
                {
                    result = dataContext.Sp_Qldh_LoaiKichThuoc_Add_Edit_Deli("ADD", int.Parse(id), tenKichThuoc, maKichThuoc, double.Parse(heSoChatDai), ghiChu, KichHoat, currentUserID, currentUserID, ref idd, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                }
                if (int.Parse(id) > 0)
                {
                    result = dataContext.Sp_Qldh_LoaiKichThuoc_Add_Edit_Deli("EDIT", int.Parse(id), tenKichThuoc, maKichThuoc, double.Parse(heSoChatDai), ghiChu, KichHoat, currentUserID, currentUserID, ref idd, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                }
                if (!string.IsNullOrEmpty(result))
                {
                    return result;
                }
            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message + ex.StackTrace;
            }
            return "SUCCESS";

        }
        #endregion Kết thúc hàm thêm - sửa kích thước
        #region Hàm xóa kích thước
        [WebMethod]
        public static string XoaKichThuoc(int id)
        {
            try
            {
                Guid currentUserID = Guid.NewGuid();
                string currentUser = "";
                #region Get current User
                MembershipUser membershipUser = Membership.GetUser(HttpContext.Current.User.Identity.Name);
                if (membershipUser != null)
                {
                    currentUser = membershipUser.UserName;
                    currentUserID = (Guid)membershipUser.ProviderUserKey;
                }
                #endregion get current User
                //Initial data context variable, this class is declared in .dbml file in xRPDAL namespace
                xRPDataContext dts = new xRPDataContext();

                var result = dts.Sp_Qldh_LoaiKichThuoc_Deli("DEL1", id, currentUserID, Util.GetIP(), Util.GetPCName());
            }
            catch (Exception)
            {
                return "ERROR";
            }
            return "SUCCESS";
        }
        #endregion Kết thúc hàm xóa kích thước
        #region Hàm thêm - sửa hệ số tổng giao
        [WebMethod]
        public static string ThemHeSoTongGiao(string id, string idLoaiKichThuoc, string soLop, string heSoTongGiao,
            string ghiChu, string kichHoat)
        {
            Guid currentUserID = Guid.NewGuid();
            string currentUser = "";
            #region Get current User
            MembershipUser membershipUser = Membership.GetUser(HttpContext.Current.User.Identity.Name);
            if (membershipUser != null)
            {
                currentUser = membershipUser.UserName;
                currentUserID = (Guid)membershipUser.ProviderUserKey;
            }
            #endregion get current User

            xRPDataContext dataContext = new xRPDataContext();
            try
            {
                int? idd = int.Parse(id) == 0 || int.Parse(id) == -1 ? (int?)null : int.Parse(id);
                bool KichHoat = false;
                if (kichHoat == "1")
                {
                    KichHoat = true;
                }
                if (kichHoat == "0")
                {
                    KichHoat = false;
                }
                string result = "";
                if (int.Parse(id) == -1)
                {
                    result = dataContext.Sp_Qldh_HeSoTongDao_Add_Edit_Deli("ADD", int.Parse(id), int.Parse(idLoaiKichThuoc), int.Parse(soLop), double.Parse(heSoTongGiao), ghiChu, KichHoat, currentUserID, currentUserID, ref idd, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                }
                if (int.Parse(id) > 0)
                {
                    result = dataContext.Sp_Qldh_HeSoTongDao_Add_Edit_Deli("EDIT", int.Parse(id), int.Parse(idLoaiKichThuoc), int.Parse(soLop), double.Parse(heSoTongGiao), ghiChu, KichHoat, currentUserID, currentUserID, ref idd, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                }
                if (!string.IsNullOrEmpty(result))
                {
                    return result;
                }
            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message + ex.StackTrace;
            }
            return "SUCCESS";

        }
        #endregion Kết thúc hàm thêm - sửa hệ số tổng giao
        #region Hàm xóa hệ số tổng giao
        [WebMethod]
        public static string XoaHeSoTongGiao(int id)
        {
            try
            {
                Guid currentUserID = Guid.NewGuid();
                string currentUser = "";
                #region Get current User
                MembershipUser membershipUser = Membership.GetUser(HttpContext.Current.User.Identity.Name);
                if (membershipUser != null)
                {
                    currentUser = membershipUser.UserName;
                    currentUserID = (Guid)membershipUser.ProviderUserKey;
                }
                #endregion get current User
                //Initial data context variable, this class is declared in .dbml file in xRPDAL namespace
                xRPDataContext dts = new xRPDataContext();

                var result = dts.Sp_Qldh_HeSoTongDao_Deli("DEL1", id, currentUserID, Util.GetIP(), Util.GetPCName());
            }
            catch (Exception)
            {
                return "ERROR";
            }
            return "SUCCESS";
        }
        #endregion Kết thúc xóa hệ số tổng giao
    }
}