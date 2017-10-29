using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using xRPDAL;
using xRPRepository;


namespace xRPRepository
{

    public partial class Qlsx_CoCauGiayTheoSongRepository : DRepository
    {

        public List<Sp_Qlsx_CoCauGiayTheoSong_SelectResult> GetCoCauGiayTheoLoaiSong(int idLoaiSong)
        {
            if (idLoaiSong == 0)
            {
                return dataContext.Sp_Qlsx_CoCauGiayTheoSong_Select(0, null, null, null, null, null,0, "").ToList();
            }
            else
            {
                return dataContext.Sp_Qlsx_CoCauGiayTheoSong_Select(5, null, null, null, null, idLoaiSong, null, "").ToList();
            }
        }


        public List<Sp_Qlsx_CoCauGiayTheoSong_SelectResult> GetDanhSachCoCauGiay(int? type, int? id, int? coCauGiayId, int? lopGiayId, int? vatTuGiayId, int? xoa, string fulltext)
        {
            return (from ds in dataContext.Sp_Qlsx_CoCauGiayTheoSong_Select(type, id, coCauGiayId, lopGiayId, vatTuGiayId, xoa, null, fulltext) select ds).ToList();
        }
        /// <summary>
        /// Lấy công đoạn theo Id
        /// </summary>
        /// <param name="id">Mã id truyền vào</param>
        /// <author>phamkhuong102</author>
        /// <datecreate>2015-01-12</datecreate>
        /// <returns></returns>
        public Sp_Qlsx_CoCauGiayTheoSong_SelectResult GetCoCauGiayById(int? id)
        {
            return dataContext.Sp_Qlsx_CoCauGiayTheoSong_Select(1, id, null, null, null, null, null, null).SingleOrDefault();
        }
    }
}
