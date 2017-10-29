using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;
using xRPRepository;
namespace xRP.Business.QuanLySanXuat.NguonLuc
{
    public partial class AddOrEditNguonLuc : System.Web.UI.UserControl
    {
        /// <summary>
        /// phamkhuong102
        /// </summary>
        /// 
        #region phamkhuong102
        Qlnl_NguonLucRepository nguonLucRepository = new Qlnl_NguonLucRepository();

        public string nguonLucId { set; get; }
        protected string congDoanData = "{}";
        protected void Page_Load(object sender, EventArgs e)
        {
            //Kiểm tra mã id
            if (Attributes["param"] != null)
            {
                string URL = Attributes["param"];
                nguonLucId = Util.GetParam(URL, "id");
                if (nguonLucId != "")
                {
                    int id = 0;
                    if (int.TryParse(nguonLucId, out id))
                        LoadData(id);
                    else Response.Redirect(Util.SERVER_NAME + "/Business/QuanLySanXuat/Default.aspx?page=cd", false);
                }
            }

        }
        private void LoadData(int id)
        {
            try
            {
                var dataNguonLuc = nguonLucRepository.GetNguonLucById(id);
                if (dataNguonLuc != null)
                {
                    this.txtNguonLuc.Text = dataNguonLuc.NguonLuc;
                    this.txtMucTai.Text = dataNguonLuc.MucTai.ToString();
                    this.txtDonViTinh.Text = dataNguonLuc.DonViTinh;
                    this.txtThuocCongDoan.Text = dataNguonLuc.TenCongDoan;
                    this.ckKichHoat.Checked = dataNguonLuc.KichHoat == true ? true : false;
                    this.txtGhiChu.Text = dataNguonLuc.GhiChu;
                    this.slcDonViTinh.Value = "" + dataNguonLuc.IDDonVitinh;
                    this.slcThuocCongDoan.Value = "" + dataNguonLuc.IDCongDoan;
                }
            }
            catch (Exception ex)
            {

            }
        }
        #endregion
    }
}