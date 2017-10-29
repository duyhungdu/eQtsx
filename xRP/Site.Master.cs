using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using xRPDAL;
using xRPRepository;

namespace xRP
{
    public partial class Site : System.Web.UI.MasterPage // MasterBase//
    {
        string username = "";
        public string PHANHE { get; set; }
        public int POSITION { get; set; }
        public string pages { get; set; }
        Sys_FunctionRepository functionRepository = new Sys_FunctionRepository();
        protected void Page_Load(object sender, EventArgs e)
        {
            //Gán cứng phân hệ và vị trí 1 = Menu
            PHANHE = "QLSX";
            POSITION = 1;

            //Lấy thông tin người dùng đang đăng nhập
            MembershipUser user = Membership.GetUser(HttpContext.Current.User.Identity.Name);
            if (user != null)
            {
                username = user.UserName;
                if (!IsPostBack)
                {
                    BindUserName();
                    BindMenu();
                }
            }
            else
            {
                Response.Redirect(FormsAuthentication.LoginUrl);
            }
        }
        /// <summary>
        /// Thể hiện username người dùng đang đăng nhập góc trên cùng bên phải
        /// Nut Thoát
        /// </summary>
        private void BindUserName()
        {
            ltUserName.Text = @"<a href='" + Util.SERVER_NAME + "/Administrator/QuanLyHeThong/Default.aspx?page=profile" + "'>" + username + "</a>";
            ltUserName.Text += " (IP: " + Util.GetIP() + ")";
            ltLogout.Text = "<a href=" + Util.SERVER_NAME + "/Account/Logout.aspx" + ">Thoát</a>";
        }
        /// <summary>
        /// Load danh mục chức năng trên menu (cấp cha)
        /// </summary>
        protected void BindMenu()
        {
            if (Request.QueryString["page"] != null)
            {
                pages = Request.QueryString["page"].ToString();
            }
            else
            {
                pages = "home";
            }
            string result = "";
            string temp_li_active = @"<li class='selected'><a class='selected' href='{0}'>{1}</a></li>";
            string temp_li = @"<li><a href='{0}'>{1}</a></li>";
            string temp_li_parent_selected = @"<li class='selected'><a class='selected' href='{0}'>{1}</a>{2}</li>";
            string temp_li_parent = @"<li><a href='{0}'>{1}</a>{2}</li>";
            string temp_ul = "<ul>{0}</ul>";
            if (Request.QueryString["page"] == null || Request.QueryString["page"].ToString() == "home" || pages == "home")
            {
                result += string.Format(temp_li_active, "/", "Bàn làm việc");
            }
            else
            {
                result += string.Format(temp_li, "/", "Bàn làm việc");
            }


            List<Sys_Function> listParentFunction = new List<Sys_Function>();
            listParentFunction = functionRepository.GetFunctionByTenPhanHe(PHANHE, 0, POSITION);
            string buildListLi = "";
            string buildUl = "";
            foreach (Sys_Function function in listParentFunction)
            {
                List<Sys_Function> listChildFunction = new List<Sys_Function>();
                listChildFunction = functionRepository.GetFunctionByTenPhanHe(PHANHE, function.ID, POSITION);
                if (function != null)
                {
                    if (listChildFunction.Count > 0)
                    {

                        if (function.Icon != null && function.Icon.Contains(pages))
                        {
                            result += string.Format(temp_li_parent_selected, function.Href, function.TenChucNang, BindChildMenu(function));
                        }
                        else
                        {
                            result += string.Format(temp_li_parent, function.Href, function.TenChucNang, BindChildMenu(function));
                        }
                    }
                    else
                    {
                        if (function.Icon != null && function.Icon.Contains(pages))
                        {
                            result += string.Format(temp_li_active, function.Href, function.TenChucNang);
                        }
                        else
                        {
                            result += string.Format(temp_li, function.Href, function.TenChucNang);
                        }
                    }
                }
            }
            ltMenu.Text += result;
        }
        /// <summary>
        /// Đệ quy lấy danh mục chức năng cấp con
        /// </summary>
        /// <param name="function"></param>
        /// <returns></returns>
        protected string BindChildMenu(Sys_Function function)
        {

            string result = "";
            string temp_li_active = @"<li class='selected'><a href='{0}'>{1}</a></li>";
            string temp_li = @"<li><a href='{0}'>{1}</a></li>";
            string temp_li_blank = @"<li><a target='_blank' href='{0}'>{1}</a></li>";
            string temp_li_parent_selected = @"<li class='selected'><a href='{0}'>{1}</a>{2}</li>";
            string temp_li_parent = @"<li><a href='{0}'>{1}</a>{2}</li>";
            string temp_li_parent_blank = @"<li><a target='_blank' href='{0}'>{1}</a>{2}</li>";
            string temp_ul = "<ul>{0}</ul>";


            string buildUl = "";
            List<Sys_Function> listiPubFunction = new List<Sys_Function>();
            listiPubFunction = functionRepository.GetFunctionByTenPhanHe(PHANHE, function.ID, POSITION);
            if (listiPubFunction.Count > 0)
            {

                foreach (Sys_Function childFunction in listiPubFunction)
                {
                    if (childFunction.Icon != "NOT-MENU")
                    {
                        string buildListLi = "";
                        if (functionRepository.GetFunctionByTenPhanHe(PHANHE, childFunction.ID, POSITION).Count > 0)
                        {
                            buildListLi += BindChildMenu(childFunction);
                            if (childFunction.Href == "javascript:void(0);")
                            {

                                buildUl += string.Format(temp_li_parent, childFunction.Href, childFunction.TenChucNang, buildListLi);
                            }
                            else
                            {
                                if (!string.IsNullOrEmpty(childFunction.NodeID))
                                {
                                    buildUl += string.Format(temp_li_parent_blank, childFunction.Href, childFunction.TenChucNang, buildListLi);

                                }
                                else
                                {
                                    buildUl += string.Format(temp_li_parent, childFunction.Href, childFunction.TenChucNang, buildListLi);
                                }
                            }
                        }
                        else
                        {
                            if (childFunction.Href == "javascript:void(0);")
                            {
                                buildUl += string.Format(temp_li, childFunction.Href, childFunction.TenChucNang);
                            }
                            else
                            {
                                if (!string.IsNullOrEmpty(childFunction.NodeID))
                                {
                                    buildUl += string.Format(temp_li_blank, childFunction.Href, childFunction.TenChucNang);

                                }
                                else
                                {
                                    buildUl += string.Format(temp_li, childFunction.Href, childFunction.TenChucNang);
                                }
                            }
                        }

                    }
                }
                return string.Format(temp_ul, buildUl);
            }
            else
            {
                if (function.Href == "")
                {
                    return string.Format(temp_li, function.Href, function.TenChucNang);
                }
                else
                {
                    return string.Format(temp_li, function.Href, function.TenChucNang);
                }
            }

        }
    }
}