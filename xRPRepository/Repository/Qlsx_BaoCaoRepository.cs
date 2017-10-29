using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using xRPDAL;
using xRPRepository;

namespace xRPRepository
{
    public partial class Qlsx_BaoCaoRepository : DRepository
    {

        public List<Sp_Qlsx_BaoCaoSanXuatTongHop_SelectResult> Qlsx_BaoCaoSanXuatTongHop(int? donHangId, int? matHangId, int? tinhTrangDonHang, DateTime? tuNgay, DateTime? denNgay)
        {
            return (from ds in dataContext.Sp_Qlsx_BaoCaoSanXuatTongHop_Select(donHangId, matHangId, tinhTrangDonHang, tuNgay, denNgay) select ds).ToList();
        }
    }
}
