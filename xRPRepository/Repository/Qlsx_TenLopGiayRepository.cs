using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using xRPDAL;

namespace xRPRepository
{
    public class Qlsx_TenLopGiayRepository : DRepository
    {

        public List<Sp_Qlsx_TenLopGiay_SelectResult> GetDanhSachTenLopGiay()
        {
            List<Sp_Qlsx_TenLopGiay_SelectResult> listTenLopGiay = (from ds in dataContext.Sp_Qlsx_TenLopGiay_Select(0, null, null, null)
                                                                    select ds).ToList();
            return listTenLopGiay;
        }
        public Sp_Qlsx_TenLopGiay_SelectResult GetTenLopGiayById(int? tenLopGiayId)
        {
            var dataTenLopGiay = dataContext.Sp_Qlsx_TenLopGiay_Select(1, tenLopGiayId, null, null).FirstOrDefault();
            return dataTenLopGiay;

        }
    }
}
