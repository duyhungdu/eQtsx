using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;

namespace xRP.Administrator.QuanLyDonHang.HeSoTongGiao
{
    public partial class AddorEditHeSoTongGiao : System.Web.UI.UserControl
    {
        public string ID_HeSoTongGiao{ get; set; }
        public string trang { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            string URL = Attributes["param"];
            ID_HeSoTongGiao = Util.GetParam(URL, "id");
            trang = Util.GetParam(URL, "trang");
            if (ID_HeSoTongGiao != "" && ID_HeSoTongGiao != "-1")
            {
                int id = int.Parse(ID_HeSoTongGiao);
                xRPDataContext datacontext = new xRPDataContext();
                Qldh_HeSoTongDao hstg = (from c in datacontext.Qldh_HeSoTongDaos where c.ID == id select c).FirstOrDefault();
                txtGhiChu.Text = hstg.GhiChu;
                txtHeSoTongGiao.Text = hstg.HeSoTongDao.ToString();
                txtSoLop.Text = hstg.SoLop.ToString();
                slcKichThuoc.Value = hstg.IDLoaiKichThuoc.ToString();
                Qldh_LoaiKichThuoc lkt = (from d in datacontext.Qldh_LoaiKichThuocs where d.ID == hstg.IDLoaiKichThuoc select d).FirstOrDefault();
                if (lkt != null)
                {
                    txtKichThuoc.Text = lkt.MaHieuKichThuoc.Trim() + "_" + lkt.LoaiKichThuoc;
                }
                if (hstg.KichHoat.Value == true)
                {
                    chkKichHoat.Checked = true;
                }
                if (hstg.KichHoat.Value == false)
                {
                    chkKichHoat.Checked = false;
                }
            }
        }
    }
}