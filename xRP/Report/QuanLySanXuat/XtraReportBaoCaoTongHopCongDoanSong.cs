using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using xRPDAL;
using System.Data.Linq;
using System.Linq;

namespace xRP.Report.QuanLySanXuat
{
    public partial class XtraReportBaoCaoTongHopCongDoanSong : DevExpress.XtraReports.UI.XtraReport
    {
        public XtraReportBaoCaoTongHopCongDoanSong(DateTime start,DateTime end)
        {
            InitializeComponent();
            BindData(start, end);
        }
        protected void BindData(DateTime startDate, DateTime endDate)
        {
            xRPDataContext dataContext = new xRPDataContext();
            objectDataSource1.DataSource = dataContext.sp_Qlsx_TongHopCongDoanSong(startDate.ToString("MM/dd/yyyy"), endDate.ToString("MM/dd/yyyy")).ToList();

            var sysconfig = dataContext.Sys_ThongSoHeThongs;
            string tenCongTy = (from t in sysconfig where t.ThongSo == "TenCongTy" select t.GiaTri).FirstOrDefault();
            string diaChiCongTy = (from t in sysconfig where t.ThongSo == "DiaChiCongTy" select t.GiaTri).FirstOrDefault();
            string dienThoaiCongTy = (from t in sysconfig where t.ThongSo == "DienThoaiLienHe" select t.GiaTri).FirstOrDefault();

            lblTenCongTy.Text = tenCongTy.ToUpper();
            lblDiaChi.Text = diaChiCongTy.ToUpper() ;
            lblTuNgayDenNgay.Text = "Từ ngày " + startDate.ToString("dd/MM/yyyy") + " - " + endDate.ToString("dd/MM/yyyy");
            lblPrinat.Text = "Print at: " + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss");
        }
    }
}
