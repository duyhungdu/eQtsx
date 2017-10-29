<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddOrEditPhieuKiemTraVatTuNhap.ascx.cs" Inherits="xRP.Business.QuanLyVatTu.KiemTraVatTuNhap.AddOrEditPhieuKiemTraVatTuNhap" %>
<%@ Register Assembly="CollectionPager" Namespace="SiteUtils" TagPrefix="cc1" %>
<script type="text/javascript">
    var dataChiTiet = [];
    var dataVatTu = [];
    var tinhChatNhapXuat = [];
    var isEditable = true;

    function loadNhaCungCap() {
        queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataNhaCungCapForAutoComplete", "{}", function (result) {
            var objJSON = JSON.parse(result.d);
            $('#<%=txtTenNhaCungCap.ClientID%>').autocomplete({
                lookup: objJSON,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    if (queryLowerCase == "*") {
                        return true;
                    }
                    if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }
                },
                onSelect: function (suggestion) {
                    $('#<%=slcTenNhaCungCap.ClientID%>').val(suggestion.data);
                    var c = 0;
                    $.each(dataChiTiet, function (idx, vattunhap) {
                        if (vattunhap.MaHieuNhaCungCap.Value != $('#<%=slcTenNhaCungCap.ClientID%>').val())
                            vattunhap.MaHieuNhaCungCap.setValue($('#<%=slcTenNhaCungCap.ClientID%>').val());
                    });
                    bindDataChiTiet(dataChiTiet);
                },
                onHint: function (hint) {
                },
                onInvalidateSelection: function () {
                    $('#<%=slcTenNhaCungCap.ClientID%>').val("");
                    var c = 0;
                    $.each(dataChiTiet, function (idx, vattunhap) {
                        if (vattunhap.MaHieuNhaCungCap.Value != $('#<%=slcTenNhaCungCap.ClientID%>').val())
                            vattunhap.MaHieuNhaCungCap.setValue("");
                    });
                    bindDataChiTiet(dataChiTiet);
                }
            });
        });
        }
        $(function () {
            if ("<%=ID_PhieuNhap%>" != "") {
            dataChiTiet = new PhieuNhap({ ID: parseInt("<%=ID_PhieuNhap%>"), MaNhaCungCap: parseInt($("#<%=slcTenNhaCungCap.ClientID%>").val()) }).getChiTietPhieuNhap();
                bindDataChiTiet(dataChiTiet);
            }
            $("#<%=txtMaPhieu.ClientID%>").val("<%=MaPhieu%>");
            $("#<%=btnSave.ClientID%>").on("click", function () {
                savePhieuNhap();
                return false;
            });
            $("#btn-luu-print").on("click", function () {
                savePhieuNhap(true);
                return false;
            });
            $('#<%=txtNgayNhap.ClientID%>').datetimepicker({
                mask: '99/99/9999', timepicker: false,
                format: 'd/m/Y'
            });
            $('.date').mask('00/00/0000');
            dataVatTu = JSON.parse('<%=DataVatTu%>');
            tinhChatNhapXuat = JSON.parse('<%=DataTinhChatNhapXuat%>');
            loadNhaCungCap();

            queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataKhoVatTuNVLorThanhPhamForAutoComplete", "{TYPE:1}", function (result) {
                var objJSON = JSON.parse(result.d);
                $('#<%=txtKhoChua.ClientID%>').autocomplete({
                lookup: objJSON,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }

                },
                onSelect: function (suggestion) {
                    $('#<%=slcKhoChua.ClientID%>').val(suggestion.data);
                },
                onHint: function (hint) {
                },
                onInvalidateSelection: function () {
                    $('#<%=slcKhoChua.ClientID%>').val("");
                }
                });
            });
            queryData("Default.aspx/GetDSPhieuXuatJSON", "{kieuVatTu:1}", function (result) {
            var objJSON = JSON.parse(result.d);
            $('#<%=txtTheoPhieuXuat.ClientID%>').autocomplete({
                    lookup: objJSON,
                    lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                        if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }

                    },
                    onSelect: function (suggestion) {
                        $('#<%=slcPhieuXuat.ClientID%>').val(suggestion.data);
                },
                onHint: function (hint) {
                },
                onInvalidateSelection: function () {
                    $('#<%=slcPhieuXuat.ClientID%>').val("");
                }
                });
            });
            if ($("#<%=ddlTinhChat.ClientID%>").val() == "29") {
            $("#<%=txtTheoPhieuXuat.ClientID%>").prop('disabled', false);
                $("#<%=txtTenNhaCungCap.ClientID%>").prop('disabled', true);
            } else {
                $("#<%=txtTheoPhieuXuat.ClientID%>").prop('disabled', true);
                $("#<%=txtTenNhaCungCap.ClientID%>").prop('disabled', false);
            }
            $("#<%=txtTenNhaCungCap.ClientID%>").focus();
            $("#<%=ddlTinhChat.ClientID%>").change(function () {
                //Get Ma Phieu Nhap
                if ("<%=ID_PhieuNhap%>" == "") {
                    queryData("/WebService/DanhMuc.asmx/SinhMaPhieu", "{maTinhChat:\"" + $(this).val() + "\", tenBang: \"*\"}", function (result) {
                        $("#<%=txtMaPhieu.ClientID%>").val(result.d);
                    }, null, true);
                }

            if ($(this).val() == "29") {
                $("#<%=txtTheoPhieuXuat.ClientID%>").prop('disabled', false);
                    $("#<%=txtTenNhaCungCap.ClientID%>").prop('disabled', true);
                    $("#<%=txtTenNhaCungCap.ClientID%>").val("");
                    $.each(dataChiTiet, function (idx, vattunhap) {
                        vattunhap.MarkDelete.setValue(true);
                    });
                    bindDataChiTiet(dataChiTiet);
                } else {
                    $("#<%=txtTheoPhieuXuat.ClientID%>").prop('disabled', true);
                    $("#<%=txtTenNhaCungCap.ClientID%>").prop('disabled', false);

                    $("#<%=txtTheoPhieuXuat.ClientID%>").val("");
                    $("#<%=slcPhieuXuat.ClientID%>").val("");
                    $.each(dataChiTiet, function (idx, vattunhap) {
                        vattunhap.MarkDelete.setValue(false);
                    });
                    bindDataChiTiet(dataChiTiet);
                }
            });
            
        });
        function duyetPhieuNhap(id) {
            new PhieuNhap({
                ID: id
            }).duyetPhieuNhap();
        }

        function savePhieuNhap(print) {
            try {
                if (!confirm("Bạn có chắc muốn lưu thông tin phiếu nhập không?")) {
                    return;
                }
                var data = new Object();
                var idPhieu = "<%=ID_PhieuNhap%>";
            if (!$.isNumeric(idPhieu)) idPhieu = 0;
            data.ID = parseInt(idPhieu);
            data.MaHieuPhieuNhap = $("#<%=txtMaPhieu.ClientID%>").val().trim();
            data.TinhTrang = parseInt("<%=CurrentTinhTrang%>");

            if (data.MaHieuPhieuNhap == "") {
                alert("Bạn chưa nhập mã phiếu.");
                $("#<%=txtMaPhieu.ClientID%>").focus();
                return;
            }
            data.NgayNhap = $("#<%=txtNgayNhap.ClientID%>").val();
            var TinhChat = $("#<%= ddlTinhChat.ClientID %>").val();
            if (!$.isNumeric(TinhChat)) {
                alert("Bạn chưa nhập tính chất nhập xuất.");
                $("#<%=ddlTinhChat.ClientID%>").focus();
                return;
            } else
                data.MaTinhChatNhapXuat = parseInt(TinhChat);

            var traLai = $("#<%= ddlTinhChat.ClientID %>").val();
            var DonViCungCap = $("#<%=slcTenNhaCungCap.ClientID%>").val();
            if (traLai == "29")
                data.MaNhaCungCap = 0;
            else if (!$.isNumeric(DonViCungCap)) {
                alert("Bạn chưa nhập đơn vị cung cấp.");
                $("#<%=slcTenNhaCungCap.ClientID%>").focus();
                return;
            } else {
                data.MaNhaCungCap = parseInt(DonViCungCap);
            }

        var KhoChua = $("#<%=slcKhoChua.ClientID%>").val();
            if (!$.isNumeric(KhoChua)) {
                alert("Bạn chưa nhập kho chứa.");
                $("#<%=slcKhoChua.ClientID%>").focus();
                return;
            } else {
                data.MaKhoVatTu = parseInt(KhoChua);
            }

            var traLai = $("#<%= ddlTinhChat.ClientID %>").val();
            var phieuXuat = $("#<%= slcPhieuXuat.ClientID %>").val();
            if (traLai != "29")
                data.MaPhieuXuat = 0;
            else if (traLai == "29" && phieuXuat == "") {
                alert("Bạn chưa nhập phiếu xuất.");
                $("#<%=txtTheoPhieuXuat.ClientID%>").focus();
                return;
            } else
                data.MaPhieuXuat = phieuXuat;

        data.GhiChu = $("#<%=txtGhiChu.ClientID%>").val();
            data.KieuVatTu = parseInt('<%=KieuVatTu%>');
            var bgimg = "";
            var phieuNhap = new PhieuNhap(data);
            $("input[type=submit]").prop("disabled", true);
            phieuNhap.save(function (result) {
                var newid = result.d;
                if ($.isNumeric(newid)) {
                    var c = 0;
                    var allResult = "";
                    if (dataChiTiet.length == 0) {
                        if (print)
                            window.location.href = "<%=Util.SERVER_NAME %>/Business/QuanLyVatTu/Default.aspx?page=ppn&id=" + newid;
                        else
                            window.location.href = "<%=Util.SERVER_NAME %>/Business/QuanLyVatTu/Default.aspx?page=pktn";
                    }
                    $.each(dataChiTiet, function (idx, vattunhap) {
                        vattunhap.MaPhieuNhap.setValue(newid);
                        console.log(vattunhap)
                        vattunhap.save(function (result) {
                            c++;
                            if (result.d && result.d != "SUCCESS") {
                                allResult += "\n" + result.d;
                            }
                            if (c == dataChiTiet.length && allResult != "") {
                                alert("Có lỗi trong quá trình xử lý: " + allResult);
                                if (!print) {//save only
                                    $("#<%=btnSave.ClientID%>").css("background-image", "");
                                    $("#<%=btnSave.ClientID%>").addClass("icon-save");
                                } else {
                                    $("#<%=btnSavePrint.ClientID%>").css("background-image", bgimg);
                                }
                                $("input[type=submit]").prop("disabled", false);
                            }
                            if (c == dataChiTiet.length && allResult == "") {
                                if (print)
                                    window.location.href = "<%=Util.SERVER_NAME %>/Business/QuanLyVatTu/Default.aspx?page=ppn&id=" + newid;
                                else
                                    window.location.href = "<%=Util.SERVER_NAME %>/Business/QuanLyVatTu/Default.aspx?page=pktn";
                            }
                        });
                    });

                } else {
                    alert("Có lỗi khi lưu dữ liệu\n" + result.d);
                    if (!print) {//save only
                        $("#<%=btnSave.ClientID%>").css("background-image", "");
                        $("#<%=btnSave.ClientID%>").addClass("icon-save");
                    } else {
                        $("#<%=btnSavePrint.ClientID%>").css("background-image", bgimg);
                    }
                    $("input[type=submit]").prop("disabled", false);
                }
            });
        } catch (e) { }
    }

    function OpenChiTietVatTu(id, randID) {
        LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Business/QuanLyVatTu/KiemTraVatTuNhap/AddOrEditChiTietPhieuKiemTraVatTuNhap.ascx", "&id=" + randID);
        var title = (id == "0" ? "Thêm mới" : "Chỉnh sửa") + " chi tiết vật tư nhập";
        $("#content_div").dialog({ modal: true, width: 920, height: 500, title: title });
    }
    function CloseModal() {
        $("#content_div").dialog("close");
    }

    function deleteChiTietVatTu(mavattu) {
        if (!confirm("Bạn có chắc muốn xóa vật tư này không?")) return;
        var delVatTu;
        for (var i = 0; i < dataChiTiet.length; i++) {
            if (dataChiTiet[i].GUID == mavattu) {
                delVatTu = dataChiTiet[i];
                dataChiTiet.splice(i, 1);
                delVatTu.markDelete(function (result) {
                    alert("Đã xóa chi tiết vật tư nhập")
                    window.location.reload(true);
                });
                break;
            }
        }
    }

    function bindDataChiTiet(dataChiTiet) {
        $("#tabDanhSachPhieuNhapVatTu tbody").text("");
        for (var i = 0; i < dataChiTiet.length; i++) {
            if (!dataChiTiet[i].MarkDelete.Value)
                $("#tabDanhSachPhieuNhapVatTu tbody").append("<tr><td class='center-col'>" + (i + 1) + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].MaCuon.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].MaHieuVatTu.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].TenVatTu.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].DonViTinh.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].DonGia.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].SoLuongThucNhap.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].SoLuongDauCuon.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].SoLuongLamPhieuNhap.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].DinhLuongTieuChuan.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].DinhLuongThucTe.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].KichThuocTieuChuan.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].KichThuocThucTe.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].ChenhLechDinhLuong.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].DinhLuongTinhTru.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].TruThuaKichThuoc.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].KhoiLuongTru.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].TruLoi.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].SoLuongChenhLechKhongTinh.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].ThanhTien.Value + "</td>" +
                    "<td class='center-col'>" +
                    '<a class="edit-icon" href="javascript:OpenChiTietVatTu(\'' + dataChiTiet[i].ID.Value + '\',\'' + dataChiTiet[i].GUID + '\');"></a>' +
                       '<a class="delete-icon" href="javascript:deleteChiTietVatTu(\'' + dataChiTiet[i].GUID + '\');"></a>'
                    + "</td>"
                    + "</tr>");
        }
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
                            <asp:Button ToolTip="Lưu" CssClass="menu-bar-item-button icon icon-save" runat="server" ID="btnSave" />
                        </li>
                        <li class="menu-item icon-only" id="btn-luu-print">
                            <asp:Button ToolTip="Lưu và In" CssClass="menu-bar-item-button icon icon-save-printer" runat="server" ID="btnSavePrint" />
                        </li>
                        <asp:Literal ID="ltPrint" runat="server"></asp:Literal>
                        <asp:Literal ID="ltAccept" runat="server"></asp:Literal>
                        <li class="menu-item icon-only" id="btn-cancel">
                            <asp:Button ToolTip="Hủy" CssClass="menu-bar-item-button icon cancel-icon" runat="server" ID="btnCancel" OnClick="btnCancel_Click" />
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
                                                <input type="text" class="disable-textbox" readonly="true" id="txtMaPhieu" autocomplete="off" maxlength="255" title="CNS" runat="server" />
                                            </div>

                                        </div>
                                    </div>
                                </td>
                                <td>Ngày nhập
                                </td>
                                <td>
                                    <div class="workitemcontrol">
                                        <div class="combo tree drop short-control-50">
                                            <div class="wrap">
                                                <input type="text" id="txtNgayNhap" autocomplete="off" maxlength="255" title="CNS" runat="server" />
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>Nhà cung cấp</td>
                                <td colspan="3">
                                    <div class="workitemcontrol">
                                        <div class="combo tree drop">
                                            <div class="wrap">
                                                <asp:HiddenField ID="slcTenNhaCungCap" runat="server" ClientIDMode="Static" />
                                                <input style="width: 97%;" type="text" id="txtTenNhaCungCap" autocomplete="off" maxlength="255" title="CNS" runat="server" />
                                                <a title="Tải lại dữ liệu" class="icon icon-refresh" id="btnRefresh" onclick="loadNhaCungCap(); return false;"></a>
                                            </div>
                                        </div>
                                    </div>
                                </td>

                            </tr>
                            <tr>
                                <td>Tính chất nhập xuất</td>
                                <td>
                                    <div class="workitemcontrol">
                                        <div class="short-control-50">
                                            <div class="wrap" style="display: block">
                                                <asp:DropDownList ID="ddlTinhChat" runat="server"></asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td>Kho chứa</td>
                                <td>
                                    <div class="workitemcontrol">
                                        <div class="combo tree drop short-control-50">
                                            <div class="wrap">
                                                <asp:HiddenField ID="slcKhoChua" runat="server" />
                                                <input type="text" id="txtKhoChua" autocomplete="off" maxlength="255" title="CNS" runat="server" />
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>Theo phiếu xuất:</td>
                                <td>
                                    <div class="workitemcontrol">
                                        <div class="combo tree drop short-control-50">
                                            <div class="wrap">
                                                <asp:HiddenField ID="slcPhieuXuat" runat="server" ClientIDMode="Static" />
                                                <asp:TextBox ID="txtTheoPhieuXuat" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <asp:Literal ID="ltTinhTrang" runat="server" Text="Tình trạng"></asp:Literal></td>
                                <td>
                                    <asp:Label ID="lblTinhTrang" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>Ghi chú
                                </td>
                                <td colspan="3">
                                    <asp:TextBox TextMode="MultiLine" ID="txtGhiChu" runat="server" CssClass="text-area"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4"></td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="work-item-bonus">
                        <asp:Literal ID="ltButtonNewChiTietVatTuNhap" runat="server"></asp:Literal>
                    </div>
                    <asp:Panel runat="server" ID="pnChiTietVatTu">
                        <div id="" class="div-data">
                            <table class="data-table tab-detail" id="tabDanhSachPhieuNhapVatTu">
                                <thead>
                                    <tr>
                                        <td>STT</td>
                                        <td>Mã cuộn</td>
                                        <td>Mã VT</td>
                                        <td>Tên VT</td>
                                        <td>ĐV Tính</td>
                                        <td>Giá nhập</td>
                                        <td>SL thực nhập</td>
                                        <td>SL đầu cuộn</td>
                                        <td>SL làm phiếu</td>
                                        <td>ĐL tiêu chuẩn</td>
                                        <td>ĐL thực tế</td>
                                        <td>KT tiêu chuẩn</td>
                                        <td>KT thực tế</td>
                                        <td>Chênh lệch ĐL</td>
                                        <td>ĐL tính trừ</td>
                                        <td>Trừ KT</td>
                                        <td>KL trừ</td>
                                        <td>Trừ lõi</td>
                                        <td>SL chênh lệch không tính</td>
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
        <div class="paging">
            <cc1:CollectionPager ID="colPage" runat="server" PageSize="10" PagingMode="QueryString"
                QueryStringKey="trang" BackText="Trước"
                FirstText="Đầu" LastText="Cuối" NextText="Sau"
                LabelText="" PageNumbersSeparator="&amp;nbsp;&amp;nbsp;" PageNumbersStyle="color:#ea1111;font-size:12px;padding:5px;"
                PageNumberStyle="color:#555;padding:3px 8px;border:solid 1px #ccc;" ResultsLocation="Bottom"
                ResultsStyle="font-family:Arial;font-size:12px;text-align:right;margin-top:5px;"
                ShowLabel="True" BackNextButtonStyle="border:none;background:red;" BackNextDisplay="HyperLinks"
                BackNextLinkSeparator="&nbsp;&nbsp;-&nbsp;&nbsp;" ControlStyle="text-align:right;margin:5px;float:right;" BackNextLocation="Split" ResultsFormat="Hiển thị {0}-{1} (trong tổng số {2} bản ghi)" ShowFirstLast="True" ControlCssClass="paging_tool_bar" EnableViewState="False" MaxPages="10" SectionPadding="5" SliderSize="5">
            </cc1:CollectionPager>
        </div>
        <div class="clear"></div>

    </div>
    <div class="ui-dialog-buttonset">
    </div>
