using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;
using xRPRepository;
namespace xRP.Administrator.QuanLyVatTu.DonViTinh
{
    public partial class AddOrEditDonViTinh : System.Web.UI.UserControl
    {
        public string ID_DVT { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Attributes["param"] != null)
            {
                string URL = Attributes["param"];
                ID_DVT = Util.GetParam(URL, "id");
                if (ID_DVT != "" && ID_DVT != "-1")
                {
                    int id = int.Parse(ID_DVT);
                    LoadData(id);
                }
            }
        }
        protected void LoadData(int id)
        {
            Sp_Qlvt_DonViTinh_SelectResult loaivattu = new xRPDAL.xRPDataContext().Sp_Qlvt_DonViTinh_Select(1, id, null, null, "").FirstOrDefault();
            if (loaivattu != null)
            {
                txtTenDonViTinh.Text = loaivattu.DonViTinh;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            //Page.Response.Redirect("~/Administrator/QuanLyVatTu/LoaiVatTu/DanhMucLoaiVatTu.ascx");
        }

    }
}