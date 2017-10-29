using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;

namespace xRP.Administrator.QuanLyVatTu.Kho
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
                    case "dskho": LoadDanhKho(); break;

                }
            }
        }
        [WebMethod]
        public static string TestExist(string maKho)
        {
            xRPDataContext xrp = new xRPDataContext();
            int nhacc = (from c in xrp.Qlvt_KhoVatTus where c.MaHieuKho == maKho && c.Xoa == false select c).Count();

            string daura = "";
            if (nhacc > 0)
            {
                daura = "dung";
            }
            else
            {
                daura = "sai";
            }
            return daura;
        }
        [WebMethod]
        public static string UpdateKho(string id, string maKho, string tenKho, string diaChi, string sodienthoai, string nguoiphutrach, string kichHoat, string ghiChu, string thuocTongKho, string loaiKho)
        {
            try
            {
                int thuoctongkho_temp = 0;
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
                Qlvt_KhoVatTu qlvt = new Qlvt_KhoVatTu();
                int? idd = int.Parse(id) == 0 || int.Parse(id) == -1 ? (int?)null : int.Parse(id);

                if (int.Parse(id) == -1)
                {
                    dataContext.Sp_Qlvt_KhoVatTu_Add_Edit_Deli("ADD", 0, maKho, tenKho, thuoctongkho_temp, bool.Parse(loaiKho), diaChi, sodienthoai, nguoiphutrach, ghiChu, int.Parse(kichHoat), currentUserID, currentUserID, ref idd, Util.GetIP(), Util.GetPCName());
                }
                if (int.Parse(id) > 0)
                {
                    dataContext.Sp_Qlvt_KhoVatTu_Add_Edit_Deli("EDIT", int.Parse(id), maKho, tenKho, thuoctongkho_temp, bool.Parse(loaiKho), diaChi, sodienthoai, nguoiphutrach, ghiChu, int.Parse(kichHoat), currentUserID, currentUserID, ref idd, Util.GetIP(), Util.GetPCName());

                }
            }
            catch (Exception)
            {
                return "ERROR";
            }
            return "SUCCESS";

        }
        [WebMethod]
        public static string XoaKho(int id)
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

                xRPDataContext xrp = new xRPDataContext();
                xrp.Sp_Qlvt_KhoVatTu_Deli("DEL1", id, currentUserID, Util.GetIP(), Util.GetPCName());
                // Qlvt_KhoVatTu qltcxn = (from c in xrp.Qlvt_KhoVatTus where c.ID == id select c).FirstOrDefault();
                //qltcxn.Xoa = true;
                //xrp.SubmitChanges(); 
            }
            catch (Exception)
            {
                return "ERROR";
            }
            return "SUCCESS";
        }
        protected void LoadDanhKho()
        {
            Administrator.QuanLyVatTu.Kho.DanhMucKho danhMucKho = (Administrator.QuanLyVatTu.Kho.DanhMucKho)this.Page.LoadControl("~/Administrator/QuanLyVatTu/Kho/DanhMucKho.ascx");
            plcContent.Controls.Add(danhMucKho);
        }
    }
}