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
    public partial class Add : System.Web.UI.UserControl
    {
        Sys_DanhMucNhomRepository groupRepository = new Sys_DanhMucNhomRepository();

        protected void Page_Load(object sender, EventArgs e)
        {
            lblNameError.Visible = false;
            lblMessage.Visible = false;

            if (!IsPostBack)
            {
                BindPermission();
            }
        }



        private void BindPermission()
        {
            rptPermissions.DataSource = xRP.Security.xRPMembership.GetAllRoles();
            rptPermissions.DataBind();
        }


        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                int groupdID = 0;
                string name = txtName.Text;
                string role = string.Empty;
                List<Guid> permissions = new List<Guid>();
                bool isUpdateGroupSuccess = false;
                bool isExistName = false;//
                bool isUpdatePermissionSuccess = false;

                Sys_DanhMucNhom group = new Sys_DanhMucNhom();
                isExistName = groupRepository.IsExistName(name);

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

                groupRepository.Add(group);
                groupRepository.SubmitChanges();
                groupdID = group.ID;
                isUpdateGroupSuccess = true;


                isUpdatePermissionSuccess = xRPMembership.UpdatePermissionToGroup(permissions, groupdID);
                //Response.Redirect("default.aspx?page=editgroup&id=" + groupdID.ToString() + "&success=1");
                Page.Response.Redirect("~/Administrator/QuanLyHeThong/default.aspx?page=group");
            }
            catch (Exception ex)
            {
                string message = "Lỗi trong quá trình cập nhật, lỗi: " + ex.Message;
                String cstext2 = "alert('" + message + "');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", cstext2, true);
            }
        }
    }
}