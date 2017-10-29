using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;
using xRPRepository;

namespace xRP.Administrator.QuanLyHeThong.PhongBan
{
    public partial class List : System.Web.UI.UserControl
    {

        public string RootPageUrl = "/Administrator/QuanLyHeThong/";

        public string DeparmentTree = string.Empty;
        string itemFormat = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            itemFormat = lblDeparmentRowFormat.Text;
            BuildTree();
        }

        private void BuildTree()
        {
            List<string> nodes = new List<string>();
            Sys_DanhMucDonViRepository repository = new Sys_DanhMucDonViRepository();
            List<Sys_DanhMucDonVi> departments = repository.GetDepartmentStructure();
            int level = 0;
            departments.ForEach(x => nodes = BuildTreeNode(x, level, itemFormat, nodes));
            nodes.ForEach(x => DeparmentTree = string.Concat(DeparmentTree, x));
        }


        private List<string> BuildTreeNode(Sys_DanhMucDonVi department, int level, string format, List<string> nodes)
        {
            string temp = string.Empty;
            temp = string.Format(format, department.TenDonVi, level, department.ID);
            nodes.Add(temp);
            ++level;
            department.Childs.ForEach(x => nodes = BuildTreeNode(x, level, format, nodes));
            return nodes;
        }

    }
}