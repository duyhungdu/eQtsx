using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRP.Security;
using xRPDAL;
using xRPRepository;

namespace xRP.Administrator.QuanLyHeThong.Quyen
{
    public partial class FunctionForPermission : System.Web.UI.UserControl
    {
        public Role role = new Role();
        Sys_FunctionRepository functionRepository = new Sys_FunctionRepository();

        public string PHANHE { get; set; }
        public int POSITION { get; set; }


        protected void Page_Load(object sender, EventArgs e)
        {
            //Gán cứng phân hệ và vị trí 1 = Menu
            PHANHE = "QLSX";
            POSITION = 1;

            if (Request.QueryString["perid"] != null)
            {
                ltChucNang.Text = "Cấu hình chức năng cho quyền";
                var roleId = Request.QueryString["perid"].ToString();
                role = xRP.Security.xRPMembership.GetAllRoles().FirstOrDefault(p => p.ID == new Guid(roleId));

            }
            else
            {
                ltChucNang.Text = "Danh mục chức năng";
                pnlThongTinQuyen.Visible = false;
                role = xRP.Security.xRPMembership.GetAllRoles().FirstOrDefault(p => p.Code == "APPADMIN");
                if (role == null)
                {
                    role = xRP.Security.xRPMembership.GetAllRoles().FirstOrDefault();
                }
            }
            BindData(role.ID);
            // rptFunctions
        }
        protected void BindData(Guid roleId)
        {
            colPager.MaxPages = 10000;
            colPager.PageSize = 100;
            colPager.DataSource = BindFunction(roleId);
            colPager.BindToControl = rptFunctions;
            rptFunctions.DataSource = colPager.DataSourcePaged;
            rptFunctions.DataBind();

        }
        protected List<Sys_Function> BindFunction(Guid roleId)
        {
            List<Sys_Function> lsData = new List<Sys_Function>();
            List<Sys_Function> listParent = new List<Sys_Function>();
            listParent = functionRepository.GetFunctionBy2(roleId, PHANHE, 0).OrderBy(x => x.ThuTu).ToList();
            foreach (Sys_Function function in listParent)
            {
              //  lsData.Add(function);
                //BindChildMenu(roleId, ref lsData, function);

                //Ở đây có chức năng cấp cha nhất rồi
                List<Sys_Function> listChildFunction = GetListChildFunction(roleId, function, lsData, POSITION); 

            }
            return lsData;

        }
        protected List<Sys_Function> GetListChildFunction(Guid roleID, Sys_Function function, List<Sys_Function> list, int POSITION)
        {
            List<Sys_Function> listChildFunction = new List<Sys_Function>();
            listChildFunction = functionRepository.GetFunctionBy2(roleID, PHANHE, function.ID).OrderBy(x => x.ThuTu).ToList();
            if (listChildFunction.Count > 0)
            {
                 list.Add(function);
                foreach (Sys_Function child in listChildFunction)
                {
                    GetListChildFunction(roleID, child, list, POSITION);
                }
            }
            else
            {

                list.Add(function);
            }
            return list;
        }
        protected void BindChildMenu(Guid roleId, ref List<Sys_Function> lsFunction, Sys_Function function)
        {
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect(Util.SERVER_NAME + "/Administrator/QuanLyHeThong/Default.aspx?page=permission");
        }
    }
}