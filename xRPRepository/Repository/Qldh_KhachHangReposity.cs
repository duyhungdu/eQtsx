using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using xRPDAL;

namespace xRPRepository
{
    public class Qldh_KhachHangReposity : DRepository
    {
        public List<Sp_Qldh_KhachHang_SelectResult> GetDanhSachKhachHang(int? type, int? id, int? xoa, int? kichHoat,string keyword)
        {
            List<Sp_Qldh_KhachHang_SelectResult> lstKhachHang = dataContext.Sp_Qldh_KhachHang_Select(type, id, xoa,kichHoat,keyword).ToList();
            return lstKhachHang;
        }
        public string ThemHoacSuaKhachHang(string type, int? id, string maKhachHang, string tenKhachHang, int? idNhomKhachHang,
            string diaChi, string dienthoaiLienHe, string fax, string email, string thongtinLienHe,
            bool? kichHoat, string ghiChu, Guid? maNguoiTaoSua, int? id_new_identity, string ip, string pcName)
        {
            return dataContext.Sp_Qldh_KhachHang_Add_Edit_Deli(type, id, maKhachHang, tenKhachHang, idNhomKhachHang, diaChi, dienthoaiLienHe, fax, email, thongtinLienHe, kichHoat, ghiChu, maNguoiTaoSua, maNguoiTaoSua, ref id_new_identity, ip, pcName).FirstOrDefault().Column1;
        }
        /// <summary>
        /// Xóa khách hàng
        /// </summary>
        /// <param name="id"></param>
        /// <param name="maNguoiThayDoi"></param>
        /// <param name="ip"></param>
        /// <param name="pcName"></param>
        public void XoaKhachHang(int? id, Guid? maNguoiThayDoi, string ip, string pcName)
        {
            var result = dataContext.Sp_Qldh_KhachHang_Deli("DEL1", id, maNguoiThayDoi, ip, pcName);
        }
    }
}
