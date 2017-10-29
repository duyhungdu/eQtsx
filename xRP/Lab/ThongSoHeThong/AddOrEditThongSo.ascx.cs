using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;

namespace xRP.Lab.ThongSoHeThong
{
    public partial class AddOrEditThongSo : System.Web.UI.UserControl
    {
        public string ListTinhChatNhapXuat = "";
        xRPDataContext datacontext = new xRPDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {

            //Lấy từ trong bảng Sys_ThongSoHeThong ra quy tắc sinh mã gán vào biến partern
            string partern = "PNK:5";
            // Lấy ra thông số của mã phiếu lớn nhất
            int heightest = 11;
            //Gọi hàm
            GenerateMaPhieu(partern, heightest);


            //Lấy ra danh sách Tính chất nhập xuất dưới dạng chuỗi
            //  ListTinhChatNhapXuat = "{\"name\":\"John Johnson\",\"street\": \"Oslo West 16\",\"phone\": \"555 1234567\"}";


            List<Qlvt_TinhChatNhapXuat> listTinhChatNhapXuat = new List<Qlvt_TinhChatNhapXuat>();
            listTinhChatNhapXuat = datacontext.Qlvt_TinhChatNhapXuats.ToList();
            string result = "{";
            string temp = "\"{0}\":\"{1}\"";
            string temp2 = ",\"{0}\":\"{1}\"";
            string close_str = "}";
            foreach (Qlvt_TinhChatNhapXuat tinhchat in listTinhChatNhapXuat)
            {
                if (result == "{")
                {
                    result += string.Format(temp, tinhchat.ID, tinhchat.TenTinhChatNhapXuat);
                }
                else
                {
                    result += string.Format(temp2, tinhchat.ID, tinhchat.TenTinhChatNhapXuat);
                }
            }
            result += close_str;
            ListTinhChatNhapXuat = result;
        }
        protected void GenerateMaPhieu(string partern, int hightest)
        {
            txtMaLoai.Text = Util.GenerateCode(partern, hightest);
        }
        /// <summary>
        /// Load danh sách Tính chất nhập xuất phục vụ AutoSuggest
        /// </summary>
        /// <returns></returns>
        public string LoadListTinhChatNhapXuat()
        {

            return "";
        }
    }
}