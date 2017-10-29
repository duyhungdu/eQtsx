using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using xRPDAL;

namespace xRPRepository
{
    public class Sys_DanhMucChucVuRepository : Repository<Sys_DanhMucChucVu>
    {
        public bool IsExistName(string name)
        {
            return GetTable().Count(x => x.TenChucVu == name) > 0;
        }
    }
}
