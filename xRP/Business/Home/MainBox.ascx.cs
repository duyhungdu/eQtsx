using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;

namespace xRP.Business.Home
{
    public partial class MainBox : System.Web.UI.UserControl
    {
        protected xRPDataContext dts = new xRPDataContext();
        protected string QuyTrinhQuanLyVatTu { set; get; }
        protected string QuyTrinhQuanLySanXuat { set; get; }
        protected void Page_Load(object sender, EventArgs e)
        {
            //BindGridDonHang();
            //BindGridNhapVatTu();
            //BindGridXuatVatTu();
            //BindCanhBaoVatTu();
        }
        private void BindCanhBaoVatTu()
        {
            rptCanhBaoTonKho.DataSource = dts.Sp_Qlvt_VatTu_Select(3, null, null, null, 0).Take(10).ToList();
            rptCanhBaoTonKho.DataBind();
        }
        private void BindGridDonHang()
        {
            var listDonh = dts.Sp_Qldh_DonHang_Select(0, null, null, null, null, null, null, "", null).OrderByDescending(p => p.NgayTao).Take(10).ToList();
            colPageDonHang.DataSource = listDonh;
            colPageDonHang.BindToControl = rptDonHang;
            rptDonHang.DataSource = colPageDonHang.DataSourcePaged;
        }
        private void BindGridNhapVatTu()
        {
            var listNhapVatTu = dts.Sp_Qlvt_PhieuNhap_Select(0, null, null, null, null, null, null, null, null, null, null, "", " NgayTao DESC").Take(5).ToList();
            colPageNhapVatTu.DataSource = listNhapVatTu;
            colPageNhapVatTu.BindToControl = rptDanhMucNhapVatTu;
            rptDanhMucNhapVatTu.DataSource = colPageNhapVatTu.DataSourcePaged;
        }
        private void BindGridXuatVatTu()
        {
            var listXuatVatTu = dts.Sp_Qlvt_PhieuXuat_Select(0, null, null, null, null, null, null, "", " NgayThayDoi DESC").Take(5).ToList();
            colPageXuatVatTu.DataSource = listXuatVatTu;
            colPageXuatVatTu.BindToControl = rptDanhMucXuatVatTu;
            rptDanhMucXuatVatTu.DataSource = colPageXuatVatTu.DataSourcePaged;
        }
    }
}