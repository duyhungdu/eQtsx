using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using xRPRepository;
using xRPDAL;
//using AjaxControlToolkit;
using System.Collections.Specialized;
using System.Web.Script.Serialization;
namespace xRP.WebService
{
    /// <summary>
    /// Summary description for VatTu
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class VatTu : System.Web.Services.WebService
    {

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }
        //[WebMethod]
        //public string[] Qlvt_MaVatTu_GetAll(string prefixText, int count)
        //{
        //    if (count == 0)
        //    {
        //        count = 10;
        //    }
        //    Qlvt_VatTuRepository vattuRepository = new Qlvt_VatTuRepository();
        //    prefixText = Util.XacDinhNguyenAm(prefixText);
        //    List<Qlvt_VatTu> listvattu = vattuRepository.Qlvt_VatTu_GetAllByMa(prefixText);
        //    List<string> items = new List<string>(count);
        //    int i = 0;
        //    foreach (Qlvt_VatTu vattu in listvattu)
        //    {
        //        string strName = vattu.MaHieuVatTu;
        //        items.Add(strName);
        //        i++;
        //        if (i == count)
        //            break;

        //    }
        //    return items.ToArray();
        //}
        //[WebMethod]
        //public string[] Qlvt_TenVatTu_GetAll(string prefixText, int count)
        //{
        //    if (count == 0)
        //    {
        //        count = 10;
        //    }
        //    prefixText = Util.XacDinhNguyenAm(prefixText);
        //    Qlvt_VatTuRepository vattuRepository = new Qlvt_VatTuRepository();
        //    List<Qlvt_VatTu> listvattu = vattuRepository.Qlvt_VatTu_GetAllByTen(prefixText);
        //    List<string> items = new List<string>(count);
        //    int i = 0;
        //    foreach (Qlvt_VatTu vattu in listvattu)
        //    {
        //        string strName = vattu.TenVatTu;
        //        items.Add(strName);
        //        i++;
        //        if (i == count)
        //            break;

        //    }
        //    return items.ToArray();
        //}
        [WebMethod]
        public string GetJSONData()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                List<object> list = new List<object>();
                foreach (var vt in dts.Sp_Qlvt_VatTu_Select(0, (int?)null, (int?)null, (int?)null))
                {
                    list.Add(new
                    {
                        ID = vt.ID,
                        MaVatTu = vt.MaHieuVatTu,
                        TenVatTu = vt.TenVatTu,
                        DonViTinh = vt.DonViTinh,
                        DinhLuongTieuChuan = vt.DinhLuong,
                        KichThuocTieuChuan = vt.KichThuocVatTu
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
        [WebMethod]
        public string GetJSONDataByMaHieu()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                List<object> list = new List<object>();
                foreach (var vt in dts.Sp_Qlvt_VatTu_Select(0, (int?)null, (int?)null, (int?)null))
                {
                    list.Add(new
                    {
                        value = vt.MaHieuVatTu,
                        data = vt.TenVatTu
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
        [WebMethod]
        public string GetJSONDataByTen()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                List<object> list = new List<object>();
                foreach (var vt in dts.Sp_Qlvt_VatTu_Select(0, (int?)null, (int?)null, (int?)null))
                {
                    list.Add(new
                    {
                        data = vt.MaHieuVatTu,
                        value = vt.TenVatTu
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

        [WebMethod]
        public string GetMaLoaiVatTuJSONData(int maVatTu)
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                var vatTu = dts.Sp_Qlvt_VatTu_Select(2, maVatTu, (int?)null, (int?)null).FirstOrDefault();
                if (vatTu == null)
                {
                    return "{\"ERROR\":\"Vật tư không tồn tại.\"}";
                }

                List<object> list = new List<object>();
                foreach (var lvt in dts.Sp_Qlvt_LoaiVatTu_Select(1, vatTu.MaLoaiVatTu, "", (int?)null, (int?)null))
                {
                    list.Add(new
                    {
                        data = lvt.MaHieuLoaiVatTu
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
