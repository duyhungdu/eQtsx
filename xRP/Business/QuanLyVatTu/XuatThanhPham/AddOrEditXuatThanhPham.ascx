<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddOrEditXuatThanhPham.ascx.cs" Inherits="xRP.Business.QuanLyVatTu.XuatThanhPham.AddOrEditXuatThanhPham" %>
<script type="text/javascript">
    var dataChiTiet = [];
    var dataVatTu = [];
    $(document).ready(function () {
        dataVatTu = JSON.parse('<%=DataVatTu%>');
        var phieuNhapData = "";
        $("#<%=txtMaPhieu.ClientID%>").focus();

        $('#<%=txtNgayXuat.ClientID %>').datetimepicker({
            mask: '99/99/9999', timepicker: false,
            format: 'd/m/Y',
        });

        if ("<%=ID_PhieuXuat%>" != "") {
            dataChiTiet = new PhieuXuat({ itemID: parseInt("<%=ID_PhieuXuat%>") }).getChiTietThanhPhamXuat();

            for (var i = 0; i < dataChiTiet.length; i++)
                    dataChiTiet[i].data.randomID = generateUUID();

                bindDataChiTiet(dataChiTiet);
        }
         
        queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataKhoVatTuForAutoComplete", "{}", function (result) {
            var objJSON = JSON.parse(result.d);
            $('#<%=txtKhoDen.ClientID%>').autocomplete({
                lookup: objJSON,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }

                },
                onSelect: function (suggestion) {
                    $('#<%=slcKhoDen.ClientID%>').val(suggestion.data);
                },
                onHint: function (hint) {
                },
                onInvalidateSelection: function () {
                    $('#<%=slcKhoChua.ClientID%>').val("");
                }
            });
        });

        $("#btnSave").on("click", function () {
            if (!confirm("Bạn có chắc muốn lưu phiếu xuất này không?")) {
                return false;
            }
            var phieuXuat = new PhieuXuat();
            phieuXuat.data.ID = parseInt("<%=ID_PhieuXuat%>");
            var maPhieu = $("#<%=txtMaPhieu.ClientID%>").val().trim();
            if (!maPhieu) {
                alert("Bạn chưa nhập mã phiếu");
                $("#<%=txtMaPhieu.ClientID%>").focus();
                return;
            }
            phieuXuat.data.MaHieuPhieuXuat = maPhieu;

            var ngayXuat = $("#<%=txtNgayXuat.ClientID%>").val();
            if (!ngayXuat) {
                alert("Bạn chưa nhập ngày xuất");
                $("#<%=txtNgayXuat.ClientID%>").focus();
                return;
            }
            phieuXuat.data.NgayXuat = ngayXuat;
            var khachHang = $("#<%=slcKhachHang.ClientID%>").val();
            if (!khachHang) {
                alert("Bạn chưa nhập " + $("#lblKhachHang").text());
                $("#<%=slcKhachHang.ClientID%>").focus();
                return;
            }
            phieuXuat.data.MaDonViNhan = parseInt(khachHang);

            var khoXuat = $("#<%=slcKhoChua.ClientID%>").val();
            if (!khoXuat) {
                alert("Không xác định kho xuất");
                return;
            }

            phieuXuat.data.MaKhoVatTu = parseInt(khoXuat);

            if ($("#<%=txtKhoDen.ClientID%>").css("display") != "none") {
                var khoDen = $("#<%=slcKhoDen.ClientID%>").val();
                if (!khoDen) {
                    alert("Bạn chưa nhập kho đến");
                    $("#<%=txtKhoDen.ClientID%>").focus();
                    return;
                }
                phieuXuat.data.MaKhoVatTuDen = parseInt(khoDen);
            }
            else
                phieuXuat.data.MaKhoVatTuDen = null;

            var tinhChat = $("#<%=ddlTinhChat.ClientID%>").val();
            if (!tinhChat) {
                alert("Bạn chưa chọn tính chất nhập xuất");
                $("#<%=ddlTinhChat.ClientID%>").focus();
                return;
            }
            phieuXuat.data.MaTinhChatNhapXuat = parseInt(tinhChat);


            phieuXuat.data.TinhTrang = 0;
            phieuXuat.data.KieuVatTu = 2;
            phieuXuat.data.GhiChu = $("#<%=txtGhiChu.ClientID%>").val();
            phieuXuat.save(function (result) {
                var idPhieu = "<%=ID_PhieuXuat%>";
                var newid = result.d;

                if ($.isNumeric(newid)) {
                    var c = 0;
                    var allResult = "";
                    if (dataChiTiet.length == 0) {
                        window.location.href = "<%=Util.SERVER_NAME %>/Business/QuanLyVatTu/Default.aspx?page=xtp";
                    }
                    $.each(dataChiTiet, function (idx, xuatthanhpham) {
                        if (xuatthanhpham.data.itemID == null) {
                            xuatthanhpham.data.itemID = 0;
                        }
                        xuatthanhpham.data.iDPhieuXuat = parseInt(newid);
                        xuatthanhpham.save(function (result) {
                            c++;
                            if (result.d && result.d != "SUCCESS") {
                                allResult += "\n" + result.d;
                            }
                            if (c == dataChiTiet.length && allResult != "") {
                                alert("Có lỗi trong quá trình xử lý: " + allResult);
                            }
                            if (c == dataChiTiet.length) {
                                window.location.href = "<%=Util.SERVER_NAME %>/Business/QuanLyVatTu/Default.aspx?page=xtp";
                            }
                        });
                        setTimeout(1000);
                    });
                } else {
                    alert("Có lỗi khi lưu dữ liệu\n" + result.d);
                }
            });
        });

        $("#btn-luu-print").on("click", function () {
            if (!confirm("Bạn có chắc muốn lưu phiếu xuất này không?")) {
                return false;
            }
            var phieuXuat = new PhieuXuat();
            phieuXuat.data.ID = parseInt("<%=ID_PhieuXuat%>");
            var maPhieu = $("#<%=txtMaPhieu.ClientID%>").val().trim();
            if (!maPhieu) {
                alert("Bạn chưa nhập mã phiếu");
                $("#<%=txtMaPhieu.ClientID%>").focus();
                return;
            }
            phieuXuat.data.MaHieuPhieuXuat = maPhieu;

            var ngayXuat = $("#<%=txtNgayXuat.ClientID%>").val();
            if (!ngayXuat) {
                alert("Bạn chưa nhập ngày xuất");
                $("#<%=txtNgayXuat.ClientID%>").focus();
                return;
            }
            phieuXuat.data.NgayXuat = ngayXuat;
            var khachHang = $("#<%=slcKhachHang.ClientID%>").val();
            if (!khachHang) {
                alert("Bạn chưa nhập " + $("#lblKhachHang").text());
                $("#<%=slcKhachHang.ClientID%>").focus();
                return;
            }
            phieuXuat.data.MaDonViNhan = parseInt(khachHang);

            var khoXuat = $("#<%=slcKhoChua.ClientID%>").val();
            if (!khoXuat) {
                alert("Không xác định kho xuất");
                return;
            }

            phieuXuat.data.MaKhoVatTu = parseInt(khoXuat);

            if ($("#<%=txtKhoDen.ClientID%>").css("display") != "none") {
                var khoDen = $("#<%=slcKhoDen.ClientID%>").val();
                if (!khoDen) {
                    alert("Bạn chưa nhập kho đến");
                    $("#<%=txtKhoDen.ClientID%>").focus();
                    return;
                }
                phieuXuat.data.MaKhoVatTuDen = parseInt(khoDen);
            }
            else
                phieuXuat.data.MaKhoVatTuDen = null;

            var tinhChat = $("#<%=ddlTinhChat.ClientID%>").val();
            if (!tinhChat) {
                alert("Bạn chưa chọn tính chất nhập xuất");
                $("#<%=ddlTinhChat.ClientID%>").focus();
                return;
            }
            phieuXuat.data.MaTinhChatNhapXuat = parseInt(tinhChat);

            /**
            */

            phieuXuat.data.TinhTrang = 0;
            phieuXuat.data.GhiChu = $("#<%=txtGhiChu.ClientID%>").val();
            phieuXuat.save(function (result) {
                var idPhieu = "<%=ID_PhieuXuat%>";
                var newid = result.d;
                if ($.isNumeric(newid)) {
                    var c = 0;
                    var allResult = "";
                    if (dataChiTiet.length == 0) {
                        window.location.href = "<%=Util.SERVER_NAME %>/Business/QuanLyVatTu/Default.aspx?page=xtp&id=" + newid;
                    }
                    $.each(dataChiTiet, function (idx, xuatthanhpham) {
                        xuatthanhpham.data.iDPhieuXuat = parseInt(newid);
                        xuatthanhpham.save(function (result) {
                            c++;
                            if (result.d && result.d != "SUCCESS") {
                                allResult += "\n" + result.d;
                            }
                            if (c == dataChiTiet.length && allResult != "") {
                                alert("Có lỗi trong quá trình xử lý: " + allResult);
                            }
                            if (c == dataChiTiet.length) {
                                window.location.href = "<%=Util.SERVER_NAME %>/Business/QuanLyVatTu/Default.aspx?page=xtp&id=" + newid;
                            }
                        });
                        setTimeout(1000);
                    });
                } else {
                    alert("Có lỗi khi lưu dữ liệu\n" + result.d);
                }
            });
        });

        $("#<%=ddlTinhChat.ClientID%>").on("change", function () {
            BindKhachHang(true)
        });
        $("#btnCancel").on("click", function () {
            window.location.href = "<%=Util.SERVER_NAME %>/Business/QuanLyVatTu/Default.aspx?page=xtp";
        });
        BindKhachHang(false)


        $("#btn-tao-moi-chi-tiet-phieu-thanh-pham-xuat").click(function () {
            $("#content_div").prop('title', 'Thêm mới phiếu thành phẩm xuất');
            var randID = generateUUID();
            var phieuyeucauid = '<%= ID_PhieuXuat%>';
            LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Business/QuanLyVatTu/XuatThanhPham/AddOrEditXuatThanhPhamChiTiet.ascx", "&id=0&randID=" + randID + "&phieuyeucauid=" + phieuyeucauid);

            $("#content_div").dialog({ modal: true, width: 800, height: 500 });
        });
    });

    function BindKhachHang(clearValue) {
        if (clearValue) {
            $('#<%=slcKhachHang.ClientID%>').val("");
                $('#<%=txtKhachHang.ClientID%>').val("");
                $('#<%=txtKhoDen.ClientID%>').val("");
                $('#<%=slcKhoDen.ClientID%>').val("");
            }
            for (var i = 0; i < dataTinhChatNhapXuat.length; i++) {
                if ($("#<%=ddlTinhChat.ClientID%>").val() == dataTinhChatNhapXuat[i].ID) {
                if (dataTinhChatNhapXuat[i].NoiBo) {
                    $("#lblKhachHang").text("Phòng ban/đơn vị");
                    $('#<%=txtKhoDen.ClientID%>').show();
                } else {
                    $("#lblKhachHang").text("Khách hàng");
                    $('#<%=txtKhoDen.ClientID%>').hide();
                }
                if (dataTinhChatNhapXuat[i].DieuChuyen) {
                    $("#lblKhoDen").text("Kho đến");
                    $("#<%=txtKhoDen.ClientID%>").show();
                    $("#rowKhoDen").show();
                } else {
                    $("#lblKhoDen").text("");
                    $("#<%=txtKhoDen.ClientID%>").hide();
                    $("#rowKhoDen").hide();
                }
            }
        }
        queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONKhachHangByTinhChatNhapXuat", "{idTinhChat:" + $("#<%=ddlTinhChat.ClientID%>").val() + "}", function (result) {
                var objJSON = JSON.parse(result.d);
                $('#<%=txtKhachHang.ClientID%>').autocomplete({
                lookup: objJSON,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }

                },
                onSelect: function (suggestion) {
                    $('#<%=slcKhachHang.ClientID%>').val(suggestion.data);
                },
                onHint: function (hint) {
                },
                onInvalidateSelection: function () {
                    $('#<%=slcKhachHang.ClientID%>').val("");
                }
            });
        });
    }
    function onChangTenXuatBan(ctr) {
        dataChiTiet[parseInt($(ctr).attr('datachitiet'))].data.tenXuatBan = $(ctr).val();
    }

    function bindDataChiTiet(dataChiTiet) {
        $("#tabDanhSachPhieuXuatThanhPham tbody").text("");
        for (var i = 0; i < dataChiTiet.length; i++) {
            $("#tabDanhSachPhieuXuatThanhPham tbody").append("<tr><td class='center-col'>" + (i + 1) + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.iDMatHang + "</td>" +
                "<td class='center-col'><input type='text' id='xuatthanhpham-" + i + "' datachitiet='" + i + "' class='ten-mat-hang' onchange='onChangTenXuatBan(this)' value='" + dataChiTiet[i].data.tenXuatBan + "' /></td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.dai + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.rong + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.cao + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.soLop + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.loaiSanPham + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.loaiKichThuoc + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.donViTinh + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.donGia + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.soLuongXuat + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.thanhTien + "</td>" +
                "<td class='center-col'>" +
                '<a class="edit-icon" href="javascript:OpenChiTietThanhPhamXuat(\'' + dataChiTiet[i].data.itemID + '\',\'' + dataChiTiet[i].data.randomID + '\');"></a>' +
                '<a class="delete-icon" href="javascript:deleteChiTietThanhPhamXuat(\'' + dataChiTiet[i].data.randomID + '\');"></a>'
                + "</td>"
                + "</tr>");
        }
    }

    $("#btnSave").on("click", function () {
        if (!confirm("Bạn có chắc muốn lưu phiếu xuất thành phẩm này không?")) {
            return false;
        }
        var phieuXuat = new PhieuXuat();
        phieuXuat.data.ID = parseInt("<%=ID_PhieuXuat%>");
        var maPhieu = $("#<%=txtMaPhieu.ClientID%>").val().trim();
        if (!maPhieu) {
            alert("Bạn chưa nhập mã phiếu");
            $("#<%=txtMaPhieu.ClientID%>").focus();
            return;
        }
        phieuXuat.data.MaHieuPhieuXuat = maPhieu;

        var ngayXuat = $("#<%=txtNgayXuat.ClientID%>").val();
        if (!ngayXuat) {
            alert("Bạn chưa nhập ngày xuất");
            $("#<%=txtNgayXuat.ClientID%>").focus();
            return;
        }
        phieuXuat.data.NgayXuat = ngayXuat;
        var khachHang = $("#<%=slcKhachHang.ClientID%>").val();
        if (!khachHang) {
            alert("Bạn chưa nhập " + $("#lblKhachHang").text());
            $("#<%=slcKhachHang.ClientID%>").focus();
            return;
        }
        phieuXuat.data.MaDonViNhan = parseInt(khachHang);

        var khoXuat = $("#<%=slcKhoChua.ClientID%>").val();
        if (!khoXuat) {
            alert("Không xác định kho xuất");
            return;
        }

        phieuXuat.data.MaKhoVatTu = parseInt(khoXuat);

        if ($("#<%=txtKhoDen.ClientID%>").css("display") != "none") {
            var khoDen = $("#<%=slcKhoDen.ClientID%>").val();
            if (!khoDen) {
                alert("Bạn chưa nhập kho đến");
                $("#<%=txtKhoDen.ClientID%>").focus();
                return;
            }
            phieuXuat.data.MaKhoVatTuDen = parseInt(khoDen);
        }
        else
            phieuXuat.data.MaKhoVatTuDen = null;

        var tinhChat = $("#<%=ddlTinhChat.ClientID%>").val();
        if (!tinhChat) {
            alert("Bạn chưa chọn tính chất nhập xuất");
            $("#<%=ddlTinhChat.ClientID%>").focus();
            return;
        }
        phieuXuat.data.MaTinhChatNhapXuat = parseInt(tinhChat);
        phieuXuat.data.TinhTrang = 0;
        phieuXuat.data.GhiChu = $("#<%=txtGhiChu.ClientID%>").val();
        phieuXuat.data.KieuVatTu = parseInt('<%=KieuVatTu%>');

        phieuXuat.save(function (result) {
            var idPhieu = "<%=ID_PhieuXuat%>";
            var newid = result.d;

            if ($.isNumeric(newid)) {
                var c = 0;
                var allResult = "";
                if (dataChiTiet.length == 0) {
                    window.location.href = "<%=Util.SERVER_NAME %>/Business/QuanLyVatTu/Default.aspx?page=pktx";
                }
                $.each(dataChiTiet, function (idx, thanhphamxuat) {
                    thanhphamxuat.data.iDPhieuXuat = parseInt(newid);
                    thanhphamxuat.save(function (result) {
                        c++;
                        if (result.d && result.d != "SUCCESS") {
                            allResult += "\n" + result.d;
                        }
                        if (c == dataChiTiet.length && allResult != "") {
                            alert("Có lỗi trong quá trình xử lý: " + allResult);
                        }
                        if (c == dataChiTiet.length) {
                            window.location.href = "<%=Util.SERVER_NAME %>/Business/QuanLyVatTu/Default.aspx?page=xtp";
                        }
                    });
                    setTimeout(1000);
                });
            } else {
                alert("Có lỗi khi lưu dữ liệu\n" + result.d);
            }
        });
    });



    function deleteChiTietThanhPhamXuat(mavattu) {
        if (!confirm("Bạn có chắc muốn xóa mặt hàng nhập này không?")) return;
        var delVatTu;
        for (var i = 0; i < dataChiTiet.length; i++) {
            if (dataChiTiet[i].data.randomID == mavattu) {
                delVatTu = dataChiTiet[i];
                dataChiTiet.splice(i, 1);
                delVatTu.markDelete(function (result) {
                    alert("Đã xóa mặt hàng nhập.")
                    // window.location.reload(true);
                });
                bindDataChiTiet(dataChiTiet);
                break;
            }
        }
    }

    function OpenChiTietThanhPhamXuat(id, randID) {
        //$("#content_div").prop('title', 'Chỉnh sửa chi tiết vật tư nhập: ' + id);
        var phieuyeucauid = '<%= ID_PhieuXuat%>';
        LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Business/QuanLyVatTu/XuatThanhPham/AddOrEditXuatThanhPhamChiTiet.ascx", "&id=" + id + "&randID=" + randID + "&phieuyeucauid=" + phieuyeucauid);
        var title = (id == "0" ? "Thêm mới" : "Chỉnh sửa") + " chi tiết mặt hàng";
        $("#content_div").dialog({ modal: true, width: 920, height: 500, title: title });
    }





    function CloseModal() {
        $("#content_div").dialog("close");
    }
