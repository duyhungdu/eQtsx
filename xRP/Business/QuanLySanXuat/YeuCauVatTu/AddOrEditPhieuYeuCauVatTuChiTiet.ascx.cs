using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;
namespace xRP.Business.QuanLySanXuat.YeuCauVatTu
{
    public partial class AddOrEditPhieuYeuCauVatTuChiTiet : System.Web.UI.UserControl
    {
        public int phieuYeuCauID = 0;
        protected xRPDataContext dts = new xRPDataContext();
        public string phieuYeuCauChiTietID { set; get; }
        protected string randID { set; get; }
        protected string DataVatTu = "{}";
        protected void Page_Load(object sender, EventArgs e)
        {

            int? _PhieuYeuCauChiTietID = null;
            if (Attributes["param"] != null)
            {
                string URL = Attributes["param"];
                phieuYeuCauChiTietID = Util.GetParam(URL, "id");
                randID = Util.GetParam(URL, "randID");
                var strPhieuYeuCauID = Util.GetParam(URL, "phieuyeucauid");
               
                if (strPhieuYeuCauID != "")
                {
                    int.TryParse(strPhieuYeuCauID, out  phieuYeuCauID);
                }
            }
            //var listVatTu = new System.Collections.ArrayList();

            if (phieuYeuCauID == 0)
                _PhieuYeuCauChiTietID = null;
            else _PhieuYeuCauChiTietID = phieuYeuCauID;


            var listVatTu = (from p in dts.Qlsx_PhieuYeuCauVatTuChiTiets
                             join vt in dts.Qlvt_VatTus on p.IDVatTu equals vt.ID
                             where p.IDPhieuYeuCauVatTu == _PhieuYeuCauChiTietID
                             select new
                             {
                                 MaVatTu = vt.ID,
                                 MaHieuLoaiVatTu = vt.MaHieuVatTu
                             }).ToList();
 

            DataVatTu = new JavaScriptSerializer().Serialize(listVatTu);
        }


        //  
    }
}