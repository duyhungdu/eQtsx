using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace xRPDAL
{
    /// <summary>
    /// Bảng trung gian giữa quyền và nhóm. Quyền và nhóm quan hệ nhiều-nhiều.
    /// Bảng nhóm quyền (group của quyền) có tên: Sys_QuyenNhom
    /// </summary>
    public partial class Sys_NhomQuyen : IDbTable
    {
        public DateTime ModifiedOn { get; set; }
    }
}
