using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using xRPDAL;
using xRPRepository;
using System.Data.Linq;
using System.Linq;
using System.Collections.Generic;

namespace xRP.Report.QuanLySanXuat
{
    public partial class XtraReportSanXuatTongHop : DevExpress.XtraReports.UI.XtraReport
    {
        public XtraReportSanXuatTongHop(DateTime? start, DateTime? end)
        {
            InitializeComponent();
            BindData(start, end);
        }
        protected void BindData(DateTime? start, DateTime? end)
        {
            xRPDataContext dts = new xRPDataContext();

            objectDataSource1.DataSource = dts.Sp_Qlsx_BaoCaoSanXuatTongHop_Select(null, null, null, start, end).ToList();

            var sysconfig = dts.Sys_ThongSoHeThongs;
            string tenCongTy = (from t in sysconfig where t.ThongSo == "TenCongTy" select t.GiaTri).FirstOrDefault();
            string diaChiCongTy = (from t in sysconfig where t.ThongSo == "DiaChiCongTy" select t.GiaTri).FirstOrDefault();
            string dienThoaiCongTy = (from t in sysconfig where t.ThongSo == "DienThoaiLienHe" select t.GiaTri).FirstOrDefault();

            lblTenCongTy.Text = tenCongTy;
            lblDiaChiCongTy.Text = "Địa chỉ: " + diaChiCongTy;
            lblDienThoaiCongTy.Text = "Số ĐT: " + dienThoaiCongTy;

            string ngaybc = "";
            if (start.HasValue)
            {
                ngaybc += "Từ ngày: " + start.Value.ToString("dd/MM/yyyy");
            }
            if (end.HasValue)
            {
                if (start.HasValue)
                {
                    ngaybc += " - " + end.Value.ToString("dd/MM/yyyy");
                }
                else
                {
                    ngaybc += "Tính đến: " + end.Value.ToString("dd/MM/yyyy");
                }
            }

            if (!string.IsNullOrEmpty(ngaybc))
            {
                lblNgayBaoCao.Text = ngaybc;
            }
            else {
                lblNgayBaoCao.Visible = false;
            }

            lblPrintAt.Text = "Print at: " + DateTime.Now.ToString("dd/MM/yyyy hh:mm");
        }
    }
}
