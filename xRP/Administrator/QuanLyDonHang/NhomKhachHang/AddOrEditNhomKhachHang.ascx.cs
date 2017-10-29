using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;

namespace xRP.Administrator.QuanLyDonHang.NhomKhachHang
{
    public partial class AddOrEditNhomKhachHang : System.Web.UI.UserControl
    {
        public string ID_NhomKhachHang { get; set; }
        public string trang { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            string URL = Attributes["param"];
            ID_NhomKhachHang = Util.GetParam(URL, "id");
            trang = Util.GetParam(URL, "trang");

            if (ID_NhomKhachHang != "" && ID_NhomKhachHang != "-1")
            {
                int id = int.Parse(ID_NhomKhachHang);
                xRPDataContext nhomKhachHang = new xRPDataContext();
                Qldh_NhomKhachHang qlkh = (from c in nhomKhachHang.Qldh_NhomKhachHangs where c.ID == id select c).FirstOrDefault();
                txtNhomKhachHang.Text = qlkh.TenNhomKhachHang;
                txtGhiChu.Text = qlkh.GhiChu;

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