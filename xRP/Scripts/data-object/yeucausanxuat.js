
/**
 * Phieu xuat object
 */
function LenhSanXuat(data) {
    this.data = {
        ID: 0,
        TT: 0,
        IDCongDoan: 0,
        NgaySanXuat: '',
        TinhTrang: '',
        GhiChu: '',
        MaHieuCongDoan: '',
        MaKhachHang: 0,
        MaDonHang: 0,
        TenCongDoan: '',
        MoTaTinhTrang: '',
        YeuCauSanXuatID: '',
        TypeQuery: '',//Type=Edit,ViewDetail
        DanhSachYeuCauSanXuat: '',
        ThoiGianCanSanXuat: 0,
        Status: ''

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
        if (!confirm("Bạn có thực sự muốn xóa lệnh sản xuất này không?")) return;
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
                if (result.d == "SUCCESS" || result.d == "null" || result.d == null) {
                    window.location.reload(true);
                } else {
                    alert(result.d);
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
    save: function (onSucessLenhSanXuat, isPrint, notshowConfirm, notReload) {
        var $this = this;;
        if ($this == null) return;

        var lsLenhChiTiet = [];
        var tongThoiGianSanXuat = 0;
        $.each($this.dataChiTiet, function (dx, lenhChiTiet) {
            if (lenhChiTiet.data.IsSave > 0) {

                lenhChiTiet.data.ThuTuUuTien = lenhChiTiet.data.TT;

                var lsDataDinhMucVatTu = [];
                $.each(lenhChiTiet.data.dataDinhMucVatTu, function (dx, dinhMucVatTu) {
                    lsDataDinhMucVatTu.push(dinhMucVatTu.data);
                });
                lenhChiTiet.data.DanhSachDinhMucVatTu = JSON.stringify(lsDataDinhMucVatTu).toString();


                //lenhChiTiet.data.QuyDoiMetDai = lenhChiTiet.data.QuyDoiMetDai.toFixed(2);
                if (isNaN(lenhChiTiet.data.QuyDoiMetDai) || lenhChiTiet.data.QuyDoiMetDai == 'Infinity')
                    lenhChiTiet.data.QuyDoiMetDai = 0;

                //lenhChiTiet.data.ThoiGianSanXuat = lenhChiTiet.data.ThoiGianSanXuat.toFixed(2);
                if (isNaN(lenhChiTiet.data.ThoiGianSanXuat) || lenhChiTiet.data.ThoiGianSanXuat == 'Infinity')
                    lenhChiTiet.data.ThoiGianSanXuat = 0;

                lsLenhChiTiet.push(lenhChiTiet.data);

                tongThoiGianSanXuat += lenhChiTiet.data.ThoiGianSanXuat;

            } else if (lenhChiTiet.data.IsSave <= 0 && lenhChiTiet.data.SoLuongYeuCau > 0) {
                alert('Bạn chưa tính định mức cho mặt hàng:\n' + lenhChiTiet.data.MaHieuDonHang + ' - ' + lenhChiTiet.data.TenMatHang);
                return;
            }
        });

        if ((tongThoiGianSanXuat / 60 > $this.data.ThoiGianCanSanXuat) && !confirm("Tổng thời gian sản xuất lớn hơn 9h, Bạn có thực sự muốn lưu lệnh sản xuất này không?")) return;

        $this.data.DanhSachYeuCauSanXuat = JSON.stringify(lsLenhChiTiet).toString();

        var lsYeuCau = {
            lsYeuCauSanXuat: $this.data.DanhSachYeuCauSanXuat,
            ngayTao: $this.data.NgaySanXuat,
            congDoanId: $this.data.IDCongDoan,
            lenhSanXuatId: $this.data.ID,
            ID: $this.data.ID,
            status: 'Pending'
        };
        $.ajax({
            type: "POST",
            url: "Default.aspx/AddOrEditLenhSanXuatAll",
            data: JSON.stringify(lsYeuCau),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Request: " + XMLHttpRequest + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                alert('Có lỗi trong quá trình xử lý');
            },
            success: function (result) {
                var data = 0;
                if (!isNaN(result.d)) {
                    onSucessLenhSanXuat(parseInt(result.d), isPrint, notshowConfirm, notReload);
                }
                else alert(result.d);
            }
        });

    },
    saveYeuCauSanXuat: function (onSucess) {

        var lsYeuCau = {
            lsYeuCauSanXuat: this.data.DanhSachYeuCauSanXuat,
            ngayTao: this.data.NgaySanXuat,
            congDoanId: this.data.IDCongDoan,
            lenhSanXuatId: this.data.ID,
            ID: this.data.ID,
            status: this.data.Status
        };

        $.ajax({
            type: "POST",
            url: "Default.aspx/AddOrEditLenhSanXuatAll",
            data: JSON.stringify(lsYeuCau),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Request: " + XMLHttpRequest + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                alert('Có lỗi trong quá trình xử lý');
            },
            success: function (result) {
                var data = 0;
                if (!isNaN(result.d)) {
                    onSucess(parseInt(result.d));
                }
                else alert(result.d);
            }
        });

    },
    getDanhSachLenhSanXuatChiTiet: function (onSuccess) {
        var data = [];
        if (this.ID != 0) {
            var $this = this;
            queryData("Default.aspx/GetLenhSanXuatChiTietForDetail", "{IDLenhSanXuat:" + $this.data.ID + "}", function (result) {
                var returnDataObject = JSON.parse(result.d);

                for (var i = 0; i < returnDataObject.length; i++) {
                    //console.log(returnDataObject[i]);
                    //console.log(new LenhSanXuatChiTiet(returnDataObject[i]));
                    data.push(new LenhSanXuatChiTiet(returnDataObject[i]));
                }
                if (onSuccess)
                    onSuccess(returnDataObject);
            }, null, false);
        }
        return data;
    },
    getDanhSachLenhSanXuatChiTietAll: function (onSuccess) {
        var data = [];
        if (this.ID != 0) {
            var $this = this;
            queryData("Default.aspx/GetLenhSanXuatChiTiet", "{IDLenhSanXuat:" + $this.data.ID + ",IDCongDoan:" + $this.data.IDCongDoan + ",IDKhachHang:" + $this.data.MaKhachHang + ",IDDonHang:" + $this.data.MaDonHang + "}", function (result) {
                var returnDataObject = JSON.parse(result.d);
                for (var i = 0; i < returnDataObject.length; i++) {
                    data.push(new LenhSanXuatChiTiet(returnDataObject[i]));
                }
                if (onSuccess)
                    onSuccess(returnDataObject);
            }, null, false);
        }
        return data;
    },

    getLenhSanXuatChiTiet: function (onSuccess) {
        var data = [];
        if (this.ID != 0) {
            var $this = this;
            queryData("Default.aspx/GetLenhSanXuatChiTietDetail", "{IDLenhSanXuat:" + $this.data.ID + ",YeuCauSanXuatId:" + $this.data.YeuCauSanXuatID + "}", function (result) {
                var returnDataObject = JSON.parse(result.d);
                data.push(new LenhSanXuatChiTiet(returnDataObject));
                if (onSuccess)
                    onSuccess(returnDataObject);
            }, null, false);
        }
        return data;
    },
    getDanhSachLenhSanXuatChiTietForDetail: function (onSuccess) {
        var data = [];
        if (this.ID != 0) {
            var $this = this;
            queryData("Default.aspx/GetLenhSanXuatChiTietForDetail", "{IDLenhSanXuat:" + $this.data.ID + "}", function (result) {
                var returnDataObject = JSON.parse(result.d);
                for (var i = 0; i < returnDataObject.length; i++) {
                    data.push(new LenhSanXuatChiTiet(returnDataObject[i]));
                }
                if (onSuccess)
                    onSuccess(returnDataObject);
            }, null, false);
        }
        return data;
    }
}


