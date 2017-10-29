using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;
namespace xRP.Administrator.QuanLyDonHang.DonHang.XuLyDonHang
{
    public partial class CongDoanSanXuatGiay : System.Web.UI.UserControl
    {
        public int ID_DonHang = 0, ID_MatHang = 0, CongDoanCuoi = 0;
        public double SoLuongYeuCau = 0;
        public string SoLuongTon = "";
        public string TenMatHang = "", MaHieuMatHang = "";
        xRPDataContext dts = new xRPDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.Params["mathangid"]))
            {
                int temp = 0;
                if (int.TryParse(Request.Params["mathangid"], out temp))
                {
                    Sp_Qldh_MatHang_SelectResult matHang = dts.Sp_Qldh_MatHang_Select(1, temp, (int?)null, 0, 1, "").FirstOrDefault();

                    if (matHang != null)
                    {
                        ID_MatHang = matHang.ID;
                        ID_DonHang = matHang.IDDonHang.Value;
                        CongDoanCuoi = matHang.IDCongDoanCuoi.HasValue ? matHang.IDCongDoanCuoi.Value : 0;
                        TenMatHang = matHang.TenMatHang;
                        MaHieuMatHang = matHang.MaHieuMatHang;
                        SoLuongYeuCau = matHang.SoLuong.HasValue ? matHang.SoLuong.Value : 0;
                        Sp_Qlvt_DonViTinh_SelectResult dvt = dts.Sp_Qlvt_DonViTinh_Select(1, matHang.IDDonVitinh.Value, null, null, "").FirstOrDefault();
                        SoLuongTon = (matHang.SoLuongTon.HasValue ? matHang.SoLuongTon.Value : 0).ToString() + " " + dvt.DonViTinh;
                    }
                }
            }
        }
    }
}