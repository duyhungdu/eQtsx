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


namespace xRP.Administrator.QuanLyHeThong.Nhom
{
    public partial class Edit : System.Web.UI.UserControl
    {
        int id = 0;
        Sys_DanhMucNhomRepository groupRepository = new Sys_DanhMucNhomRepository();
        public string GroupName = string.Empty;
        public string RootPageUrl = "/Administrator/QuanLyHeThong/";


        protected void Page_Load(object sender, EventArgs e)
        {
            string temp = Request.QueryString["id"] ?? "0";
            int.TryParse(temp, out id);

            lblNameError.Visible = false;
            lblMessage.Visible = false;

            ///show message after add group successfully
            string success = Request.QueryString["success"] ?? "0";
            if (Request.UrlReferrer != null)
            {
                if (success == "1" && Request.UrlReferrer.ToString().ToLower().Contains("default.aspx?page=addgroup"))
                {
                    String cstext2 = "alert('Cập nhật thành công');";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", cstext2, true);
                }
            }
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            ShowDetail();
        }


        private void ShowDetail()
        {
            Sys_DanhMucNhom group = new Sys_DanhMucNhom();
            group = groupRepository.GetById(id);
            GroupName = group.TenNhom;

            if (IsPostBack) return;
            txtName.Text = group.TenNhom;
            txtNote.Text = group.GhiChu;
            ckKichHoat.Checked = group.KichHoat;

            List<Role> roles = xRPMembership.GetPermisisonForGroup(id);
            rptPermissions.DataSource = roles;
            rptPermissions.DataBind();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                string role = string.Empty;
                List<Guid> permissions = new List<Guid>();
                bool isUpdateGroupSuccess = false;
                bool isExistName = false;//
                bool isUpdatePermissionSuccess = false;

                Sys_DanhMucNhom group = new Sys_DanhMucNhom();
                group = groupRepository.GetById(id);

                if (group.TenNhom != txtName.Text)
                {
                    isExistName = groupRepository.IsExistName(txtName.Text);
                }

                if (isExistName)
                {
                    ClientScriptManager cs = Page.ClientScript;
                    String cstext1 = "alert('Tên nhóm đã tồn tại, vui lòng chọn tên khác');";
                    cs.RegisterStartupScript(this.GetType(), "alert", cstext1, true);
                    return;
                }

                group.NgayThayDoi = DateTime.Now;
                group.NgaySua = DateTime.Now;
                group.NgayTao = DateTime.Now;
                group.TenNhom = txtName.Text;
                group.GhiChu = txtNote.Text;
                group.KichHoat = ckKichHoat.Checked;

                foreach (RepeaterItem item in rptPermissions.Items)
                {
                    CheckBox chkAdd = (CheckBox)item.FindControl("chkAdd");
                    HiddenField hdfRole = (HiddenField)item.FindControl("hdfRole");
                    if (chkAdd.Checked)
                    {
                        role = hdfRole.Value;
                        permissions.Add(new Guid(role));
                    }
                }

                //groupRepository.Add(group);
                groupRepository.SubmitChanges();
                isUpdateGroupSuccess = true;

                isUpdatePermissionSuccess = xRPMembership.UpdatePermissionToGroup(permissions, id);

                Page.Response.Redirect("~/Administrator/QuanLyHeThong/default.aspx?page=group");

                // Check to see if the startup script is already registered.
                String cstext2 = "alert('Cập nhật thành công');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", cstext2, true);
            }
            catch (Exception ex)
            {
                //lblMessage.CssClass = "error";
                //lblMessage.Visible = true;
                //lblMessage.Text = "Lỗi trong quá trình cập nhật, lỗi: " + ex.Message;
                string message = "Lỗi trong quá trình cập nhật, lỗi: " + ex.Message;
                String cstext2 = "alert('" + message + "');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", cstext2, true);
            }
        }
    }
}