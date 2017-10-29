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

namespace xRP.Business.QuanLyVatTu
{
    public partial class Default : System.Web.UI.Page
    {
        protected string DataKho = "", DataTinhChatXuatNhap;
        private xRPDataContext dts = new xRPDataContext();
       
        protected void Page_Load(object sender, EventArgs e)
        {
            
            string page = "";
            if (Request.QueryString["page"] != null)
            {
                page = Request.QueryString["page"];
                switch (page)
                {
                    #region Nhập

                    case "pktn": LoadDanhSachPhieuKiemTraVatTuNhap(); break;
                    case "aoepktn": LoadAddOrEditPhieuKiemTraVatTuNhap(); break;
                    case "kcsvtn": LoadKCSVatTuNhap(); break;
                    case "vdktn": LoadViewDetailPhieuKiemTraVatTuNhap(); break;
                    #endregion Nhập

                    #region Xuất
                    case "pktx": LoadDanhSachPhieuKiemTraVatTuXuat(); break;
                    case "aoepktx": LoadAddOrEditPhieuKiemTraVatTuXuat(); break;
                    case "kcsvtx": LoadKCSVatTuXuat(); break;
                    case "vdktx": LoadViewDetailPhieuKiemTraVatTuXuat(); break;
                    #endregion Xuất

                    #region Báo cáo nhập xuất tồn vật tư
                    case "ppn": InPhieuNhap(); break;
                    case "ppx": InPhieuXuat(); break;
                    case "bcnxtvt": BaoCaoNhapXuatTon(); break;
                    case "bcnxtvt2": BaoCaoNhapXuatTon2(); break;
                    case "bckdkcs": BaoCaoKhongDatKCS(); break;
                    #endregion kết thúc

                    #region Nhập thành phẩm
                    case "ntp": LoadDanhSachNhapThanhPham(); break;
                    case "cnntp": LoadAddOrEditNhapThanhPham(); break;
                    case "ppntp": LoadPrintPhieuNhapThanhPham(); break;
                    #endregion

                    #region Xuất thành phẩm
                    case "xtp": LoadDanhSachXuatThanhPham(); break;
                    case "cnxtp": LoadAddOrEditXuatThanhPham(); break;
                    case "ppxtp": LoadPrintPhieuXuatThanhPham(); break;
                    #endregion

                    case "bcnxttp": BaoCaoNhapXuatTon(); break;

                }
            }
            var listKho = dts.Sp_Qlvt_VatTu_Select(0, (int?)null, (int?)null, null, (int?)null);
            var listTinhChat = dts.Sp_Qlvt_TinhChatNhapXuat_Select(0, (int?)null, (int?)null, (int?)null);
            DataKho = new JavaScriptSerializer().Serialize(listKho);
            DataTinhChatXuatNhap = new JavaScriptSerializer().Serialize(listTinhChat);
        }
        #region Báo cáo xuất vật tư
        public void InPhieuXuat()
        {
            plcContent.Controls.Add(LoadControl("~/Business/QuanLyVatTu/XuatVatTu/ReportViewerXuat.ascx"));
        }

        #endregion Kết thúc báo cáo xuất vật tư
        #region Báo cáo nhập vật tư
        public void InPhieuNhap()
        {
            //plcContent.Controls.Add(LoadControl("~/Business/QuanLyVatTu/KiemTraVatTuNhap/ReportViewer.ascx"));
            plcContent.Controls.Add(LoadControl("~/Report/XtraReportViewer.ascx"));
        }

        #endregion Kết thúc
        #region Báo cáo nhập xuất tồn
        public void BaoCaoNhapXuatTon()
        {
            plcContent.Controls.Add(LoadControl("~/Report/ReportViewer.ascx"));
        }
        public void BaoCaoNhapXuatTon2()
        {
            plcContent.Controls.Add(LoadControl("~/Report/XtraReportViewer.ascx"));
        }
        public void BaoCaoKhongDatKCS()
        {
            plcContent.Controls.Add(LoadControl("~/Report/ReportViewer.ascx"));
        }

        #endregion Báo cáo nhập xuất tồn


