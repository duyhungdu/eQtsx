using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace xRP.Business.Home
{
    public partial class VersionInfo : System.Web.UI.UserControl
    {
        public string version = "";
        public string buildDate = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            xRPDAL.xRPDataContext dataContext = new xRPDAL.xRPDataContext();
            string version_info = "";
            try
            {
                version_info = (from ds in dataContext.Sys_ThongSoHeThongs where ds.ThongSo == "VersionInfo" select ds).FirstOrDefault().GiaTri;
            }
            catch
            {
                version_info = "Thiếu thống số";
            }
            ltThongTinPhienBan.Text = version_info;
            LoadVersion();
        }
        protected void LoadVersion()
        {
            Assembly assembly = Assembly.GetExecutingAssembly();
             version = assembly.GetName().Version.ToString();
             buildDate = getBuildTime().ToString("dd/MM/yyyy HH:mm:ss");
        }
        protected DateTime getLinkerTimeStamp(string filepath)
        {
            const int peHeaderOffset = 60;
            const int linkerTimestampOffset = 8;

            byte[] b = new byte[2048];
            Stream s = null;

            try
            {
                s = new FileStream(filepath, FileMode.Open, FileAccess.Read);
                s.Read(b, 0, 2048);
            }
            finally
            {
                if (s != null)
                {
                    s.Close();
                }
            }

            int i = BitConverter.ToInt32(b, peHeaderOffset);
            int secondsSince1970 = BitConverter.ToInt32(b, i + linkerTimestampOffset);
            DateTime dt = new DateTime(1970, 1, 1, 0, 0, 0);
            dt = dt.AddSeconds(secondsSince1970);
            dt = dt.AddHours(TimeZone.CurrentTimeZone.GetUtcOffset(dt).Hours);
            return dt;
        }

        protected DateTime getBuildTime()
        {
            System.Reflection.Assembly assembly = System.Reflection.Assembly.GetExecutingAssembly();
            return getLinkerTimeStamp(assembly.Location);
        }
    }
}