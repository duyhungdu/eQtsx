using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;
using xRPRepository;
using xRP;
using xRP.Security;
using Newtonsoft.Json;
using xRPUtil;
using System.Web.Script.Serialization;

namespace xRP.Administrator.QuanLyHeThong
{
    public partial class Default : System.Web.UI.Page
    {

        public string RootPageUrl = "/Administrator/QuanLyHeThong/";


        protected void Page_Load(object sender, EventArgs e)
        {
            string page = "";
            if (Request.QueryString["page"] != null)
            {
                page = Request.QueryString["page"];
                switch (page)
                {
                    case "log": LoadLog(); break;
                    case "config": LoadConfig(); break;
                    case "user": LoadUser(); break;
                    case "adduser": LoadAddUser(); break;
                    case "edituser": LoadEditUser(); break;
                    case "group": LoadGroup(); break;
                    case "addgroup": LoadAddGroup(); break;
                    case "editgroup": LoadEditGroup(); break;
                    case "permission": LoadPermission(); break;
                    case "perfun": LoadFunctionForPermission(); break;
                    case "addeditconfig": LoadAddEditConfig(); break;
                    case "profile": LoadUserProfile(); break;
                    case "department": LoadDepartment(); break;
                    case "position": LoadPosition(); break;
                    case "addposition": LoadAddPosition(); break;
                    case "adddepartment": LoadAddDepartment(); break;
                    case "editstaff": LoadEditStaff(); break;
                    case "staff": LoadStaff(); break;
                    case "addstaff": LoadAddStaff(); break;
                }
            }
        }

        private void LoadStaff()
        {
            string controlUrl = RootPageUrl + "/staff/list.ascx";
            xRP.Administrator.QuanLyHeThong.Staff.List listUC = (xRP.Administrator.QuanLyHeThong.Staff.List)this.Page.LoadControl(controlUrl);
            plcContent.Controls.Add(listUC);
        }

        private void LoadAddStaff()
        {
            string controlUrl = RootPageUrl + "/staff/Add.ascx";
            xRP.Administrator.QuanLyHeThong.Staff.Add listUC = (xRP.Administrator.QuanLyHeThong.Staff.Add)this.Page.LoadControl(controlUrl);
            plcContent.Controls.Add(listUC);
        }

        private void LoadEditStaff()
        {
            string controlUrl = RootPageUrl + "/staff/add.ascx";
            xRP.Administrator.QuanLyHeThong.Staff.Add listUC = (xRP.Administrator.QuanLyHeThong.Staff.Add)this.Page.LoadControl(controlUrl);
            plcContent.Controls.Add(listUC);
        }

        private void LoadAddPosition()
        {
            string controlUrl = RootPageUrl + "ChucVu/Add.ascx";
            Administrator.QuanLyHeThong.ChucVu.Add listUC = (Administrator.QuanLyHeThong.ChucVu.Add)this.Page.LoadControl(controlUrl);
            plcContent.Controls.Add(listUC);
        }

        private void LoadAddDepartment()
        {
            string controlUrl = RootPageUrl + "PhongBan/Department/Add.ascx";
            xRP.Administrator.QuanLyHeThong.PhongBan.Deparment.AddRoot listUC = (xRP.Administrator.QuanLyHeThong.PhongBan.Deparment.AddRoot)this.Page.LoadControl(controlUrl);
            plcContent.Controls.Add(listUC);
        }

        private void LoadPosition()
        {
            string controlUrl = RootPageUrl + "ChucVu/List.ascx";
            Administrator.QuanLyHeThong.ChucVu.List listUC = (Administrator.QuanLyHeThong.ChucVu.List)this.Page.LoadControl(controlUrl);
            plcContent.Controls.Add(listUC);
        }


        private void LoadDepartment()
        {
            string controlUrl = RootPageUrl + "PhongBan/List.ascx";
            xRP.Administrator.QuanLyHeThong.PhongBan.List listUC = (xRP.Administrator.QuanLyHeThong.PhongBan.List)this.Page.LoadControl(controlUrl);
            plcContent.Controls.Add(listUC);
        }

