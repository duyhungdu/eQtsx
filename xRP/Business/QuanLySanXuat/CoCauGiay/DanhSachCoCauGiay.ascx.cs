using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPRepository;


namespace xRP.Business.QuanLySanXuat.CoCauGiay
{
    public partial class DanhSachCoCauGiay : System.Web.UI.UserControl
    {
        Qlsx_CoCauGiayTheoSongRepository coCauGiayRepository = new Qlsx_CoCauGiayTheoSongRepository();
        protected void Page_Load(object sender, EventArgs e)
        {
            txtIDCoCauGiay.Focus();
            if (Request.QueryString["id"] != null)
            {
                BindData(int.Parse(Request.QueryString["id"]));
            }
            else
            {
                BindData(0);
            }
          
        }
        protected void BindData(int idLoaiSong)
        {
            colPager.MaxPages = 10000;
            colPager.PageSize = 10;
            colPager.DataSource = coCauGiayRepository.GetCoCauGiayTheoLoaiSong(idLoaiSong);
            colPager.BindToControl = rptCoCauGiay;
            rptCoCauGiay.DataSource = colPager.DataSourcePaged;
            rptCoCauGiay.DataBind();
        }

        protected void btnSeach_Click(object sender, EventArgs e)
        {
            BindData(int.Parse(slcIDCoCauGiay.Value));
            Response.Redirect(Util.SERVER_NAME + "/Business/QuanLySanXuat/Default.aspx?page=ccg&id=" + slcIDCoCauGiay.Value);
        }
    }
}