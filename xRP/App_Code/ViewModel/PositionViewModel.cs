using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using xRP;
using xRPRepository;
using xRPDAL;

namespace xRP
{
    public class PositionViewModel
    {
        public Sys_DanhMucChucVu Position { get; set; }
        public Sys_DanhMucDonVi Department { get; set; }
    }
}