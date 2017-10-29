using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;

namespace xRP.Administrator.QuanLyDonHang.DonHang.XuLyDonHang
{
    public partial class DinhMucVatTu : System.Web.UI.UserControl
    {
        public Sp_Qldh_MatHang_SelectResult matHang;
        public int IDCoCauGiay = 0;
        xRPDataContext dts = new xRPDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.Params["mathangid"]))
            {
                int temp = 0;
                if (int.TryParse(Request.Params["mathangid"], out temp))
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