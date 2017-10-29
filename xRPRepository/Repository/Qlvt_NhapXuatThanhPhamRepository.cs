using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using xRPDAL;

namespace xRPRepository
{
    public partial class Qlvt_NhapXuatThanhPhamRepository : DRepository
    {
        #region Nhập thành phẩm
        public List<Sp_Qlvt_ThanhPhamNhap_SelectResult> GetDanhSachThanhPhamNhap(int? type, int? id, int? phieunhapId, int? tinhtrang)
        {
            return (from ds in dataContext.Sp_Qlvt_ThanhPhamNhap_Select(type, id, phieunhapId, tinhtrang) select ds).ToList();
        }

        public Sp_Qlvt_ThanhPhamNhap_SelectResult GetThanhPhamNhapById(int? id)
        {
            return dataContext.Sp_Qlvt_ThanhPhamNhap_Select(1, id, null, null).FirstOrDefault();
        }
        #endregion

        #region Xuất thành phẩm

        public List<Sp_Qlvt_ThanhPhamXuat_SelectResult> GetDanhSachThanhPhamXuat(int? type, int? id, int? phieuxuatId, int? tinhtrang)
        {
            return (from ds in dataContext.Sp_Qlvt_ThanhPhamXuat_Select(type, id, phieuxuatId, tinhtrang,"") select ds).ToList();
        }

        public Sp_Qlvt_ThanhPhamXuat_SelectResult GetThanhPhamXuatById(int? id)
        {
            return dataContext.Sp_Qlvt_ThanhPhamXuat_Select(1, id, null, null,"").FirstOrDefault();
        }
        #endregion
    }
}
