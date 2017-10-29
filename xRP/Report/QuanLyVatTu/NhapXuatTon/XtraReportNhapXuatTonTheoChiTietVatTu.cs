using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using System.Data;
using System.Data.Linq;
using System.Linq;
using xRPDAL;
using xRPRepository;

namespace xRP.Report.QuanLyVatTu.NhapXuatTon
{
    public partial class XtraReportNhapXuatTonTheoChiTietVatTu : DevExpress.XtraReports.UI.XtraReport
    {
        public XtraReportNhapXuatTonTheoChiTietVatTu(string lsKhoId, string lsLoaiVatTuId, string lsVatTuId, string lsNhaCungCapId, DateTime? ngayBatDau, DateTime? ngayKetThuc, bool truloi)
        {
            InitializeComponent();
            BindData(lsKhoId, lsLoaiVatTuId, lsVatTuId, lsNhaCungCapId, ngayBatDau, ngayKetThuc, truloi);
        }
        protected void BindData(string lsKhoId, string lsLoaiVatTuId, string lsVatTuId, string lsNhaCungCapId, DateTime? ngayBatDau, DateTime? ngayKetThuc, bool truloi)
        {
            xRPDataContext dataContext = new xRPDataContext();
            Sys_ThongSoHeThongRepository repThongSoHeThong = new Sys_ThongSoHeThongRepository();
            var sysconfig = dataContext.Sys_ThongSoHeThongs;
            string tenCongTy = (from t in sysconfig where t.ThongSo == "TenCongTy" select t.GiaTri).FirstOrDefault();
            string diaChiCongTy = (from t in sysconfig where t.ThongSo == "DiaChiCongTy" select t.GiaTri).FirstOrDefault();
            string dienThoaiCongTy = (from t in sysconfig where t.ThongSo == "DienThoaiLienHe" select t.GiaTri).FirstOrDefault();
            lblTenCongTy.Text = tenCongTy;
            lblDiaChiCongTy.Text = "Địa chỉ: " + diaChiCongTy;
            lblDienThoaiCongTy.Text = "Số ĐT: " + dienThoaiCongTy;
            lblPrintAt.Text = DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss");
            lblNgayHomNay.Text = repThongSoHeThong.GetThongSoHeThong("DiaPhuong", "Hà Nội") + ", ngày" + " " + DateTime.Now.Day.ToString() + " " + "tháng" + " " + DateTime.Now.Month.ToString() + " " + "năm" + " " + DateTime.Now.Year.ToString();
            string ngaybatdau = ngayBatDau != null ? ngayBatDau.Value.ToString("dd/MM/yyyy") : "";
            string ngayketthuc = ngayKetThuc != null ? ngayKetThuc.Value.ToString("dd/MM/yyyy") : "";
            string tungaydenngay = "";
            if (!string.IsNullOrEmpty(ngaybatdau))
            {
                tungaydenngay += "Từ ngày: " + ngaybatdau;
                if (!string.IsNullOrEmpty(ngayketthuc))
                {
                    tungaydenngay += " đến ngày: " + ngayketthuc;
                }

            }
            else
            {
                if (!string.IsNullOrEmpty(ngayketthuc))
                {
                    tungaydenngay += "Tính đến ngày: " + ngayketthuc;
                }
                else
                {
                    tungaydenngay = " ";
                }
            }
            lblTuNgayDenNgay.Text = tungaydenngay;
            if (truloi)
            {
                lblTruLoi.Text = "Số liệu thống kê có trừ lõi";
                objectDataSource1.DataSource = dataContext.Sp_Qlvt_BaoCaoNhapXuatTonTheoVatTu_TruLoi(
                    String.IsNullOrEmpty(lsKhoId) == true ? null : lsKhoId,
                    String.IsNullOrEmpty(lsLoaiVatTuId) == true ? null : lsLoaiVatTuId,
                    String.IsNullOrEmpty(lsVatTuId) == true ? null : lsVatTuId,
                    String.IsNullOrEmpty(lsNhaCungCapId) == true ? null : lsNhaCungCapId,
                    ngayBatDau, ngayKetThuc).ToList();
            }
            else
            {
                lblTruLoi.Text = "Số liệu thống kê không trừ lõi";
                objectDataSource1.DataSource = dataContext.Sp_Qlvt_BaoCaoNhapXuatTonTheoVatTu(
                      String.IsNullOrEmpty(lsKhoId) == true ? null : lsKhoId,
                    String.IsNullOrEmpty(lsLoaiVatTuId) == true ? null : lsLoaiVatTuId,
                    String.IsNullOrEmpty(lsVatTuId) == true ? null : lsVatTuId,
                    String.IsNullOrEmpty(lsNhaCungCapId) == true ? null : lsNhaCungCapId,
                    ngayBatDau, ngayKetThuc).ToList();
            }
        }
    }
}
