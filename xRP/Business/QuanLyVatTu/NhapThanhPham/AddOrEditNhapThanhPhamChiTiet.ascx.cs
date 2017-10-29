using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;

namespace xRP.Business.QuanLyVatTu.NhapThanhPham
{
    public partial class AddOrEditNhapThanhPhamChiTiet : System.Web.UI.UserControl
    {
        protected string idNhapThanhPham { set; get; }
        protected string tinhtrang { set; get; }
        protected string randID { set; get; }
        protected Qlvt_ThanhPhamNhap currentPhieuNhapThanhPham { set; get; }

        protected void Page_Load(object sender, EventArgs e)
        {

            idNhapThanhPham = Request.QueryString["id"];

            if (Attributes["param"] != null)
            {
                string URL = Attributes["param"];
                idNhapThanhPham = Util.GetParam(URL, "id");
                var phieunhapId = Util.GetParam(URL, "phieunhapid");
                txtRandom.Value = randID = Util.GetParam(URL, "randID"); 

                if (idNhapThanhPham != "")
                {
                    int id = 0;
                    if (int.TryParse(idNhapThanhPham, out id))
                        LoadData(id);
                }
            }
        }

        private void LoadData(int id)
        {
            try
            {
                xRPDataContext dts = new xRPDataContext();
                this.currentPhieuNhapThanhPham = (from t in dts.Qlvt_ThanhPhamNhaps where t.ID == id select t).FirstOrDefault();
                if (this.currentPhieuNhapThanhPham != null)
                {
                    txtIDMatHang.Text = dts.Qldh_MatHangs.FirstOrDefault(p => p.ID == this.currentPhieuNhapThanhPham.IDMatHang).MaHieuMatHang + " - " + dts.Qldh_MatHangs.FirstOrDefault(p => p.ID == this.currentPhieuNhapThanhPham.IDMatHang).TenMatHang;
                    slcIDMatHang.Value = this.currentPhieuNhapThanhPham.IDMatHang.ToString();

                    txtIDDonViTinh.Text = dts.Qlvt_DonViTinhs.FirstOrDefault(p => p.ID == this.currentPhieuNhapThanhPham.IDDonViTinh).DonViTinh;
                    slcIDDonViTinh.Value = this.currentPhieuNhapThanhPham.IDDonViTinh.ToString();

                    txtDonGia.Text = this.currentPhieuNhapThanhPham.DonGia.ToString();
                    txtThanhTien.Text = this.currentPhieuNhapThanhPham.ThanhTien.ToString();
                    tinhtrang = this.currentPhieuNhapThanhPham.TinhTrang.ToString();
                    txtRandom.Value = "-1";//Đã tồn tại giá trị trong hệ thống.
                }
                else
                {
                    tinhtrang = "0";
                }

            }
            catch (Exception ex)
            {
                Response.Write(ex.StackTrace);
                Response.Write(ex.Message);
            }
        }
    }
}