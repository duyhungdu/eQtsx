using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPRepository;

namespace xRP.Business.QuanLySanXuat.TaoLenhSanXuat
{
    public partial class CapNhatLenhSanXuat : System.Web.UI.UserControl
    {
        protected Qlsx_YeuCauSanXuatRepository yeuCauSanXuatRepository = new Qlsx_YeuCauSanXuatRepository();
        public int lenhSanXuatId = -1;
        public string ngayCapNhatLenhSanXuat = DateTime.Now.ToString("dd/MM/yyyy");

        public string congDoanId = string.Empty;

        //public bool lenhSanXuatId = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var _lenhSanXuatId = Request.QueryString["lenhSanXuatId"];

                if (Request.QueryString["cd"] != null)
                    congDoanId = Request.QueryString["cd"].ToString();

                if (_lenhSanXuatId != null && _lenhSanXuatId != "")
                {
                    int.TryParse(_lenhSanXuatId, out lenhSanXuatId);
                }
               // Binddata(lenhSanXuatId);
            }
            txtNgayTao.Text = ngayCapNhatLenhSanXuat;
        }


        public void Binddata(int? lenhSanXuatId)
        {
            //Kiểm tra tồn tại danh sách Lệnh sản xuất chi tiết
            var listLenhSanXuatChiTiet = yeuCauSanXuatRepository.GetDanhSachLenhSanXuatChiTiet(lenhSanXuatId, null, null, null);
            CollectionPager1.MaxPages = 10000;
            CollectionPager1.PageSize = 10;
            CollectionPager1.DataSource = listLenhSanXuatChiTiet;// yeuCauSanXuatRepository.GetDanhSachYeuCauSanXuat(congDoanId);
            CollectionPager1.BindToControl = rptYeuCauSanXuat;
            rptYeuCauSanXuat.DataSource = CollectionPager1.DataSourcePaged;
            rptYeuCauSanXuat.DataBind();
        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Business/QuanLySanXuat/Default.aspx?page=lsx&cd=" + congDoanId);
        }

    }
}