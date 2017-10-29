
/**
 * Phieu xuat object
 */

function PhieuXuat(data) {
    this.data = {
        ID: 0,
        MaHieuPhieuXuat: "",
        NgayXuat: "",
        MaDonViNhan: 0,
        MaKhoVatTu: 0,
        KieuVatTu: 1,
        MaTinhChatNhapXuat: 0,
        MaKhoVatTuDen: 0,
        TinhTrang: 0,
        GhiChu: ""
    };
    this.dataChiTiet = [];
    if (data) {
        $.extend(this.data, data);
        if (this.data.itemID) {
            this.data.itemID = parseInt(this.data.itemID);
        } else
            this.data.itemID = 0;
    }
}
PhieuXuat.prototype = {
    constructor: PhieuXuat,
    markDelete: function () {
        if (!this.data) {
            alert("Dữ liệu lỗi.")
            return;
        }
        if (!confirm("Bạn có thực sự muốn xóa phiếu xuất này không?")) return;
        var $this = this;
        $("*").bind("click", disableClickEvent);// disable click event
        $.ajax({
            type: "POST",
            url: "Default.aspx/DeletePhieuXuat",
            data: JSON.stringify($this.data),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                $("*").unbind("click", disableClickEvent); // enable click event
            },
            success: function (result) {
                if (result.d == "SUCCESS") {
                    window.location.reload(true);
                } else {
                    alert("Có lỗi trong quá trình xử lý\n" + result.d);
                    $("*").unbind("click", disableClickEvent); // enable click event
                }
            }
        });
    },
    duyetPhieuXuatThanhPham: function () {
        if (!this.data) {
            alert("Dữ liệu lỗi.")
            return;
        }
        if (!confirm("Bạn có thực sự muốn duyệt phiếu xuất này không?")) return;
        var $this = this;
        $.ajax({
            type: "POST",
            url: "Default.aspx/DuyetPhieuXuatThanhPham",
            data: JSON.stringify($this.data),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (result) {
                if (result.d == "SUCCESS") {
                    window.location.reload(true);
                } else {
                    alert(result.d);
                    window.location.reload(true);
                }
            }
        });
    },
    duyetPhieuXuat: function () {
        if (!this.data) {
            alert("Dữ liệu lỗi.")
            return;
        }
        if (!confirm("Bạn có thực sự muốn duyệt phiếu xuất này không?")) return;
        var $this = this;
        $("*").bind("click", disableClickEvent);// disable click event
        $.ajax({
            type: "POST",
            url: "Default.aspx/DuyetPhieuXuat",
            data: JSON.stringify($this.data),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                $("*").unbind("click", disableClickEvent); // enable click event
            },
            success: function (result) {
                if (result.d == "SUCCESS") {
                    window.location.reload(true);
                } else {
                    alert(result.d);
                    window.location.reload(true);
                }
            }
        });
    },
    save: function (onComplete) {
        var $this = this;
        $("*").bind("click", disableClickEvent);// disable click event
        $.ajax({
            type: "POST",
            url: "Default.aspx/AddOrUpdatePhieuXuat",
            data: JSON.stringify(this.data),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                if (onComplete)
                    onComplete({ d: "Có lỗi trong quá trình xử lý: " + errorThrown });
                $("*").unbind("click", disableClickEvent); // enable click event
            },
            success: function (result) {
                onComplete(result);
                $("*").unbind("click", disableClickEvent); // enable click event
            }
        });
    }, getChiTietPhieuXuat: function (onSuccess) {
        if (this.data.itemID != 0) {
            var $this = this;
            queryData("Default.aspx/GetVatTuXuat", "{idPhieuXuat:" + $this.data.itemID + "}", function (result) {
                onSuccess(JSON.parse(result.d));
            });
        }
    },
    //getChiTietThanhPhamXuat: function (onSuccess) {
    //    if (this.data.itemID != 0) {
    //        var $this = this;
    //        queryData("Default.aspx/GetThanhPhamXuat", "{idPhieuXuat:" + $this.data.itemID + "}", function (result) {
    //            onSuccess(JSON.parse(result.d));
    //        });
    //    } 
    //},
    getChiTietThanhPhamXuat: function (onSuccess) {
        var data = [];
        if (this.data.itemID != 0) {
            var $this = this;
            queryData("Default.aspx/GetThanhPhamXuat", "{idPhieuXuat:" + $this.data.itemID + "}", function (result) {
                var returnDataObject = JSON.parse(result.d);
                for (var i = 0; i < returnDataObject.length; i++) {
                    data.push(new XuatThanhPham(returnDataObject[i]));
                }
                if (onSuccess)
                    onSuccess(returnDataObject);
            }, null, false);
        }
        return data;
    }
}

