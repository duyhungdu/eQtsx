using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using xRPDAL;

namespace xRPRepository
{
    public class Qlsx_LenhSanXuatRepository : DRepository
    {

        public List<Sp_Qlsx_LenhSanXuat_SelectResult> GetDanhSachLenhSanXuat(int? congDoanId, int? khachHangId, int? donHangId)
        {                                                                                    //Sp_Qlsx_YeuCauSanXuatSelect
            List<Sp_Qlsx_LenhSanXuat_SelectResult> listLenhSanXuat = dataContext.Sp_Qlsx_LenhSanXuat_Select(2, null, congDoanId, khachHangId, donHangId, null, null, null).ToList();
            if (listLenhSanXuat.Count > 0) return listLenhSanXuat;
            else return new List<Sp_Qlsx_LenhSanXuat_SelectResult>();

        }
        public List<Sp_Qlsx_LenhSanXuat_SelectResult> GetDanhSachLenhSanXuat(int? congDoanId, DateTime? ngaySanXuatTu, DateTime? ngaySanXuatDen)
        {                                                                                    //Sp_Qlsx_YeuCauSanXuatSelect
            List<Sp_Qlsx_LenhSanXuat_SelectResult> listLenhSanXuat = dataContext.Sp_Qlsx_LenhSanXuat_Select(2, null, congDoanId, null, null, null, ngaySanXuatTu, ngaySanXuatDen).ToList();
            if (listLenhSanXuat.Count > 0) return listLenhSanXuat;
            else return new List<Sp_Qlsx_LenhSanXuat_SelectResult>();

        }

        public Sp_Qlsx_LenhSanXuat_SelectResult GetLenhSanXuatById(int? lenhSanXuatId)
        {                                                                                    //Sp_Qlsx_YeuCauSanXuatSelect
            var dataLenhSanXuat = dataContext.Sp_Qlsx_LenhSanXuat_Select(1, lenhSanXuatId, null, null, null, null, null, null).FirstOrDefault();
            return dataLenhSanXuat;
        }
    }
}
