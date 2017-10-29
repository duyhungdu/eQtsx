using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;


public static class Util
{
    #region Membership
    public static string currentUserName = HttpContext.Current.User.Identity.Name;
    #endregion Membership
    #region String
    public static string SplipText(string text, int length)
    {
        string result = text;
        int space = 0;
        if (result.Length > length)
        {
            for (int i = 0; i < result.Length; i++)
            {
                if (result[i] == ' ')
                {
                    if (i <= length)
                    {
                        space = i;
                    }
                    else
                    {
                        break;
                    }
                }
            }
            if (space != 0)
            {
                result = result.Substring(0, space) + "...";
            }
            else
            {
                result = result.Substring(0, length) + "...";
            }
        }
        return result;
    }
    public static string GetParam(string URL, string key)
    {
        if (URL != "")
        {
            string[] list = URL.Split('&');
            foreach (string item in list)
            {
                string[] keywords = item.Split('=');
                if (keywords[0] == key)
                {
                    return keywords[1];
                }
            }
        }
        return "";
    }
    public static string XacDinhNguyenAm(string searchKey)
    {
        searchKey = searchKey.ToLower();
        char[] charArr = searchKey.ToCharArray();
        searchKey = "";
        foreach (char c in charArr)
        {
            string tmp = "";
            tmp = c.ToString();

            if (c == 'a')
            {
                tmp = "[aáàạảãâấầậẩẫăắằặẳẵ]";
            }
            if (c == 'e')
            {
                tmp = "[eéèẹẻẽêếềệểễ]";
            }
            if (c == 'o')
            {
                tmp = "[oóòọỏõôốồộổỗơớờợởỡ]";
            }
            if (c == 'i')
            {
                tmp = "[iíìịỉĩ]";
            }
            if (c == 'u')
            {
                tmp = "[uúùụủũưứừựửữ]";
            }
            if (c == 'd')
            {
                tmp = "[dđ]";
            }
            if (c == 'y')
            {
                tmp = "[ýyỳỷỹ]";
            }
            searchKey += tmp;
        }
        return searchKey;
    }
    #endregion String
    #region Number
    public static bool IsNumber(string pText)
    {
        Regex regex = new Regex(@"^[-+]?[0-9]*\.?[0-9]+$");
        return regex.IsMatch(pText);
    }

    #endregion Number
    #region Date time
    public static DateTime ConvertStringToDateTime(string datetime)
    {
        List<string> listDateTime = datetime.Split('/').ToList();
        DateTime result = new DateTime();
        result = new DateTime(int.Parse(listDateTime[2]), int.Parse(listDateTime[1]), int.Parse(listDateTime[0]));
        return result;
    }
    public static bool IsDate_ddMMyyyy(string strDate, ref DateTime outDate)
    {
        try
        {
            string[] temp = strDate.Trim().Split('/');
            outDate = new DateTime(int.Parse(temp[2]), int.Parse(temp[1]), int.Parse(temp[0]), 00, 00, 00);
            return true;
        }
        catch
        {
            return false;
        }
    }
    public static string FormatDateTime(object datetime)
    {
        return string.Format("{0:dd/MM/yyyy}", datetime);
    }
    #endregion Date time
    #region Enterprise
    public static string RerenderStatus(object paraRender, string true_value, string false_value)
    {
        if (paraRender != null)
        {
            if ((bool)paraRender == true)
            {
                return true_value;
            }
            else
            {
                return false_value;
            }
        }
        else
        {
            return false_value;
        }
    }
    public static string RerenderInOut(object paraRender, string true_value, string false_value)
    {
        if (paraRender != null)
        {
            if ((int)paraRender == 1)
            {
                return true_value;
            }
            else
            {
                return false_value;
            }
        }
        else
        {

            return false_value;
        }
    }
    public static string GenerateCode(string partern, int number)
    {
        string[] arr = partern.Split(':');
        string phanchu = "";
        string phanso = "";
        if (arr.Length > 0)
        {
            phanchu = arr[0];
            phanso = arr[1];
        }
        return phanchu + number.ToString("D" + phanso);
    }
    #endregion Enterprise
    #region Client Resource
    public static string GetIP()
    {
        return HttpContext.Current.Request.UserHostAddress;
    }
    public static string GetHostID()
    {
        string strHostName = "";
        strHostName = Dns.GetHostName();
        string currIP = "";
        IPHostEntry ipEntry = Dns.GetHostByName(strHostName);
        IPAddress[] ipAddress = ipEntry.AddressList;
        for (int i = 0; i < ipAddress.Length; i++)
        {
            currIP += ipAddress[i].ToString();
        }
        return currIP;
    }
    public static string GetPCName()
    {
        return Dns.GetHostName();
    }
    #endregion Client Resource
    #region Server resource
    /// <summary>
    /// Get Name of Server - only for web-application
    /// </summary>
    /// <returns></returns>
    public static string GetServerName()
    {
        string result = "http://" + HttpContext.Current.Request.Url.Host + ":" + HttpContext.Current.Request.Url.Port;
        result = result.Replace(":80", string.Empty);
        return result;
    }
    /// <summary>
    /// Server's name
    /// </summary>
    public static readonly string SERVER_NAME = GetServerName();
    #endregion Server resource
    /// <summary>
    /// Other Application (website...)
    /// </summary>
    /// <returns></returns>
    #region Non-Language SEO
    public static string BuildObjectTitleSEO(object objectTitle)
    {
        string strReturn = "";
        Regex regex = new Regex("\\p{IsCombiningDiacriticalMarks}+");
        strReturn = Regex.Replace(objectTitle.ToString().Trim(), "[^\\w\\s]", string.Empty).Replace("-", string.Empty).Replace(" ", "-").Replace(":", "-").ToLower();
        string strFormD = strReturn.Normalize(System.Text.NormalizationForm.FormD);
        return regex.Replace(strFormD, string.Empty).Replace("đ", "d");
    }

