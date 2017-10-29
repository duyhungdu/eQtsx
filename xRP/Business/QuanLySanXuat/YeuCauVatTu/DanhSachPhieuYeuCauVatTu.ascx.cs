using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;
using xRPRepository;

namespace xRP.Business.QuanLySanXuat.YeuCauVatTu
{
    public partial class DanhSachPhieuYeuCauVatTu : System.Web.UI.UserControl
    {
        protected Qlsx_PhieuYeuCauVatTuRepository phieuYeuCauVatTuRepository = new Qlsx_PhieuYeuCauVatTuRepository();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData(0, null, null, null, null, null, null);
            }
        }

        public void BindData(int? type, int? id, string maHieuThamChieu, int? donViYeuCau, DateTime? ngaySuDungTu, DateTime? ngaySuDungDen, int? tinhtrang)
        {
            var listPhieuYeuCauVatTu = phieuYeuCauVatTuRepository.GetDanhSachPhieuYeuCauVatTu(type, id, maHieuThamChieu, donViYeuCau, ngaySuDungTu, ngaySuDungDen, tinhtrang);
            colPage.MaxPages = 10000;
            colPage.PageSize = 10; // số items hiển thị trên một trang.
            colPage.DataSource = listPhieuYeuCauVatTu;
            colPage.BindToControl = rptPhieuYeuCauVatTu;
            rptPhieuYeuCauVatTu.DataSource = colPage.DataSourcePaged;
            rptPhieuYeuCauVatTu.DataBind();
        }
    }
}