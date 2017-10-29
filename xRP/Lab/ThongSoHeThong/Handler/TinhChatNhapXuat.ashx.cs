using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using xRPDAL;
namespace xRP.Lab.ThongSoHeThong.Handler
{
    /// <summary>
    /// Summary description for TinhChatNhapXuat
    /// </summary>
    public class TinhChatNhapXuat : IHttpHandler
    {
        xRPDataContext datacontext = new xRPDataContext();

        public void ProcessRequest(HttpContext context)
        {

            //List<Qlvt_TinhChatNhapXuat> listTinhChatNhapXuat = new List<Qlvt_TinhChatNhapXuat>();
            //listTinhChatNhapXuat = datacontext.Qlvt_TinhChatNhapXuats.ToList();

            //List<NoBody> listResult = new List<NoBody>();
            //listResult = (from ds in listTinhChatNhapXuat
            //              select new NoBody
            //              {
            //                  Key = ds.ID.ToString(),
            //                  Value = ds.TenTinhChatNhapXuat
            //              }).ToList();
            //JavaScriptSerializer javascriptSerializer = new JavaScriptSerializer();
            //string result = javascriptSerializer.Serialize(listTinhChatNhapXuat);
            string abc = "\"{ \"name\": \"John Johnson\", \"street\": \"Oslo West 16\", \"phone\": \"555 1234567\" }\"";
            context.Response.Write(abc);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }

}