using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using xRP;
using xRPRepository;
using xRPDAL;

namespace xRP
{
    public class StaffViewModel
    {
        public Sys_CanBo CanBo { get; set; }
        public List<PositionViewModel> Postision { get; set; }
    }
}