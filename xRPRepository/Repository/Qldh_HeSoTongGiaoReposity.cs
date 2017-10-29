using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using xRPDAL;

namespace xRPRepository
{
    public class Qldh_HeSoTongGiaoReposity:DRepository
    {
        public List<Sp_Qldh_HeSoTongDao_SelectResult> GetHeSoTongGiao(int? type,int? id,int? xoa,int? kichHoat,string keyword)
        {
            List<Sp_Qldh_HeSoTongDao_SelectResult> lstHeSoTongGiao = dataContext.Sp_Qldh_HeSoTongDao_Select(type, id, xoa, kichHoat,keyword).ToList();
            return lstHeSoTongGiao;
        }
    }
}
