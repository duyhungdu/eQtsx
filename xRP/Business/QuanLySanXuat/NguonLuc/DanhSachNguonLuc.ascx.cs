using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPRepository;

namespace xRP.Business.QuanLySanXuat.NguonLuc
{
    public partial class DanhSachNguonLuc : System.Web.UI.UserControl
    {
        Qlnl_NguonLucRepository nguonLucRepository = new Qlnl_NguonLucRepository();
        protected void Page_Load(object sender, EventArgs e)
        {
            BindData();
        }
        protected void BindData()
        {
            CollectionPager1.MaxPages = 10000;
            CollectionPager1.PageSize = 10;
            CollectionPager1.DataSource = nguonLucRepository.GetAllNguonLuc(0, null, 0, null, null,"");
            CollectionPager1.BindToControl = rptNguonLuc;
            rptNguonLuc.DataSource = CollectionPager1.DataSourcePaged;
            rptNguonLuc.DataBind();
        }
    }
}