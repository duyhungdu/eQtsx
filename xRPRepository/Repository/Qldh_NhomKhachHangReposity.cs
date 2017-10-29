using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using xRPDAL;

namespace xRPRepository
{
   public class Qldh_NhomKhachHangReposity:DRepository
    {
       public List<Sp_Qldh_NhomKhachHang_SelectResult> GetNhomKhachHang(int? type, int? id, int? xoa, int? kichHoat,string keyword)
       {
           List<Sp_Qldh_NhomKhachHang_SelectResult> lstNhomKhachHang = dataContext.Sp_Qldh_NhomKhachHang_Select(type, id, xoa, kichHoat,keyword).ToList();
           return lstNhomKhachHang;
       }
    }
}
