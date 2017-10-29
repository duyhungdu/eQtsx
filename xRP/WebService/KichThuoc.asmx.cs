using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using xRPDAL;

namespace xRP.WebService
{
    /// <summary>
    /// Summary description for LoaiVatTu
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    [System.Web.Script.Services.ScriptService]
    public class KichThuoc : System.Web.Services.WebService
    {

        [WebMethod]
        public string GetJSONDataKichThuocForAutoComplete()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                List<object> list = new List<object>();
                foreach (var vt in dts.Qldh_LoaiKichThuocs)
                {
                    list.Add(new
                    {
                        data = vt.ID,
                        value = vt.MaHieuKichThuoc.Trim() + " - " + vt.LoaiKichThuoc
                    });
                }
                data = new JavaScriptSerializer().Serialize(list);
            }
            catch (Exception ex)
            {
                data = "{error:\"" + ex.Message + "\"}";
            }
            return data;
        }
    }
}
