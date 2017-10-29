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
using xRP.App_Code.Service;

namespace xRP.Administrator.QuanLyHeThong.NguoiDung
{
    public partial class Profile : System.Web.UI.UserControl
    {
        public string message = string.Empty;
        public bool IsSystemAdmin = false;
        public MembershipUser user = null;
        Sys_DanhMucNhomRepository groupRepository = new Sys_DanhMucNhomRepository();
        StaffService staffService = new StaffService();

        string username = string.Empty;

        public Sys_CanBo staff = new Sys_CanBo();

        protected void Page_Load(object sender, EventArgs e)
        {

            username = HttpContext.Current.User.Identity.Name;
            user = Membership.GetUser(username);

            txtTenDangNhap.Text = username;
            txtPassword.Text = string.Empty;
            txtRePassword.Text = string.Empty;
            txtEmail.Text = user.Email;

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

            ///Show department information
            staff = staffService.GetStaff(username);
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
            groups.FindAll(x => userGroupsIds.Contains(x.ID)).ForEach(x => vms.Add(new UserGroupViewModel { Group = x, IsChecked = true }));

            rptGroups.DataSource = vms.OrderBy(x => x.Group.TenNhom).ToList();
            rptGroups.DataBind();

            ///Show Permissions
            IsSystemAdmin = xRPMembership.IsSystemAdmin(user.UserName);

            if (!IsSystemAdmin)
            {
                List<Role> roles = xRPMembership.GetRoleForUser(user.UserName);
                rptPermissions.DataSource = roles;
                rptPermissions.DataBind();
            }
            else
            {
                rptPermissions.Visible = false;
            }

            if (staff != null)
            {
                txtName.Text = staff.TenCanBo;
                txtSoDienThoai.Text = staff.SoDienThoai;
            }

            List<PositionViewModel> positions = new List<PositionViewModel>();
            if (staff != null) positions = staffService.GetPositionByStaff(staff.ID);
            rptDepartments.DataSource = positions;
            rptDepartments.DataBind();
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                lblEmailSuccess.Visible = false;
                lblPasswordSucess.Visible = false;

                bool updateProfileSuccess = false;

                string email = txtEmail.Text;
                string oldPassword = txtOldPassword.Text;
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


                if (!string.IsNullOrEmpty(oldPassword))
                {
                    //Check password is valid
                    bool isValidPassword = false;
                    isValidPassword = Membership.ValidateUser(user.UserName, oldPassword);

                    bool changePassIsSuccess = false;

                    if (isValidPassword)
                    {
                        try
                        {
                            user.ChangePassword(oldPassword, password);
                            changePassIsSuccess = true;
                        }
                        catch { }
                        if (changePassIsSuccess)
                        {
                            lblPasswordSucess.Text = "Thay đổi mật khẩu thành công.";
                            lblPasswordSucess.Visible = true;
                        }
                        else
                        {
                            lblPasswordError.Text = "Mật khẩu mới không hợp lệ, vui lòng chọn mật khẩu khác.";
                            message = message + "Mật khẩu mới không hợp lệ, vui lòng chọn mật khẩu khác.\\n";
                        }
                    }
                    else
                    {
                        message = message + "Mật khẩu cũ không chính xác, vui lòng nhập chính xác mật khẩu cũ.\\n";
                    }
                }

                #endregion


                #region Update profile
                if (staff != null)
                {
                    staff.SoDienThoai = txtSoDienThoai.Text;
                    staff.TenCanBo = txtName.Text;
                    updateProfileSuccess = staffService.UpdateStaff(staff.ID, txtName.Text, txtSoDienThoai.Text);
                    if (!updateProfileSuccess)
                    {
                        message = message + "Cập nhật thông tin không thành công.\\n";
                    }
                }
                #endregion

                lblMessage.Visible = true;
                lblMessage.Text = "Cập nhật thành công";
                lblMessage.CssClass = "success";
            }
            catch (Exception ex)
            {
                lblMessage.CssClass = "error";
                lblMessage.Visible = true;
                message = message + "Lỗi trong quá trình cập nhật, lỗi: " + (ex.Message + ex.StackTrace).EncodeJsString();

            }
        }


    }
}