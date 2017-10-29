using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using xRPDAL;

namespace xRPRepository
{
    public class DRepository
    {
        public xRPDataContext dataContext;
        public DRepository()
        {
            dataContext = new xRPDataContext();
        }

    }
}
