using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;

namespace xRP.Administrator.QuanLyDonHang.LoaiSanPham
{
    public partial class AddOrEditLoaiSanPham : System.Web.UI.UserControl
    {
        public string ID_LoaiSanPham { get; set; }
        public string trang { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            string URL = Attributes["param"];
            ID_LoaiSanPham = Util.GetParam(URL, "id");
            trang = Util.GetParam(URL, "trang");

            if (ID_LoaiSanPham != "" && ID_LoaiSanPham != "-1")
            {
                int id = int.Parse(ID_LoaiSanPham);
                xRPDataContext datacontext = new xRPDataContext();
                Qldh_LoaiSanPham qlkh = (from c in datacontext.Qldh_LoaiSanPhams where c.ID == id select c).FirstOrDefault();

                txtTenLoaiSanPham.Text = qlkh.TenLoaiSanPham;
                txtGhiChu.Text = qlkh.GhiChu;
                txtCongThuc.Text = qlkh.CongThucTinhDienTichSanPham;
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