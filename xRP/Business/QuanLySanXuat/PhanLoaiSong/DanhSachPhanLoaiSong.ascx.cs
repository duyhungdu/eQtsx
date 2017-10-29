using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPRepository;
using xRPDAL;

namespace xRP.Business.QuanLySanXuat.PhanLoaiSong
{
    public partial class DanhSachPhanLoaiSong : System.Web.UI.UserControl
    {
        Qlsx_PhanLoaiSongRepository phanLoaiSongRepository = new Qlsx_PhanLoaiSongRepository();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData("");
            }
        }
        protected void BindData(string key)
        {
            if (!string.IsNullOrEmpty(key))
            {
                xRPDataContext dataContext = new xRPDataContext();
                CollectionPager1.MaxPages = 10000;
                CollectionPager1.PageSize = 10;
                CollectionPager1.DataSource = dataContext.Sp_Qlsx_PhanLoaiSong_Select(-1, null, null, 0, null, key).ToList();
                CollectionPager1.BindToControl = rptPhanLoaiSong;
                rptPhanLoaiSong.DataSource = CollectionPager1.DataSourcePaged;
                rptPhanLoaiSong.DataBind();

            }
            else
            {

                xRPDataContext dataContext = new xRPDataContext();
                CollectionPager1.MaxPages = 10000;
                CollectionPager1.PageSize = 10;
                CollectionPager1.DataSource = dataContext.Sp_Qlsx_PhanLoaiSong_Select(0, null, null, 0, null, "").ToList();
                CollectionPager1.BindToControl = rptPhanLoaiSong;
                rptPhanLoaiSong.DataSource = CollectionPager1.DataSourcePaged;
                rptPhanLoaiSong.DataBind();
            }
        }

        protected void btnSeach_Click(object sender, EventArgs e)
        {
            BindData(txtTimKiem.Text);
        }
    }
}