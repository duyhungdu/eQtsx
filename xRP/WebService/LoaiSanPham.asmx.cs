﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using xRPDAL;

namespace xRP.WebService
{
    /// <summary>
    /// Summary description for LoaiSanPham
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class LoaiSanPham : System.Web.Services.WebService
    {
        [WebMethod]
        public string GetJSONData()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                List<object> list = new List<object>();
                foreach (var vt in dts.Qldh_LoaiSanPhams)
                {
                    list.Add(new
                    {
                        data = vt.ID,
                        value = vt.TenLoaiSanPham
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
