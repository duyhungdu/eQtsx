using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using xRPDAL;
using System.Data.Linq;
using System.Linq;
using xRPRepository;

namespace xRP.Report.QuanLyVatTu.NhapVatTu
{
    public partial class XtraReportNhapKhoNCC : DevExpress.XtraReports.UI.XtraReport
    {
        private Qlvt_PhieuNhap currentPhieuNhap = null;
        private Qlvt_KhoVatTu currentKhoVatTu = null;
        public XtraReportNhapKhoNCC(int id)
        {
            InitializeComponent();
            BindData(id);
        }
        protected void BindData(int id)
        {
            xRPDataContext dts = new xRPDataContext();
            var sysconfig = dts.Sys_ThongSoHeThongs;
            string tenCongTy = (from t in sysconfig where t.ThongSo == "TenCongTy" select t.GiaTri).FirstOrDefault();
            string diaChiCongTy = (from t in sysconfig where t.ThongSo == "DiaChiCongTy" select t.GiaTri).FirstOrDefault();
            string dienThoaiCongTy = (from t in sysconfig where t.ThongSo == "DienThoaiLienHe" select t.GiaTri).FirstOrDefault();

            lblTenCongTy.Text = tenCongTy;
            lblDiaChiCongTy.Text = "Địa chỉ: " + diaChiCongTy;
            lblDienThoaiCongTy.Text = "Số ĐT: " + dienThoaiCongTy;
            string ngayhomnay = new Sys_ThongSoHeThongRepository().GetThongSoHeThong("DiaPhuong", "Hà Nội") + ", ngày" + " " + DateTime.Now.Day.ToString() + " " + "tháng" + " " + DateTime.Now.Month.ToString() + " " + "năm" + " " + DateTime.Now.Year.ToString();
            lblNgayIn.Text = ngayhomnay;
            this.currentPhieuNhap = dts.Qlvt_PhieuNhaps.Where(x => x.ID == id).FirstOrDefault();
            this.currentKhoVatTu = dts.Qlvt_KhoVatTus.Where(x => x.ID == currentPhieuNhap.MaKhoVatTu).FirstOrDefault();
            lblMaPhieuNhap.Text = "Mã phiếu nhập kho: " + currentPhieuNhap.MaHieuPhieuNhap;
            lblNhapTaiKho.Text = "Kho nhập: " + currentKhoVatTu.TenKhoVatTu;
            lblNgayNhapKho.Text = "Ngày nhập kho: " + currentPhieuNhap.NgayNhap.Value.ToString("dd/MM/yyyy");
            lblNoiDung.Text = "Nội dung:" + currentPhieuNhap.GhiChu;
            lblNhaCungCap.Text = "Nhà cung cấp: " + currentPhieuNhap.Qlvt_NhaCungCap.TenNhaCungCap;
            objectDataSource1.DataSource = dts.sp_Baocao_PhieuNhapVatTu(id);
        }
    }
}
