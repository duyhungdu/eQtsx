using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;
using xRPRepository;
namespace xRP.Business.QuanLySanXuat.TaoLenhSanXuat
{
    public partial class DetailLenhSanXuat : System.Web.UI.UserControl
    {
        protected Qlsx_YeuCauSanXuatRepository yeuCauSanXuatRepository = new Qlsx_YeuCauSanXuatRepository();
        protected Qlsx_LenhSanXuatRepository lenhSanXuatRepository = new Qlsx_LenhSanXuatRepository();
        public bool IsDinhMucVatTu = false;
        public int IDLenhSanXuat = 0;
        public int IDCongDoan = -1;
        public string ngayTaoLenhSanXuat = DateTime.Now.ToString("dd/MM/yyyy");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //Lấy về Mã lệnh sản xuất cần sửa.
                var _lenhSanXuatId = Request.QueryString["lenhSanXuatId"];
                //Kiểm tra Mã lênh sản xuất.
                if (_lenhSanXuatId != null & _lenhSanXuatId != "")
                {
                    //Đưa về kiểu giá trị Int của Mã lệnh sản xuất
                    int.TryParse(_lenhSanXuatId, out IDLenhSanXuat);
                }

                //int? IDCongDoan = null;

                //Kiểm tra thông tin dữ liệu lệnh sản xuất  khi sửa thông tin
                var dataLenhSanXuat = lenhSanXuatRepository.GetLenhSanXuatById(IDLenhSanXuat);
                // Nếu tồn tại dữ liệu
                if (dataLenhSanXuat != null)
                {
                    ngayTaoLenhSanXuat = String.Format("{0:dd/MM/yyyy}", dataLenhSanXuat.NgayTao);
                    // Binddata(lenhSanXuatId, dataLenhSanXuat.IDCongDoan);?
                    IDCongDoan = dataLenhSanXuat.IDCongDoan;
                    IsDinhMucVatTu = (IDCongDoan == 1 ? true : false);

                    lblTitle.Text = "Chi tiết lệnh sản xuất: " + dataLenhSanXuat.TenCongDoan;
                }
                else
                {
                    if (Request.QueryString["cd"] != null)
                        IDCongDoan = int.Parse(Request.QueryString["cd"].ToString());
                    lblTitle.Text = "Tạo lệnh sản xuất";
                }


                txtNgayTao.Text = ngayTaoLenhSanXuat;
            }
        }



        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Business/QuanLySanXuat/Default.aspx?page=lsx?cd=" + IDCongDoan);
        }

        protected void ddlCongDoan_SelectedIndexChanged(object sender, EventArgs e)
        {


        }
    }
}