        private void LoadAddEditConfig()
        {
            string controlUrl = RootPageUrl + "ThongSoHeThong/AddOrEdit.ascx";
            xRP.Administrator.QuanLyHeThong.ThongSoHeThong.AddOrEdit listUC = (xRP.Administrator.QuanLyHeThong.ThongSoHeThong.AddOrEdit)this.Page.LoadControl(controlUrl);
            plcContent.Controls.Add(listUC);
        }

        private void LoadUserProfile()
        {
            string controlUrl = RootPageUrl + "NguoiDung/Profile.ascx";
            xRP.Administrator.QuanLyHeThong.NguoiDung.Profile listUC = (xRP.Administrator.QuanLyHeThong.NguoiDung.Profile)this.Page.LoadControl(controlUrl);
            plcContent.Controls.Add(listUC);
        }

        private void LoadPermission()
        {
            string controlUrl = RootPageUrl + "Quyen/List.ascx";
            Administrator.QuanLyHeThong.Quyen.List listUC = (Administrator.QuanLyHeThong.Quyen.List)this.Page.LoadControl(controlUrl);
            plcContent.Controls.Add(listUC);
        }

        private void LoadGroup()
        {
            string controlUrl = RootPageUrl + "Nhom/List.ascx";
            Administrator.QuanLyHeThong.Nhom.List listUC = (Administrator.QuanLyHeThong.Nhom.List)this.Page.LoadControl(controlUrl);
            plcContent.Controls.Add(listUC);
        }

        private void LoadAddGroup()
        {
            string controlUrl = RootPageUrl + "Nhom/Add.ascx";
            Administrator.QuanLyHeThong.Nhom.Add listUC = (Administrator.QuanLyHeThong.Nhom.Add)this.Page.LoadControl(controlUrl);
            plcContent.Controls.Add(listUC);
        }

        private void LoadEditGroup()
        {
            string controlUrl = RootPageUrl + "Nhom/Edit.ascx";
            Administrator.QuanLyHeThong.Nhom.Edit listUC = (Administrator.QuanLyHeThong.Nhom.Edit)this.Page.LoadControl(controlUrl);
            plcContent.Controls.Add(listUC);
        }

        private void LoadLog()
        {
            string controlUrl = RootPageUrl + "NhatKyHeThong/List.ascx";
            Administrator.QuanLyHeThong.NhatKyHeThong.List listUC = (Administrator.QuanLyHeThong.NhatKyHeThong.List)this.Page.LoadControl(controlUrl);
            plcContent.Controls.Add(listUC);
        }

        private void LoadConfig()
        {
            string controlUrl = RootPageUrl + "ThongSoHeThong/List.ascx";
            Administrator.QuanLyHeThong.ThongSoHeThong.List listUC = (Administrator.QuanLyHeThong.ThongSoHeThong.List)this.Page.LoadControl(controlUrl);
            plcContent.Controls.Add(listUC);
        }

        protected void LoadUser()
        {
            string controlUrl = RootPageUrl + "NguoiDung/List.ascx";
            Administrator.QuanLyHeThong.NguoiDung.List listUC = (Administrator.QuanLyHeThong.NguoiDung.List)this.Page.LoadControl(controlUrl);
            plcContent.Controls.Add(listUC);
        }

        private void LoadAddUser()
        {
            string controlUrl = RootPageUrl + "NguoiDung/AddUser.ascx";
            Administrator.QuanLyHeThong.NguoiDung.AddUser listUC = (Administrator.QuanLyHeThong.NguoiDung.AddUser)this.Page.LoadControl(controlUrl);
            plcContent.Controls.Add(listUC);
        }

        private void LoadEditUser()
        {
            string controlUrl = RootPageUrl + "NguoiDung/EditUser.ascx";
            Administrator.QuanLyHeThong.NguoiDung.EditUser listUC = (Administrator.QuanLyHeThong.NguoiDung.EditUser)this.Page.LoadControl(controlUrl);
            plcContent.Controls.Add(listUC);
        }