</script>


<div class="splitter horizontal hub-splitter stateful toggle-button-enabled toggle-button-hotkey-enabled">
    <div class="rightPane" style="left: 0px;">
        <div class="hub-title">
        </div>
        <div class="right-hub-content">
            <div class="work-item-form">
                <div class="workitem-info-bar">
                    <div class="info-text-wrapper">
                        <span class="info-text">
                            <asp:Literal ID="ltTitle" runat="server"></asp:Literal></span>
                    </div>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block;">
                    <ul class="menu-bar">
                        <li class="menu-item icon-only" id="btn-luu">
                            <input type="button" class="menu-bar-item-button icon icon-save" id="btnSave" title="Lưu thông tin" />
                        </li>
                        <li class="menu-item icon-only" id="btn-luu-print">
                            <asp:Button ToolTip="Lưu và In" CssClass="menu-bar-item-button icon icon-save-printer" runat="server" ID="btnSavePrint" OnClientClick="return false;" />
                        </li>
                        <asp:Literal ID="ltPrint" runat="server"></asp:Literal>

                        <li class="menu-item icon-only" id="btn-cancel">
                            <input type="button" class="menu-bar-item-button icon cancel-icon" id="btnCancel" title="Thoát lưu dữ liệu" />
                        </li>
                    </ul>
                </div>
                <div class="work-item-view" style="margin-left: 10px;">

                    <table class="witform-layout">
                        <tbody>
                            <tr>
                                <td style="width: 10%;"></td>
                                <td style="width: 40%;"></td>
                                <td style="width: 10%;"></td>
                                <td style="width: 40%;"></td>
                            </tr>
                            <tr>
                                <td>Mã phiếu
                                </td>
                                <td>
                                    <div class="workitemcontrol">
                                        <div class="combo tree drop short-control-30">
                                            <div class="wrap">
                                                <%--<input type="text" id="txtMaPhieu" autocomplete="off" maxlength="255" title="CNS" runat="server" />--%>
                                                <asp:TextBox ID="txtMaPhieu" CssClass="disable-textbox" ReadOnly="true" runat="server"></asp:TextBox>
                                            </div>

                                        </div>
                                    </div>
                                </td>
                                <td>Ngày xuất
                                </td>
                                <td>
                                    <div class="workitemcontrol">
                                        <div class="combo tree drop short-control-50">
                                            <div class="wrap">
                                                <input type="text" id="txtNgayXuat" placeholder="__/__/____" name="field-name" class="combo tree drop" style="width: 40%" runat="server" />
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>Tính chất nhập xuất</td>
                                <td>
                                    <div class="workitemcontrol">
                                        <div class="combo tree drop short-control-50">
                                            <div class="wrap" style="display: block">
                                                <asp:DropDownList ID="ddlTinhChat" runat="server" Height="20px"></asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td>Kho xuất</td>
                                <td>
                                    <div class="workitemcontrol">
                                        <div class="combo tree drop short-control-50">
                                            <div class="wrap">
                                                <asp:HiddenField ID="slcKhoChua" runat="server" ClientIDMode="Static" />
                                                <asp:Label ID="lblKhoChua" runat="server" Text=""></asp:Label>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td><span id="lblKhachHang" /></td>
                                <td colspan="3">
                                    <div class="workitemcontrol">
                                        <div class="combo tree drop">
                                            <div class="wrap">
                                                <asp:HiddenField ID="slcKhachHang" runat="server" />
                                                <input type="text" id="txtKhachHang" autocomplete="off" title="CNS" runat="server" />
                                            </div>
                                        </div>
                                    </div>
                                </td>

                            </tr>
                            <tr id="rowKhoDen">
                                <td><span id="lblKhoDen" /></td>
                                <td>
                                    <div class="workitemcontrol">
                                        <div class="combo tree drop short-control-50">
                                            <div class="wrap">
                                                <asp:HiddenField ID="slcKhoDen" runat="server" />
                                                <asp:TextBox ID="txtKhoDen" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Ghi chú</td>
                                <td colspan="3">
                                    <asp:TextBox ID="txtGhiChu" TextMode="MultiLine" runat="server" Width="100%" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="work-item-bonus">
                        <asp:Literal ID="ltButtonNewChiTietVatTuXuat" runat="server"></asp:Literal>
                    </div>
                    <asp:Panel runat="server" ID="pnChiTietVatTu">
                        <div id="" class="div-data">
                            <table class="data-table tab-detail" id="tabDanhSachPhieuXuatThanhPham">
                                <thead>
                                    <tr>
                                        <td>STT</td>
                                        <td>Mã hàng</td>
                                        <td>Tên hàng</td>
                                        <td>Dài</td>
                                        <td>Rộng</td>
                                        <td>Cao</td>
                                        <td>Số lớp</td>
                                        <td>Loại sản phẩm</td>
                                        <td>Loại kích thước</td>
                                        <td>Đơn vị tính</td>
                                        <td>Đơn giá</td>
                                        <td>Số lượng</td>
                                        <td>Thành tiền</td>
                                        <td>Chức năng</td>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
        <div class="clear"></div>
    </div>
</div>
<div id="content_div" title="Thêm mới phiếu thành phẩm xuất">
</div>


