using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using xRPDAL;

namespace xRPRepository
{
    public class Sys_ThongSoHeThongRepository : Repository<Sys_ThongSoHeThong>
    {
        public bool IsExistThongSo(string name)
        {
            return GetTable().Count(x => x.ThongSo == name) > 0;
        }

        public Sp_Get_All_Function_By_TenPhanHeResult GetByTenThongSo(string thongso)
        {
            return dataContext.Sp_Get_All_Function_By_TenPhanHe(thongso, 1, 1).FirstOrDefault();
        }

        public Sys_ThongSoHeThong GetThongSoHeThongBy(string thongso)
        {
            return dataContext.Sys_ThongSoHeThongs.FirstOrDefault(p => p.ThongSo == thongso);
        }

        public string GetThongSoHeThong(string thongso, string defaultvalue)
        {
            var thongsoResult=dataContext.Sys_ThongSoHeThongs.FirstOrDefault(x => x.ThongSo == thongso);
            if (thongsoResult != null)
            {
                return thongsoResult.GiaTri;
            }
            else
            {
                return defaultvalue;
            }
        }

        public string TenCongTy
        {
            get
            {
                return GetThongSoHeThongBy("TenCongTy").GiaTri;
            }

        }
        public string DiaChiCongTy
        {
            get
            {
                return GetThongSoHeThongBy("DiaChiCongTy").GiaTri;
            }

        }
        public string DienThoaiLienHe
        {
            get
            {
                return GetThongSoHeThongBy("DienThoaiLienHe").GiaTri;
            }

        }
        public string Fax
        {
            get
            {
                return GetThongSoHeThongBy("Fax").GiaTri;
            }

        }
        public string MaPhieuXuat
        {
            get
            {
                return GetThongSoHeThongBy("MaPhieuXuat").GiaTri;
            }

        }
        public string MaPhieuNhap
        {
            get
            {
                return GetThongSoHeThongBy("MaPhieuNhap").GiaTri;
            }

        }
        public string VersionInfo
        {
            get
            {
                return GetThongSoHeThongBy("VersionInfo").GiaTri;
            }

        }
        public string Madonhang
        {
            get
            {
                return GetThongSoHeThongBy("Madonhang").GiaTri;
            }

        }
        public string QuyTrinhQuanLyVatTu
        {
            get
            {
                return GetThongSoHeThongBy("QuyTrinhQuanLyVatTu").GiaTri;
            }

        }
        public string QuyTrinhQuanLySanXuat
        {
            get
            {
                return GetThongSoHeThongBy("QuyTrinhQuanLySanXuat").GiaTri;
            }

        }
    }
}
