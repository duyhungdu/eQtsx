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

namespace xRP.Administrator.QuanLyVatTu.VatTu
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadDanhMucVatTu();
        }
        public void LoadDanhMucVatTu()
        {
            Administrator.QuanLyVatTu.VatTu.DanhMucVatTu danhmucvattu = (Administrator.QuanLyVatTu.VatTu.DanhMucVatTu)this.Page.LoadControl("~/Administrator/QuanLyVatTu/VatTu/DanhMucVatTu.ascx");
            plcContent.Controls.Add(danhmucvattu);
        }

        [WebMethod]
        public static string DeleteItem(int itemID)
        {
            xRPDataContext dataContext = new xRPDataContext();
            try
            {
                ////Initial data context variable, this class is declared in .dbml file in xRPDAL namespace
                //var dbContext = new xRPDataContext();
                //var delItem = dbContext.Qlvt_VatTus.FirstOrDefault(i => i.ID == itemID && (i.Xoa != null && !i.Xoa.Value));
                //if (delItem != null) //Check for item exists
                //{
                //    dbContext.Qlvt_VatTus.DeleteOnSubmit(delItem); //Call delete.
                //    dbContext.SubmitChanges(); // Submit change to data context.
                //}
                //dbContext.Dispose();

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

                var result = dataContext.Sp_Qlvt_VatTu_Deli("DEL1", itemID, currentUserID, Util.GetIP(), Util.GetPCName());
            }
            catch (Exception)
            {
                return "ERROR";
            }
            return "SUCCESS";
        }

        [WebMethod]
        public static string AddOrUpdateItem(int itemID, string ma, string ten, int loai, double kichThuoc, double dinhLuong, string donViTinh, bool kichHoat, int tonToiThieu, string ghiChu)
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
                var dbContext = new xRPDataContext();
                int? id = 0;
                var item = dbContext.Qlvt_VatTus.FirstOrDefault(i => i.ID == itemID && (i.Xoa != null && !i.Xoa.Value));
                string result = "";
                int paramKichHoat = kichHoat != true ? 0 : 1;
                if (item == null) //Create new instance of LoaiVatTu
                {
                    result = dbContext.Sp_Qlvt_VatTu_Add_Edit_Deli("ADD", null, loai, ten.Trim(), ma.Trim().ToUpper(), kichThuoc, dinhLuong, int.Parse(donViTinh), ghiChu, tonToiThieu, paramKichHoat, currentUserID, null, ref id, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                }
                else
                {
                    result = dbContext.Sp_Qlvt_VatTu_Add_Edit_Deli("EDIT", itemID, loai, ten.Trim(), ma.Trim().ToUpper(), kichThuoc, dinhLuong, int.Parse(donViTinh), ghiChu, tonToiThieu, paramKichHoat, item.MaNguoiTao, currentUserID, ref id, Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                }
                dbContext.Dispose();
                if (!string.IsNullOrEmpty(result))
                    return result;
            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message;
            }
            return "SUCCESS";
        }
    }
}