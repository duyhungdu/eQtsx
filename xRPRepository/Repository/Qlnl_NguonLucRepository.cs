using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using xRPDAL;

namespace xRPRepository
{
    public partial class Qlnl_NguonLucRepository : DRepository
    {
        public List<Sp_Qlnl_NguonLuc_SelectResult> GetAllNguonLuc(int? type, int? id, int? xoa, int? kichhoat, int? tinhtrang, string keyword)
        {
            return (from ds in dataContext.Sp_Qlnl_NguonLuc_Select(type, id, xoa, kichhoat, tinhtrang, keyword) select ds).ToList();
        }
        /// <summary>
        /// Lấy công đoạn theo Id
        /// </summary>
        /// <param name="id">Mã id truyền vào</param>
        /// <author>phamkhuong102</author>
        /// <datecreate>2015-01-12</datecreate>
        /// <returns></returns>
        public Sp_Qlnl_NguonLuc_SelectResult GetNguonLucById(int? id)
        {
            return dataContext.Sp_Qlnl_NguonLuc_Select(1, id, null, null, null, "").SingleOrDefault();
        }
    }
}
