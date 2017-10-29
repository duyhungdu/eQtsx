using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;

namespace xRP.Administrator.QuanLyVatTu.NhaCungCap
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
                    case "dsnhacungcap": LoadDanhSachNhaCungCap(); break;

                }
            }
        }
        [WebMethod]
        public static string TestExist(string manhacungcap)
        {
            xRPDataContext xrp = new xRPDataContext();
            int nhacc = (from c in xrp.Qlvt_NhaCungCaps where c.MaHieuNhaCungCap == manhacungcap && c.Xoa == false  select c).Count();

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
        public static string UpdateNhaCungCap(string id, string manhacc, string tennhacungcap,
            string diaChi, string sodienthoai, string somayfax, string email, string taikhoannganhang, string motainganhang, string diachiweb,
            string kichhoat, string ghichu)
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
            xRPDataContext nhacungcap = new xRPDataContext();
            Qlvt_NhaCungCap dalnhacungcap = new Qlvt_NhaCungCap();
            int? idd = int.Parse(id) == 0 || int.Parse(id) == -1 ? (int?)null : int.Parse(id);
            try
            {
                if (int.Parse(id) == -1)
                {
                    nhacungcap.Sp_Qlvt_NhaCungCap_Add_Edit_Deli("ADD", int.Parse(id), manhacc, tennhacungcap, diaChi, sodienthoai, taikhoannganhang, motainganhang, email, somayfax, diachiweb, ghichu, int.Parse(kichhoat), currentUserID, currentUserID, ref idd,Util.GetIP(),Util.GetPCName());
                }
                if(int.Parse(id) > 0)
                {
                    nhacungcap.Sp_Qlvt_NhaCungCap_Add_Edit_Deli("EDIT", int.Parse(id), manhacc, tennhacungcap, diaChi, sodienthoai, taikhoannganhang, motainganhang, email, somayfax, diachiweb, ghichu, int.Parse(kichhoat), currentUserID, currentUserID, ref idd, Util.GetIP(), Util.GetPCName());
                }

            }
            catch (Exception)
            {
                return "ERROR";
            }
            return "SUCCESS";
        }
        [WebMethod]
        public static string DeleteItem(int itemID)
        {
            try
            {
                //Initial data context variable, this class is declared in .dbml file in xRPDAL namespace
                xRPDataContext dts = new xRPDataContext();
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
                dts.Sp_Qlvt_NhaCungCap_Deli("DEL1", itemID, currentUserID, Util.GetIP(), Util.GetPCName());
                //Qlvt_NhaCungCap nhacc = (from t in dts.Qlvt_NhaCungCaps where t.ID == itemID select t).FirstOrDefault();
                //if (nhacc != null) //Check for item exists
                //{
                //    dts.Qlvt_NhaCungCaps.DeleteOnSubmit(nhacc); //Call delete.
                //    dts.SubmitChanges(); // Submit change to data context.
                //}
            }
            catch (Exception)
            {
                return "ERROR";
            }
            return "SUCCESS";
        }
        protected void LoadDanhSachNhaCungCap()
        {
            Administrator.QuanLyVatTu.NhaCungCap.DanhMucNhaCungCap danhMucNhaCungCap = (Administrator.QuanLyVatTu.NhaCungCap.DanhMucNhaCungCap)this.Page.LoadControl("~/Administrator/QuanLyVatTu/NhaCungCap/DanhMucNhaCungCap.ascx");
            plcContent.Controls.Add(danhMucNhaCungCap);
        }
    }
}