using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;
using xRPRepository;

namespace xRP.Business.QuanLySanXuat.CongDoan
{
    public partial class AddOrEditCongDoan : System.Web.UI.UserControl
    {
        /// <summary>
        /// phamkhuong102
        /// </summary>
        /// 
        #region phamkhuong102
        Qlsx_CongDoanRepository congDoanRepository = new Qlsx_CongDoanRepository();

        public string congDoanId { set; get; }

        protected void Page_Load(object sender, EventArgs e)
        {
            //Kiểm tra mã id
            if (Attributes["param"] != null)
            {
                string URL = Attributes["param"];
                congDoanId = Util.GetParam(URL, "id");
                if (congDoanId != "")
                {
                    int id = 0;
                    if (int.TryParse(congDoanId, out id))
                        LoadData(id);
                    else Response.Redirect(Util.SERVER_NAME + "/Business/QuanLySanXuat/Default.aspx?page=cd", false);
                }
            }

        }
        private void LoadData(int id)
        {
            try
            {
                var dataCongDoan = congDoanRepository.GetCongDoanById(id);
                if (dataCongDoan != null)
                {
                    this.txtMaHieuCongDoan.Text = dataCongDoan.MaHieuCongDoan;
                    this.txtCongDoan.Text = dataCongDoan.TenCongDoan;
                    this.txtDonViPhuTrach.Text = dataCongDoan.TenDonViPhuTrach;
                    this.slcDonViPhuTrach.Value = "" + dataCongDoan.IDDonViPhuTrach;
                    this.ckKichHoat.Checked = dataCongDoan.KichHoat == true ? true : false;
                    this.txtGhiChu.Text = dataCongDoan.GhiChu;

                }

            }
            catch (Exception ex)
            {

            }
        }
        #endregion
    }
}