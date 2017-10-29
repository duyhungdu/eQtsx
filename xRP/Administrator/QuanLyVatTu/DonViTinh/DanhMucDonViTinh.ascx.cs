using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPRepository;
using xRPDAL;
using System.Web.Services;

namespace xRP.Administrator.QuanLyVatTu.DonViTinh
{
    public partial class DanhMucDonViTinh : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            searchbox.Focus();
            if (!IsPostBack)
            {
                BindData("");
            }
        }
         protected void BindData(string keyword)
        {
            if (!string.IsNullOrEmpty(keyword))
            {
                var x = new xRPDataContext().Sp_Qlvt_DonViTinh_Select(-1, null, 0, null, keyword).OrderByDescending(vt => vt.NgayTao).ToList();
                colPage.MaxPages = 10000;
                colPage.PageSize = 10; // số items hiển thị trên một trang.
                colPage.DataSource = x;
                colPage.BindToControl = rptDanhMucLoaiVatTu;
                rptDanhMucLoaiVatTu.DataSource = colPage.DataSourcePaged;
                rptDanhMucLoaiVatTu.DataBind();
            }
            else
            {
                var x = new xRPDataContext().Sp_Qlvt_DonViTinh_Select(0, null, 0, null, "").OrderByDescending(vt => vt.NgayTao).ToList();
                colPage.MaxPages = 10000;
                colPage.PageSize = 10; // số items hiển thị trên một trang.
                colPage.DataSource = x;
                colPage.BindToControl = rptDanhMucLoaiVatTu;
                rptDanhMucLoaiVatTu.DataSource = colPage.DataSourcePaged;
                rptDanhMucLoaiVatTu.DataBind();
            }
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindData(searchbox.Value);
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect(Request.RawUrl);
        }

    }
}