using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;
using xRPRepository;
namespace xRP.Business.QuanLySanXuat.YeuCauVatTu
{
    public partial class AddOrEditPhieuYeuCauVatTu : System.Web.UI.UserControl
    {
        public string phieuYeuCauID { get; set; }
        public string lenhSanXuatID { get; set; }
        //  public string ID_PhieuNhap { get; set; }
        //  private Qlvt_PhieuNhap currentPhieuNhap = null;
        private Qlsx_PhieuYeuCauVatTu phieuYeuCauVatTu = null;
        protected int CurrentTinhTrang = 0;
        protected xRPDataContext dts = new xRPDataContext();
        protected string DataChiTiet = string.Empty;
        protected string DataVatTu = string.Empty;
        public string congDoanId = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lenhSanXuatID = Request.QueryString["lenhSanXuatId"];
                if (lenhSanXuatID == null) lenhSanXuatID = "";
                
                ltTitle.Text = string.Format("Tạo phiếu yêu cầu vật tư: {0}", dts.fc_SinhMa("MAPHIEUYEUCAUVATTU", "*"));

                if (Request.QueryString["cd"] != null)
                    congDoanId = Request.QueryString["cd"].ToString();



                if (lenhSanXuatID != "" && lenhSanXuatID != "0")
                {
                    //  int id = 0;
                    // if (int.TryParse(lenhSanXuatID, out id))
                    LoadData(lenhSanXuatID);
                    //  else Response.Redirect(Util.SERVER_NAME + "/Business/QuanLySanXuat/Default.aspx?page=lsx", false);
                }
                 
                var listVatTu = new System.Collections.ArrayList();
                foreach (var x in dts.Sp_Qlvt_VatTu_Select(0, (int?)null, (int?)null, "", null))
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
        }

        private void LoadData(string lenhSanXuatId)
        {
            try
            {

                using (xRPDataContext dts = new xRPDataContext())
                {
                    //this.phieuYeuCauVatTu = (from t in dts.Qlvt_PhieuNhaps where t.ID == id select t).FirstOrDefault();
                    this.phieuYeuCauVatTu = dts.Qlsx_PhieuYeuCauVatTus.FirstOrDefault(t => t.MaHieuThamChieu == lenhSanXuatId);
                    //var count = dts.Qlsx_PhieuYeuCauVatTus.Count();

                    if (this.phieuYeuCauVatTu != null)
                    {
                        ltTitle.Text = string.Format("Chỉnh sửa phiếu yêu cầu vật tư: {0}", this.phieuYeuCauVatTu.MaHieuPhieuYeuCau);
                        phieuYeuCauID = this.phieuYeuCauVatTu.ID.ToString();
                        pnChiTietVatTu.Visible = true;
                        this.txtMaHieuThamChieu.Value = this.phieuYeuCauVatTu.MaHieuThamChieu;
                        this.txtNgaySuDung.Value = string.Format("{0:dd/MM/yyyy}", this.phieuYeuCauVatTu.NgaySuDung);

                        this.txtMoTa.Text = this.phieuYeuCauVatTu.Mota;
                        this.CurrentTinhTrang = this.phieuYeuCauVatTu.TinhTrang.HasValue ? this.phieuYeuCauVatTu.TinhTrang.Value : 0;


                        var lsPhieuYeuCauVatTuChiTiet = (from p in dts.Qlsx_PhieuYeuCauVatTuChiTiets
                                                         join vt in dts.Qlvt_VatTus on p.IDVatTu equals vt.ID
                                                         join dvt in dts.Qlvt_DonViTinhs on p.IDDonViTinh equals dvt.ID
                                                         where p.IDPhieuYeuCauVatTu == phieuYeuCauVatTu.ID
                                                         select new
                                                         {
                                                             p.ID,
                                                             p.IDPhieuYeuCauVatTu,
                                                             p.IDVatTu,
                                                             vt.TenVatTu,
                                                             TenDonVi = "",
                                                             p.IDDonViTinh,
                                                             p.SoLuongYeuCau,
                                                             p.GhiChu,
                                                             p.TinhTrang,
                                                             NguoiYeuCau = p.MaNguoiTao,
                                                             p.NgayTao,
                                                             p.MaNguoiTao,
                                                             p.NgayThayDoi,
                                                             p.MaNguoiThayDoi
                                                         }).ToList();
                        DataChiTiet = new JavaScriptSerializer().Serialize(lsPhieuYeuCauVatTuChiTiet);


                    }
                    else
                    {
                        this.txtMaHieuThamChieu.Value = lenhSanXuatId;
                        this.txtNgaySuDung.Value = string.Format("{0:dd/MM/yyyy}", DateTime.Now);

                    }



                    // <input type="button" title="Lưu và In" class="menu-bar-item-button icon icon-save" id="btnSavePrint" onclick="onSaveData(true)" />
                    ltButtonNewChiTietVatTuNhap.Text = "<span class=\"menu-item icon-only\" id=\"btn-tao-moi-chi-tiet-kiem-tra-vat-tu-nhap\"><span class=\"icon icon-add\"></span><a href=\"javascript:void(0);\">Thêm vật tư</a></span>";
                    ltPrint.Text = "<li class=\"menu-item icon-only\" id=\"btn-print\"><input type=\"button\" title=\"In\" class=\"menu-bar-item-button icon icon-printer\" id=\"btnPrint\" /></li>";
                    //ltAccept.Text = "<li class=\"menu-item icon-only\" id=\"btn-accept\"><a title=\"Duyệt\" class=\"menu-bar-item-button icon icon-tfs-build-reason-batchedci\" href=\"javascript:duyetPhieuNhap('" + ID_PhieuNhap + "');\"></a></li>";
                    slcTinhTrang.Value = this.CurrentTinhTrang.ToString();

                    switch (this.CurrentTinhTrang)
                    {
                        case 0:
                            this.lblTinhTrang.Text = "Chưa nhận";
                            break;
                        default:
                            this.lblTinhTrang.Text = "Đã nhận";
                            break;
                    }
                    if (lenhSanXuatID == "" || lenhSanXuatID == "0")
                    {
                        lblTinhTrang.Text = "";
                        //dong tam ltPrint.Text = "";
                    }
                    if (CurrentTinhTrang == 0)
                    {
                        //dong tam ltPrint.Text = "";
                    }
                    if (CurrentTinhTrang == 0 || CurrentTinhTrang == 2)
                    {
                        ltAccept.Text = "";
                    }




                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.StackTrace);
                Response.Write(ex.Message);
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect(Util.SERVER_NAME + "/Business/QuanLySanXuat/Default.aspx?page=lsx&cd=" + congDoanId, false);
        }

    }
}