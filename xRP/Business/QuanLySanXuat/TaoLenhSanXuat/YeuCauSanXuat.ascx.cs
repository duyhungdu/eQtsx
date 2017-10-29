using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;
using xRPRepository;
namespace xRP.Business.QuanLySanXuat.TaoLenhSanXuat
{
    public partial class YeuCauSanXuat : System.Web.UI.UserControl
    {
        protected Qlsx_YeuCauSanXuatRepository yeuCauSanXuatRepository = new Qlsx_YeuCauSanXuatRepository();
        protected Qlsx_LenhSanXuatRepository lenhSanXuatRepository = new Qlsx_LenhSanXuatRepository();
        protected void Page_Load(object sender, EventArgs e)
        {
            string congdoan = Request.QueryString["cd"] != null ? Request.QueryString["cd"].ToString() : "1";
            string tinhtrang = Request.QueryString["tinhtrang"] != null ? Request.QueryString["tinhtrang"].ToString() : "1";
            int? khachhang = null;
            int? donhang = null;
            if (Request.QueryString["kh"] != null)
            {
                if (Request.QueryString["kh"].ToString() != "0")
                {
                    khachhang = int.Parse(Request.QueryString["kh"].ToString());
                }
            }
            if (Request.QueryString["dh"] != null)
            {
                if (Request.QueryString["dh"].ToString() != "0")
                {
                    donhang = int.Parse(Request.QueryString["dh"].ToString());
                }
            }
            ddlTinhTrang.Items.FindByValue(tinhtrang).Selected = true;
            xRPDataContext dts = new xRPDataContext();
            colPageYeuCauSanXuat.MaxPages = 10000;
            colPageYeuCauSanXuat.PageSize = 10; // số items hiển thị trên một trang.
            switch (tinhtrang)
            {
                case "1": colPageYeuCauSanXuat.DataSource = dts.Sp_Qlsx_YeuCauSanXuat_Select(2, null, int.Parse(congdoan), null, khachhang, donhang, null, null).OrderByDescending(x => x.NgayTao).ToList(); break;// lấy tất cả
                case "2": colPageYeuCauSanXuat.DataSource = dts.Sp_Qlsx_YeuCauSanXuat_Select(2, null, int.Parse(congdoan), null, khachhang, donhang, 0, 0).OrderByDescending(x => x.NgayTao).ToList(); break;// lấy đang sản xuất
                case "3": colPageYeuCauSanXuat.DataSource = dts.Sp_Qlsx_YeuCauSanXuat_Select(2, null, int.Parse(congdoan), null, khachhang, donhang, 1, 0).OrderByDescending(x => x.NgayTao).ToList(); break;//lấy đã kết thúc
                case "4": colPageYeuCauSanXuat.DataSource = dts.Sp_Qlsx_YeuCauSanXuat_Select(2, null, int.Parse(congdoan), null, khachhang, donhang, null, 1).OrderByDescending(x => x.NgayTao).ToList(); break;//lấy đã hủy
            }
            colPageYeuCauSanXuat.BindToControl = rptYeuCauSanXuat;
            rptYeuCauSanXuat.DataSource = colPageYeuCauSanXuat.DataSourcePaged;
            rptYeuCauSanXuat.DataBind();
        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Business/QuanLySanXuat/Default.aspx?page=dsycsx");
        }
        protected void ddlCongDoan_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void rptYeuCauSanXuat_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            Sp_Qlsx_YeuCauSanXuat_SelectResult ycsx = (Sp_Qlsx_YeuCauSanXuat_SelectResult)e.Item.DataItem;
            Literal ltFunc = (Literal)e.Item.FindControl("ltFunction");
            Literal ltStatus = (Literal)e.Item.FindControl("ltTinhTrang");

            if (ycsx != null)
            {
                string tinhtrang = ycsx.TinhTrang != null ? ycsx.TinhTrang.Value.ToString() : "0";
                bool xoa = ycsx.Xoa != null ? ycsx.Xoa.Value : false;
                if (xoa)
                {
                    ltStatus.Text = "Đã hủy";
                }
                else
                {
                    if (tinhtrang == "0")
                    {
                        ltStatus.Text = "Đang sản xuất";
                    }
                    else
                    {
                        ltStatus.Text = "Đã hoàn thành";
                    }
                }
                switch (tinhtrang)
                {
                    case "0":
                        if (ycsx.Xoa != null ? ycsx.Xoa.Value : false)
                        {
                            ltFunc.Text += "<li class=\"menu-item\"><a href='javascript:HuyHuy(\"" + ycsx.ID + "\");' title=\"Khôi phục yêu cầu\"><span class=\"icon revert-icon\"></span><span class=\"text\">Khôi phục yêu cầu</span></a></li>";
                        }
                        else
                        {
                            ltFunc.Text += "<li class=\"menu-item\"><a href='javascript:KetThucYeuCau(\"" + ycsx.ID + "\");' title=\"Kết thúc yêu cầu\"><span class=\"icon accept-icon\"></span><span class=\"text\">Kết thúc yêu cầu</span></a></li>";
                            ltFunc.Text += "<li class=\"menu-item\"><a href='javascript:HuyYeuCau(\"" + ycsx.ID + "\");' title=\"Hủy yêu cầu\"><span class=\"icon stop-icon\"></span><span class=\"text\">Hủy yêu cầu</span></a></li>";
                            ltFunc.Text += "<li class=\"menu-item\"><a href='javascript:OpenModalCanhBaoVatTu(\"" + ycsx.ID + "\");' title=\"Xem phương án vật tư\"><span class=\"icon icon-kcs\"></span><span class=\"text\">Xem phương án vật tư</span></a></li>";
                        }
                        break;
                    case "1":
                        {
                            if (ycsx.Xoa != null ? ycsx.Xoa.Value : false)
                            {
                                ltFunc.Text += "<li class=\"menu-item\"><a href='javascript:HuyHuy(\"" + ycsx.ID + "\");' title=\"Khôi phục yêu cầu\"><span class=\"icon revert-icon\"></span><span class=\"text\">Khôi phục yêu cầu</span></a></li>";
                            }
                            else
                            {
                                ltFunc.Text += "<li class=\"menu-item\"><a href='javascript:HuyKetThucYeuCau(\"" + ycsx.ID + "\");' title=\"Hủy kết thúc yêu cầu\"><span class=\"icon undo-icon\"></span><span class=\"text\">Hủy kết thúc yêu cầu</span></a></li>";

                            }
                        }
                        break;
                }
            }
        }
    }
}