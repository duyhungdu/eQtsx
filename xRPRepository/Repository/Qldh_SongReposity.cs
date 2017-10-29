using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using xRPDAL;

namespace xRPRepository
{
    public class Qldh_SongReposity:DRepository
    {
        public List<Sp_Qldh_DanhMucSong_SelectResult> GetDanhMucSong(int? type, int? id, int? xoa, int? kichHoat,string keyword)
        {
            List<Sp_Qldh_DanhMucSong_SelectResult> listDanhMucSong = dataContext.Sp_Qldh_DanhMucSong_Select(type, id, xoa, kichHoat,keyword).ToList();
            return listDanhMucSong;
        }
    }
}
