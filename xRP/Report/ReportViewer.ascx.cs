using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRP.Report.DataSet;
using xRPDAL;
using xRPRepository;

namespace xRP.Report
{
    public partial class ReportViewer : System.Web.UI.UserControl
    {
        protected Sys_ThongSoHeThongRepository repThongSoHeThong = new Sys_ThongSoHeThongRepository();

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    //VisibleControl();

                    string page = "";
                    if (Request.QueryString["page"] != null)
                    {
                        page = Request.QueryString["page"].ToString();
                    }
                    switch (page)
                    {
                        case "bcnxtvt":
                            pnBaoCaoNhapXuatTon.Visible = true;
                            lblBaoCaoNhapXuatTon.Text = "Báo cáo nhập xuất tồn";
                            break;
                        case "bckdkcs":
                            pnlBaoCaoFailedKCS.Visible = true;
                            ltBaoCaoKCS.Text = "Báo cáo KCS";
                            break;
                        case "bcghsx":
                            pnlBaoCaoSanXuatGiaoHang.Visible = true;
                            lblBaoCaoSanXuatGiaoHang.Text = "Báo cáo sản xuất - giao hàng";
                            break;
                        case "bcnxttp":
                            pnBaoCaoNhapXuatTonThanhPham.Visible = true;
                            lblBaoCaoNhapXuatTonThanhPham.Text = "Báo cáo nhập xuất tồn thành phẩm";
                            break;
                        case "ppdathhang":
                            pnBaoCaoKhac.Visible = true;
                            ltPageTitle.Text = "Phiếu đặt hàng";
                            ltQuayLai.Text = "<a id='btnCancel' class='menu-bar-item-button icon cancel-icon' href='/Administrator/QuanLyDonHang/DonHang/Default.aspx?page=dsdonhang' title='Quay lại'></a>";
                            LoadPhieuDatHang();
                            break;
                        case "ppntp":
                            pnBaoCaoKhac.Visible = true;
                            ltPageTitle.Text = "Phiếu nhập thành phẩm";
                            ltQuayLai.Text = "<a id='btnCancel' class='menu-bar-item-button icon cancel-icon' href='/Business/QuanLyVatTu/Default.aspx?page=ntp' title='Quay lại'></a>";
                            LoadPhieuNhapThanhPham();
                            break;
                        case "ppxtp":
                            pnBaoCaoKhac.Visible = true;
                            ltPageTitle.Text = "Phiếu xuất thành phẩm";
                            ltQuayLai.Text = "<a id='btnCancel' class='menu-bar-item-button icon cancel-icon' href='/Business/QuanLyVatTu/Default.aspx?page=xtp' title='Quay lại'></a>";
                            LoadPhieuXuatThanhPham();
                            break;

                        case "plsx":
                            pnBaoCaoKhac.Visible = true;
                            ltPageTitle.Text = "Lệnh sản xuất";
                            ltQuayLai.Text = "<a id='btnCancel' class='menu-bar-item-button icon cancel-icon' href='/Business/QuanLySanXuat/Default.aspx?page=lsx' title='Quay lại'></a>";
                            LoadLenhSanXuat();
                            break;
                        case "pavt":
                            pnBaoCaoKhac.Visible = true;
                            ltPageTitle.Text = "Phương án vật tư";
                            ltQuayLai.Text = "";
                            LoadPhuongAnVatTu();
                            break;
                        case "inpycvt":
                            pnBaoCaoKhac.Visible = true;
                            ltPageTitle.Text = "Phiếu yêu cầu vật tư";
                            ltQuayLai.Text = "<a id='btnCancel' class='menu-bar-item-button icon cancel-icon' href='/Business/QuanLySanXuat/Default.aspx?page=lsx' title='Quay lại'></a>";
                            LoadPhieuYeuCauVatTu();
                            break;
                        case "bcsx":
                        case "bcsxth":
                            pnBaoCaoSanXuatTongHop.Visible = true;
                            ltPageTitle.Text = "Báo cáo sản xuất tổng hợp";
                            ltQuayLai.Text = "<a id='btnCancel' class='menu-bar-item-button icon cancel-icon' href='/Business/QuanLySanXuat/Default.aspx?page=bcsx' title='Quay lại'></a>";
                            BaoCaoSanXuatTongHop(null, null);
                            break;
                    }
                }
            }
            catch (Exception ex)
            {

            }
        }

        protected void LoadBaoCaoNhapXuatTon()
        {
            Report.QuanLyVatTu.NhapXuatTon.BaoCaoXuatNhapTonVatTu nhapXuatTon = (Report.QuanLyVatTu.NhapXuatTon.BaoCaoXuatNhapTonVatTu)this.Page.LoadControl("~/Report/QuanLyVatTu/NhapXuatTon/BaoCaoXuatNhapTonVatTu.ascx");
            nhapXuatTon.ViewerData = rpViewer;
            plcReportData.Controls.Add(nhapXuatTon);
        }
        protected void LoadPhieuDatHang()
        {
            var dts = new xRPDataContext();
            int id = 0;
            if (!string.IsNullOrEmpty(Request.QueryString["id"]))
            {
                int.TryParse(Request.QueryString["id"], out id);
            }
            var donhang = dts.Sp_Qldh_DonHang_Select(1, id, null, null, null, null, null, null, null).FirstOrDefault();
            if (donhang == null) id = 0;
            if (id == 0)
            {
                ReportDataSource rpt = new ReportDataSource("DonHang", new DataTable());
                rpViewer.LocalReport.DataSources.Clear();
                rpViewer.LocalReport.DataSources.Add(rpt);
                rpViewer.LocalReport.ReportPath = "Report/QuanLyBanHang/ReportNhapKho.rdlc";
                rpViewer.LocalReport.SetParameters(new ReportParameter("MaDonHang", ""));
                rpViewer.LocalReport.SetParameters(new ReportParameter("NgayDatHang", ""));
                rpViewer.LocalReport.SetParameters(new ReportParameter("KhachHang", ""));
                rpViewer.LocalReport.SetParameters(new ReportParameter("MaDonHang", ""));
                rpViewer.LocalReport.SetParameters(new ReportParameter("DiaChi", ""));
                rpViewer.LocalReport.SetParameters(new ReportParameter("DienThoai", ""));
                rpViewer.LocalReport.SetParameters(new ReportParameter("NgayGiaoHang", ""));
                rpViewer.LocalReport.SetParameters(new ReportParameter("TenCongTy", ""));
                rpViewer.LocalReport.SetParameters(new ReportParameter("DiaChiCongTy", ""));
                rpViewer.LocalReport.SetParameters(new ReportParameter("DienThoaiCongTy", ""));
                rpViewer.LocalReport.SetParameters(new ReportParameter("FaxCongTy", ""));
                rpViewer.LocalReport.Refresh();
            }
            else
            {
                rpViewer.LocalReport.ReportPath = "Report/QuanLyBanHang/ReportDatHang.rdlc";
                rpViewer.LocalReport.SetParameters(new ReportParameter("MaDonHang", donhang.MaHieuDonHang));
                rpViewer.LocalReport.SetParameters(new ReportParameter("NgayDatHang", donhang.NgayDatHang.HasValue ? donhang.NgayDatHang.Value.ToString("dd/MM/yyyy") : ""));
                rpViewer.LocalReport.SetParameters(new ReportParameter("KhachHang", donhang.TENKHACHHANG));
                rpViewer.LocalReport.SetParameters(new ReportParameter("MaDonHang", donhang.MaHieuDonHang));
                var khachHang = dts.Sp_Qldh_KhachHang_Select(1, donhang.MaKhachHang, null, null, "").FirstOrDefault();
                rpViewer.LocalReport.SetParameters(new ReportParameter("DiaChi", khachHang == null ? "" : khachHang.DiaChi));
                rpViewer.LocalReport.SetParameters(new ReportParameter("DienThoai", khachHang == null ? "" : khachHang.DienThoaiLienHe));
                rpViewer.LocalReport.SetParameters(new ReportParameter("NgayGiaoHang", donhang.NgayGiaoHang.HasValue ? donhang.NgayGiaoHang.Value.ToString("dd/MM/yyyy") : ""));
                var sysconfig = dts.Sys_ThongSoHeThongs;
                string tenCongTy = (from t in sysconfig where t.ThongSo == "TenCongTy" select t.GiaTri).FirstOrDefault();
                string diaChiCongTy = (from t in sysconfig where t.ThongSo == "DiaChiCongTy" select t.GiaTri).FirstOrDefault();
                string dienThoaiCongTy = (from t in sysconfig where t.ThongSo == "DienThoaiLienHe" select t.GiaTri).FirstOrDefault();
                string fax = (from t in sysconfig where t.ThongSo == "Fax" select t.MoTa).FirstOrDefault();
                rpViewer.LocalReport.SetParameters(new ReportParameter("TenCongTy", tenCongTy));
                rpViewer.LocalReport.SetParameters(new ReportParameter("DiaChiCongTy", diaChiCongTy));
                rpViewer.LocalReport.SetParameters(new ReportParameter("DienThoaiCongTy", dienThoaiCongTy));
                rpViewer.LocalReport.SetParameters(new ReportParameter("FaxCongTy", fax));

                ReportDataSource rpt = new ReportDataSource("DonHang", dts.sp_Baocao_DonHang(id));
                rpViewer.LocalReport.DataSources.Clear();
                rpViewer.LocalReport.DataSources.Add(rpt);
                rpViewer.LocalReport.Refresh();
            }
        }
        protected void LoadPhieuNhapThanhPham()
        {
            var dts = new xRPDataContext();
            int id = 0;
            if (!string.IsNullOrEmpty(Request.QueryString["id"]))
            {
                int.TryParse(Request.QueryString["id"], out id);
            }
            var phieunhap = dts.Sp_Qlvt_PhieuNhap_Select(1, id, null, null, null, null, null, null, null, null, null, null, null).FirstOrDefault();
            if (phieunhap == null) id = 0;
            if (id == 0)
            {
                ReportDataSource rpt = new ReportDataSource("dtsNhapKhoThanhPham", new DataTable());
                rpViewer.LocalReport.DataSources.Clear();
                rpViewer.LocalReport.DataSources.Add(rpt);
                rpViewer.LocalReport.ReportPath = "Report/QuanLyBanHang/ReportNhapKhoThanhPham.rdlc";
                rpViewer.LocalReport.SetParameters(new ReportParameter("maphieunhap", ""));
                rpViewer.LocalReport.SetParameters(new ReportParameter("nhaptaikho", ""));
                rpViewer.LocalReport.SetParameters(new ReportParameter("tencongty", ""));
                rpViewer.LocalReport.SetParameters(new ReportParameter("diachi", ""));
                rpViewer.LocalReport.SetParameters(new ReportParameter("sodienthoai", ""));
                rpViewer.LocalReport.SetParameters(new ReportParameter("ngayin", ""));
                rpViewer.LocalReport.SetParameters(new ReportParameter("ngaynhapkho", ""));
                rpViewer.LocalReport.SetParameters(new ReportParameter("noidung", ""));
                rpViewer.LocalReport.SetParameters(new ReportParameter("sotienbangchu", ""));
                rpViewer.LocalReport.Refresh();
            }
            else
            {

                rpViewer.LocalReport.ReportPath = "Report/QuanLyBanHang/ReportNhapKhoThanhPham.rdlc";
                rpViewer.LocalReport.SetParameters(new ReportParameter("maphieunhap", phieunhap.MaHieuPhieuNhap));
                rpViewer.LocalReport.SetParameters(new ReportParameter("nhaptaikho", phieunhap.TenKhoVatTu));

                var sysconfig = dts.Sys_ThongSoHeThongs;
                string tenCongTy = (from t in sysconfig where t.ThongSo == "TenCongTy" select t.GiaTri).FirstOrDefault();
                string diaChiCongTy = (from t in sysconfig where t.ThongSo == "DiaChiCongTy" select t.GiaTri).FirstOrDefault();
                string dienThoaiCongTy = (from t in sysconfig where t.ThongSo == "DienThoaiLienHe" select t.GiaTri).FirstOrDefault();
                rpViewer.LocalReport.SetParameters(new ReportParameter("tencongty", tenCongTy));
                rpViewer.LocalReport.SetParameters(new ReportParameter("diachi", diaChiCongTy));
                rpViewer.LocalReport.SetParameters(new ReportParameter("sodienthoai", dienThoaiCongTy));
                rpViewer.LocalReport.SetParameters(new ReportParameter("ngayin", DateTime.Now.ToString("dd/MM/yyyy")));
                rpViewer.LocalReport.SetParameters(new ReportParameter("ngaynhapkho", phieunhap.NgayNhap.HasValue ? phieunhap.NgayNhap.Value.ToString("dd/MM/yyyy") : ""));
                rpViewer.LocalReport.SetParameters(new ReportParameter("noidung", phieunhap.GhiChu != "" ? phieunhap.GhiChu : " "));


                double tongtien = 0;
                foreach (Sp_Qlvt_ThanhPhamNhap_SelectResult tpnhap in dts.Sp_Qlvt_ThanhPhamNhap_Select(2, null, phieunhap.ID, null))
                {
                    tongtien += (tpnhap.ThanhTien != null ? tpnhap.ThanhTien.Value : 0);
                }
                string strTongTien = "";
                if (tongtien == 0)
                {
                    strTongTien = "Không đồng";
                }
                else
                {
                    strTongTien = Util.ReadMoney(tongtien.ToString()) + " đồng";
                }
                rpViewer.LocalReport.SetParameters(new ReportParameter("sotienbangchu", strTongTien));
                ReportDataSource rpt = new ReportDataSource("dtsNhapKhoThanhPham", dts.Sp_Qlvt_ThanhPhamNhap_Select(2, null, phieunhap.ID, null));
                rpViewer.LocalReport.DataSources.Clear();
                rpViewer.LocalReport.DataSources.Add(rpt);
                rpViewer.LocalReport.Refresh();
            }
        }
        protected void LoadPhieuXuatThanhPham()
        {
            var dts = new xRPDataContext();
            int id = 0;
            if (!string.IsNullOrEmpty(Request.QueryString["id"]))
            {
                int.TryParse(Request.QueryString["id"], out id);
            }
            var phieuxuat = dts.Sp_Qlvt_PhieuXuat_Select(1, id, null, null, null, null, null, null, null).FirstOrDefault();
            if (phieuxuat == null) id = 0;
            if (id == 0)
            {
                ReportDataSource rpt = new ReportDataSource("dtsXuatKhoThanhPham", new DataTable());
                rpViewer.LocalReport.DataSources.Clear();
                rpViewer.LocalReport.DataSources.Add(rpt);
                rpViewer.LocalReport.ReportPath = "Report/QuanLyBanHang/ReportXuatKhoThanhPham.rdlc";
                rpViewer.LocalReport.SetParameters(new ReportParameter("maphieuxuat", ""));
                rpViewer.LocalReport.SetParameters(new ReportParameter("xuattaikho", ""));
                rpViewer.LocalReport.SetParameters(new ReportParameter("tencongty", ""));
                rpViewer.LocalReport.SetParameters(new ReportParameter("diachi", ""));
                rpViewer.LocalReport.SetParameters(new ReportParameter("sodienthoai", ""));
                rpViewer.LocalReport.SetParameters(new ReportParameter("ngayin", ""));
                rpViewer.LocalReport.SetParameters(new ReportParameter("ngayxuatkho", ""));
                rpViewer.LocalReport.SetParameters(new ReportParameter("noidung", ""));
                rpViewer.LocalReport.SetParameters(new ReportParameter("sotienbangchu", ""));
                rpViewer.LocalReport.SetParameters(new ReportParameter("khachhang", ""));
                rpViewer.LocalReport.SetParameters(new ReportParameter("diachikhachhang", ""));
                rpViewer.LocalReport.Refresh();
            }
            else
            {

                rpViewer.LocalReport.ReportPath = "Report/QuanLyBanHang/ReportXuatKhoThanhPham.rdlc";
                rpViewer.LocalReport.SetParameters(new ReportParameter("maphieuxuat", phieuxuat.MaHieuPhieuXUAT));
                rpViewer.LocalReport.SetParameters(new ReportParameter("xuattaikho", phieuxuat.TenKhoVatTu));

                var sysconfig = dts.Sys_ThongSoHeThongs;
                string tenCongTy = (from t in sysconfig where t.ThongSo == "TenCongTy" select t.GiaTri).FirstOrDefault();
                string diaChiCongTy = (from t in sysconfig where t.ThongSo == "DiaChiCongTy" select t.GiaTri).FirstOrDefault();
                string dienThoaiCongTy = (from t in sysconfig where t.ThongSo == "DienThoaiLienHe" select t.GiaTri).FirstOrDefault();
                rpViewer.LocalReport.SetParameters(new ReportParameter("tencongty", tenCongTy));
                rpViewer.LocalReport.SetParameters(new ReportParameter("diachi", diaChiCongTy));
                rpViewer.LocalReport.SetParameters(new ReportParameter("sodienthoai", dienThoaiCongTy));
                rpViewer.LocalReport.SetParameters(new ReportParameter("ngayin", DateTime.Now.ToString("dd/MM/yyyy")));
                rpViewer.LocalReport.SetParameters(new ReportParameter("ngayxuatkho", phieuxuat.NgayXuat.HasValue ? phieuxuat.NgayXuat.Value.ToString("dd/MM/yyyy") : ""));
                rpViewer.LocalReport.SetParameters(new ReportParameter("noidung", phieuxuat.GhiChu != "" ? phieuxuat.GhiChu : " "));
                rpViewer.LocalReport.SetParameters(new ReportParameter("khachhang", phieuxuat.TenDonVi != "" ? phieuxuat.TenDonVi : " "));
                rpViewer.LocalReport.SetParameters(new ReportParameter("diachikhachhang", " "));


                double tongtien = 0;
                foreach (Sp_Qlvt_ThanhPhamXuat_SelectResult tpnhap in dts.Sp_Qlvt_ThanhPhamXuat_Select(2, null, phieuxuat.ID, null, ""))
                {
                    tongtien += (tpnhap.ThanhTien != null ? tpnhap.ThanhTien.Value : 0);
                }
                string strTongTien = "";
                if (tongtien == 0)
                {
                    strTongTien = "Không đồng";
                }
                else
                {
                    strTongTien = Util.ReadMoney(tongtien.ToString()) + " đồng";
                }
                rpViewer.LocalReport.SetParameters(new ReportParameter("sotienbangchu", strTongTien));
                //ReportDataSource rpt = new ReportDataSource("dtsNhapKhoThanhPham", dts.Sp_Qlvt_ThanhPhamNhap_Select(2, null, phieuxuat.ID, null));
                ReportDataSource rpt = new ReportDataSource("dtsXuatKhoThanhPham", dts.Sp_Qlvt_ThanhPhamXuat_Select(2, null, phieuxuat.ID, null, ""));
                rpViewer.LocalReport.DataSources.Clear();
                rpViewer.LocalReport.DataSources.Add(rpt);
                rpViewer.LocalReport.Refresh();
            }
        }
        #region BaoCaoSanXuatTongHop

        protected void BaoCaoSanXuatTongHop(DateTime? tuNgay, DateTime? denNgay)
        {
            //Load report
            try
            {
                xRPDataContext dts = new xRPDataContext();
                var baoCaoSanXuatTongHopRepository = new Qlsx_BaoCaoRepository();
                var data = baoCaoSanXuatTongHopRepository.Qlsx_BaoCaoSanXuatTongHop(null, null, null, tuNgay, denNgay);
                ReportDataSource rpt = new ReportDataSource("rpTongHop", data);
                rpViewer.LocalReport.DataSources.Clear();
                rpViewer.LocalReport.DataSources.Add(rpt);
                rpViewer.LocalReport.ReportPath = "Report/QuanLySanXuat/ReportSanXuatTongHop.rdlc";
                rpViewer.LocalReport.Refresh();

                //Set param 
                var dateTimeReport = DateTime.Now;//lenhSanXuat.NgaySanXuat

                string tencongty = "", diachi = "", sodienthoai = "";
                string ngaysanxuat = "Ngày" + " " + dateTimeReport.Day.ToString("D2") + " " + "tháng" + " " + dateTimeReport.Month.ToString("D2") + " " + "năm" + " " + dateTimeReport.Year.ToString();

                tencongty = repThongSoHeThong.TenCongTy;
                diachi = repThongSoHeThong.DiaChiCongTy;
                sodienthoai = repThongSoHeThong.DienThoaiLienHe;

                //Lấy thông tin nhà cung cấp
                ReportParameter[] p = new ReportParameter[5];
                p[0] = new ReportParameter("tencongty", tencongty.ToUpper());
                p[1] = new ReportParameter("diachi", diachi.ToUpper());
                p[2] = new ReportParameter("sodienthoai", sodienthoai.ToUpper());
                p[3] = new ReportParameter("ngaybaocao", ngaysanxuat);
                p[4] = new ReportParameter("printat", DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss"));
                rpViewer.LocalReport.SetParameters(p);
            }
            catch (Exception ex)
            {

            }
        }
        protected void btnBaoCaoSanXuatTongHop_Click(object sender, EventArgs e)
        {


            string ngaybd = txtBaoCaoSanXuatTongHopTuNgay.Text;
            string ngaykt = txtBaoCaoSanXuatTongHopDenNgay.Text;

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

            BaoCaoSanXuatTongHop(ngaybatdau, ngayketthuc);


        }


        #endregion

        #region LoadLenhSanXuat



        protected void LoadPhieuYeuCauVatTu()
        {
            xRPDataContext dts = new xRPDataContext();

            int phieuYeuCauVatTuId = 0;
            var _phieuYeuCauVatTuId = Request.QueryString["phieuYeuCauVatTuId"];
            if (_phieuYeuCauVatTuId != null & _phieuYeuCauVatTuId != "")
            {
                int.TryParse(_phieuYeuCauVatTuId, out phieuYeuCauVatTuId);
            }

            var phieuYeuCauVatTu = dts.Sp_Qlsx_PhieuYeuCauVatTu_Select(1, phieuYeuCauVatTuId, null, null, null, null, null).FirstOrDefault();
            var data = dts.Sp_Qlsx_PhieuYeuCauVatTuChiTiet_Select(1, phieuYeuCauVatTuId, null).ToList();

            ReportDataSource rpt = new ReportDataSource("rpPhieuYeuCauVatTu", data);
            rpViewer.LocalReport.DataSources.Clear();
            rpViewer.LocalReport.DataSources.Add(rpt);
            rpViewer.LocalReport.ReportPath = "Report/QuanLySanXuat/ReportYeuCauVatTu.rdlc";
            rpViewer.LocalReport.Refresh();

            //Set param đang lỗi

            string tencongty = "", diachi = "", sodienthoai = "";
            string ngaysanxuat = "Ngày" + " " + DateTime.Now.Day.ToString() + " " + "tháng" + " " + DateTime.Now.Month.ToString() + " " + "năm" + " " + DateTime.Now.Year.ToString(), congdoan = "";

            tencongty = repThongSoHeThong.TenCongTy;
            diachi = repThongSoHeThong.DiaChiCongTy;
            sodienthoai = repThongSoHeThong.DienThoaiLienHe;
            //Lấy thông tin nhà cung cấp
            //var nhacungcap = (from ds in dts.Qlvt_NhaCungCaps where ds.ID == currentPhieuNhap.MaNhaCungCap select ds).FirstOrDefault();
            ReportParameter[] p = new ReportParameter[7];
            p[0] = new ReportParameter("tencongty", tencongty.ToUpper());
            p[1] = new ReportParameter("diachi", diachi.ToUpper());
            p[2] = new ReportParameter("dienthoailienhe", sodienthoai.ToUpper());
            p[3] = new ReportParameter("ngayin", ngaysanxuat);
            p[4] = new ReportParameter("maphieuxuat", phieuYeuCauVatTu.MaHieuPhieuYeuCau.ToString());
            p[5] = new ReportParameter("noidung", phieuYeuCauVatTu.Mota);
            p[6] = new ReportParameter("ngayxuat", String.Format("{0:dd/MM/yyyy}", phieuYeuCauVatTu.NgaySuDung));

            rpViewer.LocalReport.SetParameters(p);
        }
        protected void LoadPhuongAnVatTu()
        {
            //Load report
            try
            {
                xRPDataContext dts = new xRPDataContext();

                int yeucausanxuatID = Request.QueryString["id"] != null ? int.Parse(Request.QueryString["id"].ToString()) : 0;

                List<Sp_Qlsx_PhuongAnSanXuat_SelectResult> listLenhSanXuatChiTiet = dts.Sp_Qlsx_PhuongAnSanXuat_Select(yeucausanxuatID, 0).ToList();
                foreach (Sp_Qlsx_PhuongAnSanXuat_SelectResult abc in listLenhSanXuatChiTiet)
                {
                    if (!string.IsNullOrEmpty(abc.VatTuThoaMan))
                    {
                        abc.VatTuThoaMan = abc.VatTuThoaMan.Replace("<br>", Environment.NewLine);
                        abc.VatTuThoaMan = abc.VatTuThoaMan.Replace("</br>", Environment.NewLine);
                        abc.VatTuThoaMan = abc.VatTuThoaMan.Replace("<br >", Environment.NewLine);
                    }
                }
                ReportDataSource rpt = new ReportDataSource("dtsPhuongAnVatTu", listLenhSanXuatChiTiet);
                rpViewer.LocalReport.DataSources.Clear();
                rpViewer.LocalReport.DataSources.Add(rpt);
                rpViewer.LocalReport.ReportPath = "Report/QuanLySanXuat/ReportPhuongAnDauTuSanXuat.rdlc";
                rpViewer.LocalReport.Refresh();
                //Set param 

                string tencongty = "", diachi = "", sodienthoai = "";

                tencongty = repThongSoHeThong.TenCongTy;
                diachi = repThongSoHeThong.DiaChiCongTy;
                sodienthoai = repThongSoHeThong.DienThoaiLienHe;
                var yeucausanxuat = dts.Sp_Qlsx_YeuCauSanXuat_Select(1, yeucausanxuatID, null, null, null, null, null, null).FirstOrDefault();
                ReportParameter[] p = new ReportParameter[22];
                if (yeucausanxuat != null)
                {

                    p[0] = new ReportParameter("tencongty", tencongty.ToUpper());
                    p[1] = new ReportParameter("diachi", diachi.ToUpper());
                    p[2] = new ReportParameter("sodienthoai", sodienthoai.ToUpper());
                    p[3] = new ReportParameter("MaHang", string.IsNullOrEmpty(yeucausanxuat.MaHieuMatHang) == false ? yeucausanxuat.MaHieuMatHang : " ");
                    p[4] = new ReportParameter("TenHang", string.IsNullOrEmpty(yeucausanxuat.TenMatHang) == false ? yeucausanxuat.TenMatHang : " ");
                    p[5] = new ReportParameter("MaDonHang", (string.IsNullOrEmpty(yeucausanxuat.MaHieuDonHang) == false ? yeucausanxuat.MaHieuDonHang : " ") + " - " + (string.IsNullOrEmpty(yeucausanxuat.TenKhachHang) == false ? yeucausanxuat.TenKhachHang : " "));
                    p[6] = new ReportParameter("LoaiSanPham", string.IsNullOrEmpty(yeucausanxuat.TenLoaiSanPham) == false ? yeucausanxuat.TenLoaiSanPham : " ");
                    p[7] = new ReportParameter("LoaiKichThuoc", string.IsNullOrEmpty(yeucausanxuat.LoaiKichThuoc) == false ? yeucausanxuat.LoaiKichThuoc : " ");
                    p[8] = new ReportParameter("KichThuoc", Util.FormatMoney4(yeucausanxuat.ChieuDai) + " x " + Util.FormatMoney4(yeucausanxuat.ChieuRong) + " x " + Util.FormatMoney4(yeucausanxuat.ChieuCao));
                    p[9] = new ReportParameter("SoLuongDat", string.IsNullOrEmpty(Util.FormatMoney4(yeucausanxuat.SoLuong)) == false ? Util.FormatMoney4(yeucausanxuat.SoLuong) : " ");

                    p[10] = new ReportParameter("LoaiSong", yeucausanxuat.KiHieuCoCauGiay.ToString() + " - " + yeucausanxuat.MoTaCoCauGiay);
                    p[11] = new ReportParameter("SoLop", string.IsNullOrEmpty(yeucausanxuat.SoLop.ToString()) == false ? yeucausanxuat.SoLop.ToString() : " ");
                    p[12] = new ReportParameter("TongGiao", string.IsNullOrEmpty(Util.FormatMoney3(yeucausanxuat.TongDao)) == false ? Util.FormatMoney3(yeucausanxuat.TongDao) : " ");
                    p[13] = new ReportParameter("ChatDai", string.IsNullOrEmpty(Util.FormatMoney4(yeucausanxuat.ChatDai)) == false ? Util.FormatMoney4(yeucausanxuat.ChatDai) : " ");
                    p[14] = new ReportParameter("Tai", string.IsNullOrEmpty(yeucausanxuat.Tai.ToString()) == false ? yeucausanxuat.Tai.ToString() : " ");
                    p[15] = new ReportParameter("Le", string.IsNullOrEmpty(yeucausanxuat.Le.ToString()) == false ? yeucausanxuat.Le.ToString() : " ");
                    p[16] = new ReportParameter("KhoGiay", string.IsNullOrEmpty(Util.FormatMoney6(yeucausanxuat.KhoGiay)) == false ? Util.FormatMoney6(yeucausanxuat.KhoGiay) : " ");
                    try
                    {
                        string ktttam = yeucausanxuat.KTTam;
                        string[] a = ktttam.Trim().Split('x');
                        if (a.Length == 2)
                        {
                            p[17] = new ReportParameter("KichThuocTam", Util.FormatMoney7(int.Parse(a[0])) + " x " + Util.FormatMoney7(int.Parse(a[1])));
                        }
                    }
                    catch
                    {
                        p[17] = new ReportParameter("KichThuocTam", string.IsNullOrEmpty(yeucausanxuat.KTTam) == false ? yeucausanxuat.KTTam : " ");
                    }

                    p[18] = new ReportParameter("SoLuongTam", string.IsNullOrEmpty(Util.FormatMoney3(yeucausanxuat.SoLuongTam)) == false ? Util.FormatMoney3(yeucausanxuat.SoLuongTam) : " ");
                    p[19] = new ReportParameter("SoLuongHop", string.IsNullOrEmpty(Util.FormatMoney3(yeucausanxuat.SoLuongHop)) == false ? Util.FormatMoney3(yeucausanxuat.SoLuongHop) : " ");
                    p[20] = new ReportParameter("DienTichXuatBan", yeucausanxuat.DienTichXuatBan != null ? Math.Round(yeucausanxuat.DienTichXuatBan.Value, 2).ToString() : " ");
                    p[21] = new ReportParameter("SoLuongCanSanXuat", string.IsNullOrEmpty(Util.FormatMoney3(yeucausanxuat.SoLuongCanSanXuat)) == false ? Util.FormatMoney3(yeucausanxuat.SoLuongCanSanXuat) : " ");
                }
                rpViewer.LocalReport.SetParameters(p);
            }
            catch (Exception ex)
            {

            }
        }
        protected void LoadLenhSanXuat()
        {
            //Load report
            try
            {
                xRPDataContext dts = new xRPDataContext();
                var lenhSanXuatRepository = new Qlsx_LenhSanXuatRepository();
                var yeuCauSanXuatRepository = new Qlsx_YeuCauSanXuatRepository();
                int lenhSanXuatId = 0;
                var _lenhSanXuatId = Request.QueryString["lenhsanxuatId"];
                if (_lenhSanXuatId != null & _lenhSanXuatId != "")
                {
                    int.TryParse(_lenhSanXuatId, out lenhSanXuatId);
                }

                var lenhSanXuat = lenhSanXuatRepository.GetLenhSanXuatById(lenhSanXuatId);

                List<Sp_Qlsx_LenhSanXuatChiTiet_SelectResult> listLenhSanXuatChiTiet = yeuCauSanXuatRepository.GetDanhSachLenhSanXuatChiTiet(lenhSanXuatId, null, null, null);
                double tongmetdai = 0;
                double thoigiansanxuat = 0;
                foreach (Sp_Qlsx_LenhSanXuatChiTiet_SelectResult ct in listLenhSanXuatChiTiet)
                {
                    tongmetdai += ct.QuyDoiMetDai != null ? ct.QuyDoiMetDai.Value : 0;
                    thoigiansanxuat += ct.ThoiGianSanXuat != null ? ct.ThoiGianSanXuat.Value : 0;
                }
                string thoigiantext = "0h 0' 0s";
                if (thoigiansanxuat != null)
                {
                    var time = Math.Floor(thoigiansanxuat);
                    var minute = (thoigiansanxuat - Math.Floor(thoigiansanxuat)) * 60;
                    var second = (minute - Math.Floor(minute)) * 60;
                    thoigiantext = time.ToString("00") + "h " + Math.Floor(minute).ToString("00") + "' " + Math.Round(second).ToString("00") + "s";
                }
                ReportDataSource rpt = new ReportDataSource("rpLenhSanXuatChiTiet", listLenhSanXuatChiTiet);
                rpViewer.LocalReport.DataSources.Clear();
                rpViewer.LocalReport.DataSources.Add(rpt);
                rpViewer.LocalReport.ReportPath = "Report/QuanLySanXuat/ReportLenhSanXuat.rdlc";
                rpViewer.LocalReport.Refresh();


                //Set param 

                string tencongty = "", diachi = "", sodienthoai = "";
                string ngaysanxuat = "Ngày" + " " + lenhSanXuat.NgaySanXuat.Day.ToString() + " " + "tháng" + " " + lenhSanXuat.NgaySanXuat.Month.ToString() + " " + "năm" + " " + lenhSanXuat.NgaySanXuat.Year.ToString(), congdoan = lenhSanXuat.TenCongDoan;
                DateTime ngayrakh = lenhSanXuat.NgayTao != null ? lenhSanXuat.NgayTao.Value : DateTime.Now;

                string ngayrakehoach = ngayrakh.ToString("dd/MM/yyyy");

                tencongty = repThongSoHeThong.TenCongTy;
                diachi = repThongSoHeThong.DiaChiCongTy;
                sodienthoai = repThongSoHeThong.DienThoaiLienHe;
                //Lấy thông tin nhà cung cấp
                //var nhacungcap = (from ds in dts.Qlvt_NhaCungCaps where ds.ID == currentPhieuNhap.MaNhaCungCap select ds).FirstOrDefault();
                ReportParameter[] p = new ReportParameter[9];
                p[0] = new ReportParameter("tencongty", tencongty.ToUpper());
                p[1] = new ReportParameter("diachi", diachi.ToUpper());
                p[2] = new ReportParameter("sodienthoai", sodienthoai.ToUpper());
                p[3] = new ReportParameter("congdoan", congdoan.ToUpper());
                p[4] = new ReportParameter("ngaysanxuat", lenhSanXuat.NgaySanXuat.ToString("dd/MM/yyyy"));
                p[5] = new ReportParameter("ngayrakehoach", ngayrakehoach);
                p[6] = new ReportParameter("printat", DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss"));
                p[7] = new ReportParameter("tongmetdai", "Tổng số mét dài: " + Util.FormatMoney4(tongmetdai) + " (mét)");
                p[8] = new ReportParameter("tongthoigian", "Tổng thời gian sản xuất: " + thoigiantext + ".");
                rpViewer.LocalReport.SetParameters(p);
            }
            catch (Exception ex)
            {

            }
        }
        /// <summary>
        /// Lấy danh sách lệnh sản xuất chi tiết theo mã lệnh sản xuất
        /// </summary>
        /// <param name="lenhsanxuatId"></param>
        /// <returns></returns>

        #endregion

        protected void btnReport_Click(object sender, EventArgs e)
        {
            string page = "";
            int? vatTuId = null;
            DateTime? dateFrom = null;
            DateTime? dateTo = null;
            if (Request.QueryString["page"] != null)
            {
                page = Request.QueryString["page"].ToString();
            }
            switch (page)
            {
                case "bcnxtvt":
                    try
                    {
                        vatTuId = int.Parse(txtNXT_VatTu.Text);
                    }
                    catch { }

                    try
                    {
                        dateFrom = DateTime.ParseExact(txtNXT_TuNgay.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                    }
                    catch { }

                    try
                    {
                        dateTo = DateTime.ParseExact(txtNXT_DenNgay.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                    }
                    catch { }


                    // LoadBaoCaoNhapXuatTon(vatTuId, dateFrom, dateTo);

                    break;

                case "bcnxttp":

                    try
                    {
                        vatTuId = int.Parse(txtNXT_VatTu.Text);
                    }
                    catch { }

                    try
                    {
                        dateFrom = DateTime.ParseExact(txtNXT_TuNgay.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                    }
                    catch { }

                    try
                    {
                        dateTo = DateTime.ParseExact(txtNXT_DenNgay.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                    }
                    catch { }


                    //  LoadBaoCaoNhapXuatTonThanhPham(vatTuId, dateFrom, dateTo);


                    break;
            }
        }

        #region Bao Cao Nhap Xuat Ton
        protected void btnBaoCaoNhapXuatTon_Click(object sender, EventArgs e)
        {

            string kho = slcKho.Value.Trim(',');
            string vattu = slcVatTu.Value.Trim(',');
            string nhacungcap = slcNhaCungCap.Value.Trim(',');
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
                                  String.IsNullOrEmpty(vattu) == true ? null : vattu, String.IsNullOrEmpty(nhacungcap) == true ? null : nhacungcap,
                                  ngaybatdau, ngayketthuc, int.Parse(ddlGroupBy.SelectedValue));



        }
        protected void LoadBaoCaoNhapXuatTon(string lsKhoId, string lsLoaiVatTuId, string lsVatTuId, string lsNhaCungCapId, DateTime? ngayBatDau, DateTime? ngayKetThuc, int groupBy)
        {

            using (var dts = new xRPDataContext())
            {
                ///Đường đẫn file report.
                if (groupBy == 0)
                {
                    rpViewer.LocalReport.ReportPath = "Report/QuanLyVatTu/NhapXuatTon/ReportNhapXuatTonTheoChiTietVatTu.rdlc";
                }
                else
                {
                    rpViewer.LocalReport.ReportPath = "Report/QuanLyVatTu/NhapXuatTon/ReportNhapXuatTonTheoChiTietVatTNCC.rdlc";
                }


                if (chkKhongTruLoi.Checked)
                {
                    var data = dts.Sp_Qlvt_BaoCaoNhapXuatTonTheoVatTu_TruLoi(String.IsNullOrEmpty(lsKhoId) == true ? null : lsKhoId,
                                                                     String.IsNullOrEmpty(lsLoaiVatTuId) == true ? null : lsLoaiVatTuId,
                                                                     String.IsNullOrEmpty(lsVatTuId) == true ? null : lsVatTuId,
                                                                     String.IsNullOrEmpty(lsNhaCungCapId) == true ? null : lsNhaCungCapId,
                                                                     ngayBatDau, ngayKetThuc).ToList();
                    ReportDataSource rpt = new ReportDataSource("dtsNhapXuatTon", data);
                    rpViewer.LocalReport.DataSources.Clear();
                    rpViewer.LocalReport.DataSources.Add(rpt);
                    rpViewer.LocalReport.Refresh();
                }
                else
                {
                    var data = dts.Sp_Qlvt_BaoCaoNhapXuatTonTheoVatTu(String.IsNullOrEmpty(lsKhoId) == true ? null : lsKhoId,
                                                                    String.IsNullOrEmpty(lsLoaiVatTuId) == true ? null : lsLoaiVatTuId,
                                                                    String.IsNullOrEmpty(lsVatTuId) == true ? null : lsVatTuId,
                                                                    String.IsNullOrEmpty(lsNhaCungCapId) == true ? null : lsNhaCungCapId,
                                                                    ngayBatDau, ngayKetThuc).ToList();
                    ReportDataSource rpt = new ReportDataSource("dtsNhapXuatTon", data);
                    rpViewer.LocalReport.DataSources.Clear();
                    rpViewer.LocalReport.DataSources.Add(rpt);
                    rpViewer.LocalReport.Refresh();
                }



                ReportParameter[] p = new ReportParameter[6];
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

                p[0] = new ReportParameter("tencongty", repThongSoHeThong.TenCongTy.ToUpper());
                p[1] = new ReportParameter("diachi", repThongSoHeThong.DiaChiCongTy.ToUpper());
                p[2] = new ReportParameter("sodienthoai", repThongSoHeThong.DienThoaiLienHe.ToUpper());
                p[3] = new ReportParameter("tungaydenngay", tungaydenngay);
                p[4] = new ReportParameter("ngayhientai", repThongSoHeThong.GetThongSoHeThong("DiaPhuong", "Hà Nội") + ", ngày" + " " + DateTime.Now.Day.ToString() + " " + "tháng" + " " + DateTime.Now.Month.ToString() + " " + "năm" + " " + DateTime.Now.Year.ToString());
                if (chkKhongTruLoi.Checked)
                {
                    p[5] = new ReportParameter("truloi", "Số liệu thống kê có trừ lõi");
                }
                else
                {
                    p[5] = new ReportParameter("truloi", "Số liệu thống kê không trừ lõi");

                }
                rpViewer.LocalReport.SetParameters(p);
            }
        }

        #endregion

        #region Bao Cao Nhap Xuat Ton Thanh Pham
        protected void btnBaoCaoNhapXuatTonThanhPham_Click(object sender, EventArgs e)
        {

            string kho = slcKhoThanhPham.Value.Trim(',');
            string mathang = slcMatHangThanhPham.Value.Trim(',');
            string ngaybd = txtTuNgayThanhPham.Text;
            string ngaykt = txtDenNgayThanhPham.Text;

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

            LoadBaoCaoNhapXuatTonThanhPham(String.IsNullOrEmpty(kho) == true ? null : kho,
                                  String.IsNullOrEmpty(mathang) == true ? null : mathang,
                                  ngaybatdau, ngayketthuc);



        }

        protected void LoadBaoCaoNhapXuatTonThanhPham(string lsKhoId, string lsMatHangId, DateTime? dateFrom, DateTime? dateTo)
        {
            rpViewer.LocalReport.ReportPath = "Report/QuanLyVatTu/NhapXuatTon/ReportNhapXuatTonTheoChiTietThanhPham.rdlc";
            var dts = new xRPDataContext();

            ///var data = dts.Sp_Qlvt_BaoCaoNhapXuatTonTheoVatTu(null, null, null);
            ReportDataSource rpt = new ReportDataSource("dtsNhapXuatTon", dts.Sp_Qlvt_BaoCaoNhapXuatTonThanhPham(lsKhoId, lsMatHangId, dateFrom, dateTo).ToList());
            rpViewer.LocalReport.DataSources.Clear();
            rpViewer.LocalReport.DataSources.Add(rpt);
            rpViewer.LocalReport.Refresh();

            // var tencongty = dts.Sys_ThongSoHeThongs.Where(t => t.ThongSo == "TenCongTy").FirstOrDefault();
            var tencongty = repThongSoHeThong.TenCongTy;
            // rpViewer.LocalReport.SetParameters(new ReportParameter("tencongty", tencongty == null ? "" : tencongty));
            //var diachi = dts.Sys_ThongSoHeThongs.Where(t => t.ThongSo == "DiaChiCongTy").FirstOrDefault();
            var diachi = repThongSoHeThong.DiaChiCongTy;
            // rpViewer.LocalReport.SetParameters(new ReportParameter("diachi", diachi == null ? "" : diachi));
            //var dienthoai = dts.Sys_ThongSoHeThongs.Where(t => t.ThongSo == "DienThoaiLienHe").FirstOrDefault();
            var dienthoai = repThongSoHeThong.DienThoaiLienHe;
            //  rpViewer.LocalReport.SetParameters(new ReportParameter("sodienthoai", dienthoai == null ? "" : dienthoai));
            //  rpViewer.LocalReport.SetParameters(p);

            ReportParameter[] p = new ReportParameter[4];
            p[0] = new ReportParameter("tencongty", tencongty.ToUpper());
            p[1] = new ReportParameter("diachi", diachi.ToUpper());
            p[2] = new ReportParameter("sodienthoai", dienthoai.ToUpper());
            // p[3] = new ReportParameter("sodienthoai", ngaysanxuat);


            string ngaybatdau = dateFrom != null ? dateFrom.Value.ToString("dd/MM/yyyy") : "";
            string ngayketthuc = dateTo != null ? dateTo.Value.ToString("dd/MM/yyyy") : "";
            string tungaydenngay = "";
            if (!string.IsNullOrEmpty(ngaybatdau))
            {
                tungaydenngay += "Từ: " + ngaybatdau;
                if (!string.IsNullOrEmpty(ngayketthuc))
                {
                    tungaydenngay += " đến: " + ngayketthuc;
                }

            }
            else
            {
                if (!string.IsNullOrEmpty(ngayketthuc))
                {
                    tungaydenngay += "Tính đến: " + ngayketthuc;
                }
                else
                {
                    tungaydenngay = " ";
                }
            }
            p[3] = new ReportParameter("tungaydenngay", tungaydenngay);
            rpViewer.LocalReport.SetParameters(p);
        }


        #endregion

        protected void btnBaoCaoFailedKCS_Click(object sender, EventArgs e)
        {
            string idvattu = hdfVatTuFailedKCS.Value;
            int? idVT = null;
            if (idvattu != "0")
            {
                idVT = int.Parse(idvattu);
            }
            string idncc = hdfNhaCungCapFailedKCS.Value;
            int? idNCCap = null;
            if (idncc != "0")
            {
                idNCCap = int.Parse(idncc);
            }
            string ngaybd = txtTuNgayFailed.Text;
            string ngaykt = txtDenNgayFailed.Text;

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
            LoadBaoCaoFailedKCS(idNCCap, idVT, ngaybatdau, ngayketthuc, int.Parse(DropDownList2.SelectedValue));
        }
        protected void LoadBaoCaoFailedKCS(int? nhacungcap, int? vattu, DateTime? ngayBatDau, DateTime? ngayKetThuc, int groupBy)
        {
            xRPDataContext dataContext = new xRPDataContext();

            rpViewer.LocalReport.ReportPath = "Report/QuanLyVatTu/NhapXuatTon/ReportKCSVatTu.rdlc";
            int? tinhtrang = null;
            if (groupBy != -2)
            {
                tinhtrang = groupBy;
            }
            var dts = new xRPDataContext();

            //            /var data = dts.Sp_Qlvt_BaoCaoNhapXuatTonTheoVatTu(null, null, null);

            var data = dts.Sp_Qlvt_VatTu_KhongDat_Select(vattu, nhacungcap, ngayBatDau, ngayKetThuc, tinhtrang).ToList();
            ReportDataSource rpt = new ReportDataSource("dtsVatTuKhongDat", dts.Sp_Qlvt_VatTu_KhongDat_Select(vattu, nhacungcap, ngayBatDau, ngayKetThuc, tinhtrang).ToList());
            rpViewer.LocalReport.DataSources.Clear();
            rpViewer.LocalReport.DataSources.Add(rpt);
            rpViewer.LocalReport.Refresh();


            ReportParameter[] p = new ReportParameter[5];
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
            p[0] = new ReportParameter("tencongty", repThongSoHeThong.TenCongTy.ToUpper());
            p[1] = new ReportParameter("diachi", repThongSoHeThong.DiaChiCongTy.ToUpper());
            p[2] = new ReportParameter("sodienthoai", repThongSoHeThong.DienThoaiLienHe.ToUpper());
            p[3] = new ReportParameter("ngaynhap", tungaydenngay);
            p[4] = new ReportParameter("printat", DateTime.Now.ToString("dd/MM/yyyy"));
            rpViewer.LocalReport.SetParameters(p);
        }
        protected void btnBaoCaoSanXuatGiaoHang_Click(object sender, EventArgs e)
        {
            string idKhachHang = hdfBCSXIDKhachHang.Value;
            int? idKH = null;
            if (idKhachHang != "0")
            {
                idKH = int.Parse(idKhachHang);
            }
            string idDonHang = hdfBCSXIDDonHang.Value;
            int? idDH = null;
            if (idDonHang != "0")
            {
                idDH = int.Parse(idDonHang);
            }
            string idMatHang = hdfBCSXMatHang.Value;
            int? idMH = null;
            if (idMatHang != "0")
            {
                idMH = int.Parse(idMatHang);
            }
            string ngaydathangstart = txtNgayDatHangStart.Text;
            string ngaydathangend = txtNgayDatHangEnd.Text;
            string ngaygiaohangstart = txtNgayGiaoHangStart.Text;
            string ngaygiaohangend = txtNgayGiaoHangEnd.Text;

            DateTime? ngayStartDatHang = null;
            DateTime? ngayEndDatHang = null;
            DateTime? ngayStartGiaoHang = null;
            DateTime? ngayEndGiaoHang = null;

            try
            {
                ngayStartDatHang = DateTime.ParseExact(ngaydathangstart, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            }
            catch { }

            try
            {
                ngayEndDatHang = DateTime.ParseExact(ngaydathangend, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            }
            catch { }
            try
            {
                ngayStartGiaoHang = DateTime.ParseExact(ngaygiaohangstart, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            }
            catch { }

            try
            {
                ngayEndGiaoHang = DateTime.ParseExact(ngaygiaohangend, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            }
            catch { }
            LoadBaoCaoSanXuatGiaoHang(idKH, idDH, idMH, ngayStartDatHang, ngayEndDatHang, ngayStartGiaoHang, ngayEndGiaoHang);
        }
        protected void LoadBaoCaoSanXuatGiaoHang(int? khachhang, int? donhang, int? mathang, DateTime? dathangtu, DateTime? dathangden, DateTime? giaohangtu, DateTime? giaohangden)
        {
            xRPDataContext dataContext = new xRPDataContext();

            rpViewer.LocalReport.ReportPath = "Report/QuanLyBanHang/ReportTinhHinhDatHangSanXuatGiaoHang.rdlc";

            var dts = new xRPDataContext();
            List<Sp_BaoCao_SanXuat_GiaoHang_SelectResult> list = new List<Sp_BaoCao_SanXuat_GiaoHang_SelectResult>();
            list = dts.Sp_BaoCao_SanXuat_GiaoHang_Select(dathangtu, dathangden, giaohangtu, giaohangden, donhang, khachhang, mathang).ToList();
            ReportDataSource rpt = new ReportDataSource("dtsBaoCaoSanXuatGiaoHang", list);
            rpViewer.LocalReport.DataSources.Clear();
            rpViewer.LocalReport.DataSources.Add(rpt);
            rpViewer.LocalReport.Refresh();
            ReportParameter[] p = new ReportParameter[6];

            string ngaybatdaudh = dathangtu != null ? dathangtu.Value.ToString("dd/MM/yyyy") : "";
            string ngayketthucdh = dathangden != null ? dathangden.Value.ToString("dd/MM/yyyy") : "";

            string ngaybatdaugh = giaohangtu != null ? giaohangtu.Value.ToString("dd/MM/yyyy") : "";
            string ngayketthucgh = giaohangden != null ? giaohangden.Value.ToString("dd/MM/yyyy") : "";
            string tungaydenngay = "";
            if (!string.IsNullOrEmpty(ngaybatdaudh))
            {
                tungaydenngay += "Ngày đặt hàng từ: " + ngaybatdaudh;
                if (!string.IsNullOrEmpty(ngayketthucdh))
                {
                    tungaydenngay += " đến: " + ngayketthucdh;
                }
            }
            else
            {
                if (!string.IsNullOrEmpty(ngayketthucdh))
                {
                    tungaydenngay += "Ngày đặt hàng tính đến: " + ngayketthucdh;
                }
                else
                {
                    tungaydenngay = " ";
                }
            }
            string tungaydenngaygh = "";
            if (!string.IsNullOrEmpty(ngaybatdaugh))
            {
                tungaydenngaygh += " Ngày giao hàng từ: " + ngaybatdaugh;
                if (!string.IsNullOrEmpty(ngayketthucgh))
                {
                    tungaydenngaygh += " đến: " + ngayketthucgh;
                }
            }
            else
            {
                if (!string.IsNullOrEmpty(ngayketthucgh))
                {
                    tungaydenngaygh += " Ngày giao hàng tính đến: " + ngayketthucgh;
                }
                else
                {
                    tungaydenngaygh = " ";
                }
            }
            p[0] = new ReportParameter("tencongty", repThongSoHeThong.TenCongTy.ToUpper());
            p[1] = new ReportParameter("diachi", repThongSoHeThong.DiaChiCongTy.ToUpper());
            p[2] = new ReportParameter("sodienthoai", repThongSoHeThong.DienThoaiLienHe.ToUpper());
            p[3] = new ReportParameter("ngaydat", tungaydenngay);
            p[4] = new ReportParameter("ngaygiao", tungaydenngaygh);
            p[5] = new ReportParameter("printat", DateTime.Now.ToString("dd/MM/yyyy"));
            rpViewer.LocalReport.SetParameters(p);
        }
    }
}