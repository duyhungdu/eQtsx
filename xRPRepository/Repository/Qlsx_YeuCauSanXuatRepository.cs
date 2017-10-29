using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using xRPDAL;

namespace xRPRepository
{
    public class Qlsx_YeuCauSanXuatRepository : DRepository
    {

        public List<Sp_Qlsx_YeuCauSanXuat_SelectResult> GetDanhSachYeuCauSanXuat(int? type, int? congDoanId, int? khachHangId, int? donHangId)
        {

            //Sp_Qlsx_YeuCauSanXuatSelect
            List<Sp_Qlsx_YeuCauSanXuat_SelectResult> listYeuCauSanXuat = (from ds in dataContext.Sp_Qlsx_YeuCauSanXuat_Select(type, null, congDoanId, null, khachHangId, donHangId, 0, 0)
                                                                          select ds).ToList();

            return listYeuCauSanXuat;
        }

        public Sp_Qlsx_YeuCauSanXuat_SelectResult GetYeuCauSanXuat(int? id)
        {                                                                                    //Sp_Qlsx_YeuCauSanXuatSelect
            var yeuCauSanXuat = dataContext.Sp_Qlsx_YeuCauSanXuat_Select(1, id, null, null, null, null, 0, 0).FirstOrDefault();

            if (yeuCauSanXuat != null)
                return yeuCauSanXuat;
            else
                return new Sp_Qlsx_YeuCauSanXuat_SelectResult();
        }


        public List<Sp_Qlsx_LenhSanXuatChiTiet_SelectResult> GetDanhSachLenhSanXuatChiTiet(int? lenhSanXuatId, int? congDoanId, int? khachHangId, int? donHangId)
        {
            //Sp_Qlsx_YeuCauSanXuatSelect
            List<Sp_Qlsx_LenhSanXuatChiTiet_SelectResult> listLenhSanXuatChiTiet = dataContext.Sp_Qlsx_LenhSanXuatChiTiet_Select(3, null, congDoanId, lenhSanXuatId, khachHangId, donHangId, null).OrderBy(p => p.TT).ToList();
            return listLenhSanXuatChiTiet;
        }
    }
}
