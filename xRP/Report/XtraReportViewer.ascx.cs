using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRP.Report.QuanLyBanHang;
using xRP.Report.QuanLySanXuat;
using xRP.Report.QuanLyVatTu.NhapVatTu;
using xRP.Report.QuanLyVatTu.NhapXuatTon;
using xRPDAL;

namespace xRP.Report
{
    public partial class XtraReportViewer : System.Web.UI.UserControl
    {
        public string page = "";
        public string display = "";
        public string display_baocaonhapxuatton = "none";
        public string display_baocaosanxuatgiaohang = "none";
        public string display_baocaotonghopcongdoansong = "none";
        public string display_baocaosanxuattonghop = "none";
        xRPDataContext dataContext = new xRPDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            page = Request.QueryString["page"];
            display = Request.QueryString["display"] != null ? Request.QueryString["display"] : "0";

            switch (page)
            {
                case "ppn":
                    ltTitle.Text = "In phiếu nhập vật tư";
                    if (Request.QueryString["type"] == "1")
                    {
                        LoadPrintPhieuNhap(1);
                    }
                    else
                    {
                        LoadPrintPhieuNhap(2);
                    }
                    ltBack.Text = "<a id='btnBaoCaoNhapXuatTonCancel' class='menu-bar-item-button icon cancel-icon' href='/Administrator/QuanLyDonHang/DonHang/default.aspx?page=dsdonhang' title='Quay lại'></a>";

                    break;
                case "ppdathhang":
                    ltTitle.Text = "Đơn đặt hàng bán";
                    ltBack.Text = "<a id='btnBaoCaoNhapXuatTonCancel' class='menu-bar-item-button icon cancel-icon' href='/Administrator/QuanLyDonHang/DonHang/default.aspx?page=dsdonhang' title='Quay lại'></a>";
                    LoadDonDatHangBan();
                    break;
                case "plsx":
                    ltTitle.Text = "Lệnh sản xuất";
                    ltBack.Text = "<a id='btnbaoCaoTongHopCongDoanSongCancel' class='menu-bar-item-button icon cancel-icon' href='/Business/QuanLySanXuat/Default.aspx?page=lsx' title='Quay lại'></a>";
                    LoadLenhSanXuat();
                    break;
                case "bcnxtvt2":
                    ltTitle.Text = "Báo cáo nhập xuất tồn vật tư";
                    ltBack.Text = "<a id='btnBaoCaoNhapXuatTonCancel' class='menu-bar-item-button icon cancel-icon' href='/Business/QuanLyVatTu/Default.aspx?page=pktn' title='Quay lại'></a>";
                    display_baocaonhapxuatton = "inline-block";
                    btnBaoCaoNhapXuatTon.Visible = true;
                    pnlBaoCaoNhapXuatTonVatTu.Visible = true;
                    if (display == "1")
                    {
                        LoadBaoCaoNhapXuatTon();
                    }
                    break;
                case "bcghsx2":
                    ltTitle.Text = "Báo cáo sản xuất - giao hàng";
                    ltBack.Text = "<a id='btnBaoCaoSanXuatGiaoHangCancel' class='menu-bar-item-button icon cancel-icon' href='/Administrator/QuanLyDonHang/DonHang/default.aspx?page=dsdonhang' title='Quay lại'></a>";
                    display_baocaosanxuatgiaohang = "inline-block";
                    pnlBaoCaoSanXuatGiaoHang.Visible = true;
                    btnBaoCaoSanXuatGiaoHang.Visible = true;
                    if (display == "1")
                    {
                        LoadBaoCaoSanXuatGiaoHang();
                    }
                    break;
                case "bcthcds":
                    ltTitle.Text = "Báo cáo sản xuất tổng hợp công đoạn sóng";
                    ltBack.Text = "<a id='btnbaoCaoTongHopCongDoanSongCancel' class='menu-bar-item-button icon cancel-icon' href='/Business/QuanLySanXuat/Default.aspx?page=lsx' title='Quay lại'></a>";
                    display_baocaotonghopcongdoansong = "inline-block";
                    pnlBaoCaoTongHopCongDoanSong.Visible = true;
                    btnBaoCaoTongHopCongDoanSong.Visible = true;
                    if (display == "1")
                    {
                        LoadBaoCaoTongHopCongDoanSong();
                    }
                    else
                    {
                        txtTongHopSongTu.Text = DateTime.Now.AddDays(-30).ToString("dd/MM/yyyy");
                        txtTongHopSongDen.Text = DateTime.Now.ToString("dd/MM/yyyy");
                    }
                    break;


                case "bcsx":
                    ltTitle.Text = "Báo cáo sản xuất tổng hợp";
                    ltBack.Text = "<a id='btnbaoCaoTongHopCongDoanSongCancel' class='menu-bar-item-button icon cancel-icon' href='/Business/QuanLySanXuat/Default.aspx?page=lsx' title='Quay lại'></a>";
                    display_baocaosanxuattonghop = "inline-block";
                    pnlBaoCaoSanXuatTongHop.Visible = true;
                    btnBaoCaoSanXuatTongHop.Visible = true;
                    if (display == "1")
                    {
                        LoadBaoCaoSanXuatTongHop();
                    }
                    break;
            }
        }

