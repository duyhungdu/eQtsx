using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;
using xRPRepository;

namespace xRP.Administrator.QuanLyVatTu.TinhChatXuatNhap
{
    public partial class DanhMucTinhChatXuatNhap : System.Web.UI.UserControl
    {
        Qlvt_TinhChatNhapXuatRepository tinhChatNhapXuatRepository = new Qlvt_TinhChatNhapXuatRepository();
        
        protected void Page_Load(object sender, EventArgs e)
        {
            
            BindData();
        }
        
        protected void BindData()
        {
            CollectionPager1.MaxPages = 10000;
            CollectionPager1.PageSize = 10;
            CollectionPager1.DataSource = tinhChatNhapXuatRepository.GetAllTinhChatNhapXuat(0, null, 0, null);
            
            CollectionPager1.BindToControl = rptDanhMucTinhChatXuatNhap;
            rptDanhMucTinhChatXuatNhap.DataSource = CollectionPager1.DataSourcePaged;
            rptDanhMucTinhChatXuatNhap.DataBind();
        }
    }
}