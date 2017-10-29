using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using xRPDAL;

namespace xRP.Administrator.QuanLyVatTu.TruLoi
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadControl();
        }
        protected void LoadControl()
        {
            Administrator.QuanLyVatTu.TruLoi.DanhMucTruLoi danhMucTruLoi = (Administrator.QuanLyVatTu.TruLoi.DanhMucTruLoi)this.Page.LoadControl("~/Administrator/QuanLyVatTu/TruLoi/DanhMucTruLoi.ascx");
            plcContent.Controls.Add(danhMucTruLoi);
        }
        [WebMethod]
        public static string DeleteItem(int itemID)
        {
            try
            {
                //Initial data context variable, this class is declared in .dbml file in xRPDAL namespace
                xRPDataContext dts = new xRPDataContext();
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
               // var result = dts.Sp_Qlvt_DonViTinh_Deli("DEL1", itemID, (user == null ? (Guid?)null : user.UserId), Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                var result = "";
                if (!string.IsNullOrEmpty(result)) return result;
            }
            catch (Exception)
            {
                return "ERROR";
            }
            return "SUCCESS";
        }

        [WebMethod]
        public static string AddOrEditTruLoi(string id, string maloaivattu, string kichthuoc, string sosanh, string truloi)
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
            string mesage = "";
            try
            {
                int? idd = int.Parse(id) == 0 || int.Parse(id) == -1 ? (int?)null : int.Parse(id);
                if (int.Parse(id) == -1)
                {
                    //Thêm
                }
                if (int.Parse(id) > 0)
                {
                    //Cập nhật
                }
            }
            catch (Exception)
            {
                return "ERROR";
            }
            if (!string.IsNullOrEmpty(mesage))
            {

                return mesage;
            }
            else
            {
                return "SUCCESS";
            }

        }
    }
}