        private void LoadFunctionForPermission()
        {
            string controlUrl = RootPageUrl + "Quyen/FunctionForPermission.ascx";
            Administrator.QuanLyHeThong.Quyen.FunctionForPermission listUC = (Administrator.QuanLyHeThong.Quyen.FunctionForPermission)this.Page.LoadControl(controlUrl);
            plcContent.Controls.Add(listUC);
        }

        #region Staff


        [WebMethod]
        public static string GetPermisionForAccount(string username)
        {
            List<Role> roles = xRPMembership.GetRoleForUser(username);
            return JsonConvert.SerializeObject(new { items = roles });
        }


        #endregion

        #region Log

        [WebMethod]
        public static string DeleteLogItem(string itemID)
        {
            AjaxResponse response = new AjaxResponse();
            if (itemID.ToLower() == "admin" || itemID.ToLower() == "administrator")
            {
                response.IsSuccess = false;
                response.Message = "Không thể xóa tài khoản quản trị mặc định";
                return JsonConvert.SerializeObject(response);
            }

            try
            {
                //Initial data context variable, this class is declared in .dbml file in xRPDAL namespace
                Sys_UserLogRepository repository = new Sys_UserLogRepository();
                Sys_UserLog entity = repository.GetById(int.Parse(itemID));
                repository.DeleteOnSubmit(entity);
                repository.SubmitChanges();
                response.IsSuccess = true;
                response.Message = "OK";
            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = (ex.Message + ex.StackTrace).EncodeJsString();
            }
            return JsonConvert.SerializeObject(response);
        }

        #endregion

        #region Config

        [WebMethod]
        public static string DeleteConfigItem(string itemID)
        {
            AjaxResponse response = new AjaxResponse();

            try
            {
                //Initial data context variable, this class is declared in .dbml file in xRPDAL namespace
                Sys_ThongSoHeThongRepository repository = new Sys_ThongSoHeThongRepository();
                Sys_ThongSoHeThong entity = repository.GetById(int.Parse(itemID));
                repository.DeleteOnSubmit(entity);
                repository.SubmitChanges();
                response.IsSuccess = true;
                response.Message = "OK";
            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = (ex.Message + ex.StackTrace).EncodeJsString();
            }
            return JsonConvert.SerializeObject(response);
        }



        [WebMethod]
        public static string AddOrUpdateConfigItem(string id, string name, string value, string note)
        {
            AjaxResponse response = new AjaxResponse();
            try
            {
                if (string.IsNullOrEmpty(id))
                {

                    Sys_ThongSoHeThongRepository repository = new Sys_ThongSoHeThongRepository();
                    Sys_ThongSoHeThong entity = new Sys_ThongSoHeThong();

                    string message = string.Empty;
                    bool isExistName = false;

                    isExistName = repository.IsExistThongSo(name);


                    if (isExistName)
                    {
                        response.IsSuccess = false;
                        message = "Tên đã tồn tại, vui lòng nhập tên khác.\n";
                    }

                    if (isExistName)
                    {
                        response.Message = message;
                        return JsonConvert.SerializeObject(response);
                    }

                    entity.ThongSo = name;
                    entity.MoTa = note;
                    entity.GiaTri = value;
                    entity.NgayThayDoi = DateTime.Now;
                    entity.NguoiThayDoi = Guid.NewGuid();

                    repository.InsertOnSubmit(entity);
                    repository.SubmitChanges();

                    response.IsSuccess = true;
                }
                else
                {

                    Sys_ThongSoHeThongRepository repository = new Sys_ThongSoHeThongRepository();
                    Sys_ThongSoHeThong entity = repository.GetById(int.Parse(id));
                    if (entity == null)
                    {
                        response.IsSuccess = false;
                        response.Message = "Không tồn tại bản ghi";
                        return JsonConvert.SerializeObject(response);
                    }


                    ///Check trùng tên trong trường hợp sửa
                    if (entity.ThongSo != name)
                    {
                        string message = string.Empty;
                        bool isExistName = repository.IsExistThongSo(name);

                        if (isExistName)
                        {
                            response.IsSuccess = false;
                            message = "Tên đã tồn tại, vui lòng nhập tên khác.\n";
                        }

                        if (isExistName)
                        {
                            response.Message = message;
                            return JsonConvert.SerializeObject(response);
                        }
                    }

                    entity.ThongSo = name;
                    entity.MoTa = note;
                    entity.GiaTri = value;
                    entity.NgayThayDoi = DateTime.Now;
                    entity.NguoiThayDoi = Guid.NewGuid();
                    repository.SubmitChanges();

                    response.IsSuccess = true;
                }

            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = (ex.Message + ex.StackTrace).EncodeJsString();
            }
            return JsonConvert.SerializeObject(response);
        }
        #endregion

