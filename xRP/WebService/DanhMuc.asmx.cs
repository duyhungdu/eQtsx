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

    public class DanhMuc : System.Web.Services.WebService
    {
        [WebMethod]
        public string GetDanhSachPhuongAnLsx(int yeucausanxuatId, int? lenhsanxuatchitietId)
        {
            xRPDataContext dts = new xRPDataContext();
            var listPhuongAn = dts.Sp_Qlsx_PhuongAnSanXuat_Select(yeucausanxuatId, lenhsanxuatchitietId);
            return new JavaScriptSerializer().Serialize(listPhuongAn);
        }
        [WebMethod]
        public string GetDanhSachPhuongAnVatTuToiUuLsx(int yeucausanxuatId, int? lenhsanxuatchitietId)
        {
            xRPDataContext dts = new xRPDataContext();
            var listPhuongAn = dts.Sp_Qlsx_PhuongAnSanXuat_Select_2(yeucausanxuatId, lenhsanxuatchitietId);
            return new JavaScriptSerializer().Serialize(listPhuongAn);
        }


        [WebMethod]
        public string GetDanhSachPhuongAn(int id_yc_sx)
        {
            xRPDataContext dts = new xRPDataContext();
            var listPhuongAn = dts.Sp_Qlsx_PhuongAnSanXuat_Select(id_yc_sx, 0);
            return new JavaScriptSerializer().Serialize(listPhuongAn);

        }
        [WebMethod]
        public string GetDanhSachPhuongAnVatTuToiUu(int yeuCauSanXuatId)
        {
            xRPDataContext dts = new xRPDataContext();
            var listPhuongAn = dts.Sp_Qlsx_PhuongAnSanXuat_Select_2(yeuCauSanXuatId, 0);
            return new JavaScriptSerializer().Serialize(listPhuongAn);

        }
        [WebMethod]
        public string GetJSonKhoGiayByIDVatTu(int id)
        {
            xRPDataContext dts = new xRPDataContext();

            try
            {
                var abc = dts.Sp_Qlvt_VatTu_Select(2, id, null, "", null).FirstOrDefault().KichThuocVatTu.Value.ToString();
                return abc;
            }
            catch
            {
                return "0";
            }
        }
        /// <summary>
        /// Select danh mục Nhà cung cấp (JSON)
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public string GetJSONDataNhaCungCapForAutoComplete()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                List<object> list = new List<object>();
                foreach (var vt in dts.Qlvt_NhaCungCaps)
                {
                    list.Add(new
                    {
                        data = vt.ID,
                        value = vt.MaHieuNhaCungCap.Trim() + " - " + vt.TenNhaCungCap,
                        ID = vt.ID
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
        public string GetJSONDataNhaCungCap(int ID)
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                var x = dts.Sp_Qlvt_NhaCungCap_Select(1, ID, null, null, (int?)null, (int?)null);
                data = new JavaScriptSerializer().Serialize(x);
            }
            catch (Exception ex)
            {
                data = "{error:\"" + ex.Message + "\"}";
            }
            return data;
        }

        /// <summary>
        /// Select danh mục Kho vật tư (JSON)
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public string GetJSONDataKhoVatTuForAutoComplete()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                //sua lai dung select
                List<object> list = new List<object>();
                var x = dts.Sp_Qlvt_KhoVatTu_Select(0, (int?)null, null, (bool?)null, 0, 1);
                foreach (var vt in x)
                {
                    list.Add(new
                    {
                        data = vt.ID,
                        value = vt.MaHieuKho.Trim() + " - " + vt.TenKhoVatTu
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

        /// <summary>
        /// Select kho theo NVL or Thành phẩm
        /// 0 là NVL, 1 là Thành phẩm
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public string GetJSONDataKhoVatTuNVLorThanhPhamForAutoComplete(int TYPE)
        {
            xRPDataContext dts = new xRPDataContext();
            bool isTP = false;
            if (TYPE == 1)
            {
                isTP = false;
            }
            else
            {
                isTP = true;
            }
            string data = "[]";
            try
            {
                //sua lai dung select
                List<object> list = new List<object>();
                var x = dts.Sp_Qlvt_KhoVatTu_Select(0, (int?)null, null, isTP, 0, 1);
                foreach (var vt in x)
                {
                    list.Add(new
                    {
                        data = vt.ID,
                        value = vt.MaHieuKho.Trim() + " - " + vt.TenKhoVatTu
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
        public string GetJSONDataKhoVatTuXuatForAutoComplete()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                //sua lai dung select
                List<object> list = new List<object>();
                var x = dts.Sp_Qlvt_KhoVatTu_Select(0, (int?)null, null, (bool?)null, 0, 1);
                foreach (var vt in x)
                {
                    list.Add(new
                    {
                        data = vt.ID,
                        value = vt.MaHieuKho.Trim() + " - " + vt.TenKhoVatTu
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

        /// <summary>
        /// Select vật tư theo MaHieu
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public string GetJSONDataVatTuByMaHieuForAutoComplete()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                List<object> list = new List<object>();
                foreach (var vt in dts.Sp_Qlvt_VatTu_Select(0, (int?)null, (int?)null, null, (int?)null))
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




        /// <summary>
        /// Select vật tư theo Ten
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public string GetJSONDataVatTuTheoKichThuocByTenForAutoComplete(int? idLoaiGiay, string khoGiay)
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                int? idkhoGiay = null;
                try
                {
                    idkhoGiay = int.Parse(khoGiay);
                }
                catch (Exception ex) { }

                List<object> list = new List<object>();
                foreach (var vt in dts.Sp_Qlvt_VatTu_Theo_KichThuoc_Select(1, idLoaiGiay, idkhoGiay, 0))
                {
                    list.Add(new
                    {
                        data = vt.MaHieuVatTu,
                        value = vt.MaHieuVatTu.Trim() + " - " + vt.TenVatTu,
                        DonViTinh = vt.DonViTinh,
                        DinhLuong = vt.DinhLuong,
                        ID = vt.ID,
                        IDDonViTinh = vt.IDDonViTinh,
                        SoLuongTon = vt.SoLuongTon
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


        /// <summary>
        /// Select vật tư theo Ten
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public string GetJSONDataVatTuDapUngByTenForAutoComplete(int? yeuCauSanXuatId, int? soLuongCanSanXuat, int? idLoaiGiay, string loaiPhuongAn, int? lenhSanXuatChiTietID)
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {

                List<object> list = new List<object>();
                foreach (var vt in dts.Sp_Qlvt_VatTu_DapUng_Select(yeuCauSanXuatId, soLuongCanSanXuat, idLoaiGiay, loaiPhuongAn, lenhSanXuatChiTietID))
                {
                    list.Add(new
                    {
                        data = vt.MaHieuVatTu,
                        value = vt.MaHieuVatTu.Trim() + " - " + vt.TenVatTu,
                        DonViTinh = vt.DonViTinh,
                        DinhLuong = vt.DinhLuong,
                        ID = vt.ID,
                        IDDonViTinh = vt.IDDonViTinh,
                        SoLuongTon = vt.SoLuongTon
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


        /// <summary>
        /// Select vật tư theo Ten
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public string GetJSONDataVatTuByTenForAutoComplete()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                List<object> list = new List<object>();
                foreach (var vt in dts.Sp_Qlvt_VatTu_Select(0, (int?)null, (int?)null, null, 0))
                {
                    list.Add(new
                    {
                        data = vt.MaHieuVatTu,
                        value = vt.MaHieuVatTu.Trim() + " - " + vt.TenVatTu,
                        DonViTinh = vt.DonViTinh,
                        DinhLuong = vt.DinhLuong,
                        ID = vt.ID,
                        IDDonViTinh = vt.IDDonViTinh,
                        SoLuongTon = vt.SoLuongTon
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

        /// <summary>
        /// Select vật tư theo Ten and Nhà cung cấp
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public string GetJSONDataVatTuByTenAndNhaCungCapForAutoComplete(int nhaCungCapID)
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                List<object> list = new List<object>();
                foreach (var vt in dts.Sp_Qlvt_VatTu_Select(0, (int?)null, (int?)null, null, 0))
                {
                    list.Add(new
                    {
                        data = vt.MaHieuVatTu,
                        value = vt.MaHieuVatTu.Trim() + " - " + vt.TenVatTu
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
        /// <summary>
        /// Select vật tư theo Kho
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public string GetJSONDataVatTuByKhoForAutoComplete(int maKho)
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                List<object> list = new List<object>();
                foreach (var vt in dts.Sp_Qlvt_VatTuNhap_Select(3, (int?)null, (int?)null, maKho, 0))
                {
                    list.Add(new
                    {
                        data = vt.MaHieuVatTu,
                        value = vt.MaHieuVatTu.Trim() + " - " + vt.TenVatTu + " (" + vt.MaCuon + "-" + vt.SoLuongConLai + ")", //(Tồn: " + vt.SoLuongConLai + ")",
                        textvalue = vt.MaHieuVatTu.Trim() + " - " + vt.TenVatTu + " (" + vt.MaCuon + "-" + vt.SoLuongConLai + ")",// (Tồn: " + vt.SoLuongConLai + ")",
                        dinhluongthucte = vt.DinhLuongThucTe,
                        kichthuocthucte = vt.KichThuocThucTe,
                        soLuongDauCuon = vt.SoLuongDauCuon,
                        soLuongConLai = vt.SoLuongConLai,
                        SoLuongTon = vt.SoLuongTon,
                        soLuongTonToiThieu = vt.SoLuongTonToiThieu,
                        ID = vt.ID

                        // join voi bang Qlvt_VatTu.SoLuongTonToiThieu
                        //, Qlvt_VatTu.SoLuongTon,Qlvt_VatTuNhap.SoLuongDauCuon,  Qlvt_VatTu.SoLuongTonToiThieu
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
        /// <summary>
        /// Select vật tư theo phieu yeu cau va kho
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public string GetJSONDataVatTuByPYCForAutoComplete(int id, int maKho)
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                List<object> list = new List<object>();
                var ds = dts.Qlvt_VaTu_PhieuYeuCauVatTu_Select(id);
                foreach (var vt in ds)
                {
                    list.Add(new
                    {
                        data = vt.MaHieuVatTu,
                        value = vt.MaHieuVatTu.Trim() + " - " + vt.TenVatTu + " (" + vt.MaCuon + "-" + vt.SoLuongConLai + ")", //(Tồn: " + vt.SoLuongConLai + ")",
                        textvalue = vt.MaHieuVatTu.Trim() + " - " + vt.TenVatTu + " (" + vt.MaCuon + "-" + vt.SoLuongConLai + ")",// (Tồn: " + vt.SoLuongConLai + ")",
                        dinhluongthucte = vt.DinhLuongThucTe,
                        kichthuocthucte = vt.KichThuocThucTe,
                        soLuongDauCuon = vt.SoLuongDauCuon,
                        soLuongConLai = vt.SoLuongConLai,
                        SoLuongTon = vt.SoLuongTon,
                        soLuongTonToiThieu = vt.SoLuongTonToiThieu,
                        ID = vt.ID
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
        /// <summary>
        /// Select toàn bộ vật tư
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public string GetJSONDataVatTu()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                List<object> list = new List<object>();
                foreach (var vt in dts.Sp_Qlvt_VatTu_Select(0, (int?)null, (int?)null, null, 0))
                {
                    list.Add(new
                    {
                        ID = vt.ID,
                        MaVatTu = vt.MaHieuVatTu,
                        TenVatTu = vt.TenVatTu,
                        DonViTinh = vt.DonViTinh,
                        DonViTinhID = vt.IDDonViTinh,
                        DinhLuongTieuChuan = vt.DinhLuong,
                        KichThuocTieuChuan = vt.KichThuocVatTu,
                        SoLuongConLai = vt.SoLuongTon
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
        public string GetJSONDataAllVatTu()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                List<object> list = new List<object>();
                foreach (var vt in dts.Sp_Qlvt_VatTu_Select(0, (int?)null, (int?)null, null, 0))
                {
                    list.Add(new
                    {
                        data = vt.ID,
                        value = vt.MaHieuVatTu + " - " + vt.TenVatTu
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
        /// <summary>
        /// Select toàn bộ vật tư
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public string GetJSONDataVatTuNhap()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                List<object> list = new List<object>();
                foreach (var vt in dts.Sp_Qlvt_VatTuNhap_Select(0, (int?)null, (int?)null, (int?)null, 0))
                {
                    list.Add(new
                    {
                        ID = vt.ID,
                        MaVatTu = vt.MaHieuVatTu,
                        TenVatTu = vt.TenVatTu,
                        IDDonViTinh = vt.IDDonViTinh,
                        DonViTinh = vt.DonViTinh,
                        DinhLuongThucTe = vt.DinhLuongThucTe,
                        KichThuocThucTe = vt.KichThuocThucTe,
                        DinhLuongTieuChuan = vt.DinhLuongTieuChuan,
                        KichThuocTieuChuan = vt.KichThuocTieuChuan,
                        SoLuongDauCuon = vt.SoLuongDauCuon,
                        MaCuon = vt.MaCuon,
                        SoLuongConLai = vt.SoLuongConLai,
                        MaHieuVatTu = vt.MaHieuVatTu1,
                        TruLoi = vt.TruLoi,
                        ChenhLechDinhLuong = vt.ChenhLechDinhLuong,
                        DinhLuongTinhTru = vt.DinhLuongTinhTru,
                        TruThuaKichThuoc = vt.TruThuaKichThuoc,
                        KhoiLuongTru = vt.KhoiLuongTru,
                        SoLuongChenhLech = vt.SoLuongChenhLechKhongTinh
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

        /// <summary>
        /// Select toàn bộ đơn vị
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public string GetJSONDataDonVi()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                List<object> list = new List<object>();
                foreach (var vt in dts.Sys_DanhMucDonVis)
                {
                    list.Add(new
                    {
                        data = vt.ID,
                        value = vt.MaHieuDonVi + " - " + vt.TenDonVi
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

        /// <summary>
        /// Select Khách hàng theo tính chất nhập xuất
        /// </summary>
        /// <param name="idTinhChat"></param>
        /// <returns></returns>
        [WebMethod]
        public string GetJSONKhachHangByTinhChatNhapXuat(int idTinhChat)
        {
            xRPDataContext dts = new xRPDataContext();
            Sp_Qlvt_TinhChatNhapXuat_SelectResult tcnx = dts.Sp_Qlvt_TinhChatNhapXuat_Select(1, idTinhChat, (int?)null, (int?)null).FirstOrDefault();
            string data = "[]";
            try
            {
                List<object> list = new List<object>();
                if (tcnx != null)
                {
                    if (tcnx.NoiBo.Value)
                    {
                        foreach (var vt in dts.Sys_DanhMucDonVis)
                        {
                            list.Add(new
                            {
                                data = vt.ID,
                                value = (vt.MaHieuDonVi == null ? "" : (vt.MaHieuDonVi.Trim() + " - ")) + vt.TenDonVi
                            });
                        }
                    }
                    else if (tcnx.TenTinhChatNhapXuat == "Xuất trả lại")
                    {
                        foreach (var vt in dts.Sp_Qlvt_NhaCungCap_Select(0, (int?)null, null, null, 0, 1))
                        {
                            list.Add(new
                            {
                                data = vt.ID,
                                value = (vt.MaHieuNhaCungCap == null ? "" : (vt.MaHieuNhaCungCap.Trim() + " - ")) + vt.TenNhaCungCap
                            });
                        }
                    }
                    else
                    {
                        foreach (var vt in dts.Sp_Qldh_KhachHang_Select(0, (int?)null, 0, 1, ""))
                        {
                            list.Add(new
                            {
                                data = vt.ID,
                                value = (vt.MaHieuKhachHang == null ? "" : (vt.MaHieuKhachHang.Trim() + " - ")) + vt.TenKhachHang
                            });
                        }
                    }
                }


                data = new JavaScriptSerializer().Serialize(list);
            }
            catch (Exception ex)
            {
                data = "{error:\"" + ex.Message + ":" + ex.StackTrace + "\"}";
            }
            return data;
        }

        /// <summary>
        /// Select Khách hàng theo tính chất nhập xuất
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public string GetJSONKhachHangForAutoComplete()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {

                List<object> list = new List<object>();
                foreach (var vt in dts.Sp_Qldh_KhachHang_Select(0, (int?)null, 0, 1, ""))
                {
                    list.Add(new
                    {
                        data = vt.ID,
                        value = vt.MaHieuKhachHang.Trim() + " - " + vt.TenKhachHang
                    });
                }

                data = new JavaScriptSerializer().Serialize(list);
            }
            catch (Exception ex)
            {
                data = "{error:\"" + ex.Message + ":" + ex.StackTrace + "\"}";
            }
            return data;
        }

        /// <summary>
        /// Select Khách hàng theo tính chất nhập xuất
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public string GetJSONKhachHang()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                data = new JavaScriptSerializer().Serialize(dts.Sp_Qldh_KhachHang_Select(0, (int?)null, 0, 1, ""));
            }
            catch (Exception ex)
            {
                data = "{error:\"" + ex.Message + ":" + ex.StackTrace + "\"}";
            }
            return data;
        }

        [WebMethod]
        public string GetJSONDataHangHoaByCodeForAutoComplete()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                List<object> list = new List<object>();
                foreach (var vt in dts.Sp_Qldh_MatHang_Select(0, (int?)null, (int?)null, (int?)null, (int?)null, ""))
                {
                    list.Add(new
                    {
                        data = vt.TenMatHang,
                        value = vt.MaHieuMatHang.Trim(),
                        IDMatHang = vt.ID
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
        public string GetListMatHangAutoSuggestSource()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                List<object> list = new List<object>();
                foreach (var vt in dts.Sp_Qldh_MatHang_Select_2())
                {
                    list.Add(new
                    {
                        data = vt.ID,
                        value = vt.TenMatHang
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
        public string GetJSONDataHangHoaByNameForAutoComplete()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                List<object> list = new List<object>();
                var mhs = dts.Sp_Qldh_MatHang_Select_1(null);

                //foreach (var vt in dts.Sp_Qldh_MatHang_Select(0, (int?)null, (int?)null, (int?)null, (int?)null))
                foreach (var vt in mhs)
                {
                    list.Add(new
                    {
                        data = vt.MaHieuMatHang.Trim(),
                        value = vt.TenMatHang + " - " + vt.MaHieuMatHang.Trim(),
                        IDMatHang = vt.ID
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
        public string GetJSONDataHangHoaByNameForSuggestion(string filter)
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                List<object> list = new List<object>();
                filter = filter.Trim().ToLower();
                var mhs = (from t in dts.Sp_Qldh_MatHang_Select_1(null)
                           where ((t.MaHieuMatHang == null ? "" : t.MaHieuMatHang.Trim().ToLower()) + " " + (t.TenMatHang == null ? "" : t.TenMatHang.Trim().ToLower())).Contains(filter)
                           select t);

                foreach (var vt in mhs)
                {
                    list.Add(new
                    {
                        data = vt.MaHieuMatHang == null ? "" : vt.MaHieuMatHang.Trim(),
                        value = (vt.TenMatHang == null ? "" : vt.TenMatHang.Trim()) + " - " + (vt.MaHieuMatHang == null ? "" : vt.MaHieuMatHang.Trim()),
                        IDMatHang = vt.ID
                    });
                }
                data = new JavaScriptSerializer().Serialize(list);
            }
            catch (Exception ex)
            {
                data = "{error:\"" + ex.Message + "\" \n " + ex.StackTrace + "}";
            }
            return data;
        }

        [WebMethod]
        public string GetJSONDataHangHoa()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                var list = dts.Sp_Qldh_MatHang_Select(0, (int?)null, (int?)null, (int?)null, (int?)null, "");
                data = new JavaScriptSerializer().Serialize(list);
            }
            catch (Exception ex)
            {
                data = "{error:\"" + ex.Message + "\"}";
            }
            return data;
        }

        [WebMethod]
        public string GetJSONDataHangHoaByID(int ID)
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                var list = dts.Sp_Qldh_MatHang_Select_1(null).FirstOrDefault(t => t.ID == ID);
                if (list == null) return data;
                data = new JavaScriptSerializer().Serialize(list);
            }
            catch (Exception ex)
            {
                data = "{error:\"" + ex.Message + "\"}";
            }
            return data;
        }

        [WebMethod]
        public string GetJSONDataDonViTinhForAutoComplete()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                List<object> list = new List<object>();
                foreach (var vt in dts.Sp_Qlvt_DonViTinh_Select(0, (int?)null, (int?)null, (int?)null, ""))
                {
                    list.Add(new
                    {
                        data = vt.ID,
                        value = vt.DonViTinh
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
        public string GetJSONDataSongTheoMatHang(int IDMatHang)
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "";
            try
            {
                data = new JavaScriptSerializer().Serialize(dts.Sp_Qldh_MatHangTheoSong_Select(0, (int?)null, 0, 1).Where(t => t.IDMatHang == IDMatHang));
            }
            catch (Exception ex)
            {
                data = "{error:\"" + ex.Message + "\"}";
            }
            return data;
        }

        [WebMethod]
        public string GetJSONDataSongByIDArray(int[] ID)
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "";
            try
            {
                data = new JavaScriptSerializer().Serialize(dts.Sp_Qldh_DanhMucSong_Select(0, (int?)null, 0, 1, "").Where(t => ID.Contains(t.ID)));
            }
            catch (Exception ex)
            {
                data = "{error:\"" + ex.Message + "\"}";
            }
            return data;
        }
        [WebMethod]
        public string GetJSONDataDanhMucSongForAutoComplete()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                List<object> list = new List<object>();
                foreach (var vt in dts.Sp_Qldh_DanhMucSong_Select(0, (int?)null, 0, 1, ""))
                {
                    list.Add(new
                    {
                        data = vt.ID,
                        value = vt.TenSong
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
        public string GetJSONDataCongDoan()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "";
            try
            {
                data = new JavaScriptSerializer().Serialize(dts.Sp_Qlsx_CongDoan_Select(0, (int?)null, 0, 1, ""));
            }
            catch (Exception ex)
            {
                data = "{error:\"" + ex.Message + "\"}";
            }
            return data;
        }
        [WebMethod]
        public string GetJSONDataCongDoanForAutoComplete()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                List<object> list = new List<object>();
                foreach (var vt in dts.Sp_Qlsx_CongDoan_Select(0, (int?)null, (int?)null, (int?)null, ""))
                {
                    list.Add(new
                    {
                        data = vt.ID,
                        value = vt.TenCongDoan,
                        MaHieuCongDoan = vt.MaHieuCongDoan
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
        public string GetJSONDataCongDoanTheoSong(int LoaiSong)
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "";
            try
            {
                data = new JavaScriptSerializer().Serialize(dts.Sp_Qlsx_CoCauGiayTheoSong_Select(2, (int?)null, (int?)null, (int?)null, null, LoaiSong, 0, ""));
            }
            catch (Exception ex)
            {
                data = "{error:\"" + ex.Message + "\"}";
            }
            return data;
        }


        [WebMethod]
        public string GetJSONDataMatHangByID(int? matHangId)
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                List<object> list = new List<object>();
                foreach (var vt in dts.Sp_Qldh_MatHang_Select(1, matHangId, null, null, null, ""))
                {
                    list.Add(new
                    {
                        data = vt.ID,
                        value = vt.TenMatHang,
                        chieudai = vt.ChieuDai,
                        chieurong = vt.ChieuRong,
                        chieucao = vt.ChieuCao,
                        solop = vt.SoLop,
                        soluong = vt.SoLuong,
                        loaisanpham = dts.Sp_Qldh_LoaiSanPham_Select(1, vt.IDLoaiSanPham, null, null, "").FirstOrDefault().TenLoaiSanPham,
                        loaikichthuoc = dts.Sp_Qldh_LoaiKichThuoc_Select(1, vt.IDLoaiKichThuoc, null, null, "").FirstOrDefault().LoaiKichThuoc
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
        public string GetJSONDataDinhMucVatTu(int? matHangId, int? lenhSanXuatChiTietId, int? yeuCauSanXuatId)
        {
            using (xRPDataContext dts = new xRPDataContext())
            {
                //yeuCauSanXuatId
                var matHang = dts.Sp_Qldh_MatHang_Select(1, matHangId, (int?)null, 0, 1, "").FirstOrDefault();

                //Nếu không tồn tại mặt hàng hoặc không tồn tại cơ cấu giấy theo sóng.
                if (matHang == null || (matHang != null && matHang.IDLoaiSongSanXuat < 0))
                    return new JavaScriptSerializer().Serialize(new List<Sp_Qlsx_DinhMucVatTu_SelectResult>());

                var dataCoCauGiay = dts.Sp_Qlsx_CoCauGiayTheoSong_Select(2, (int?)null, (int?)null, (int?)null, null, matHang.IDLoaiSongSanXuat.HasValue ? matHang.IDLoaiSongSanXuat.Value : 0, 0, "").ToList();
                //if (lenhSanXuatChiTietId != 0)
                //{ 

                var dataDinhMucVatTu = dts.Sp_Qlsx_DinhMucVatTu_Select(2, (int?)null, lenhSanXuatChiTietId, (int?)null, (int?)null).ToList();

                //Qlsx_CoCauGiayTheoSong.ID = Qlsx_DinhMucVatTu.IDPhatSinhTieuHao

                var initData = (from c in dataDinhMucVatTu
                                join d in dataCoCauGiay on c.IDPhatSinhTieuHaoVatTu equals d.ID
                                select new Sp_Qlsx_DinhMucVatTu_SelectResult
                                {
                                    TT = c.TT,
                                    ID = c.ID,
                                    IDLenhSanXuatChiTiet = c.IDLenhSanXuatChiTiet,
                                    IDPhatSinhTieuHaoVatTu = c.IDPhatSinhTieuHaoVatTu,
                                    IDVatTu = c.IDVatTu,
                                    IDDonViTinh = c.IDDonViTinh,
                                    HeSoTieuHao = c.HeSoTieuHao,
                                    SoLuong = c.SoLuong,
                                    SoLuongYeuCau = c.SoLuongYeuCau,
                                    DonViTinh = c.DonViTinh,
                                    TenLop = c.TenLop,
                                    DinhLuong = c.DinhLuong,
                                    TenLoaiVatTu = c.TenLoaiVatTu,
                                    MaHieuVatTu = c.MaHieuVatTu,
                                    TenVatTu = c.TenVatTu,
                                    IDLoaiGiay = d.IDLoaiGiay
                                    //ChatDai = matHang.ChatDai,
                                    //SoLuongTam = matHang.SoLuongTam

                                }).ToList();

                var filterData = (from c in dataCoCauGiay
                                  where !dataDinhMucVatTu.Any(d => d.IDPhatSinhTieuHaoVatTu == c.ID)
                                  select new Sp_Qlsx_DinhMucVatTu_SelectResult
                                  {
                                      TT = c.TT,
                                      ID = 0,
                                      IDLenhSanXuatChiTiet = lenhSanXuatChiTietId,
                                      IDPhatSinhTieuHaoVatTu = c.ID,
                                      IDVatTu = 0,
                                      IDDonViTinh = 0,
                                      HeSoTieuHao = c.HeSoTieuHao,
                                      SoLuong = 0,
                                      SoLuongYeuCau = 0,
                                      DonViTinh = "",
                                      TenLop = c.TenLop,
                                      DinhLuong = 0,
                                      TenLoaiVatTu = c.TenLoaiVatTu,
                                      MaHieuVatTu = "",
                                      TenVatTu = "",
                                      IDLoaiGiay = c.IDLoaiGiay
                                      //ChatDai = matHang.ChatDai,
                                      //SoLuongTam = matHang.SoLuongTam

                                  }).ToList();

                initData.AddRange(filterData);
                initData = initData.OrderBy(p => p.IDPhatSinhTieuHaoVatTu).Distinct().ToList();

                string data = new JavaScriptSerializer().Serialize(initData);
                return data;

            }
        }


        [WebMethod]
        public string GetJSONDataHeSoTongDao()
        {
            xRPDataContext dts = new xRPDataContext();
            return new JavaScriptSerializer().Serialize(dts.Sp_Qldh_HeSoTongDao_Select(0, (int?)null, (int?)null, (int?)null, ""));
        }

        [WebMethod]
        public string GetJSONDataHeSoChatDai()
        {
            xRPDataContext dts = new xRPDataContext();
            return new JavaScriptSerializer().Serialize(dts.Sp_Qldh_LoaiKichThuoc_Select(0, (int?)null, (int?)null, (int?)null, ""));
        }

        /// <summary>
        /// phamkhuong102
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public string GetJSONPhanLoaiSongForAutoComplete()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                //sua lai dung select
                List<object> list = new List<object>();

                var x = dts.Sp_Qlsx_PhanLoaiSong_Select(0, null, null, null, null, "").ToList();
                foreach (var vt in x)
                {
                    list.Add(new
                    {
                        data = vt.ID,
                        value = vt.KiHieuCoCauGiay.Trim(),
                        KyHieuQuyDoi = vt.KiHieuQuyDoi.Trim(),
                        SoLop = vt.SoLop
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
        public string GetJSONPhanLoaiSongForSearch()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                //sua lai dung select
                List<object> list = new List<object>();

                var x = dts.Sp_Qlsx_PhanLoaiSong_Select(0, null, null, null, null, "").ToList();
                foreach (var vt in x)
                {
                    list.Add(new
                    {
                        data = vt.ID,
                        value = vt.KiHieuCoCauGiay + " - " + vt.KiHieuQuyDoi + " - " + vt.MoTaCoCauGiay.Trim(),
                        KyHieuQuyDoi = vt.KiHieuQuyDoi.Trim()
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
        public string GetJSONPhanLoaiSongForAutoComplete_KyHieu()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                //sua lai dung select
                List<object> list = new List<object>();

                var x = dts.Sp_Qlsx_PhanLoaiSong_Select(0, null, null, null, null, "").ToList();
                foreach (var vt in x)
                {
                    list.Add(new
                    {
                        data = vt.ID,
                        value = vt.KiHieuCoCauGiay.Trim() + "-" + vt.MoTaCoCauGiay.Trim(),
                        solop = vt.SoLop,
                        kyhieucocaugiay = vt.KiHieuCoCauGiay.Trim()
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
        public string GetJSONTenLopGiayForAutoComplete()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                //sua lai dung select
                List<object> list = new List<object>();
                var x = dts.Sp_Qlsx_TenLopGiay_Select(0, null, null, null).ToList();
                foreach (var vt in x)
                {
                    list.Add(new
                    {
                        data = vt.ID,
                        value = vt.TenLop.Trim()
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
        public string GetJSONDataPhieuYeuCau()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                //sua lai dung select
                List<object> list = new List<object>();
                var x = dts.Sp_Qlsx_PhieuYeuCauVatTu_Select(4, null, null, null, null, null, 0).ToList();
                foreach (var vt in x)
                {
                    list.Add(new
                    {
                        data = vt.ID.ToString(),
                        value = vt.ID.ToString() + " - " + vt.NgayTao.Value.ToString("dd/MM/yyyy")
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
        public string GetJSONDataPhieuYeuCau2()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                //sua lai dung select
                List<object> list = new List<object>();
                var x = dts.Sp_Qlsx_PhieuYeuCauVatTu_Select(4, null, null, null, null, null, 0).ToList();
                foreach (var vt in x)
                {
                    list.Add(new
                    {
                        data = vt.ID.ToString(),
                        value = vt.MaHieuPhieuYeuCau.ToString() + " - " + vt.NgayTao.Value.ToString("dd/MM/yyyy")
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
        public string GetPhieuYeuCauVatTuChiTiet(int? phieuYeuCauVatTuId)
        {
            xRPDataContext dts = new xRPDataContext();
            var data = dts.Sp_Qlsx_PhieuYeuCauVatTuChiTiet_Select(1, phieuYeuCauVatTuId, null);
            return new JavaScriptSerializer().Serialize(data);
        }

        [WebMethod]
        public string GetJSONDataPhieuNhapForAutoComplete()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                List<object> list = new List<object>();
                foreach (var vt in dts.Sp_Qlvt_PhieuNhap_Select(0, (int?)null, (int?)null, null, null, null, null, (int?)null, null, null, null, null, null))
                {
                    list.Add(new
                    {
                        data = vt.ID,
                        value = vt.MaHieuPhieuNhap
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
        public string GetJSONDataPhieuXuatForAutoComplete()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                List<object> list = new List<object>();
                foreach (var vt in dts.Sp_Qlvt_PhieuXuat_Select(0, (int?)null, (int?)null, (int?)null, null, null, null, null, null))
                {
                    list.Add(new
                    {
                        data = vt.ID,
                        value = vt.MaHieuPhieuXUAT
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
        public string GetJSONDataMatHangThanhPhamForAutoComplete()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                List<object> list = new List<object>();
                foreach (var vt in dts.Sp_Qldh_MatHang_Select_2())
                {
                    //var vt = dts.Sp_Qldh_MatHang_Select(1, vt1.ID, null, null, null, null).FirstOrDefault();
                    //var loaisanpham = dts.Sp_Qldh_LoaiSanPham_Select(1, vt.IDLoaiSanPham, null, null, "").FirstOrDefault();
                    //var loaikichthuoc = dts.Sp_Qldh_LoaiKichThuoc_Select(1, vt.IDLoaiKichThuoc, null, null, "").FirstOrDefault();
                    //var donvitinh = dts.Sp_Qlvt_DonViTinh_Select(1, vt.IDDonVitinh, null, null, "").FirstOrDefault();

                    list.Add(new
                    {
                        data = vt.ID,
                        value = vt.MaHieuMatHang + " - " + vt.TenMatHang,
                        mahieumathang = vt.MaHieuMatHang
                        //chieudai = vt.ChieuDai,
                        //chieurong = vt.ChieuRong,
                        //chieucao = vt.ChieuCao,
                        //solop = vt.SoLop,
                        //loaisanpham = loaisanpham != null ? loaisanpham.TenLoaiSanPham : "",
                        //loaikichthuoc = loaikichthuoc != null ? loaikichthuoc.LoaiKichThuoc : "",
                        //donvitinhid = vt.IDDonVitinh,
                        //donvitinh = donvitinh != null ? donvitinh.DonViTinh : ""
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
        public string GetJSONDataMatHangForAutoComplete()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                List<object> list = new List<object>();

                foreach (var vt in dts.Sp_Qldh_MatHang_Select_2())
                {

                    list.Add(new
                    {
                        data = vt.ID,
                        value = vt.MaHieuMatHang + " - " + vt.TenMatHang,
                        mahieumathang = vt.MaHieuMatHang
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
        public string GetJSONDataMatHangForAutoCompleteWithTon()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                List<object> list = new List<object>();

                foreach (var vt in dts.Sp_Qldh_MatHang_Select_2())
                {

                    list.Add(new
                    {
                        data = vt.ID,
                        value = vt.MaHieuMatHang + " - " + vt.TenMatHang + " - (Tồn: " + vt.SoLuongTon + ")",
                        mahieumathang = vt.MaHieuMatHang
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
        public string GetJSONDataMatHangForAutoCompleteByID(int Id)
        {
            xRPDataContext dts = new xRPDataContext();
            string dataJson = "[]";
            try
            {
                List<object> list = new List<object>();
                var vt = dts.Sp_Qldh_MatHang_Select(1, Id, null, null, null, null).FirstOrDefault();
                var loaisanpham = dts.Sp_Qldh_LoaiSanPham_Select(1, vt.IDLoaiSanPham, null, null, "").FirstOrDefault();
                var loaikichthuoc = dts.Sp_Qldh_LoaiKichThuoc_Select(1, vt.IDLoaiKichThuoc, null, null, "").FirstOrDefault();
                var donvitinh = dts.Sp_Qlvt_DonViTinh_Select(1, vt.IDDonVitinh, null, null, "").FirstOrDefault();
                var data = new
                    {
                        data = vt.ID,
                        value = vt.TenMatHang,
                        chieudai = vt.ChieuDai,
                        chieurong = vt.ChieuRong,
                        chieucao = vt.ChieuCao,
                        solop = vt.SoLop,
                        loaisanpham = loaisanpham != null ? loaisanpham.TenLoaiSanPham : "",
                        loaikichthuoc = loaikichthuoc != null ? loaikichthuoc.LoaiKichThuoc : "",
                        donvitinhid = vt.IDDonVitinh,
                        donvitinh = donvitinh != null ? donvitinh.DonViTinh : "",
                        soluongton = vt.SoLuongTon
                    };

                dataJson = new JavaScriptSerializer().Serialize(data);
            }
            catch (Exception ex)
            {
                dataJson = "{error:\"" + ex.Message + "\"}";
            }
            return dataJson;
        }


        [WebMethod]
        public string GetJSONDataLoaiVatTuForAutoComplete()
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                List<object> list = new List<object>();
                foreach (var vt in dts.Sp_Qlvt_LoaiVatTu_Select(0, null, null, null, null, ""))
                {
                    list.Add(new
                    {
                        data = vt.ID,
                        value = vt.TenLoaiVatTu,
                        mahieu = vt.MaHieuLoaiVatTu
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
        public double GetTruLoi(int idVatTu, double kichThuoc)
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                var vattu = dts.Sp_Qlvt_VatTu_Select(2, idVatTu, null, null, null).FirstOrDefault();
                if (vattu == null) return 0;
                return dts.fc_TruLoi(vattu.MaHieuLoaiVatTu, kichThuoc).Value;
            }
            catch (Exception ex)
            {
                data = "{error:\"" + ex.Message + "\"}";
            }
            return 0;
        }

        [WebMethod]
        public double GetKhoGiay(double tongdao, int? idloaigiay)
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                //if (!idloaigiay.HasValue)
                idloaigiay = 0;
                var khogiay = dts.Fc_LayKhoGiayPhuHop(tongdao, idloaigiay);
                if (!khogiay.HasValue) return 0;
                return khogiay.Value;
            }
            catch (Exception ex)
            {
                data = "{error:\"" + ex.Message + "\"}";
            }
            return 0;
        }
        [WebMethod]
        public string GetJSONDataDonHangForAutoComplete(int maKhachHang)
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                List<object> list = new List<object>();
                foreach (var dh in dts.Sp_Qldh_DonHang_Select(2, null, maKhachHang, null, null, null, null, null, null))
                {
                    list.Add(new
                    {
                        data = dh.ID,
                        value = dh.MaHieuDonHang
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
        public string GetJSONDataDonHangByKhachHangForAutoComplete(int maKhachHang)
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                List<object> list = new List<object>();
                if (maKhachHang == 0)
                {
                    foreach (var dh in dts.Sp_Qldh_DonHang_Select(2, null, null, null, 0, null, null, null, null))
                    {
                        list.Add(new
                        {
                            data = dh.ID,
                            value = dh.MaHieuDonHang
                        });
                    }
                }
                else
                {
                    foreach (var dh in dts.Sp_Qldh_DonHang_Select(2, null, maKhachHang, null, null, null, null, null, null))
                    {
                        list.Add(new
                        {
                            data = dh.ID,
                            value = dh.MaHieuDonHang
                        });
                    }
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
        public string GetJSONDataYeuCauSanXuatForAutoComplete(int? congDoan, int? khachHangId, int? donHangId)
        {
            xRPDataContext dts = new xRPDataContext();
            string data = "[]";
            try
            {
                List<object> list = new List<object>();
                foreach (var ycsx in dts.Sp_Qlsx_YeuCauSanXuat_Select(2, null, congDoan, null, khachHangId, donHangId, 0, 0).ToList())
                {
                    list.Add(new
                    {
                        data = ycsx.ID,
                        value = ycsx.MaHieuMatHang + " - " + ycsx.TenMatHang + " - " + ycsx.TenKhachHang + " - " + ycsx.MaHieuDonHang,
                        mahieudonhang = ycsx.MaHieuDonHang,
                        mahieumathang = ycsx.MaHieuMatHang,
                        kttam = ycsx.KTTam,
                        solop = ycsx.SoLop,
                        tongdao = ycsx.TongDao,
                        chatdai = ycsx.ChatDai,
                        soluongtam = ycsx.SoLuongTam,
                        soluonghop = ycsx.SoLuongHop,
                        soluong = ycsx.SoLuong,
                        tenmathang = ycsx.TenMatHang,
                        kichthuoc = ycsx.KichThuoc,
                        khogiay = ycsx.KhoGiay,
                        soluongconlaicansanxuat = ycsx.SoLuongConLaiCanSanXuat
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
        public string SinhMaPhieu(int maTinhChat, string tenBang) {
            using (xRPDataContext dts = new xRPDataContext()) {
                var tc = dts.Qlvt_TinhChatNhapXuats.Where(t => t.ID == maTinhChat).FirstOrDefault();
                if (tc != null)
                    return dts.fc_SinhMa(tc.MaTinhChatNhapXuat, tenBang);
                else return "";
            }
        }
    }
}
