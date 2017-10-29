using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;

namespace xRP.Lab.ThongSoHeThong
{
    public partial class ThongSoHeThong : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string page = "";
            if (Request.QueryString["page"] != null)
            {
                page = Request.QueryString["page"];
                switch (page)
                {
                    case "tsht": LoadDanhSachThongSoHeThong(); break;

                }
            }
        }
        protected void LoadDanhSachThongSoHeThong()
        {
            Lab.ThongSoHeThong.DanhMucThongSo danhmucThongSo = (Lab.ThongSoHeThong.DanhMucThongSo)this.Page.LoadControl("~/Lab/ThongSoHeThong/DanhMucThongSo.ascx");
            plcContent.Controls.Add(danhmucThongSo);
        }
    }
}