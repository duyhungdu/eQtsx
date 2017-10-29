using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;
namespace xRP.Business.QuanLyVatTu.XuatVatTu
{
    public partial class ViewDetailPhieuKiemTraVatTuXuat : System.Web.UI.UserControl
    {
        public string ID_PhieuXuat { get; set; }
        private Qlvt_PhieuXuat currentPhieuXuat = null;
        protected xRPDataContext dts = new xRPDataContext();
        protected string DataChiTiet = "";
        protected string DataVatTu = "[]";
        public string KieuVatTu = ((int)EnumPhieuXuat.KieuVatTu.VatTuXuat).ToString();


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var listVatTu = new System.Collections.ArrayList();
                foreach (var x in dts.Sp_Qlvt_VatTu_Select(0, (int?)null, (int?)null, null, (int?)null))
                {
                    listVatTu.Add(
                        new
                        {
                            MaVatTu = x.MaHieuVatTu,
                            MaHieuLoaiVatTu = x.MaHieuLoaiVatTu.Trim()
                        });
                }
                DataVatTu = new JavaScriptSerializer().Serialize(listVatTu);
            }
            ltTitle.Text = "Thêm phiếu xuất";

            ID_PhieuXuat = Request.QueryString["id"];
            if (ID_PhieuXuat == null) ID_PhieuXuat = "";
            if (ID_PhieuXuat != "" && ID_PhieuXuat != "0")
            {
                int id = 0;
                if (int.TryParse(ID_PhieuXuat, out id))
                    LoadData(id);
                else Response.Redirect(Util.SERVER_NAME + "/Business/QuanLyVatTu/Default.aspx?page=pn", false);
            }
            else
            {
                ID_PhieuXuat = "0";
                ltTitle.Text = "Tạo phiếu xuất";
                this.txtNgayXuat.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now);
                //Lấy từ trong bảng Sys_ThongSoHeThong ra quy tắc sinh mã gán vào biến partern
                //string partern = dts.Sys_ThongSoHeThongs.Where(t => t.ThongSo == "MaPhieuXuat").FirstOrDefault().GiaTri;
                
                //var lastRow = dts.Qlvt_PhieuXuats.OrderByDescending(t => t.ID).Take(1).FirstOrDefault();
                //int maxValue = lastRow == null ? 1 : lastRow.ID + 1;
                
