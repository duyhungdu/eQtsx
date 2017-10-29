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


namespace xRP.Administrator.QuanLyHeThong.ChucVu
{
    public partial class AddOrEdit : System.Web.UI.UserControl
    {
        public string id { get; set; }

        public string trang { get; set; }


        protected void Page_Load(object sender, EventArgs e)
        {
            Sys_DanhMucChucVuRepository repository = new Sys_DanhMucChucVuRepository();

            if (Attributes["param"] != null)
            {
                string URL = Attributes["param"];
                id = Util.GetParam(URL, "id");

                if (string.IsNullOrEmpty(id)) id = "0";

                trang = Util.GetParam(URL, "trang");

                if (id != "0")
                {
                    Sys_DanhMucChucVu entity = repository.GetById(int.Parse(id));
                    txtName.Text = entity.TenChucVu;
                    txtNote.Text = entity.GhiChu;
                    ckKichHoat.Checked = entity.KichHoat;
                }
            }
        }
    }
}