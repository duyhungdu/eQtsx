function NhapThanhPham(data) {
    this.data = {
        itemID: 0,
        randomID: '',
        iDPhieuNhap: 0,
        iDMatHang: 0,
        maHieuMatHang: '',
        tenMatHang: '',
        dai: 0,
        rong: 0,
        cao: 0,
        soLop: 0,
        loaiSanPham: '',
        loaiKichThuoc: '',
        soLuongNhap: 0,
        iDDonViTinh: 0,
        donViTinh: '',
        donGia: 0,
        thanhTien: 0,
        tinhTrang: ''
    };
    if (data) {
        $.extend(this.data, data);
        if (this.data.itemID) {
            this.data.itemID = parseInt(this.data.itemID);
        } else
            this.data.itemID = 0;
    }
}

NhapThanhPham.prototype = {
    constructor: NhapThanhPham,
    markDelete: function () {
        if (!this.data) {
            alert("Dữ liệu lỗi.")
            return;
        }
        if (!confirm("Bạn có thực sự muốn xóa thành phẩm nhập này không?")) return;
        var $this = this;
        $.ajax({
            type: "POST",
            url: "Default.aspx/DeleteNhapThanhPham",
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
            url: "Default.aspx/AddOrEditNhapThanhPhamChiTiet",
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
    }
}


function XuatThanhPham(data) {
    this.data = {
        itemID: 0,
        randomID: '',
        iDPhieuXuat: 0,
        iDMatHang: 0,
        tenMatHang: '',
        dai: 0,
        rong: 0,
        cao: 0,
        soLop: 0,
        loaiSanPham: '',
        loaiKichThuoc: '',
        tenXuatBan: '',
        iDDonViTinh: 0,
        donViTinh: '',
        soLuongXuat: 0,
        donGia: 0,
        thanhTien: 0,
        ghiChu: "",
        tinhTrang:''
    };
    if (data) {
        $.extend(this.data, data);
        if (this.data.itemID) {
            this.data.itemID = parseInt(this.data.itemID);
        } else
            this.data.itemID = 0;
    }
}

XuatThanhPham.prototype = {
    constructor: XuatThanhPham,
    markDelete: function () {
        if (!this.data) {
            alert("Dữ liệu lỗi.")
            return;
        }
        if (!confirm("Bạn có thực sự muốn xóa thành phẩm xuất này không?")) return;
        var $this = this;
        $.ajax({
            type: "POST",
            url: "Default.aspx/DeleteXuatThanhPham",
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
        //console.log(JSON.stringify(this.data)); 
        $.ajax({
            type: "POST",
            url: "Default.aspx/AddOrEditXuatThanhPhamChiTiet",
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
    }
}
