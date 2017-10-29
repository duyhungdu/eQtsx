using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRP.Security;
using xRPDAL;
using xRPRepository;

namespace xRP.Administrator.QuanLyVatTu.NhaCungCap
{
    public partial class DanhMucNhaCungCap : System.Web.UI.UserControl
    {
        Qlvt_NhaCungCapRepository nhaCungCapRepository = new Qlvt_NhaCungCapRepository();
        protected void Page_Load(object sender, EventArgs e)
        {
            txtTimKiem.Focus();
          
            BindData();
        }

        protected void BindData()
        {
            List<Sp_Qlvt_NhaCungCap_SelectResult> listNhaCC=null;
            if (!string.IsNullOrEmpty(txtTimKiem.Text.Trim()))
            {
                var key = txtTimKiem.Text.Trim().ToLower();
                //listNhaCC = (from t in listNhaCC where string.Concat(t.MaHieuNhaCungCap.ToLower(), t.TenNhaCungCap.ToLower(), t.DiaChi.ToLower()).Contains(key) select t).ToList();
                listNhaCC = nhaCungCapRepository.SearchNhaCungCap(key);
            }
            else {
                listNhaCC = nhaCungCapRepository.GetAllNhaCungCap(0, null, "", 0, null);
            }
            CollectionPager1.MaxPages = 10000;
            CollectionPager1.PageSize = 10;
            CollectionPager1.DataSource = listNhaCC;
            CollectionPager1.BindToControl = rptDanhMucNhaCungCap;
            rptDanhMucNhaCungCap.DataSource = CollectionPager1.DataSourcePaged;
            rptDanhMucNhaCungCap.DataBind();
        }

        protected void CheckPermisson(string username)
        {
            bool qlvt_permission = xRPMembership.IsUserInRole(username, "Quản lý vật tư");
            if (qlvt_permission)
            {
                pnlDeny.Visible = false;
            }
            else
            {
                pnlDeny.Visible = true;
                pnlForm.Visible = false;
            }
        }

        protected void btnSeach_Click(object sender, EventArgs e)
        {
            BindData();
        }
    }
}