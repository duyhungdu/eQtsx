using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using xRPDAL;

namespace xRPRepository
{
    public class Qldh_KichThuocReposity : DRepository
    {
        public List<Sp_Qldh_LoaiKichThuoc_SelectResult> GetLoaiKichThuoc(int? type, int? id, int? xoa, int? kichHoat,string keyword)
        {
            List<Sp_Qldh_LoaiKichThuoc_SelectResult> lstLoaiKichThuoc = dataContext.Sp_Qldh_LoaiKichThuoc_Select(type, id, xoa, kichHoat,keyword).ToList();
            return lstLoaiKichThuoc;
        }
    }
}
