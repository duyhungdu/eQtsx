using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;

namespace xRP.Administrator.QuanLyDonHang.Song
{
    public partial class AddOrEditSong : System.Web.UI.UserControl
    {
        public string ID_Song { get; set; }
        public string trang { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            string URL = Attributes["param"];
            ID_Song = Util.GetParam(URL, "id");
            trang = Util.GetParam(URL, "trang");

            if (ID_Song != "" && ID_Song != "-1")
            {
                int id = int.Parse(ID_Song);
                xRPDataContext datacontext = new xRPDataContext();
                Qldh_DanhMucSong qlkh = (from c in datacontext.Qldh_DanhMucSongs where c.ID == id select c).FirstOrDefault();
                txtTenSong.Text = qlkh.TenSong;
                txtGhiChu.Text = qlkh.GhiChu;
                txtHeSoTieuHao.Text = qlkh.HeSoTieuHao.ToString();
                if (qlkh.KichHoat.Value == true)
                {
                    chkKichHoat.Checked = true;
                }
                if (qlkh.KichHoat.Value == false)
                {
                    chkKichHoat.Checked = false;
                }
            }
        }
    }
}