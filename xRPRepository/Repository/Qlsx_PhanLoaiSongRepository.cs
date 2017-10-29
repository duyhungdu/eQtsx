using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using xRPDAL;

namespace xRPRepository
{
    public class Qlsx_PhanLoaiSongRepository : DRepository
    {
        public List<Sp_Qlsx_PhanLoaiSong_SelectResult> GetAllPhanLoaiSong(int? type, int? id, int? solop, int? xoa, bool? kichhoat)
        {
            return (from ds in dataContext.Sp_Qlsx_PhanLoaiSong_Select(type, id, solop, xoa, kichhoat,"") orderby ds.NgayTao descending select ds).ToList();
        }
        /// <summary>
        /// Lấy công đoạn theo Id
        /// </summary>
        /// <param name="id">Mã id truyền vào</param>
        /// <author>phamkhuong102</author>
        /// <datecreate>2015-01-12</datecreate>
        /// <returns></returns>
        public Sp_Qlsx_PhanLoaiSong_SelectResult GetPhanLoaiSongById(int? id)
        {
            return dataContext.Sp_Qlsx_PhanLoaiSong_Select(1, id, null, null, null, "").SingleOrDefault();
        }
    }

}
