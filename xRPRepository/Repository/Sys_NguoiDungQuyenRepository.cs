using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using xRPDAL;

namespace xRPRepository
{
    public class Sys_NguoiDungQuyenRepository : Repository<Sys_NguoiDungQuyen>
    {
        public Sys_NguoiDungQuyen Get(Guid userId, Guid permissionId)
        {
            return GetTable().Where(x => x.UserId == userId && x.RoleId == permissionId).FirstOrDefault();

        }
    }
}
