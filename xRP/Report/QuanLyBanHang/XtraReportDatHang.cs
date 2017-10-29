using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using xRPDAL;
using System.Data.Linq;
using System.Linq;


namespace xRP.Report.QuanLyBanHang
{
    public partial class XtraReportDatHang : DevExpress.XtraReports.UI.XtraReport
    {
        xRPDataContext dataContext = new xRPDataContext();
        public XtraReportDatHang(int id)
        {
            InitializeComponent();
            BindData(id);
        }
        protected void BindData(int id)
        {
            var donhang = dataContext.Sp_Qldh_DonHang_Select(1, id, null, null, null, null, null, null, null).FirstOrDefault();
            if (donhang != null)
            {

                //Config value
                var sysconfig = dataContext.Sys_ThongSoHeThongs;
                string tenCongTy = (from t in sysconfig where t.ThongSo == "TenCongTy" select t.GiaTri).FirstOrDefault();
                string diaChiCongTy = (from t in sysconfig where t.ThongSo == "DiaChiCongTy" select t.GiaTri).FirstOrDefault();
                string dienThoaiCongTy = (from t in sysconfig where t.ThongSo == "DienThoaiLienHe" select t.GiaTri).FirstOrDefault();

                lblTenCongTy.Text = tenCongTy;
                lblDiaChiCongTy.Text = "Địa chỉ: " + diaChiCongTy;
                lblDienThoaiCongTy.Text = "Số ĐT: " + dienThoaiCongTy;

                lblMaDonHang.Text = donhang.MaHieuDonHang;
                lblKhachHang.Text = donhang.TENKHACHHANG;
                lblNgayDat.Text = donhang.NgayDatHang != null ? donhang.NgayDatHang.Value.ToString("dd/MM/yyyy") : "";
                lblDiaChi.Text = donhang.DiaChi;
                lblDienThoai.Text = donhang.DienThoaiLienHe;
                lblNgayGiaohang.Text = donhang.NgayGiaoHang != null ? donhang.NgayGiaoHang.Value.ToString("dd/MM/yyyy") : "";
                lblGhiChu.Text = donhang.GhiChu;
                lblPhuongThucThanhToan.Text = "CK";
                objectDataSource1.DataSource = dataContext.sp_Baocao_DonHang(id);
            }
        }

    }
}