                bool khoExisted = false;
                if (!string.IsNullOrWhiteSpace(Request.QueryString["kho"]))
                {
                    int maKhoVatTu = 0;
                    if (int.TryParse(Request.QueryString["kho"], out maKhoVatTu))
                    {
                        var kc = dts.Qlvt_KhoVatTus.Where(t => t.ID == maKhoVatTu).FirstOrDefault();
                        if (kc != null)
                        {
                            this.lblKhoChua.Text = kc.MaHieuKho.Trim() + " - " + kc.TenKhoVatTu;
                            khoExisted = true;
                        }
                    }
                }
                if (!khoExisted)
                    Response.Redirect(Util.SERVER_NAME + "/Business/QuanLyVatTu/Default.aspx?page=pn", false);
            }
        }

        private void LoadData(int id)
        {
            try
            {

                xRPDataContext dts = new xRPDataContext();
                this.currentPhieuXuat = (from t in dts.Qlvt_PhieuXuats where t.ID == id select t).FirstOrDefault();

                if (this.currentPhieuXuat != null)
                {
                    ltPrint.Text = "<li class=\"menu-item icon-only\" id=\"Li1\"><input type=\"button\" class=\"menu-bar-item-button icon-printer\" id=\"btnPrint\" title=\"In dữ liệu\" /></li>";
                    ltTitle.Text = "Xem phiếu xuất: " + this.currentPhieuXuat.MaHieuPhieuXuat;
                    if (this.currentPhieuXuat.Xoa.HasValue && this.currentPhieuXuat.Xoa.Value)
                        Response.Redirect(Util.SERVER_NAME + "/Business/QuanLyVatTu/Default.aspx?page=pktx", false);

                    this.txtMaPhieu.Text = this.currentPhieuXuat.MaHieuPhieuXuat;
                    this.txtNgayXuat.Text = string.Format("{0:dd/MM/yyyy}", this.currentPhieuXuat.NgayXuat);


                    if (this.currentPhieuXuat.MaKhoVatTu.HasValue)
                    {
                        var kc = dts.Qlvt_KhoVatTus.Where(t => t.ID == this.currentPhieuXuat.MaKhoVatTu.Value).FirstOrDefault();
                        if (kc != null)
                            this.lblKhoChua.Text = kc.MaHieuKho.Trim() + " - " + kc.TenKhoVatTu;
                    }

                    if (this.currentPhieuXuat.MaKhoVatTuDen.HasValue)
                    {
                        var kd = dts.Qlvt_KhoVatTus.Where(t => t.ID == this.currentPhieuXuat.MaKhoVatTuDen.Value).FirstOrDefault();
                        if (kd != null)
                            this.txtKhoDen.Text = kd.MaHieuKho.Trim() + " - " + kd.TenKhoVatTu;
                    }

                    if (this.currentPhieuXuat.MaTinhChatNhapXuat.HasValue)
                    {
                        this.ddlTinhChat.Text = this.currentPhieuXuat.MaTinhChatNhapXuat.Value.ToString();
                        var tinhChat = dts.Sp_Qlvt_TinhChatNhapXuat_Select(1, currentPhieuXuat.MaTinhChatNhapXuat.Value, (int?)null, (int?)null).FirstOrDefault();
                        this.ddlTinhChat.Text = tinhChat.TenTinhChatNhapXuat;
                        if (this.currentPhieuXuat.MaDonViNhan.HasValue && tinhChat != null && tinhChat.NoiBo.HasValue && tinhChat.NoiBo.Value)
                        {
                            var kh = dts.Sys_DanhMucDonVis.Where(t => t.ID == this.currentPhieuXuat.MaDonViNhan.Value).FirstOrDefault();
                            if (kh != null)
                                this.txtKhachHang.Text = (kh.MaHieuDonVi == null ? "" : (kh.MaHieuDonVi.Trim() + " - ")) + kh.TenDonVi;
                        }
                        if (this.currentPhieuXuat.MaDonViNhan.HasValue && tinhChat != null && tinhChat.NoiBo.HasValue && !tinhChat.NoiBo.Value)
                        {

                            var kh = dts.Qldh_KhachHangs.Where(t => t.ID == this.currentPhieuXuat.MaDonViNhan.Value).FirstOrDefault();
                            if (kh != null)
                                this.txtKhachHang.Text = kh.TenKhachHang;
                        }
                        if (tinhChat.NoiBo.Value)
                        {
                            lblKhachHang.InnerText = "Phòng ban/đơn vị";
                            this.txtKhoDen.Visible = true;
                        }
                        else {
                            lblKhachHang.InnerText = "Khách hàng";
                            this.txtKhoDen.Visible = false;
                        }
                        if (tinhChat.DieuChuyen.HasValue && tinhChat.DieuChuyen.Value)
                        {
                            lblKhoDen.InnerText = "Kho đến";
                            txtKhoDen.Visible = true;
                            rKhoDen.Visible = true;
                        } else {
                            lblKhoDen.InnerText = "";
                            txtKhoDen.Visible = false;
                            rKhoDen.Visible = false;
                        }
                    }
                    this.txtGhiChu.Text = this.currentPhieuXuat.GhiChu.Replace("\n","<br/>");
                }
                else
                    this.txtNgayXuat.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now);

            }
            catch (Exception ex)
            {
                Response.Write(ex.StackTrace);
                Response.Write(ex.Message);
            }

        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect(Util.SERVER_NAME + "/Business/QuanLyVatTu/Default.aspx?page=pktn", false);
        }
    }
}