    public static string BuildNewsArticleSEO(object id, object categoryTitle, object title)
    {
        int newsarticleID = 0;
        string newsarticleTitle = "";
        string newscategoryTitle = "";
        newsarticleID = (id != null) ? (int)id : 0;
        newsarticleTitle = (title != null) ? title.ToString() : "";
        newscategoryTitle = (categoryTitle != null) ? categoryTitle.ToString() : "";
        return string.Format("/bai-viet/{1}/{2}-{0}.htm", newsarticleID, BuildObjectTitleSEO(newscategoryTitle), BuildObjectTitleSEO(newsarticleTitle));
    }
    public static string BuildNewsCategorySEO(object id, object title)
    {
        int newscategoryID = 0;
        string newscategoryTitle = "";
        newscategoryID = (id != null) ? (int)id : 0;
        newscategoryTitle = (title != null) ? title.ToString() : "";
        return string.Format("/chuyen-muc/{1}-{0}.htm", newscategoryID, BuildObjectTitleSEO(newscategoryTitle));
    }

    public static string BuildProductSEO(object id, object categoryTitle, object title)
    {
        int productID = 0;
        string productTitle = "";
        string productCategoryTitle = "";
        productID = (id != null) ? (int)id : 0;
        productTitle = (title != null) ? title.ToString() : "";
        productCategoryTitle = (categoryTitle != null) ? categoryTitle.ToString() : "";
        return string.Format("/san-pham/{1}/{2}-{0}.htm", productID, BuildObjectTitleSEO(productCategoryTitle), BuildObjectTitleSEO(productTitle));
    }
    public static string BuildProductCategorySEO(object id, object title)
    {
        int productcategoryID = 0;
        string productcategoryTitle = "";
        productcategoryID = (id != null) ? (int)id : 0;
        productcategoryTitle = (title != null) ? title.ToString() : "";
        return string.Format("/danh-muc/{1}-{0}.htm", productcategoryID, BuildObjectTitleSEO(productcategoryTitle));
    }
    #endregion SEO
    #region Message
    public static string ShowErrorMessageTitle()
    {
        return "";
    }
    public static string ShowErrorMessage()
    {
        return "";
    }
    #endregion Message
    #region HTML

    public static string FethLinkFromSource(string html)
    {
        try
        {
            string regexImgSrc = @"<img[^>]*?src\s*=\s*[""']?([^'"" >]+?)[ '""][^>]*?>";
            MatchCollection matchesImgSrc = Regex.Matches(html, regexImgSrc, RegexOptions.IgnoreCase | RegexOptions.Singleline);
            foreach (Match m in matchesImgSrc)
            {
                string href = m.Groups[1].Value;
                return href;

            }
        }
        catch
        { return ""; }
        return "";
    }
    public static string RemoveImageTag(string html)
    {

        try
        {
            int indexImg = html.IndexOf("<img", 0);
            while (indexImg != -1)
            {
                int endIndex = html.IndexOf("/>", indexImg);
                string imge = html.Substring(indexImg, endIndex - indexImg + 2);
                html = html.Replace(imge, "");

                indexImg = html.IndexOf("<img", 0);
            }
            return html;
        }
        catch
        { return ""; }
       
    }
    public static string StripTagsRegex(string source)
    {
        return Regex.Replace(source, "<.*?>", string.Empty);
    }
    #endregion HTML
    #region Hàm đọc tiền thành chữ
    public static string ReadMoney(string Money)
    {
        string temp = "";
        // Cho đủ 12 số
        while (Money.Length < 12)
        {
            Money = "0" + Money;
        }
        string g1 = Money.Substring(0, 3);
        string g2 = Money.Substring(3, 3);
        string g3 = Money.Substring(6, 3);
        string g4 = Money.Substring(9, 3);

        //Đọc nhóm 1 ---------------------
        if (g1 != "000")
        {
            temp = ReadGroup3Digit(g1);
            temp += " Tỷ";
        }
        //Đọc nhóm 2-----------------------
        if (g2 != "000")
        {
            temp += ReadGroup3Digit(g2);
            temp += " Triệu";
        }
        //---------------------------------
        if (g3 != "000")
        {
            temp += ReadGroup3Digit(g3);
            temp += " Ngàn";
        }
        //-----------------------------------
        //Chỗ này ko biết có nên ko ?
        //temp =temp + ReadGroup3(g4).Replace("Không Trăm Lẻ","Lẻ"); // Đọc 1000001 là Một Triệu Lẻ Một thay vì Một Triệu Không Trăm Lẻ 1;
        temp = temp + ReadGroup3Digit(g4);
        //---------------------------------
        // Tinh chỉnh
        temp = temp.Replace("Một Mươi", "Mười");
        temp = temp.Trim();
        if (temp.IndexOf("Không Trăm") == 0)
            temp = temp.Remove(0, 10);
        temp = temp.Trim();
        if (temp.IndexOf("Lẻ") == 0)
            temp = temp.Remove(0, 2);
        temp = temp.Trim();
        temp = temp.Replace("Mươi Một", "Mươi Mốt");
        temp = temp.Trim();
        if (temp.Length < 1) return "";
        //Change Case
        return temp.Substring(0, 1).ToUpper() + temp.Substring(1).ToLower();

    }



