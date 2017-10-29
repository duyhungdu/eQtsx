using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace xRP
{
    class EnumPhieuXuat
    {
        /// <summary>
        /// Trạng Thái
        /// </summary>
        public enum TrangThai { };
        /// <summary>
        /// Select Type
        /// </summary>
        public enum SelectType { All = 0, Search = -1, SelectByCode = 1 }


        public enum KieuVatTu { All = 0, VatTuXuat = 1, XuatThanhPham = 2 }
    }
}
