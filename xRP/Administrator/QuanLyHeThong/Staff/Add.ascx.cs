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


namespace xRP.Administrator.QuanLyHeThong.Staff
{
    public partial class Add : System.Web.UI.UserControl
    {
        Sys_DanhMucChucVuRepository repository = new Sys_DanhMucChucVuRepository();
        public string id = string.Empty;
        public string DeparmentTree = string.Empty;
        public string StaffName = string.Empty;
        string itemFormat = string.Empty;
        public string trang = "";
        List<Sys_DanhMucChucVu> positions = new List<Sys_DanhMucChucVu>();
        Sys_CanBoRepository staffRepository = new Sys_CanBoRepository();
        Sys_CanBo staff = new Sys_CanBo();
        List<Sys_CanBo_Department_ChucVu> mappings = new List<Sys_CanBo_Department_ChucVu>();


        protected void Page_Load(object sender, EventArgs e)
        {
            trang = Request.QueryString["trang"] != null ? Request.QueryString["trang"].ToString() : "1";
            lblNameError.Visible = false;
            lblMessage.Visible = false;

            itemFormat = lblDeparmentRowFormat.Text;

            id = Request.QueryString["id"] ?? "0";


            if (!IsPostBack)
            {
                List<string> userNames = staffRepository.GetAvailableUserName();

                if (id != "0")
                {
                    staff = staffRepository.GetById(int.Parse(id));
                    ckKichHoat.Checked = staff.KichHoat;
                    txtName.Text = staff.TenCanBo;
                    txtEmail.Text = staff.Email;
                    txtSoDienThoai.Text = staff.SoDienThoai;
                    StaffName = staff.TenCanBo;

                    if (!string.IsNullOrEmpty(staff.UserName))
                    {
                        userNames.Add(staff.UserName);
                    }

                    mappings = staffRepository.GetMappingByStaff(int.Parse(id));
                }

                ddlAccount.DataSource = userNames;
                ddlAccount.Items.Add(new ListItem { Text = "[Bạn hãy chọn]", Value = "0" });
                ddlAccount.DataBind();

                if (id != "0")
                {
                    ddlAccount.SelectedValue = staff.UserName;

                }


                Sys_DanhMucChucVuRepository positionRepository = new Sys_DanhMucChucVuRepository();
                positions = positionRepository.GetAll().ToList();

                ///Phong ban, don vi
                Sys_DanhMucDonViRepository repository = new Sys_DanhMucDonViRepository();
                List<DepartmentTreeNode> nodes = new List<DepartmentTreeNode>();
                List<Sys_DanhMucDonVi> departments = repository.GetDepartmentStructure();
                int level = 0;
                departments.ForEach(x => nodes = BuildTreeNode(x, level, nodes));

                rptDepartment.DataSource = nodes;
                rptDepartment.DataBind();
            }
        }


        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Sys_CanBoRepository repository = new Sys_CanBoRepository();
            Sys_CanBo staff = new Sys_CanBo();

            if (!string.IsNullOrEmpty(id) && id != "0")
            {
                staff = repository.GetById(int.Parse(id));
            }

            //Update thông tin cơ bản
            bool isExistEmail = false;
            if (id == "0")
            {
                if (repository.IsEmailExist(txtEmail.Text))
                {
                    lblEmailError.Visible = true;
                    lblEmailError.Text = "Email đã tồn tại, vui lòng chọn email khác";
                    return;
                }
            }
            else
            {
                if (staff.Email.ToLower() != txtEmail.Text.ToLower())
                {
                    if (repository.IsEmailExist(txtEmail.Text))
                    {
                        lblEmailError.Visible = true;
                        lblEmailError.Text = "Email đã tồn tại, vui lòng chọn email khác";
                        return;
                    }
                }
            }

            staff.UserName = ddlAccount.SelectedValue;
            staff.NgayThayDoi = DateTime.Now;
            staff.Email = txtEmail.Text;
            staff.MaNguoiTao = new Guid(Membership.GetUser(HttpContext.Current.User.Identity.Name).ProviderUserKey.ToString());
            staff.MaNguoiThayDoi = new Guid(Membership.GetUser(HttpContext.Current.User.Identity.Name).ProviderUserKey.ToString());
            staff.NgayTao = DateTime.Now;
            staff.SoDienThoai = txtSoDienThoai.Text;
            staff.TenCanBo = txtName.Text;
            staff.KichHoat = ckKichHoat.Checked;
            if (id == "0")
            {
                repository.Add(staff);
            }
            repository.SubmitChanges();
            ///Update thông tin chức vụ phòng ban.
            int temp = 0;

            List<Sys_CanBo_Department_ChucVu> mappings = new List<Sys_CanBo_Department_ChucVu>();
            foreach (RepeaterItem item in rptDepartment.Items)
            {
                CheckBox chkCheck = (CheckBox)item.FindControl("chkCheck");
                DropDownList ddlPosition = (DropDownList)item.FindControl("ddlPosition");
                HiddenField hdfID = (HiddenField)item.FindControl("hdfID");
                int.TryParse(ddlPosition.SelectedValue, out temp);

                if (chkCheck.Checked && temp > 0)
                {
                    Sys_CanBo_Department_ChucVu map = new Sys_CanBo_Department_ChucVu();
                    map.CanBoID = staff.ID;
                    map.ChucVuID = temp;
                    map.DepartmentID = int.Parse(hdfID.Value);
                    mappings.Add(map);
                }
            }
            repository.UpdateDepartmentPosition(staff.ID, mappings);

            Page.Response.Redirect("default.aspx?page=staff&trang=" + trang);
        }

        private List<DepartmentTreeNode> BuildTreeNode(Sys_DanhMucDonVi department, int level, List<DepartmentTreeNode> nodes)
        {
            DepartmentTreeNode node = new DepartmentTreeNode();
            node.Name = department.TenDonVi;
            node.Level = level;
            node.ID = department.ID;
            nodes.Add(node);
            ++level;
            department.Childs.ForEach(x => nodes = BuildTreeNode(x, level, nodes));
            return nodes;
        }

        protected void rptDepartment_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item)
            {
                DepartmentTreeNode node = (DepartmentTreeNode)e.Item.DataItem;
                DropDownList ddlPosition = (DropDownList)e.Item.FindControl("ddlPosition");
                CheckBox chkCheck = (CheckBox)e.Item.FindControl("chkCheck");
                ddlPosition.DataSource = positions;
                ddlPosition.DataBind();

                if (mappings.Count > 0)
                {
                    Sys_CanBo_Department_ChucVu map = mappings.FirstOrDefault(x => x.DepartmentID == node.ID);
                    if (map != null)
                    {
                        ddlPosition.Enabled = true;
                        chkCheck.Checked = true;
                        ddlPosition.SelectedValue = map.ChucVuID.ToString();
                    }

                }

            }
        }


    }
}