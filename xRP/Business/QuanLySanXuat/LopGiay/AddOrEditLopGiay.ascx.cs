using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPRepository;
using xRPRepository;

namespace xRP.Business.QuanLySanXuat.LopGiay
{
    public partial class AddOrEditLopGiay : System.Web.UI.UserControl
    {
        Qlsx_TenLopGiayRepository tenLopGiayRepository = new Qlsx_TenLopGiayRepository();

        public string lopGiayId { set; get; }
        protected string congDoanData = "{}";
        protected void Page_Load(object sender, EventArgs e)
        {
            //Kiểm tra mã id
            if (Attributes["param"] != null)
            {
                string URL = Attributes["param"];
                lopGiayId = Util.GetParam(URL, "id");
                if (lopGiayId != "")
                {
                    int id = 0;
                    if (int.TryParse(lopGiayId, out id))
                        LoadData(id);
                    else Response.Redirect(Util.SERVER_NAME + "/Business/QuanLySanXuat/Default.aspx?page=lg", false);
                }
            }

        }
        private void LoadData(int id)
        {
            try
            {
                var dataLopGiay = tenLopGiayRepository.GetTenLopGiayById(id);
                if (dataLopGiay != null)
                {
                    this.txtDanhMucSong.Text = dataLopGiay.TenSong;
                    this.txtTenLop.Text = dataLopGiay.TenLop;
                    this.ckKichHoat.Checked = dataLopGiay.KichHoat == true ? true : false;
                    this.slcDanhMucSong.Value = "" + dataLopGiay.IDDanhMucSong;

                }
            }
            catch (Exception ex)
            {

            }
        }
    }
}