        protected void LoadKCSVatTuNhap()
        {
            Business.QuanLyVatTu.KiemTraVatTuNhap.KCSKiemTraVatTuNhap kCSKiemTraVatTuNhap = (Business.QuanLyVatTu.KiemTraVatTuNhap.KCSKiemTraVatTuNhap)this.Page.LoadControl("~/Business/QuanLyVatTu/KiemTraVatTuNhap/KCSKiemTraVatTuNhap.ascx");
            plcContent.Controls.Add(kCSKiemTraVatTuNhap);
        }
        protected void LoadDanhSachPhieuKiemTraVatTuNhap()
        {
            Business.QuanLyVatTu.KiemTraVatTuNhap.DanhMucPhieuKiemTraVatTuNhap danhMucPhieuKiemTraVatTuNhap = (Business.QuanLyVatTu.KiemTraVatTuNhap.DanhMucPhieuKiemTraVatTuNhap)this.Page.LoadControl("~/Business/QuanLyVatTu/KiemTraVatTuNhap/DanhMucPhieuKiemTraVatTuNhap.ascx");
            plcContent.Controls.Add(danhMucPhieuKiemTraVatTuNhap);
        }
        protected void LoadAddOrEditPhieuKiemTraVatTuNhap()
        {
            Business.QuanLyVatTu.KiemTraVatTuNhap.AddOrEditPhieuKiemTraVatTuNhap addOrEditPhieuKiemTraVatTuNhap = (Business.QuanLyVatTu.KiemTraVatTuNhap.AddOrEditPhieuKiemTraVatTuNhap)this.Page.LoadControl("~/Business/QuanLyVatTu/KiemTraVatTuNhap/AddOrEditPhieuKiemTraVatTuNhap.ascx");
            plcContent.Controls.Add(addOrEditPhieuKiemTraVatTuNhap);
        }
        protected void LoadViewDetailPhieuKiemTraVatTuNhap()
        {
            Business.QuanLyVatTu.KiemTraVatTuNhap.ViewDetailPhieuKiemTraVatTuNhap viewDetailPhieuKiemTraVatTuNhap = (Business.QuanLyVatTu.KiemTraVatTuNhap.ViewDetailPhieuKiemTraVatTuNhap)this.Page.LoadControl("~/Business/QuanLyVatTu/KiemTraVatTuNhap/ViewDetailPhieuKiemTraVatTuNhap.ascx");
            plcContent.Controls.Add(viewDetailPhieuKiemTraVatTuNhap);
        }
        protected void LoadKCSVatTuXuat()
        {
            Business.QuanLyVatTu.XuatVatTu.KCSKiemTraVatTuXuat kCSKiemTraVatTuXuat = (Business.QuanLyVatTu.XuatVatTu.KCSKiemTraVatTuXuat)this.Page.LoadControl("~/Business/QuanLyVatTu/XuatVatTu/KCSKiemTraVatTuXuat.ascx");
            plcContent.Controls.Add(kCSKiemTraVatTuXuat);
        }
        protected void LoadDanhSachPhieuKiemTraVatTuXuat()
        {
            Business.QuanLyVatTu.XuatVatTu.DanhMucPhieuKiemTraVatTuXuat danhMucPhieuKiemTraVatTuXuat = (Business.QuanLyVatTu.XuatVatTu.DanhMucPhieuKiemTraVatTuXuat)this.Page.LoadControl("~/Business/QuanLyVatTu/XuatVatTu/DanhMucPhieuKiemTraVatTuXuat.ascx");
            plcContent.Controls.Add(danhMucPhieuKiemTraVatTuXuat);
        }
        protected void LoadAddOrEditPhieuKiemTraVatTuXuat()
        {
            Business.QuanLyVatTu.XuatVatTu.AddOrEditPhieuKiemTraVatTuXuat addOrEditPhieuKiemTraVatTuXuat = (Business.QuanLyVatTu.XuatVatTu.AddOrEditPhieuKiemTraVatTuXuat)this.Page.LoadControl("~/Business/QuanLyVatTu/XuatVatTu/AddOrEditPhieuKiemTraVatTuXuat.ascx");
            plcContent.Controls.Add(addOrEditPhieuKiemTraVatTuXuat);
        }
        protected void LoadViewDetailPhieuKiemTraVatTuXuat()
        {
            Business.QuanLyVatTu.XuatVatTu.ViewDetailPhieuKiemTraVatTuXuat viewDetailPhieuKTX = (Business.QuanLyVatTu.XuatVatTu.ViewDetailPhieuKiemTraVatTuXuat)this.Page.LoadControl("~/Business/QuanLyVatTu/XuatVatTu/ViewDetailPhieuKiemTraVatTuXuat.ascx");
            plcContent.Controls.Add(viewDetailPhieuKTX);
        }


        #region In nhập, xuất thành phẩm
        protected void LoadPrintPhieuNhapThanhPham()
        {
            Report.ReportViewer reportViewNhapThanhPham = (Report.ReportViewer)this.Page.LoadControl("~/Report/ReportViewer.ascx");
            plcContent.Controls.Add(reportViewNhapThanhPham);
        }

