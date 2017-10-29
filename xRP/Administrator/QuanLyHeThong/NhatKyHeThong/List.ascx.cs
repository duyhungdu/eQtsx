using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;
using xRPRepository;


namespace xRP.Administrator.QuanLyHeThong.NhatKyHeThong
{
    public partial class List : System.Web.UI.UserControl
    {
        public string RootPageUrl = "/Administrator/QuanLyHeThong/";


        public string trang { get; set; }
        public int StartIndex { get; set; }
        int pageSize = 20;
        int pageIndex = 1;

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

            int.TryParse(trang, out pageIndex);
            StartIndex = pageSize * (pageIndex - 1);

            //Sys_UserLogRepository repository = new Sys_UserLogRepository();
            ////List<Sys_Log> data = repository.GetTable().OrderByDescending(x => x.ThoiGianThucHien).ToList();
            //List<Sys_UserLog> data = new List<Sys_UserLog>();
            xRPDataContext dataContext = new xRPDataContext();
            List<Sp_Qlht_NhatKyHeThong_SelectResult> data = dataContext.Sp_Qlht_NhatKyHeThong_Select().ToList();

            CollectionPager1.MaxPages = 10000;
            CollectionPager1.PageSize = 20; // số items hiển thị trên một trang.
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
    }
}