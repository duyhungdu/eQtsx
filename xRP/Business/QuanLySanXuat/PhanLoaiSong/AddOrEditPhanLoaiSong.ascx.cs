using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPRepository;

namespace xRP.Business.QuanLySanXuat.PhanLoaiSong
{
    public partial class AddOrEditPhanLoaiSong : System.Web.UI.UserControl
    {
        Qlsx_PhanLoaiSongRepository phanLoaiSong = new Qlsx_PhanLoaiSongRepository();

        public string phanLoaiSongId { set; get; }
        protected string phanLoaiSongData = "{}";
        protected void Page_Load(object sender, EventArgs e)
        {
            //Kiểm tra mã id
            if (Attributes["param"] != null)
            {
                string URL = Attributes["param"];
                phanLoaiSongId = Util.GetParam(URL, "id");
                if (phanLoaiSongId != "")
                {
                    int id = 0;
                    if (int.TryParse(phanLoaiSongId, out id))
                        LoadData(id);
                    else Response.Redirect(Util.SERVER_NAME + "/Business/QuanLySanXuat/Default.aspx?page=pls", false);
                }
            }

        }
        private void LoadData(int id)
        {
            try
            {
                var _phanLoaiSong = phanLoaiSong.GetPhanLoaiSongById(id);
                if (_phanLoaiSong != null)
                {
                    this.txtKiHieuCoCauGiay.Text = _phanLoaiSong.KiHieuCoCauGiay;
                    this.txtSoLop.Text = "" + _phanLoaiSong.SoLop;
                    this.txtMoTaCoCauGiay.Text = _phanLoaiSong.MoTaCoCauGiay;
                    this.ckKichHoat.Checked = _phanLoaiSong.KichHoat == true ? true : false;
                    this.txtGhiChu.Text = _phanLoaiSong.GhiChu;
                    this.txtKiHieuQuyDoi.Text = _phanLoaiSong.KiHieuQuyDoi;
               
                }

            }
            catch (Exception ex)
            {

            }
        }
    }
}