        protected void LoadPrintPhieuXuatThanhPham()
        {
            Report.ReportViewer reportViewXuatThanhPham = (Report.ReportViewer)this.Page.LoadControl("~/Report/ReportViewer.ascx");
            plcContent.Controls.Add(reportViewXuatThanhPham);
        }
        #endregion In nhập, xuất thành phẩm

        #region Nhập thành phẩm
        protected void LoadDanhSachNhapThanhPham()
        {
            Business.QuanLyVatTu.NhapThanhPham.DanhSachNhapThanhPham danhSachNhapThanhPham = (Business.QuanLyVatTu.NhapThanhPham.DanhSachNhapThanhPham)this.Page.LoadControl("~/Business/QuanLyVatTu/NhapThanhPham/DanhSachNhapThanhPham.ascx");
            plcContent.Controls.Add(danhSachNhapThanhPham);
        }
        protected void LoadAddOrEditNhapThanhPham()
        {
            Business.QuanLyVatTu.NhapThanhPham.AddOrEditNhapThanhPham addOrEditNhapThanhPham = (Business.QuanLyVatTu.NhapThanhPham.AddOrEditNhapThanhPham)this.Page.LoadControl("~/Business/QuanLyVatTu/NhapThanhPham/AddOrEditNhapThanhPham.ascx");
            plcContent.Controls.Add(addOrEditNhapThanhPham);
        }
        #endregion

        #region Xuất thành phẩm
        protected void LoadDanhSachXuatThanhPham()
        {
            Business.QuanLyVatTu.XuatThanhPham.DanhSachXuatThanhPham danhSachXuatThanhPham = (Business.QuanLyVatTu.XuatThanhPham.DanhSachXuatThanhPham)this.Page.LoadControl("~/Business/QuanLyVatTu/XuatThanhPham/DanhSachXuatThanhPham.ascx");
            plcContent.Controls.Add(danhSachXuatThanhPham);
        }
        protected void LoadAddOrEditXuatThanhPham()
        {
            Business.QuanLyVatTu.XuatThanhPham.AddOrEditXuatThanhPham addOrEditXuatThanhPham = (Business.QuanLyVatTu.XuatThanhPham.AddOrEditXuatThanhPham)this.Page.LoadControl("~/Business/QuanLyVatTu/XuatThanhPham/AddOrEditXuatThanhPham.ascx");
            plcContent.Controls.Add(addOrEditXuatThanhPham);
        }
        #endregion


        [WebMethod]
        public static string DeletePhieuNhap(int ID)
        {
            try
            {
                xRPDataContext dts = new xRPDataContext();
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                var result = dts.Sp_Qlvt_PhieuNhap_Deli("DEL1", ID, user.UserId, Util.GetIP(), Util.GetPCName()).FirstOrDefault();
                if (result != null && !string.IsNullOrEmpty(result.Column1))
                    return result.Column1;
            }
            catch (Exception)
            {
                return "ERROR";
            }
            return "SUCCESS";
        }



        [WebMethod]
        public static string DuyetPhieuNhapThanhPham(int ID)
        {
            try
            {
                xRPDataContext dts = new xRPDataContext();

                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();

                var result = dts.Sp_Qlvt_PhieuNhapThanhPham_TinhTrang(ID, user.UserId, "DUYET", Util.GetIP(), Util.GetPCName()).FirstOrDefault();
                if (result != null && !string.IsNullOrEmpty(result.Column1)) return result.Column1;
                return "Đã duyệt phiêu nhập";
            }
            catch (Exception ex)
            {
                return "ERROR" + ex.Message;
            }
        }


        [WebMethod]
        public static string DuyetPhieuNhap(int ID)
        {
            try
            {
                xRPDataContext dts = new xRPDataContext();

                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();

                var result = dts.Sp_Qlvt_PhieuNhap_TinhTrang(ID, user.UserId, "DUYET", Util.GetIP(), Util.GetPCName()).FirstOrDefault();
                if (result != null && !string.IsNullOrEmpty(result.Column1)) return result.Column1;
                return "Đã duyệt phiêu nhập";
            }
            catch (Exception ex)
            {
                return "ERROR" + ex.Message;
            }
        }

