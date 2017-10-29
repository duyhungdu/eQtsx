using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;
using xRPRepository;

namespace xRP.Administrator.QuanLyVatTu.NhaCungCap
{
    public partial class AddOrEditNhaCungCap : System.Web.UI.UserControl
    {
        public string ID_NhaCungCap { get; set; }
        public string trang { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Attributes["param"] != null)
            {
                string URL = Attributes["param"];
                ID_NhaCungCap = Util.GetParam(URL, "id");
                trang = Util.GetParam(URL,"trang");
                if (ID_NhaCungCap != "" && ID_NhaCungCap != "-1")
                {
                    int id = int.Parse(ID_NhaCungCap);
                    xRPDataContext xrp = new xRPDataContext();

                    Qlvt_NhaCungCap qlncc = (from c in xrp.Qlvt_NhaCungCaps where c.ID == id select c).FirstOrDefault();

                    txtMaNCC.Text = qlncc.MaHieuNhaCungCap;
                    txtTenNhaCungCap.Text = qlncc.TenNhaCungCap;
                    txtDiaChiNhaCungCap.Text = qlncc.DiaChi;
                    txtSoDienThoaiLienHe.Text = qlncc.DienThoaiLienHe;
                    txtSoMayFax.Text = qlncc.SoFax;
                    txtEmail.Text = qlncc.Email;
                    txtTaiKhoanNganHang.Text = qlncc.SoTaiKhoan;
                    txtMoTaiNganHang.Text = qlncc.NganHang;
                    txtDiaChiWebsite.Text = qlncc.Url;
                    txtGhiChu.Text = qlncc.GhiChu;
                    if (qlncc.KichHoat.Value == true)
                    {
                        ckKichHoat.Checked = true;
                    }
                    if (qlncc.KichHoat.Value == false)
                    {
                        ckKichHoat.Checked = false;
                    }
                   
                }

            }
        }
    }
}