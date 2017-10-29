using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using xRPDAL;

namespace xRPRepository
{
    public class Qlvt_NhaCungCapRepository : DRepository
    {
        public List<Sp_Qlvt_NhaCungCap_SelectResult> GetAllNhaCungCap(int? type, int? id, string mahieu, int? xoa, int? kichhoat)
        {

            return (from ds in dataContext.Sp_Qlvt_NhaCungCap_Select(type, id, mahieu, null, xoa, kichhoat) select ds).ToList();
        }
        public List<Sp_Qlvt_NhaCungCap_SelectResult> SearchNhaCungCap(string sval)
        {

            return dataContext.Sp_Qlvt_NhaCungCap_Select(-1, null, null, sval, 0, null).ToList();
        }
    }
}
