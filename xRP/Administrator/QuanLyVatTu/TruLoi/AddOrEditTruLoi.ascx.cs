using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;

namespace xRP.Administrator.QuanLyVatTu.TruLoi
{
    public partial class AddOrEditTruLoi : System.Web.UI.UserControl
    {
        public string ID_TruLoi = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Attributes["param"] != null)
            {
                string URL = Attributes["param"];
                ID_TruLoi = Util.GetParam(URL, "id");
                if (ID_TruLoi != "" && ID_TruLoi != "-1")
                {
                    int id = int.Parse(ID_TruLoi);
                    LoadData(id);
                }
            }
        }
        protected void LoadData(int id)
        {
            xRPDataContext dataContext = new xRPDataContext();
            Qlvt_TruLoi truloi = new Qlvt_TruLoi();
            truloi = dataContext.Qlvt_TruLois.Where(x => x.id == id).FirstOrDefault();
            if (truloi != null)
            {
                txtTruLoi.Text = truloi.TruLoi != null ? truloi.TruLoi.Value.ToString() : "";
                txtSoSanh.Text = truloi.SoSanh.ToString();
                txtLoaiVatTu.Text = truloi.MaHieuLoaiVatu;
                txtKichThuoc.Text = truloi.KichThuoc != null ? truloi.KichThuoc.Value.ToString() : "";
            }
        }
    }
}