        #region User

        [WebMethod]
        public static string DeleteUserItem(string itemID)
        {
            AjaxResponse response = new AjaxResponse();
            if (itemID.ToLower() == "admin" || itemID.ToLower() == "administrator")
            {
                response.IsSuccess = false;
                response.Message = "Không thể xóa tài khoản quản trị mặc định";
                return JsonConvert.SerializeObject(response);
            }

            try
            {
                //Initial data context variable, this class is declared in .dbml file in xRPDAL namespace
                //Sys_NguoiDungRepository repository = new Sys_NguoiDungRepository();
                //response.IsSuccess = repository.DeleteUserByUserName(itemID);
                Membership.DeleteUser(itemID, true);
                response.IsSuccess = true;
                response.Message = "OK";
            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = (ex.Message + ex.StackTrace).EncodeJsString();
            }
            return JsonConvert.SerializeObject(response);
        }

        [WebMethod]
        public static string AddOrUpdateUserItem(string id, string username, string password, string email, string fullname, bool isactive)
        {
            AjaxResponse response = new AjaxResponse();
            try
            {
                if (string.IsNullOrEmpty(id))
                {
                    string message = string.Empty;
                    bool isExistUserName = false;
                    bool isExistEmail = false;

                    //isExistUserName = repository.IsExistUserName(username);
                    //isExistEmail = repository.IsExistEmail(email);

                    isExistUserName = Membership.GetUser(username) != null;
                    isExistEmail = !string.IsNullOrEmpty(Membership.GetUserNameByEmail(email));

                    if (isExistEmail)
                    {
                        response.IsSuccess = false;
                        message = "Email đã tồn tại, vui lòng nhập email khác.\n";
                    }

                    if (isExistUserName)
                    {
                        response.IsSuccess = false;
                        message += "Tên đăng nhập đã tồn tại, vui lòng nhập tên đăng nhập khác.\n";
                    }

                    if (isExistEmail || isExistUserName)
                    {
                        response.Message = message;
                        return JsonConvert.SerializeObject(response);
                    }


                    MembershipCreateStatus status = MembershipCreateStatus.Success;
                    Membership.CreateUser(username, password, email, string.Empty, string.Empty, true, (object)Guid.NewGuid(), out status);
                    if (status == MembershipCreateStatus.Success)
                    {
                        response.IsSuccess = true;
                        return JsonConvert.SerializeObject(response);
                    }
                    else
                    {
                        if (status == MembershipCreateStatus.DuplicateEmail)
                        {
                            message = "Địa chỉ email đã tồn tại, vui lòng chọn địa chỉ email khác";
                        }
                        if (status == MembershipCreateStatus.DuplicateUserName)
                        {
                            message = "Tên đăng nhập đã tồn tại, vui lòng chọn tên đăng nhập khác";
                        }
                        if (status == MembershipCreateStatus.InvalidEmail)
                        {
                            message = "Emai không hợp lệ, vui lòng chọn tên đăng nhập khác";
                        }

                        if (status == MembershipCreateStatus.InvalidPassword)
                        {
                            message = "Mật khẩu không hợp lệ, vui lòng chọn mật khẩu khác";
                        }
                        if (string.IsNullOrEmpty(message))
                        {
                            message = "Lỗi không xác định đã xảy ra, vui lòng thử lại";
                        }
                        response.Message = message;
                        return JsonConvert.SerializeObject(response);
                    }
                    response.Message = message;
                    return JsonConvert.SerializeObject(response);
                }
                else
                {
                    //Update chưa làm
                }

            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = (ex.Message + ex.StackTrace).EncodeJsString();
            }
            return JsonConvert.SerializeObject(response);
        }
        #endregion

