function TenLopGiay(data) {
    this.data = {
        itemID: 0,
        tenLop: "",
        danhMucSong: "",
        kichHoat: true,
    };
    if (data) {
        $.extend(this.data, data);
        if (this.data.itemID) {
            this.data.itemID = parseInt(this.data.itemID);
        } else
            this.data.itemID = 0;
    }
}

TenLopGiay.prototype = {
    constructor: TenLopGiay,
    markDelete: function () {
        if (!this.data) {
            alert("Dữ liệu lỗi.")
            return;
        }
        if (!confirm("Bạn có thực sự muốn xóa phân loại tên lớp giấy này không?")) return;
        var $this = this;
        $.ajax({
            type: "POST",
            url: "Default.aspx/DeleteTenLopGiay",
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
            url: "Default.aspx/AddOrEditTenLopGiay",
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
