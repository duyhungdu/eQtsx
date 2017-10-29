
/*
 * Phieu nhap data object
 */
var PhieuNhap = function (initData) {
    var $this = this;
    var dataObj = DataObject.call(this, [
        { Name: "ID", Type: "int", Value: 0 },
        { Name: "MaHieuPhieuNhap", Type: "string", Value: "" },
        { Name: "MaPhieuXuat", Type: "int", Value: 0 },
        { Name: "NgayNhap", Type: "string", Value: "" },
        { Name: "MaNhaCungCap", Type: "int", Value: 0 },
        { Name: "MaKhoVatTu", Type: "int", Value: null },
        { Name: "MaTinhChatNhapXuat", Type: "int", Value: null },
        { Name: "KieuVatTu", Type: "int", Value: 1 },
        { Name: "TinhTrang", Type: "int", Value: 0 },
        { Name: "GhiChu", Type: "string", Value: "" }
    ]);
    if (initData) {
        var keys = Object.getOwnPropertyNames(initData);
        for (var i = 0; i < keys.length; i++) {
            if (this[keys[i]]) {
                this[keys[i]].setValue(initData[keys[i]]);
            }
        }
    }
}

PhieuNhap.prototype = $.extend({
    markDelete: function (onComplete) {
        if (this.ID.Value == 0) {
            return;
        }
        var $this = this;
        if (this.TinhTrang.Value == 0 && !confirm("Bạn có thực sự muốn xóa phiếu kiểm tra này không?")) return;
        if (this.TinhTrang.Value != 0 && !confirm("Bạn có thực sự muốn xóa phiếu nhập này không?")) return;
        $("*").bind("click", disableClickEvent);// disable click event
        $.ajax({
            type: "POST",
            url: "Default.aspx/DeletePhieuNhap",
            data: JSON.stringify($this.getJSON()),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                $("*").unbind("click", disableClickEvent); // enable click event
                console.log("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (result) {
                if (result.d == "SUCCESS") {
                    window.location.reload(true);
                } else {
                    $("*").unbind("click", disableClickEvent); // enable click event
                    alert("Có lỗi trong quá trình xử lý\n" + result.d);
                }
            }
        });
    },
    save: function (onComplete) {
        var $this = this;
        if (typeof this.MaPhieuXuat.Value == "undefined" || this.MaPhieuXuat.Value == null)
            this.MaPhieuXuat.setValue(0);
        $("*").bind("click", disableClickEvent);// disable click event
        $.ajax({
            type: "POST",
            url: "Default.aspx/AddOrUpdatePhieuNhap",
            data: JSON.stringify(this.getJSON()),
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
    },
    duyetPhieuNhapThanhPham: function () {
        if (!confirm("Bạn có thực sự muốn duyệt phiếu nhập thành phẩm này không?")) return;
        var $this = this;
        $.ajax({
            type: "POST",
            url: "Default.aspx/DuyetPhieuNhapThanhPham",
            data: JSON.stringify($this.getJSON()),
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
    duyetPhieuNhap: function () {
        if (!confirm("Bạn có thực sự muốn duyệt phiếu nhập này không?")) return;
        var $this = this;
        $("*").bind("click", disableClickEvent);// disable click event
        $.ajax({
            type: "POST",
            url: "Default.aspx/DuyetPhieuNhap",
            data: JSON.stringify($this.getJSON()),
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
    getChiTietPhieuNhap: function (onSuccess) {
        var data = [];
        if (this.ID.Value != 0) {
            var $this = this;
            queryData("Default.aspx/GetVatTuNhap", "{idPhieuNhap:" + $this.ID.Value + "}", function (result) {
                var returnDataObject = JSON.parse(result.d);
                for (var i = 0; i < returnDataObject.length; i++) {
                    returnDataObject[i].MaHieuNhaCungCap = $this.MaNhaCungCap.Value.toString();
                    data.push(new VatTuNhap(returnDataObject[i]));
                }
                if (onSuccess)
                    onSuccess(returnDataObject);
            }, null, false);
        }
        return data;
    },
    getChiTietPhieuNhapThanhPham: function (onSuccess) {
        var data = [];
        if (this.ID.Value != 0) {
            var $this = this;
            queryData("Default.aspx/GetThanhPhamNhap", "{idPhieuNhap:" + $this.ID.Value + "}", function (result) {
                var returnDataObject = JSON.parse(result.d);
                for (var i = 0; i < returnDataObject.length; i++) {
                    data.push(new NhapThanhPham(returnDataObject[i]));
                }
                if (onSuccess)
                    onSuccess(returnDataObject);
            }, null, false);
        }
        return data;
    }
}, DataObject.prototype);

/*
 * Chi tiet phieu nhap (Vat tu nhap) data object
 */

var VatTuNhap = function (initData) {
    var $this = this;
    var dataObj = DataObject.call(this, [
        { Name: "ID", Type: "int", Value: 0 },
        { Name: "MaPhieuNhap", Type: "int", Value: 0 },
        { Name: "MaCuon", Type: "string", Value: "" },
        { Name: "MaVatTu", Type: "int", Value: 0 },
        { Name: "MaHieuVatTu", Type: "string", Value: "" },
        { Name: "TenVatTu", Type: "string", Value: "" },
        { Name: "DonViTinh", Type: "string", Value: "" },
        { Name: "DonGia", Type: "float", Value: 0 },
        { Name: "SoLuongThucNhap", Type: "float", Value: 0 },
        { Name: "SoLuongDauCuon", Type: "float", Value: 0 },
        { Name: "SoLuongLamPhieuNhap", Type: "float", Value: 0 },
        { Name: "DinhLuongTieuChuan", Type: "float", Value: 0 },
        { Name: "DinhLuongThucTe", Type: "float", Value: 0 },
        { Name: "KichThuocTieuChuan", Type: "float", Value: 0 },
        { Name: "KichThuocThucTe", Type: "float", Value: 0 },
        { Name: "ChenhLechDinhLuong", Type: "float", Value: 0 },
        { Name: "DinhLuongTinhTru", Type: "float", Value: 0 },
        { Name: "TruThuaKichThuoc", Type: "float", Value: 0 },
        { Name: "KhoiLuongTru", Type: "float", Value: 0 },
        { Name: "TruLoi", Type: "float", Value: 0 },
        { Name: "SoLuongChenhLechKhongTinh", Type: "float", Value: 0 },
        { Name: "ThanhTien", Type: "float", Value: 0 },
        { Name: "DinhLuongKiemTra", Type: "float", Value: 0 },
        { Name: "KichThuocKiemTra", Type: "float", Value: 0 },
        { Name: "DoMucKiemTra", Type: "float", Value: 0 },
        { Name: "DoAmKiemTra", Type: "float", Value: 0 },
        { Name: "CamQuanKiemTra", Type: "string", Value: "" },
        { Name: "TinhTrang", Type: "int", Value: 0 },
        { Name: "GhiChu", Type: "string", Value: "" },
        { Name: "MaHieuNhaCungCap", Type: "string", Value: "" },
        { Name: "MarkDelete", Type: "boolean", Value: false }
    ]);
    if (initData) {
        var keys = Object.getOwnPropertyNames(initData);
        for (var i = 0; i < keys.length; i++) {
            if (this[keys[i]]) {
                this[keys[i]].setValue(initData[keys[i]]);
            }
        }
    }

    $(this).on("DataChanged", function (evt) {
        if (evt.fieldName === "MaHieuVatTu") {
            $this.getThongTinVatTu();
        }
        if (evt.fieldName === "SoLuongDauCuon" || evt.fieldName === "MaHieuNhaCungCap") {
            $this.calMaCuon();
        }
        if (evt.fieldName === "DinhLuongTieuChuan" || evt.fieldName === "DinhLuongThucTe") {
            $this.calChenhLechDinhLuong();
        }
        if (evt.fieldName === "ChenhLechDinhLuong") {
            $this.calDinhLuongTinhTru();
        }
        if (evt.fieldName === "KichThuocTieuChuan" || evt.fieldName === "KichThuocThucTe" || evt.fieldName === "SoLuongLamPhieuNhap") {
            $this.calTruThuaKichThuoc();
        }
        if (evt.fieldName === "DinhLuongThucTe" || evt.fieldName === "DinhLuongTinhTru" || evt.fieldName === "SoLuongLamPhieuNhap") {
            $this.calKhoiLuongTru();
        }
        if (evt.fieldName === "MaHieuVatTu" || evt.fieldName === "KichThuocTieuChuan") {
            $this.calTruLoi();
        }
        if (evt.fieldName === "SoLuongDauCuon" || evt.fieldName === "SoLuongLamPhieuNhap") {
            $this.calSoLuongChenhLech();
        }
        if (evt.fieldName === "SoLuongLamPhieuNhap" || evt.fieldName === "TruThuaKichThuoc" || evt.fieldName === "TruLoi" || evt.fieldName === "KhoiLuongTru") {
            $this.calSoLuongThucNhap();
        }
        if (evt.fieldName === "SoLuongThucNhap" || evt.fieldName === "DonGia") {
            $this.calThanhTien();
        }
        if (evt.fieldName === "MaVatTu" || evt.fieldName === "KichThuocThucTe") {
            $this.calTruLoi();
        }
    });
}

VatTuNhap.prototype = $.extend({
    markDelete: function () {
        if (this.ID.Value == 0) {
            return;
        }
        if (!confirm("Bạn có thực sự muốn xóa vật tư này không?")) return;
        var $this = this;
        $.ajax({
            type: "POST",
            url: "Default.aspx/DeleteChiTietVatTu",
            data: JSON.stringify($this.getJSON()),
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
    save: function (onComplete) {
        var $this = this;
        if (this.MarkDelete.Value) {
            this.markDelete();
            return;
        }
        $.ajax({
            type: "POST",
            url: "Default.aspx/AddOrUpdateVatTuNhap",
            data: JSON.stringify(this.getJSON()),
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
        var curID = this.ID.Value || this.itemID.Value;
        if (curID == 0) {
            onComplete({ d: "" });
            return;
        }
        $.ajax({
            type: "POST",
            url: "Default.aspx/DeleteChiTietVatTu",
            data: JSON.stringify(this.getJSON()),
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
    }, getThongTinVatTu: function () {
        var $this = this;
        queryData("/WebService/DanhMuc.asmx/GetJSONDataVatTu", "", function (result) {
            var list = $.parseJSON(result.d);
            var found = false;
            for (var i = 0; i < list.length; i++) {
                if (list[i].MaVatTu == $this.MaHieuVatTu.Value) {
                    found = true;
                    $this.MaVatTu.setValue(list[i].ID);
                    $this.TenVatTu.setValue(list[i].MaVatTu + " - " + list[i].TenVatTu);
                    $this.DonViTinh.setValue(list[i].DonViTinh);
                    $this.DinhLuongTieuChuan.setValue(list[i].DinhLuongTieuChuan);
                    $this.KichThuocTieuChuan.setValue(list[i].KichThuocTieuChuan);
                    $this.calMaCuon();
                }
            }
            if (!found) {
                $this.MaVatTu.setValue(0);
                $this.TenVatTu.setValue("");
                $this.DonViTinh.setValue("");
                $this.DinhLuongTieuChuan.setValue(0);
                $this.KichThuocTieuChuan.setValue(0);
                $this.MaCuon.setValue("");
            }
        }, null, false);
    }, calMaCuon: function () {
        if (this.MaVatTu.Value == 0) {
            this.MaCuon.setValue("");
            return;
        }
        var donViCungCap = this.MaHieuNhaCungCap.Value;
        var mavattu = this.MaHieuVatTu.Value;
        var maLoaiGiay;
        for (var i = 0; i < dataVatTu.length; i++) {
            if (dataVatTu[i].MaVatTu == mavattu && dataVatTu[i].MaHieuLoaiVatTu) {
                maLoaiGiay = dataVatTu[i].MaHieuLoaiVatTu.charAt(0);
            }
        }
        var $this = this;
        if (donViCungCap) {
            var maDonViCC = "";
            queryData("/WebService/DanhMuc.asmx/GetJSONDataNhaCungCap", "{ID:" + donViCungCap + "}", function (result) {
                var dataNCC = JSON.parse(result.d);
                for (var j = 0; j < dataNCC.length; j++) {
                    if (dataNCC[j].ID == donViCungCap) {
                        maDonViCC = dataNCC[j].MaHieuNhaCungCap.trim();
                    }
                }
            }, null, false);
            var macuon = maDonViCC + "-" + maLoaiGiay + "-" + $this.KichThuocTieuChuan.Value + "-" + $this.DinhLuongTieuChuan.Value + "-" + $this.SoLuongDauCuon.Value;
            $this.MaCuon.setValue(macuon);
        };

    }, calChenhLechDinhLuong: function () {
        if (this.DinhLuongTieuChuan.Value && this.DinhLuongThucTe.Value) {
            this.ChenhLechDinhLuong.setValue(this.DinhLuongTieuChuan.Value - this.DinhLuongThucTe.Value);
        } else {
            this.ChenhLechDinhLuong.setValue(0);
        }
    }, calDinhLuongTinhTru: function () {
        if (this.ChenhLechDinhLuong.Value > 5)
            this.DinhLuongTinhTru.setValue(this.ChenhLechDinhLuong.Value - 5);
        else if (this.ChenhLechDinhLuong.Value < -5)
            this.DinhLuongTinhTru.setValue(this.ChenhLechDinhLuong.Value + 5);
        else
            this.DinhLuongTinhTru.setValue(0);

    }, calTruThuaKichThuoc: function () {
        if (this.KichThuocThucTe.Value && this.KichThuocTieuChuan.Value && this.SoLuongLamPhieuNhap.Value && (this.KichThuocThucTe.Value - this.KichThuocTieuChuan.Value > 0.5)
            && this.KichThuocTieuChuan.Value) {
            var val = this.KichThuocThucTe.Value * this.SoLuongLamPhieuNhap.Value / this.KichThuocTieuChuan.Value - this.SoLuongLamPhieuNhap.Value;
            //var temp = (val - Math.floor(val)).toString();
            //if (temp.length > 6)
            //    temp = temp.substring(0, 6);
            //val = Math.floor(val) + parseFloat(temp);
            this.TruThuaKichThuoc.setValue(Math.round(val));
        }
        else
            this.TruThuaKichThuoc.setValue(0);

    }, calKhoiLuongTru: function () {
        if (this.SoLuongLamPhieuNhap.Value && this.DinhLuongThucTe.Value && this.DinhLuongTinhTru.Value) {
            this.KhoiLuongTru.setValue(Math.round(Math.abs((this.SoLuongLamPhieuNhap.Value / this.DinhLuongThucTe.Value) * this.DinhLuongTinhTru.Value), 0));
        }
        else
            this.KhoiLuongTru.setValue(0);
    }, calTruLoi: function () {
        var $this = this;
        queryData("/WebService/DanhMuc.asmx/GetTruLoi", "{idVatTu:" + this.MaVatTu.Value + ", kichThuoc:" + this.KichThuocThucTe.Value + "}", function (result) {
            $this.TruLoi.setValue(JSON.parse(result.d));
        });
        /*
        if (!this.KichThuocTieuChuan.Value) {
            this.TruLoi.setValue(0);
            return;
        }
        var mavattu = this.MaHieuVatTu.Value;
        var ch;
        for (var i = 0; i < dataVatTu.length; i++) {
            if (dataVatTu[i].MaVatTu == mavattu && dataVatTu[i].MaHieuLoaiVatTu) {
                ch = dataVatTu[i].MaHieuLoaiVatTu.charAt(0);
            }
        }
        if (!ch) {
            this.TruLoi.setValue(0);
            return;
        }
        var val1 = 0;
        if ((ch == "F" || ch == "D" || ch == "E") && this.KichThuocTieuChuan.Value < 140)
            val1 = 4;
        else if ((ch == "F" || ch == "D" || ch == "E") && this.KichThuocTieuChuan.Value >= 140)
            val1 = 5;

        var val2 = 0;
        if ((ch == "A" || ch == "B" || ch == "C") && this.KichThuocTieuChuan.Value < 140)
            val2 = 5;
        else if ((ch == "A" || ch == "B" || ch == "C") && this.KichThuocTieuChuan.Value >= 140)
            val2 = 6;
        this.TruLoi.setValue(val1 + val2);
        */
    }, calSoLuongChenhLech: function () {
        if (this.SoLuongDauCuon.Value && this.SoLuongLamPhieuNhap.Value)
            this.SoLuongChenhLechKhongTinh.setValue(this.SoLuongDauCuon.Value - this.SoLuongLamPhieuNhap.Value);
        else
            this.SoLuongChenhLechKhongTinh.setValue(0);
    }, calSoLuongThucNhap: function () {
        var val = this.SoLuongLamPhieuNhap.Value - this.TruThuaKichThuoc.Value - this.TruLoi.Value - this.KhoiLuongTru.Value;
        var temp = (val - Math.floor(val)).toString();
        if (temp.length > 6)
            temp = temp.substring(0, 6);
        val = Math.floor(val) + parseFloat(temp);

        this.SoLuongThucNhap.setValue(val);
    }, calThanhTien: function () {
        if (this.DonGia.Value && this.SoLuongThucNhap.Value) {
            var val = this.DonGia.Value * this.SoLuongThucNhap.Value;
            var temp = (val - Math.floor(val)).toString();
            if (temp.length > 6)
                temp = temp.substring(0, 6);
            val = Math.floor(val) + parseFloat(temp);
            if (val < 0) {
                //alert("dữ liệu sai, xin hãy kiểm tra lại.");
            } else
                this.ThanhTien.setValue(val);
        } else
            this.ThanhTien.setValue(0);
    }
}, DataObject.prototype);