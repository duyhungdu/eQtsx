using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPRepository;
using xRPDAL;

namespace xRP.Administrator.QuanLyHeThong.PhongBan.Deparment
{
    public partial class AddRoot : System.Web.UI.UserControl
    {
        public string Nodes = string.Empty;
        public string id { get; set; }
        public int parentID = 0;
        public string trang { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            id = Request.QueryString["id"] ?? "0";

            if (IsPostBack) return;

            List<Option> options = BuildProductCategorySelection(5);
            foreach (Option option in options)
            {
                Nodes = string.Concat(Nodes, string.Format(lblNodeFormat.Text, option.ID, option.Name));
            }

            if (id != "0")
            {
                Sys_DanhMucDonViRepository repository = new Sys_DanhMucDonViRepository();
                Sys_DanhMucDonVi department = repository.GetById(int.Parse(id));
                txtCode.Text = department.MaHieuDonVi;
                txtName.Text = department.TenDonVi;
                txtNote.Text = department.GhiChu;
                parentID = department.MaDonViCapTren;
            }

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                int groupdID = 0;
                string name = txtCode.Text;
                string role = string.Empty;
                bool isExistName = false;//


                Sys_DanhMucDonVi entity = new Sys_DanhMucDonVi();
                Sys_DanhMucDonViRepository repository = new Sys_DanhMucDonViRepository();

                if (id != "0")
                {
                    entity = repository.GetById(int.Parse(id));
                    if (entity.MaHieuDonVi != txtCode.Text)
                    {
                        isExistName = repository.IsExistDepartmentCode(name);
                    }
                }
                else
                {
                    isExistName = repository.IsExistDepartmentCode(name);
                }

                if (isExistName)
                {

                    ClientScriptManager cs = Page.ClientScript;
                    String cstext1 = "alert('Tên nhóm đã tồn tại, vui lòng chọn tên khác');";
                    cs.RegisterStartupScript(this.GetType(), "alert", cstext1, true);


                    return;
                }
                entity.MaHieuDonVi = txtCode.Text;
                entity.NgayThayDoi = DateTime.Now;
                entity.NgayTao = DateTime.Now;
                entity.TenDonVi = txtName.Text;
                entity.GhiChu = txtNote.Text;

                int temp = 0;
                int.TryParse(Request.Form["ddlDepartment"], out temp);
                entity.MaDonViCapTren = temp;

                if (id == "0")
                {
                    repository.Add(entity);
                }

                repository.SubmitChanges();
                groupdID = entity.ID;

                Response.Redirect("default.aspx?page=department");
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

        public List<Option> BuildProductCategorySelection(int seperator)
        {
            List<Sys_DanhMucDonVi> departments = new Sys_DanhMucDonViRepository().GetAll().OrderBy(p => p.TenDonVi).ToList();
            if (id != "0") departments.RemoveAll(x => x.ID == int.Parse(id));
            List<Option> nodes = new List<Option>();
            foreach (Sys_DanhMucDonVi c in departments.FindAll(p => p.MaDonViCapTren == 0))
            {
                BuildOption(c, 0, seperator, ref nodes, ref departments);
            }
            return nodes;
        }

        private void BuildOption(Sys_DanhMucDonVi department, int level, int seperator, ref List<Option> nodes, ref List<Sys_DanhMucDonVi> departments)
        {
            string prefix = string.Empty;
            string name = string.Empty;
            for (int i = 0; i < level; i++)
            {
                prefix = string.Concat(prefix, "&nbsp;");
            }
            name = string.Concat(prefix, department.TenDonVi);
            Option node = new Option();
            node.Name = name;
            node.ID = department.ID;
            nodes.Add(node);
            level = level + seperator;
            foreach (Sys_DanhMucDonVi c in departments.FindAll(p => p.MaDonViCapTren == department.ID))
            {
                BuildOption(c, level, seperator, ref nodes, ref departments);
            }
        }

    }
}