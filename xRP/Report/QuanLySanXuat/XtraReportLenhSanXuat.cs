using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using xRPDAL;
using xRPRepository;
using System.Collections.Generic;
using System.Data.Linq;
using System.Linq;

namespace xRP.Report.QuanLySanXuat
{
    public partial class XtraReportLenhSanXuat : DevExpress.XtraReports.UI.XtraReport
    {
        public XtraReportLenhSanXuat(int id)
        {
            InitializeComponent();
            BindData(id);
        }
        protected void BindData(int id)
        {
            xRPDataContext dts = new xRPDataContext();
            var lenhSanXuatRepository = new Qlsx_LenhSanXuatRepository();
            var yeuCauSanXuatRepository = new Qlsx_YeuCauSanXuatRepository();
            var lenhSanXuat = lenhSanXuatRepository.GetLenhSanXuatById(id);

            var sysconfig = dts.Sys_ThongSoHeThongs;
            string tenCongTy = (from t in sysconfig where t.ThongSo == "TenCongTy" select t.GiaTri).FirstOrDefault();
            string diaChiCongTy = (from t in sysconfig where t.ThongSo == "DiaChiCongTy" select t.GiaTri).FirstOrDefault();
            string dienThoaiCongTy = (from t in sysconfig where t.ThongSo == "DienThoaiLienHe" select t.GiaTri).FirstOrDefault();

            lblTenCongTy.Text = tenCongTy;
            lblDiaChiCongTy.Text = "Địa chỉ: " + diaChiCongTy;
            lblDienThoaiCongTy.Text = "Số ĐT: " + dienThoaiCongTy;



            List<Sp_Qlsx_LenhSanXuatChiTiet_SelectResult> listLenhSanXuatChiTiet = dts.Sp_Qlsx_LenhSanXuatChiTiet_Select(3, null, null, id, null, null, null).OrderBy(x => x.TT).ToList();
            objectDataSource1.DataSource = listLenhSanXuatChiTiet;
            double tongmetdai = 0;
            double thoigiansanxuat = 0;
            foreach (Sp_Qlsx_LenhSanXuatChiTiet_SelectResult ct in listLenhSanXuatChiTiet)
            {
                tongmetdai += ct.QuyDoiMetDai != null ? ct.QuyDoiMetDai.Value : 0;
                thoigiansanxuat += ct.QuyDoiMetDai != null ? (ct.QuyDoiMetDai.Value / int.Parse(dts.Sys_ThongSoHeThongs.Where(x => x.ThongSo == "CONGSUATMAYSONG").FirstOrDefault().GiaTri)) : 0;
            }
            string thoigiantext = "0h 0' 0s";
            var time = Math.Floor(thoigiansanxuat);
            var minute = (thoigiansanxuat - time) * 60;
            var second = (minute - Math.Floor(minute)) * 60;
            if (Math.Round(second) == 60)
            {
                second = 0;
                minute++;
            }
            thoigiantext = time.ToString("00") + "h " + Math.Floor(minute).ToString("00") + "' " + Math.Round(second).ToString("00") + "s";
            lblTongMetDai.Text = "Tổng số mét dài: " + Util.FormatMoney4(tongmetdai) + " (mét)";
            lblTongThoiGian.Text = "Tổng thời gian sản xuất: " + thoigiantext + ".";
            lblTieuDeLenhSanXuat.Text = "LỆNH SẢN XUẤT: CÔNG ĐOẠN " + lenhSanXuat.TenCongDoan.ToUpper();
            lblPrintAt.Text = DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss");

            string ngaysanxuat = "Ngày" + " " + lenhSanXuat.NgaySanXuat.Day.ToString() + " " + "tháng" + " " + lenhSanXuat.NgaySanXuat.Month.ToString() + " " + "năm" + " " + lenhSanXuat.NgaySanXuat.Year.ToString(), congdoan = lenhSanXuat.TenCongDoan;
            DateTime ngayrakh = lenhSanXuat.NgayTao != null ? lenhSanXuat.NgayTao.Value : DateTime.Now;

            string ngayrakehoach = ngayrakh.ToString("dd/MM/yyyy");

            lblNgayRaKeHoach.Text = "Ngày ra kế hoạch: " + ngayrakehoach + " - Ngày sản xuất: " + lenhSanXuat.NgaySanXuat.ToString("dd/MM/yyyy");
        }

    }
}