function LenhSanXuatChiTiet(data) {
    this.data = {
        RanID: 0,
        ID: 0,
        TT: 0,
        IDYeuCauSanXuat: 0,
        IDLenhSanXuat: 0,
        MaHieuDonHang: '',
        MaHieuMatHang: '',
        TenMatHang: '',
        ChieuDai: 0,
        ChieuRong: 0,
        ChieuCao: 0,
        KTTam: '',
        KichThuoc: '',
        SoLop: 0,
        IDLoaiSongSanXuat: 0,
        IDLoaiGiay: 0,
        KhoGiay: '',
        ChatDai: 0,
        TongDao: 0,
        Xa: 0,
        Le: 0,
        Tai: 0,
        SoLuongHop: 0,
        SoLuongTam: 0,
        DienTichSanXuat: '',
        DienTichXuatBan: '',
        SoLuong: 0,
        KiHieuCoCauGiay: '',
        MoTaCoCauGiay: '',
        MaHieuKichThuoc: '',
        LoaiKichThuoc: 0,
        TenLoaiSanPham: '',
        MaHieuCongDoan: 0,
        TenCongDoan: '',
        SoLuongYeuCau: 0,
        SoLuongDatDuoc: 0,
        SoLuongLoi: 0,
        ThuTuUuTien: 0,
        MaMatHang: 0,
        GhiChu: '',
        SoLuongYeuCauSanXuatKeHoach: 0,
        SoLuongYeuCauSanXuatKeHoachConLai: 0,
        DanhSachDinhMucVatTu: '',
        QuyDoiMetDai: 0,
        ThoiGianSanXuat: 0,
        IsSave: 0,
        DoiPhuongAn: 0
    };
    this.dataDinhMucVatTu = [];
    if (data) {
        $.extend(this.data, data);
        if (this.data.itemID) {
            this.data.itemID = parseInt(this.data.itemID);
        } else
            this.data.itemID = 0;
    }
}
LenhSanXuatChiTiet.prototype = {
    constructor: LenhSanXuatChiTiet,
    markDelete: function (onDeleteYeuCauSanXuat, index) {
        if (!this.data) {
            alert("Dữ liệu lỗi.")
            return;
        }
        if (!confirm("Bạn có thực sự muốn xóa lệnh sản xuất chi tiết này không?")) return;
        var $this = this;
        $.ajax({
            type: "POST",
            url: "Default.aspx/DeleteLenhSanXuatChiTiet",
            //data: { lenhSanXuatChiTietId: id },
            data: "{lenhSanXuatChiTietId:\"" + $this.data.ID + "\"}",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Request: " + XMLHttpRequest + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                alert('Có lỗi trong quá trình xử lý');
            },
            success: function (result) {
                onDeleteYeuCauSanXuat(result, index);
            }
        });
    },
    save: function (onComplete) {
        var $this = this;
        // console.log($this);
        if ($this == null) return;
        $this.data.ThuTuUuTien = $this.data.TT;

        var lsDataDinhMucVatTu = [];
        $.each($this.data.dataDinhMucVatTu, function (dx, dinhMucVatTu) {
            lsDataDinhMucVatTu.push(dinhMucVatTu.data);
        });
        $this.data.DanhSachDinhMucVatTu = JSON.stringify(lsDataDinhMucVatTu).toString();


        $this.data.QuyDoiMetDai = $this.data.QuyDoiMetDai.toFixed(2);
        if (isNaN($this.data.QuyDoiMetDai) || $this.data.QuyDoiMetDai == 'Infinity')
            $this.data.QuyDoiMetDai = 0;

        $this.data.ThoiGianSanXuat = $this.data.ThoiGianSanXuat.toFixed(2);
        if (isNaN($this.data.ThoiGianSanXuat) || $this.data.ThoiGianSanXuat == 'Infinity')
            $this.data.ThoiGianSanXuat = 0;

        $.ajax({
            type: "POST",
            url: "Default.aspx/AddOrEditLenhSanXuatChiTietAndDinhMuc",
            data: JSON.stringify($this.data),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Request: " + XMLHttpRequest + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                alert('Có lỗi trong quá trình xử lý');
            },
            success: function (result) {
                var data = 0;
                if (!isNaN(result.d)) {
                    data = parseInt(result.d);
                    if (data > 0) {
                        $this.data.IsSave = 1;
                        $this.data.ID = data;
                    }
                    else {
                        alert("Có lỗi trong quá trình tính định mức vật tư , Bạn có muốn lưu lệnh sản xuất chi tiết này không?");
                        return;
                    }
                }
                else alert(result.d);
            }
        });
    },
    getDanhSachDinhMucVatTu: function (onSuccess) {
        var data = [];
        if (this.ID != 0) {
            var $this = this;
            var khoGiay = $this.data.KhoGiay;
            queryData("/WebService/DanhMuc.asmx/GetJSONDataDinhMucVatTu", "{matHangId:" + $this.data.MaMatHang + ",lenhSanXuatChiTietId:" + $this.data.ID + ",yeuCauSanXuatId:" + $this.data.IDYeuCauSanXuat + "}", function (result) {
                var returnDataObject = JSON.parse(result.d);
                for (var i = 0; i < returnDataObject.length; i++) {
                    var dm = new DinhMucVatTu(returnDataObject[i]);
                    dm.data.KhoGiay = khoGiay;
                    data.push(dm);

                }
                if (onSuccess)
                    onSuccess(returnDataObject);
            }, null, false);
        }

        return data;
    }
}

