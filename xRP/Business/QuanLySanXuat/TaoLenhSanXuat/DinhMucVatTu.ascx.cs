using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;

namespace xRP.Business.QuanLySanXuat.TaoLenhSanXuat
{
    public partial class DinhMucVatTu : System.Web.UI.UserControl
    {
        public Sp_Qldh_MatHang_SelectResult matHang;
        public int IDCoCauGiay = 0;
        public int IDLenhSanXuatChiTiet = 0;
        public string RanID = "";
        xRPDataContext dts = new xRPDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Attributes["param"] != null)
            {
                int temp = 0;

                string URL = Attributes["param"];
                var mathangid = Util.GetParam(URL, "mathangid");
                var lenhSanXuatChiTietId = Util.GetParam(URL, "lenhSanXuatChiTietId");
                RanID = Util.GetParam(URL, "ranId");

                int.TryParse(lenhSanXuatChiTietId, out IDLenhSanXuatChiTiet);

                if (int.TryParse(mathangid, out temp))
                {
                    matHang = dts.Sp_Qldh_MatHang_Select(1, temp, (int?)null, 0, 1,"").FirstOrDefault();
                    if (matHang == null)
                        matHang = new Sp_Qldh_MatHang_SelectResult();
                    else
                    {
                        IDCoCauGiay = matHang.IDLoaiSongSanXuat.HasValue ? matHang.IDLoaiSongSanXuat.Value : 0;
                    }

                }
            }

        }
    }
}