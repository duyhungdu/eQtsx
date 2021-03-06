﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xRPDAL;
using xRPRepository;


namespace xRP.Administrator.QuanLyHeThong.ChucVu
{
    public partial class List : System.Web.UI.UserControl
    {
        public string trang { get; set; }
        public int StartIndex { get; set; }
        int pageSize = 20;
        int pageIndex = 1;
        string keyword = string.Empty;

        public string RootPageUrl = "/Administrator/QuanLyHeThong/";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["trang"] != null)
            {
                trang = Request.QueryString["trang"].ToString();
            }
            if (string.IsNullOrEmpty(trang))
            {
                trang = "1";
            }

            if (Request.QueryString["s"] != null)
            {
                keyword = Request.QueryString["s"].ToString();
            }

            txtTimKiem.Text = keyword;


            int.TryParse(trang, out pageIndex);
            StartIndex = pageSize * (pageIndex - 1);

            Sys_DanhMucChucVuRepository repository = new Sys_DanhMucChucVuRepository();
            List<Sys_DanhMucChucVu> data = repository.GetTable().Where(x => string.IsNullOrEmpty(keyword) || x.TenChucVu.Contains(keyword)).OrderByDescending(x => x.NgayThayDoi).ToList();

            CollectionPager1.MaxPages = 10000;
            CollectionPager1.PageSize = 10; // số items hiển thị trên một trang.
            CollectionPager1.DataSource = data;
            CollectionPager1.BindToControl = rptData;
            rptData.DataSource = CollectionPager1.DataSourcePaged;
            rptData.DataBind();
        }


        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect(Request.RawUrl);
        }

        protected void btTimKiem_Click(object sender, EventArgs e)
        {

        }
    }
}