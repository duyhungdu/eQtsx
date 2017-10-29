using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;

namespace xRP.Administrator.QuanLyVatTu.TinhChatXuatNhap
{
    public partial class Default : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadControl();

        }
        protected void LoadControl()
        {
            Administrator.QuanLyVatTu.TinhChatXuatNhap.DanhMucTinhChatXuatNhap danhmuctinhchatxuatnhap = (Administrator.QuanLyVatTu.TinhChatXuatNhap.DanhMucTinhChatXuatNhap)this.Page.LoadControl("~/Administrator/QuanLyVatTu/TinhChatXuatNhap/DanhMucTinhChatXuatNhap.ascx");
            plcContent.Controls.Add(danhmuctinhchatxuatnhap);
        }

        [WebMethod]
        public static string ThemTinhChatXuatNhap(string id, string tenTinhChat, int phanLoai, string kichHoat, string ghiChu, int lanoibo, string maTinhChatNhapXuat)
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
            Qlvt_TinhChatNhapXuat tinhChatNhapXuat = new Qlvt_TinhChatNhapXuat();
            try
            {
                int? idd = int.Parse(id) == 0 || int.Parse(id) == -1 ? (int?)null : int.Parse(id);
                if (int.Parse(id) == -1)
                {
                    dataContext.Sp_Qlvt_TinhChatNhapXuat_Add_Edit_Deli("ADD", null, tenTinhChat, phanLoai, ghiChu, maTinhChatNhapXuat, int.Parse(kichHoat), currentUserID, currentUserID, ref idd, Util.GetIP(), Util.GetPCName(), lanoibo, (bool?)null);
                }
                if (int.Parse(id) > 0)
                {
                    dataContext.Sp_Qlvt_TinhChatNhapXuat_Add_Edit_Deli("EDIT", int.Parse(id), tenTinhChat, phanLoai, ghiChu, maTinhChatNhapXuat, int.Parse(kichHoat), currentUserID, currentUserID, ref idd, Util.GetIP(), Util.GetPCName(), lanoibo, (bool?)null);
                }
            }
            catch (Exception)
            {
                return "ERROR";
            }
            return "SUCCESS";

        }
        [WebMethod]
        public static string XoaTinhChat(int id)
        {
            xRPDataContext dataContext = new xRPDataContext();
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
            var result = dataContext.Sp_Qlvt_TinhChatNhapXuat_Deli("DEL1", id, currentUserID, Util.GetIP(), Util.GetPCName());
            }
            catch (Exception)
            {
                return "ERROR";
            }
            return "SUCCESS";
        }
    }
}