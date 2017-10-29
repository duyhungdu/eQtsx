using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using xRPDAL;

namespace xRPRepository
{
    public class Sys_DanhMucNhomRepository : Repository<Sys_DanhMucNhom>
    {
        public bool IsExistName(string name)
        {
            return GetTable().Count(x => x.TenNhom == name) > 0;
        }
    }
}