VatTuXuat = function (data) {
    this.data = {
        ID: 0,
        MaVatTuNhap: 0, //IDVatTuNhap
        MaHieuVatTu: "", //Ma hieu vat tu nhap
        TenVatTu: "",
        MaPhieuXuat: 0,
        MaKhoVatTu: 0,
        SoLuongDauCuonBanDau: 0,
        SoLuongDauCuonHienTai: 0,
        SoLuongTonTheoCuon: 0, //So luong con lai
        SoLuongLamPhieuXuat: 0,
        SoLuongConLaiCuoiNgay: 0,
        KichThuocTieuChuan: 0,
        DinhLuongTieuChuan: 0,
        KichThuocThucTe: 0,
        DinhLuongThucTe: 0,
        ChenhLechDinhLuong: 0,
        DinhLuongTinhTru: 0,
        TruThuaKichThuoc: 0,
        KhoiLuongTru: 0,
        TruLoi: 0,
        Loi: 0,
        SoLuongChenhLechKhongTinh: 0,
        SoLuongThucXuat: 0,
        IDDonViTinh: 0,
        DonGia: 0,
        ThanhTien: 0,
        GhiChu: "",
        KieuVatTu: null
    };
    if (data) {
        for (var i = 0; i < data.length; i++) {
            var newObj = {};
            $.each(data[i], function (name, value) {
                newObj[name] = (!value ? undefined : value);
            });
            data[i] = newObj;
        }
        $.extend(true, this.data, data);
        if (this.data.itemID) {
            this.data.itemID = parseInt(this.data.itemID);
        } else
            this.data.itemID = 0;
    } else
        this.data.itemID = 0;
    this.data.RandomID = generateUUID();
    $this = this;
    $(this).on("DataChanged", function (evt) {
        if (evt.fieldName == "MaHieuVatTu")
            $this.getThongTinVatTu();
    });
    //$this.getThongTinVatTuByID();
}

