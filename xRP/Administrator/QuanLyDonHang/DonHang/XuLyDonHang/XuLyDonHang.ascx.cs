using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;

namespace xRP.Administrator.QuanLyDonHang.DonHang.XuLyDonHang
{
    public partial class XuLyDonHang : System.Web.UI.UserControl
    {
        public string ID_DonHang { get; set; }
        private Qldh_DonHang currentDonHang = null;
        protected int CurrentTinhTrang = 0;
        protected xRPDataContext dts = new xRPDataContext();
        protected string DataChiTiet = "";
        public string ListDonViTinh = "[]";

        protected void Page_Load(object sender, EventArgs e)
        {
            var listDonViTinh = dts.Sp_Qlvt_DonViTinh_Select(0, (int?)null, 0, 1, "");
            ListDonViTinh = new JavaScriptSerializer().Serialize(listDonViTinh);
            ID_DonHang = Request.QueryString["donhangid"];
            if (ID_DonHang == null) ID_DonHang = "";
            if (ID_DonHang != "" && ID_DonHang != "0")
            {
                int id = 0;
                if (int.TryParse(ID_DonHang, out id))
                    LoadData(id);
                else Response.Redirect(Util.SERVER_NAME + "/Business/QuanLySanXuat/Default.aspx?page=cd", false);
            }
        }
        private void LoadData(int id)
        {
            try
            {
                this.currentDonHang = (from t in dts.Qldh_DonHangs where t.ID == id select t).FirstOrDefault();
                if (this.currentDonHang != null)
                {
                    //ltTitle.Text = "Chỉnh sửa phiếu kiểm tra vật tư nhập: " + this.currentDonHang.MaHieuPhieuNhap;
                    if (this.currentDonHang.Xoa.HasValue && this.currentDonHang.Xoa.Value)
                        Response.Redirect(Util.SERVER_NAME + "/Business/QuanLySanXuat/Default.aspx?page=cd", false);

                    this.lblMaDonHang.Text = this.currentDonHang.MaHieuDonHang;

                    this.CurrentTinhTrang = this.currentDonHang.TinhTrang.HasValue ? this.currentDonHang.TinhTrang.Value : 0;
                }

            }
            catch (Exception ex)
            {
                Response.Write(ex.StackTrace);
                Response.Write(ex.Message);
            }
        }

    }
}