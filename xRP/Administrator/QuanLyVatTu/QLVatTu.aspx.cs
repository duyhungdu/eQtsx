using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace xRP.Administrator.QuanLyVatTu
{
    public partial class QLVatTu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string page = "";
            if (Request.QueryString["page"] != null)
            {
                page = Request.QueryString["page"];
                switch (page)
                {
                    case "tcnx": LoadDanhSachTinhChatNhapXuat(); break;
                    
                }
            }
        }
        protected void LoadDanhSachTinhChatNhapXuat()
        {
            Administrator.QuanLyVatTu.TinhChatXuatNhap.DanhMucTinhChatXuatNhap danhMucTinhChatNhapXuat = (Administrator.QuanLyVatTu.TinhChatXuatNhap.DanhMucTinhChatXuatNhap)this.Page.LoadControl("~/Administrator/QuanLyVatTu/TinhChatXuatNhap/DanhMucTinhChatXuatNhap.ascx");
            plcContent.Controls.Add(danhMucTinhChatNhapXuat);
        }
    }
}