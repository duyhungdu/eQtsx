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
    public partial class AddUser : System.Web.UI.UserControl
    {
        Sys_DanhMucNhomRepository groupRepository = new Sys_DanhMucNhomRepository();

        protected void Page_Load(object sender, EventArgs e)
        {
            BindGroups();
            BindPermission();
        }

        private void BindPermission()
        {
            rptPermissions.DataSource = xRP.Security.xRPMembership.GetAllRoles();
            rptPermissions.DataBind();
        }


        private void BindGroups()
        {
            List<Sys_DanhMucNhom> allGroups = groupRepository.GetAll().ToList();
            rptGroups.DataSource = allGroups;
            rptGroups.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            bool hasError = false;
            bool isAddUserSuccess = false;
            bool isAddUserToGroup = false;
            bool isAddPermissionToUser = false;

            string email = txtEmail.Text;
            string password = txtPassword.Text;
            string repassword = txtRePassword.Text;
            string username = txtTenDangNhap.Text;

            if (password != repassword || string.IsNullOrEmpty(password))
            {
                lblPasswordError.Text = "Mật khẩu không được để trống và phải khớp nhau.";
                hasError = true;
            }

            if (string.IsNullOrEmpty(username))
            {
                lblNameError.Text = "Tên đăng nhập không được để trống.";
                hasError = true;
            }

            if (hasError) return;

            //MembershipCreateStatus status = MembershipCreateStatus.Success;
            MembershipUser user = null;
            try
            {
                if (string.IsNullOrEmpty(email))
                {
                    user = Membership.CreateUser(username, password);
                }
                if (!string.IsNullOrEmpty(email))
                {
                    user = Membership.CreateUser(username, password, email);
                }
                isAddUserSuccess = true;
            }
            catch (MembershipCreateUserException ex)
            {
                hasError = true;
                if (ex.StatusCode == MembershipCreateStatus.DuplicateEmail)
                {
                    lblEmailError.Text = "Email đã tồn tại, vui lòng chọn email khác.";
                    lblEmailError.Visible = true;
                }
                if (ex.StatusCode == MembershipCreateStatus.DuplicateUserName)
                {
                    lblNameError.Text = "Tên đăng nhập đã tồn tại, vui lòng chọn tên đăng nhập khác.";
                    lblNameError.Visible = true;
                }
                if (ex.StatusCode == MembershipCreateStatus.InvalidUserName)
                {
                    lblNameError.Text = "Tên đăng nhập không hợp lệ, vui lòng chọn tên đăng nhập khác.";
                    lblNameError.Visible = true;
                }
                if (ex.StatusCode == MembershipCreateStatus.InvalidPassword)
                {
                    lblPasswordError.Text = "Mật khẩu không hợp lệ, vui lòng chọn tên mật khẩu khác.";
                    lblPasswordError.Visible = true;
                }
            }

            if (isAddUserSuccess)
            {
                ///Cập nhật nhóm cho người dùng
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

                ///Cập nhật quyền cho người dùng
                List<Guid> permissionIds = new List<Guid>();
                //List<Guid> grantPermissions = new List<Guid>();
                List<string> grantPermissions = new List<string>();
                List<Guid> denyPermisions = new List<Guid>();


                foreach (RepeaterItem item in rptPermissions.Items)
                {
                    HiddenField hdfID = (HiddenField)item.FindControl("hdfID");
                    HiddenField hdfName = (HiddenField)item.FindControl("hdfName");
                    DropDownList ddlOperator = (DropDownList)item.FindControl("ddlOperator");

                    if (ddlOperator.SelectedValue == "deny")
                    {
                        denyPermisions.Add(new Guid(hdfID.Value));
                    }
                    if (ddlOperator.SelectedValue == "grant")
                    {
                        //grantPermissions.Add(new Guid(hdfID.Value));
                        grantPermissions.Add(hdfName.Value);
                    }
                }
                isAddPermissionToUser = xRPMembership.AddPermissionToUser(new Guid(user.ProviderUserKey.ToString()), user.UserName, grantPermissions, denyPermisions);
            }

            if (isAddUserSuccess)
            {
                Response.Redirect("default.aspx?page=edituser&success=1&id=" + user.UserName);
            }
        }

    }
}