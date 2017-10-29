using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRP.Report.DataSet;
//using xRP.DataSet;
using xRPDAL;
using xRPRepository;

namespace xRP.Business.QuanLyVatTu.KiemTraVatTuNhap
{
    public partial class ReportViewer : System.Web.UI.UserControl
    {
        public string ID = "";
        private Qlvt_PhieuNhap currentPhieuNhap = null;
        private Qlvt_KhoVatTu currentKhoVatTu = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    ID = Request.QueryString["id"].ToString();
                    string type = Request.QueryString["type"];
                    if (string.IsNullOrWhiteSpace(type) || type != "2") type = "1";

                    xRPDataContext dts = new xRPDataContext();
                    DataTable dt = GetData(int.Parse(Request.QueryString["id"].ToString()));
                    var data = dts.sp_Baocao_PhieuNhapVatTu(int.Parse(ID));
                    ReportDataSource rpt = new ReportDataSource("dtsPhieuNhap", data);
                    rpViewer.LocalReport.DataSources.Clear();
                    rpViewer.LocalReport.DataSources.Add(rpt);
                    rpViewer.LocalReport.ReportPath = type == "1" ? "Report/QuanLyVatTu/NhapVatTu/ReportNhapKho.rdlc" : "Report/QuanLyVatTu/NhapVatTu/ReportNhapKhoNCC.rdlc";
                    rpViewer.LocalReport.Refresh();


                    this.currentPhieuNhap = (from t in dts.Qlvt_PhieuNhaps where t.ID == int.Parse(Request.QueryString["id"].ToString()) select t).FirstOrDefault();
                    this.currentKhoVatTu = (from ds in dts.Qlvt_KhoVatTus where ds.ID == currentPhieuNhap.MaKhoVatTu select ds).FirstOrDefault();

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

                    //Lấy thông tin nhà cung cấp
                    var nhacungcap = (from ds in dts.Qlvt_NhaCungCaps where ds.ID == currentPhieuNhap.MaNhaCungCap select ds).FirstOrDefault();

                    ReportParameter[] p = new ReportParameter[12];
                    p[0] = new ReportParameter("maphieunhap", currentPhieuNhap.MaHieuPhieuNhap);
                    p[1] = new ReportParameter("nhaptaikho", currentKhoVatTu.TenKhoVatTu);
                    p[2] = new ReportParameter("tencongty", tencongty);
                    p[3] = new ReportParameter("diachi", diachi.ToUpper());
                    p[4] = new ReportParameter("sodienthoai", sodienthoai);
                    p[5] = new ReportParameter("ngayin", new Sys_ThongSoHeThongRepository().GetThongSoHeThong("DiaPhuong", "Hà Nội") + ", ngày" + " " + DateTime.Now.Day.ToString() + " " + "tháng" + " " + DateTime.Now.Month.ToString() + " " + "năm" + " " + DateTime.Now.Year.ToString());

                    double x = 0, y = 0, z = 0, k = 0;
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {

                        if (!string.IsNullOrEmpty(dt.Rows[i][3].ToString()))
                        {
                            x = x + double.Parse(dt.Rows[i][3].ToString());
                        }
                        if (!string.IsNullOrEmpty(dt.Rows[i][5].ToString()))
                        {
                            y = y + double.Parse(dt.Rows[i][5].ToString());
                        }
                        if (!string.IsNullOrEmpty(dt.Rows[i][4].ToString()))
                        {
                            z = z + double.Parse(dt.Rows[i][4].ToString());
                        }
                        if (!string.IsNullOrEmpty(dt.Rows[i][7].ToString()))
                        {
                            k = k + double.Parse(dt.Rows[i][7].ToString());
                        }


                    }
                    p[7] = new ReportParameter("tongdltt", x.ToString());
                    p[8] = new ReportParameter("tongtruloi", y.ToString());
                    p[9] = new ReportParameter("tongtruthuakho", z.ToString());
                    p[10] = new ReportParameter("tongthucnhap", k.ToString());
                    p[11] = new ReportParameter("tien", Util.ReadMoney(k.ToString()));
                    p[6] = new ReportParameter("ngaynhapkho", currentPhieuNhap.NgayNhap.ToString());
                    rpViewer.LocalReport.SetParameters(p);
                    if (currentPhieuNhap.TinhTrang != 2)
                    {
                        ltAccept.Text = "<li class=\"menu-item icon-only\"><a id=\"btnAccept\" class=\"menu-bar-item-button icon accept-icon\" href=\"javascript:duyetPhieuNhap('"+currentPhieuNhap.ID+"');\"></a></li>";
                    }
                }
            }
        }
        public DataRow dr;
        public DataTable GetData(int id)
        {
            xRPDataContext datacontext = new xRPDataContext();
            List<sp_Baocao_PhieuNhapVatTuResult> listBaoCaoPhieuNhap = (from ds in datacontext.sp_Baocao_PhieuNhapVatTu(id) select ds).ToList();

            DataSetERP dataset = new DataSetERP();
            DataTable dt = dataset.Tables.Add("tblPhieuNhapKho");
            dt.Columns.Add("TenVT", typeof(String));
            dt.Columns.Add("DonViTinh", typeof(String));
            dt.Columns.Add("SoKgKiemTra", typeof(String));
            dt.Columns.Add("DLTT", typeof(String));
            dt.Columns.Add("TruThuKho", typeof(String));
            dt.Columns.Add("TruLoi", typeof(String));
            dt.Columns.Add("TruDL", typeof(String));
            dt.Columns.Add("ThucNhap", typeof(String));
            dt.Columns.Add("STT", typeof(String));
            dt.Columns.Add("so", typeof(String));
            if (listBaoCaoPhieuNhap.Count > 0)
            {
                for (int i = 0; i < listBaoCaoPhieuNhap.Count; i++)
                {
                    dr = dt.NewRow();
                    dr["TenVT"] = listBaoCaoPhieuNhap[i].TenVatTu;
                    dr["DonViTinh"] = listBaoCaoPhieuNhap[i].DVT;
                    dr["SoKgKiemTra"] = "";
                    dr["DLTT"] = Util.FormatMoney(listBaoCaoPhieuNhap[i].DinhLuongThucTe != null ? listBaoCaoPhieuNhap[i].DinhLuongThucTe.Value : 0);
                    dr["TruThuKho"] = Util.FormatMoney(listBaoCaoPhieuNhap[i].TruThuaKichThuoc != null ? listBaoCaoPhieuNhap[i].TruThuaKichThuoc.Value : 0);
                    dr["TruLoi"] = Util.FormatMoney(listBaoCaoPhieuNhap[i].TruLoi != null ? listBaoCaoPhieuNhap[i].TruLoi.Value : 0);
                    dr["TruDL"] = "";
                    dr["ThucNhap"] = Util.FormatMoney(listBaoCaoPhieuNhap[i].SoLuongThucNhap != null ? listBaoCaoPhieuNhap[i].SoLuongThucNhap.Value : 0);
                    dr["STT"] = i + 1;
                    dr["so"] = "1";
                    dt.Rows.Add(dr);
                }
            }
            return dt;
        }

        protected void btnAccept_Click(object sender, EventArgs e)
        {

        }
    }
}