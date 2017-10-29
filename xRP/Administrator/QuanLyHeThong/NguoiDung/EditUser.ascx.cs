using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;
using xRPRepository;
using System.Web.Security;
using xRP.Security;
using xRPUtil;

namespace xRP.Administrator.QuanLyHeThong.NguoiDung
{
    public partial class EditUser : System.Web.UI.UserControl
    {
        public string message = string.Empty;
        public bool IsSystemAdmin = false;
        public MembershipUser user = null;
        Sys_DanhMucNhomRepository groupRepository = new Sys_DanhMucNhomRepository();
        string username = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {

            username = Request.QueryString["id"] ?? string.Empty;
            user = Membership.GetUser(username);

            txtTenDangNhap.Text = username;
            txtPassword.Text = string.Empty;
            txtRePassword.Text = string.Empty;
            txtEmail.Text = user.Email;
            chkIsLocked.Checked = !user.IsLockedOut;

            lblMessage.Visible = false;

            ///show message after add group successfully
            string success = Request.QueryString["success"] ?? "0";
            if (Request.UrlReferrer != null)
            {
                if (success == "1" && Request.UrlReferrer.ToString().ToLower().Contains("default.aspx?page=adduser"))
                {
                    lblMessage.Text = "Cập nhật thành công";
                    lblMessage.CssClass = "success";
                    lblMessage.Visible = true;
                }
            }
        }


        protected void Page_PreRender(object sender, EventArgs e)
        {
            ShowDetail();
        }

        private void ShowDetail()
        {
            ///Show Groups
            Sys_NguoiDungNhomRepository userGroupRepository = new Sys_NguoiDungNhomRepository();
            List<Sys_NguoiDungNhom> userGroups = userGroupRepository.GetTable().Where(x => x.UserId == new Guid(user.ProviderUserKey.ToString())).ToList();
            List<int> userGroupsIds = new List<int>();
            userGroups.ForEach(x => userGroupsIds.Add(x.GroupID));

            Sys_DanhMucNhomRepository groupRepository = new Sys_DanhMucNhomRepository();
            List<Sys_DanhMucNhom> groups = groupRepository.GetAll().ToList();

            List<UserGroupViewModel> vms = new List<UserGroupViewModel>();

            groups.FindAll(x => !userGroupsIds.Contains(x.ID)).ForEach(x => vms.Add(new UserGroupViewModel { Group = x, IsChecked = false }));
            groups.FindAll(x => userGroupsIds.Contains(x.ID)).ForEach(x => vms.Add(new UserGroupViewModel { Group = x, IsChecked = true }));


            rptGroups.DataSource = vms.OrderBy(x => x.Group.TenNhom).ToList();
            rptGroups.DataBind();

            ///Show Permissions

            List<UserPermissionViewModel> permissions = new List<UserPermissionViewModel>();

            List<Role> allRole = xRPMembership.GetAllRoles();
            List<Role> rolesFromGroup = xRPMembership.GetUserRolesFromGroup(new Guid(user.ProviderUserKey.ToString()));
            List<Role> grantRoles = xRPMembership.GetGrantRolesForUser(new Guid(user.ProviderUserKey.ToString()));
            List<Role> denyRoles = xRPMembership.GetDenyRolesForUser(new Guid(user.ProviderUserKey.ToString()));

            List<Guid> guids = new List<Guid>();
            List<Guid> groupRoleGuids = new List<Guid>();

            rolesFromGroup.ForEach(x => groupRoleGuids.Add(x.ID));
            rolesFromGroup.ForEach(x => guids.Add(x.ID));

            grantRoles.ForEach(x => guids.Add(x.ID));
            denyRoles.ForEach(x => guids.Add(x.ID));

            allRole.RemoveAll(x => guids.Contains(x.ID));

            guids = new List<Guid>();
            denyRoles.ForEach(x => guids.Add(x.ID));
            grantRoles.ForEach(x => guids.Add(x.ID));

            rolesFromGroup.RemoveAll(x => guids.Contains(x.ID));
            rolesFromGroup.ForEach(x => permissions.Add(new UserPermissionViewModel { IsInherit = true, Role = x }));

            grantRoles.FindAll(x => groupRoleGuids.Contains(x.ID)).ForEach(x => permissions.Add(new UserPermissionViewModel { IsOverride = true, Role = x, IsGrant = true, IsAssigned = true }));
            grantRoles.FindAll(x => !groupRoleGuids.Contains(x.ID)).ForEach(x => permissions.Add(new UserPermissionViewModel { Role = x, IsGrant = true, IsAssigned = true }));

            denyRoles.FindAll(x => groupRoleGuids.Contains(x.ID)).ForEach(x => permissions.Add(new UserPermissionViewModel { IsOverride = true, Role = x, IsDeny = true, IsAssigned = true }));
            denyRoles.FindAll(x => !groupRoleGuids.Contains(x.ID)).ForEach(x => permissions.Add(new UserPermissionViewModel { Role = x, IsDeny = true, IsAssigned = true }));

            allRole.ForEach(x => permissions.Add(new UserPermissionViewModel { Role = x, IsOrphan = true }));

            rptPermissions.DataSource = permissions.OrderBy(x => x.Role.Name).ToList();
            rptPermissions.DataBind();

        }


        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                bool isAddUserToGroup = false;
                lblEmailSuccess.Visible = false;
                lblPasswordSucess.Visible = false;