function QLSXYeuCauSanXuat(data) {
    this.data = {
        RanID: 0,
        ID: 0

    };
    this.dataDinhMucVatTu = [];
    if (data) {
        $.extend(this.data, data);
        if (this.data.itemID) {
            this.data.itemID = parseInt(this.data.itemID);
        } else
            this.data.itemID = 0;
    }
}
QLSXYeuCauSanXuat.prototype = {
    constructor: QLSXYeuCauSanXuat,
    markDelete: function () {
        if (!this.data) {
            alert("Dữ liệu lỗi.")
            return;
        }
        if (!confirm("Bạn có thực sự muốn xóa lệnh sản xuất chi tiết này không?")) return;
        var $this = this;
        $.ajax({
            type: "POST",
            url: "Default.aspx/DeleteYeuCauSanXuat",
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
        // console.log($this);
        if ($this == null) return;

        $.ajax({
            type: "POST",
            url: "Default.aspx/AddOrEditYeuCauSanXuat",
            data: JSON.stringify($this.data),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {

                console.log("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                if (onComplete)
                    onComplete({ d: "Có lỗi trong quá trình xử lý cập nhật lệnh sản xuất chi tiết và định mức: " + errorThrown });
            },
            success: function (result) {
                onComplete(result);
            }
        });
    },
    getDanhSachDinhMucVatTu: function (onSuccess) {
        var data = [];
        if (this.ID != 0) {
            var $this = this;
            queryData("/WebService/DanhMuc.asmx/GetJSONDataDinhMucVatTu", "{matHangId:" + $this.data.MaMatHang + ",lenhSanXuatChiTietId:" + $this.data.ID + ",yeuCauSanXuatId:" + $this.data.IDYeuCauSanXuat + "}", function (result) {
                var returnDataObject = JSON.parse(result.d);
                for (var i = 0; i < returnDataObject.length; i++) {
                    data.push(new DinhMucVatTu(returnDataObject[i]));
                }
                if (onSuccess)
                    onSuccess(returnDataObject);
            }, null, false);
        }

        return data;
    },
    KetThucYeuCau: function (onSuccess) {
        var $this = this;
        $.ajax({
            type: "POST",
            url: "Default.aspx/KetThucYeuCau",
            data: JSON.stringify($this.data),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (result) {
                if (result.d == "" || result.d == null || result.d == "") {
                    alert("Kết thúc yêu cầu thành công");
                    window.location.reload(true);
                } else {
                    alert(result.d);
                }
            }
        });
    },
    HuyYeuCau: function (onSuccess) {
        var $this = this;
        $.ajax({
            type: "POST",
            url: "Default.aspx/HuyYeuCau",
            data: JSON.stringify($this.data),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (result) {
                if (result.d == "" || result.d == null || result.d == "") {
                    alert("Hủy yêu cầu thành công");
                    window.location.reload(true);
                } else {
                    alert(result.d);
                }
            }
        });
    },
    HuyHuyYeuCau: function (onSuccess) {
        var $this = this;
        $.ajax({
            type: "POST",
            url: "Default.aspx/HuyHuyYeuCau",
            data: JSON.stringify($this.data),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (result) {
                if (result.d == "" || result.d == null || result.d == "") {
                    alert("Hủy yêu cầu thành công");
                    window.location.reload(true);
                } else {
                    alert(result.d);
                }
            }
        });
    },
    HuyKetThucYeuCau: function (onSuccess) {
        var $this = this;
        $.ajax({
            type: "POST",
            url: "Default.aspx/HuyKetThucYeuCau",
            data: JSON.stringify($this.data),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (result) {
                if (result.d == "" || result.d == null || result.d == "") {
                    alert("Hủy yêu cầu thành công");
                    window.location.reload(true);
                } else {
                    alert(result.d);
                }
            }
        });
    },
}