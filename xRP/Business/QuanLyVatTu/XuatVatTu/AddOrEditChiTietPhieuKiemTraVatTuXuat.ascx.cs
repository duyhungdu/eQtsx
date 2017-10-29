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
    public partial class AddOrEditChiTietPhieuKiemTraVatTuXuat : System.Web.UI.UserControl
    {
        protected xRPDataContext dts = new xRPDataContext();
        public string ID_VatTu { set; get; }
        protected string DataVatTu = "{}";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Attributes["param"] != null)
            {
                string URL = Attributes["param"];
                ID_VatTu = Util.GetParam(URL, "id");
                if (ID_VatTu != "")
                {
                }
            }
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
    }
}