                string email = txtEmail.Text;
                string password = txtPassword.Text;
                string repassword = txtRePassword.Text;
                string username = txtTenDangNhap.Text;

                #region Update account


                if ((string.IsNullOrEmpty(user.Email) && !string.IsNullOrEmpty(email)) || (!string.IsNullOrEmpty(user.Email) && user.Email != email))
                {
                    //Page.Response.Write("user emai:" + user.Email + "email: " + email + (user.Email.Trim() != email.Trim()).ToString());

                    if (!string.IsNullOrEmpty(Membership.GetUserNameByEmail(email)))
                    {
                        lblEmailError.Text = "Email đã tồn tại trong hệ thống, vui lòng nhập email khác.";
                        message = message + "Email đã tồn tại trong hệ thống, vui lòng nhập email khác. \\n";
                        //lblEmailError.Visible = true;
                    }
                    else
                    {
                        user.Email = email;
                        Membership.UpdateUser(user);
                        lblEmailSuccess.Text = "Thay đổi email thành công.";
                        //message = message + "Thay đổi email thành công. \\n";
                        lblEmailSuccess.Visible = true;
                    }
                }
                if (!string.IsNullOrEmpty(password))
                {
                    //Check password is valid
                    bool isValidPassword = false;
                    string userName = "NoMEwYnPAJ";
                    try
                    {
                        Membership.CreateUser(userName, password);
                        isValidPassword = true;
                        Membership.DeleteUser(userName, true);
                    }
                    catch (MembershipCreateUserException ex)
                    {
                    }

                    bool changePassIsSuccess = false;

                    if (isValidPassword)
                        try
                        {
                            string newPass = user.ResetPassword();
                            user.ChangePassword(newPass, password);
                            changePassIsSuccess = true;
                        }
                        catch { }
                    if (changePassIsSuccess)
                    {
                        lblPasswordSucess.Text = "Thay đổi mật khẩu thành công.";
                        lblPasswordSucess.Visible = true;
                        //message = message + "Thay đổi mật khẩu thành công.\\n";

                    }
                    else
                    {
                        lblPasswordError.Text = "Mật khẩu mới không hợp lệ, vui lòng chọn mật khẩu khác.";
                        //lblPasswordError.Visible = true;
                        message = message + "Mật khẩu mới không hợp lệ, vui lòng chọn mật khẩu khác.\\n";

                    }
                }

                if (chkIsLocked.Checked != (!user.IsLockedOut))
                {
                    xRPMembership.ChangeUserActive(user.UserName, !chkIsLocked.Checked);
                }

                #endregion

                #region Update Permission

                List<Role> rolesFromGroup = xRPMembership.GetUserRolesFromGroup(new Guid(user.ProviderUserKey.ToString()));
                List<Role> grantRoles = xRPMembership.GetGrantRolesForUser(new Guid(user.ProviderUserKey.ToString()));
                List<Role> denyRoles = xRPMembership.GetDenyRolesForUser(new Guid(user.ProviderUserKey.ToString()));

                ///Chứa list các quyền bị từ chối
                List<Guid> addDenyRoles = new List<Guid>();
                ///Chứa list các quyền được phân vào.
                //List<Guid> addGrantRoles = new List<Guid>();
                ///Chứa list các quyền deny sẽ bị xóa
                List<Guid> removeDenyRoles = new List<Guid>();
                ///Chứa list các role bị xóa
                List<string> removeGrantRoles = new List<string>();
                List<string> addGrantRoles = new List<string>();

