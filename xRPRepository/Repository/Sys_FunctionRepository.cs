using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using xRPDAL;

namespace xRPRepository
{
    public class Sys_FunctionRepository : Repository<Sys_Function>
    {
        /// <summary>
        /// Lấy ra danh mục chức năng theo phân hệ và vị trí xuất hiện
        /// parentID=0 thì lấy cấp cha nhất
        /// parentID # 0 thì lấy theo parentID
        /// </summary>
        /// <param name="tenphanhe"></param>
        /// <param name="parentID"></param>
        /// <param name="position"></param>
        /// <returns></returns>
        public List<Sys_Function> GetFunctionByTenPhanHe(string tenphanhe, int parentID, int position)
        {
            return (from ds in dataContext.Sp_Get_All_Function_By_TenPhanHe(tenphanhe, parentID, position)
                    select new Sys_Function
                    {
                        ID = ds.ID,
                        TenChucNang = ds.TenChucNang,
                        Ma = ds.Ma,
                        ThuTu = ds.ThuTu,
                        Href = ds.Href,
                        Icon = ds.Icon,
                        ParentID = ds.ParentID,
                        NodeID=ds.NodeID
                    }).ToList();
        }
        public List<Sys_Function> GetFunctionBy(Guid? roleId, string tenphanhe, int parentID, int position)
        {
            //Lấy giá trị đã tồn tại
            var lsData = new List<Sys_Function>();
            var dataExist = (from ds in dataContext.Sp_Get_All_Function_By_TenPhanHe(tenphanhe, parentID, position)
                             join p in dataContext.Sys_QuyenTheoChucNangs on ds.ID equals p.FunctionID
                             where p.Xoa == false && p.RoleID == roleId
                             select new Sys_Function
                             {
                                 ID = ds.ID,
                                 TenChucNang = ds.TenChucNang,
                                 Ma = ds.Ma,
                                 ThuTu = ds.ThuTu,
                                 Href = ds.Href,
                                 Icon = ds.Icon,
                                 ParentID = ds.ParentID,
                                 Selected = true,
                                 RoleFunctionId = p.ID
                             }).ToList();

            //Danh sách sẽ thêm vào
            var dataAdd = (from c in dataContext.Sp_Get_All_Function_By_TenPhanHe(tenphanhe, parentID, position)
                           where !dataContext.Sys_QuyenTheoChucNangs.Any(d => d.FunctionID == c.ID && d.Xoa == false && d.RoleID == roleId)
                           select new Sys_Function
                           {
                               ID = c.ID,
                               TenChucNang = c.TenChucNang,
                               Ma = c.Ma,
                               ThuTu = c.ThuTu,
                               Href = c.Href,
                               Icon = c.Icon,
                               ParentID = c.ParentID,
                               Selected = false,
                               RoleFunctionId = 0
                           }).ToList();

            lsData.AddRange(dataExist);
            lsData.AddRange(dataAdd);
            lsData = lsData.OrderBy(p => p.ID).Distinct().ToList();

            return lsData;
        }
        public List<Sys_Function> GetFunctionBy2(Guid? roleId, string tenphanhe, int parentID)
        {
            //Lấy giá trị đã tồn tại
            var lsData = new List<Sys_Function>();
            var dataExist = (from ds in dataContext.Sp_Get_All_Function_By_TenPhanHe_2(tenphanhe, parentID)
                             join p in dataContext.Sys_QuyenTheoChucNangs on ds.ID equals p.FunctionID
                             where p.Xoa == false && p.RoleID == roleId
                             select new Sys_Function
                             {
                                 ID = ds.ID,
                                 TenChucNang = ds.TenChucNang,
                                 Ma = ds.Ma,
                                 ThuTu = ds.ThuTu,
                                 Href = ds.Href,
                                 Icon = ds.Icon,
                                 ParentID = ds.ParentID,
                                 Selected = true,
                                 RoleFunctionId = p.ID
                             }).ToList();

            //Danh sách sẽ thêm vào
            var dataAdd = (from c in dataContext.Sp_Get_All_Function_By_TenPhanHe_2(tenphanhe, parentID)
                           where !dataContext.Sys_QuyenTheoChucNangs.Any(d => d.FunctionID == c.ID && d.Xoa == false && d.RoleID == roleId)
                           select new Sys_Function
                           {
                               ID = c.ID,
                               TenChucNang = c.TenChucNang,
                               Ma = c.Ma,
                               ThuTu = c.ThuTu,
                               Href = c.Href,
                               Icon = c.Icon,
                               ParentID = c.ParentID,
                               Selected = false,
                               RoleFunctionId = 0
                           }).ToList();

            lsData.AddRange(dataExist);
            lsData.AddRange(dataAdd);
            lsData = lsData.OrderBy(p => p.ID).Distinct().ToList();

            return lsData;
        }
        public bool AddOrUpdateFunctionRole(Guid roleId, List<Sys_QuyenTheoChucNang> lsDataPhanQuyenChucNang, Guid userId, ref  string strResponse)
        {

            try
            {
                // dataContext.Sys_QuyenTheoChucNangs.Where(p => p.RoleID == roleId && !lsDataPhanQuyenChucNang.Any(d => d.ID == p.ID)).ToList().ForEach(x => x.Xoa = true);
                (from c in dataContext.Sys_QuyenTheoChucNangs.Where(p => p.RoleID == roleId).ToList()
                 where !lsDataPhanQuyenChucNang.Any(d => d.ID == c.ID)
                 select c).ToList().ForEach(x => x.Xoa = true);


                foreach (var item in lsDataPhanQuyenChucNang)
                {
                    if (item.ID > 0)
                    { //Sửa thông tin
                        var data = dataContext.Sys_QuyenTheoChucNangs.FirstOrDefault(p => p.ID == item.ID);
                        data.RoleID = item.RoleID;
                        data.FunctionID = item.FunctionID;
                        item.NgayThayDoi = DateTime.Now;
                        item.MaNguoiThayDoi = userId;
                        item.Xoa = false;
                    }
                    else
                    { //Thêm mới

                        item.NgayTao = DateTime.Now;
                        item.MaNguoiTao = userId;
                        item.Xoa = false;
                        dataContext.Sys_QuyenTheoChucNangs.InsertOnSubmit(item);
                    }

                }
                dataContext.SubmitChanges();
                strResponse = "Success";
                return true;
            }
            catch (Exception ex)
            {
                strResponse = (ex.Message + ex.StackTrace);
                return false;
            }

        }
    }
}
