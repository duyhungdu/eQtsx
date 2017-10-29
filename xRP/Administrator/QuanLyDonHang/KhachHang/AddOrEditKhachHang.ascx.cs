using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;
using xRPRepository;

namespace xRP.Administrator.QuanLyDonHang.KhachHang
{
    public partial class AddOrEditKhachHang : System.Web.UI.UserControl
    {
        public string ID_NhomKH { get; set; }
        public string trang { get; set; }
        public string type { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            loadDrop();
            string URL = Attributes["param"];
            ID_NhomKH = Util.GetParam(URL, "id");
            trang = Util.GetParam(URL, "trang");
            if (Util.GetParam(URL, "type") != null)
            {
                type = Util.GetParam(URL, "type");
            }
            else
            {
                type = "1";
            }

            if (ID_NhomKH != "" && ID_NhomKH != "-1")
            {
                Qldh_KhachHangReposity khachhangReposity = new Qldh_KhachHangReposity();
                var lstKhachHang = khachhangReposity.GetDanhSachKhachHang(0, 0, 0, null,"");

                int id = int.Parse(ID_NhomKH);
                Sp_Qldh_KhachHang_SelectResult qlkh = (from c in lstKhachHang
                                                                   where c.ID==id
                                                                   select new Sp_Qldh_KhachHang_SelectResult
                                       {
                                           ID = c.ID,
                                           MaHieuKhachHang = c.MaHieuKhachHang,
                                           TenKhachHang = c.TenKhachHang,
                                           DiaChi = c.DiaChi,
                                           DienThoaiLienHe = c.DienThoaiLienHe,
                                           SoFax = c.SoFax,
                                           Email = c.Email,
                                           ThongTinLienHe = c.ThongTinLienHe,
                                           GhiChu = c.GhiChu,
                                           IDNhomKhachHang = c.IDNhomKhachHang,
                                           KichHoat = c.KichHoat
                                       }).FirstOrDefault();

                txtMaKhachHang.Text = qlkh.MaHieuKhachHang;
                txtTenKhachHang.Text = qlkh.TenKhachHang;
                txtDiaChiKhachHang.Text = qlkh.DiaChi;
                txtSoDienThoaiLienHe.Text = qlkh.DienThoaiLienHe;
                txtSoMayFax.Text = qlkh.SoFax;
                txtEmail.Text = qlkh.Email;
                txtNguoiLienLac.Text = qlkh.ThongTinLienHe;
                txtGhiChu.Text = qlkh.GhiChu;
                dropNhomKH.SelectedValue = qlkh.IDNhomKhachHang.Value.ToString();

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
        public void loadDrop()
        {
            xRPDataContext datacontext = new xRPDataContext();
            List<Qldh_NhomKhachHang> lstqlkh = (from c in datacontext.Qldh_NhomKhachHangs  select c).ToList();
            dropNhomKH.DataSource = lstqlkh;
            dropNhomKH.DataValueField = "ID";
            dropNhomKH.DataTextField = "TenNhomKhachHang";
            dropNhomKH.DataBind();
        }
    }
}