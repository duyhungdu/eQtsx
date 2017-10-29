<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddOrEditPhieuKiemTraVatTuXuat.ascx.cs" Inherits="xRP.Business.QuanLyVatTu.XuatVatTu.AddOrEditPhieuKiemTraVatTuXuat" %>
<%@ Register Src="~/Business/QuanLyVatTu/XuatVatTu/AddOrEditChiTietPhieuKiemTraVatTuXuat.ascx" TagPrefix="uc1" TagName="AddOrEditChiTietPhieuKiemTraVatTuXuat" %>

<script type="text/javascript">
    var dataChiTiet = [];
    var dataVatTu = [];
    var isEditable = true;
    var phieuYeuCau = "";
    $(document).ready(function () {
        dataVatTu = JSON.parse('<%=DataVatTu%>');
        var phieuNhapData = "";
        $("#<%=txtMaPhieu.ClientID%>").focus();

        $('#<%=txtNgayXuat.ClientID %>').datetimepicker({
            mask: '99/99/9999', timepicker: false,
            format: 'd/m/Y',
        });

        new PhieuXuat({ itemID: parseInt("<%=ID_PhieuXuat%>") }).getChiTietPhieuXuat(function (result) {
            for (var i = 0; i < result.length; i++) {
                result[i].SoLuongDauCuonHienTai = result[i].SoluongconLai;
                result[i].SoLuongConLai = result[i].SoluongconLai;
                result[i].SoLuongDauCuonBanDau = result[i].SoLuongDauCuon;
                dataChiTiet.push(new VatTuXuat(result[i]));
            }
            bindDataChiTiet(dataChiTiet);
        });

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
        queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataPhieuYeuCau2", "{}", function (result) {
            var objJSON = JSON.parse(result.d);
            $('#<%=txtPhieuYeuCau.ClientID%>').autocomplete({
                lookup: objJSON,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }

                },
                onSelect: function (suggestion) {
                    $('#<%=slcPhieuYeuCau.ClientID%>').val(suggestion.data);
                    phieuYeuCau = suggestion.data;
                },
                onHint: function (hint) {
                },
                onInvalidateSelection: function () {
                    $('#<%=slcPhieuYeuCau.ClientID%>').val("");
                    phieuYeuCau = "";
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

            /**
            */

            phieuXuat.data.TinhTrang = 0;
            phieuXuat.data.GhiChu = $("#<%=txtGhiChu.ClientID%>").val();
            $("input").prop("disabled", true);
            phieuXuat.save(function (result) {
                var idPhieu = "<%=ID_PhieuXuat%>";
                var newid = result.d;

                if ($.isNumeric(newid)) {
                    var c = 0;
                    var allResult = "";
                    if (dataChiTiet.length == 0) {
                        window.location.href = "<%=Util.SERVER_NAME %>/Business/QuanLyVatTu/Default.aspx?page=pktx";
                    }
                    $.each(dataChiTiet, function (idx, vattuxuat) {
                        vattuxuat.data.iDPhieuXuat = parseInt(newid);
                        vattuxuat.data.MaPhieuXuat = parseInt(newid);

                        vattuxuat.save(function (result) {
                            c++;
                            if (result.d && result.d != "SUCCESS") {
                                allResult += "\n" + result.d;
                            }
                            if (c == dataChiTiet.length && allResult != "") {
                                alert("Có lỗi trong quá trình xử lý: " + allResult);
                                $("input").prop("disabled", false);
                            }
                            if (c == dataChiTiet.length) {
                                window.location.href = "<%=Util.SERVER_NAME %>/Business/QuanLyVatTu/Default.aspx?page=pktx";
                            }
                        });
                    });
                } else {
                    alert("Có lỗi khi lưu dữ liệu\n" + result.d);
                    $("input").prop("disabled", false);
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


            phieuXuat.data.TinhTrang = 0;
            phieuXuat.data.GhiChu = $("#<%=txtGhiChu.ClientID%>").val();

            phieuXuat.data.KieuVatTu = parseInt('<%=KieuVatTu%>');

            $("input").prop("disabled", true);
            phieuXuat.save(function (result) {
                var idPhieu = "<%=ID_PhieuXuat%>";
                var newid = result.d;
                if ($.isNumeric(newid)) {
                    var c = 0;
                    var allResult = "";
                    if (dataChiTiet.length == 0) {
                        window.location.href = "<%=Util.SERVER_NAME %>/Business/QuanLyVatTu/Default.aspx?page=ppx&id=" + newid;
                    }
                    $.each(dataChiTiet, function (idx, vattuxuat) {
                        vattuxuat.data.MaPhieuXuat = parseInt(newid);
                        vattuxuat.save(function (result) {
                            c++;
                            if (result.d && result.d != "SUCCESS") {
                                allResult += "\n" + result.d;
                            }
                            if (c == dataChiTiet.length && allResult != "") {
                                alert("Có lỗi trong quá trình xử lý: " + allResult);
                                $("input").prop("disabled", false);
                            }
                            if (c == dataChiTiet.length) {
                                window.location.href = "<%=Util.SERVER_NAME %>/Business/QuanLyVatTu/Default.aspx?page=ppx&id=" + newid;
                            }
                        });
                    });
                } else {
                    alert("Có lỗi khi lưu dữ liệu\n" + result.d);
                    $("input").prop("disabled", false);
                }
            });
        });

        $("#<%=ddlTinhChat.ClientID%>").on("change", function () {
            BindKhachHang(true);
            if ("<%=ID_PhieuXuat%>" == "" || "<%=ID_PhieuXuat%>" == "0") {
                queryData("/WebService/DanhMuc.asmx/SinhMaPhieu", "{maTinhChat:\"" + $(this).val() + "\", tenBang: \"*\"}", function (result) {
                    $("#<%=txtMaPhieu.ClientID%>").val(result.d);
                 }, null, true);
            }
        });
        $("#btnCancel").on("click", function () {
            window.location.href = "<%=Util.SERVER_NAME %>/Business/QuanLyVatTu/Default.aspx?page=pktx";
        });
        $("#btnPrint").on("click", function () {
            window.location.href = "<%=Util.SERVER_NAME %>/Business/QuanLyVatTu/Default.aspx?page=ppx&id=" + parseInt("<%=ID_PhieuXuat%>");
        });
        BindKhachHang(false)
    });

    function BindKhachHang(clearValue) {
        if (clearValue) {
            $('#<%=slcKhachHang.ClientID%>').val("");
            $('#<%=txtKhachHang.ClientID%>').val("");
            $('#<%=txtKhoDen.ClientID%>').val("");
            $('#<%=slcKhoDen.ClientID%>').val("");
        }
        var laXuatTraLai = false;
        for (var i = 0; i < dataTinhChatNhapXuat.length; i++) {
            if ($("#<%=ddlTinhChat.ClientID%>").val() == dataTinhChatNhapXuat[i].ID) {
                $("#lbPhieuYeuCau").show();
                $("#<%=txtPhieuYeuCau.ClientID%>").show();
                if (dataTinhChatNhapXuat[i].NoiBo) {
                    $("#lblKhachHang").text("Phòng ban/đơn vị");
                    $('#<%=txtKhoDen.ClientID%>').show();
                } else if (dataTinhChatNhapXuat[i].TenTinhChatNhapXuat == "Xuất trả lại") {
                    $("#lbPhieuYeuCau").hide();
                    $("#<%=txtPhieuYeuCau.ClientID%>").hide();
                    $("#lblKhachHang").text("Nhà cung cấp");
                    $('#<%=txtKhoDen.ClientID%>').hide();
                    laXuatTraLai = true;
                } else {
                    $("#lblKhachHang").text("Khách hàng");
                    $('#<%=txtKhoDen.ClientID%>').hide();
                }
            if (dataTinhChatNhapXuat[i].DieuChuyen) {
                $("#lblKhoDen").text("Kho đến");
                $("#<%=txtKhoDen.ClientID%>").show();
                $("#rowKhoDen").show();
            }
            else {
                $("#lblKhoDen").text("");
                $("#<%=txtKhoDen.ClientID%>").hide();
                    $("#rowKhoDen").hide();
                }
            }
        }
        isXuatTraLai = laXuatTraLai;
        for (var i=0; i<dataChiTiet.length; i++)
            dataChiTiet[i].calSoLuongThucXuat(laXuatTraLai);
        bindDataChiTiet(dataChiTiet);

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

    function bindDataChiTiet(dataChiTiet) {
        $("#tabDanhSachPhieuXuatVatTu tbody").text("");
        for (var i = 0; i < dataChiTiet.length; i++) {
            $("#tabDanhSachPhieuXuatVatTu tbody").append("<tr><td class='center-col'>" + (i + 1) + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.MaHieuVatTu + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.TenVatTu + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.DonViTinh + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.SoLuongDauCuonBanDau + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.SoLuongConLaiCuoiNgay + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.DinhLuongTieuChuan + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.DinhLuongThucTe + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.KichThuocTieuChuan + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.KichThuocThucTe + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.SoLuongThucXuat + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.DonGia + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.ThanhTien + "</td>" +
                "<td class='center-col'>" +
                '<a class="edit-icon" href="javascript:OpenChiTietVatTu(\'' + dataChiTiet[i].data.ID + '\',\'' + dataChiTiet[i].data.RandomID + '\');"></a>' +
                   '<a class="delete-icon" href="javascript:deleteChiTietVatTu(\'' + dataChiTiet[i].data.RandomID + '\');"></a>'
                + "</td>"
                + "</tr>");
        }
    }


    function deleteChiTietVatTu(mavattu) {
        if (!confirm("Bạn có chắc muốn xóa vật tư này không?")) return;
        var delVatTu;
        for (var i = 0; i < dataChiTiet.length; i++) {
            if (dataChiTiet[i].data.RandomID == mavattu) {
                delVatTu = dataChiTiet[i];
                dataChiTiet.splice(i, 1);
                if (delVatTu.ID) {
                    delVatTu.markDelete(function (result) {
                        alert("Đã xóa chi tiết vật tư nhập")
                        window.location.reload(true);
                    });
                }
                bindDataChiTiet(dataChiTiet);
                break;
            }
        }
    }

    function OpenChiTietVatTu(id, randID) {
        //$("#content_div").prop('title', 'Chỉnh sửa chi tiết vật tư nhập: ' + id);
        LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Business/QuanLyVatTu/XuatVatTu/AddOrEditChiTietPhieuKiemTraVatTuXuat.ascx", "&id=" + randID);
        var title = (id == "0" ? "Thêm mới" : "Chỉnh sửa") + " chi tiết vật tư xuất";
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

                        <asp:Literal ID="ltAccept" runat="server"></asp:Literal>

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
                                                <asp:DropDownList ID="ddlTinhChat" runat="server" Height="20px" ClientIDMode="Static"></asp:DropDownList>
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
                                <td>
                                    <div class="workitemcontrol">
                                        <div class="combo tree drop">
                                            <div class="wrap">
                                                <asp:HiddenField ID="slcKhachHang" runat="server" />
                                                <input type="text" id="txtKhachHang" autocomplete="off" title="CNS" runat="server" style="width: 94%;" />
                                                <a class="icon icon-refresh" style="height: 21px; margin-left: 3px;" id="btnRefresh" title="Tải lại dữ liệu" onclick="BindKhachHang(); return false;"></a>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <span id="lbPhieuYeuCau1" style="display:none">Theo phiếu yêu cầu</span>
                                </td>
                                <td>
                                    <div class="workitemcontrol" style="display:none">
                                        <div class="combo tree drop">
                                            <div class="wrap">
                                                <asp:HiddenField ID="slcPhieuYeuCau" runat="server" />
                                                <input type="text" id="txtPhieuYeuCau" autocomplete="off" title="CNS" runat="server" />
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
                            <table class="data-table tab-detail" id="tabDanhSachPhieuXuatVatTu">
                                <thead>
                                    <tr>
                                        <td>STT</td>
                                        <td>Mã VT</td>
                                        <td>Tên VT</td>
                                        <td>Đơn vị tính</td>
                                        <td>SL đầu cuộn</td>
                                        <td>SL còn lại cuối ngày</td>
                                        <td>ĐL tiêu chuẩn</td>
                                        <td>ĐL thực tế</td>
                                        <td>Kích thước TC</td>
                                        <td>Kích thước TT</td>
                                        <td>SL thực xuất</td>
                                        <td>Giá xuất</td>
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
<div id="content_div" title="Thêm mới vật tư xuất">
</div>

<script type="text/ecmascript">
    function CloseModal() {
        $("#content_div").dialog("close");
    }
    $(function () {
        $("#btn-tao-moi-chi-tiet-kiem-tra-vat-tu-xuat").click(function () {
            $("#content_div").prop('title', 'Thêm mới vật tư xuất');
            LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Business/QuanLyVatTu/XuatVatTu/AddOrEditChiTietPhieuKiemTraVatTuXuat.ascx", "&id=;");
            $("#content_div").dialog({ modal: true, width: 800, height: 500 });
        });
    });
    function duyetPhieuXuat(id) {
        new PhieuXuat({
            itemID: id
        }).duyetPhieuXuat();
    }
</script>
