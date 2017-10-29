using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using xRPDAL;
using System.Collections.Generic;
using System.Data.Linq;
using System.Linq;
using xRPRepository;

namespace xRP.Report.QuanLyVatTu.XuatVatTu
{
    public partial class XtraReportXuatKho : DevExpress.XtraReports.UI.XtraReport
    {
        xRPDataContext dts = new xRPDataContext();
        public XtraReportXuatKho(int id)
        {
            InitializeComponent();
            if (id > 0)
            {
                LoadData(id);
            }
        }

        private void LoadData(int id)
        {
            List<sp_Baocao_PhieuXuatVatTuResult> listReportPhieuXuat = new List<sp_Baocao_PhieuXuatVatTuResult>();
            listReportPhieuXuat = dts.sp_Baocao_PhieuXuatVatTu(id).ToList();
            var phieuXuat = dts.Qlvt_PhieuXuats.FirstOrDefault(p => p.ID == id);
            var kh = (from ds in dts.Qldh_KhachHangs where ds.ID == phieuXuat.MaDonViNhan.Value select ds).FirstOrDefault();
            var khovattu = (from ds in dts.Qlvt_KhoVatTus where ds.ID == phieuXuat.MaKhoVatTu select ds).FirstOrDefault();
            string tencongty = "", diachi = "", sodienthoai = "";
            var listthongsoht = (from ds in dts.Sys_ThongSoHeThongs select ds).ToList();
            foreach (var item in listthongsoht)
            {
                if (item.ThongSo == "TenCongTy")
                {
                    tencongty = item.GiaTri;
                }
                if (item.ThongSo == "DiaChiCongTy")
                {
                    diachi = item.GiaTri;
                }
                if (item.ThongSo == "DienThoaiLienHe")
                {
                    sodienthoai = item.GiaTri;
                }
            }
            lblTenCongTy.Text = tencongty;
            
            lblDiaChiCongTy.Text = diachi;
            lblDienThoaiCongTy.Text = sodienthoai;
            lblMauPhieuXuat.Text = "Mã phiếu xuất kho: " + phieuXuat.MaHieuPhieuXuat;
            
            if(phieuXuat.MaDonViNhan.HasValue)
            {
                int tinhchatNhapXuatID = phieuXuat.MaTinhChatNhapXuat != null ? phieuXuat.MaTinhChatNhapXuat.Value : 0;
                var tcnx = dts.Qlvt_TinhChatNhapXuats.FirstOrDefault(x=>x.ID==tinhchatNhapXuatID);
                if (tcnx != null)
                {
                    if (tcnx.MaTinhChatNhapXuat == "XBA" || tcnx.MaTinhChatNhapXuat == "XKH")
                    {
                        lblKhachHang.Text = "Khách hàng: " + dts.Qldh_KhachHangs.FirstOrDefault(x => x.ID == phieuXuat.MaDonViNhan.Value).TenKhachHang;    
                    }
                    if (tcnx.MaTinhChatNhapXuat == "XSX")
                    {
                        lblKhachHang.Text = "Đơn vị nhận: Nội bộ";
                    }
                }
                
            }
            DateTime ngayXuat = new DateTime();
            ngayXuat = phieuXuat.NgayXuat.Value;
            lblNgayNhapXuat.Text = "Ngày xuất kho: " + ngayXuat.Day.ToString() + "/" + ngayXuat.Month.ToString() + "/" +ngayXuat.Year.ToString();
            lblXuatTaiKho.Text = "Xuất tại: " + khovattu.TenKhoVatTu;
            lblNoiDung.Text = "Nội dung: " + phieuXuat.GhiChu;
            lblNgayIn.Text =  new Sys_ThongSoHeThongRepository().GetThongSoHeThong("DiaPhuong","Hà Nội")+ ", ngày" + " " + DateTime.Now.Day.ToString() + " " + "tháng" + " " + DateTime.Now.Month.ToString() + " " + "năm" + " " + DateTime.Now.Year.ToString();
            objectDataSource1.DataSource = listReportPhieuXuat;
        }
    }
}
