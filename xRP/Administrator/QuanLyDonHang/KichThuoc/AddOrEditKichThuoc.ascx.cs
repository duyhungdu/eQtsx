using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;

namespace xRP.Administrator.QuanLyDonHang.KichThuoc
{
    public partial class AddOrEditKichThuoc : System.Web.UI.UserControl
    {
        public string ID_KichThuoc { get; set; }
        public string trang { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            string URL = Attributes["param"];
            ID_KichThuoc = Util.GetParam(URL, "id");
            trang = Util.GetParam(URL, "trang");

            if (ID_KichThuoc != "" && ID_KichThuoc != "-1")
            {
                int id = int.Parse(ID_KichThuoc);
                xRPDataContext datacontext = new xRPDataContext();
                Qldh_LoaiKichThuoc qlkh = (from c in datacontext.Qldh_LoaiKichThuocs where c.ID == id select c).FirstOrDefault();
                txtMaKichThuoc.Text = qlkh.MaHieuKichThuoc;
                txtTenKichThuoc.Text = qlkh.LoaiKichThuoc;
                txtGhiChu.Text = qlkh.GhiChu;
                txtHeSoChatDai.Text = qlkh.HeSoChatDai.ToString();
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