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
using xRPRepository;
namespace xRP.Business.QuanLySanXuat
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

                    #region Công đoạn
                    case "cd": LoadCongDoan(false); break;
                    case "cdaoe": LoadCongDoan(true); break;
                    #endregion Công đoạn
                    #region Nguồn lực
                    case "ngl": LoadNguonLuc(false); break;
                    case "nglaoe": LoadNguonLuc(true); break;
                    #endregion Nguồn lực
                    #region Cơ cấu giấy
                    case "ccg": LoadCoCauGiay(false); break;
                    case "ccgaoe": LoadCoCauGiay(true); break;
                    #endregion Cơ cấu giấy
                    #region Phân loại sóng
                    case "pls": LoadPhanLoaiSong(false); break;
                    case "plsaoe": LoadPhanLoaiSong(true); break;
                    #endregion Phân loại sóng
                    #region Lớp giấy
                    case "lg": LoadLopGiay(false); break;
                    case "lgaoe": LoadLopGiay(true); break;
                    #endregion Lớp giấy
                    #region Lệnh sản xuất
                    case "lsx": LoadLenhSanXuat(0); break;
                    case "tlsx": LoadLenhSanXuat(1); break;
                    case "dtlsx": LoadChiTietLenhSanXuat(); break;
                    case "ipycvt": InPhieuYeuCauVatTu(); break;
                    case "dsycsx": YeuCauSanXuat(); break;


                    #endregion Lệnh sản xuất
                    #region Phiếu yêu cầu vật tư
                    case "pycvt": LoadPhieuYeuCauVatTu(false); break;
                    case "cnpycvt": LoadPhieuYeuCauVatTu(true); break;
                    case "ctpycvt": LoadChiTietPhieuYeuCauVatTu(); break;
                    case "inpycvt": InPhieuYeuCauVatTu(); break;

                    #endregion Phiếu yêu cầu vật tư
                    #region Báo cáo sản xuất
                    case "bcsx":
                        LoadBaoCaoSanXuat(0);
                        break;
                    case "bcthcds":
                        LoadBaoCaoTongHopCongDoanSong();
                        break;
                    #endregion Báo cáo sản xuất
                    #region Cập nhật lệnh sản xuất
                    case "cnlsx": LoadCapNhatLenhSanXuat(); break;
                    #endregion Cập nhật lệnh sản xuất
                    #region In Lệnh sản xuất
                    case "plsx":
                        LoadInLenhSanXuat();
                        break;
                    #endregion In Lệnh sản xuất
                    #region In Phương án vật tư
                    case "pavt":
                        LoadInPhuongAnVatTu();
                        break;
                    #endregion Phương án vật tư
                    #region Đơn hàng
                    case "dh": LoadDonHang(); break;
                    case "xldh": LoadXuLyDonHang(); break;
                    case "cdsx": LoadCongDoanSanXuat(); break;
                    case "cccg": LoadChonCoCauGiay(); break;
                    case "dmvattu": LoadDinhMucVatTu(); break;
                    #endregion Đơn hàng
                }
            }
        }

        private void LoadCapNhatPhieuYeuCauVatTu()
        {
            throw new NotImplementedException();
        }



        private void LoadCapNhatLenhSanXuat()
        {
            Business.QuanLySanXuat.TaoLenhSanXuat.CapNhatLenhSanXuat capNhatLenhSanXuat = (Business.QuanLySanXuat.TaoLenhSanXuat.CapNhatLenhSanXuat)this.Page.LoadControl("~/Business/QuanLySanXuat/TaoLenhSanXuat/CapNhatLenhSanXuat.ascx");
            plcContent.Controls.Add(capNhatLenhSanXuat);
        }
        protected void LoadCongDoan(bool addoredit)
        {
            if (addoredit)
            {
                Business.QuanLySanXuat.CongDoan.AddOrEditCongDoan addOrEditCongDoan = (Business.QuanLySanXuat.CongDoan.AddOrEditCongDoan)this.Page.LoadControl("~/Business/QuanLySanXuat/CongDoan/AddOrEditCongDoan.ascx");
                plcContent.Controls.Add(addOrEditCongDoan);
            }
            else
            {
                Business.QuanLySanXuat.CongDoan.DanhSachCongDoan danhSachCongDoan = (Business.QuanLySanXuat.CongDoan.DanhSachCongDoan)this.Page.LoadControl("~/Business/QuanLySanXuat/CongDoan/DanhSachCongDoan.ascx");
                plcContent.Controls.Add(danhSachCongDoan);
            }
        }
        protected void LoadNguonLuc(bool addoredit)
        {
            if (addoredit)
            {
                Business.QuanLySanXuat.NguonLuc.AddOrEditNguonLuc addOrEditNguonLuc = (Business.QuanLySanXuat.NguonLuc.AddOrEditNguonLuc)this.Page.LoadControl("~/Business/QuanLySanXuat/NguonLuc/AddOrEditNguonLuc.ascx");
                plcContent.Controls.Add(addOrEditNguonLuc);
            }
            else
            {
                Business.QuanLySanXuat.NguonLuc.DanhSachNguonLuc danhSachNguonLuc = (Business.QuanLySanXuat.NguonLuc.DanhSachNguonLuc)this.Page.LoadControl("~/Business/QuanLySanXuat/NguonLuc/DanhSachNguonLuc.ascx");
                plcContent.Controls.Add(danhSachNguonLuc);
            }
        }
        private void LoadChiTietPhieuYeuCauVatTu()
        {
            //Business.QuanLySanXuat.YeuCauVatTu.ChiTietPhieuYeuCauVatTu chiTietPhieuYeuCauVatTu = (Business.QuanLySanXuat.YeuCauVatTu.ChiTietPhieuYeuCauVatTu)this.Page.LoadControl("~/Business/QuanLySanXuat/YeuCauVatTu/ChiTietPhieuYeuCauVatTu.ascx");
            //plcContent.Controls.Add(chiTietPhieuYeuCauVatTu);
        }



        protected void InPhieuYeuCauVatTu()
        {
            Report.ReportViewer reportLenhSanXuat = (Report.ReportViewer)this.Page.LoadControl("~/Report/ReportViewer.ascx");
            plcContent.Controls.Add(reportLenhSanXuat);
        }

        protected void YeuCauSanXuat()
        {
            Business.QuanLySanXuat.TaoLenhSanXuat.YeuCauSanXuat yeuCauSanXuat = (Business.QuanLySanXuat.TaoLenhSanXuat.YeuCauSanXuat)this.Page.LoadControl("~/Business/QuanLySanXuat/TaoLenhSanXuat/YeuCauSanXuat.ascx");
            plcContent.Controls.Add(yeuCauSanXuat);
        }

        protected void LoadLenhSanXuat(int type)
        {
            if (type == 0)
            {
                Business.QuanLySanXuat.TaoLenhSanXuat.DanhSachLenhSanXuat danhSachLenhSanXuat = (Business.QuanLySanXuat.TaoLenhSanXuat.DanhSachLenhSanXuat)this.Page.LoadControl("~/Business/QuanLySanXuat/TaoLenhSanXuat/DanhSachLenhSanXuat.ascx");
                plcContent.Controls.Add(danhSachLenhSanXuat);
            }
            if (type == 1)
            {
                Business.QuanLySanXuat.TaoLenhSanXuat.AddOrEditLenhSanXuat addOrEditLenhSanXuat = (Business.QuanLySanXuat.TaoLenhSanXuat.AddOrEditLenhSanXuat)this.Page.LoadControl("~/Business/QuanLySanXuat/TaoLenhSanXuat/AddOrEditLenhSanXuat.ascx");
                plcContent.Controls.Add(addOrEditLenhSanXuat);
            }
        }

        protected void LoadChiTietLenhSanXuat()
        {
            Business.QuanLySanXuat.TaoLenhSanXuat.DetailLenhSanXuat detailLenhSanXuat = (Business.QuanLySanXuat.TaoLenhSanXuat.DetailLenhSanXuat)this.Page.LoadControl("~/Business/QuanLySanXuat/TaoLenhSanXuat/DetailLenhSanXuat.ascx");
            plcContent.Controls.Add(detailLenhSanXuat);
        }
        private void LoadPhieuYeuCauVatTu(bool addoredit)
        {
            if (addoredit)
            {
                Business.QuanLySanXuat.YeuCauVatTu.AddOrEditPhieuYeuCauVatTu addOrEditPhieuYeuCauVatTu = (Business.QuanLySanXuat.YeuCauVatTu.AddOrEditPhieuYeuCauVatTu)this.Page.LoadControl("~/Business/QuanLySanXuat/YeuCauVatTu/AddOrEditPhieuYeuCauVatTu.ascx");
                plcContent.Controls.Add(addOrEditPhieuYeuCauVatTu);
            }
            else
            {
                Business.QuanLySanXuat.YeuCauVatTu.DanhSachPhieuYeuCauVatTu danhSachPhieuYeuCauVatTu = (Business.QuanLySanXuat.YeuCauVatTu.DanhSachPhieuYeuCauVatTu)this.Page.LoadControl("~/Business/QuanLySanXuat/YeuCauVatTu/DanhSachPhieuYeuCauVatTu.ascx");
                plcContent.Controls.Add(danhSachPhieuYeuCauVatTu);
            }
        }


        //protected void LoadCapNhatLenhSanXuat()
        //{
        //    Business.QuanLySanXuat.TaoLenhSanXuat.DanhSachLenhSanXuat danhSachLenhSanXuat = (Business.QuanLySanXuat.TaoLenhSanXuat.DanhSachLenhSanXuat)this.Page.LoadControl("~/Business/QuanLySanXuat/TaoLenhSanXuat/DanhSachLenhSanXuat.ascx");
        //    plcContent.Controls.Add(danhSachLenhSanXuat);

        //    Business.QuanLySanXuat.TaoLenhSanXuat.AddOrEditLenhSanXuat addOrEditLenhSanXuat = (Business.QuanLySanXuat.TaoLenhSanXuat.AddOrEditLenhSanXuat)this.Page.LoadControl("~/Business/QuanLySanXuat/TaoLenhSanXuat/AddOrEditLenhSanXuat.ascx");
        //    plcContent.Controls.Add(addOrEditLenhSanXuat);

        //}
        protected void LoadBaoCaoSanXuat(int type)
        {
            if (type == 1)
            {
                Business.QuanLySanXuat.BaoCaoSanXuat.AddOrEditBaoCaoSanXuat addOrEditBaoCaoSanXuat = (Business.QuanLySanXuat.BaoCaoSanXuat.AddOrEditBaoCaoSanXuat)this.Page.LoadControl("~/Business/QuanLySanXuat/BaoCaoSanXuat/AddOrEditBaoCaoSanXuat.ascx");
                plcContent.Controls.Add(addOrEditBaoCaoSanXuat);
            }
            else
            {

                Report.XtraReportViewer reportLenhSanXuat = (Report.XtraReportViewer)this.Page.LoadControl("~/Report/XtraReportViewer.ascx");
                plcContent.Controls.Add(reportLenhSanXuat);
            }
        }
        protected void LoadBaoCaoTongHopCongDoanSong()
        {
            Report.XtraReportViewer reportTongHopCongDoanSong = (Report.XtraReportViewer)this.Page.LoadControl("~/Report/XtraReportViewer.ascx");
            plcContent.Controls.Add(reportTongHopCongDoanSong);
        }
        protected void LoadCoCauGiay(bool addoredit)
        {
            if (addoredit)
            {
                Business.QuanLySanXuat.CoCauGiay.AddOrEditCoCauGiay addOrEditCoCauGiay = (Business.QuanLySanXuat.CoCauGiay.AddOrEditCoCauGiay)this.Page.LoadControl("~/Business/QuanLySanXuat/CoCauGiay/AddOrEditCoCauGiay.ascx");
                plcContent.Controls.Add(addOrEditCoCauGiay);
            }
            else
            {
                Business.QuanLySanXuat.CoCauGiay.DanhSachCoCauGiay danhSachCoCauGiay = (Business.QuanLySanXuat.CoCauGiay.DanhSachCoCauGiay)this.Page.LoadControl("~/Business/QuanLySanXuat/CoCauGiay/DanhSachCoCauGiay.ascx");
                plcContent.Controls.Add(danhSachCoCauGiay);
            }

        }
        protected void LoadPhanLoaiSong(bool addoredit)
        {
            if (addoredit)
            {
                Business.QuanLySanXuat.PhanLoaiSong.AddOrEditPhanLoaiSong AddOrEditPhanLoaiSong = (Business.QuanLySanXuat.PhanLoaiSong.AddOrEditPhanLoaiSong)this.Page.LoadControl("~/Business/QuanLySanXuat/PhanLoaiSong/AddOrEditPhanLoaiSong.ascx");
                plcContent.Controls.Add(AddOrEditPhanLoaiSong);
            }
            else
            {
                Business.QuanLySanXuat.PhanLoaiSong.DanhSachPhanLoaiSong DanhSachPhanLoaiSong = (Business.QuanLySanXuat.PhanLoaiSong.DanhSachPhanLoaiSong)this.Page.LoadControl("~/Business/QuanLySanXuat/PhanLoaiSong/DanhSachPhanLoaiSong.ascx");
                plcContent.Controls.Add(DanhSachPhanLoaiSong);
            }
        }
        protected void LoadLopGiay(bool addoredit)
        {
            if (addoredit)
            {
                Business.QuanLySanXuat.LopGiay.AddOrEditLopGiay AddOrEditLopGiay = (Business.QuanLySanXuat.LopGiay.AddOrEditLopGiay)this.Page.LoadControl("~/Business/QuanLySanXuat/LopGiay/AddOrEditLopGiay.ascx");
                plcContent.Controls.Add(AddOrEditLopGiay);
            }
            else
            {
                Business.QuanLySanXuat.LopGiay.DanhSachLopGiay DanhSachLopGiay = (Business.QuanLySanXuat.LopGiay.DanhSachLopGiay)this.Page.LoadControl("~/Business/QuanLySanXuat/LopGiay/DanhSachLopGiay.ascx");
                plcContent.Controls.Add(DanhSachLopGiay);
            }
        }

        #region Xử lý đơn hàng
        protected void LoadDonHang()
        {
            Administrator.QuanLyDonHang.DonHang.DanhMucDonHang danhDonHang = (Administrator.QuanLyDonHang.DonHang.DanhMucDonHang)this.Page.LoadControl("~/Administrator/QuanLyDonHang/DonHang/DanhMucDonHang.ascx");
            plcContent.Controls.Add(danhDonHang);
        }
        protected void LoadXuLyDonHang()
        {
            Administrator.QuanLyDonHang.DonHang.XuLyDonHang.XuLyDonHang xulydonhang = (Administrator.QuanLyDonHang.DonHang.XuLyDonHang.XuLyDonHang)this.Page.LoadControl("~/Administrator/QuanLyDonHang/DonHang/XuLyDonHang/XuLyDonHang.ascx");
            plcContent.Controls.Add(xulydonhang);
        }
        protected void LoadCongDoanSanXuat()
        {
            Administrator.QuanLyDonHang.DonHang.XuLyDonHang.CongDoanSanXuatGiay congdoansanxuat = (Administrator.QuanLyDonHang.DonHang.XuLyDonHang.CongDoanSanXuatGiay)this.Page.LoadControl("~/Administrator/QuanLyDonHang/DonHang/XuLyDonHang/CongDoanSanXuatGiay.ascx");
            plcContent.Controls.Add(congdoansanxuat);
        }
        protected void LoadChonCoCauGiay()
        {
            Administrator.QuanLyDonHang.DonHang.XuLyDonHang.ChonCoCauGiay choncocaugiay = (Administrator.QuanLyDonHang.DonHang.XuLyDonHang.ChonCoCauGiay)this.Page.LoadControl("~/Administrator/QuanLyDonHang/DonHang/XuLyDonHang/ChonCoCauGiay.ascx");
            plcContent.Controls.Add(choncocaugiay);
        }
        protected void LoadDinhMucVatTu()
        {
            Administrator.QuanLyDonHang.DonHang.XuLyDonHang.DinhMucVatTu dinhmucvattu = (Administrator.QuanLyDonHang.DonHang.XuLyDonHang.DinhMucVatTu)this.Page.LoadControl("~/Administrator/QuanLyDonHang/DonHang/XuLyDonHang/DinhMucVatTu.ascx");
            plcContent.Controls.Add(dinhmucvattu);
        }
        [WebMethod]
        public static string KetThucXuLyDonHang(int ID)
        {
            xRPDataContext dts = new xRPDataContext();
            var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
            return dts.Sp_Qldh_DonHang_XuLy(ID, user.UserId, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
        }
        [WebMethod]
        public static string CopyLenhSanXuat(string id)
        {
            xRPDataContext dts = new xRPDataContext();
            var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
            int? newiD = 0;
            string result = dts.Sp_Qlsx_LenhSanXuat_Copy(int.Parse(id), user.UserId, Util.GetIP(), Util.GetPCName(), ref newiD).FirstOrDefault().Column1;
            if (newiD != null)
            {
                return newiD.ToString();
            }
            else
            {
                return result;
            }
        }
        [WebMethod]
        public static string GetYeuCauByMatHangID(int ID)
        {
            xRPDataContext dts = new xRPDataContext();
            return dts.Sp_Qlsx_YeuCauSanXuat_Select(3, null, 1, ID, null, null, null, null).FirstOrDefault().ID.ToString();

        }
        #endregion Xử lý đơn hàng

        #region Quản lý công đoạn
        [WebMethod]
        public static string AddOrEditCongDoan(int itemID, int maDonViPhuTrach, bool kichHoat, string tenCongDoan, string maHieuCongDoan, string ghiChu)
        {
            string returnMessage = "";
            try
            {
                DateTime dtNgayNhap = DateTime.Now;
                xRPDataContext dts = new xRPDataContext();
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                int? id = itemID == 0 ? 0 : itemID;
                if (itemID <= 0)
                    returnMessage = dts.Sp_Qlsx_CongDoan_Add_Edit_Deli("ADD", null, maDonViPhuTrach, tenCongDoan, maHieuCongDoan, ghiChu, kichHoat == true ? 1 : 0, user.UserId, null, ref id, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                //returnMessage = "Thêm mới công đoạn";

                else
                    returnMessage = dts.Sp_Qlsx_CongDoan_Add_Edit_Deli("EDIT", itemID, maDonViPhuTrach, tenCongDoan, maHieuCongDoan, ghiChu, kichHoat == true ? 1 : 0, user.UserId, null, ref id, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                // returnMessage = "Sửa thông tin công đoạn";
                dts.Dispose();
                if (!string.IsNullOrEmpty(returnMessage))
                    return returnMessage;
                return id.HasValue ? id.Value.ToString() : returnMessage;
            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message;
            }
        }

        [WebMethod]
        public static string DeleteCongDoan(int itemID)
        {
            string result = "";
            try
            {
                int? id = itemID == 0 ? 0 : itemID;
                //Initial data context variable, this class is declared in .dbml file in xRPDAL namespace
                xRPDataContext dts = new xRPDataContext();
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                result = dts.Sp_Qlsx_CongDoan_Add_Edit_Deli("DEL1", itemID, null, null, null, null, null, user.UserId, null, ref id, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;

                if (!string.IsNullOrEmpty(result)) return result;
            }
            catch (Exception)
            {
                return "ERROR";
            }
            return "SUCCESS";
        }

        [WebMethod]
        public static string GetCongDoanSanXuat(int IDMatHang)
        {
            xRPDataContext dts = new xRPDataContext();
            List<Sp_Qlsx_YeuCauSanXuat_SelectResult> list = new List<Sp_Qlsx_YeuCauSanXuat_SelectResult>();
            list = (from yc in dts.Sp_Qlsx_YeuCauSanXuat_Select(0, (int?)null, (int?)null, (int?)null, null, null, 0, 0) where yc.IDMatHang.Value == IDMatHang select yc).ToList();
            return new JavaScriptSerializer().Serialize(list);
        }

        [WebMethod]
        public static string AddOrEditCongDoanSanXuat(int ID, int IDCongDoan, int IDMatHang, int ThuTuThucHienCongDoan, int SoLuongCanSanXuat, string GhiChu)
        {
            string returnMessage = "";
            try
            {
                DateTime dtNgayNhap = DateTime.Now;
                xRPDataContext dts = new xRPDataContext();
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                int? id = ID == 0 ? 0 : ID;
                //int id_mathang = 0;
                if (ID == 0)
                {
                    //  dts.Sp_Qldh_MatHang_Add_Edit_Deli("EDIT", IDMatHang, "",null,"",);
                    returnMessage = dts.Sp_Qlsx_YeuCauSanXuat_Add_Edit_Deli("ADD", (int?)null, IDMatHang, IDCongDoan, ThuTuThucHienCongDoan, SoLuongCanSanXuat, GhiChu, user.UserId, user.UserId, ref id, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                }
                else
                {
                    var x = dts.Sp_Qlsx_YeuCauSanXuat_Select(1, id, (int?)null, (int?)null, (int?)null, null, 0, null).FirstOrDefault();
                    returnMessage = dts.Sp_Qlsx_YeuCauSanXuat_Add_Edit_Deli("EDIT", ID, IDMatHang, IDCongDoan, ThuTuThucHienCongDoan, SoLuongCanSanXuat, GhiChu, x.MaNguoiTao, user.UserId, ref id, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                }
                dts.Dispose();
                if (!string.IsNullOrEmpty(returnMessage))
                    return returnMessage;
                return id.HasValue ? id.Value.ToString() : returnMessage;

            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message;
            }
        }

        [WebMethod]
        public static string DeleteCongDoanSanXuat(int ID)
        {
            string result = "";
            try
            {

                //Initial data context variable, this class is declared in .dbml file in xRPDAL namespace
                xRPDataContext dts = new xRPDataContext();
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                if (dts.Qlsx_YeuCauSanXuats.FirstOrDefault(t => t.ID == ID) != null)
                    result = dts.Sp_Qlsx_YeuCauSanXuat_Deli("DEL1", ID, user.UserId, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                if (!string.IsNullOrEmpty(result)) return result;
            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message;
            }
            return "SUCCESS";
        }
        #endregion

        #region Quan ly Ban hang
        [WebMethod]
        public static string UpdateMatHangSoLuongThung(int id, int soluong)
        {
            xRPDataContext dts = new xRPDataContext();
            var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
            int? mhid = 0;

            string retr = dts.Sp_Qldh_MatHang_Update(id, soluong, user.UserId, user.UserId, ref mhid, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
            if (!string.IsNullOrEmpty(retr))
            {
                return retr;
            }
            else
            {
                return "SUCCESS";
            }

        }
        [WebMethod]
        public static string ChonCoCauGiay(int ID, int TongDao, int ChatDai, int Xa, int LoaiSongSanXuat, int SoLuongTam, int SoLuongHop, double Tai, double Le, double KhoGiay)
        {
            string returnMessage = "";
            try
            {
                DateTime dtNgayNhap = DateTime.Now;
                xRPDataContext dts = new xRPDataContext();
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                int? id = ID == 0 ? 0 : ID;
                if (ID != 0)
                {
                    var x = dts.Sp_Qldh_MatHang_Select(1, id, (int?)null, 0, 1, "").FirstOrDefault();
                    if (x != null)
                        returnMessage = dts.Sp_Qldh_MatHang_Add_Edit_Deli("EDIT", ID, x.MaHieuMatHang, x.IDDonHang, x.TenMatHang, x.NgayGiaoHang, x.SoLuong, x.IDDonVitinh,
                            x.SoLuongMau, x.MauSacMatNgoai, x.ChieuDai, x.ChieuRong, x.ChieuCao, x.IDLoaiKichThuoc, x.IDLoaiSanPham, x.SoLop, TongDao,
                            ChatDai, Xa, x.IDLoaiGiay, KhoGiay, x.DinhLuong, LoaiSongSanXuat, LoaiSongSanXuat, Tai, Le, SoLuongTam, SoLuongHop,
                            x.DienTichSanXuat, x.DienTichXuatBan, x.IDCongDoanCuoi, x.DonGia, x.ThanhTien,
                            x.GhiChu, "", 1, x.MaNguoiTao, user.UserId, ref id, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;

                    int? slCanSanXuat = dts.Sp_Qlsx_YeuCauSanXuat_Select(3, null, 1, ID, null, null, null, null).FirstOrDefault().SoLuongCanSanXuat;
                    int? mhid = 0;
                    if (slCanSanXuat != null)
                    {
                        //Goi store cap nhat
                        string retr = dts.Sp_Qldh_MatHang_Update(x.ID, slCanSanXuat, user.UserId, user.UserId, ref mhid, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                    }
                }



                dts.Dispose();
                if (!string.IsNullOrEmpty(returnMessage))
                    return returnMessage;
                return id.HasValue ? id.Value.ToString() : returnMessage;

            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message;
            }
        }

        [WebMethod]
        public static string AddOrEditDinhMucVatTu(int ID, int IDLenhSanXuatChiTiet, int IDPhatSinhTieuHaoVatTu, int IDVatTu, int IDDonViTinh, double HeSoTieuHao, double SoLuong)
        {
            string returnMessage = "0";
            try
            {
                xRPDataContext dts = new xRPDataContext();
                //dts.Sp_Qlsx_DinhMucVatTu_Add_Edit_Deli("Add", ID, iDYeuCauSanXuat, iDPhatSinhTieuHaoVatTu, iDVatTu, iDDonViTinh, heSoTieuHao, soLuong, iDDonHang, mANGUOITAO, mANGUOITHAYDOI, nEW_identity, iP, pC)

                //Thông tin người đăng nhập
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();

                //AddOrEditLenhSanXuat - Tạo moi dinh muc.
                int? id = 0;
                Sp_Qlsx_DinhMucVatTu_Add_Edit_DeliResult resultData;

                if (ID == 0)// Thêm mới dinh muc.
                {
                    resultData = dts.Sp_Qlsx_DinhMucVatTu_Add_Edit_Deli("ADD", null, IDLenhSanXuatChiTiet, null, IDPhatSinhTieuHaoVatTu, IDVatTu, IDDonViTinh, HeSoTieuHao, SoLuong, user.UserId, null, ref id, Util.GetIP(), Util.GetPCName()).FirstOrDefault();
                }
                else
                {
                    resultData = dts.Sp_Qlsx_DinhMucVatTu_Add_Edit_Deli("EDIT", ID, IDLenhSanXuatChiTiet, null, IDPhatSinhTieuHaoVatTu, IDVatTu, IDDonViTinh, HeSoTieuHao, SoLuong, null, user.UserId, ref id, Util.GetIP(), Util.GetPCName()).FirstOrDefault();
                }
                if (resultData != null && !string.IsNullOrEmpty(resultData.Column1)) return resultData.Column1;

                return returnMessage = id.HasValue ? id.Value.ToString() : "0";

            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message + "\n" + ex.StackTrace;
            }
        }

        [WebMethod]
        public static string GetDinhMucVatTu(int lenhSanXuatChiTietId)
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                data = new JavaScriptSerializer().Serialize(dts.Sp_Qlsx_DinhMucVatTu_Select(2, null, lenhSanXuatChiTietId, null, null));
            }
            catch (Exception ex)
            {
                data = "{error:\"" + ex.Message + "\"}";
            }
            return data;
        }

        [WebMethod]
        public static string XuLyDonHang(int IDDonHang)
        {
            xRPDataContext dts = new xRPDataContext();
            var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
            return dts.Sp_Qldh_DonHang_XuLy(IDDonHang, user.UserId, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
        }
        #endregion

        #region Quản lý nguồn lực
        [WebMethod]
        public static string AddOrEditNguonLuc(int itemID, string nguonLuc, float mucTai, int donVitinhId, int maCongDoan, bool tinhTrang, bool kichHoat, string ghiChu)
        {
            string returnMessage = "";
            try
            {
                DateTime dtNgayNhap = DateTime.Now;
                xRPDataContext dts = new xRPDataContext();
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                int? id = itemID == 0 ? 0 : itemID;
                int? _nguonLuc = 0;
                if (itemID == 0)
                {
                    returnMessage = dts.Sp_Qlnl_NguonLuc_Add_Edit_Deli("ADD", null, nguonLuc, mucTai, donVitinhId, maCongDoan, tinhTrang == true ? 1 : 0, ghiChu, kichHoat == true ? 1 : 0, user.UserId, null, ref _nguonLuc, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                }
                else
                {
                    returnMessage = dts.Sp_Qlnl_NguonLuc_Add_Edit_Deli("EDIT", itemID, nguonLuc, mucTai, donVitinhId, maCongDoan, tinhTrang == true ? 1 : 0, ghiChu, kichHoat == true ? 1 : 0, user.UserId, user.UserId, ref _nguonLuc, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                }

                dts.Dispose();
                if (!string.IsNullOrEmpty(returnMessage))
                    return returnMessage;
                return id.HasValue ? id.Value.ToString() : returnMessage;

            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message;
            }
        }

        [WebMethod]
        public static string DeleteNguonLuc(int itemID)
        {
            try
            {
                xRPDataContext dts = new xRPDataContext();
                int? newId = 0;
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                var result = dts.Sp_Qlnl_NguonLuc_Add_Edit_Deli("DEL1", itemID, null, null, null, null, null, "", null, user.UserId, null, ref newId, Util.GetIP(), Util.GetPCName()).FirstOrDefault();
                if (result != null && !string.IsNullOrEmpty(result.Column1)) return result.Column1;

            }
            catch (Exception)
            {
                return "ERROR";
            }
            return "SUCCESS";
        }

        #endregion

        #region Quản lý danh mục lớp giấy
        [WebMethod]
        public static string AddOrEditTenLopGiay(int itemID, string tenLop, int danhMucSongId, bool kichHoat, string ghiChu)
        {
            string returnMessage = "";
            try
            {
                DateTime dtNgayNhap = DateTime.Now;
                xRPDataContext dts = new xRPDataContext();
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                int? id = itemID == 0 ? 0 : itemID;
                int? _tenLopGiayId = 0;
                if (itemID == 0)
                {
                    returnMessage = dts.Sp_Qlsx_TenLopGiay_Add_Edit_Deli("ADD", null, tenLop, danhMucSongId, kichHoat == true ? 1 : 0, user.UserId, null, ref _tenLopGiayId, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                }
                else
                {
                    returnMessage = dts.Sp_Qlsx_TenLopGiay_Add_Edit_Deli("EDIT", itemID, tenLop, danhMucSongId, kichHoat == true ? 1 : 0, user.UserId, null, ref _tenLopGiayId, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;

                }
                dts.Dispose();
                if (!string.IsNullOrEmpty(returnMessage))
                    return returnMessage;
                return id.HasValue ? id.Value.ToString() : returnMessage;

            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message;
            }
        }

        [WebMethod]
        public static string DeleteTenLopGiay(int itemID)
        {
            try
            {
                xRPDataContext dts = new xRPDataContext();
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                int? _tenLopGiayId = 0;
                var result = dts.Sp_Qlsx_TenLopGiay_Add_Edit_Deli("DEL1", itemID, null, null, null, user.UserId, null, ref _tenLopGiayId, Util.GetIP(), Util.GetPCName()).FirstOrDefault();

                if (result != null && !string.IsNullOrEmpty(result.Column1)) return result.Column1;
            }
            catch (Exception)
            {
                return "ERROR";
            }
            return "SUCCESS";
        }

        #endregion

        #region Quản lý danh mục phân loại sóng
        [WebMethod]
        public static string AddOrEditPhanLoaiSong(int itemID, string kiHieuCoCauGiay, string kiHieuQuyDoi, string moTaCoCauGiay, int soLop, bool kichHoat, string ghiChu)
        {
            string returnMessage = "";
            try
            {
                DateTime dtNgayNhap = DateTime.Now;
                xRPDataContext dts = new xRPDataContext();
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                int? id = itemID == 0 ? 0 : itemID;
                int? _phanLoaiSongId = 0;
                if (itemID <= 0)
                {
                    returnMessage = dts.Sp_Qlsx_PhanLoaiSong_Add_Edit_Deli("ADD", null, kiHieuCoCauGiay, kiHieuQuyDoi, moTaCoCauGiay, ghiChu, soLop, kichHoat, user.UserId, user.UserId, ref _phanLoaiSongId, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;

                }
                else
                {
                    returnMessage = dts.Sp_Qlsx_PhanLoaiSong_Add_Edit_Deli("EDIT", itemID, kiHieuCoCauGiay, kiHieuQuyDoi, moTaCoCauGiay, ghiChu, soLop, kichHoat, user.UserId, user.UserId, ref _phanLoaiSongId, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;

                }
                dts.Dispose();
                if (!string.IsNullOrEmpty(returnMessage))
                    return returnMessage;
                return _phanLoaiSongId.HasValue ? _phanLoaiSongId.Value.ToString() : returnMessage;

            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message;
            }
        }

        [WebMethod]
        public static string DeletePhanLoaiSong(int itemID)
        {
            try
            {
                xRPDataContext dts = new xRPDataContext();
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                var result = dts.Sp_Qlsx_PhanLoaiSong_Deli("DEL1", itemID, user.UserId, Util.GetIP(), Util.GetPCName()).FirstOrDefault();
                if (result != null && !string.IsNullOrEmpty(result.Column1)) return result.Column1;
            }
            catch (Exception)
            {
                return "ERROR";
            }
            return "SUCCESS";
        }

        #endregion

        #region Quản lý danh mục cơ cấu giấy
        [WebMethod]
        public static string AddOrEditCoCauGiay(int itemID, int? coCauGiayId, int? lopGiayId, int? loaiGiayID, int? thuTu, bool kichHoat)
        {
            string returnMessage = "";
            try
            {
                DateTime dtNgayNhap = DateTime.Now;
                xRPDataContext dts = new xRPDataContext();
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                int? id = itemID == 0 ? 0 : itemID;
                int? _coCauGiayTheoSong = 0;
                int? kichhoat = null;
                try
                {
                    kichhoat = kichHoat != false ? 1 : 0;
                }
                catch
                {
                    kichhoat = 0;
                }
                if (itemID <= 0)
                {
                    returnMessage = dts.Sp_Qlsx_CoCauGiayTheoSong_Add_Edit_Deli("ADD", null, coCauGiayId, lopGiayId, loaiGiayID, thuTu, kichhoat, user.UserId, null, ref _coCauGiayTheoSong, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                }
                else
                {
                    returnMessage = dts.Sp_Qlsx_CoCauGiayTheoSong_Add_Edit_Deli("EDIT", itemID, coCauGiayId, lopGiayId, loaiGiayID, thuTu, kichhoat, user.UserId, null, ref _coCauGiayTheoSong, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;

                }
                dts.Dispose();
                if (!string.IsNullOrEmpty(returnMessage))
                    return returnMessage;
                return _coCauGiayTheoSong.HasValue ? _coCauGiayTheoSong.Value.ToString() : returnMessage;

            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message;
            }
        }
        [WebMethod]
        public static string DeleteCoCauGiay(int itemID)
        {
            try
            {
                xRPDataContext dts = new xRPDataContext();
                int? _coCauGiayTheoSong = 0;
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                string mesage = "";
                mesage = dts.Sp_Qlsx_CoCauGiayTheoSong_Add_Edit_Deli("DEL1", itemID, null, null, null, null, null, user.UserId, null, ref _coCauGiayTheoSong, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                if (!string.IsNullOrEmpty(mesage))
                {
                    return mesage;
                }
                else
                {
                    return "SUCCESS";
                }
            }
            catch (Exception)
            {
                return "ERROR";
            }
        }
        #endregion

        #region Quản lý lệnh sản xuất
        [WebMethod]
        public static string GetLenhSanXuatChiTiet(int? IDLenhSanXuat, int? IDCongDoan, int? IDKhachHang, int? IDDonHang)
        {
            IDKhachHang = IDKhachHang < 1 ? null : IDKhachHang;
            IDDonHang = IDDonHang < 1 ? null : IDDonHang;

            int? typeYeuCauSanXuat = 2;
            var listLenhSanXuatChiTiet = new Qlsx_YeuCauSanXuatRepository().GetDanhSachLenhSanXuatChiTiet(IDLenhSanXuat, IDCongDoan, IDKhachHang, IDDonHang);
            var listYeuCauSanXuat = new Qlsx_YeuCauSanXuatRepository().GetDanhSachYeuCauSanXuat(typeYeuCauSanXuat, IDCongDoan, IDKhachHang, IDDonHang);

            if (IDLenhSanXuat != null && IDLenhSanXuat > 1) typeYeuCauSanXuat = 4;
            if (IDKhachHang < 1) IDKhachHang = null;
            if (IDDonHang < 1) IDDonHang = null;


            var initData = (from c in listLenhSanXuatChiTiet
                            join d in listYeuCauSanXuat on c.IDYeuCauSanXuat equals d.ID
                            //where listYeuCauSanXuat.Any(d => d.ID == c.IDYeuCauSanXuat)
                            select new Sp_Qlsx_LenhSanXuatChiTiet_SelectResult
                            {
                                ID = c.ID,
                                TT = c.TT,
                                IDYeuCauSanXuat = c.IDYeuCauSanXuat,
                                IDLenhSanXuat = c.IDLenhSanXuat,
                                MaHieuDonHang = c.MaHieuDonHang,
                                MaHieuMatHang = c.MaHieuMatHang,
                                TenMatHang = c.TenMatHang,
                                ChieuDai = c.ChieuDai,
                                ChieuRong = c.ChieuRong,
                                ChieuCao = c.ChieuCao,
                                KTTam = c.KTTam,
                                KichThuoc = c.KichThuoc,
                                SoLop = c.SoLop,
                                IDLoaiSongSanXuat = c.IDLoaiSongSanXuat,
                                KhoGiay = c.KhoGiay,
                                ChatDai = c.ChatDai,
                                TongDao = c.TongDao,
                                Xa = c.Xa,
                                Le = c.Le,
                                Tai = c.Tai,
                                SoLuongHop = c.SoLuongHop,
                                SoLuongTam = c.SoLuongTam,
                                DienTichSanXuat = c.DienTichSanXuat,
                                DienTichXuatBan = c.DienTichXuatBan,
                                SoLuong = c.SoLuong,
                                KiHieuCoCauGiay = c.KiHieuCoCauGiay,
                                MoTaCoCauGiay = c.MoTaCoCauGiay,
                                MaHieuKichThuoc = c.MaHieuKichThuoc,
                                LoaiKichThuoc = c.LoaiKichThuoc,
                                TenLoaiSanPham = c.TenLoaiSanPham,
                                MaHieuCongDoan = c.MaHieuCongDoan,
                                TenCongDoan = c.TenCongDoan,
                                SoLuongYeuCau = c.SoLuongYeuCau,
                                SoLuongDatDuoc = c.SoLuongDatDuoc,
                                SoLuongLoi = c.SoLuongLoi,
                                NgayThayDoi = c.NgayThayDoi,
                                ThuTuUuTien = c.ThuTuUuTien,
                                QuyDoiMetDai = c.QuyDoiMetDai,
                                ThoiGianSanXuat = c.ThoiGianSanXuat,
                                GhiChu = c.GhiChu,
                                UserName = c.UserName,
                                MaMatHang = c.MaMatHang,
                                SoLuongYeuCauSanXuatKeHoach = c.SoLuongYeuCauSanXuatKeHoach,
                                SoLuongYeuCauSanXuatKeHoachConLai = c.SoLuongYeuCauSanXuatKeHoachConLai
                            }).ToList();

            var filterData = (from c in listYeuCauSanXuat
                              where !listLenhSanXuatChiTiet.Any(d => d.IDYeuCauSanXuat == c.ID)
                              select new Sp_Qlsx_LenhSanXuatChiTiet_SelectResult
                              {
                                  TT = c.TT,
                                  ID = 0,
                                  IDYeuCauSanXuat = c.ID,
                                  IDLenhSanXuat = IDLenhSanXuat,
                                  MaHieuDonHang = c.MaHieuDonHang,
                                  MaHieuMatHang = c.MaHieuMatHang,
                                  TenMatHang = c.TenMatHang,
                                  ChieuDai = c.ChieuDai,
                                  ChieuRong = c.ChieuRong,
                                  ChieuCao = c.ChieuCao,
                                  KTTam = c.KTTam,
                                  KichThuoc = c.KichThuoc,
                                  SoLop = c.SoLop,
                                  IDLoaiSongSanXuat = c.IDLoaiSongSanXuat,
                                  KhoGiay = c.KhoGiay,
                                  ChatDai = c.ChatDai,
                                  TongDao = c.TongDao,
                                  Xa = c.Xa,
                                  Le = c.Le,
                                  Tai = c.Tai,
                                  SoLuongHop = c.SoLuongHop,
                                  SoLuongTam = c.SoLuongTam,
                                  DienTichSanXuat = c.DienTichSanXuat,
                                  DienTichXuatBan = c.DienTichXuatBan,
                                  SoLuong = c.SoLuong,
                                  KiHieuCoCauGiay = c.KiHieuCoCauGiay,
                                  MoTaCoCauGiay = c.MoTaCoCauGiay,
                                  MaHieuKichThuoc = c.MaHieuKichThuoc,
                                  LoaiKichThuoc = c.LoaiKichThuoc,
                                  TenLoaiSanPham = c.TenLoaiSanPham,
                                  MaHieuCongDoan = c.MaHieuCongDoan,
                                  TenCongDoan = c.TenCongDoan,
                                  SoLuongYeuCau = 0,// c.SoLuongConLaiCanSanXuat,// > 0 ? c.SoLuongConLaiCanSanXuat : c.SoLuongCanSanXuat, ?
                                  SoLuongDatDuoc = 0,
                                  SoLuongLoi = c.SoLuongLoi,
                                  NgayThayDoi = c.NgayThayDoi,
                                  ThuTuUuTien = c.ThuTuThucHienCongDoan,
                                  GhiChu = c.GhiChu,
                                  UserName = c.UserName,
                                  MaMatHang = c.IDMatHang,
                                  QuyDoiMetDai = 0,
                                  ThoiGianSanXuat = 0,
                                  //yc.SoLuongCanSanXuat AS SoLuongYeuCauSanXuatKeHoach,yc.SoLuongConLaiCanSanXuat AS SoLuongYeuCauSanXuatKeHoachConLai
                                  SoLuongYeuCauSanXuatKeHoach = c.SoLuongCanSanXuat,
                                  SoLuongYeuCauSanXuatKeHoachConLai = c.SoLuongConLaiCanSanXuat
                              }).ToList();

            initData.AddRange(filterData);
            initData = initData.OrderBy(p => p.TT).Distinct().ToList();
            //return listLenhSanXuatChiTiet;

            string data = new JavaScriptSerializer().Serialize(initData);
            return data;

        }
        [WebMethod]
        public static string GetLenhSanXuatChiTietDetail(int? IDLenhSanXuat, int? YeuCauSanXuatId)
        {
            var c = new Qlsx_YeuCauSanXuatRepository().GetYeuCauSanXuat(YeuCauSanXuatId);
            var initData = new Sp_Qlsx_LenhSanXuatChiTiet_SelectResult
                            {
                                TT = c.TT,
                                ID = 0,
                                IDYeuCauSanXuat = c.ID,
                                IDLenhSanXuat = IDLenhSanXuat,
                                MaHieuDonHang = c.MaHieuDonHang,
                                MaHieuMatHang = c.MaHieuMatHang,
                                TenMatHang = c.TenMatHang,
                                ChieuDai = c.ChieuDai,
                                ChieuRong = c.ChieuRong,
                                ChieuCao = c.ChieuCao,
                                KTTam = c.KTTam,
                                KichThuoc = c.KichThuoc,
                                SoLop = c.SoLop,
                                IDLoaiSongSanXuat = c.IDLoaiSongSanXuat,
                                KhoGiay = c.KhoGiay,
                                ChatDai = c.ChatDai,
                                TongDao = c.TongDao,
                                Xa = c.Xa,
                                Le = c.Le,
                                Tai = c.Tai,
                                SoLuongHop = c.SoLuongHop,
                                SoLuongTam = c.SoLuongTam,
                                DienTichSanXuat = c.DienTichSanXuat,
                                DienTichXuatBan = c.DienTichXuatBan,
                                SoLuong = c.SoLuong,
                                KiHieuCoCauGiay = c.KiHieuCoCauGiay,
                                MoTaCoCauGiay = c.MoTaCoCauGiay,
                                MaHieuKichThuoc = c.MaHieuKichThuoc,
                                LoaiKichThuoc = c.LoaiKichThuoc,
                                TenLoaiSanPham = c.TenLoaiSanPham,
                                MaHieuCongDoan = c.MaHieuCongDoan,
                                TenCongDoan = c.TenCongDoan,
                                SoLuongYeuCau = 0,// c.SoLuongConLaiCanSanXuat,// > 0 ? c.SoLuongConLaiCanSanXuat : c.SoLuongCanSanXuat, ?
                                SoLuongDatDuoc = 0,
                                SoLuongLoi = c.SoLuongLoi,
                                NgayThayDoi = c.NgayThayDoi,
                                ThuTuUuTien = c.ThuTuThucHienCongDoan,
                                GhiChu = c.GhiChu,
                                UserName = c.UserName,
                                MaMatHang = c.IDMatHang,
                                QuyDoiMetDai = 0,
                                ThoiGianSanXuat = 0,
                                //yc.SoLuongCanSanXuat AS SoLuongYeuCauSanXuatKeHoach,yc.SoLuongConLaiCanSanXuat AS SoLuongYeuCauSanXuatKeHoachConLai
                                SoLuongYeuCauSanXuatKeHoach = c.SoLuongCanSanXuat,
                                SoLuongYeuCauSanXuatKeHoachConLai = c.SoLuongConLaiCanSanXuat
                            };
            return new JavaScriptSerializer().Serialize(initData);
        }


        [WebMethod]
        public static string GetLenhSanXuatChiTietForDetail(int? IDLenhSanXuat)
        {
            return new JavaScriptSerializer().Serialize(new Qlsx_YeuCauSanXuatRepository().GetDanhSachLenhSanXuatChiTiet(IDLenhSanXuat, null, null, null));
        }
        [WebMethod]
        public static string AddOrEditLenhSanXuatAll(string lsYeuCauSanXuat, string ngayTao, string congDoanId, string lenhSanXuatId, string status)
        {
            int lenhSXId = 0;
            var resultData = "";
            var dinhMucResultData = "";
            var indexError = 0;
            string returnMessage = "0";
            try
            {

                lenhSanXuatId = lenhSanXuatId.Trim().Trim('#');
                xRPDataContext dts = new xRPDataContext();
                var yeuCauSanXuatRepository = new Qlsx_YeuCauSanXuatRepository();

                //Thông tin người đăng nhập
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();

                //AddOrEditLenhSanXuat - Tạo lệnh sản xuất.
                int? _lenhSanXuatId = 0;

                int.TryParse(lenhSanXuatId, out lenhSXId);
                //Mã công đoạn
                int _congDoanId = 0;
                int.TryParse(congDoanId, out _congDoanId);
                //    Ngày sản xuất
                var _NgaySanXuat = DateTime.ParseExact(ngayTao, "dd/MM/yyyy", new CultureInfo("en-US"));

                if (lenhSXId < 1)// Thêm mới lệnh sản xuất.
                {   //  Thực hiện thêm mới

                    resultData = dts.Sp_Qlsx_LenhSanXuat_Add_Edit_Deli("ADD", null, _congDoanId, _NgaySanXuat, 0, string.Empty, user.UserId, null, ref _lenhSanXuatId, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                }
                else
                {
                    // _lenhSanXuatId = lenhSXId;
                    var lsx = dts.Qlsx_LenhSanXuats.FirstOrDefault(p => p.ID == lenhSXId);//dts.Sp_Qlsx_LenhSanXuat_Select(1, lenhSXId, null, null, null, null).FirstOrDefault();
                    resultData = dts.Sp_Qlsx_LenhSanXuat_Add_Edit_Deli("EDIT", lenhSXId, lsx.IDCongDoan, _NgaySanXuat, lsx.TinhTrang == -1 ? 0 : lsx.TinhTrang, string.Empty, user.UserId, null, ref _lenhSanXuatId, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                    _lenhSanXuatId = lenhSXId;
                }


                if (_lenhSanXuatId == 0 || _lenhSanXuatId == null)
                {
                    return resultData;
                }
                else if (_lenhSanXuatId > 0 && !string.IsNullOrEmpty(resultData))
                {
                    //if (lenhSXId >= 1)
                    // return resultData;
                    // else
                    return "-" + _lenhSanXuatId;
                }
                else
                {
                    if (!string.IsNullOrEmpty(lsYeuCauSanXuat) && lsYeuCauSanXuat != "[]")
                    {
                        //Danh sách chọn lệnh yêu cầu
                        var results = new JavaScriptSerializer().Deserialize<List<Sp_Qlsx_LenhSanXuatChiTiet_SelectResult>>(lsYeuCauSanXuat);
                        int? lenhSanXuatChiTiet = 0;
                        // var aaa = dts.Sp_Qlsx_LenhSanXuatChiTiet_Add_Edit_Deli("DELBYLSX", null, _lenhSanXuatId, null, null, null, "", user.UserId, null, ref bangKeSanXuatId, Util.GetIP(), Util.GetPCName()).FirstOrDefault();

                        // Duyệt danh sách 
                        foreach (var item in results)
                        {
                            if (item.ID > 0)//Sua
                            {
                                resultData = dts.Sp_Qlsx_LenhSanXuatChiTiet_Add_Edit_Deli("EDIT", item.ID, _lenhSanXuatId, item.IDYeuCauSanXuat, (int)item.TT, item.SoLuongYeuCau, item.QuyDoiMetDai, item.ThoiGianSanXuat, "", user.UserId, null, ref lenhSanXuatChiTiet, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                                if (lenhSanXuatChiTiet == 0)
                                {
                                    return returnMessage + "" + resultData;
                                }
                            }
                            else
                            {
                                //Them moi
                                resultData = dts.Sp_Qlsx_LenhSanXuatChiTiet_Add_Edit_Deli("ADD", null, _lenhSanXuatId, item.IDYeuCauSanXuat, (int)item.TT, item.SoLuongYeuCau, item.QuyDoiMetDai, item.ThoiGianSanXuat, "", user.UserId, null, ref lenhSanXuatChiTiet, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                                if (lenhSanXuatChiTiet == 0)
                                {
                                    return returnMessage + "" + resultData;
                                }
                                //resultData = dts.Sp_Qlsx_PhieuYeuCauVatTu_Add(_lenhSanXuatId, user.UserId).FirstOrDefault().Column1;
                            }

                            if (lenhSanXuatChiTiet < 1)
                            {
                                resultData = "ERROR[ID:" + lenhSanXuatChiTiet + ",IDLenhSanXuat" + _lenhSanXuatId + "]:Cập nhật lệnh sản xuất chi tiết- " + resultData;
                            }
                            else
                            {
                                if (!string.IsNullOrEmpty(item.DanhSachDinhMucVatTu) &&
                                    item.DanhSachDinhMucVatTu != "[]")
                                {
                                    //Danh sách định mức vật tư 
                                    var lsDinhMucVatTu = new JavaScriptSerializer().Deserialize<List<Sp_Qlsx_DinhMucVatTu_SelectResult>>(item.DanhSachDinhMucVatTu);
                                    int? dinhMucVatTu = 0;
                                    // Duyệt danh sách 
                                    foreach (var itemDinhMuc in lsDinhMucVatTu)
                                    {
                                        if (itemDinhMuc.ID > 0)//Sua
                                        {
                                            var data = dts.Sp_Qlsx_DinhMucVatTu_Add_Edit_Deli("EDIT", itemDinhMuc.ID, lenhSanXuatChiTiet, null, itemDinhMuc.IDPhatSinhTieuHaoVatTu, itemDinhMuc.IDVatTu, itemDinhMuc.IDDonViTinh, itemDinhMuc.HeSoTieuHao, itemDinhMuc.SoLuong, user.UserId, null, ref dinhMucVatTu, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                                            if (dinhMucVatTu <= 0)
                                            {
                                                indexError++;
                                                dinhMucResultData += "ERROR[DinhMucVatTuID:" + item.ID + ",IDLenhSanXuatChiTiet" + lenhSanXuatChiTiet + "]:Sửa định mức vật tư- " + data;
                                            }

                                        }
                                        else
                                        {//Them moi
                                            var data = dts.Sp_Qlsx_DinhMucVatTu_Add_Edit_Deli("ADD", null, lenhSanXuatChiTiet, null, itemDinhMuc.IDPhatSinhTieuHaoVatTu, itemDinhMuc.IDVatTu, itemDinhMuc.IDDonViTinh, itemDinhMuc.HeSoTieuHao, itemDinhMuc.SoLuong, user.UserId, null, ref dinhMucVatTu, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                                            if (dinhMucVatTu <= 0)
                                            {
                                                indexError++;
                                                dinhMucResultData += "ERROR[DinhMucVatTuID:" + item.ID + ",IDLenhSanXuatChiTiet" + lenhSanXuatChiTiet + "]:Thêm mới định mức vật tư- " + data;
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        if (lenhSanXuatChiTiet > 0)
                        {
                            //Có lỗi sảy ra khi cập nhật định mức vật tư.
                            if (indexError != 0)
                                return dinhMucResultData;
                            else
                            {
                                //Thêm mới phiếu yêu cầu vật tư.
                                resultData = dts.Sp_Qlsx_PhieuYeuCauVatTu_Add(_lenhSanXuatId, user.UserId).FirstOrDefault().Column1;
                                return _lenhSanXuatId.ToString();
                            }

                        }
                    }
                }


                if (_lenhSanXuatId > 0)
                    return "" + _lenhSanXuatId;
                else
                    return returnMessage;

            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message;
            }
        }


        [WebMethod]
        public static string DeleteLenhSanXuatChiTiet(int? lenhSanXuatChiTietId)
        {
            var dts = new xRPDataContext();
            var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
            var result = dts.Sp_Qlsx_DinhMucVatTu_Deli("DelAll", null, lenhSanXuatChiTietId, user.UserId, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
            if (string.IsNullOrEmpty(result))
                result = dts.Sp_Qlsx_LenhSanXuatChiTiet_Deli("Del0", lenhSanXuatChiTietId, user.UserId, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
            return result;
        }
        [WebMethod]
        public static int? KiemTraVatTu(int? IDVatTu1, float? SoLuongCan1,
                                        int? IDVatTu2, float? SoLuongCan2,
                                        int? IDVatTu3, float? SoLuongCan3,
                                        int? IDVatTu4, float? SoLuongCan4,
                                        int? IDVatTu5, float? SoLuongCan5,
                                        int? IDVatTu6, float? SoLuongCan6,
                                        int? IDVatTu7, float? SoLuongCan7,
                                        int? IDVatTu8, float? SoLuongCan8,
                                        int? IDVatTu9, float? SoLuongCan9,
                                        int? IDVatTu10, float? SoLuongCan10)
        {
            var dts = new xRPDataContext();
            var result = dts.Fc_Kiemtra_VatTu(IDVatTu1, SoLuongCan1,
                                         IDVatTu2, SoLuongCan2,
                                         IDVatTu3, SoLuongCan3,
                                         IDVatTu4, SoLuongCan4,
                                         IDVatTu5, SoLuongCan5,
                                         IDVatTu6, SoLuongCan6,
                                         IDVatTu7, SoLuongCan7,
                                         IDVatTu8, SoLuongCan8,
                                         IDVatTu9, SoLuongCan9,
                                         IDVatTu10, SoLuongCan10);
            return result;
        }


        [WebMethod]
        public static string UpdateEndLenhSanXuat(string lsYeuCauSanXuat, string ngayTao, string nguonLucId, int? lenhSanXuatId)
        {
            int _nguonLucId = 0;
            var resultDataDetail = "";
            try
            {
                xRPDataContext dts = new xRPDataContext();
                var yeuCauSanXuatRepository = new Qlsx_YeuCauSanXuatRepository();
                var _NgayTao = DateTime.ParseExact(ngayTao, "dd/MM/yyyy", new CultureInfo("en-US"));
                //Thông tin người đăng nhập
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                int.TryParse(nguonLucId, out _nguonLucId);
                //Danh sách chọn lệnh yêu cầu cập nhật lệnh sản xuất
                var results = new JavaScriptSerializer().Deserialize<List<Sp_Qlsx_LenhSanXuatChiTiet_SelectResult>>(lsYeuCauSanXuat);
                // Duyệt danh sách 
                foreach (var item in results)
                {
                    //int? outID = 0;
                    var lsxCT = dts.Qlsx_LenhSanXuatChiTiets.FirstOrDefault(p => p.ID == item.ID);
                    lsxCT.SoLuongDatDuoc = item.SoLuongDatDuoc;
                    lsxCT.SoLuongLoi = item.SoLuongLoi;
                    dts.SubmitChanges();
                    //var updateTT = dts.Sp_Qlsx_LenhSanXuatChiTiet_Add_Edit_Deli("EDIT", item.ID, item.IDLenhSanXuat, item.IDYeuCauSanXuat, item.ThuTuUuTien, item.SoLuongYeuCau, item.QuyDoiMetDai, item.ThoiGianSanXuat, "", null, user.UserId, ref outID, Util.GetIP(), Util.GetPCName());

                    //Lấy ra chi tiết bản ghi.
                    //var dataYeuCau = yeuCauSanXuatRepository.GetYeuCauSanXuat(item.IDYeuCauSanXuat);
                    //Khởi tạo giá trị trả về của LenhSanXuatChiTiet Id.
                    int? bangKeSanXuatId = 0;
                    //Thực thi store
                    //Sp_Qlsx_BangKeSanXuat_Add_Edit_Del0 anh sẽ sửa lại một chút, thêm 1 biến truyền vào nữa là @TinhTrang
                    //[3:15:01 PM] Lê Như Hòa: Nếu chỉ cập nhật thì em truyền @TinhTrang = 1; Nếu mà cập nhật và kết thúc em truyền @TinhTrang=2 cho anh nhé
                    resultDataDetail += dts.Sp_Qlsx_BangKeSanXuat_Add_Edit_Deli("ADD", null, item.ID, _NgayTao, _nguonLucId, item.SoLuongDatDuoc, item.SoLuongLoi, "", 2, user.UserId, null, ref bangKeSanXuatId, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                }

                resultDataDetail += dts.Sp_Qlsx_LenhSanXuat_TinhTrang(lenhSanXuatId, _NgayTao, 2, user.UserId.ToString(), Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;

                bool chuaxong = false;

                // Nếu hàm của anh return 1 thì chuaxong=true
                int checkXong = dts.Fc_KiemTra_LenhSanXuat(lenhSanXuatId) != null ? dts.Fc_KiemTra_LenhSanXuat(lenhSanXuatId).Value : 0;
                if (checkXong == 1)
                {
                    chuaxong = true;
                }
                if (chuaxong)
                {
                    return "0";
                }
                else
                {
                    return string.IsNullOrEmpty(resultDataDetail) ? "1" : resultDataDetail;
                }
            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message;
            }
        }
        [WebMethod]
        public static string UpdateLenhSanXuat(string lsYeuCauSanXuat, string ngayTao, string nguonLucId)
        {
            int _nguonLucId = 0;
            string returnMessage = "0";
            try
            {
                xRPDataContext dts = new xRPDataContext();
                var yeuCauSanXuatRepository = new Qlsx_YeuCauSanXuatRepository();
                var _NgayTao = DateTime.ParseExact(ngayTao, "dd/MM/yyyy", new CultureInfo("en-US"));

                //Thông tin người đăng nhập
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();

                int.TryParse(nguonLucId, out _nguonLucId);

                //Danh sách chọn lệnh yêu cầu cập nhật lệnh sản xuất
                var results = new JavaScriptSerializer().Deserialize<List<Sp_Qlsx_LenhSanXuatChiTiet_SelectResult>>(lsYeuCauSanXuat);

                // Duyệt danh sách 
                foreach (var item in results)
                {

                    // int? outID = 0;

                    var lsxCT = dts.Qlsx_LenhSanXuatChiTiets.FirstOrDefault(p => p.ID == item.ID);
                    lsxCT.SoLuongDatDuoc = item.SoLuongDatDuoc;
                    lsxCT.SoLuongLoi = item.SoLuongLoi;
                    dts.SubmitChanges();

                    //var updateTT = dts.Sp_Qlsx_LenhSanXuatChiTiet_Add_Edit_Deli("EDIT", item.ID, item.IDLenhSanXuat, item.IDYeuCauSanXuat, item.ThuTuUuTien, item.SoLuongYeuCau, lsxCT.QuyDoiMetDai, lsxCT.ThoiGianSanXuat, "", null, user.UserId, ref outID, Util.GetIP(), Util.GetPCName());

                    //Lấy ra chi tiết bản ghi.
                    //var dataYeuCau = yeuCauSanXuatRepository.GetYeuCauSanXuat(item.IDYeuCauSanXuat);
                    //Khởi tạo giá trị trả về của LenhSanXuatChiTiet Id.
                    int? lenhSanXuatChiTiet = 0;
                    //Thực thi store
                    //Sp_Qlsx_BangKeSanXuat_Add_Edit_Del0 anh sẽ sửa lại một chút, thêm 1 biến truyền vào nữa là @TinhTrang
                    //[3:15:01 PM] Lê Như Hòa: Nếu chỉ cập nhật thì em truyền @TinhTrang = 1; Nếu mà cập nhật và kết thúc em truyền @TinhTrang=2 cho anh nhé


                    var resultDataDetail = dts.Sp_Qlsx_BangKeSanXuat_Add_Edit_Deli("ADD", null, item.ID, _NgayTao, _nguonLucId, item.SoLuongDatDuoc, item.SoLuongLoi, "", 1, user.UserId, null, ref lenhSanXuatChiTiet, Util.GetIP(), Util.GetPCName()).FirstOrDefault();

                }

                //// dts.SubmitChanges();
                return returnMessage = "1";

            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message;
            }
        }


        [WebMethod]
        public static string AddOrEditLenhSanXuat(int? ID, string NgaySanXuat, int? IDCongDoan)
        {
            var resultData = "";
            try
            {
                xRPDataContext dts = new xRPDataContext();
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                DateTime? _NgaySanXuat = null;

                if (!String.IsNullOrEmpty(NgaySanXuat))
                    _NgaySanXuat = DateTime.ParseExact(NgaySanXuat, "dd/MM/yyyy", new CultureInfo("en-US"));

                int? _lenhSanXuatId = 0;

                if (ID < 1)// Thêm mới lệnh sản xuất.
                {   //  Thực hiện thêm mới
                    resultData = dts.Sp_Qlsx_LenhSanXuat_Add_Edit_Deli("ADD", null, IDCongDoan, _NgaySanXuat, 0, "", user.UserId, null, ref _lenhSanXuatId, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;

                    //Thêm mới phiếu yêu cầu vật tư.
                    //resultData = dts.Sp_Qlsx_PhieuYeuCauVatTu_Add(_lenhSanXuatId, user.UserId).FirstOrDefault().Column1;
                }
                else
                {
                    // _lenhSanXuatId = lenhSXId;
                    var lsx = dts.Sp_Qlsx_LenhSanXuat_Select(1, ID, null, null, null, null, null, null).FirstOrDefault();
                    resultData = dts.Sp_Qlsx_LenhSanXuat_Add_Edit_Deli("EDIT", ID, lsx.IDCongDoan, lsx.NgaySanXuat, lsx.TinhTrang, "", user.UserId, null, ref _lenhSanXuatId, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;

                    //resultData = dts.Sp_Qlsx_PhieuYeuCauVatTu_Add(_lenhSanXuatId, user.UserId).FirstOrDefault().Column1;
                }
                if (_lenhSanXuatId > 0) return _lenhSanXuatId.ToString();
                else return resultData;

            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message;
            }

        }
        [WebMethod]
        public static string DeleteLenhSanXuat(int? ID)
        {

            try
            {
                using (xRPDataContext dts = new xRPDataContext())
                {
                    //Thông tin người đăng nhập
                    var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                    int? lenhSanXuatID = 0;
                    //Thực thi store
                    var resultDataDetail = dts.Sp_Qlsx_LenhSanXuat_Add_Edit_Deli("DEL1", ID, null, null, null, "", user.UserId, null, ref lenhSanXuatID, Util.GetIP(), Util.GetPCName()).FirstOrDefault();

                    return resultDataDetail.Column1;
                }

            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message;
            }

        }

        //- Kết thúc yêu cầu.
        [WebMethod]
        public static string KetThucYeuCau(int? ID)
        {
            try
            {
                using (xRPDataContext dts = new xRPDataContext())
                {
                    //Thông tin người đăng nhập
                    var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                    //Thực thi store
                    string result = dts.Sp_Qlsx_YeuCauSanXuat_Multi_Task("END", ID, user.UserId, Util.GetIP(), Util.GetPCName()).FirstOrDefault().loi;
                    return result;
                }

            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message;
            }
        }

        //- Hủy yêu cầu
        [WebMethod]
        public static string HuyYeuCau(int? ID)
        {
            try
            {
                using (xRPDataContext dts = new xRPDataContext())
                {
                    var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                    var result = dts.Sp_Qlsx_YeuCauSanXuat_Multi_Task("DEL0", ID, user.UserId, Util.GetIP(), Util.GetPCName()).FirstOrDefault().loi;
                    return result;
                }

            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message;
            }
        }
        [WebMethod]
        public static string HuyHuyYeuCau(int? ID)
        {
            try
            {
                using (xRPDataContext dts = new xRPDataContext())
                {
                    var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                    var result = dts.Sp_Qlsx_YeuCauSanXuat_Multi_Task("UNDODEL", ID, user.UserId, Util.GetIP(), Util.GetPCName()).FirstOrDefault().loi;
                    return result;
                }

            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message;
            }
        }
        [WebMethod]
        public static string HuyKetThucYeuCau(int? ID)
        {
            try
            {
                using (xRPDataContext dts = new xRPDataContext())
                {
                    var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                    var result = dts.Sp_Qlsx_YeuCauSanXuat_Multi_Task("UNDOEND", ID, user.UserId, Util.GetIP(), Util.GetPCName()).FirstOrDefault().loi;
                    return result;
                }

            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message;
            }
        }


        #endregion

        #region Quản lý lệnh sản xuất chi tiết
        [WebMethod]
        public static string AddOrUpdateDinhMucVatTu(int? ID, int? IDLenhSanXuatChiTiet, int? IDPhatSinhTieuHaoVatTu, int? IDVatTu, int? IDDonViTinh, float? HeSoTieuHao, float? SoLuong)
        {
            var resultData = "";
            try
            {
                xRPDataContext dts = new xRPDataContext();
                //Thông tin người đăng nhập
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();

                int? _DinhMucVatTuId = ID == null ? 0 : ID;


                if (ID < 1)// Thêm mới định mức vật tư
                {
                    //  Thực hiện thêm mới
                    resultData = dts.Sp_Qlsx_DinhMucVatTu_Add_Edit_Deli("ADD", null, IDLenhSanXuatChiTiet, null, IDPhatSinhTieuHaoVatTu, IDVatTu, IDDonViTinh, HeSoTieuHao, SoLuong, user.UserId, null, ref _DinhMucVatTuId, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                }
                else
                {
                    _DinhMucVatTuId = 0;
                    resultData = dts.Sp_Qlsx_DinhMucVatTu_Add_Edit_Deli("EDIT", ID, IDLenhSanXuatChiTiet, null, IDPhatSinhTieuHaoVatTu, IDVatTu, IDDonViTinh, HeSoTieuHao, SoLuong, user.UserId, null, ref _DinhMucVatTuId, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;


                }
                if (_DinhMucVatTuId > 0) return _DinhMucVatTuId.ToString();
                else return resultData;

            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message;
            }
        }


        [WebMethod]
        public static string AddOrEditLenhSanXuatChiTiet(int? ID, int? IDYeuCauSanXuat, int? IDLenhSanXuat, int? IDLoaiSongSanXuat, int? SoLuongYeuCau, double? QuyDoiMetDai, double? ThoiGianSanXuat, int? ThuTuUuTien, string GhiChu)
        {

            var resultData = "";
            try
            {
                xRPDataContext dts = new xRPDataContext();
                //Thông tin người đăng nhập
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                int? _IDLenhSanXuatChiTiet = (ID == null ? 0 : ID);
                if (ID < 1)// Thêm mới LenhSanXuatChiTiet
                {
                    //  Thực hiện thêm mới
                    resultData = dts.Sp_Qlsx_LenhSanXuatChiTiet_Add_Edit_Deli("ADD", null, IDLenhSanXuat, IDYeuCauSanXuat, ThuTuUuTien, SoLuongYeuCau, QuyDoiMetDai, ThoiGianSanXuat, GhiChu, user.UserId, null, ref _IDLenhSanXuatChiTiet, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                }
                else
                {
                    _IDLenhSanXuatChiTiet = 0;
                    resultData = dts.Sp_Qlsx_LenhSanXuatChiTiet_Add_Edit_Deli("EDIT", ID, IDLenhSanXuat, IDYeuCauSanXuat, ThuTuUuTien, SoLuongYeuCau, QuyDoiMetDai, ThoiGianSanXuat, GhiChu, user.UserId, null, ref _IDLenhSanXuatChiTiet, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;

                }
                if (_IDLenhSanXuatChiTiet > 0) return _IDLenhSanXuatChiTiet.ToString();
                else return resultData;

            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message;
            }

        }

        [WebMethod]
        public static string AddOrEditLenhSanXuatChiTietAndDinhMuc(int? ID, int? IDYeuCauSanXuat, int? IDLenhSanXuat, int? IDLoaiSongSanXuat, int? SoLuongYeuCau, double? QuyDoiMetDai, double? ThoiGianSanXuat, int? ThuTuUuTien, string GhiChu, string DanhSachDinhMucVatTu, int? DoiPhuongAn)
        {
            var resultData = "";
            var dinhMucResultData = "";
            var indexError = 0;
            try
            {

                xRPDataContext dts = new xRPDataContext();
                var lsDinhMucVatTu = new JavaScriptSerializer().Deserialize<List<Sp_Qlsx_DinhMucVatTu_SelectResult>>(DanhSachDinhMucVatTu);
                //Thông tin người đăng nhập
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                int? _IDLenhSanXuatChiTiet = (ID == null ? 0 : ID);

                //end.

                if (ID < 1)// Thêm mới LenhSanXuatChiTiet
                {
                    //  Thực hiện thêm mới
                    resultData = dts.Sp_Qlsx_LenhSanXuatChiTiet_Add_Edit_Deli("ADD", null, IDLenhSanXuat, IDYeuCauSanXuat, ThuTuUuTien, SoLuongYeuCau, QuyDoiMetDai, ThoiGianSanXuat, GhiChu, user.UserId, null, ref _IDLenhSanXuatChiTiet, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                }
                else
                {
                    _IDLenhSanXuatChiTiet = 0;
                    resultData = dts.Sp_Qlsx_LenhSanXuatChiTiet_Add_Edit_Deli("EDIT", ID, IDLenhSanXuat, IDYeuCauSanXuat, ThuTuUuTien, SoLuongYeuCau, QuyDoiMetDai, ThoiGianSanXuat, GhiChu, user.UserId, null, ref _IDLenhSanXuatChiTiet, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                }
                if (_IDLenhSanXuatChiTiet < 1)
                {
                    resultData = "ERROR[ID:" + ID + ",IDLenhSanXuat" + IDLenhSanXuat + "]:Cập nhật lệnh sản xuất chi tiết- " + resultData;
                }
                else
                {
                    if (ID > 0 && DoiPhuongAn == 1)
                        dts.Sp_Qlsx_DinhMucVatTu_Deli("DELALL", null, null, user.UserId, Util.GetIP(), Util.GetPCName());
                    //Danh sách định mức vật tư 
                    int? dinhMucVatTu = 0;
                    // Duyệt danh sách 
                    foreach (var item in lsDinhMucVatTu)
                    {
                        if (item.ID > 0)//Sua
                        {
                            var data = dts.Sp_Qlsx_DinhMucVatTu_Add_Edit_Deli("EDIT", item.ID, _IDLenhSanXuatChiTiet, null, item.IDPhatSinhTieuHaoVatTu, item.IDVatTu, item.IDDonViTinh, item.HeSoTieuHao, item.SoLuong, user.UserId, null, ref dinhMucVatTu, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                            if (dinhMucVatTu <= 0)
                            {
                                indexError++;
                                dinhMucResultData += "ERROR[DinhMucVatTuID:" + item.ID + ",IDLenhSanXuatChiTiet" + _IDLenhSanXuatChiTiet + "]:Sửa định mức vật tư- " + data;
                            }
                        }
                        else
                        {
                            //Them moi
                            var data = dts.Sp_Qlsx_DinhMucVatTu_Add_Edit_Deli("ADD", null, _IDLenhSanXuatChiTiet, null, item.IDPhatSinhTieuHaoVatTu, item.IDVatTu, item.IDDonViTinh, item.HeSoTieuHao, item.SoLuong, user.UserId, null, ref dinhMucVatTu, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                            if (dinhMucVatTu <= 0)
                            {
                                indexError++;
                                dinhMucResultData += "ERROR[DinhMucVatTuID:" + item.ID + ",IDLenhSanXuatChiTiet" + _IDLenhSanXuatChiTiet + "]:Thêm mới định mức vật tư- " + data;
                            }
                        }
                    }
                }
                if (!string.IsNullOrEmpty(dinhMucResultData)) return dinhMucResultData;
                else if (!string.IsNullOrEmpty(resultData)) return resultData;
                else return _IDLenhSanXuatChiTiet.ToString();

            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message;
            }
        }

        #endregion

        #region In lệnh sản xuất
        protected void LoadInLenhSanXuat()
        {
            //Khuong
            Report.XtraReportViewer reportLenhSanXuat = (Report.XtraReportViewer)this.Page.LoadControl("~/Report/XtraReportViewer.ascx");
            plcContent.Controls.Add(reportLenhSanXuat);
        }
        #endregion In lệnh sản xuất

        #region In phương án
        protected void LoadInPhuongAnVatTu()
        {
            //Khuong
            Report.ReportViewer reportPhuongAn = (Report.ReportViewer)this.Page.LoadControl("~/Report/ReportViewer.ascx");
            plcContent.Controls.Add(reportPhuongAn);
        }
        #endregion In phương án

        #region Phiếu yêu cầu vật tư.

        [WebMethod]
        public static string AddOrEditPhieuYeuCauVatTuAndChiTiet(string ID, int? IDDonViYeuCau, string MaHieuThamChieu, string NgaySuDung, int? TinhTrang, string MaNhaCungCap, string Mota, string lsPhieuYeuCauVatTuChiTiet)
        {
            var resultData = "";
            int phieuYCVTID = 0;
            try
            {
                xRPDataContext dts = new xRPDataContext();
                var phieuYeuCauVatTuRepository = new Qlsx_PhieuYeuCauVatTuRepository();

                //Thông tin người đăng nhập
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();

                int? _phieuYeuCauVatTuId = 0;

                int.TryParse(ID, out phieuYCVTID);
                //    Ngày sử dụng
                var _NgaySuDung = DateTime.ParseExact(NgaySuDung, "dd/MM/yyyy", new CultureInfo("en-US"));

                if (phieuYCVTID < 1)// Thêm mới phiếu yêu cầu vật tư.
                {
                    //  Thực hiện thêm mới
                    resultData += dts.Sp_Qlsx_PhieuYeuCauVatTu_Add_Edit_Deli("ADD", null, MaHieuThamChieu, IDDonViYeuCau, _NgaySuDung, Mota, user.UserId, null, ref _phieuYeuCauVatTuId, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                }
                else
                {
                    _phieuYeuCauVatTuId = phieuYCVTID;
                    resultData += dts.Sp_Qlsx_PhieuYeuCauVatTu_Add_Edit_Deli("EDIT", _phieuYeuCauVatTuId, MaHieuThamChieu, IDDonViYeuCau, _NgaySuDung, Mota, user.UserId, null, ref _phieuYeuCauVatTuId, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                }

                var lsData = new JavaScriptSerializer().Deserialize<List<Sp_Qlsx_PhieuYeuCauVatTuChiTiet_SelectResult>>(lsPhieuYeuCauVatTuChiTiet);

                if (lsData.Count > 0)
                {
                    // Duyệt danh sách 
                    foreach (var item in lsData)
                    {
                        int? _phieuYeuCauVatTuChiTietId = item.ID == null ? 0 : item.ID;
                        if (_phieuYeuCauVatTuChiTietId < 1)// Thêm mới phiếu yêu cầu vật tư chi tiết.
                        {
                            //  Thực hiện thêm mới
                            resultData += dts.Sp_Qlsx_PhieuYeuCauVatTuChiTiet_Add_Edit_Deli("ADD", null, _phieuYeuCauVatTuId, item.IDVatTu, item.IDDonViTinh, item.SoLuongYeuCau, item.GhiChu, item.TinhTrang, user.UserId, null, ref _phieuYeuCauVatTuChiTietId, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                        }
                        else
                        {
                            _phieuYeuCauVatTuChiTietId = item.ID;
                            resultData = dts.Sp_Qlsx_PhieuYeuCauVatTuChiTiet_Add_Edit_Deli("EDIT", _phieuYeuCauVatTuChiTietId, _phieuYeuCauVatTuId, item.IDVatTu, item.IDDonViTinh, item.SoLuongYeuCau, item.GhiChu, TinhTrang, user.UserId, null, ref _phieuYeuCauVatTuChiTietId, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;

                        }

                    }
                }
                return string.IsNullOrEmpty(resultData) == true ? "1" : resultData;

            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message;
            }
        }


        [WebMethod]
        public static string AddOrEditPhieuYeuCauVatTu(string ID, int? IDDonViYeuCau, string MaHieuThamChieu, string NgaySuDung, int? TinhTrang, string MaNhaCungCap, string Mota)
        {
            var resultData = "";
            int phieuYCVTID = 0;
            string returnMessage = "0";
            try
            {
                xRPDataContext dts = new xRPDataContext();
                var phieuYeuCauVatTuRepository = new Qlsx_PhieuYeuCauVatTuRepository();

                //Thông tin người đăng nhập
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();

                int? _phieuYeuCauVatTuId = 0;

                int.TryParse(ID, out phieuYCVTID);
                //    Ngày sử dụng
                var _NgaySuDung = DateTime.ParseExact(NgaySuDung, "dd/MM/yyyy", new CultureInfo("en-US"));

                if (phieuYCVTID < 1)// Thêm mới phiếu yêu cầu vật tư.
                {
                    //  Thực hiện thêm mới
                    resultData = dts.Sp_Qlsx_PhieuYeuCauVatTu_Add_Edit_Deli("ADD", null, MaHieuThamChieu, IDDonViYeuCau, _NgaySuDung, Mota, user.UserId, null, ref _phieuYeuCauVatTuId, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                }
                else
                {
                    _phieuYeuCauVatTuId = phieuYCVTID;
                    resultData = dts.Sp_Qlsx_PhieuYeuCauVatTu_Add_Edit_Deli("EDIT", _phieuYeuCauVatTuId, MaHieuThamChieu, IDDonViYeuCau, _NgaySuDung, Mota, user.UserId, null, ref _phieuYeuCauVatTuId, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                }

                return _phieuYeuCauVatTuId > 0 ? _phieuYeuCauVatTuId.ToString() : resultData;

            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message;
            }
        }

        /*
        [WebMethod]
        public static string AddOrEditPhieuYeuCauVatTu(string ID, int? IDDonViYeuCau, string MaHieuThamChieu, string NgaySuDung, int? TinhTrang, string MaNhaCungCap, string Mota, string PhieuYeuCauChiTiet)
        {
            int phieuYCVTID = 0;
            string returnMessage = "0";
            try
            {
                xRPDataContext dts = new xRPDataContext();
                var phieuYeuCauVatTuRepository = new Qlsx_PhieuYeuCauVatTuRepository();
                int? _phieuYeuCauVatTuChiTietId = 0;
                //Thông tin người đăng nhập
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();


                int? _phieuYeuCauVatTuId = 0;

                int.TryParse(ID, out phieuYCVTID);
                //    Ngày sử dụng
                var _NgaySuDung = DateTime.ParseExact(NgaySuDung, "dd/MM/yyyy", new CultureInfo("en-US"));

                if (phieuYCVTID < 1)// Thêm mới phiếu yêu cầu vật tư.
                {
                    //  Thực hiện thêm mới
                    var resultData = dts.Sp_Qlsx_PhieuYeuCauVatTu_Add_Edit_Deli("ADD", null, MaHieuThamChieu, IDDonViYeuCau, _NgaySuDung, Mota, user.UserId, null, ref _phieuYeuCauVatTuId, Util.GetIP(), Util.GetPCName()).FirstOrDefault();

                }
                else
                {
                    //_phieuYeuCauVatTuId = phieuYCVTID;
                    //var resultData = dts.Sp_Qlsx_PhieuYeuCauVatTu_Add_Edit_Deli("EDIT", _phieuYeuCauVatTuId, MaHieuThamChieu, IDDonViYeuCau, _NgaySuDung, Mota, user.UserId, null, ref _phieuYeuCauVatTuId, Util.GetIP(), Util.GetPCName()).FirstOrDefault();


                    //var lsPhieuYeuCauChiTiet = new JavaScriptSerializer().Deserialize<List<Sp_Qlsx_PhieuYeuCauVatTuChiTiet_SelectResult>>(PhieuYeuCauChiTiet);
                   
                    //// Duyệt danh sách 
                    //foreach (var item in lsPhieuYeuCauChiTiet)
                    //{
                    //    //Thực thi store
                    //    if (item.ID < 1)// Thêm mới phiếu yêu cầu vật tư chi tiết.
                    //    {
                    //        //  Thực hiện thêm mới
                    //        var resultDataDetail = dts.Sp_Qlsx_PhieuYeuCauVatTuChiTiet_Add_Edit_Deli("ADD", item.ID, _phieuYeuCauVatTuId, item.IDVatTu, item.IDDonViTinh, (int?)item.SoLuongYeuCau, item.GhiChu, item.TinhTrang, user.UserId, null, ref _phieuYeuCauVatTuChiTietId, Util.GetIP(), Util.GetPCName()).FirstOrDefault();
                    //    }
                    //    else
                    //    {
                    //        var resultDataDetail = dts.Sp_Qlsx_PhieuYeuCauVatTuChiTiet_Add_Edit_Deli("EDIT", item.ID, _phieuYeuCauVatTuId, item.IDVatTu, item.IDDonViTinh, (int?)item.SoLuongYeuCau, item.GhiChu, 0, user.UserId, null, ref _phieuYeuCauVatTuChiTietId, Util.GetIP(), Util.GetPCName()).FirstOrDefault();

                    //    }
                    //}
                }
                return returnMessage = "" + _phieuYeuCauVatTuId;

            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message;
            }
        }
         
         */
        #endregion

        #region Phiếu yêu cầu vật tư chi tiết.
        [WebMethod]
        public static string AddOrEditPhieuYeuCauVatTuChiTiet(int? ID, int? IDPhieuYeuCauVatTu, int? IDVatTu, int? IDDonViTinh, int? SoLuongYeuCau, string GhiChu, int? TinhTrang)
        {
            int phieuYCVTCTID = 0;
            var resultData = "";
            string returnMessage = "0";
            try
            {
                xRPDataContext dts = new xRPDataContext();
                var phieuYeuCauVatTuRepository = new Qlsx_PhieuYeuCauVatTuRepository();

                //Thông tin người đăng nhập
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();


                int? _phieuYeuCauVatTuChiTietId = ID == null ? 0 : ID;


                if (_phieuYeuCauVatTuChiTietId < 1)// Thêm mới phiếu yêu cầu vật tư chi tiết.
                {
                    //  Thực hiện thêm mới
                    resultData = dts.Sp_Qlsx_PhieuYeuCauVatTuChiTiet_Add_Edit_Deli("ADD", null, IDPhieuYeuCauVatTu, IDVatTu, IDDonViTinh, SoLuongYeuCau, GhiChu, TinhTrang, user.UserId, null, ref _phieuYeuCauVatTuChiTietId, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                }
                else
                {
                    _phieuYeuCauVatTuChiTietId = phieuYCVTCTID;
                    resultData = dts.Sp_Qlsx_PhieuYeuCauVatTuChiTiet_Add_Edit_Deli("EDIT", _phieuYeuCauVatTuChiTietId, IDPhieuYeuCauVatTu, IDVatTu, IDDonViTinh, SoLuongYeuCau, GhiChu, TinhTrang, user.UserId, null, ref _phieuYeuCauVatTuChiTietId, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;


                }
                return _phieuYeuCauVatTuChiTietId > 0 ? _phieuYeuCauVatTuChiTietId.ToString() : resultData;

            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message;
            }
        }


        [WebMethod]
        public static string DeletePhieuYeuCauVatTu(int ID)
        {
            try
            {
                xRPDataContext dts = new xRPDataContext();
                int? _coCauGiayTheoSong = 0;
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                //var result = dts.Sp_Qlsx_CoCauGiayTheoSong_Add_Edit_Deli("DEL1", itemID, null, null, null, user.UserId, Util.GetIP(), Util.GetPCName()).FirstOrDefault();
                var result = dts.Sp_Qlsx_PhieuYeuCauVatTu_Add_Edit_Deli("DEL1", ID, null, null, null, null, user.UserId, null, ref _coCauGiayTheoSong, Util.GetIP(), Util.GetPCName()).FirstOrDefault();
                if (result != null && !string.IsNullOrEmpty(result.Column1)) return result.Column1;
            }
            catch (Exception)
            {
                return "ERROR";
            }
            return "SUCCESS";
        }


        [WebMethod]
        public static string DeletePhieuYeuCauVatTuChiTiet(int ID)
        {
            try
            {
                xRPDataContext dts = new xRPDataContext();
                int? _coCauGiayTheoSong = 0;
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                //var result = dts.Sp_Qlsx_CoCauGiayTheoSong_Add_Edit_Deli("DEL1", itemID, null, null, null, user.UserId, Util.GetIP(), Util.GetPCName()).FirstOrDefault();
                var result = dts.Sp_Qlsx_PhieuYeuCauVatTuChiTiet_Add_Edit_Deli("DEL0", ID, null, null, null, null, null, null, user.UserId, null, ref _coCauGiayTheoSong, Util.GetIP(), Util.GetPCName()).FirstOrDefault();
                if (result != null && !string.IsNullOrEmpty(result.Column1)) return result.Column1;
            }
            catch (Exception)
            {
                return "ERROR";
            }
            return "SUCCESS";
        }

        #endregion

    }

}