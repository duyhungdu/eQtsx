using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using xRP.Security;
using xRPDAL;
using xRPRepository;


namespace xRP.Security
{
    public static class xRPMembership
    {
        public static List<Role> GetAllRoles()
        {
            xRPDataContext dataContext = new xRPDataContext();
            var roles = dataContext.Sp_Qlht_GetAllRoles();

            List<Role> data = new List<Role>();
            foreach (Sp_Qlht_GetAllRolesResult s in roles)
            {
                data.Add(new Role { Name = s.RoleName, ID = s.RoleID, Code = s.Code, Description = s.Description });
            }
            return data;
        }

        public static List<Role> GetPermisisonForGroup(int groupID)
        {
            List<Role> roles = new List<Role>();
            List<Role> allRoles = GetAllRoles();

            Sys_QuyenTheoNhomRepository permissionRepository = new Sys_QuyenTheoNhomRepository();
            List<Sys_QuyenTheoNhom> permissions = permissionRepository.GetTable().Where(x => x.IDDanhMucNhom == groupID).ToList();
            List<Guid> guids = new List<Guid>();
            permissions.ForEach(x => guids.Add(x.RoleID));
            allRoles.FindAll(x => guids.Contains(x.ID)).ForEach(x => x.IsGrant = true);
            return allRoles;
        }

        public static bool UpdatePermissionToGroup(List<Guid> permissions, int groupId)
        {
            bool isSuccess = false;

            List<Guid> removalPermissions = new List<Guid>();
            List<Guid> additionPermissions = new List<Guid>();
            List<Guid> groupPermission = new List<Guid>();

            Sys_QuyenTheoNhomRepository permissionRepository = new Sys_QuyenTheoNhomRepository();
            List<Sys_QuyenTheoNhom> currentPermissions = permissionRepository.GetTable().Where(x => x.IDDanhMucNhom == groupId).ToList();
            currentPermissions.ForEach(x => groupPermission.Add(x.RoleID));

            removalPermissions = groupPermission.FindAll(x => !permissions.Contains(x));
            additionPermissions = permissions.FindAll(x => !groupPermission.Contains(x));

            try
            {
                foreach (Guid permission in additionPermissions)
                {
                    Sys_QuyenTheoNhom g = new Sys_QuyenTheoNhom();
                    g.IDDanhMucNhom = groupId;
                    g.MaNguoiTao = Guid.NewGuid();
                    g.MaNguoiThayDoi = Guid.NewGuid();
                    //g.ModifiedOn
                    g.NgayTao = DateTime.Now;
                    g.NgayThayDoi = DateTime.Now;
                    g.RoleID = permission;
                    permissionRepository.Add(g);
                }

                foreach (Guid permission in removalPermissions)
                {
                    Sys_QuyenTheoNhom g = permissionRepository.GetTable().FirstOrDefault(x => x.RoleID == permission && x.IDDanhMucNhom == groupId);
                    permissionRepository.Delete(g.ID);
                }

                permissionRepository.SubmitChanges();
                isSuccess = true;
            }
            catch { }
            return isSuccess;
        }

        public static List<Sys_DanhMucNhom> GetGroupsForUser(Guid userId)
        {
            List<Sys_DanhMucNhom> groups = new List<Sys_DanhMucNhom>();
            xRPDataContext dataContext = new xRPDataContext();
            var result = dataContext.Sp_Qlht_GetAllGroupsForUser(userId);
            foreach (Sp_Qlht_GetAllGroupsForUserResult g in result)
            {
                groups.Add(new Sys_DanhMucNhom { ID = g.ID.Value, TenNhom = g.TenNhom });
            }
            return groups;
        }

        public static bool UpdateGroupForUser(Guid userId, List<int> groupIds)
        {
            bool isSuccess = false;

            List<int> removalGroups = new List<int>();
            List<int> additionGroups = new List<int>();
            List<int> userGroups = new List<int>();


            Sys_NguoiDungNhom deleteNguoiDungNhom = new Sys_NguoiDungNhom();

            Sys_NguoiDungNhomRepository userGroupRepository = new Sys_NguoiDungNhomRepository();
            userGroupRepository.GetTable().Where(x => x.UserId == userId).ToList().ForEach(x => userGroups.Add(x.GroupID));


            removalGroups = userGroups.FindAll(x => !groupIds.Contains(x));
            additionGroups = groupIds.FindAll(x => !userGroups.Contains(x));

            foreach (int i in removalGroups)
            {
                deleteNguoiDungNhom = userGroupRepository.GetTable().FirstOrDefault(x => x.GroupID == i && x.UserId == userId);
                if (deleteNguoiDungNhom != null)
                {
                    userGroupRepository.Delete(deleteNguoiDungNhom.ID);
                }
            }

            foreach (int i in additionGroups)
            {
                Sys_NguoiDungNhom addNguoiDungNhom = new Sys_NguoiDungNhom();
                addNguoiDungNhom.GroupID = i;
                addNguoiDungNhom.UserId = userId;
                userGroupRepository.Add(addNguoiDungNhom);
            }
            userGroupRepository.SubmitChanges();
            isSuccess = true;

            return isSuccess;
        }