                bool isGrant = false;
                bool isDeny = false;
                bool isOrphan = false;
                bool isAssigned = false;
                bool isOverride = false;
                bool isInherit = false;


                Guid guid = new Guid();
                string roleName = string.Empty;

                foreach (RepeaterItem item in rptPermissions.Items)
                {

                    Label lblTip = (Label)item.FindControl("lblTip");

                    DropDownList ddlUnAssignedOperator = (DropDownList)item.FindControl("ddlUnAssignedOperator");
                    DropDownList ddlAssignedOperator = (DropDownList)item.FindControl("ddlAssignedOperator");
                    DropDownList ddlGroupOperator = (DropDownList)item.FindControl("ddlGroupOperator");
                    string operation = string.Empty;

                    HiddenField hdfID = (HiddenField)item.FindControl("hdfID");
                    HiddenField hdfName = (HiddenField)item.FindControl("hdfName");

                    HiddenField hdfIsGrant = (HiddenField)item.FindControl("hdfIsGrant");
                    HiddenField hdfIsDeny = (HiddenField)item.FindControl("hdfIsDeny");
                    HiddenField hdfIsOrphan = (HiddenField)item.FindControl("hdfIsOrphan");
                    HiddenField hdfIsAssigned = (HiddenField)item.FindControl("hdfIsAssigned");
                    HiddenField hdfIsOverride = (HiddenField)item.FindControl("hdfIsOverride");
                    HiddenField hdfIsInherit = (HiddenField)item.FindControl("hdfIsInherit");

                    isGrant = bool.Parse(hdfIsGrant.Value);
                    isDeny = bool.Parse(hdfIsDeny.Value);
                    isOrphan = bool.Parse(hdfIsOrphan.Value);
                    isAssigned = bool.Parse(hdfIsAssigned.Value);
                    isOverride = bool.Parse(hdfIsOverride.Value);
                    isInherit = bool.Parse(hdfIsInherit.Value);

                    guid = new Guid(hdfID.Value);
                    roleName = hdfName.Value;

                    //Kiểm tra quyền người dùng kế thừa từ nhóm, check trạng thái quyền hiện tại với thao tác người dùng chọn trong Dropdownlist
                    //Kiểm tra quyền là quyền thừa kế từ nhóm và người dùng thiết lập "Từ chối"
                    if (isInherit && !isOverride)
                    {
                        operation = ddlGroupOperator.SelectedValue;
                        if (operation == "deny")
                            addDenyRoles.Add(guid);
                    }

                    //Check các quyền chưa được phân, có 2 trường hợp: cho phép sẽ add trực tiếp vào Role và Deny add vào bảng riêng
                    if (isOrphan)
                    {
                        operation = ddlUnAssignedOperator.SelectedValue;

                        switch (operation)
                        {
                            case "deny": { addDenyRoles.Add(guid); break; }
                            case "grant": { addGrantRoles.Add(roleName); break; }
                        }
                    }
                    ///Check các quyền được gán trực tiếp cho người dùng, xét trạng thái
                    if (isAssigned)
                    {
                        operation = ddlAssignedOperator.SelectedValue;

                        if (isGrant && operation == "deny")
                        {
                            addDenyRoles.Add(guid);
                            removeGrantRoles.Add(roleName);
                        }
                        if (isDeny && operation == "grant")
                        {
                            removeDenyRoles.Add(guid);
                            addGrantRoles.Add(roleName);
                        }
                        if (operation == "delete")
                        {
                            if (isDeny)
                            {
                                removeDenyRoles.Add(guid);
                            }
                            if (isGrant)
                            {
                                removeGrantRoles.Add(roleName);
                            }
                        }
                    }
                }

                xRPMembership.AddDenyRoleForUser(new Guid(user.ProviderUserKey.ToString()), addDenyRoles);
                xRPMembership.RemoveDenyRoleForUser(new Guid(user.ProviderUserKey.ToString()), removeDenyRoles);

                foreach (string s in removeGrantRoles)
                {
                    Roles.RemoveUserFromRole(user.UserName, s);
                }

                foreach (string s in addGrantRoles)
                {
                    Roles.AddUserToRole(user.UserName, s);
                }

                #endregion

