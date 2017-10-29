using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;

namespace xRP.Report.QuanLyBanHang
{
    public partial class XtraReportReportTinhHinhDatHangSanXuatGiaoHang : DevExpress.XtraReports.UI.XtraReport
    {
        public XtraReportReportTinhHinhDatHangSanXuatGiaoHang(int? idKH, int? idDH, int? idMH, DateTime ngayStartDatHang, DateTime ngayEndDatHang, DateTime ngayStartGiaoHang, DateTime ngayEndGiaoHang)
        {
            InitializeComponent();
            BindData(idKH, idDH, idMH, ngayStartDatHang, ngayEndDatHang, ngayStartGiaoHang, ngayEndGiaoHang);
        }
        protected void BindData(int? idKH, int? idDH, int? idMH, DateTime ngayStartDatHang, DateTime ngayEndDatHang, DateTime ngayStartGiaoHang, DateTime ngayEndGiaoHang)
        {

        }

    }
}
