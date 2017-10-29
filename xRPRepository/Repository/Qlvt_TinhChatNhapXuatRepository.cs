using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using xRPDAL;

namespace xRPRepository
{
    public partial class Qlvt_TinhChatNhapXuatRepository : DRepository
    {
        public List<Sp_Qlvt_TinhChatNhapXuat_SelectResult> GetAllTinhChatNhapXuat(int? type, int? id, int? xoa, int? kichhoat)
        {
            return (from ds in dataContext.Sp_Qlvt_TinhChatNhapXuat_Select(type, id, xoa, kichhoat) select ds).ToList();
        }
    }
}
