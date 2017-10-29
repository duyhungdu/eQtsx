
/**
 * Phieu xuat object
 */
function LenhSanXuat(data) {
    this.data = {
        ID: 0,
        MaHieuLenhSanXuat: "",
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
LenhSanXuat.prototype = {
    constructor: LenhSanXuat,
    markDelete: function () {
        if (!this.data) {
            alert("Dữ liệu lỗi.")
            return;
        }
        if (!confirm("Bạn có thực sự muốn xóa phiếu xuất này không?")) return;
        var $this = this;
        $.ajax({
            type: "POST",
            url: "Default.aspx/DeleteLenhSanXuat",
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
    duyetLenhSanXuat: function () {
        if (!this.data) {
            alert("Dữ liệu lỗi.")
            return;
        }
        if (!confirm("Bạn có thực sự muốn duyệt phiếu xuất này không?")) return;
        var $this = this;
        $.ajax({
            type: "POST",
            url: "Default.aspx/DuyetLenhSanXuat",
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
    save: function (onComplete) {
        var $this = this;
        $.ajax({
            type: "POST",
            url: "Default.aspx/AddOrUpdateLenhSanXuat",
            data: JSON.stringify(this.data),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                if (onComplete)
                    onComplete({ d: "Có lỗi trong quá trình xử lý: " + errorThrown });
            },
            success: function (result) {
                onComplete(result);
            }
        });
    }, getChiTietLenhSanXuat: function (onSuccess) {
        if (this.data.itemID != 0) {
            var $this = this;
            queryData("Default.aspx/GetVatTuXuat", "{idPhieuXuat:" + $this.data.itemID + "}", function (result) {
                onSuccess(JSON.parse(result.d));
            });
        }
    }
}




function PhieuYeuCauVatTu(data) {
    this.data = {
        ID: 0,
        IDDonViYeuCau: 0,
        MaHieuThamChieu: "",
        NgaySuDung: "",
        TinhTrang: 0,
        NgayThayDoi: '',
        MaNguoiThayDoi: 0,
        NgayTao: '',
        MaNguoiTao: 0,
        Mota: "",
        MaNhaCungCap: 0,
        lsPhieuYeuCauVatTuChiTiet: ''
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
PhieuYeuCauVatTu.prototype = {
    constructor: PhieuYeuCauVatTu,
    markDelete: function () {
        if (!this.data) {
            alert("Dữ liệu lỗi.")
            return;
        }
        if (!confirm("Bạn có thực sự muốn xóa phiếu yêu cầu này không?")) return;
        var $this = this;

        $.ajax({
            type: "POST",
            url: "Default.aspx/DeletePhieuYeuCauVatTu",
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

    save: function (onComplete) {
        var $this = this;

        $.ajax({
            type: "POST",
            url: "Default.aspx/AddOrEditPhieuYeuCauVatTu",
            data: JSON.stringify($this.data),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                if (onComplete)
                    onComplete({ d: "Có lỗi trong quá trình xử lý: " + errorThrown });
            },
            success: function (result) {
                onComplete(result);
            }
        });
    },
    saveAndChiTiet: function (onComplete) {
        var $this = this;

        $.ajax({
            type: "POST",
            url: "Default.aspx/AddOrEditPhieuYeuCauVatTuAndChiTiet",
            data: JSON.stringify($this.data),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                if (onComplete)
                    onComplete({ d: "Có lỗi trong quá trình xử lý: " + errorThrown });
            },
            success: function (result) {
                onComplete(result);
            }
        });
    }, getPhieuYeuCauVatTuChiTiet: function (onSuccess) {

        if (this.data.itemID != 0) {
            var $this = this;
            // console.log($this.data.itemID);
            queryData("/WebService/DanhMuc.asmx/GetPhieuYeuCauVatTuChiTiet", "{ phieuYeuCauVatTuId:" + $this.data.itemID + "}", function (result) {
                onSuccess(JSON.parse(result.d));
            });
        }
    }
}

/*
 * Chi tiet phieu nhap (Vat tu nhap) data object
 */
function PhieuYeuCauVatTuChiTiet(data) {
    this.data = {
        ID: 0,
        IDPhieuYeuCauVatTu: 0,
        IDMathang: 0,
        IDVatTu: 0,
        IDDonViTinh: 0,
        SoLuongYeuCau: 0,
        MaHieuVatTu: '',
        MaHieuVatTu1: '',
        TenVatTu: "",
        DonViTinh: "",
        TinhTrang: 0,
        NguoiTao: "",
        GhiChu: "",
        RandomID: 0
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
};

PhieuYeuCauVatTuChiTiet.prototype = {
    save: function (onComplete) {
        if (this.data.itemID != this.data.ID && this.data.itemID == 0)
            this.data.itemID = this.data.ID;
        var $this = this;
        console.log(JSON.stringify($this.data));

        $.ajax({
            type: "POST",
            url: "Default.aspx/AddOrEditPhieuYeuCauVatTuChiTiet",
            data: JSON.stringify($this.data),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                if (onComplete)
                    onComplete({ d: "Có lỗi trong quá trình xử lý: " + errorThrown });
            },
            success: function (result) {
                onComplete(result);
            }
        });
    },
    markDelete: function (onComplete, onError) {
        var curID = this.data.ID || this.data.itemID;
        if (curID == 0) {
            onComplete({ d: "" });
            return;
        }
        $.ajax({
            type: "POST",
            url: "Default.aspx/DeletePhieuYeuCauVatTuChiTiet",
            data: "{\"ID\":" + curID + "}",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                if (onComplete)
                    onComplete({ d: "Có lỗi trong quá trình xử lý: " + errorThrown });
            },
            success: function (result) {
                if (result.d == "SUCCESS") {
                    if (onComplete)
                        onComplete(result);
                } else {
                    alert("Có lỗi trong quá trình xử lý, hãy thử lại!");
                }
            }
        });
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
                } else {
                    this.data[field] = parseInt(value);
                }
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
    setPhieuYeuCauVatTuID: function (val) {
        this.setValue("IDPhieuYeuCauVatTu", val, "int");
    },
    setMaVatTu: function (val) {
        this.setValue("IDVatTu", val, "int");
    },
    setMaHieuVatTu: function (val) {
        this.setValue("MaHieuVatTu", val, "string");
    },
    setTenVatTu: function (val) {
        this.setValue("TenVatTu", val, "string");
    },
    setMaDonViTinh: function (val) {
        this.setValue("IDDonViTinh", val, "int");
    },
    setTenDonViTinh: function (val) {
        this.setValue("DonViTinh", val, "string");
    },
    setSoLuongYeuCau: function (val) {
        this.setValue("SoLuongYeuCau", val, "int");
    },
    setTinhTrang: function (val) {
        this.setValue("TinhTrang", val, "int");
    },
    setGhiChu: function (val) { this.setValue("GhiChu", val, "string"); },
    fireEvent: function (field, value) {
        $(this).trigger({
            type: "DataChanged",
            fieldName: field,
            value: value
        });
    }
};
