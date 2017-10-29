using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;
using xRP.Security;
using xRPRepository;
using System.Web.Security;

namespace xRP.Administrator.QuanLyHeThong.NguoiDung
{
    public partial class List : System.Web.UI.UserControl
    {
        public string trang { get; set; }
        public int StartIndex { get; set; }
        int pageSize = 20;
        int pageIndex = 1;
        public string RootPageUrl = "/Administrator/QuanLyHeThong/";
        string keyword = string.Empty;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["trang"] != null)
            {
                trang = Request.QueryString["trang"].ToString();
            }
            if (string.IsNullOrEmpty(trang))
            {
                trang = "1";
            }
            if (Request.QueryString["s"] != null)
            {
                keyword = Request.QueryString["s"].ToString();
            }

            txtTimKiem.Text = keyword;

            int.TryParse(trang, out pageIndex);
            StartIndex = pageSize * (pageIndex - 1);

            List<vw_aspnet_User> data=new  List<vw_aspnet_User>();

            data = xRPMembership.GetAllUser(keyword);

            CollectionPager1.MaxPages = 10000;
            CollectionPager1.PageSize = 10; // số items hiển thị trên một trang.
            CollectionPager1.DataSource = data;
            CollectionPager1.BindToControl = rptData;
            rptData.DataSource = CollectionPager1.DataSourcePaged;
            rptData.DataBind();
        }


        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect(Request.RawUrl);
        }

        protected void btTimKiem_Click(object sender, EventArgs e)
        {

        }

        protected void rptData_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                vw_aspnet_User user = (vw_aspnet_User)e.Item.DataItem;
                Label lblActive = (Label)e.Item.FindControl("lblActive");
                Label lblLock = (Label)e.Item.FindControl("lblLock");
                //Label lblOnline = (Label)e.Item.FindControl("lblOnline");
                //if (user.IsOnline) lblOnline.Text = string.Format("<img src='{0}' alt='Đang online'>", "/styles/images/online.png");
                //if (!user.IsOnline) lblOnline.Text = string.Format("<img src='{0}' alt='Đang offline'>", "/styles/images/offline.png");

                if (user.IsApproved) lblActive.Text = string.Format("<img src='{0}' alt='Đang online'>", "/styles/images/online.png");
                if (!user.IsApproved) lblActive.Text = string.Format("<img src='{0}' alt='Đang offline'>", "/styles/images/offline.png");
            }

        }
    }
}