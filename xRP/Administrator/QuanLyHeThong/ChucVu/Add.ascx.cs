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


namespace xRP.Administrator.QuanLyHeThong.ChucVu
{
    public partial class Add : System.Web.UI.UserControl
    {
        Sys_DanhMucChucVuRepository repository = new Sys_DanhMucChucVuRepository();
        public string id = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            lblNameError.Visible = false;
            lblMessage.Visible = false;

            id = Request.QueryString["id"] ?? "0";


            if (!IsPostBack)
            {
                if (id != "0")
                {
                    Sys_DanhMucChucVu entity = repository.GetById(int.Parse(id));
                    txtName.Text = entity.TenChucVu;
                    txtNote.Text = entity.GhiChu;
                    ckKichHoat.Checked = entity.KichHoat;
                }
            }
        }


        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                int groupdID = 0;
                string name = txtName.Text;
                string role = string.Empty;
                bool isExistName = false;//


                Sys_DanhMucChucVu entity = new Sys_DanhMucChucVu();

                if (id != "0")
                {
                    entity = repository.GetById(int.Parse(id));
                    if (entity.TenChucVu != txtName.Text)
                    {
                        isExistName = repository.IsExistName(name);
                    }
                }
                else
                {
                    isExistName = repository.IsExistName(name);
                }

                if (isExistName)
                {
                    //lblNameError.Text = "Tên chức vụ đã tồn tại, vui lòng chọn tên khác";
                    //lblNameError.Visible = true;

                    ClientScriptManager cs = Page.ClientScript;
                    String cstext1 = "alert('Tên chức vụ đã tồn tại, vui lòng chọn tên khác');";
                    cs.RegisterStartupScript(this.GetType(), "alert", cstext1, true);

                    return;
                }

                entity.NgayThayDoi = DateTime.Now;
                entity.NgaySua = DateTime.Now;

                entity.NgayTao = DateTime.Now;
                entity.TenChucVu = txtName.Text;
                entity.GhiChu = txtNote.Text;
                entity.KichHoat = ckKichHoat.Checked;

                if (id == "0")
                {
                    repository.Add(entity);
                }

                repository.SubmitChanges();
                groupdID = entity.ID;

                Response.Redirect("default.aspx?page=position");

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