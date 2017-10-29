using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;
using xRPRepository;

namespace xRP.Administrator.QuanLyVatTu.Kho
{
    public partial class AddOrEditKho : System.Web.UI.UserControl
    {
        public string ID_Kho { get; set; }
        public string trang { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {

            xRPDataContext getalldmkho2 = new xRPDataContext();
            //List<Qlvt_KhoVatTu> lst = (from ds in getalldmkho2.Qlvt_KhoVatTu_GetAll()
            //                           select new Qlvt_KhoVatTu
            //                           {
            //                               ID = ds.ID,
            //                               MaHieuKho = ds.MaHieuKho,
            //                               TenKhoVatTu = ds.TenKhoVatTu
            //                           }).ToList();
            //dropThuocTongKho.DataSource = lst;
            //dropThuocTongKho.DataTextField = "TenKhoVatTu";
            //dropThuocTongKho.DataValueField = "ID";
            //dropThuocTongKho.DataBind();
            //dropThuocTongKho.Items.Insert(0, new ListItem("Tất cả", "0"));
            if (Attributes["param"] != null)
            {
                string URL = Attributes["param"];
                ID_Kho = Util.GetParam(URL, "id");
                trang = Util.GetParam(URL, "trang");

                if (ID_Kho != "" && ID_Kho != "-1")
                {
                    int id = int.Parse(ID_Kho);

                    Qlvt_KhoVatTu qlkho = (from c2 in getalldmkho2.Qlvt_KhoVatTus where c2.ID == id select c2).FirstOrDefault();
                    txtMaKho.Text = qlkho.MaHieuKho;
                    txtTenKho.Text = qlkho.TenKhoVatTu;
                    dropThuocTongKho.SelectedValue = qlkho.MaKhoCapTren.Value.ToString();
                    txtDiaChi.Text = qlkho.DiaChi;
                    txtSoDienThoai.Text = qlkho.SoDienThoai;
                    txtNguoiPhuTrach.Text = qlkho.NguoiPhuTrach;
                    if (qlkho.KichHoat.Value == true)
                    {

                        ckKichHoat.Checked = true;
                    }
                    else
                    {

                        ckKichHoat.Checked = false;
                    }
                    if (qlkho.LoaiKho.Value == true)
                    {
                        rdlLoaiKho.SelectedValue = "1";
                    }
                    else
                    {
                        rdlLoaiKho.SelectedValue = "0";
                    }
                    txtGhiChu.Text = qlkho.GhiChu;
                }

            }

        }

    }
}