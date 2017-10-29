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
    public partial class AddOrEditLenhSanXuat : System.Web.UI.UserControl
    {
        protected Qlsx_YeuCauSanXuatRepository yeuCauSanXuatRepository = new Qlsx_YeuCauSanXuatRepository();
        protected Qlsx_LenhSanXuatRepository lenhSanXuatRepository = new Qlsx_LenhSanXuatRepository();
        protected xRPDataContext dts = new xRPDataContext();
        public bool IsDinhMucVatTu = false;
        public int IDLenhSanXuat = 0;
        public int IDCongDoan = -1;
        public string ngayTaoLenhSanXuat = DateTime.Now.ToString("dd/MM/yyyy");
        public int thoiGianCanSanXuat = 9;
        public int congXuatMaySong = 35 * 60;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //Lấy về Mã lệnh sản xuất cần sửa.
                var _lenhSanXuatId = Request.QueryString["lenhSanXuatId"];
                //Kiểm tra Mã lênh sản xuất.
                if (_lenhSanXuatId != null & _lenhSanXuatId != "")
                    //Đưa về kiểu giá trị Int của Mã lệnh sản xuất
                    int.TryParse(_lenhSanXuatId, out IDLenhSanXuat);


                //int? IDCongDoan = null;

                //Kiểm tra thông tin dữ liệu lệnh sản xuất  khi sửa thông tin
               var dataLenhSanXuat = lenhSanXuatRepository.GetLenhSanXuatById(IDLenhSanXuat);
               //var dataLenhSanXuat = dts.Qlsx_LenhSanXuats.Where(x => x.ID == IDLenhSanXuat).FirstOrDefault() ;
                
                // Nếu tồn tại dữ liệu
                if (dataLenhSanXuat != null)
                {
                    ngayTaoLenhSanXuat = String.Format("{0:dd/MM/yyyy}", dataLenhSanXuat.NgaySanXuat);
                    // Binddata(lenhSanXuatId, dataLenhSanXuat.IDCongDoan);?
                    IDCongDoan = dataLenhSanXuat.IDCongDoan;
                    IsDinhMucVatTu = (IDCongDoan == 1 ? true : false);

                    lblTitle.Text = "Sửa lệnh sản xuất: " + dataLenhSanXuat.TenCongDoan;

                }
                else
                {
                    if (Request.QueryString["cd"] != null)
                        IDCongDoan = int.Parse(Request.QueryString["cd"].ToString());
                    lblTitle.Text = "Tạo lệnh sản xuất";
                }
                // Đưa dữ liệu lên lưới hiển thị<Grid> theo mã lênh sản xuất và công đoạn.

                //Đưa dữ liệu Công đoạn lên dropdownlist.
                if (IDCongDoan != -1)
                {
                    BinddataDrop(IDCongDoan);
                }
                else
                {
                    BinddataDrop(0);
                }

                txtNgayTao.Text = ngayTaoLenhSanXuat;

                var sysGiaTri = dts.Sys_ThongSoHeThongs.FirstOrDefault(p => p.ThongSo.Equals("THOIGIANCASANXUAT")).GiaTri;
                if (!string.IsNullOrEmpty(sysGiaTri))
                    int.TryParse(sysGiaTri, out thoiGianCanSanXuat);
                thoiGianCanSanXuat = thoiGianCanSanXuat == 0 ? 9 : thoiGianCanSanXuat;

                var sysCongXuat = dts.Sys_ThongSoHeThongs.FirstOrDefault(p => p.ThongSo.Equals("CONGSUATMAYSONG")).GiaTri;
                if (!string.IsNullOrEmpty(sysCongXuat))
                    int.TryParse(sysCongXuat, out congXuatMaySong);
                congXuatMaySong = congXuatMaySong == 0 ? 35 * 60 : congXuatMaySong;

            }
        }
        /// <summary>
        /// Hàm đưa dữ liệu lên dropdowwnlist
        /// </summary>
        protected void BinddataDrop(int? congDoanId)
        {
            Qlsx_CongDoanRepository danhSachCongDoan = new Qlsx_CongDoanRepository();
            var danhsachCongDoanData = danhSachCongDoan.GetAllCongDoan(2, null, null, null);
            ddlCongDoan.DataSource = danhsachCongDoanData;
            ddlCongDoan.DataBind();
            if (congDoanId != null)
                ddlCongDoan.SelectedValue = congDoanId.ToString();

            else congDoanId = danhsachCongDoanData[0].ID;

            //Binddata(IDLenhSanXuat, congDoanId);
        }

        /// <summary>
        /// Hàm lấy dữ liệu lên lưới hiển thị.
        /// </summary>
        /// <param name="lenhSanXuatId"></param>
        /// <param name="congDoanId"></param>
        /// <returns></returns>


        protected void btnCancel_Click(object sender, EventArgs e)
        {
            //Response.Redirect("/Business/QuanLySanXuat/Default.aspx?page=tlsx&cd=1");
            Response.Redirect("/Business/QuanLySanXuat/Default.aspx?page=lsx&cd=" + IDCongDoan);
        }

        protected void ddlCongDoan_SelectedIndexChanged(object sender, EventArgs e)
        {
            int id = 0;
            int.TryParse(ddlCongDoan.SelectedItem.Value, out id);
        }
    }
}