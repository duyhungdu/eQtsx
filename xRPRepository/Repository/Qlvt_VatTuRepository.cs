using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using xRPDAL;

namespace xRPRepository
{
    public class Qlvt_VatTuRepository : DRepository
    {
        public List<Sp_Qlvt_VatTu_SelectResult> GetAllVatTu(int? type, int? id, int? maloaivattu, int? xoa)
        {
            return (from ds in dataContext.Sp_Qlvt_VatTu_Select(type, id, maloaivattu,"", xoa) select ds).ToList();
        }
        public List<Sp_Qlvt_VatTu_SelectResult> SearchVatTu(string sval)
        {
            return (from ds in dataContext.Sp_Qlvt_VatTu_Select(-1, null, null, sval, 0) select ds).ToList();
        }
        public List<Sp_Qlvt_VatTu_SelectResult> SearchVatTu3(string sval)
        {
            return (from ds in dataContext.Sp_Qlvt_VatTu_Select(3, null, null,sval, 0) select ds).ToList();
        }
    }
}
