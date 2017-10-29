using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;
using xRPRepository;

namespace xRP.Administrator.QuanLyVatTu.Kho
{
    public partial class DanhMucKho : System.Web.UI.UserControl
    {
        public string trang { get; set; }
        public string id_khohang { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["trang"] != null)
            {
                trang = Request.QueryString["trang"].ToString();
            }
            if (Request.QueryString["idKhoHang"] != null)
            {
                id_khohang = Request.QueryString["idKhoHang"].ToString();
            }
            var lstTinhChatNhapXuat = new xRPDataContext().Sp_Qlvt_KhoVatTu_Select(0,0,"",(bool?)null,0,null).OrderByDescending(kho => kho.TenKhoVatTu).ToList();
            if (!string.IsNullOrEmpty(id_khohang))
            {
                lstTinhChatNhapXuat = (from ds in lstTinhChatNhapXuat where ds.ID == int.Parse(id_khohang) select ds).ToList();
            }
            CollectionPager1.MaxPages = 10000;
            CollectionPager1.PageSize = 10; // số items hiển thị trên một trang.
            CollectionPager1.DataSource = lstTinhChatNhapXuat;
            CollectionPager1.BindToControl = rptDanhMuckho;
            rptDanhMuckho.DataSource = CollectionPager1.DataSourcePaged;
            rptDanhMuckho.DataBind();
        }

        protected void ltrRefresh_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect(Request.RawUrl);
        }

        protected void btTimKiem_Click(object sender, EventArgs e)
        {

        }

    }
}