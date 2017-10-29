using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPRepository;

namespace xRP.Business.QuanLySanXuat.LopGiay
{
    public partial class DanhSachLopGiay : System.Web.UI.UserControl
    {
        Qlsx_TenLopGiayRepository tenLopGiayRepository = new Qlsx_TenLopGiayRepository();
        protected void Page_Load(object sender, EventArgs e)
        {
            BindData();
        }
        protected void BindData()
        {
            CollectionPager1.MaxPages = 10000;
            CollectionPager1.PageSize = 10;
            CollectionPager1.DataSource = tenLopGiayRepository.GetDanhSachTenLopGiay();
            CollectionPager1.BindToControl = rptTenLopGiay;
            rptTenLopGiay.DataSource = CollectionPager1.DataSourcePaged;
            rptTenLopGiay.DataBind();
        }
    }
}