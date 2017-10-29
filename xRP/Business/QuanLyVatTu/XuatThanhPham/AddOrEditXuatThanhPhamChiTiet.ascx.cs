using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;

namespace xRP.Business.QuanLyVatTu.XuatThanhPham
{
    public partial class AddOrEditXuatThanhPhamChiTiet : System.Web.UI.UserControl
    {
        protected string idXuatThanhPham { set; get; }
        protected string randID { set; get; }
        protected string tinhtrang { set; get; }
        protected Qlvt_ThanhPhamXuat currentPhieuXuatThanhPham { set; get; }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (Attributes["param"] != null)
            {
                string URL = Attributes["param"];
                idXuatThanhPham = Util.GetParam(URL, "id");
                randID = Util.GetParam(URL, "randID");
                var phieuxuatId = Util.GetParam(URL, "phieuxuatid");
                
                if (idXuatThanhPham != "")
                {
                    int id = 0;
                    if (int.TryParse(idXuatThanhPham, out id))
                        LoadData(id);
                }
            }
        }

        private void LoadData(int id)
        {
            try
            {
                xRPDataContext dts = new xRPDataContext();
                this.currentPhieuXuatThanhPham = (from t in dts.Qlvt_ThanhPhamXuats where t.ID == id select t).FirstOrDefault();

                if (this.currentPhieuXuatThanhPham != null)
                {
                    //  txtIDPhieuXuat.Text = dts.Qlvt_PhieuXuats.FirstOrDefault(p => p.ID == this.currentPhieuXuatThanhPham.IDPhieuXuat).MaHieuPhieuXuat;
                    //  slcIDPhieuXuat.Value = this.currentPhieuXuatThanhPham.IDPhieuXuat.ToString();
                    txtIDMatHang.Text = dts.Qldh_MatHangs.FirstOrDefault(p => p.ID == this.currentPhieuXuatThanhPham.IDMatHang).TenMatHang;
                    slcIDMatHang.Value = this.currentPhieuXuatThanhPham.IDMatHang.ToString();
                    txtIDDonViTinh.Text = dts.Qlvt_DonViTinhs.FirstOrDefault(p => p.ID == this.currentPhieuXuatThanhPham.IDDonViTinh).DonViTinh;
                    slcIDDonViTinh.Value = this.currentPhieuXuatThanhPham.IDDonViTinh.ToString();
                    txtSoLuongXuat.Text = this.currentPhieuXuatThanhPham.SoLuongXuat.ToString();
                    txtDonGia.Text = this.currentPhieuXuatThanhPham.DonGia.ToString();
                    txtThanhTien.Text = this.currentPhieuXuatThanhPham.ThanhTien.ToString();
                    tinhtrang = this.currentPhieuXuatThanhPham.TinhTrang.ToString();
                    
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