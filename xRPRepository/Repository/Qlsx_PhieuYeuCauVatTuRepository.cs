using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using xRPDAL;

namespace xRPRepository
{
    public class Qlsx_PhieuYeuCauVatTuRepository : DRepository
    {
        public List<Sp_Qlsx_PhieuYeuCauVatTu_SelectResult> GetDanhSachPhieuYeuCauVatTu(int? type, int? id, string maHieuThamChieu, int? donViYeuCau, DateTime? ngaySuDungTu, DateTime? ngaySuDungDen, int? tinhtrang)
        {
            var lstPhieuYeuCauVatTu = dataContext.Sp_Qlsx_PhieuYeuCauVatTu_Select(type, id, maHieuThamChieu, donViYeuCau, ngaySuDungTu, ngaySuDungDen, tinhtrang).ToList();
            return lstPhieuYeuCauVatTu;
        }

        public Sp_Qlsx_PhieuYeuCauVatTu_SelectResult GetPhieuYeuCauVatTu(int id)
        {
            var phieuYeuCauVatTu = dataContext.Sp_Qlsx_PhieuYeuCauVatTu_Select(1, id, null, null, null, null, null).FirstOrDefault();
            return phieuYeuCauVatTu;
        }
    }
}