    private static string ReadGroup3Digit(string G3)
    {
        try
        {
            string[] ReadDigit = new string[10] { " Không", " Một", " Hai", " Ba", " Bốn", " Năm", " Sáu", " Bảy", " Tám", " Chín" };
            string temp = "";
            if (G3 == "000") return "";

            //Ðọc số hàng trăm
            temp = ReadDigit[int.Parse(G3[0].ToString())] + " Trăm";
            //Ðọc số hàng chục
            if (G3[1].ToString() == "0")
                if (G3[2].ToString() == "0") return temp;
                else
                {
                    temp += " Lẻ" + ReadDigit[int.Parse(G3[2].ToString())];
                    return temp;
                }
            else
                temp += ReadDigit[int.Parse(G3[1].ToString())] + " Mươi";
            //--------------Ðọc hàng dơn vị

            if (G3[2].ToString() == "5") temp += " Năm";
            else if (G3[2].ToString() != "0") temp += ReadDigit[int.Parse(G3[2].ToString())];
            return temp;
        }
        catch
        {
            return string.Empty;
        }
    }

    #endregion kết thúc

    #region Hàm chuyển số sang định dạng tiền
    public static string ConvertNumber(string parameter)
    {
        CultureInfo elGR = CultureInfo.CreateSpecificCulture("el-GR");
        string number = string.Format(elGR, "{0:0,0}", parameter);
        return number;
    }
    #endregion kết thúc  
    public static string FormatMoney(double money)
    {
        return string.Format("{0:#,###.##}", money).Replace(',', '.');
    }
    public static string FormatMoney(object money)
    {
        return string.Format("{0:#,###.##}", money).Replace(',', '.');
    }
    public static string FormatMoney2(Double money)
    {
        string result = string.Empty;
        int t = (int)money;
        if (money == 0)
        {
            return "0";
        }
        if ((Double)t == money)
        {
            result = string.Format("{0:#,###.##}", money);
        }
        else
        {
            result = string.Format("{0:#,###.##}", money);
        }
        return result;
    }
    public static string FormatMoney3(int? money)
    {
        if (money != null)
        {
            if (money != 0)
            {
                return string.Format("{0:#,###.##}", money).Replace(',', '.');
            }
            else
            {
                return "0";
            }
        }
        else
        {
            return "";
        }
    }
    public static string FormatMoney4(double? money)
    {
        if (money != null)
        {
            if (money != 0)
            {
                return string.Format("{0:#,###.##}", money).Replace(',', '.');
            }
            else
            {
                return "0";
            }   
        }
        else
        {
            return "0";
        }
    }
    public static string FormatMoney8(double? money)
    {
        if (money != null)
        {
            if (money != 0)
            {
                return string.Format("{0:#,###.##}", money).Replace(',', '.');
            }
            else
            {
                return "0";
            }  
        }
        else
        {
            return "0";
        }
    }
    public static string FormatMoney5(object money)
    {
        if (money != null)
        {
            if (!string.IsNullOrEmpty(string.Format("{0:#,###.##}", money).Replace(',', '.')))
            {
                return string.Format("{0:#,###.##}", money).Replace(',', '.');
            }
            else
            {
                return "0";
            }
        }
        else
        {
            return " ";
        }
    }
    public static string FormatMoney6(double? money)
    {
        if (money != null)
        {
            if (money != 0)
            {
                return string.Format("{0:#,###.##}", money).Replace(',', '.');
            }
            else
            {
                return "0";
            }
        }
        else
        {
            return "0";
        }
    }
    public static string FormatMoney7(int? money)
    {
        if (money != null)
        {
            if (money != 0)
            {
                return string.Format("{0:#,###.##}", money).Replace(',', '.');
            }
            else
            {
                return "0";
            }
        }
        else
        {
            return "0";
        }
    }
}
