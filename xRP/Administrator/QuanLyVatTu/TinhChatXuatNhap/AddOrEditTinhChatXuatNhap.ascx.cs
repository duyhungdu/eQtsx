using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;
using xRPRepository;

namespace xRP.Administrator.QuanLyVatTu.TinhChatXuatNhap
{
    public partial class AddOrEditTinhChatXuatNhap : System.Web.UI.UserControl
    {
        public string ID_TinhChat { get; set; }
        public string trang { get; set; }
        Qlvt_TinhChatNhapXuatRepository tinhChatNhapXuatRepository = new Qlvt_TinhChatNhapXuatRepository();
        protected void Page_Load(object sender, EventArgs e)
        {
            InitData();
        }
        protected void InitData()
        {
            if (Attributes["param"] != null)
            {
                string URL = Attributes["param"];
                ID_TinhChat = Util.GetParam(URL, "id");
                trang = Util.GetParam(URL, "trang");
                if (ID_TinhChat != "" && ID_TinhChat != "-1")
                {
                    int id = int.Parse(ID_TinhChat);
                    Sp_Qlvt_TinhChatNhapXuat_SelectResult tinhChatNhapXuat = new Sp_Qlvt_TinhChatNhapXuat_SelectResult();
                    tinhChatNhapXuat = tinhChatNhapXuatRepository.GetAllTinhChatNhapXuat(1, id, 0, null).FirstOrDefault();
                    txtMaTinhChat.Text = tinhChatNhapXuat.MaTinhChatNhapXuat;
                    txtTenTinhChat.Text = tinhChatNhapXuat.TenTinhChatNhapXuat;
                    txtGhiChu.Text = tinhChatNhapXuat.GhiChu;
                    rbtnPhanLoai.SelectedValue = tinhChatNhapXuat.PhanLoaiNhapXuat.Value.ToString();
                    if (tinhChatNhapXuat.KichHoat.HasValue)
                    {
                        if (tinhChatNhapXuat.KichHoat.Value)
                        {
                            ckKichHoat.Checked = true;
                        }
                        else
                        {
                            ckKichHoat.Checked = false;
                        }
                    }
                    else
                    {
                        ckKichHoat.Checked = false;
                    }


                    if (tinhChatNhapXuat.NoiBo.HasValue)
                    {
                        if (tinhChatNhapXuat.NoiBo.Value)
                        {
                            chkNoiBo.Checked = true;
                        }
                        else
                        {
                            chkNoiBo.Checked = false;
                        }
                    }
                    else
                    {
                        chkNoiBo.Checked = false;
                    }
                }
            }
        }
    }
}