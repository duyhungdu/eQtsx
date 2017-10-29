using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRP.Report.DataSet;
//using xRP.DataSet;
using xRPDAL;
using xRPRepository;

namespace xRP.Business.QuanLyVatTu.XuatVatTu
{
    public partial class ReportViewerXuat : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] != null)
            {
                Report.QuanLyVatTu.XuatVatTu.XtraReportXuatKho rpPhieu = new Report.QuanLyVatTu.XuatVatTu.XtraReportXuatKho(int.Parse(Request.QueryString["id"]));
                ASPxDocumentViewer1.Report = rpPhieu;
            }
        }
    }
}