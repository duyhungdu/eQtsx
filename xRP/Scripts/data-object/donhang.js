
/*
 * Đơn hàng: DonHang
 */
var DonHang = function (initData) {
    var $this = this;
    var dataObj = DataObject.call(this, [
        { Name: "ID", Type: "int", Value: 0 },
        { Name: "MaHieuDonHang", Type: "string", Value: "" },
        { Name: "MaHieuKhachHang", Type: "string", Value: "" },
        { Name: "TenKhachHang", Type: "string", Value: "" },
        { Name: "NgayDatHang", Type: "string", Value: null },
        { Name: "NgayGiaoHang", Type: "string", Value: null },
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

DonHang.prototype = $.extend({
    markDelete: function () {
        if (this.ID.Value == 0) {
            return;
        }
        if (!confirm("Bạn có thực sự muốn xóa đơn hàng này không?")) return;
        var $this = this;
        $("*").bind("click", disableClickEvent);// disable click event
        $.ajax({
            type: "POST",
            url: "/Administrator/QuanLyDonHang/DonHang/default.aspx/XoaDonHang",
            data: JSON.stringify($this.getJSON()),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                $("*").unbind("click", disableClickEvent); // enable click event
            },
            success: function (result) {
                if (result.d == "") {
                    window.location.reload(true);
                } else {
                    alert("Có lỗi trong quá trình xử lý\n" + result.d);
                    $("*").unbind("click", disableClickEvent); // enable click event
                }
            }
        });
    }, undoProcess: function () {
        if (this.ID.Value == 0) {
            return;
        }
        if (!confirm("Bạn có thực sự hủy xử lý đơn hàng này không?")) return;
        var $this = this;
        $("*").bind("click", disableClickEvent);// disable click event
        $.ajax({
            type: "POST",
            url: "/Administrator/QuanLyDonHang/DonHang/default.aspx/HuyXuLyDonHang",
            data: JSON.stringify($this.getJSON()),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                $("*").unbind("click", disableClickEvent); // enable click event
            },
            success: function (result) {
                if (result.d == "") {
                    window.location.reload(true);
                } else {
                    alert("Có lỗi trong quá trình xử lý\n" + result.d);
                    $("*").unbind("click", disableClickEvent); // enable click event
                }
            }
        });
    },
    save: function (onComplete) {
        var $this = this;
        $("*").bind("click", disableClickEvent);// disable click event
        $.ajax({
            type: "POST",
            url: "Default.aspx/AddOrUpdateDonHang",
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
    getChiTietHangHoa: function (onSuccess) {
        if (this.ID.Value != 0) {
            var $this = this;
            queryData("/Administrator/QuanLyDonHang/DonHang/Default.aspx/GetHangHoa", "{IDDonHang:" + $this.ID.Value + "}", function (result) {
                onSuccess(JSON.parse(result.d));
            });
        }
    }
}, DataObject.prototype);

/*
 * Mặt hàng: MatHang
 */
var MatHang = function (initData) {
    var $this = this;
    this.LoaiSong = [];
    this.TenLoaiSong = [];
    this.StopValueChangedEvent = false;
    var dataObj = DataObject.call(this, [
        { Name: "ID", Type: "int", Value: 0 },
        { Name: "IDMatHang", Type: "int", Value: 0 },
        { Name: "MaHieuMatHang", Type: "string", Value: "" },
        { Name: "IDDonHang", Type: "int", Value: 0 },
        { Name: "TenMatHang", Type: "string", Value: "" },
        { Name: "MaHangTheoDon", Type: "string", Value: "" },
        { Name: "NgayGiaoHang", Type: "string", Value: null },
        { Name: "SoLuong", Type: "float", Value: 0 },
        { Name: "IDDonViTinh", Type: "int", Value: 0 },
        { Name: "DonViTinh", Type: "string", Value: "" },
        { Name: "SoLuongMau", Type: "int", Value: 0 },
        { Name: "MauSacMatNgoai", Type: "string", Value: "" },
        { Name: "ChieuDai", Type: "float", Value: 0 },
        { Name: "ChieuRong", Type: "float", Value: 0 },
        { Name: "ChieuCao", Type: "float", Value: 0 },
        { Name: "IDLoaiSanPham", Type: "int", Value: 0 },
        { Name: "TenLoaiSanPham", Type: "string", Value: "" },
        { Name: "SoLop", Type: "int", Value: 0 },
        { Name: "IDLoaiGiay", Type: "int", Value: 0 },
        { Name: "LoaiGiay", Type: "string", Value: "" },
        { Name: "KhoGiay", Type: "int", Value: 0 },
        { Name: "DinhLuong", Type: "float", Value: 0 },
        { Name: "LoaiSongSanXuat", Type: "int", Value: 0 },
        { Name: "LoaiSongXuatBan", Type: "int", Value: 0 },
        { Name: "TenLoaiSongSanXuat", Type: "string", Value: "" },
        { Name: "TenLoaiSongXuatBan", Type: "string", Value: "" },
        { Name: "DienTichSanXuat", Type: "float", Value: 0 },
        { Name: "DienTichXuatBan", Type: "float", Value: 0 },
        { Name: "CongDoanCuoi", Type: "int", Value: 0 },
        { Name: "DonGia", Type: "float", Value: 0 },
        { Name: "ThanhTien", Type: "float", Value: 0 },
        { Name: "GhiChu", Type: "string", Value: "" },
        { Name: "IDLoaiKichThuoc", Type: "int", Value: 0 },
        { Name: "MaLoaiKichThuoc", Type: "string", Value: "" },
        { Name: "LoaiKichThuoc", Type: "string", Value: "" },
        { Name: "ChieuDao", Type: "float", Value: 0 },
        { Name: "HeSoChatDai", Type: "float", Value: 0 },
        { Name: "ChatDai", Type: "float", Value: 0 },
        { Name: "HeSoTongDao", Type: "float", Value: 0 },
        { Name: "TongDao", Type: "int", Value: 0 },
        { Name: "Xa", Type: "int", Value: 0 },
        { Name: "SoLuongTam", Type: "int", Value: 0 },
        { Name: "SoLuongHop", Type: "int", Value: 0 },
        { Name: "Tai", Type: "float", Value: 0 },
        { Name: "Le", Type: "float", Value: 0 },
        { Name: "KhoGiay", Type: "float", Value: 0 },
        { Name: "TinhTrang", Type: "int", Value: 0 },
        { Name: "DSLoaiSong", Type: "string", Value: "" }
    ]);
    if (initData) {
        var keys = Object.getOwnPropertyNames(initData);
        for (var i = 0; i < keys.length; i++) {
            if (this[keys[i]]) {
                this[keys[i]].setValue(initData[keys[i]]);
            }
        }
    }
    this.getDataLoaiKichThuoc();
    if (this.ID.Value > 0) {
        queryData("/WebService/DanhMuc.asmx/GetJSONDataSongTheoMatHang", "{IDMatHang:" + this.ID.Value + "}", function (result) {
            var datasong = JSON.parse(result.d);
            for (var j = 0; j < datasong.length; j++) {
                $this.LoaiSong.push(datasong[j].IDSong);
                $this.TenLoaiSong.push(datasong[j].TenSong);
            }
        }, null, false);
    }
    $(this).on("DataChanged", function (evt) {
        if ($this.StopValueChangedEvent) return;
        if (evt.fieldName === "SoLuong" || evt.fieldName === "DonGia")
            $this.calThanhTien();
        if (evt.fieldName === "IDLoaiSanPham" || evt.fieldName === "ChieuDai" || evt.fieldName === "ChieuRong" || evt.fieldName === "ChieuCao")
            $this.calDienTich();
        if (evt.fieldName === "IDLoaiKichThuoc") {
            this.getDataLoaiKichThuoc();
        }
        if (evt.fieldName === "SoLop") {
            this.getDataLoaiKichThuoc();
        }
        if (evt.fieldName === "ChieuDai" || evt.fieldName === "ChieuDai" || evt.fieldName === "ChieuRong" || evt.fieldName === "ChieuCao" || evt.fieldName === "LoaiSongSanXuat") {
            this.calMaHangHoa();
        }
        if (evt.fieldName === "LoaiSongSanXuat" || evt.fieldName === "TongDao" || evt.fieldName === "Le") {
            this.calKhoGiay();
        }
    });
    //this.initCalField();
}

MatHang.prototype = $.extend({
    init: function (initData) {
        if (initData) {
            var keys = Object.getOwnPropertyNames(initData);
            for (var i = 0; i < keys.length; i++) {
                if (this[keys[i]]) {
                    this[keys[i]].setValue(initData[keys[i]]);
                }
            }
        }
        this.initCalField();
    },
    getDataLoaiKichThuoc: function () {
        var $this = this;
        queryData("/WebService/DanhMuc.asmx/GetJSONDataHeSoTongDao", "{}", function (result) {
            var dataHSTD = JSON.parse(result.d);
            for (var j = 0; j < dataHSTD.length; j++) {
                if (dataHSTD[j].IDLoaiKichThuoc == $this.IDLoaiKichThuoc.Value && dataHSTD[j].SoLop == $this.SoLop.Value)
                    $this.HeSoTongDao.setValue(dataHSTD[j].HeSoTongDao);
            }
        }, null, false);
        queryData("/WebService/DanhMuc.asmx/GetJSONDataHeSoChatDai", "{}", function (result) {
            var dataHSCD = JSON.parse(result.d);
            for (var j = 0; j < dataHSCD.length; j++) {
                if (dataHSCD[j].ID == $this.IDLoaiKichThuoc.Value) {
                    $this.HeSoChatDai.setValue(dataHSCD[j].HeSoChatDai);
                    $this.MaLoaiKichThuoc.setValue(dataHSCD[j].MaHieuKichThuoc.trim());
                }
            }
        }, null, false);
    },
    save: function (onComplete) {
        var $this = this;
        this.DSLoaiSong.Value = this.LoaiSong;
        if (this.TinhTrang.Value == 0 && !$this.StopValueChangedEvent) {
            this.calTongDao();
            this.calChatDai();
            this.calXa();
            this.SoLuongHop.setValue(this.SoLuong.Value);
            this.calSoLuongTam();
            /*
            if (this.TongDao.Value == 0)
                this.calTongDao();
            if (this.ChatDai.Value == 0)
                this.calChatDai();
            if (this.Xa.Value == 0)
                this.calXa();
            if (this.SoLuongHop.Value == 0)
                this.SoLuongHop.setValue(this.SoLuong.Value);
            if (this.SoLuongTam.Value == 0)
                this.calSoLuongTam();
                */
        }
        this.LoaiSongXuatBan.setValue(this.LoaiSongSanXuat.Value);
        
        $.ajax({
            type: "POST",
            url: "Default.aspx/AddOrUpdateChiTietDonHang",
            data: JSON.stringify(this.getJSON()),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            async: false,
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
                    if (onComplete)
                        onComplete(result);
                }
            }
        });
    },
    markDelete: function () {
        var $this = this;
        $.ajax({
            type: "POST",
            url: "Default.aspx/DeleteHangHoa",
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
                    alert("Có lỗi trong quá trình xử lý\n" + result.d);
                }
            }
        });
    },
    getTenDSSong: function (onSuccess) {
        var data = [];
        queryData("/WebService/DanhMuc.asmx/GetJSONDataSongByIDArray", "{ID:[" + this.LoaiSong.join(", ") + "]}", function (result) {
            data = JSON.parse(result.d);
            if (onSuccess)
                onSuccess(result);
        }, null, false);
        return data;
    },
    initCalField: function () {
        this.calTongDao();
        this.calChatDai();
        this.calXa();
        this.calSoLuongTam();
        this.calKhoGiay();
    },
    calMaQuyDoi: function () {
        var $this = this;
        var lopGiay = "";
        queryData("/WebService/DanhMuc.asmx/GetJSONPhanLoaiSongForAutoComplete", "{}", function (result) {
            var datasong = JSON.parse(result.d);
            for (var j = 0; j < datasong.length; j++) {
                if (datasong[j].data == $this.LoaiSongSanXuat.Value) {
                    lopGiay = datasong[j].KyHieuQuyDoi;
                    $("#txtMaQuyDoi").val(datasong[j].KyHieuQuyDoi);
                    $this.SoLop.setValue(datasong[j].SoLop);
                }
            }
        }, null, false);
        return lopGiay;
    },
    chonCoCauGiay: function (onSuccess) {
        var $this = this;
        $("*").bind("click", disableClickEvent);// disable click event
        $.ajax({
            type: "POST",
            url: "/Business/QuanLySanXuat/Default.aspx/ChonCoCauGiay",
            data: JSON.stringify($this.getJSON()),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                $("*").unbind("click", disableClickEvent); // enable click event
            },
            success: function (result) {
                if (onSuccess) {
                    onSuccess(result);
                }
                $("*").unbind("click", disableClickEvent); // enable click event
            }
        });
    },
    calTongDao: function () {
        var tongdao = 0;
        var $this = this;
        if ($this["ChieuCao"].Value != 0)
            tongdao = $this["ChieuRong"].Value + $this["ChieuCao"].Value + $this["HeSoTongDao"].Value;
        else
            tongdao = $this["ChieuRong"].Value;
        /*
        switch ($this["MaLoaiKichThuoc"].Value) {
            case "KTT":
                tongdao = $this["ChieuRong"].Value + $this["ChieuCao"].Value + $this["HeSoTongDao"].Value;
                break;
            case "KTN":
                tongdao = $this["ChieuRong"].Value + $this["ChieuCao"].Value + $this["HeSoTongDao"].Value;
                break;
            case "KTPBTP":
                tongdao = $this["ChieuRong"].Value + $this["ChieuCao"].Value + $this["HeSoTongDao"].Value;
                break;
            case "DRPBCN":
                tongdao = $this["ChieuRong"].Value + $this["ChieuCao"].Value;
                break;
            default:
                break;
        }
        */
        if (!isNaN(tongdao))
            this["TongDao"].setValue(tongdao);

    },
    calChatDai: function () {
        var cd = 0;
        if (this["ChieuCao"].Value == 0) {
            cd = this["ChieuDai"].Value;
            this["ChatDai"].setValue(cd);
        }
        else {
            if ((this["ChieuDai"].Value + this["ChieuRong"].Value) <= 1200)
                cd = (this["ChieuDai"].Value + this["ChieuRong"].Value) * 2 + this["HeSoChatDai"].Value;
            else
                cd = this["ChieuDai"].Value + this["ChieuRong"].Value + this["HeSoChatDai"].Value;
            if (!isNaN(cd))
                this["ChatDai"].setValue(cd);
            else
                this["ChatDai"].setValue(0);
        }
    },
    calXa: function () {
        var xa = 0;
        if (this.TongDao.Value < 900 || this.TongDao.Value >= 1800)
            xa = 2;
        else
            xa = 1;

        this.Xa.setValue(xa);
    },
  calKhoGiay: function () {
        var khoGiay = 0;
        var xa = 1;
        var $this = this;
        if (this.ChieuCao.Value == 0) {
            khoGiay = this.TongDao.Value;
            if (khoGiay < 900) {
                if (this.TongDao.Value > 0) {
                    do {
                        xa++;
                        khoGiay = Math.round(this.TongDao.Value * xa);
                    } while (khoGiay < 900);
                }
            }
        }
        else if (this.TongDao.Value && this.Xa.Value && this.Le.Value) {
            khoGiay = Math.round(this.TongDao.Value * this.Xa.Value + this.Le.Value);
            if (khoGiay < 900) {
                if (this.TongDao.Value > 0) {
                    do {
                        xa++;
                        khoGiay = Math.round(this.TongDao.Value * xa + this.Le.Value);
                    } while (khoGiay < 900);
                }
            }
        }
        this.Xa.setValue(xa);
        this.KhoGiay.setValue(khoGiay);
    } 
,
    calSoLuongTam: function () {
        if (this.Xa.Value > 0) {
            if ((this["ChieuDai"].Value + this["ChieuRong"].Value) <= 1200)
                this.SoLuongTam.setValue(Math.round(this.SoLuongHop.Value / this.Xa.Value));
            else
                this.SoLuongTam.setValue((this.SoLuongHop.Value / this.Xa.Value) * 2);
            /*
            if ((this.ChatDai.Value + this.ChieuRong.Value) * 2 + 50 < 2400)
                this.SoLuongTam.setValue(Math.round(this.SoLuongHop.Value / this.Xa.Value));
            else
                this.SoLuongTam.setValue((this.SoLuongHop.Value / this.Xa.Value) * 2);
                */
        }
        else
            this.SoLuongTam.setValue(0);
    },
    calThanhTien: function () {
        if (this.SoLuong.Value && this.DonGia.Value) {
            var val = this.DonGia.Value * this.SoLuong.Value;
            var temp = (val - Math.floor(val)).toString();
            if (temp.length > 4)
                temp = temp.substring(0, 4);
            val = Math.floor(val) + parseFloat(temp);
            this.ThanhTien.setValue(val);
        } else
            this.ThanhTien.setValue(0);
    },
    calDienTich: function () {
        if (this.IDLoaiSanPham.Value) {
            for (var i = 0; i < listLoaiSanPham.length; i++) {
                if (listLoaiSanPham[i].ID == this.IDLoaiSanPham.Value) {
                    var congThuc = listLoaiSanPham[i].CongThucTinhDienTichSanPham;
                    var ChieuDai = this.ChieuDai.Value;
                    var ChieuRong = this.ChieuRong.Value;
                    var ChieuCao = this.ChieuCao.Value;
                    var Le = this.Le.Value;
                    var Tai = this.Tai.Value;
                    if (congThuc) {
                        this.DienTichSanXuat.setValue(eval(congThuc));
                        this.DienTichXuatBan.setValue(eval(congThuc));
                    }
                }
            }
        }
    },
    calMaHangHoa: function () {
        var $this = this;
        var mkh = maKhachHang;
        if (!mkh)
            mkh = "";
        else {
            queryData("/WebService/DanhMuc.asmx/GetJSONKhachHang", "{}", function (result) {
                var dataKH = JSON.parse(result.d);
                for (var j = 0; j < dataKH.length; j++) {
                    if (dataKH[j].ID == mkh)
                        mkh = dataKH[j].MaHieuKhachHang;
                }
            }, null, false);
        }
        if (mkh && mkh.length > 4) {
            mkh = mkh.substring(0, 3);
        }
        //LopGiay
        var lopGiay = "";
        if (this.LoaiSongSanXuat.Value)
            $("#txtMaQuyDoi").val("");
        lopGiay = this.calMaQuyDoi();
        if (lopGiay && lopGiay.length > 3) {
            lopGiay = lopGiay.substring(0, 2);
        }
        var dai = "0000" + this.ChieuDai.Value;
        dai = dai.substring(dai.length - 4);
        var rong = "0000" + this.ChieuRong.Value;
        rong = rong.substring(rong.length - 4);
        var cao = "0000" + this.ChieuCao.Value;
        cao = cao.substring(cao.length - 4);
        var cd = "";
        queryData("/WebService/DanhMuc.asmx/GetJSONDataCongDoanForAutoComplete", "{}", function (result) {
            var dataCongDoan = JSON.parse(result.d);
            
            for (var k = 0; k < dataCongDoan.length; k++) {
                if (dataCongDoan[k].data == $this.CongDoanCuoi.Value)
                    cd = dataCongDoan[k].MaHieuCongDoan;
                
            }
        }, null, false);

        this.MaHieuMatHang.setValue(mkh + lopGiay + dai + rong + cao + this.MaLoaiKichThuoc.Value + cd);

    },
    huyXuLy: function () {
        if (this.ID.Value == 0) {
            return;
        }
        if (!confirm("Bạn có thực sự hủy xử lý mặt hàng này không?")) return;
        var $this = this;
        $("*").bind("click", disableClickEvent);// disable click event
        $.ajax({
            type: "POST",
            url: "/Administrator/QuanLyDonHang/DonHang/default.aspx/HuyXuLyMatHang",
            data: JSON.stringify($this.getJSON()),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                $("*").unbind("click", disableClickEvent); // enable click event
            },
            success: function (result) {
                if (result.d == "") {
                    window.location.reload(true);
                } else {
                    alert("Có lỗi trong quá trình xử lý\n" + result.d);
                    $("*").unbind("click", disableClickEvent); // enable click event
                }
            }
        });
    },
}, DataObject.prototype);