                //lblMessage.Visible = true;
                //lblMessage.Text = "Cập nhật thành công";
                //lblMessage.CssClass = "success";
                message = "Cập nhật thành công";
                String cstext2 = "alert('" + message + "');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", cstext2, true);
            }
            catch (Exception ex)
            {
                //lblMessage.CssClass = "error";
                //lblMessage.Visible = true;
                message = message + "Lỗi trong quá trình cập nhật, lỗi: " + (ex.Message + ex.StackTrace).EncodeJsString();
                //string message = "Lỗi trong quá trình cập nhật, lỗi: " + ex.Message;
                String cstext2 = "alert('" + message + "');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", cstext2, true);
            }
        }

        protected void rptPermissions_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item)
            {
                UserPermissionViewModel role = (UserPermissionViewModel)e.Item.DataItem;
                //Role role = permission.Role;
                Label lblTip = (Label)e.Item.FindControl("lblTip");

                DropDownList ddlUnAssignedOperator = (DropDownList)e.Item.FindControl("ddlUnAssignedOperator");
                DropDownList ddlAssignedOperator = (DropDownList)e.Item.FindControl("ddlAssignedOperator");
                DropDownList ddlGroupOperator = (DropDownList)e.Item.FindControl("ddlGroupOperator");


                if (role.IsInherit)
                {
                    ddlGroupOperator.Visible = false;
                    ddlGroupOperator.Visible = true;
                    if (role.IsOverride)
                    {
                        ddlGroupOperator.SelectedValue = "deny";
                        ddlGroupOperator.Enabled = false;
                        lblTip.Text = lblInheritFromGroup.Text + lblOverride.Text;
                    }
                    else
                    {
                        ddlGroupOperator.SelectedValue = "grant";
                        lblTip.Text = lblInheritFromGroup.Text;
                    }
                }

                if (role.IsAssigned)
                {
                    ddlAssignedOperator.Visible = true;
                    if (role.IsGrant && !role.IsOverride)
                    {
                        lblTip.Text = lblGrant.Text;
                        ddlAssignedOperator.SelectedValue = "grant";
                    }
                    if (role.IsGrant && role.IsOverride)
                    {
                        lblTip.Text = lblGrant.Text + lblOverride.Text;
                        ddlAssignedOperator.SelectedValue = "grant";
                    }
                    if (role.IsDeny && !role.IsOverride)
                    {
                        lblTip.Text = lblDeny.Text;
                        ddlAssignedOperator.SelectedValue = "deny";
                    }
                    if (role.IsDeny && role.IsOverride)
                    {
                        lblTip.Text = lblDeny.Text + lblOverride.Text;
                        ddlAssignedOperator.SelectedValue = "deny";
                    }
                }

                if (role.IsOrphan)
                {
                    lblTip.Text = lblOrphan.Text;
                    ddlUnAssignedOperator.SelectedValue = "0";
                    ddlUnAssignedOperator.Visible = true;
                }
            }
        }

        protected void chkAdd_CheckedChanged(object sender, EventArgs e)
        {
            #region Update groups
            ///Cập nhật nhóm cho người dùng
            bool isAddUserToGroup = false;

            try
            {
                List<int> groupIds = new List<int>();
                int intTemp = 0;
                foreach (RepeaterItem item in rptGroups.Items)
                {
                    HiddenField hdfID = (HiddenField)item.FindControl("hdfID");
                    CheckBox chkAdd = (CheckBox)item.FindControl("chkAdd");
                    if (chkAdd.Checked)
                    {
                        int.TryParse(hdfID.Value, out intTemp);
                        if (intTemp > 0) groupIds.Add(intTemp);
                    }
                }
                isAddUserToGroup = xRPMembership.UpdateGroupForUser(new Guid(user.ProviderUserKey.ToString()), groupIds);
                if (isAddUserToGroup)
                {
                    lblMessage.Visible = true;
                    lblMessage.Text = "Cập nhật thành công";
                    lblMessage.CssClass = "success";
                }
                else
                {
                    lblMessage.CssClass = "error";
                    lblMessage.Visible = true;
                    lblMessage.Text = "Lỗi trong quá trình cập nhật";
                }
            }
            catch (Exception ex)
            {
                lblMessage.CssClass = "error";
                lblMessage.Visible = true;
                message = message + "Lỗi trong quá trình cập nhật, lỗi: " + (ex.Message + ex.StackTrace).EncodeJsString();
            }
            #endregion
        }
    }
}