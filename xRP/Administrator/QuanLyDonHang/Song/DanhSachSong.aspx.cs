using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;

namespace xRP.Administrator.QuanLyDonHang.Song
{
    public partial class DanhSachSong : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string page = "";
            if (Request.QueryString["page"] != null)
            {
                page = Request.QueryString["page"];
                switch (page)
                {
                    case "dssong": LoadDanhSachSong(); break;

                }
            }
        }
         [WebMethod]
        public static string ThemSong(string id, string tenSong, string heSoTieuHao, string kichHoat, string ghiChu)
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

                if (int.Parse(id) == -1)
                {
                    dataContext.Sp_Qldh_DanhMucSong_Add_Edit_Deli("ADD", int.Parse(id), tenSong, double.Parse(heSoTieuHao), ghiChu, KichHoat, currentUserID, currentUserID, ref idd, Util.GetIP(), Util.GetPCName());
                }
                if (int.Parse(id) > 0)
                {
                    dataContext.Sp_Qldh_DanhMucSong_Add_Edit_Deli("EDIT", int.Parse(id), tenSong, double.Parse(heSoTieuHao), ghiChu, KichHoat, currentUserID, currentUserID, ref idd, Util.GetIP(), Util.GetPCName());
                }
            }
            catch (Exception)
            {
                return "ERROR";
            }
            return "SUCCESS";

        }
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

                var result = dts.Sp_Qldh_DanhMucSong_Deli("DEL1", id, currentUserID,Util.GetIP(),Util.GetPCName());
            }
            catch (Exception)
            {
                return "ERROR";
            }
            return "SUCCESS";
        }
        protected void LoadDanhSachSong()
        {
            Administrator.QuanLyDonHang.Song.DanhMucSong danhmucsong = (Administrator.QuanLyDonHang.Song.DanhMucSong)this.Page.LoadControl("~/Administrator/QuanLyDonHang/Song/DanhMucSong.ascx");
            plcContent.Controls.Add(danhmucsong);
        }
    }
}