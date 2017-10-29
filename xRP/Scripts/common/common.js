var disableClickEvent = function (evt) {
    evt.preventDefault();
}

var dropdown_button = function () {
    $("#ul_dropdown").slideToggle('fast');
}
function LoadUserControl(page, url, param) {
    if (url != "#") {
        var dataValue = "{url:'" + url + "',param:'" + param + "'}";
        $.ajax({
            url: page + "/AddControl",
            type: "POST",
            data: dataValue,
            contentType: "application/json; charset=utf-8",
            beforeSend: function () {
                $("#content_div").html("");
            },
            success: OnSuccess,
            error: OnError
        });
    }
}
function loadForm(url) {
    $("#content_div").load(url);
}
function OnSuccess(data) {
    LoadControl(data);
}
function OnError() {
    LoadError();
}
function LoadControl(data) {
    $("#content_div").html(data.d);
}

function queryData(dataUrl, params, success, error, fasync) {
    if (fasync !== true && fasync !== false) fasync = true;
    $.ajax({
        type: "POST",
        url: dataUrl,
        data: params,
        cache: false,
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        async: fasync,
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (error)
                error();
        },
        success: function (result) {
            if (success)
                success(result);
        }
    });
}
function generateUUID() {
    var d = new Date().getTime();
    var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
        var r = (d + Math.random() * 16) % 16 | 0;
        d = Math.floor(d / 16);
        return (c == 'x' ? r : (r & 0x7 | 0x8)).toString(16);
    });
    return uuid;
};


/*
Custom field
*/
var Field = function (f) {
    var $this = this;
    if (typeof f == "undefined" || f == null || !f.hasOwnProperty("Name") || !f.hasOwnProperty("Type")) {
        throw "Invalid field type declaration!";
    }

    this.Name = f.Name;
    this.Type = f.Type;
    this.BindingObject = null;
    var ControlFieldName = (typeof f.BindingControl == "undefined" || f.BindingControl.trim() == "" ? null : f.BindingControl.trim());
    if (ControlFieldName) {
        this.BindingObject = document.getElementById(ControlFieldName);
        if (this.BindingObject) {
            $(this.BindingObject).on("change", function () {
                $this.setValue($($this.BindingObject).val());
            });
        }
    }
    this.DisplayName = f.hasOwnProperty("DisplayName") ? f.DisplayName : f.Name;
    this.setValue((f.hasOwnProperty("Value") ? f.Value : ""));
}

Field.prototype = {
    constructor: Field,
    setValue: function (value, handleEvent) {
        var oldValue = this.Value;
        var isValid = true;
        if (value == null)
            this.Value = null;
        else
            switch (this.Type) {
                case "string":

                    if (value || value === "")
                        this.Value = value.toString();
                    else {
                        alert("Dữ liệu " + this.DisplayName + " phải là kiểu xâu");
                        isValid = false;
                    }
                    break;
                case "int":
                    if (!$.isNumeric(value)) {
                        alert("Dữ liệu " + this.DisplayName + " phải là kiểu số nguyên");
                        isValid = false;
                    } else
                        this.Value = parseInt(value);
                    break;
                case "float":
                    if (!$.isNumeric(value)) {
                        alert("Dữ liệu " + this.DisplayName + " phải là kiểu số thực");
                        isValid = false;
                    } else
                        this.Value = parseFloat(value);
                    break;
                case "boolean":
                    if (value === true || value === false) {
                        this.Value = value;
                        isValid = false;
                    } else if (value.toString() === "true" || value.toString() === "false") {
                        this.Value = value.toString() === "true";
                    } else {
                        alert("Dữ liệu " + this.DisplayName + " phải là kiểu số boolean");
                        isValid = false;
                    }
                    break;
                default:
                    alert("Kiểu dữ liệu không được định nghĩa: " + this.DisplayName);
                    isValid = false;
                    break;
            }
        if (isValid) {
            if (this.BindingObject) {
                if (this.BindingObject.value !== "undefined") {
                    $(this.BindingObject).val(this.Value);
                } else {
                    $(this.BindingObject).text(this.Value);
                }
            }
            this.fireEvent(this.Value, oldValue);
        }
        return isValid;
    },
    getValue: function () {
        return this.Value;
    },
    fireEvent: function (value, oldValue) {
        if (value != oldValue)
            $(this).trigger({
                type: "DataChanged",
                fieldName: this.Name,
                value: value
            });
    },
    toString: function () {
        this.getValue();
    }
}

/*
 * Data object
 * Constructor: initData: Array of fields
 */
var DataObject = function (initData) {
    this.ID = 0;
    this.GUID = generateUUID();
    if (typeof initData == "undefined" || initData == null)
        return;
    if (!initData instanceof Array)
        throw "Init data object parameters must a array of field(s)";
    var $this = this;
    $.each(initData, function (i) {
        var f = new Field(initData[i]);
        $(f).on("DataChanged", function (evt) {
            $this.fireEvent(evt);
        });
        var fName = f.Name;
        $this[fName] = f;
    });
    return $this;
}

DataObject.prototype = {
    constructor: DataObject,
    getJSON: function () {
        var data = {};
        var props = Object.getOwnPropertyNames(this);
        var $this = this;
        $.each(props, function (i) {
            if (Field.prototype.isPrototypeOf($this[props[i]])) {
                data[props[i]] = $this[props[i]].getValue();
            }
        });
        return data;
    }, fireEvent: function (evt) {
        $(this).trigger({
            type: "DataChanged",
            fieldName: evt.fieldName,
            value: evt.value
        });
    }
}

/*
 Loai vat tu data object
 */
LoaiVatTu = function (data) {
    this.data = {
        itemID: 0,
        maLoai: "",
        tenLoai: "",
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
LoaiVatTu.prototype = {
    constructor: LoaiVatTu,
    save: function (onComplete) {
        if (!this.data) {
            alert("Dữ liệu lỗi.")
            return;
        }
        var $this = this;
        $.ajax({
            type: "POST",
            url: "Default.aspx/AddOrUpdateItem",
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
                        onComplete();
                } else {
                    if (!$.isNumeric(result.d)) {
                        alert(result.d);
                    }
                    if (onComplete)
                        onComplete();
                }
            }
        });
    },
    markDelete: function () {
        if (!this.data) {
            alert("Dữ liệu lỗi.")
            return;
        }
        if (!confirm("Bạn có thực sự muốn xóa đơn vị tính  này không?")) return;
        var $this = this;
        $.ajax({
            type: "POST",
            url: "Default.aspx/DeleteItem",
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
    }
}

function formatNumber(num, tp) {
    if ($.isNumeric(num)) {
        num = parseFloat(num);
        var tpInput = 2;
        if (tp != null && $.isNumeric(tp) && tp >= 0)
            tpInput = tp;

        var p = num.toFixed(tpInput).split(".");

        if (tpInput == 0)
            return p[0].split("").reverse().reduce(function (acc, num, i, orig) {
                return num + (i && !(i % 3) ? "." : "") + acc;
            }, "");
        else
            return p[0].split("").reverse().reduce(function (acc, num, i, orig) {
                return num + (i && !(i % 3) ? "." : "") + acc;
            }, "") + "," + p[1];

    }
    return 0;
}