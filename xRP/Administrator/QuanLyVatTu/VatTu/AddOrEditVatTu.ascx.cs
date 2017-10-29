using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;

namespace xRP.Administrator.QuanLyVatTu.VatTu
{
    public partial class AddOrEditVatTu : System.Web.UI.UserControl
    {
        public string ItemID { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Attributes["param"] != null)
            {
                string URL = Attributes["param"];
                ItemID = Util.GetParam(URL, "id");
                if (ItemID != "" && ItemID != "-1")
                {
                    int id = int.Parse(ItemID);
                    FillData(id);
                }
                else
                {
                    BindCbo(0);
                }
            }
        }

        protected void BindCbo(int selectedId)
        {
            var dbContext = new xRPDataContext();
            cboLoaiVatTu.DataSource = dbContext.Qlvt_LoaiVatTus;
            cboLoaiVatTu.DataTextField = "TenLoaiVatTu";
            cboLoaiVatTu.DataValueField = "ID";
            cboLoaiVatTu.DataBind();
            cboLoaiVatTu.SelectedIndex = cboLoaiVatTu.Items.IndexOf(cboLoaiVatTu.Items.FindByValue(selectedId.ToString()));
            dbContext.Dispose();
        }

        protected void FillData(int id)
        {
            var dbContext = new xRPDataContext();
            var item = dbContext.Qlvt_VatTus.FirstOrDefault(i => i.ID == id);
            if (item != null)
            {
                //-----Fill and selected cbo----
                BindCbo(item.MaLoaiVatTu.Value);
                //-------------------------------
                txtDinhLuong.Text = item.DinhLuong.ToString();
                //txtDonViTinh.Text = item.DonViTinh;
                txtDonViTinh.Text = new xRPDataContext().Qlvt_DonViTinhs.FirstOrDefault(i => i.ID == item.IDDonViTinh).DonViTinh;
                hdfDonViTinh.Value = item.IDDonViTinh.ToString();
                txtGhiChu.Text = item.GhiChu;
                txtKichThuocVatTu.Text = item.KichThuocVatTu.ToString();
                txtMaVatTu.Text = item.MaHieuVatTu;
                txtTenVatTu.Text = item.TenVatTu;
                txtTonToiThieu.Text = item.SoLuongTonToiThieu.Value.ToString();
                try
                {
                    chkKichHoat.Checked = item.KichHoat.Value;
                }
                catch
                {
                    chkKichHoat.Checked = false;
                }
            }
            dbContext.Dispose();

        }
    }
}