        #region Permission
        [WebMethod]
        public static string DeletePermissionItem(string itemID)
        {
            AjaxResponse response = new AjaxResponse();
            try
            {
                Roles.DeleteRole(itemID);
                response.IsSuccess = true;
                response.Message = "OK";
            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = (ex.Message + ex.StackTrace).EncodeJsString();
            }
            return JsonConvert.SerializeObject(response);
        }



        [WebMethod]
        public static string AddOrUpdatePermissionItem(string id, string name, string code, string note)
        {
            AjaxResponse response = new AjaxResponse();
            try
            {
                if (string.IsNullOrEmpty(id))
                {
                    string message = string.Empty;
                    CreateRoleStatus status = new CreateRoleStatus();
                    status = xRPMembership.CreateRole(name, code, note);
                    if (!status.IsSuccess)
                    {
                        if (status.IsDuplicateCode)
                        {
                            message += "Mã quyền đã tồn tại, vui lòng chọn mã khác.\n";
                        }
                        if (status.IsDuplicateName)
                        {
                            message = "Tên đã tồn tại, vui lòng chọn tên khác.\n";
                        }
                        response.IsSuccess = false;
                        response.Message = message;

                    }
                    else
                    {
                        response.IsSuccess = true;
                        response.Message = "Cập nhật thành công";
                    }
                }
                else
                {
                    string message = string.Empty;
                    UpdateRoleStatus status = new UpdateRoleStatus();
                    Role updateRole = new Role();
                    updateRole.Code = code;
                    updateRole.Description = note;
                    updateRole.Name = name;

                    status = xRPMembership.UpdateRole(id, updateRole);
                    if (!status.IsSuccess)
                    {
                        if (status.IsDuplicateCode)
                        {
                            message += "Mã quyền đã tồn tại, vui lòng chọn mã khác.\n";
                        }
                        if (status.IsDuplicateName)
                        {
                            message = "Tên đã tồn tại, vui lòng chọn tên khác.\n";
                        }
                        response.IsSuccess = false;
                        response.Message = message;

                    }
                    else
                    {
                        response.IsSuccess = true;
                        response.Message = "Cập nhật thành công";
                    }
                }

            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = (ex.Message + ex.StackTrace).EncodeJsString();
            }
            return JsonConvert.SerializeObject(response);
        }

        [WebMethod]
        public static string AddOrUpdateFunctionRole(string roleId, string lsFunction)
        {
            AjaxResponse response = new AjaxResponse();
            var strresponse = "";

            if (!string.IsNullOrEmpty(lsFunction))
            {
                xRPDataContext dts = new xRPDataContext();
                Sys_FunctionRepository functionRepository = new Sys_FunctionRepository();
                var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();

                var dataQuyenTheoChucNangs = new JavaScriptSerializer().Deserialize<List<Sys_QuyenTheoChucNang>>(lsFunction);
                response.IsSuccess = functionRepository.AddOrUpdateFunctionRole(new Guid(roleId), dataQuyenTheoChucNangs, user.UserId, ref strresponse);
                response.Message = strresponse.EncodeJsString();
            }
            else
            {

                response.IsSuccess = false;
                response.Message = "Quá trình thực hiện không thành công".EncodeJsString();
            }
            return JsonConvert.SerializeObject(response);
        }


        #endregion

