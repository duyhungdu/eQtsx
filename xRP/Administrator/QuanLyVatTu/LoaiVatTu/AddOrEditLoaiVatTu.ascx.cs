using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;
using xRPRepository;
namespace xRP.Administrator.QuanLyVatTu.LoaiVatTu
{
    public partial class AddOrEditLoaiVatTu : System.Web.UI.UserControl
    {
        public string ID_LoaiVatTu { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Attributes["param"] != null)
            {
                string URL = Attributes["param"];
                ID_LoaiVatTu = Util.GetParam(URL, "id");
                if (ID_LoaiVatTu != "" && ID_LoaiVatTu!="-1")
                {
                    int id = int.Parse(ID_LoaiVatTu);
                    LoadData(id);
                }
            }
        }
        protected void LoadData(int id)
        {
            Sp_Qlvt_LoaiVatTu_SelectResult loaivattu = new xRPDAL.xRPDataContext().Sp_Qlvt_LoaiVatTu_Select(1, id, "", null, null,"").FirstOrDefault();
            if (loaivattu != null)
            {
                AddOrEditLoaiVatTu_txtMaLoai.Text = loaivattu.MaHieuLoaiVatTu;
                AddOrEditLoaiVatTu_txtMaLoai.Enabled = false;
                AddOrEditLoaiVatTu_txtTenLoai.Text = loaivattu.TenLoaiVatTu;
                AddOrEditLoaiVatTu_txtGhiChu.Text = loaivattu.GhiChu;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            //Page.Response.Redirect("~/Administrator/QuanLyVatTu/LoaiVatTu/DanhMucLoaiVatTu.ascx");
        }

    }
}