function PhanLoaiSong(data) {
    this.data = {
        itemID: 0,
        kiHieuCoCauGiay: "",
        moTaCoCauGiay: 0,
        kiHieuQuyDoi: "",
        soLop: 0,
        kichHoat: true,
        ghiChu: ""
    };
    if (data) {
        $.extend(this.data, data);
        if (this.data.itemID) {
            this.data.itemID = parseInt(this.data.itemID);
        } else
            this.data.itemID = 0;
    }
}

PhanLoaiSong.prototype = {
    constructor: PhanLoaiSong,
    markDelete: function () {
        if (!this.data) {
            alert("Dữ liệu lỗi.")
            return;
        }
        if (!confirm("Bạn có thực sự muốn xóa phân loại sóng này không?")) return;
        var $this = this;
        $.ajax({
            type: "POST",
            url: "Default.aspx/DeletePhanLoaiSong",
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
            url: "Default.aspx/AddOrEditPhanLoaiSong",
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