        public static bool AddPermissionToUser(Guid userId, string userName, List<string> grantPermissions, List<Guid> denyPermission)
        {
            bool isSuccess = false;
            try
            {
                Roles.AddUserToRoles(userName, grantPermissions.ToArray());
                Sys_NguoiDungQuyenRepository userPermissionRepository = new Sys_NguoiDungQuyenRepository();
                foreach (Guid guid in denyPermission)
                {
                    Sys_NguoiDungQuyen userPermission = new Sys_NguoiDungQuyen();
                    userPermission.RoleId = guid;
                    userPermission.UserId = userId;
                    userPermissionRepository.Add(userPermission);
                }
                userPermissionRepository.SubmitChanges();
                isSuccess = true;
            }
            catch
            {
            }

            return isSuccess;
        }

        public static List<Role> GetUserRolesFromGroup(Guid userid)
        {
            List<Role> roles = new List<Role>();
            xRPDataContext dataContext = new xRPDataContext();
            var result = dataContext.Sp_Qlht_GetUserRoleFromGroup(userid);
            foreach (Sp_Qlht_GetUserRoleFromGroupResult r in result)
            {
                roles.Add(new Role { ID = r.RoleId, Name = r.RoleName });
            }
            return roles;
        }

        public static List<Role> GetGrantRolesForUser(Guid userid)
        {
            List<Role> roles = new List<Role>();
            xRPDataContext dataContext = new xRPDataContext();
            var result = dataContext.Sp_Qlht_GetAllGrantRolesForUser(userid);
            foreach (Sp_Qlht_GetAllGrantRolesForUserResult r in result)
            {
                roles.Add(new Role { ID = r.RoleId, Name = r.RoleName, IsGrant = true });
            }
            return roles;
        }

        public static List<Role> GetDenyRolesForUser(Guid userid)
        {
            List<Role> roles = new List<Role>();
            xRPDataContext dataContext = new xRPDataContext();
            var result = dataContext.Sp_Qlht_GetAllDenyRolesForUser(userid);
            foreach (Sp_Qlht_GetAllDenyRolesForUserResult r in result)
            {
                roles.Add(new Role { ID = r.RoleId, Name = r.RoleName, IsGrant = false });
            }
            return roles;
        }

        public static bool AddDenyRoleForUser(Guid userid, List<Guid> roles)
        {
            bool isSucess = false;

            Sys_NguoiDungQuyenRepository repository = new Sys_NguoiDungQuyenRepository();
            foreach (Guid g in roles)
            {
                Sys_NguoiDungQuyen userRole = new Sys_NguoiDungQuyen();
                userRole.RoleId = g;
                userRole.UserId = userid;
                repository.Add(userRole);
            }
            repository.SubmitChanges();
            isSucess = true;

            return isSucess;
        }

        public static bool RemoveDenyRoleForUser(Guid userid, List<Guid> roles)
        {
            bool isSucess = false;

            Sys_NguoiDungQuyenRepository repository = new Sys_NguoiDungQuyenRepository();
            foreach (Guid g in roles)
            {
                Sys_NguoiDungQuyen userRole = repository.GetTable().Where(x => x.UserId == userid && x.RoleId == g).FirstOrDefault();
                if (userRole != null)
                {
                    repository.Delete(userRole.ID);
                }
            }
            repository.SubmitChanges();
            isSucess = true;
            return isSucess;
        }

        /// <summary>
        /// Phương thức lấy toàn bộ quyền được thao tác của người dùng
        /// </summary>
        /// <param name="username"></param>
        /// <returns></returns>
        public static List<Role> GetRoleForUser(string username)
        {
            List<Role> roles = new List<Role>();

            MembershipUser user = Membership.GetUser(username);
            if (user != null)
            {
                Guid userid = new Guid(user.ProviderUserKey.ToString());
                List<Role> roleFromGroups = GetUserRolesFromGroup(userid);
                List<Role> grantRoles = GetGrantRolesForUser(userid);
                List<Role> denyRoles = GetDenyRolesForUser(userid);
                List<Guid> excludeRoles = new List<Guid>();
                denyRoles.ForEach(x => excludeRoles.Add(x.ID));

                roles.AddRange(roleFromGroups);
                roles.AddRange(grantRoles);
                roles.RemoveAll(x => excludeRoles.Contains(x.ID));
            }

            return roles;
        }

        /// <summary>
        /// Phương thức kiểm tra xem người dùng có được phân quyền hay không?
        /// </summary>
        /// <param name="uesrname"></param>
        /// <param name="role"></param>
        /// <returns></returns>
        public static bool IsUserInRole(string username, string role)
        {
            bool isGrant = false;

            MembershipUser user = Membership.GetUser(username);
            Guid userid = new Guid(user.ProviderUserKey.ToString());
            if (user != null)
            {
                List<Role> roles = GetRoleForUser(username);
                Role hasRole = roles.FirstOrDefault(x => x.Name == xRP.Security.Permission.SYSTEM_ADMIN);
                if (hasRole != null)
                {
                    isGrant = true;
                }
                else
                {
                    hasRole = roles.FirstOrDefault(x => x.Name == role);
                    isGrant = hasRole != null;
                }
            }
            return isGrant;
        }

