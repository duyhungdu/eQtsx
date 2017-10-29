using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using xRPDAL;
using xRPRepository;

namespace xRPRepository
{
    public partial class Qlsx_CongDoanRepository : DRepository
    {
        public List<Sp_Qlsx_CongDoan_SelectResult> GetAllCongDoan(int? type, int? id, int? xoa, int? kichhoat)
        {
            return (from ds in dataContext.Sp_Qlsx_CongDoan_Select(type, id, xoa, kichhoat,"") select ds).ToList();
        }
        /// <summary>
        /// Lấy công đoạn theo Id
        /// </summary>
        /// <param name="id">Mã id truyền vào</param>
        /// <author>phamkhuong102</author>
        /// <datecreate>2015-01-12</datecreate>
        /// <returns></returns>
        public Sp_Qlsx_CongDoan_SelectResult GetCongDoanById(int? id)
        {
            return dataContext.Sp_Qlsx_CongDoan_Select(1, id, null, null, "").SingleOrDefault();
        }
    }
}
