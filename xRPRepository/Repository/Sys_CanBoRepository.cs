using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using xRPDAL;


namespace xRPRepository
{
    public class Sys_CanBoRepository : Repository<Sys_CanBo>
    {
        public bool IsEmailExist(string email)
        {
            return GetTable().Count(x => x.Email == email) > 0;
        }

        /// <summary>
        /// Thêm mới, xóa, sửa mapping
        /// </summary>
        /// <param name="staffId"></param>
        /// <param name="mappings"></param>
        public void UpdateDepartmentPosition(int staffId, List<Sys_CanBo_Department_ChucVu> mappings)
        {
            var currentMappings = GetMappingByStaff(staffId);
            List<Sys_CanBo_Department_ChucVu> addMappings = new List<Sys_CanBo_Department_ChucVu>();
            List<Sys_CanBo_Department_ChucVu> updateMappings = new List<Sys_CanBo_Department_ChucVu>();
            List<Sys_CanBo_Department_ChucVu> deleteMappings = new List<Sys_CanBo_Department_ChucVu>();

            ///Xác định chức vụ nào là thêm mới, hoặc update
            foreach (Sys_CanBo_Department_ChucVu map in mappings)
            {
                Sys_CanBo_Department_ChucVu m = currentMappings.FirstOrDefault(x => x.DepartmentID == map.DepartmentID);
                if (m == null)
                {
                    addMappings.Add(map);
                }
                else
                {
                    if (m.ChucVuID != map.ChucVuID)
                    {
                        m.ChucVuID = map.ChucVuID;
                        //updateMappings.Add(map);
                    }
                }
            }

            foreach (Sys_CanBo_Department_ChucVu map in currentMappings)
            {
                Sys_CanBo_Department_ChucVu m = mappings.FirstOrDefault(x => x.DepartmentID == map.DepartmentID);
                if (m == null)
                {
                    deleteMappings.Add(map);
                }
            }

            //foreach (Sys_CanBo_Department_ChucVu map in updateMappings)
            //{
            //    Sys_CanBo_Department_ChucVu m =currentMappings.fin dataContext.Sys_CanBo_Department_ChucVus.FirstOrDefault(x => x.ID == map.ID);
            //    m.ChucVuID = map.ChucVuID;
            //}

            deleteMappings.ForEach(x => dataContext.Sys_CanBo_Department_ChucVus.DeleteOnSubmit(x));
            addMappings.ForEach(x => dataContext.Sys_CanBo_Department_ChucVus.InsertOnSubmit(x));
            dataContext.SubmitChanges();
        }

        public Sys_CanBo Add(Sys_CanBo staff, List<Sys_CanBo_Department_ChucVu> maps)
        {
            this.dataContext.Sys_CanBos.InsertOnSubmit(staff);
            maps.ForEach(x => this.dataContext.Sys_CanBo_Department_ChucVus.InsertOnSubmit(x));
            this.dataContext.SubmitChanges();
            return staff;
        }

        public List<string> GetAvailableUserName()
        {
            List<string> data = new List<string>();
            var result = this.dataContext.Sp_Qlht_GetAvailableUserName();
            foreach (var item in result)
            {
                data.Add(item.UserName);
            }
            return data;
        }

        public Sys_CanBo GetStaffByUserName(string username)
        {
            return GetTable().FirstOrDefault(x => x.UserName == username);
        }

        public List<Sys_CanBo> GetStaffByDepartment(int departmentId)
        {
            List<Sys_CanBo> staff = new List<Sys_CanBo>();
            var result = dataContext.sp_Qlht_GetStaffByDepartment(departmentId);
            foreach (var data in result)
            {
                Sys_CanBo s = new Sys_CanBo();
                s.ID = data.ID;
                s.KichHoat = data.KichHoat;
                s.SoDienThoai = data.SoDienThoai;
                s.TenCanBo = data.TenCanBo;
                s.UserName = data.UserName;
                staff.Add(s);
            }
            return staff;
        }


        public List<Sys_CanBo_Department_ChucVu> GetMappingByStaff(int staffId)
        {
            return dataContext.Sys_CanBo_Department_ChucVus.Where(x => x.CanBoID == staffId).ToList();
        }
    }
}