        /// <summary>
        /// Kiểm tra xem người dùng có quyền cao nhất hay không?
        /// </summary>
        /// <param name="username"></param>
        /// <param name="role"></param>
        /// <returns></returns>
        public static bool IsSystemAdmin(string username)
        {
            bool isSystemAdmin = false;

            MembershipUser user = Membership.GetUser(username);
            Guid userid = new Guid(user.ProviderUserKey.ToString());
            if (user != null)
            {
                List<Role> roles = GetRoleForUser(username);
                Role hasRole = roles.FirstOrDefault(x => x.Name == xRP.Security.Permission.SYSTEM_ADMIN);
                isSystemAdmin = hasRole != null;
            }
            return isSystemAdmin;
        }

        public static bool ChangeUserActive(string userName, bool isLock = false)
        {
            bool isSuccess = false;
            MembershipUser user = Membership.GetUser(userName);

            if (user != null)
            {
                xRPDataContext dataContext = new xRPDataContext();
                aspnet_Membership membershipItem = dataContext.aspnet_Memberships.FirstOrDefault(x => x.UserId == Guid.Parse(user.ProviderUserKey.ToString()));
                if (membershipItem != null)
                {
                    membershipItem.IsLockedOut = isLock;
                }
                dataContext.SubmitChanges();
                isSuccess = true;
            }
            return isSuccess;
        }

        public static CreateRoleStatus CreateRole(string name, string code, string note)
        {
            CreateRoleStatus status = new CreateRoleStatus();

            bool isExistName = false;
            bool isExistCode = false;

            xRPDataContext dataContext = new xRPDataContext();
            isExistName = dataContext.aspnet_Roles.FirstOrDefault(x => x.LoweredRoleName == name.ToLower()) != null;
            isExistCode = dataContext.aspnet_Roles.FirstOrDefault(x => x.Code.ToLower() == code.ToLower()) != null;

            status.IsDuplicateCode = isExistCode;
            status.IsDuplicateName = isExistName;

            try
            {
                if (!isExistCode && !isExistName)
                {
                    Roles.CreateRole(name);
                    aspnet_Role role = dataContext.aspnet_Roles.FirstOrDefault(x => x.LoweredRoleName == name.ToLower());
                    role.Code = code;
                    role.Description = note;
                    //dataContext.aspnet_Roles.InsertOnSubmit(role);
                    dataContext.SubmitChanges();
                    status.IsSuccess = true;
                }
            }
            catch (Exception ex) { }

            return status;
        }

        public static UpdateRoleStatus UpdateRole(string name, Role role)
        {
            UpdateRoleStatus status = new UpdateRoleStatus();
            xRPDataContext dataContext = new xRPDataContext();

            bool isExistName = false;
            bool isExistCode = false;

            Role oldRole = GetRoleByName(name);

            if (oldRole.Code != role.Code)
            {
                isExistCode = dataContext.aspnet_Roles.FirstOrDefault(x => x.Code.ToLower() == role.Code.ToLower()) != null;
            }

            if (oldRole.Name != role.Name)
            {
                isExistName = dataContext.aspnet_Roles.FirstOrDefault(x => x.LoweredRoleName == role.Name.ToLower()) != null;
            }
            status.IsDuplicateCode = isExistCode;
            status.IsDuplicateName = isExistName;

            try
            {
                if (!isExistCode && !isExistName)
                {
                    aspnet_Role dbRole = dataContext.aspnet_Roles.FirstOrDefault(x => x.LoweredRoleName == name.ToLower());
                    dbRole.Code = role.Code;
                    dbRole.RoleName = role.Name;
                    dbRole.LoweredRoleName = role.Name.ToLower();
                    dbRole.Description = role.Description;
                    dataContext.SubmitChanges();
                    status.IsSuccess = true;
                }
            }
            catch { }

            return status;
        }

        public static Role GetRoleByName(string name)
        {
            xRPDataContext dataContext = new xRPDataContext();
            Role role = null;
            aspnet_Role membershipRole = dataContext.aspnet_Roles.FirstOrDefault(x => x.LoweredRoleName == name.ToLower());
            if (membershipRole != null)
            {
                role = new Role();
                role.Code = membershipRole.Code;
                role.Description = membershipRole.Description;
                role.Name = membershipRole.RoleName;
                role.ID = membershipRole.RoleId;
            }
            return role;
        }

        public static List<vw_aspnet_User> GetAllUser(string keyWord = null)
        {
            xRPDataContext dataContext = new xRPDataContext();
            if (string.IsNullOrEmpty(keyWord))
            {
                return dataContext.vw_aspnet_Users.ToList();
            }
            else
            {
                return dataContext.vw_aspnet_Users.Where(x => x.UserName.Contains(keyWord) || x.Email.Contains(keyWord)).ToList();
            }
        }
    }
}