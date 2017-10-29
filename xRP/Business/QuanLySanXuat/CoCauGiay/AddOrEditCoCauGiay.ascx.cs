using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPRepository;
using xRPRepository;

namespace xRP.Business.QuanLySanXuat.CoCauGiay
{
    public partial class AddOrEditCoCauGiay : System.Web.UI.UserControl
    {

        Qlsx_CoCauGiayTheoSongRepository coCauGiayRepository = new Qlsx_CoCauGiayTheoSongRepository();
        protected string coCauGiayId = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            //Kiểm tra mã id
            if (Attributes["param"] != null)
            {
                string URL = Attributes["param"];
                coCauGiayId = Util.GetParam(URL, "id");
                if (coCauGiayId != "")
                {
                    int id = 0;
                    if (int.TryParse(coCauGiayId, out id))
                        LoadData(id);
                    else Response.Redirect(Util.SERVER_NAME + "/Business/QuanLySanXuat/Default.aspx?page=ccg", false);
                }
            }

        }
        private void LoadData(int id)
        {
            try
            {
                var dataCoCauGiay = coCauGiayRepository.GetCoCauGiayById(id);
                if (dataCoCauGiay != null)
                {
                    this.txtIDCoCauGiay.Text = dataCoCauGiay.KiHieuCoCauGiay;
                    this.slcIDCoCauGiay.Value = "" + dataCoCauGiay.IDCoCauGiay;
                    this.txtIDLopGiay.Text = dataCoCauGiay.TenLop;
                    this.slcIDLopGiay.Value = "" + dataCoCauGiay.IDLopGiay;
                    this.txtThuTu.Text = "" + dataCoCauGiay.ThuTu;
                    this.txtLoaiGiay.Text = dataCoCauGiay.TenLoaiVatTu;
                    this.slcLoaiGiay.Value = dataCoCauGiay.IDLoaiGiay.ToString();
                    this.ckKichHoat.Checked = dataCoCauGiay.KichHoat == true ? true : false;
                }

            }
            catch (Exception ex)
            {

            }
        }
    }
}