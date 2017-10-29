using System;
using System.Collections.Generic;
using System.Web;
using xRP;
using xRPRepository;
using xRPDAL;
using System.Linq;
using System.Collections;


namespace xRP.App_Code.Service
{
    public class StaffService
    {
        Sys_CanBoRepository staffRepository = new Sys_CanBoRepository();
        Sys_DanhMucDonViRepository departmentRepository = new Sys_DanhMucDonViRepository();
        Sys_DanhMucChucVuRepository positionRepository = new Sys_DanhMucChucVuRepository();

        public List<StaffViewModel> GetStaffViewModel()
        {
            return null;
        }


        public bool UpdateStaff(int id, string Name, string Mobile)
        {
            try
            {
                Sys_CanBo staff = staffRepository.GetById(id);
                if (staff != null)
                {
                    staff.TenCanBo = Name;
                    staff.SoDienThoai = Mobile;
                    staffRepository.SubmitChanges();
                    return true;
                }
            }
            catch { }
            return false;
        }

        public Sys_CanBo GetStaff(string username)
        {
            return staffRepository.GetStaffByUserName(username);
        }

        public Sys_CanBo AddStaff(Sys_CanBo staff, List<Sys_CanBo_Department_ChucVu> maps)
        {
            //return staffRepository.Add(staff, maps);
            return null;
        }


        public List<PositionViewModel> GetPositionByStaff(string username)
        {
            Sys_CanBo staff = staffRepository.GetStaffByUserName(username);
            if (staff != null)
            {
                return GetPositionByStaff(staff.ID);
            }
            return new List<PositionViewModel>();
        }

        public List<PositionViewModel> GetPositionByStaff(int staffId)
        {
            List<PositionViewModel> vm = new List<PositionViewModel>();

            List<Sys_DanhMucDonVi> departments = departmentRepository.GetAll().ToList();
            List<Sys_DanhMucChucVu> positions = positionRepository.GetAll().ToList();

            //Sys_CanBo staff = staffRepository.GetById(staffId);
            Sys_DanhMucDonVi donvi = new Sys_DanhMucDonVi();
            Sys_DanhMucChucVu chucvu = new Sys_DanhMucChucVu();

            //List<Sys_CanBo_Department_ChucVu> maps = staffRepository.GetMappingByStaff(staffId);
            //foreach (Sys_CanBo_Department_ChucVu map in maps)
            //{
            //    PositionViewModel pvm = new PositionViewModel();
            //    donvi = departments.FirstOrDefault(x => x.ID == map.DepartmentID);
            //    chucvu = positions.FirstOrDefault(x => x.ID == map.ChucVuID);

            //    if (donvi != null && chucvu != null)
            //    {
            //        pvm.Department = donvi;
            //        pvm.Position = chucvu;
            //    }
            //    vm.Add(pvm);
            //}

            return vm;
        }


    }
}