        #region Group
        [WebMethod]
        public static string DeleteGroupItem(string itemID)
        {
            AjaxResponse response = new AjaxResponse();
            try
            {
                //Initial data context variable, this class is declared in .dbml file in xRPDAL namespace
                Sys_DanhMucNhomRepository repository = new Sys_DanhMucNhomRepository();
                Sys_DanhMucNhom entity = repository.GetById(int.Parse(itemID));
                repository.DeleteOnSubmit(entity);
                repository.SubmitChanges();
                response.IsSuccess = true;
                response.Message = "OK";
            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = (ex.Message + ex.StackTrace).EncodeJsString();
            }
            return JsonConvert.SerializeObject(response);
        }
        #endregion

        #region Position

        [WebMethod]
        public static string DeletePostionItem(string itemID)
        {
            AjaxResponse response = new AjaxResponse();
            try
            {
                //Initial data context variable, this class is declared in .dbml file in xRPDAL namespace
                Sys_DanhMucChucVuRepository repository = new Sys_DanhMucChucVuRepository();
                Sys_DanhMucChucVu entity = repository.GetById(int.Parse(itemID));
                repository.DeleteOnSubmit(entity);
                repository.SubmitChanges();
                response.IsSuccess = true;
                response.Message = "OK";
            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = (ex.Message + ex.StackTrace).EncodeJsString();
            }
            return JsonConvert.SerializeObject(response);
        }


        [WebMethod]
        public static string DeletePositionItem(string itemID)
        {
            AjaxResponse response = new AjaxResponse();
            try
            {
                //Initial data context variable, this class is declared in .dbml file in xRPDAL namespace
                int temp = 0;
                int.TryParse(itemID, out temp);
                Sys_DanhMucDonViRepository repository = new Sys_DanhMucDonViRepository();

                List<Sys_DanhMucDonVi> childs = repository.GetTable().Where(x => x.MaDonViCapTren == temp).ToList();
                //Sys_DanhMucDonVi parent = repository.GetById(temp);
                foreach (Sys_DanhMucDonVi child in childs)
                {
                    child.MaDonViCapTren = 0;
                }
                repository.Delete(temp);
                repository.SubmitChanges();
                response.IsSuccess = true;
                response.Message = "OK";

            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = (ex.Message + ex.StackTrace).EncodeJsString();
            }
            return JsonConvert.SerializeObject(response);
        }


        [WebMethod]
        public static string AddOrUpdatePositionItem(string id, string name, bool isactive, string note)
        {
            AjaxResponse response = new AjaxResponse();
            try
            {
                string message = string.Empty;

                int groupdID = 0;
                string role = string.Empty;
                bool isExistName = false;//
                Sys_DanhMucChucVuRepository repository = new Sys_DanhMucChucVuRepository();

                //response.IsSuccess = true;
                //response.Message = "Cập nhật thành công";

                Sys_DanhMucChucVu entity = new Sys_DanhMucChucVu();

                if (id != "0")
                {
                    entity = repository.GetById(int.Parse(id));
                    if (entity.TenChucVu != name)
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
                    response.IsSuccess = false;
                    response.Message = "Tên chức vụ đã tồn tại, vui lòng chọn tên khác";
                    return JsonConvert.SerializeObject(response);
                }

                entity.NgayThayDoi = DateTime.Now;
                entity.NgaySua = DateTime.Now;

                entity.NgayTao = DateTime.Now;
                entity.TenChucVu = name;
                entity.GhiChu = note;
                entity.KichHoat = isactive;

                if (id == "0")
                {
                    repository.Add(entity);
                }

                repository.SubmitChanges();
                groupdID = entity.ID;

                response.IsSuccess = true;
                response.Message = "Cập nhật thành công";

            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = (ex.Message + ex.StackTrace).EncodeJsString();
            }
            return JsonConvert.SerializeObject(response);
        }