</div>
<div id="content_div" title="Thêm mới chi tiết vật tư nhập">
</div>

<script type="text/ecmascript">
    function CloseModal() {
        $("#content_div").dialog("close");
    }
    $(function () {
        $("#btn-tao-moi-chi-tiet-kiem-tra-vat-tu-nhap").click(function () {
            if ($("#<%=ddlTinhChat.ClientID%>").val() == "29") {
                if ($("#<%= slcPhieuXuat.ClientID%>").val() == "") {
                    alert("Bạn chưa chọn phiếu xuất để trả lại");
                    return;
                }
            } else
                if (!$("#<%=slcTenNhaCungCap.ClientID%>").val()) {
                    alert("Bạn chưa chọn nhà cung cấp");
                    $("#<%=txtTenNhaCungCap.ClientID%>").focus();
                    return;
                }
            $("#content_div").prop('title', 'Thêm mới chi tiết vật tư nhập');
            LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Business/QuanLyVatTu/KiemTraVatTuNhap/AddOrEditChiTietPhieuKiemTraVatTuNhap.ascx", "&id=");
            $("#content_div").dialog({ modal: true, width: 920, height: 500, title: 'Thêm mới chi tiết vật tư nhập' });
        });
        $("#btnPrint").click(function () {
            alert("Chức năng đang hoàn thiện");
        });
    });
</script>
