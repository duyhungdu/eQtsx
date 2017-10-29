using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using xRPDAL;
using xRPRepository;
using System.Globalization;

namespace xRP.Report.QuanLyVatTu.NhapXuatTon
{
    public partial class BaoCaoXuatNhapTonVatTu : System.Web.UI.UserControl
    {

        private Microsoft.Reporting.WebForms.ReportViewer rpViewerData;
        public Microsoft.Reporting.WebForms.ReportViewer ViewerData
        {
            set { rpViewerData = value; }
            get { return rpViewerData; }
        }

        protected Sys_ThongSoHeThongRepository repThongSoHeThong = new Sys_ThongSoHeThongRepository();
        protected void Page_Load(object sender, EventArgs e)
        {
            ltPageTitle.Text = "Báo cáo nhập xuất tồn vật tư";
        }

        protected void LoadBaoCaoNhapXuatTon(string lsKhoId, string lsLoaiVatTuId, string lsVatTuId, DateTime? ngayBatDau, DateTime? ngayKetThuc)
        {

            using (var dts = new xRPDataContext())
            {
                ///Đường đẫn file report.
                rpViewerData.LocalReport.ReportPath = "Report/QuanLyVatTu/NhapXuatTon/ReportNhapXuatTonTheoChiTietVatTu.rdlc";

                var data = dts.Sp_Qlvt_BaoCaoNhapXuatTonTheoVatTu(String.IsNullOrEmpty(lsKhoId) == true ? null : lsKhoId,
                                                                  String.IsNullOrEmpty(lsLoaiVatTuId) == true ? null : lsLoaiVatTuId,
                                                                  String.IsNullOrEmpty(lsVatTuId) == true ? null : lsVatTuId, "0",
                                                                  ngayBatDau, ngayKetThuc).ToList();

                ReportDataSource rpt = new ReportDataSource("dtsNhapXuatTon", data);
                rpViewerData.LocalReport.DataSources.Clear();
                rpViewerData.LocalReport.DataSources.Add(rpt);
                rpViewerData.LocalReport.Refresh();

                ReportParameter[] p = new ReportParameter[3];
                p[0] = new ReportParameter("tencongty", repThongSoHeThong.TenCongTy.ToUpper());
                p[1] = new ReportParameter("diachi", repThongSoHeThong.DiaChiCongTy.ToUpper());
                p[2] = new ReportParameter("sodienthoai", repThongSoHeThong.DienThoaiLienHe.ToUpper());
                // p[3] = new ReportParameter("sodienthoai", ngaysanxuat);
                rpViewerData.LocalReport.SetParameters(p);
            }
        }

        protected void btnReport_Click(object sender, EventArgs e)
        {

            string kho = slcKho.Value.Trim(',');
            string vattu = slcVatTu.Value.Trim(',');
            string ngaybd = txtTuNgay.Text;
            string ngaykt = txtDenNgay.Text;

            DateTime? ngaybatdau = null;

            try
            {
                ngaybatdau = DateTime.ParseExact(ngaybd, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            }
            catch { }

            DateTime? ngayketthuc = null;
            try
            {
                ngayketthuc = DateTime.ParseExact(ngaykt, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            }
            catch { }

            LoadBaoCaoNhapXuatTon(String.IsNullOrEmpty(kho) == true ? null : kho,
                                  null,
                                  String.IsNullOrEmpty(vattu) == true ? null : vattu,
                                  ngaybatdau, ngayketthuc);


        }
    }
}