        [WebMethod]
        public static string DeleteChiTietVatTu(int ID)
        {
            string result = "";
            try
            {
                //Initial data context variable, this class is declared in .dbml file in xRPDAL namespace
                xRPDataContext dts = new xRPDataContext();
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                result = dts.Sp_Qlvt_VatTuNhap_Deli("DEL0", ID, user.UserId, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                if (!string.IsNullOrEmpty(result)) return result;
            }
            catch (Exception)
            {
                return "ERROR";
            }
            return "SUCCESS";
        }

        [WebMethod]
        public static string AddOrUpdateVatTuNhap(int ID, int MaVatTu, int MaPhieuNhap, string DonViTinh, float DonGia,
            float SoLuongThucNhap, float SoLuongDauCuon, float SoLuongLamPhieuNhap, float DinhLuongThucTe, float KichThuocThucTe,
            float ChenhLechDinhLuong, float DinhLuongTinhTru, float TruThuaKichThuoc, float KhoiLuongTru, float TruLoi, float SoLuongChenhLechKhongTinh,
            float ThanhTien, int? TinhTrang, float? KichThuocKiemTra, float? DinhLuongKiemTra, float? DoMucKiemTra, float? DoAmKiemTra, string CamQuanKiemTra, string GhiChu, string MaCuon
            )
        {
            string sts = "";
            try
            {

                //Initial data context variable, this class is declared in .dbml file in xRPDAL namespace
                xRPDataContext dts = new xRPDataContext();
                //Get current user info
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();

                Qlvt_VatTuNhap vtnhap = null;
                if (ID > 0) //This item is existed
                    vtnhap = (from t in dts.Qlvt_VatTuNhaps where t.ID == ID select t).FirstOrDefault(); //Get Item
                bool flag = false;
                int donViTinh = (from t in dts.Qlvt_DonViTinhs where t.DonViTinh == DonViTinh select t).FirstOrDefault().ID;
                //int idVatTu = (from t in dts.Qlvt_VatTus where t.MaHieuVatTu == MaHieuVatTu select t).FirstOrDefault().ID;
                int idVatTu = MaVatTu;
                if (vtnhap == null) //Create new instance of LoaiVatTu
                {
                    int? id = 0;
                    string x = dts.Sp_Qlvt_VatTuNhap_Add_Edit_Deli("ADD", null, idVatTu
                        , MaPhieuNhap, 1, donViTinh, DonGia,
                        SoLuongThucNhap, SoLuongDauCuon, SoLuongLamPhieuNhap, DinhLuongThucTe, KichThuocThucTe, ChenhLechDinhLuong, DinhLuongTinhTru,
                        TruThuaKichThuoc, KhoiLuongTru, TruLoi, SoLuongChenhLechKhongTinh, ThanhTien, GhiChu, user.UserId, user.UserId, TinhTrang, DinhLuongKiemTra, DoMucKiemTra, DoAmKiemTra, KichThuocKiemTra, CamQuanKiemTra, MaCuon, ref id, Util.GetIP(), Util.GetPCName()
                        ).FirstOrDefault().Column1;

                    flag = true;
                    sts = x == "null" ? "" : x;
                }

                if (vtnhap != null && !flag)
                {
                    int? id = 0;
                    // khương comment vì nỗi
                    string x = dts.Sp_Qlvt_VatTuNhap_Add_Edit_Deli("EDIT", ID, idVatTu,
                        MaPhieuNhap, 1, donViTinh, DonGia,
                       SoLuongThucNhap, SoLuongDauCuon, SoLuongLamPhieuNhap, DinhLuongThucTe, KichThuocThucTe, ChenhLechDinhLuong, DinhLuongTinhTru,
                       TruThuaKichThuoc, KhoiLuongTru, TruLoi, SoLuongChenhLechKhongTinh, ThanhTien, GhiChu, null, user.UserId, TinhTrang, DinhLuongKiemTra, DoMucKiemTra, DoAmKiemTra, KichThuocKiemTra, CamQuanKiemTra, MaCuon, ref id, Util.GetIP(), Util.GetPCName()
                        ).FirstOrDefault().Column1;

                    sts = x == "null" ? "" : x;
                }
            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.StackTrace;
            }
            return string.IsNullOrEmpty(sts) ? "SUCCESS" : sts;
        }

        [WebMethod]
        public static string AddOrUpdatePhieuNhap(int ID, string MaHieuPhieuNhap, int? MaPhieuXuat, string NgayNhap, int? MaNhaCungCap, int MaKhoVatTu, int MaTinhChatNhapXuat,
            int TinhTrang, string GhiChu, int KieuVatTu)
        {
            int? mpx = null;
            if (MaPhieuXuat.HasValue && MaPhieuXuat.Value != 0)
                mpx = MaPhieuXuat.Value;
            int? ncc = null;
            if (MaNhaCungCap.HasValue && MaNhaCungCap.Value != 0)
                ncc = MaNhaCungCap.Value;
            string returnMessage = "";
            DateTime dtNgayNhap = DateTime.Now;
            try
            {
                DateTime.ParseExact(NgayNhap, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            }
            catch (Exception)
            {
                dtNgayNhap = DateTime.Now;
            }
            try
            {

                xRPDataContext dts = new xRPDataContext();
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                var tc = dts.Qlvt_TinhChatNhapXuats.Where(t => t.ID == MaTinhChatNhapXuat).FirstOrDefault();
                int? id = ID == 0 ? 0 : ID;
                if (ID == 0)
                {
                    returnMessage = dts.Sp_Qlvt_PhieuNhap_Add_Edit_Deli("ADD", (int?)null, dts.fc_SinhMa(tc==null?"":tc.MaTinhChatNhapXuat, "*"), mpx, dtNgayNhap, ncc, MaKhoVatTu, MaTinhChatNhapXuat, KieuVatTu, TinhTrang, GhiChu, user.UserId, user.UserId, (Guid?)null, ref id, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                }
                else
                    returnMessage = dts.Sp_Qlvt_PhieuNhap_Add_Edit_Deli("Edit", ID, MaHieuPhieuNhap, mpx, dtNgayNhap, ncc, MaKhoVatTu, MaTinhChatNhapXuat, KieuVatTu
, TinhTrang, GhiChu, user.UserId, user.UserId, user.UserId, ref id, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
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
        public static string GetVatTuNhap(int idPhieuNhap)
        {
            List<xRPDAL.Sp_Qlvt_VatTuNhap_SelectResult> vtn = new xRPDataContext().Sp_Qlvt_VatTuNhap_Select(2, (int?)null, idPhieuNhap, (int?)null, 0).ToList();
            string data = new JavaScriptSerializer().Serialize(vtn);
            return data;
        }



        [WebMethod]
        public static string GetPhieuNhap(int idPhieuNhap)
        {
            xRPDAL.Sp_Qlvt_PhieuNhap_SelectResult pn = new xRPDataContext().Sp_Qlvt_PhieuNhap_Select(1, idPhieuNhap, 0, (int?)null, (int?)null, (DateTime?)null, (int?)null, null, (int?)null, null, null, null, "").FirstOrDefault();
            if (pn == null) return "";
            else
                return new JavaScriptSerializer().Serialize(pn);
        }

        [WebMethod]
        public static string AddOrUpdatePhieuXuat(int ID, string MaHieuPhieuXuat, string NgayXuat, int? MaDonViNhan, int? MaKhoVatTu,
            int? MaTinhChatNhapXuat, int? MaKhoVatTuDen, int? TinhTrang, string GhiChu, int KieuVatTu)
        {
            string returnMessage = "";
            DateTime dtNgayXuat = DateTime.Now;
            try
            {
                dtNgayXuat = DateTime.ParseExact(NgayXuat, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            }
            catch (Exception ex)
            {
                dtNgayXuat = DateTime.Now;
            }
            try
            {

                xRPDataContext dts = new xRPDataContext();
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                var tc = dts.Qlvt_TinhChatNhapXuats.Where(t => t.ID == MaTinhChatNhapXuat).FirstOrDefault();
                int? id = ID == 0 ? 0 : ID;
                if (ID == 0)
                    returnMessage = dts.Sp_Qlvt_PhieuXuat_Add_Edit_Deli("ADD", (int?)null, dts.fc_SinhMa(tc==null?"":tc.MaTinhChatNhapXuat, "*"), MaDonViNhan, dtNgayXuat, MaKhoVatTu,
                        MaKhoVatTuDen, MaTinhChatNhapXuat, KieuVatTu, TinhTrang, GhiChu, user.UserId, user.UserId, ref id, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                else
                    returnMessage = dts.Sp_Qlvt_PhieuXuat_Add_Edit_Deli("Edit", ID, MaHieuPhieuXuat, MaDonViNhan, dtNgayXuat, MaKhoVatTu,
                        MaKhoVatTuDen, MaTinhChatNhapXuat, KieuVatTu, TinhTrang, GhiChu, (Guid?)null, user.UserId, ref id, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
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
        public static string GetVatTuXuat(int idPhieuXuat)
        {
            List<xRPDAL.Sp_Qlvt_VatTuXuat_SelectResult> vtn = new xRPDataContext().Sp_Qlvt_VatTuXuat_Select(2, (int?)null, idPhieuXuat, 0).ToList();
            string data = new JavaScriptSerializer().Serialize(vtn);
            return data;
        }



        [WebMethod]
        public static string GetVatTuXuatJSON(int idPhieuXuat)
        {
            List<xRPDAL.Sp_Qlvt_VatTuXuat_SelectResult> vtx = new xRPDataContext().Sp_Qlvt_VatTuXuat_Select(2, (int?)null, idPhieuXuat, 0).ToList();
            List<object> list = new List<object>();
            foreach (var vt in vtx)
            {
                list.Add(new
                {
                    data = vt.MaHieuVatTu,
                    value = vt.MaHieuVatTu.Trim() + " - " + vt.TenVatTu,
                    DonViTinh = vt.DonViTinh,
                    ID = vt.ID,
                    IDDonViTinh = vt.IDDonViTinh

                    //data = p.ID,
                    //value = p.MaHieuPhieuXUAT.Trim()
                });
            }
            string data = new JavaScriptSerializer().Serialize(list);
            return data;
        }

        [WebMethod]
        public static string GetVatTuXuatDaDuyetJSON(int idPhieuXuat)
        {
            List<xRPDAL.Sp_Qlvt_VatTuXuat_SelectResult> vtx = new xRPDataContext().Sp_Qlvt_VatTuXuat_Select(2, (int?)null, idPhieuXuat, 0).ToList();
            List<object> list = new List<object>();
            foreach (var vt in vtx)
            {
                list.Add(new
                {
                    data = vt.MaHieuVatTu,
                    value = vt.MaHieuVatTu.Trim() + " - " + vt.TenVatTu,
                    DonViTinh = vt.DonViTinh,
                    ID = vt.ID,
                    IDDonViTinh = vt.IDDonViTinh

                    //data = p.ID,
                    //value = p.MaHieuPhieuXUAT.Trim()
                });
            }
            string data = new JavaScriptSerializer().Serialize(list);
            return data;
        }

        [WebMethod]
        public static string AddOrUpdateVatTuXuat(int ID, int MaVatTuNhap, int MaPhieuXuat, int IDDonViTinh, int? KieuVatTu, float DonGia,
            float SoLuongDauCuonBanDau, float DinhLuongThucTe, float KichThuocThucTe, float ChenhLechDinhLuong, float DinhLuongTinhTru,
            float TruThuaKichThuoc, float KhoiLuongTru, float TruLoi, float SoLuongChenhLechKhongTinh, float SoLuongThucXuat, float SoLuongConLaiCuoiNgay,
            float ThanhTien, string GhiChu
            )
        {
            string sts = "";
            try
            {

                //Initial data context variable, this class is declared in .dbml file in xRPDAL namespace
                xRPDataContext dts = new xRPDataContext();
                //Get current user info
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();

                Qlvt_VatTuXuat vtxuat = null;
                if (ID > 0) //This item is existed
                    vtxuat = (from t in dts.Qlvt_VatTuXuats where t.ID == ID select t).FirstOrDefault(); //Get Item
                bool flag = false;
                if (vtxuat == null)
                {
                    int? id = 0;
                    string x = dts.Sp_Qlvt_VatTuXuat_Add_Edit_Deli("ADD", (int?)null, MaVatTuNhap, IDDonViTinh, DonGia, SoLuongDauCuonBanDau, SoLuongThucXuat,
                        SoLuongConLaiCuoiNgay, DinhLuongThucTe, KichThuocThucTe, ChenhLechDinhLuong, DinhLuongTinhTru, TruThuaKichThuoc, KhoiLuongTru, TruLoi, SoLuongChenhLechKhongTinh,
                        SoLuongThucXuat, ThanhTien, GhiChu, user.UserId, null, MaPhieuXuat, ref id, Util.GetIP(), Util.GetPCName()
                       ).FirstOrDefault().Column1;

                    flag = true;
                    sts = x == "null" ? "" : x;
                }

                if (vtxuat != null && !flag)
                {
                    int? id = 0;
                    string x = dts.Sp_Qlvt_VatTuXuat_Add_Edit_Deli("EDIT", ID, MaVatTuNhap, IDDonViTinh, DonGia, SoLuongDauCuonBanDau, SoLuongThucXuat,
                        SoLuongConLaiCuoiNgay, DinhLuongThucTe, KichThuocThucTe, ChenhLechDinhLuong, DinhLuongTinhTru, TruThuaKichThuoc, KhoiLuongTru, TruLoi, SoLuongChenhLechKhongTinh,
                        SoLuongThucXuat, ThanhTien, GhiChu, null, user.UserId, MaPhieuXuat, ref id, Util.GetIP(), Util.GetPCName()
                        ).FirstOrDefault().Column1;
                    sts = x == "null" ? "" : x;
                }
            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.StackTrace;
            }
            return string.IsNullOrEmpty(sts) ? "SUCCESS" : sts;
        }
        [WebMethod]
        public static string DeletePhieuXuat(int ID)
        {
            try
            {
                xRPDataContext dts = new xRPDataContext();
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                var result = dts.Sp_Qlvt_PhieuXuat_Deli("DEL1", ID, user.UserId, Util.GetIP(), Util.GetPCName()).FirstOrDefault();
                if (result != null && !string.IsNullOrEmpty(result.Column1)) return result.Column1;
            }
            catch (Exception)
            {
                return "ERROR";
            }
            return "SUCCESS";
        }
        [WebMethod]
        public static string DeleteChiTietVatTuXuat(int ID)
        {
            string result = "";
            try
            {
                //Initial data context variable, this class is declared in .dbml file in xRPDAL namespace
                xRPDataContext dts = new xRPDataContext();
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                result = dts.Sp_Qlvt_VatTuXuat_Deli("DEL0", ID, user.UserId, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                if (!string.IsNullOrEmpty(result)) return result;
            }
            catch (Exception)
            {
                return "ERROR";
            }
            return "SUCCESS";
        }
        [WebMethod]
        public static string DuyetPhieuXuatThanhPham(int itemID)
        {
            try
            {
                xRPDataContext dts = new xRPDataContext();
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();

                var result = dts.Sp_Qlvt_PhieuXuatThanhPham_TinhTrang(itemID, user.UserId, "DUYET", Util.GetIP(), Util.GetPCName()).FirstOrDefault();
                if (result != null && !string.IsNullOrEmpty(result.Column1)) return result.Column1;
                return "Đã duyệt phiêu xuất";
            }
            catch (Exception)
            {
                return "ERROR";
            }
        }
        [WebMethod]
        public static string DuyetPhieuXuat(int itemID)
        {
            try
            {
                xRPDataContext dts = new xRPDataContext();

                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();

                var result = dts.Sp_Qlvt_PhieuXuat_TinhTrang(itemID, user.UserId, "DUYET", Util.GetIP(), Util.GetPCName()).FirstOrDefault();
                if (result != null && !string.IsNullOrEmpty(result.Column1)) return result.Column1;
                return "Đã duyệt phiêu xuất";
            }
            catch (Exception)
            {
                return "ERROR";
            }
        }
        [WebMethod]
        public static string GetDSPhieuXuatJSON(int kieuVatTu = (int)EnumPhieuXuat.KieuVatTu.VatTuXuat)
        {
            List<xRPDAL.Sp_Qlvt_PhieuXuat_SelectResult> vtn = new xRPDataContext().Sp_Qlvt_PhieuXuat_Select((int)EnumPhieuXuat.SelectType.All, null, kieuVatTu, null, 1, null, null, "", " NgayXuat DESC").ToList();
            List<object> list = new List<object>();
            foreach (var p in vtn)
            {
                list.Add(new
                {
                    data = p.ID,
                    value = p.MaHieuPhieuXUAT.Trim()
                });
            }
            string data = new JavaScriptSerializer().Serialize(list);
            return data;
        }


        #region WebMethod - Nhập thành phẩm

        [WebMethod]
        public static string GetThanhPhamNhap(int idPhieuNhap)
        {
            var dtc = new xRPDataContext();
            var lsData = (from p in dtc.Sp_Qlvt_ThanhPhamNhap_Select(2, null, idPhieuNhap, null)
                          join mh in dtc.Qldh_MatHangs on p.IDMatHang equals mh.ID
                          //join lkt in dtc.Qldh_LoaiKichThuocs on mh.IDLoaiKichThuoc equals lkt.ID
                          //join lsp in dtc.Qldh_LoaiSanPhams on mh.IDLoaiSanPham equals lsp.ID
                          //join dvt in dtc.Qlvt_DonViTinhs on p.IDDonViTinh equals dvt.ID
                          select new
                          {
                              itemID = p.ID,
                              iDPhieuNhap = idPhieuNhap,
                              iDMatHang = mh.ID,
                              maHieuMatHang = mh.MaHieuMatHang,
                              tenMatHang = mh.TenMatHang,
                              dai = mh.ChieuDai,
                              rong = mh.ChieuRong,
                              cao = mh.ChieuCao,
                              soLop = mh.SoLop,
                              loaiSanPham = mh.Qldh_LoaiSanPham.TenLoaiSanPham,
                              loaiKichThuoc = mh.Qldh_LoaiKichThuoc.LoaiKichThuoc,
                              soLuongNhap = p.SoLuongNhap,
                              iDDonViTinh = p.IDDonViTinh,
                              donViTinh = dtc.Qlvt_DonViTinhs.FirstOrDefault(t => t.ID == p.IDDonViTinh).DonViTinh,
                              donGia = p.DonGia,
                              thanhTien = p.ThanhTien,
                              tinhTrang = p.TinhTrang
                          }).ToList();



            string data = new JavaScriptSerializer().Serialize(lsData);
            return data;
        }
        [WebMethod]
        public static string AddOrEditNhapThanhPhamChiTiet(int? itemID, int iDPhieuNhap, int iDMatHang, int soLuongNhap, int iDDonViTinh, float donGia, float thanhTien, string tinhTrang)
        {
            try
            {
                xRPDataContext dts = new xRPDataContext();
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                var type = itemID > 0 ? "EDIT" : "ADD";
                int? id = 0;
                var _TinhTrang = String.IsNullOrEmpty(tinhTrang) == false ? int.Parse(tinhTrang) : 0;
                var result = dts.Sp_Qlvt_ThanhPhamNhap_Add_Edit_Deli(type, itemID, iDPhieuNhap, iDMatHang, soLuongNhap, iDDonViTinh, donGia, thanhTien, _TinhTrang, user.UserId, null, ref id, Util.GetIP(), Util.GetPCName()).FirstOrDefault();
                if (result != null && !string.IsNullOrEmpty(result.Column1)) return result.Column1;
            }
            catch (Exception)
            {
                return "ERROR";
            }
            return "SUCCESS";
        }
        [WebMethod]
        public static string DeleteNhapThanhPham(int itemID)
        {
            try
            {
                xRPDataContext dts = new xRPDataContext();
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                int? id = 0;
                var result = dts.Sp_Qlvt_ThanhPhamXuat_Add_Edit_Deli("DELETE", itemID, null, null, null, null, null, null, null,null, null, user.UserId, null, ref id, Util.GetIP(), Util.GetPCName()).FirstOrDefault();
                if (result != null && !string.IsNullOrEmpty(result.Column1)) return result.Column1;
            }
            catch (Exception)
            {
                return "ERROR";
            }
            return "SUCCESS";
        }
        #endregion

        #region  WebMethod - Xuất thành phẩm

        [WebMethod]
        public static string GetThanhPhamXuat(int idPhieuXuat)
        {
            var dtc = new xRPDataContext();

            var dataa = dtc.Sp_Qlvt_ThanhPhamXuat_Select(2, null, idPhieuXuat, null, "").ToList();

            var lsData = (from p in dtc.Sp_Qlvt_ThanhPhamXuat_Select(2, null, idPhieuXuat, null, "")
                          join mh in dtc.Qldh_MatHangs on p.IDMatHang equals mh.ID
                          select new
                          {
                              itemID = p.ID,
                              idPhieuXuat = idPhieuXuat,
                              iDMatHang = mh.ID,
                              tenMatHang = mh.TenMatHang,
                              tenXuatBan = p.TenXuatBan,
                              dai = mh.ChieuDai,
                              rong = mh.ChieuRong,
                              cao = mh.ChieuCao,
                              soLop = mh.SoLop,
                              loaiSanPham = mh.Qldh_LoaiSanPham.TenLoaiSanPham,
                              loaiKichThuoc = mh.Qldh_LoaiKichThuoc.LoaiKichThuoc,
                              soLuongXuat = p.SoLuongXuat,
                              iDDonViTinh = p.IDDonViTinh,
                              donViTinh = dtc.Qlvt_DonViTinhs.FirstOrDefault(t => t.ID == p.IDDonViTinh).DonViTinh,
                              donGia = p.DonGia,
                              thanhTien = p.ThanhTien,
                              tinhTrang = p.TinhTrang
                          }).Distinct().ToList();

            string data = new JavaScriptSerializer().Serialize(lsData);
            return data;
        }

        [WebMethod]
        public static string AddOrEditXuatThanhPhamChiTiet(int? itemID, int iDPhieuXuat, int iDMatHang, string tenXuatBan, int iDDonViTinh, double soLuongXuat, double donGia, double thanhTien, string tinhTrang, string ghiChu)
        {
            try
            {
                xRPDataContext dts = new xRPDataContext();
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                var type = itemID > 0 ? "EDIT" : "ADD";
                int? id = 0;
                var _TinhTrang = String.IsNullOrEmpty(tinhTrang) == false ? int.Parse(tinhTrang) : 0;
                var result = dts.Sp_Qlvt_ThanhPhamXuat_Add_Edit_Deli(type, itemID, iDPhieuXuat, iDMatHang, tenXuatBan, soLuongXuat, iDDonViTinh, donGia, thanhTien,ghiChu, _TinhTrang, user.UserId, null, ref id, Util.GetIP(), Util.GetPCName()).FirstOrDefault();
                if (result != null && !string.IsNullOrEmpty(result.Column1)) return result.Column1;
            }
            catch (Exception)
            {
                return "ERROR";
            }
            return "SUCCESS";
        }
        [WebMethod]
        public static string DeleteXuatThanhPham(int itemID)
        {
            try
            {
                int? id = 0;
                xRPDataContext dts = new xRPDataContext();
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                var result = dts.Sp_Qlvt_ThanhPhamXuat_Add_Edit_Deli("DELETE", itemID, null, null, null, null, null, null, null,"", null, user.UserId, null, ref id, Util.GetIP(), Util.GetPCName()).FirstOrDefault();
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