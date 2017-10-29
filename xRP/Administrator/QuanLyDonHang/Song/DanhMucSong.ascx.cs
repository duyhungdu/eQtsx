using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPRepository;

namespace xRP.Administrator.QuanLyDonHang.Song
{
    public partial class DanhMucSong : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Bindata();
        }
        public void Bindata()
        {
            Qldh_SongReposity dsSongReposity = new Qldh_SongReposity();
            var listSong = dsSongReposity.GetDanhMucSong(0, null, 0, null,"");
            colPage.MaxPages = 10000;
            colPage.PageSize = 10; // số items hiển thị trên một trang.
            colPage.DataSource = listSong;
            colPage.BindToControl = rptDanhMucHeSoTongGiao;
            rptDanhMucHeSoTongGiao.DataSource = colPage.DataSourcePaged;
            rptDanhMucHeSoTongGiao.DataBind();
        }
    }
}