using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPRepository;

namespace xRP.Business.QuanLySanXuat.CongDoan
{
    public partial class DanhSachCongDoan : System.Web.UI.UserControl
    {
        Qlsx_CongDoanRepository congdoanRepository = new Qlsx_CongDoanRepository();
        protected void Page_Load(object sender, EventArgs e)
        {
            BindData();
        }
        protected void BindData()
        {
            CollectionPager1.MaxPages = 10000;
            CollectionPager1.PageSize = 10;
            CollectionPager1.DataSource = congdoanRepository.GetAllCongDoan(0, null, 0, null);
            CollectionPager1.BindToControl = rptCongDoan;
            rptCongDoan.DataSource = CollectionPager1.DataSourcePaged;
            rptCongDoan.DataBind();
        }
    }
}