        [WebMethod]
        public static string AddOrUpdateFunctionItem(string id, string ma, string name, string parentID,string href,string icon, string thutu)
        {
            AjaxResponse response = new AjaxResponse();
            xRPDataContext dts = new xRPDataContext();
            var user = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
            try
            {
                string message = string.Empty;

                int groupdID = 0;
                string role = string.Empty;
                bool isExistName = false;//
                Sys_FunctionRepository repository = new Sys_FunctionRepository();

                //response.IsSuccess = true;
                //response.Message = "Cập nhật thành công";

                Sys_Function entity = new Sys_Function();

                if (id != "")
                {
                    entity = repository.GetById(int.Parse(id));
                }
                else
                {
                    entity.NgayTao = DateTime.Now;
                    entity.MaNguoiTao = user.UserId;
                }
                entity.NgayThayDoi = DateTime.Now;
                entity.MaNguoiThayDoi = user.UserId;
                entity.Ma = ma;
                entity.TenChucNang = name;
                entity.ParentID = int.Parse(parentID);
                entity.Href = href;
                entity.Icon=icon;
                entity.Position = 1;
                entity.PhanHeID = 1;
                entity.ThuTu = int.Parse(thutu);
                if (id == "0")
                {
                    repository.InsertOnSubmit(entity);
                }
                repository.SubmitChanges();
                response.IsSuccess = true;
                response.Message = "Cập nhật thành công";

            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = (ex.Message + ex.StackTrace).EncodeJsString();
            }
            return JsonConvert.SerializeObject(response);
        }


        #endregion

        #region Department
        [WebMethod]
        public static string AddDepartment(string name, string code, string note)
        {
            AjaxResponse response = new AjaxResponse();
            try
            {
                Sys_DanhMucDonViRepository repository = new Sys_DanhMucDonViRepository();


                bool isExistCode = repository.IsExistDepartmentCode(code);
                if (isExistCode)
                {
                    response.IsSuccess = false;
                    response.Message = "Mã đơn vị đã tồn tại, vui lòng chọn mã khác.";
                }
                else
                {
                    Sys_DanhMucDonVi department = new Sys_DanhMucDonVi();
                    department.TenDonVi = name;
                    department.MaHieuDonVi = code;
                    department.MaDonViCapTren = 0;
                    department.KichHoat = true;
                    department.NgayTao = DateTime.Now;
                    department.NgayThayDoi = DateTime.Now;
                    department.CapDo = 0;
                    repository.Add(department);
                    repository.SubmitChanges();
                    response.IsSuccess = true;
                    response.Message = "Cập nhật thành công";
                }
            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = (ex.Message + ex.StackTrace).EncodeJsString();
            }
            return JsonConvert.SerializeObject(response);
        }

        [WebMethod]
        public static string GetUsersByDepartment(string departmentId)
        {
            Sys_CanBoRepository repository = new Sys_CanBoRepository();
            List<Sys_CanBo> staff = repository.GetStaffByDepartment(int.Parse(departmentId));// repository.GetAll().ToList();
            return JsonConvert.SerializeObject(new { items = staff });
        }

        [WebMethod]
        public static string GetPermissionForUserName(string username)
        {
            List<Role> permissions = new List<Role>();
            permissions = xRPMembership.GetRoleForUser(username);
            return JsonConvert.SerializeObject(new { items = permissions });

        }

        [WebMethod]
        public static string DeleteStaffItem(string itemID)
        {
            AjaxResponse response = new AjaxResponse();
            try
            {
                //Initial data context variable, this class is declared in .dbml file in xRPDAL namespace
                int temp = 0;
                int.TryParse(itemID, out temp);
                Sys_CanBoRepository repository = new Sys_CanBoRepository();
                repository.Delete(temp);
                repository.SubmitChanges();
                response.IsSuccess = true;
                response.Message = "OK";
            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = (ex.Message + ex.StackTrace).EncodeJsString();
            }
            return JsonConvert.SerializeObject(response);
        }

        [WebMethod]
        public static string GetRoleForStaff(string username)
        {
            List<Role> permissions = new List<Role>();
            permissions = xRPMembership.GetRoleForUser(username);
            return JsonConvert.SerializeObject(new { items = permissions });
        }


        #endregion
    }
}