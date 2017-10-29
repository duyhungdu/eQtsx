using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;
using xRPRepository;

namespace xRP.Account
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        xRPDataContext dataContext = new xRPDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            lblMessage.Visible = false;
            if (IsPostBack) return;
            txtUserNameOrEmail.Focus();
        }

        private void SendMail(string emailAddress, string userName, string newPassword)
        {
            string subject = "Khôi phục mật khẩu";
            string body = "Tên đăng nhập của bạn là: " + userName + "<br/>Mật khẩu mới của bạn là: " + newPassword;
            MailMessage mailMessage = new System.Net.Mail.MailMessage();
            mailMessage.Body = body;
            mailMessage.IsBodyHtml = true;
            mailMessage.Subject = subject;
            mailMessage.From = new MailAddress(new Sys_ThongSoHeThongRepository().GetThongSoHeThong("email_reset_pwd", "netvietic@gmail.com"));
            mailMessage.To.Add(emailAddress);
            SmtpClient smtp = new System.Net.Mail.SmtpClient("smtp.gmail.com",587);
          //  smtp.Credentials = new NetworkCredential(new Sys_ThongSoHeThongRepository().GetThongSoHeThong("email_reset_pwd", "netvietic@gmail.com"), new Sys_ThongSoHeThongRepository().GetThongSoHeThong("email_reset_pwd_pwd", "netviet@2015"));
            smtp.Credentials = new NetworkCredential("netvietic2015@gmail.com", "NetViet@2015");
            smtp.EnableSsl = true;
            smtp.Send(mailMessage);
        }


        protected void btnRecoverPassword_Click(object sender, EventArgs e)
        {
            List<string> message = new List<string>();
            bool isSendEmailSuccess = false;
            bool hasError = false;
            string username = string.Empty;
            MembershipUser user = null;
            if (txtUserNameOrEmail.Text.Contains("@"))
            {
                username = Membership.GetUserNameByEmail(txtUserNameOrEmail.Text);
            }
            else
            {
                user = Membership.GetUser(txtUserNameOrEmail.Text);
            }

            if (string.IsNullOrEmpty(username) && user == null)
            {
                hasError = true;
                message.Add("Không tồn tại tài khoản trong hệ thống, vui lòng thử lại.");
            }
            if (!string.IsNullOrEmpty(username) && user == null)
            {
                user = Membership.GetUser(username);
            }

            if (user != null)
            {
                if (string.IsNullOrEmpty(user.Email))
                {
                    message.Add("Tài khoản hiện tại không có thông tin email, vui lòng liên hệ với quản trị để lấy lại mật khẩu");
                    hasError = true;
                }
                else if (!IsEmail(user.Email))
                {
                    message.Add("Định dạng email không đúng...");
                    hasError = true;
                }
            }

            if (!hasError && user != null)
            {
                string newPassword = user.ResetPassword();
                try
                {
                    SendMail(user.Email, user.UserName, newPassword);
                    isSendEmailSuccess = true;
                }
                catch (Exception ex)
                {
                    hasError = true;
                    message.Add("Lỗi trong quá trình gửi mail, vui lòng liên hệ với quản trị "+ex.Message+ex.StackTrace);
                    //message.Add(ex.Message + ex.StackTrace);
                }
            }


            if (isSendEmailSuccess)
            {
                lblMessage.Visible = true;
                lblMessage.Text = "Một email chứa mật khẩu đã được gửi tới địa chỉ: " + user.Email;
            }
            if (!isSendEmailSuccess || hasError)
            {
                string s = string.Empty;
                message.ForEach(x => s = string.Concat(s, "<br/>", x));
                lblMessage.Text = s;
                lblMessage.Visible = true;
            }
        }


        private bool IsEmail(string email)
        {
            bool isEmail = Regex.IsMatch(email, @"\A(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)\Z", RegexOptions.IgnoreCase);
            return isEmail;
        }
    }
}