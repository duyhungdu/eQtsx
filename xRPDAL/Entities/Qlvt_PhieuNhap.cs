using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace xRPDAL
{
    public partial class Qlvt_PhieuNhap 
    {
        public enum TinhTrangs { CHUAKIEMTRA = 0, DAKIEMTRA = 1, DUYET = 2 }
        //--0:Lấy tất; 1: Lấy theo mã ID; 2:Lấy theo Mã Nhà cung cấp; 3: Lấy theo Mã kho vật tư; 4: Lấy theo Ngày lập phiếu; 5:Lấy theo Mã tính chất Nhập/Xuất
        /// <summary>
        /// Các kiểu select dữ liệu
        /// </summary>
        public enum SelectTypes { All = 0, ByID = 1, ByNhaCungCapID = 2, ByKhoVatTuID = 3, ByCreatedDate = 4, ByTinhChatNhapXuatID = 5 }
    }
}
