using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using xRPDAL;

namespace xRP.Security
{
    public static class Permission
    {

        public enum FunctionRedirect { success = 0, login = 1, role = 2, func = 3 };

        /// <summary>
        /// Quyền quản trị cao nhất
        /// </summary>
        public static readonly string SYSTEM_ADMIN = "SystemAdmin";
        public static FunctionRedirect CheckRedirect(string url)
        {
            xRPDataContext dts = new xRPDataContext();
            var dataUser = (from u in dts.aspnet_Users where u.UserName == HttpContext.Current.User.Identity.Name select u).FirstOrDefault();
            //AddFunction();
            if (dataUser != null)
            {
                if (dataUser.UserName == "admin" ||
                    (from r in dts.aspnet_Roles
                     join rf in dts.Sys_NguoiDungQuyens on r.RoleId equals rf.RoleId
                     where rf.UserId == dataUser.UserId && r.Code.Equals("APPADMIN")
                     select r).Count() > 0)
                    return FunctionRedirect.success;

                if (url.IndexOf("&") > 0)
                    url = url.Substring(0, url.IndexOf("&"));
                var lsfunction = dts.Sys_Functions.Where(p => p.Xoa == false && p.Href.ToLower().Equals(url.ToLower().Trim()));
                if (lsfunction.Count() > 0)
                {
                    var dataUsersRoleFunction = (from f in lsfunction
                                                 join rf in dts.Sys_QuyenTheoChucNangs.Where(p => p.Xoa == false) on f.ID equals rf.FunctionID
                                                 join r in dts.Sys_NguoiDungQuyens on rf.RoleID equals r.RoleId
                                                 where r.UserId == dataUser.UserId
                                                 select new
                                                 {
                                                     RoleId = r.RoleId,
                                                     Href = f.Href
                                                 }).ToList();

                    //-- User -> Group -> Role -> Function                
                    var dataUsersGroupRoleFunction = (from f in lsfunction
                                                      join rf in dts.Sys_QuyenTheoChucNangs.Where(p => p.Xoa == false) on f.ID equals rf.FunctionID
                                                      join rg in dts.Sys_QuyenTheoNhoms on rf.RoleID equals rg.RoleID
                                                      join g in dts.Sys_NguoiDungNhoms on rg.IDDanhMucNhom equals g.GroupID
                                                      where g.UserId == dataUser.UserId
                                                      select new
                                                      {
                                                          RoleId = rg.RoleID,
                                                          Href = f.Href
                                                      }).ToList();
                    if (dataUsersRoleFunction.Count() > 0 || dataUsersGroupRoleFunction.Count() > 0)
                        return FunctionRedirect.success;

                    else
                        return FunctionRedirect.func;
                }
                else return FunctionRedirect.func;
            }
            else
                return FunctionRedirect.login;
        }
        public static void AddFunction()
        {
            xRPDataContext dts = new xRPDataContext();

            var strPage = new List<Sys_Function>() { 

                #region Quản lý vật tư
                new Sys_Function(){
                    Ma = "pktn".ToLower(),
                    TenChucNang="Phiếu kiểm tra vật tư nhập",
                    ParentID = 1,
                    Href = "/Business/QuanLyVatTu/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },
              
                new Sys_Function(){
                    Ma = "aoepktn".ToLower(),
                    TenChucNang="Thêm, sửa phiếu kiểm tra vật tư nhập",
                    ParentID = 1,
                    Href = "/Business/QuanLyVatTu/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },

                new Sys_Function(){
                    Ma = "kcsvtn".ToLower(),
                    TenChucNang="KCS vật tư nhập",
                    ParentID = 1,
                    Href = "/Business/QuanLyVatTu/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },

                new Sys_Function(){
                    Ma = "vdktn".ToLower(),
                    TenChucNang="Chi tiết phiếu kiểm tra vật tư nhập",
                    ParentID = 1,
                    Href = "/Business/QuanLyVatTu/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                }, 
                
                new Sys_Function(){
                    Ma = "pktx".ToLower(),
                    TenChucNang="Phiếu kiểm tra vật tư xuất",
                    ParentID = 1,
                    Href = "/Business/QuanLyVatTu/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },
              
                new Sys_Function(){
                    Ma = "aoepktx".ToLower(),
                    TenChucNang="Thêm, sửa phiếu kiểm tra vật tư xuất",
                    ParentID = 1,
                    Href = "/Business/QuanLyVatTu/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },

                new Sys_Function(){
                    Ma = "kcsvtx".ToLower(),
                    TenChucNang="KCS vật tư xuất",
                    ParentID = 1,
                    Href = "/Business/QuanLyVatTu/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },

                new Sys_Function(){
                    Ma = "vdktx".ToLower(),
                    TenChucNang="Chi tiết phiếu kiểm tra vật tư xuất",
                    ParentID = 1,
                    Href = "/Business/QuanLyVatTu/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },

                new Sys_Function(){
                    Ma = "ppn".ToLower(),
                    TenChucNang="In phiếu nhập",
                    ParentID = 1,
                    Href = "/Business/QuanLyVatTu/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },

                new Sys_Function(){
                    Ma = "ppx".ToLower(),
                    TenChucNang="In phiếu xuất",
                    ParentID = 1,
                    Href = "/Business/QuanLyVatTu/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },
                
                new Sys_Function(){
                    Ma = "bcnxtvt".ToLower(),
                    TenChucNang="Báo cáo xuất nhập tồn",
                    ParentID = 1,
                    Href = "/Business/QuanLyVatTu/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },

                new Sys_Function(){
                    Ma = "bckdkcs".ToLower(),
                    TenChucNang="Báo cáo không đạt KCS",
                    ParentID = 1,
                    Href = "/Business/QuanLyVatTu/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },

                new Sys_Function(){
                    Ma = "ntp".ToLower(),
                    TenChucNang="Danh sách thành phẩm",
                    ParentID = 1,
                    Href = "/Business/QuanLyVatTu/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },

                new Sys_Function(){
                    Ma = "cnntp".ToLower(),
                    TenChucNang="Cập nhật phiếu nhập thành phẩm",
                    ParentID = 1,
                    Href = "/Business/QuanLyVatTu/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },

                new Sys_Function(){
                    Ma = "ppntp".ToLower(),
                    TenChucNang="In phiếu nhập thành phẩm",
                    ParentID = 1,
                    Href = "/Business/QuanLyVatTu/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },

                new Sys_Function(){
                    Ma = "xtp".ToLower(),
                    TenChucNang="Danh sách thành phẩm xuất",
                    ParentID = 1,
                    Href = "/Business/QuanLyVatTu/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },

                new Sys_Function(){
                    Ma = "cnxtp".ToLower(),
                    TenChucNang="Cập nhật phiếu xuất thành phẩm",
                    ParentID = 1,
                    Href = "/Business/QuanLyVatTu/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },
                new Sys_Function(){
                    Ma = "ppxtp".ToLower(),
                    TenChucNang="In phiếu xuất thành phẩm",
                    ParentID = 1,
                    Href = "/Business/QuanLyVatTu/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                }, 
                new Sys_Function(){
                    Ma = "bcnxttp".ToLower(),
                    TenChucNang="Báo cáo nhập xuất tồn",
                    ParentID = 1,
                    Href = "/Business/QuanLyVatTu/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },         
               
                new Sys_Function(){
                    Ma = "tcnx".ToLower(),
                    TenChucNang="Danh sách tính chất nhập xuất",
                    ParentID = 1,
                    Href = "/Administrator/QuanLyVatTu/TinhChatXuatNhap/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },   
                new Sys_Function(){
                    Ma = "dmvt".ToLower(),
                    TenChucNang="Danh mục vật tư",
                    ParentID = 1,
                    Href = "/Administrator/QuanLyVatTu/VatTu/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },     
                new Sys_Function(){
                    Ma = "loaivt".ToLower(),
                    TenChucNang="Danh mục loại vật tư",
                    ParentID = 1,
                    Href = "/Administrator/QuanLyVatTu/LoaiVatTu/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },     
                new Sys_Function(){
                    Ma = "dsnhacungcap".ToLower(),
                    TenChucNang="Danh mục nhà cung cấp",
                    ParentID = 1,
                    Href = "/Administrator/QuanLyVatTu/NhaCungCap/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },     
                new Sys_Function(){
                    Ma = "dskho".ToLower(),
                    TenChucNang="Danh mục kho",
                    ParentID = 1,
                    Href = "/Administrator/QuanLyVatTu/Kho/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },     
                new Sys_Function(){
                    Ma = "dmdvt".ToLower(),
                    TenChucNang="Danh mục vật tư",
                    ParentID = 1,
                    Href = "/Administrator/QuanLyVatTu/DonViTinh/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },     
             
                #endregion
                #region Quản lý bán hàng
               
                 new Sys_Function(){
                    Ma = "dmsong".ToLower(),
                    TenChucNang="Danh mục sóng",
                    ParentID = 2,
                    Href = "/Administrator/QuanLyDonHang/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },
                new Sys_Function(){
                    Ma = "dmnkh".ToLower(),
                    TenChucNang="Danh mục nhóm khách hàng",
                    ParentID = 2,
                    Href = "/Administrator/QuanLyDonHang/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },
                new Sys_Function(){
                    Ma = "dmlsp".ToLower(),
                    TenChucNang="Danh mục loại sản phẩm",
                    ParentID = 2,
                    Href = "/Administrator/QuanLyDonHang/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },
                new Sys_Function(){
                    Ma = "dmkt".ToLower(),
                    TenChucNang="Danh mục kích thước",
                    ParentID = 2,
                    Href = "/Administrator/QuanLyDonHang/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },
                new Sys_Function(){
                    Ma = "dmkh".ToLower(),
                    TenChucNang="Danh mục khách hàng",
                    ParentID = 2,
                    Href = "/Administrator/QuanLyDonHang/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },
                new Sys_Function(){
                    Ma = "hstg".ToLower(),
                    TenChucNang="Hệ số tổng dao",
                    ParentID = 2,
                    Href = "/Administrator/QuanLyDonHang/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },
                new Sys_Function(){
                    Ma = "ppdathhang".ToLower(),
                    TenChucNang="Phiếu đặt hàng",
                    ParentID = 2,
                    Href = "/Administrator/QuanLyDonHang/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },
                new Sys_Function(){
                    Ma = "bcghsx".ToLower(),
                    TenChucNang="Báo cáo sản xuất - giao hàng",
                    ParentID = 2,
                    Href = "/Administrator/QuanLyDonHang/Default.aspx?page=bcghsx",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },
                new Sys_Function(){
                    Ma = "dsmathang".ToLower(),
                    TenChucNang="Danh sách mặt hàng",
                    ParentID = 2,
                    Href = "/Administrator/QuanLyDonHang/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },
                new Sys_Function(){
                    Ma = "dsdonhang".ToLower(),
                    TenChucNang="Danh sách đơn hàng",
                    ParentID = 2,
                    Href = "/Administrator/QuanLyDonHang/DonHang/default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },
                new Sys_Function(){
                    Ma = "addoreditdonhang".ToLower(),
                    TenChucNang="Thêm mới chỉnh sửa đơn hàng",
                    ParentID = 2,
                    Href = "/Administrator/QuanLyDonHang/DonHang/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },
                #endregion
                #region Quản lý sản xuất
                new Sys_Function(){
                    Ma = "cd".ToLower(),
                    TenChucNang="Danh sách công đoạn",
                    ParentID = 3,
                    Href = "/Business/QuanLySanXuat/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },
            
                new Sys_Function(){
                    Ma = "cdaoe".ToLower(),
                    TenChucNang="Thêm, sửa công đoạn",
                    ParentID = 3,
                    Href = "/Business/QuanLySanXuat/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },

                new Sys_Function(){
                    Ma = "cd".ToLower(),
                    TenChucNang="Danh sách nguồn lực",
                    ParentID = 3,
                    Href = "/Business/QuanLySanXuat/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },
            
                new Sys_Function(){
                    Ma = "nglaoe".ToLower(),
                    TenChucNang="Thêm, sửa nguồn lực",
                    ParentID = 3,
                    Href = "/Business/QuanLySanXuat/Default.aspx?page=" ,
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },

                new Sys_Function(){
                    Ma = "ccg".ToLower(),
                    TenChucNang="Danh sách cơ cấu giấy",
                    ParentID = 3,
                    Href = "/Business/QuanLySanXuat/Default.aspx?page=",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },
            
                new Sys_Function(){
                    Ma = "ccgaoe".ToLower(),
                    TenChucNang="Thêm, sửa cơ cấu giấy",
                    ParentID = 3,
                    Href = "/Business/QuanLySanXuat/Default.aspx?page=" ,
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },

                new Sys_Function(){
                    Ma = "pls".ToLower(),
                    TenChucNang="Danh sách phân loại sóng",
                    ParentID = 3,
                    Href = "/Business/QuanLySanXuat/Default.aspx?page=" ,
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },
            
                new Sys_Function(){
                    Ma = "plsaoe".ToLower(),
                    TenChucNang="Thêm, sửa phân loại sóng",
                    ParentID = 3,
                    Href = "/Business/QuanLySanXuat/Default.aspx?page=" ,
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },

                new Sys_Function(){
                    Ma = "lg".ToLower(),
                    TenChucNang="Danh sách lớp giấy",
                    ParentID = 3,
                    Href = "/Business/QuanLySanXuat/Default.aspx?page=" ,
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },
            
                new Sys_Function(){
                    Ma = "lgaoe".ToLower(),
                    TenChucNang="Thêm, sửa lớp giấy",
                    ParentID = 3,
                    Href = "/Business/QuanLySanXuat/Default.aspx?page=" ,
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },

                new Sys_Function(){
                    Ma = "lsx".ToLower(),
                    TenChucNang="Danh sách lệnh sản xuất",
                    ParentID = 3,
                    Href = "/Business/QuanLySanXuat/Default.aspx?page=" ,
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },
            
                new Sys_Function(){
                    Ma = "tlsx".ToLower(),
                    TenChucNang="Tạo lệnh sản xuất",
                    ParentID = 3,
                    Href = "/Business/QuanLySanXuat/Default.aspx?page=" ,
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },

                
                new Sys_Function(){
                    Ma = "dsycsx".ToLower(),
                    TenChucNang="Danh sách yêu cầu vật sản xuất",
                    ParentID = 3,
                    Href = "/Business/QuanLySanXuat/Default.aspx?page=" ,
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },


                new Sys_Function(){
                    Ma = "pycvt".ToLower(),
                    TenChucNang="Phiếu yêu cầu vật tư",
                    ParentID = 3,
                    Href = "/Business/QuanLySanXuat/Default.aspx?page=" ,
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                }, 

                new Sys_Function(){
                    Ma = "inpycvt".ToLower(),
                    TenChucNang="In phiếu yêu cầu vật tư",
                    ParentID = 3,
                    Href = "/Business/QuanLySanXuat/Default.aspx?page=" ,
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                }, 
            
                new Sys_Function(){
                    Ma = "bcsx".ToLower(),
                    TenChucNang="Báo cáo sản xuất",
                    ParentID = 3,
                    Href = "/Business/QuanLySanXuat/Default.aspx?page=" ,
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                }, 

                 new Sys_Function(){
                    Ma = "cnlsx".ToLower(),
                    TenChucNang="Cập nhật lệnh sản xuất",
                    ParentID = 3,
                    Href = "/Business/QuanLySanXuat/Default.aspx?page=" ,
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                }, 


                 new Sys_Function(){
                    Ma = "plsx".ToLower(),
                    TenChucNang="In Lệnh sản xuất",
                    ParentID = 3,
                    Href = "/Business/QuanLySanXuat/Default.aspx?page=" ,
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },
                
                
                new Sys_Function(){
                    Ma = "pavt".ToLower(),
                    TenChucNang="Phương án vật tư",
                    ParentID = 3,
                    Href = "/Business/QuanLySanXuat/Default.aspx?page=" ,
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                }, 

                new Sys_Function(){
                    Ma = "dh".ToLower(),
                    TenChucNang="Danh sách đơn hàng",
                    ParentID = 3,
                    Href = "/Business/QuanLySanXuat/Default.aspx?page=" ,
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                }, 

                new Sys_Function(){
                    Ma = "xldh".ToLower(),
                    TenChucNang="Xử lý đơn hàng",
                    ParentID = 3,
                    Href = "/Business/QuanLySanXuat/Default.aspx?page=" ,
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                }, 

                new Sys_Function(){
                    Ma = "cdsx".ToLower(),
                    TenChucNang="Công đoạn sản xuất",
                    ParentID = 3,
                    Href = "/Business/QuanLySanXuat/Default.aspx?page=" ,
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                }, 

                new Sys_Function(){
                    Ma = "cccg".ToLower(),
                    TenChucNang="Chọn cơ cấu giấy",
                    ParentID = 3,
                    Href = "/Business/QuanLySanXuat/Default.aspx?page=" ,
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                }, 

                
                new Sys_Function(){
                    Ma = "dmvattu".ToLower(),
                    TenChucNang="Định mức vật tư",
                    ParentID = 3,
                    Href = "/Business/QuanLySanXuat/Default.aspx?page=" ,
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },
                #endregion Quản lý sản xuất
                #region Trang chủ
                new Sys_Function(){
                    Ma = "homepage".ToLower(),
                    TenChucNang="Trang chủ",
                    ParentID = 0,
                    Href = "/Default.aspx",
                    PhanHeID = 1,
                    Position = -1,
                    ThuTu = 1
                },    
                #endregion Trang chủ
            };
            foreach (var item in strPage)
            {
                if (item.Href.Contains("?page=")) item.Href = item.Href + item.Ma.ToLower();
                var lsfunction = dts.Sys_Functions.FirstOrDefault(p => p.Ma.ToLower().Equals(item.Ma) || p.Href.ToLower().Trim().Equals(item.Href.ToLower().Trim()));
                if (lsfunction == null)
                {
                    item.Icon = "";
                    item.NgayTao = DateTime.Now;
                    item.MaNguoiTao = new Guid("454c9136-8086-4f6d-babb-2357cea54a2e");
                    item.MaNguoiThayDoi = new Guid("454c9136-8086-4f6d-babb-2357cea54a2e");
                    item.NgayThayDoi = DateTime.Now;
                    item.Position = -1;
                    item.Xoa = false;
                    dts.Sys_Functions.InsertOnSubmit(item);
                    dts.SubmitChanges();
                }
            }
        }
    }
}