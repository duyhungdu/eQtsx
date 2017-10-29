using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using xRPDAL;

namespace xRP.Administrator.QuanLyVatTu.LoaiVatTu
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadControl();
        }

        protected void LoadControl()
        {
            Administrator.QuanLyVatTu.LoaiVatTu.DanhMucLoaiVatTu danhmucLoaiVatTu = (Administrator.QuanLyVatTu.LoaiVatTu.DanhMucLoaiVatTu)this.Page.LoadControl("~/Administrator/QuanLyVatTu/LoaiVatTu/DanhMucLoaiVatTu.ascx");
            plcContent.Controls.Add(danhmucLoaiVatTu);
        }


        [WebMethod]
        public static string DeleteItem(int itemID)
        {
            try
            {
                //Initial data context variable, this class is declared in .dbml file in xRPDAL namespace
                xRPDataContext dts = new xRPDataContext();
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                var result = dts.Sp_Qlvt_LoaiVatTu_Deli("DEL1", itemID, (user == null ? (Guid?)null : user.UserId), Util.GetIP(), Util.GetPCName()).FirstOrDefault().Column1;
                if (!string.IsNullOrEmpty(result)) return result;
            }
            catch (Exception)
            {
                return "ERROR";
            }
            return "SUCCESS";
        }

        [WebMethod]
        public static string AddOrUpdateItem(int itemID, string maLoai, string tenLoai, string ghiChu)
        {
            try
            {
                //Initial data context variable, this class is declared in .dbml file in xRPDAL namespace
                xRPDataContext dts = new xRPDataContext();
                //Get current user info
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
                int? id = null;
                if (itemID == 0 || itemID == -1)
                { }
                else
                {
                    id = itemID;
                }
                Sp_Qlvt_LoaiVatTu_SelectResult current = null;
                if (id.HasValue)
                    current = dts.Sp_Qlvt_LoaiVatTu_Select(1, id.Value, "", null, null, "").FirstOrDefault();
                string result = dts.Sp_Qlvt_LoaiVatTu_Add_Edit_Deli(!id.HasValue ? "ADD" : "EDIT", id, maLoai, tenLoai, "", ghiChu,
                   current == null || !current.KichHoat.HasValue ? 1 : (current.KichHoat.Value ? 1 : 0),
                    current != null ? current.MaNguoiTao : user.UserId, current != null ? user.UserId : (Guid?)null, ref id, "IP", "PC").FirstOrDefault().Column1;
                return result != null && result != "" ? result : id.ToString();
            }
            catch (Exception ex)
            {
                return "ERROR: " + ex.Message + ex.StackTrace;
            }
        }


    }
}