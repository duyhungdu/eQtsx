using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using xRPDAL;

namespace xRPRepository
{
    public class Sys_DanhMucDonViRepository : Repository<Sys_DanhMucDonVi>
    {
        public bool IsExistDepartmentCode(string code)
        {
            return GetTable().Count(x => x.MaHieuDonVi == code) > 0;
        }


        public List<Sys_DanhMucDonVi> GetDepartmentStructure()
        {
            List<Sys_DanhMucDonVi> departments = new List<Sys_DanhMucDonVi>();
            List<Sys_DanhMucDonVi> tops = new List<Sys_DanhMucDonVi>();
            List<Sys_DanhMucDonVi> orphans = new List<Sys_DanhMucDonVi>();
            List<int> ids = new List<int>();

            departments = this.GetTable().ToList();
            departments.ForEach(x => ids.Add(x.ID));

            tops = departments.Where(x => x.MaDonViCapTren == 0).OrderBy(x => x.TenDonVi).ToList();
            tops.ForEach(x => GetDepartmentRelationShip(x, departments));

            orphans = departments.FindAll(x => !ids.Contains(x.MaDonViCapTren));
            orphans.ForEach(x => GetDepartmentRelationShip(x, departments));

            return tops;
        }

        private void GetDepartmentRelationShip(Sys_DanhMucDonVi department, List<Sys_DanhMucDonVi> departments)
        {
            department.Childs = new List<Sys_DanhMucDonVi>();
            departments.FindAll(x => x.MaDonViCapTren == department.ID).ForEach(x => department.Childs.Add(x));
            department.Childs.ForEach(x => GetDepartmentRelationShip(x, departments));
        }
    }
}