        protected void LoadDonDatHangBan()
        {
            ASPxDocumentViewer1.Visible = true;
            ASPxDocumentViewer1.Report = new XtraReportDatHang(int.Parse(Request.QueryString["id"]));
        }
        protected void LoadPrintPhieuNhap(int type)
        {
            if (type == 1)
            {
                ASPxDocumentViewer1.Visible = true;
                ASPxDocumentViewer1.Report = new XtraReportNhapKho(int.Parse(Request.QueryString["id"]));
            }
            else
            {
                ASPxDocumentViewer1.Visible = true;
                ASPxDocumentViewer1.Report = new XtraReportNhapKhoNCC(int.Parse(Request.QueryString["id"]));
            }
        }
        protected void LoadLenhSanXuat()
        {
            ASPxDocumentViewer1.Visible = true;
            ASPxDocumentViewer1.Report = new XtraReportLenhSanXuat(int.Parse(Request.QueryString["lenhSanXuatId"]));
        }

        protected void btnBaoCaoNhapXuatTon_Click(object sender, EventArgs e)
        {
            string kho = slcKho.Value.Trim(',');
            string vattu = slcVatTu.Value.Trim(',');
            string nhacungcap = slcNhaCungCap.Value.Trim(',');
            string ngaybd = txtTuNgay.Text;
            string ngaykt = txtDenNgay.Text;
            bool truloi = chkKhongTruLoi.Checked;
            int groupBy = int.Parse(ddlGroupBy.SelectedValue);
            Response.Redirect(Util.SERVER_NAME + "/Business/QuanLyVatTu/Default.aspx?page=bcnxtvt2&display=1" + "&kho=" + kho + "&vattu=" + vattu + "&nhacungcap=" + nhacungcap + "&ngaybd=" + ngaybd + "&ngaykt=" + ngaykt + "&truloi=" + truloi + "&groupby=" + groupBy);
        }
        protected void LoadBaoCaoNhapXuatTon()
        {
            string kho = Request.QueryString["kho"];
            if (!string.IsNullOrEmpty(kho))
            {
                slcKho.Value = kho;
                string tempkho = "<span id='sp-{0}' style='background:#f1f1f1;margin-right:2px;' value='{0}'>{1} - {2} <span> <img src='/Styles/images/editdelete.png' span-id='sp-{0}' value='{0}' style='width: 12px;cursor: pointer;' onclick='removeDataKho(this)'></span></span>";
                foreach (string s in kho.Split(','))
                {
                    if (!string.IsNullOrEmpty(s))
                    {
                        var elementKho = dataContext.Qlvt_KhoVatTus.Where(x => x.ID == int.Parse(s)).FirstOrDefault();
                        if (elementKho != null)
                        {
                            lblKhoSelect.Text += string.Format(tempkho, elementKho.ID, elementKho.MaHieuKho, elementKho.TenKhoVatTu);
                        }
                    }
                }
            }
            string vattu = Request.QueryString["vattu"];
            if (!string.IsNullOrEmpty(vattu))
            {
                slcVatTu.Value = vattu;
                string temVatTu = "<span id='sp-{0}' style='background:#f1f1f1;margin-right:2px;' value='{0}'>{1} - {2} <span> <img src='/Styles/images/editdelete.png' span-id='sp-{0}' value='{0}' style='width: 12px;cursor: pointer;' onclick='removeDataVatTu(this)'></span></span>";
                foreach (string s in vattu.Split(','))
                {
                    if (!string.IsNullOrEmpty(s))
                    {
                        var elementVatTu = dataContext.Qlvt_VatTus.Where(x => x.ID == int.Parse(s)).FirstOrDefault();
                        if (elementVatTu != null)
                        {
                            lblVatTu.Text += string.Format(temVatTu, elementVatTu.ID, elementVatTu.MaHieuVatTu, elementVatTu.TenVatTu);
                        }
                    }
                }
            }
            string nhacungcap = Request.QueryString["nhacungcap"];
            if (!string.IsNullOrEmpty(nhacungcap))
            {
                slcNhaCungCap.Value = nhacungcap;
                string tempNhaCungCap = "<span id='sp-{0}' style='background:#f1f1f1;margin-right:2px;' value='{0}'>{1} - {2} <span> <img src='/Styles/images/editdelete.png' span-id='sp-{0}' value='{0}' style='width: 12px;cursor: pointer;' onclick='removeDataNhaCungCap(this)'></span></span>";
                foreach (string s in nhacungcap.Split(','))
                {
                    if (!string.IsNullOrEmpty(s))
                    {
                        var elementNhaCungCap = dataContext.Qlvt_NhaCungCaps.Where(x => x.ID == int.Parse(s)).FirstOrDefault();
                        if (elementNhaCungCap != null)
                        {
                            lblNhaCungCap.Text += string.Format(tempNhaCungCap, elementNhaCungCap.ID, elementNhaCungCap.MaHieuNhaCungCap, elementNhaCungCap.TenNhaCungCap);
                        }
                    }
                }
            }
            string ngaybd = Request.QueryString["ngaybd"];
            txtTuNgay.Text = ngaybd;
            string ngaykt = Request.QueryString["ngaykt"];
            txtDenNgay.Text = ngaykt;
            string truloi = Request.QueryString["truloi"];
            try
            {
                chkKhongTruLoi.Checked = bool.Parse(truloi);
            }
            catch
            {
                chkKhongTruLoi.Checked = false;
            }
            string groupby = Request.QueryString["groupby"];
            ddlGroupBy.ClearSelection();
            ddlGroupBy.Items.FindByValue(groupby).Selected = true;
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

            if (groupby == "0")
            {
                ASPxDocumentViewer1.Visible = true;
                ASPxDocumentViewer1.Report = new XtraReportNhapXuatTonTheoChitTietVatTuNCC(kho, "", vattu, nhacungcap, ngaybatdau, ngayketthuc, bool.Parse(truloi));
            }
            else
            {
                ASPxDocumentViewer1.Visible = true;
                ASPxDocumentViewer1.Report = new XtraReportNhapXuatTonTheoChiTietVatTu(kho, "", vattu, nhacungcap, ngaybatdau, ngayketthuc, bool.Parse(truloi));
            }
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
            Response.Redirect(Util.SERVER_NAME + "/Administrator/QuanLyDonHang/Default.aspx?page=bcghsx2&display=1" + "&kh=" + idKH + "&dh=" + idDH + "&mh=" + idMH + "&ngaydathangstart=" + ngaydathangstart + "&ngaydathangend=" + ngaydathangend + "&ngaygiaohangstart=" + ngaygiaohangstart + "&ngaygiaohangend=" + ngaygiaohangend);
        }
        protected void LoadBaoCaoSanXuatGiaoHang()
        {
            string kh = Request.QueryString["kh"];
            string dh = Request.QueryString["dh"];
            string mh = Request.QueryString["mh"];
            int? id_kh = null;
            if (kh != "0" && !string.IsNullOrEmpty(kh))
                id_kh = int.Parse(kh);

            int? id_dh = null;
            if (dh != "0" && !string.IsNullOrEmpty(dh))
                id_dh = int.Parse(dh);

            int? id_mh = null;
            if (mh != "0" && !string.IsNullOrEmpty(mh))
                id_mh = int.Parse(mh);


            txtNgayDatHangStart.Text = Request.QueryString["ngaydathangstart"];
            txtNgayDatHangEnd.Text = Request.QueryString["ngaydathangend"];
            txtNgayGiaoHangStart.Text = Request.QueryString["ngaygiaohangstart"];
            txtNgayGiaoHangEnd.Text = Request.QueryString["ngaygiaohangend"];

            DateTime ngayStartDatHang = DateTime.Now;
            DateTime ngayEndDatHang = DateTime.Now;
            DateTime ngayStartGiaoHang = DateTime.Now;
            DateTime ngayEndGiaoHang = DateTime.Now;
            try
            {
                var khachhang = dataContext.Qldh_KhachHangs.Where(x => x.ID == int.Parse(kh)).FirstOrDefault();
                txtBCSXKhachHang.Text = khachhang.MaHieuKhachHang + " - " + khachhang.TenKhachHang;
                hdfBCSXIDKhachHang.Value = khachhang.ID.ToString();
            }
            catch
            { }
            try
            {
                var donhang = dataContext.Qldh_DonHangs.Where(x => x.ID == int.Parse(dh)).FirstOrDefault();
                txtBCSXDonHang.Text = donhang.MaHieuDonHang;
                hdfBCSXIDDonHang.Value = donhang.ID.ToString();
            }
            catch
            { }
            try
            {
                var mathang = dataContext.Qldh_MatHangs.Where(x => x.ID == int.Parse(mh)).FirstOrDefault();
                txtBCSXMatHang.Text = mathang.MaHieuMatHang + " - " + mathang.TenMatHang;
                hdfBCSXIDKhachHang.Value = mathang.ID.ToString();
            }
            catch
            { }
            try
            {
                ngayStartDatHang = DateTime.ParseExact(txtNgayDatHangStart.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            }
            catch { }

            try
            {
                ngayEndDatHang = DateTime.ParseExact(txtNgayDatHangEnd.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            }
            catch { }
            try
            {
                ngayStartGiaoHang = DateTime.ParseExact(txtNgayGiaoHangStart.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            }
            catch { }

            try
            {
                ngayEndGiaoHang = DateTime.ParseExact(txtNgayGiaoHangEnd.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            }
            catch { }
            ASPxDocumentViewer1.Visible = true;
            ASPxDocumentViewer1.Report = new XtraReportReportTinhHinhDatHangSanXuatGiaoHang(id_kh, id_dh, id_mh, ngayStartDatHang, ngayEndDatHang, ngayStartGiaoHang, ngayEndGiaoHang);
        }

        protected void btnBaoCaoTongHopCongDoanSong_Click(object sender, EventArgs e)
        {
            string ngayStart = txtTongHopSongTu.Text;
            string ngayEnd = txtTongHopSongDen.Text;
            Response.Redirect(Util.SERVER_NAME + "/Business/QuanLySanXuat/Default.aspx?page=bcthcds&display=1&start=" + ngayStart + "&end=" + ngayEnd);
        }
        protected void LoadBaoCaoTongHopCongDoanSong()
        {

            DateTime startDate = DateTime.Now.AddDays(-30);
            DateTime endDate = DateTime.Now;
            try
            {
                startDate = DateTime.ParseExact(Request.QueryString["start"], "dd/MM/yyyy", CultureInfo.InvariantCulture);
            }
            catch { }
            try
            {
                endDate = DateTime.ParseExact(Request.QueryString["end"], "dd/MM/yyyy", CultureInfo.InvariantCulture);
            }
            catch { }
            txtTongHopSongTu.Text = startDate.ToString("dd/MM/yyyy");
            txtTongHopSongDen.Text = endDate.ToString("dd/MM/yyyy");
            ASPxDocumentViewer1.Visible = true;
            ASPxDocumentViewer1.Report = new XtraReportBaoCaoTongHopCongDoanSong(startDate, endDate);
        }

        protected void btnBaoCaoSanXuatTongHop_Click(object sender, EventArgs e)
        {
            string ngayStart = txtBaoCaoTongHopTuNgay.Text;
            string ngayEnd = txtBaoCaoTongHopDenNgay.Text;
            Response.Redirect(Util.SERVER_NAME + "/Business/QuanLySanXuat/Default.aspx?page=bcsx&display=1&start=" + ngayStart + "&end=" + ngayEnd);
        }
        protected void LoadBaoCaoSanXuatTongHop()
        {
            DateTime? startDate = null;
            DateTime? endDate = null;
            try
            {
                startDate = DateTime.ParseExact(Request.QueryString["start"], "dd/MM/yyyy", CultureInfo.InvariantCulture);
            }
            catch { }
            try
            {
                endDate = DateTime.ParseExact(Request.QueryString["end"], "dd/MM/yyyy", CultureInfo.InvariantCulture);
            }
            catch { }
            try
            {
                txtTongHopSongTu.Text = startDate.Value.ToString("dd/MM/yyyy");
            }
            catch { }
            try
            {
                txtTongHopSongDen.Text = endDate.Value.ToString("dd/MM/yyyy");
            }
            catch { }
            ASPxDocumentViewer1.Visible = true;
            ASPxDocumentViewer1.Report = new XtraReportSanXuatTongHop(startDate, endDate);
        }
    }
}