using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;
using xRPRepository;

namespace xRP.Administrator.QuanLyHeThong.ThongSoHeThong
{
    public partial class AddOrEdit : System.Web.UI.UserControl
    {
        public string id { get; set; }

        public string trang { get; set; }
        public string ConfigName = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {

            id = Request.QueryString["id"] ?? string.Empty;
            trang = Request.QueryString["trang"] ?? string.Empty;
            lblMessage.Visible = false;

            if (!string.IsNullOrEmpty(id))
            {
                Sys_ThongSoHeThongRepository repository = new Sys_ThongSoHeThongRepository();
                Sys_ThongSoHeThong entity = repository.GetById(int.Parse(id));
                txtTen.Text = entity.ThongSo;
                txtNote.Text = entity.MoTa;
                txtValue.Text = entity.GiaTri;

                ConfigName = entity.ThongSo;
            }


        }



        protected void btnAdd_Click(object sender, EventArgs e)
        {
            bool isSuccess = false;
            string message = string.Empty;
            bool isExistName = false;

            string name = txtTen.Text;
            string note = txtNote.Text;
            string value = txtValue.Text;

            if (string.IsNullOrEmpty(id))
            {
                Sys_ThongSoHeThongRepository repository = new Sys_ThongSoHeThongRepository();
                Sys_ThongSoHeThong entity = new Sys_ThongSoHeThong();


                isExistName = repository.IsExistThongSo(name);

                if (isExistName)
                {
                    message = "Tên đã tồn tại, vui lòng nhập tên khác.\n";
                }
                else
                {
                    try
                    {
                        entity.ThongSo = name;
                        entity.MoTa = note;
                        entity.GiaTri = value;
                        entity.NgayThayDoi = DateTime.Now;
                        entity.NguoiThayDoi = Guid.NewGuid();

                        repository.InsertOnSubmit(entity);
                        repository.SubmitChanges();
                        isSuccess = true;
                    }
                    catch
                    {
                        message = "Lỗi trong quá trình cập nhật";
                    }
                }

            }
            else
            {
                Sys_ThongSoHeThongRepository repository = new Sys_ThongSoHeThongRepository();
                Sys_ThongSoHeThong entity = repository.GetById(int.Parse(id));

                ConfigName = entity.ThongSo;
                ///Check trùng tên trong trường hợp sửa
                if (entity.ThongSo != name)
                {
                    isExistName = repository.IsExistThongSo(name);

                    if (isExistName)
                    {
                        message = "Tên đã tồn tại, vui lòng nhập tên khác.\n";
                    }
                }
                if (!isExistName)
                {
                    try
                    {
                        entity.ThongSo = name;
                        entity.MoTa = note;
                        entity.GiaTri = value;
                        entity.NgayThayDoi = DateTime.Now;
                        entity.NguoiThayDoi = Guid.NewGuid();
                        repository.SubmitChanges();
                        isSuccess = true;
                    }
                    catch (Exception ex)
                    {
                        message = "Lỗi trong quá trình cập nhật";
                    }
                }

            }
            if (isSuccess)
            {
                Response.Redirect("default.aspx?page=config");
            }
            else
            {
                //lblMessage.Visible = true;
                //lblMessage.CssClass = "error";
                //lblMessage.Text = message;

                //string message = "Lỗi trong quá trình cập nhật, lỗi: " + ex.Message;
                String cstext2 = "alert('" + message + "');";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", cstext2, true);
            }
        }
    }
}