VatTuXuat.prototype = {
    constructor: VatTuXuat,
    save: function (onComplete) {
        if (!this.data) {
            alert("Dữ liệu lỗi.")
            return;
        }
        var $this = this;
        $.ajax({
            type: "POST",
            url: "Default.aspx/AddOrUpdateVatTuXuat",
            data: JSON.stringify($this.data),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                if (onComplete)
                    onComplete({ d: "Có lỗi trong quá trình xử lý: " + errorThrown });
            },
            success: function (result) {
                if (result.d == "SUCCESS") {
                    if (onComplete)
                        onComplete(result);
                } else {
                    if (!$.isNumeric(result.d)) {
                        alert(result.d);
                    }
                }
            }
        });
    },
    markDelete: function () {
        if (!this.data) {
            alert("Dữ liệu lỗi.")
            return;
        }
        var $this = this;
        $.ajax({
            type: "POST",
            url: "Default.aspx/DeleteChiTietVatTuXuat",
            data: JSON.stringify($this.data),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (result) {
                if (result.d == "SUCCESS") {
                    window.location.reload(true);
                } else {
                    alert("Có lỗi trong quá trình xử lý\n" + result.d);
                }
            }
        });
    },
    getThongTinVatTu: function () {
        var $this = this;
        if (this.data.MaHieuVatTu) {
            queryData("/WebService/DanhMuc.asmx/GetJSONDataVatTuNhap", "", function (result) {
                var list = $.parseJSON(result.d);
                var found = false;
                for (var i = 0; i < list.length; i++) {
                    //if (list[i].MaVatTu == $this.data.MaHieuVatTu) {
                    if (list[i].ID == $this.data.MaVatTuNhap) {
                        $this.setMaVatTu(list[i].ID);
                        $this.setTenVatTu(list[i].TenVatTu);
                        $this.setDonViTinh(list[i].DonViTinh);
                        $this.setIDDonViTinh(list[i].IDDonViTinh);
                        $this.setDinhLuongTieuChuan(list[i].DinhLuongTieuChuan);
                        $this.setKichThuocTieuChuan(list[i].KichThuocTieuChuan);
                        $this.setDinhLuongThucTe(list[i].DinhLuongThucTe);
                        $this.setKichThuocThucTe(list[i].KichThuocThucTe);
                        $this.setSoLuongDauCuonBanDau(list[i].SoLuongDauCuon);
                        $this.setSoLuongTonTheoCuon(list[i].SoLuongConLai);
                        $this.setSoLuongDauCuonHienTai(list[i].SoLuongConLai);
                        $this.setTruLoi(list[i].TruLoi);
                        $this.setChenhLechDinhLuong(list[i].ChenhLechDinhLuong);
                        $this.setDinhLuongTinhTru(list[i].DinhLuongTinhTru);
                        $this.setTruThuaKichThuoc(list[i].TruThuaKichThuoc);
                        $this.setKhoiLuongTru(list[i].KhoiLuongTru);
                        $this.setSoLuongChenhLechKhongTinh(list[i].SoLuongChenhLech);
                        found = true;
                    }
                }
                if (!found) {
                    $this.setMaVatTu(0);
                    $this.setTenVatTu("");
                    $this.setDonViTinh("");
                    $this.setIDDonViTinh(0);
                    $this.setDinhLuongTieuChuan(0);
                    $this.setKichThuocTieuChuan(0);
                    $this.setDinhLuongThucTe(0);
                    $this.setKichThuocThucTe(0);
                    $this.setSoLuongDauCuonBanDau(0);
                    $this.setSoLuongTonTheoCuon(0);
                    $this.setSoLuongDauCuonHienTai(0);
                    $this.setTruLoi(0);
                    $this.setChenhLechDinhLuong(0);
                    $this.setDinhLuongTinhTru(0);
                    $this.setTruThuaKichThuoc(0);
                    $this.setKhoiLuongTru(0);
                    $this.setSoLuongChenhLechKhongTinh(0);
                }
            });
        } else {
            $this.setMaVatTu(0);
            $this.setTenVatTu("");
            $this.setDonViTinh("");
            $this.setIDDonViTinh(0);
            $this.setDinhLuongTieuChuan(0);
            $this.setKichThuocTieuChuan(0);
            $this.setDinhLuongThucTe(0);
            $this.setSoLuongDauCuonBanDau(0);
            $this.setSoLuongTonTheoCuon(0);
            $this.setSoLuongDauCuonHienTai(0);
            $this.setKichThuocThucTe(0);
            $this.setTruLoi(0);
            $this.setChenhLechDinhLuong(0);
            $this.setDinhLuongTinhTru(0);
            $this.setTruThuaKichThuoc(0);
            $this.setKhoiLuongTru(0);
            $this.setSoLuongChenhLechKhongTinh(0);
        }
    },
    getThongTinVatTuByID: function () {
        var $this = this;
        if (this.data.MaVatTuNhap) {
            queryData("/WebService/DanhMuc.asmx/GetJSONDataVatTuNhap", "", function (result) {
                var list = $.parseJSON(result.d);
                for (var i = 0; i < list.length; i++) {
                    //if (list[i].ID == $this.data.MaVatTuNhap) {
                    //    $this.setSoLuongDauCuonBanDau(list[i].SoLuongDauCuon);
                    //    $this.setSoLuongDauCuon(list[i].SoLuongConLai);
                    //}
                    if (list[i].ID == $this.data.MaVatTuNhap) {
                        $this.setSoLuongDauCuonBanDau(list[i].SoLuongDauCuon);
                        $this.setSoLuongTonTheoCuon(list[i].SoLuongConLai);
                    }
                }
            });
        }
    },
    setValue: function (field, value, type) {
        var isValid = true;
        switch (type) {
            case "string":
                if (value || value === "")
                    this.data[field] = value.toString();
                else {
                    alert("Sai kiểu dữ liệu " + field);
                    isValid = false;
                }
                break;
            case "int":
                if (!$.isNumeric(value)) {
                    alert("Sai kiểu dữ liệu " + field);
                    isValid = false;
                } else
                    this.data[field] = parseInt(value);
                break;
            case "float":
                if (!$.isNumeric(value)) {
                    alert("Sai kiểu dữ liệu " + field);
                    isValid = false;
                } else
                    this.data[field] = parseFloat(value);
                break;
            default:
                alert("Sai kiểu dữ liệu " + field);
                isValid = false;
                break;
        }
        if (isValid)
            this.fireEvent(field, value);
        return isValid;
    },
    setMaVatTu: function (val) {
        if (this.setValue("MaVatTuNhap", val, "int")) {
        }
    },
    setTenVatTu: function (val) {
        this.setValue("TenVatTu", val, "string");
    },
    setMaHieuVatTu: function (val) {
        this.setValue("MaHieuVatTu", val, "string");
        //this.getThongTinVatTu();
        //this.calTruLoi();
    },
    setIDVatTu: function () {
        this.setValue("MaVatTuNhap", val, "int");
        this.getThongTinVatTu();
    },
    setDonViTinh: function (val) {
        this.setValue("DonViTinh", val, "string");
    },
    setIDDonViTinh: function (val) {
        this.setValue("IDDonViTinh", val, "int");
    },
    setSoLuongYeuCau: function (val) {
        this.setValue("SoLuongYeuCau", val, "float");
    },
    setDonGia: function (val) {
        var x = this.setValue("DonGia", val, "float");
        this.calThanhTien();
        return x;
    },
    setSoLuongDauCuonBanDau: function (val) {
        this.setValue("SoLuongDauCuonBanDau", val, "float");
    },
    setSoLuongDauCuonHienTai: function (val) {
        this.setValue("SoLuongDauCuonHienTai", val, "float");
    },
    setSoLuongTonTheoCuon: function (val) {
        this.setValue("SoLuongTonTheoCuon", val, "float");
    },
    setSoLuongConLaiCuoiNgay: function (val) {
        if (this.data.SoLuongTonTheoCuon + this.data.TruLoi < val) {
            alert("Số lượng xuất không thể lớn hơn số lượng tồn");
            return false;
        }
        this.setValue("SoLuongConLaiCuoiNgay", val, "float");
        this.calSoLuongThucXuat();
        return true;
    },
    setDinhLuongTieuChuan: function (val) {
        this.setValue("DinhLuongTieuChuan", val, "float");
    },
    setDinhLuongThucTe: function (val) {
        this.setValue("DinhLuongThucTe", val, "float");
    },
    setKichThuocTieuChuan: function (val) {
        this.setValue("KichThuocTieuChuan", val, "float");
    },
    setSoLuongThucXuat: function (val) {
        this.setValue("SoLuongThucXuat", val, "float");
        this.calThanhTien();
    },
    setKichThuocThucTe: function (val) {
        this.setValue("KichThuocThucTe", val, "float");
    },
    setChenhLechDinhLuong: function (val) {
        this.setValue("ChenhLechDinhLuong", val, "float");
    },
    setDinhLuongTinhTru: function (val) {
        this.setValue("DinhLuongTinhTru", val, "float");
    },
    setTruThuaKichThuoc: function (val) {
        this.setValue("TruThuaKichThuoc", val, "float");
        this.calSoLuongThucXuat();
    },
    setKhoiLuongTru: function (val) {
        this.setValue("KhoiLuongTru", val, "float");
        this.calSoLuongThucXuat();
    },
    setTruLoi: function (val) {
        this.setValue("TruLoi", val, "float");
        //this.setSoLuongDauCuon(0);
        this.calSoLuongThucXuat();
    },
    setSoLuongChenhLechKhongTinh: function (val) {
        this.setValue("SoLuongChenhLechKhongTinh", val, "float");
    },
    setThanhTien: function (val) {
        this.setValue("ThanhTien", val, "float");
    },
    setGhiChu: function (val) {
        this.setValue("GhiChu", val, "string");
    },
    fireEvent: function (field, value) {
        $(this).trigger({
            type: "DataChanged",
            fieldName: field,
            value: value
        });

    }, calSoLuongThucXuat: function (laXuatTraLai) {
        if (isXuatTraLai)
            laXuatTraLai = isXuatTraLai
        var val = 0;
        if (this.data.SoLuongConLaiCuoiNgay == 0 && laXuatTraLai) {
            val = this.data.SoLuongDauCuonHienTai;
        }
        else if (this.data.SoLuongConLaiCuoiNgay > this.data.TruLoi)
            val = this.data.SoLuongTonTheoCuon - this.data.SoLuongConLaiCuoiNgay;
        else
            val = this.data.SoLuongTonTheoCuon - this.data.TruLoi;

        var temp = (val - Math.floor(val)).toString();
        if (temp.length > 6)
            temp = temp.substring(0, 6);
        val = Math.floor(val) + parseFloat(temp);

        this.setSoLuongThucXuat(val);

        this.calThanhTien();
    }, calThanhTien: function () {
        if (this.data.DonGia && this.data.SoLuongThucXuat) {

            var val = this.data.DonGia * this.data.SoLuongThucXuat;
            var temp = (val - Math.floor(val)).toString();
            if (temp.length > 6)
                temp = temp.substring(0, 6);
            val = Math.floor(val) + parseFloat(temp);
            if (val > 0)
                this.setThanhTien(val);
            else
                this.setThanhTien(0);
        } else
            this.setThanhTien(0);
    }
}

