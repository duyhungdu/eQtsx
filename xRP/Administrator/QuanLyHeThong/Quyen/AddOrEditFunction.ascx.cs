using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;
using xRPRepository;
using xRP.Security;

namespace xRP.Administrator.QuanLyHeThong.Quyen
{
    public partial class AddOrEditFunction : System.Web.UI.UserControl
    {
        public string id { get; set; }

        public string trang { get; set; }


        protected void Page_Load(object sender, EventArgs e)
        {
            Sys_FunctionRepository repository = new Sys_FunctionRepository();

            if (Attributes["param"] != null)
            {
                string URL = Attributes["param"];
                id = Util.GetParam(URL, "id");

                if (string.IsNullOrEmpty(id)) id = "0";

                if (id != "0")
                {
                    Sys_Function entity = repository.GetById(int.Parse(id));
                    txtName.Text = entity.TenChucNang;
                    txtMa.Text = entity.Ma;
                    txtIcon.Text = entity.Icon;
                    txtHref.Text = entity.Href;
                    txtOrder.Text = entity.ThuTu != null ? entity.ThuTu.ToString() : "0";
                    try
                    {
                        txtParent.Text = new xRPDataContext().Sys_Functions.FirstOrDefault(x => x.ID == entity.ParentID).TenChucNang;
                    }
                    catch
                    {
                        txtParent.Text = "";
                        
                    }
                    hdfParentID.Value = entity.ParentID != null ? entity.ParentID.Value.ToString() : "0";
                }
            }
        }
    }
}