/*
*/
HangHoa = function (data) {
    this.data = {
        ID: 0,
        MaHieuMatHang: "",
        IDDonHang: 0,
        TenMatHang: "",
        MaHangTheoDon: "",
        NgayGiaoHang: 0,
        SoLuong: 0,
        IDDonVitinh: 0,
        DonViTinh: "",
        SoLuongMau: 0,
        MauSacMatNgoai: "",
        ChieuDai: 0,
        ChieuRong: 0,
        ChieuCao: 0,
        IDLoaiKichThuoc: 0,
        IDLoaiSanPham: 0,
        SoLop: 0,
        HeSoTongDao: 0,
        TongDao: 0,
        HeSoChatDai: 0,
        ChatDai: 0,
        Xa: 0,
        IDLoaiGiay: 0,
        KhoGiay: 0,
        DinhLuong: 0,
        LoaiSongSanXuat: 0,
        LoaiSongXuatBan: 0,
        Tai: 0,
        Le: 0,
        SoLuongTam: 0,
        SoLuongHop: 0,
        DienTichSanXuat: 0,
        DienTichXuatBan: 0,
        CongDoanCuoi: 0,
        DonGia: 0,
        ThanhTien: 0,
        GhiChu: "",
        LoaiSong: [],
        MaLoaiKichThuoc: ""
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
        if (this.data.ID) {
            this.data.ID = parseInt(this.data.ID);
            if (this.data.ID > 0) {
                var $this = this;
                queryData("/WebService/DanhMuc.asmx/GetJSONDataSongTheoMatHang", "{IDMatHang:" + this.data.ID + "}", function (result) {
                    var datasong = JSON.parse(result.d);
                    for (var j = 0; j < datasong.length; j++) {
                        $this.data.LoaiSong.push(datasong[j].IDSong);
                    }
                }, null, false);
            }
        } else
            this.data.ID = 0;
    } else
        this.data.ID = 0;
    this.data.RandomID = generateUUID();
}
HangHoa.prototype = {
    constructor: HangHoa,
    save: function (onComplete) {
        if (!this.data) {
            alert("Dữ liệu lỗi.")
            return;
        }
        var $this = this;
        $.ajax({
            type: "POST",
            url: "Default.aspx/AddOrUpdateChiTietDonHang",
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
                    if (onComplete)
                        onComplete(result);
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
            url: "Default.aspx/DeleteHangHoa",
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
    getDSSong: function (onSuccess) {
        queryData("/WebService/DanhMuc.asmx/GetJSONDataSongByIDArray", "{ID:[" + this.data.LoaiSong.join(", ") + "]}", function (result) {
            onSuccess(result);
        });
    },
    getDSDinhMucVatTu: function () {
        var arr = [];
        queryData("/Business/QuanLySanXuat/Default.aspx/GetDinhMucVatTu", "{IDMatHang:" + this.data.ID + "}", function (result) {
            arr = JSON.parse(result.d);
        }, null, false);
        return arr;
    },
    chonCoCauGiay: function (onSuccess) {
        var $this = this;

        $.ajax({
            type: "POST",
            url: "/Business/QuanLySanXuat/Default.aspx/ChonCoCauGiay",
            data: JSON.stringify($this.data),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (result) {
                if (onSuccess) {
                    onSuccess(result);
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
        if (isValid) {
            this.fireEvent(field, value);
            if ((type == "int" || type == "float") && field != "DienTichSanXuat" && field != "DienTichXuatBan")
                this.calDienTich();
        }
        return isValid;
    },
    setIDDonHang: function (val) {
        return this.setValue("IDDonHang", val, "int");
    },
    setTenMatHang: function (val) {
        return this.setValue("TenMatHang", val, "string");
    },
    setMaHangTheoDon: function (val) {
        return this.setValue("MaHangTheoDon", val, "string");
    },
    setMaHieuMatHang: function (val) {
        return this.setValue("MaHieuMatHang", val, "string");
    },

    setDonViTinh: function (val) {
        return this.setValue("IDDonVitinh", val, "int");
    },
    setTenDonViTinh: function (val) {
        return this.setValue("DonViTinh", val, "string");
    },
    setNgayGiaoHang: function (val) {
        return this.setValue("NgayGiaoHang", val, "string");
    },
    setSoLuong: function (val) {
        if (this.setValue("SoLuong", val, "float")) {
            this.calThanhTien();
            return true;
        }
        else return false;
    },
    setSoLuongMau: function (val) {
        return this.setValue("SoLuongMau", val, "int");
    },
    setMauSacMatNgoai: function (val) {
        return this.setValue("MauSacMatNgoai", val, "string");
    },
    setChieuDai: function (val) {
        var flag = this.setValue("ChieuDai", val, "float");
        this.calChatDai();
        this.calTongDao();
        return flag;
    },
    setChieuRong: function (val) {
        var flag = this.setValue("ChieuRong", val, "float");
        this.calChatDai();
        this.calTongDao();
        return flag;
    },
    setChieuCao: function (val) {
        return this.setValue("ChieuCao", val, "float");
    },
    setLoaiKichThuoc: function (val) {
        return this.setValue("IDLoaiKichThuoc", val, "int");
    },
    setLoaiSanPham: function (val) {
        return this.setValue("IDLoaiSanPham", val, "int");
    },
    setSoLop: function (val) {
        return this.setValue("SoLop", val, "int");
    },
    setHeSoTongDao: function (val) {
        var flag = this.setValue("HeSoTongDao", val, "int");
        this.calTongDao();
        return flag;
    },
    setHeSoChatDai: function (val) {
        var flag = this.setValue("HeSoChatDai", val, "float");
        this.calChatDai();
        return flag;
    },
    setTongDao: function (val) {
        var flag = this.setValue("TongDao", val, "int");
        this.calXa();
        return flag;
    },
    setChatDai: function (val) {
        var flag = this.setValue("ChatDai", val, "float");
        this.calSoLuongTam();
        return flag;
    },
    setXa: function (val) {
        var flag = this.setValue("Xa", val, "float");
        this.calSoLuongTam();
        return flag;
    },
    setLoaiGiay: function (val) {
        return this.setValue("IDLoaiGiay", val, "int");
    },
    setKhoGiay: function (val) {
        return this.setValue("KhoGiay", val, "float");
    },
    setDinhLuong: function (val) {
        return this.setValue("DinhLuong", val, "float");
    },
    setLoaiSongSanXuat: function (val) {
        return this.setValue("LoaiSongSanXuat", val, "int");
    },
    setLoaiSongXuatBan: function (val) {
        return this.setValue("LoaiSongXuatBan", val, "int");
    },
    setTai: function (val) {
        return this.setValue("Tai", val, "float");
    },
    setLe: function (val) {
        return this.setValue("Le", val, "float");
    },
    setSoLuongTam: function (val) {
        return this.setValue("SoLuongTam", val, "int");
    },
    setSoLuongHop: function (val) {
        var flag = this.setValue("SoLuongHop", val, "int");
        this.calSoLuongTam();
        return flag;
    },
    setDienTichSanXuat: function (val) {
        return this.setValue("DienTichSanXuat", val, "float");
    },
    setDienTichXuatBan: function (val) {
        return this.setValue("DienTichXuatBan", val, "float");
    },
    setCongDoanCuoi: function (val) {
        this.setValue("CongDoanCuoi", val, "int");
        return this.setValue("IDCongDoanCuoi", val, "int");
    },
    setDonGia: function (val) {
        if (this.setValue("DonGia", val, "int")) {
            this.calThanhTien();
            return true;
        }
        else return false;
    },
    setThanhTien: function (val) {
        return this.setValue("ThanhTien", val, "float");
    },
    setGhiChu: function (val) {
        return this.setValue("GhiChu", val, "string");
    },
    fireEvent: function (field, value) {
        $(this).trigger({
            type: "DataChanged",
            fieldName: field,
            value: value
        });
    },
    calThanhTien: function () {
        if (this.data.SoLuong && this.data.DonGia) {

            var val = this.data.DonGia * this.data.SoLuong;
            var temp = (val - Math.floor(val)).toString();
            if (temp.length > 6)
                temp = temp.substring(0, 6);
            val = Math.floor(val) + parseFloat(temp);

            this.setThanhTien(val);
        } else
            this.setThanhTien(0);
    },
    calDienTich: function () {
        if (this.data.IDLoaiSanPham) {
            for (var i = 0; i < listLoaiSanPham.length; i++) {
                if (listLoaiSanPham[i].ID == this.data.IDLoaiSanPham) {
                    var congThuc = listLoaiSanPham[i].CongThucTinhDienTichSanPham;
                    var ChieuDai = this.data.ChieuDai;
                    var ChieuRong = this.data.ChieuRong;
                    var ChieuCao = this.data.ChieuCao;
                    var Le = this.data.Le;
                    var Tai = this.data.Tai;
                    if (congThuc) {
                        this.setDienTichSanXuat(eval(congThuc));
                        this.setDienTichXuatBan(eval(congThuc));
                    }
                }
            }
        }
    }
}

/***
 * Yêu cầu sản xuất: YeuCauSanXuat
 */
var YeuCauSanXuat = function (initData) {
    DataObject.call(this, [
        { Name: "ID", Type: "int", Value: 0 },
        { Name: "IDCongDoan", Type: "int", Value: 0 },
        { Name: "IDMatHang", Type: "int", Value: 0 },
        { Name: "ThuTuThucHienCongDoan", Type: "int", Value: 0 },
        { Name: "TenCongDoan", Type: "string", Value: "" },
        { Name: "SoLuongDonHang", Type: "float", Value: 0 },
        { Name: "SoLuongLoi", Type: "float", Value: 0 },
        { Name: "SoLuongCanSanXuat", Type: "float", Value: 0 },
        { Name: "GhiChu", Type: "string", Value: "" },
        { Name: "TinhTrang", Type: "boolean", Value: false },
        { Name: "Selected", Type: "boolean", Value: false }
    ]);
    var keys = Object.getOwnPropertyNames(initData);
    for (var i = 0; i < keys.length; i++) {
        if (this[keys[i]]) {
            this[keys[i]].setValue(initData[keys[i]]);
        }
    }
}

YeuCauSanXuat.prototype = $.extend({
    markDelete: function (onComplete) {
        var $this = this;
        $.ajax({
            type: "POST",
            url: "Default.aspx/DeleteCongDoanSanXuat",
            data: JSON.stringify($this.getJSON()),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (result) {
                if (result.d == "" || result.d == "SUCCESS") {
                } else {
                    alert("Có lỗi trong quá trình xử lý\n" + result.d);
                }
                if (onComplete)
                    onComplete(result);
            }
        });
    }, save: function (onComplete) {
        var $this = this;
        if (!this["Selected"].Value) {
            this.markDelete(function (result) {
                onComplete(result);
            });
        }
        else {
            $.ajax({
                type: "POST",
                url: "Default.aspx/AddOrEditCongDoanSanXuat",
                data: JSON.stringify($this.getJSON()),
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    if (onComplete)
                        onComplete({ d: "Có lỗi trong quá trình xử lý: " + errorThrown.Message });
                },
                success: function (result) {
                    onComplete(result);
                }
            });
        }
    }
}, DataObject.prototype);

/***
 * Định mức vật tư: DinhMucVatTu
 */
//var DinhMucVatTu = function (initData) {
//    DataObject.call(this, [
//        { Name: "ID", Type: "int", Value: 0 },
//        { Name: "IDMatHang", Type: "int", Value: 0 },
//        { Name: "IDDonHang", Type: "int", Value: 0 },
//        { Name: "IDLenhSanXuatChiTiet", Type: "int", Value: 0 },
//        { Name: "IDLopGiay", Type: "int", Value: 0 },
//        { Name: "TenLop", Type: "string", Value: "" },
//        { Name: "IDPhatSinhTieuHaoVatTu", Type: "int", Value: 0 },
//        { Name: "IDVatTu", Type: "int", Value: 0 },
//        { Name: "TenVatTu", Type: "string", Value: "" },
//        { Name: "IDDonViTinh", Type: "int", Value: 0 },
//        { Name: "DonViTinh", Type: "string", Value: "" },
//        { Name: "HeSoTieuHao", Type: "float", Value: 0 },
//        { Name: "DinhLuong", Type: "float", Value: 0 },
//        { Name: "KhoGiay", Type: "float", Value: 0 },
//        { Name: "ChatDai", Type: "float", Value: 0 },
//        { Name: "SoLuongTam", Type: "float", Value: 0 },
//        { Name: "SoLuong", Type: "float", Value: 0 },
//        { Name: "SoLuongTon", Type: "float", Value: 0 },
//        { Name: "MaHieuVatTu", Type: "string", Value: "" }
//    ]);
//    $(this).on("DataChanged", function (evt) {
//        if (evt.fieldName === "IDLopGiay")
//            this.IDPhatSinhTieuHaoVatTu.Value = this.IDLopGiay.Value;
//        if (evt.fieldName === "DinhLuong" || evt.fieldName === "HeSoTieuHao")
//            this.calTongSo();
//    })
//    if (initData) {
//        var keys = Object.getOwnPropertyNames(initData);
//        for (var i = 0; i < keys.length; i++) {
//            if (this[keys[i]]) {
//                this[keys[i]].setValue(initData[keys[i]]);
//            }
//        }
//    }
//}
//DinhMucVatTu.prototype = $.extend({
//    setData: function (data) {
//        if (data) {
//            var keys = Object.getOwnPropertyNames(data);
//            for (var i = 0; i < keys.length; i++) {
//                if (this[keys[i]]) {
//                    this[keys[i]].setValue(data[keys[i]]);
//                }
//            }
//        }
//    },
//    calTongSo: function () {

//        console.log();
//        var tongso = this.DinhLuong.Value * this.KhoGiay.Value * this.ChatDai.Value * this.SoLuongTam.Value * this.HeSoTieuHao.Value / 1000000000;


//        if (!isNaN(tongso)) {
//            this.SoLuong.setValue(tongso);
//        }
//    },
//    save: function (onComplete) {
//        var $this = this;
//        console.log('khuong');
//        $.ajax({
//            type: "POST",
//            url: "Default.aspx/AddOrUpdateDinhMucVatTu",
//            data: JSON.stringify($this.getJSON()),
//            contentType: 'application/json; charset=utf-8',
//            dataType: 'json',
//            error: function (XMLHttpRequest, textStatus, errorThrown) {
//                console.log("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
//                if (onComplete)
//                    onComplete({ d: "Có lỗi trong quá trình xử lý: " + errorThrown });
//            },
//            success: function (result) {
//                onComplete(result);
//            }
//        });
//    }
//}, DataObject.prototype);





function DinhMucVatTu(data) {
    this.data = {
        ID: 0,
        IDMatHang: 0,
        IDDonHang: 0,
        IDLenhSanXuatChiTiet: 0,
        IDLopGiay: 0,
        TenLop: '',
        IDPhatSinhTieuHaoVatTu: 0,
        IDVatTu: 0,
        TenVatTu: '',
        IDDonViTinh: 0,
        DonViTinh: '',
        HeSoTieuHao: 0,
        DinhLuong: 0,
        KhoGiay: '',
        ChatDai: 0,
        SoLuongTam: 0,
        SoLuong: 0,
        SoLuongTon: 0,
        MaHieuVatTu: '',
        IDLoaiGiay: 0,
        TenLoaiGiay: '',
        TenLoaiVatTu: ''
    };
    this.dataVatTu = [];
    if (data) {
        $.extend(this.data, data);
        if (this.data.itemID) {
            this.data.itemID = parseInt(this.data.itemID);
        } else
            this.data.itemID = 0;
    }
}
DinhMucVatTu.prototype = {
    constructor: DinhMucVatTu,
    markDelete: function () {
        if (!this.data) {
            alert("Dữ liệu lỗi.")
            return;
        }
        if (!confirm("Bạn có thực sự muốn xóa định mức vật tư này không?")) return;
        var $this = this;
        $.ajax({
            type: "POST",
            url: "Default.aspx/DeleteDinhMucVatTu",
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
    setData: function (data) {
        if (data) {
            var keys = Object.getOwnPropertyNames(data);
            for (var i = 0; i < keys.length; i++) {
                if (this[keys[i]]) {
                    this[keys[i]].setValue(data[keys[i]]);
                }
            }
        }
    },
    calTongSo: function () {
        var tongso = this.DinhLuong.Value * this.KhoGiay.Value * this.ChatDai.Value * this.SoLuongTam.Value * this.HeSoTieuHao.Value / 1000000000;

        //console.log('tongso:' + tongso + '||,DinhLuong:' + this.DinhLuong.Value + ',KhoGiay:' + this.KhoGiay.Value + ',ChatDai:' + this.ChatDai.Value + ',SoLuongTam:' + this.SoLuongTam.Value + ',HeSoTieuHao:' + this.HeSoTieuHao.Value);

        if (!isNaN(tongso)) {
            this.SoLuong.setValue(tongso);
        }
    },
    save: function (onComplete) {
        var $this = this;
        $.ajax({
            type: "POST",
            url: "Default.aspx/AddOrUpdateDinhMucVatTu",
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
    }
}
