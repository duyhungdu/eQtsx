using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using xRPDAL;

namespace xRPRepository
{
    public class Qldh_LoaiSanPhamRepostity:DRepository
    {
        public List<Sp_Qldh_LoaiSanPham_SelectResult> GetLoaiSanPham(int? type, int? id, int? xoa, int? kichhoat,string keyword)
        {
            List<Sp_Qldh_LoaiSanPham_SelectResult> lstLoaiSanPham = dataContext.Sp_Qldh_LoaiSanPham_Select(type, id, xoa, kichhoat,keyword).ToList();
            return lstLoaiSanPham;
        }
    }
}
