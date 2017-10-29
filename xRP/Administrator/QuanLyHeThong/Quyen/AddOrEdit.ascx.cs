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
    public partial class AddOrEdit : System.Web.UI.UserControl
    {
        public string id { get; set; }

        public string trang { get; set; }


        protected void Page_Load(object sender, EventArgs e)
        {

            if (Attributes["param"] != null)
            {
                string URL = Attributes["param"];
                id = Util.GetParam(URL, "id");
                trang = Util.GetParam(URL, "trang");

                if (!string.IsNullOrEmpty(id))
                {
                    Role role = xRPMembership.GetRoleByName(id);
                    if (role != null)
                    {
                        txtCode.Text = role.Code;
                        txtNote.Text = role.Description;
                        txtTen.Text = role.Name;
                    }

                    //Sys_QuyenRepository repository = new Sys_QuyenRepository();
                    //Sys_Quyen entity = repository.GetById(int.Parse(id));
                    ////txtNote.Text = entity.MoTa;
                    //txtTen.Text = entity.Ten;
                    //txtMa.Text = entity.Ma;
                }

            }
        }
    }
}