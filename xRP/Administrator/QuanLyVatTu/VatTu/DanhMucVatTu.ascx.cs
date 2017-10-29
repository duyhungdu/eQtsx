using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;
using xRPRepository;
namespace xRP.Administrator.QuanLyVatTu.VatTu
{
    public partial class DanhMucVatTu : System.Web.UI.UserControl
    {
        Qlvt_VatTuRepository vattuRepository = new Qlvt_VatTuRepository();
        protected void Page_Load(object sender, EventArgs e)
        {

            BindDanhMucVatTu();
            if (Request.QueryString["cbtk"] != null)
            {
                if (Request.QueryString["cbtk"].ToString() == "1")
                {
                    chkCanhBaoTonKho.Checked = true;
                }
                else
                {
                    chkCanhBaoTonKho.Checked = false;
                }
            }
            else
            {
                chkCanhBaoTonKho.Checked = false;
            }
            searchbox.Text = Request.QueryString["key"] != null ? Request.QueryString["key"].ToString() : "";
        }
        protected void BindDanhMucVatTu()
        {
            List<Sp_Qlvt_VatTu_SelectResult> listVatTu = new List<Sp_Qlvt_VatTu_SelectResult>();
           
            if (Request.QueryString["cbtk"].ToString() == "1")
            {
                if (!string.IsNullOrEmpty(Request.QueryString["key"]!=null?Request.QueryString["key"].ToString():""))
                {
                    var key = Request.QueryString["key"] != null ? Request.QueryString["key"].ToString() : "";
                    listVatTu = vattuRepository.SearchVatTu3(key);
                }
                else
                {
                    listVatTu = vattuRepository.GetAllVatTu(3, null, null, 0);
                }
            }
            else
            {
                if (!string.IsNullOrEmpty(Request.QueryString["key"] != null ? Request.QueryString["key"].ToString() : ""))
                {
                    var key = Request.QueryString["key"] != null ? Request.QueryString["key"].ToString() : "";
                    listVatTu = vattuRepository.SearchVatTu(key);
                }
                else
                {
                    listVatTu = vattuRepository.GetAllVatTu(0, null, null, 0);
                }
            }
            foreach (Sp_Qlvt_VatTu_SelectResult vattu in listVatTu)
            {
                if (vattu.SoLuongTon <= vattu.SoLuongTonToiThieu)
                {
                   
                    vattu.GhiChu = "canh_bao_ton";
                }
                else
                {
                    vattu.GhiChu = "";
                }
            }
            CollectionPager1.MaxPages = 10000;
            CollectionPager1.PageSize = 10;
            CollectionPager1.DataSource = listVatTu;
            CollectionPager1.BindToControl = rptDanhMucVatTu;
            rptDanhMucVatTu.DataSource = CollectionPager1.DataSourcePaged;
            rptDanhMucVatTu.DataBind();

        }

        protected void btnSeach_Click(object sender, EventArgs e)
        {
            if (chkCanhBaoTonKho.Checked)
            {
                Response.Redirect(Util.SERVER_NAME+"/Administrator/QuanLyVatTu/VatTu/default.aspx?page=dmvt&cbtk=1&key="+searchbox.Text);
            }
            else
            {
                Response.Redirect(Util.SERVER_NAME+"/Administrator/QuanLyVatTu/VatTu/default.aspx?page=dmvt&cbtk=0&key=" + searchbox.Text);
            }
        }


    }
}