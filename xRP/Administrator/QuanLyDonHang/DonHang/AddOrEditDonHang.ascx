<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddOrEditDonHang.ascx.cs" Inherits="xRP.Administrator.QuanLyDonHang.DonHang.AddOrEditDonHang" %>
<script type="text/javascript">
    var listDonViTinh = JSON.parse('<%=ListDonViTinh%>');
    var listLoaiSanPham = JSON.parse('<%=ListLoaiSanPham%>');
    var maKhachHang = "<%=MaKhachHang%>";
    function getTenDonViTinh(id) {
        for (var i = 0; i < listDonViTinh.length; i++) {
            if (listDonViTinh[i].ID == id) {
                return listDonViTinh[i].DonViTinh;
            }
        }
    }
    function OpenModal(id, randID) {
        $("#content_div").prop("title", "Cập nhật thông tin mặt hàng");
        LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Administrator/QuanLyDonHang/DonHang/AddChiTietSanPham.ascx", "&id=" + randID);
        $("#content_div").dialog({ modal: true, width: 800, height: 580 });
    }
    function BindKhachHang() {
        queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONKhachHangForAutoComplete", "{}", function (result) {
            var objJSON = JSON.parse(result.d);
            $('#<%=txtTenKhachHang.ClientID%>').autocomplete({
                lookup: objJSON,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }

                },
                onSelect: function (suggestion) {
                    $('#<%=slcTenKhachHang.ClientID%>').val(suggestion.data);
                    maKhachHang = suggestion.data;
                    recalMaHang();
                },
                onHint: function (hint) {
                },
                onInvalidateSelection: function () {
                    $('#<%=slcTenKhachHang.ClientID%>').val("");
                    maKhachHang = "";
                    recalMaHang();
                }
            });
        });
    }
    var dataChiTiet = [];
    $(document).ready(function () {
        $('#<%=txtNgayDatHang.ClientID%>').datetimepicker({
            mask: '99/99/9999', timepicker: false,
            format: 'd/m/Y',
        });


        $('#<%=txtNgayGiaoHang.ClientID%>').datetimepicker({
            mask: '99/99/9999', timepicker: false,
            format: 'd/m/Y',
        });
        BindKhachHang();

        $("#<%=txtTenKhachHang.ClientID%>").focus();
        //Lay danh sach san pham
        new DonHang({ ID: parseInt("<%=ID_DonHang%>") }).getChiTietHangHoa(function (result) {
            console.log(result);
            var dsHangHoa = [];
            for (var i = 0; i < result.length; i++) {
                var exist = false;
                for (var j = 0; j < dsHangHoa.length; j++) {
                    if (dsHangHoa[j].ID == result[i].ID)
                        exist = true;
                }
                if (!exist)
                    dsHangHoa.push(result[i]);
            }
            for (var i = 0; i < dsHangHoa.length; i++) {
                dsHangHoa[i].LoaiSongSanXuat = dsHangHoa[i].IDLoaiSongSanXuat;
                dsHangHoa[i].CongDoanCuoi = dsHangHoa[i].IDCongDoanCuoi;
                dsHangHoa[i].IDDonViTinh = dsHangHoa[i].IDDonVitinh;
                dataChiTiet.push(new MatHang(dsHangHoa[i]));
            }
            bindDataChiTiet(dataChiTiet);
        });
        $("#<%=btnSave.ClientID%>").on("click", function () {
            saveDonHang();
            return false;
        });

        $("#btn-luu-print").on("click", function () {
            saveDonHang(true);
        });

        $("#btn-delete").on("click", function () {
            var data = new DonHang({ ID: parseInt("<%=ID_DonHang%>") });
            data.markDelete();
        });
        $("#btn-undoprocess").on("click", function () {
            var data = new DonHang({ ID: parseInt("<%=ID_DonHang%>") });
            data.undoProcess();
        });
        $("#btn-print").on("click", function () {
            window.location.href = "/Administrator/QuanLyDonHang/Default.aspx?page=ppdathhang&id=<%=ID_DonHang%>";
        });
    });

    function recalMaHang() {
        for (var i = 0; i < dataChiTiet.length; i++) {
            dataChiTiet[i].calMaHangHoa();
        }
        bindDataChiTiet(dataChiTiet);
    }

    function saveDonHang(allowPrinting) {
        if (!confirm("Bạn có chắc muốn lưu thông tin phiếu nhập không?")) {
            return;
        }
        var data = new DonHang();
        data.MaHieuDonHang.setValue($("#<%=txtMaDonHang.ClientID%>").val().trim());
        if (data.MaHieuDonHang.Value == "") {
            alert("Bạn chưa nhập mã đơn hàng.");
            $("#<%=txtMaDonHang.ClientID%>").focus();
            return;
        }
        data.NgayDatHang.setValue($("#<%=txtNgayDatHang.ClientID%>").val());
        if (data.NgayDatHang.Value == "") {
            alert("Bạn chưa nhập ngày đặt hàng.");
            $("#<%=txtNgayDatHang%>>").focus();
            return;
        }
        data.NgayGiaoHang.setValue($("#<%=txtNgayGiaoHang.ClientID%>").val());
        if (data.NgayGiaoHang.Value == "") {
            alert("Bạn chưa nhập ngày giao hàng.");
            $("#<%=txtNgayGiaoHang%>").focus();
            return;
        }
        data.MaHieuKhachHang.setValue($("#<%=slcTenKhachHang.ClientID%>").val());
        if (data.MaHieuKhachHang.Value == "") {
            alert("Bạn chưa nhập khách hàng.");
            $("#<%=txtTenKhachHang%>").focus();
            return;
        }
        //ghi nhớ trạng thái
        data.TinhTrang.setValue($("#<%=ddlTinhTrang.ClientID%>").val());
        data.ID.setValue("<%=ID_DonHang%>");

        data.GhiChu.setValue($("#<%=txtGhiChu.ClientID%>").val());
        $("input").prop("disabled", true);
        
        data.save(function (result) {
            var newid = result.d;
            if ($.isNumeric(newid)) {
                var c = 0;
                var allResult = "";
                
                if (dataChiTiet.length == 0) {
                    if (allowPrinting) {
                        window.location.href = "/Administrator/QuanLyDonHang/Default.aspx?page=ppdathhang&id=" + newid;
                    }
                    else if (data.ID.Value == 0)
                        window.location.href = window.location.href + "&id=" + newid;
                    else
                        window.location.reload(true);
                }
                $.each(dataChiTiet, function (idx, hanghoa) {
                    hanghoa.IDDonHang.setValue(newid);
                    hanghoa.NgayGiaoHang.setValue($("#<%=txtNgayGiaoHang.ClientID%>").val());
                    hanghoa.save(function (result) {
                        c++;
                        if (result.d && result.d != "SUCCESS") {
                            allResult += "\n" + result.d;
                        }
                        if (c == dataChiTiet.length && allResult != "") {
                            alert("có lỗi trong quá trình xử lý: " + allResult);
                            $("input").prop("disabled", false);
                        }
                        if (c == dataChiTiet.length) {
                            if (allowPrinting)
                                window.location.href = "/Administrator/QuanLyDonHang/Default.aspx?page=ppdathhang&id=" + newid;
                            else
                                window.location.href = "<%=Util.SERVER_NAME %>/Administrator/QuanLyDonHang/DonHang/Default.aspx?page=dsdonhang";
                    }
                    });
                });
        } else {
            alert("Có lỗi khi lưu dữ liệu\n" + result.d);
            $("input").prop("disabled", false);
        }
        })
}

function CloseModal() {
    $("#content_div").dialog("close");
}
function bindDataChiTiet(dataChiTiet) {
    $("#tabDanhSachPhieuNhapVatTu tbody").text("");
    for (var i = 0; i < dataChiTiet.length; i++) {
        var tenLoaiGiay = "";
        queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONPhanLoaiSongForAutoComplete_KyHieu", {}, function (result) {
            var objJSON = JSON.parse(result.d);
            for (var c = 0; c < objJSON.length; c++) {
                if (objJSON[c].data == dataChiTiet[i].LoaiSongSanXuat.Value) {
                    dataChiTiet[i].TenLoaiSongSanXuat.setValue(objJSON[c].value);
                    tenLoaiGiay = objJSON[c].kyhieucocaugiay;
                }
            }
        }, null, false);
        $("#tabDanhSachPhieuNhapVatTu tbody").append("<tr><td class='center-col'>" + (i + 1) + "</td>" +
            "<td>" + dataChiTiet[i].MaHangTheoDon.Value + "</td>" +
            "<td>" + dataChiTiet[i].MaHieuMatHang.Value + "</td>" +
            "<td>" + dataChiTiet[i].TenMatHang.Value + "</td>" +
            "<td>" + dataChiTiet[i].SoLuong.Value + "</td>" +
            "<td class='center-col'>" + getTenDonViTinh(dataChiTiet[i].IDDonViTinh.Value) + "</td>" +
            "<td>" + tenLoaiGiay + "</td>" +
            "<td class='center-col'>" + dataChiTiet[i].ChieuDai.Value + "</td>" +
            "<td class='center-col'>" + dataChiTiet[i].ChieuRong.Value + "</td>" +
            "<td class='center-col'>" + dataChiTiet[i].ChieuCao.Value + "</td>" +
            "<td class='center-col'>" + dataChiTiet[i].LoaiKichThuoc.Value + "</td>" +
            "<td class='center-col'>" + dataChiTiet[i].TenLoaiSanPham.Value + "</td>" +
            "<td class='center-col' id='song_" + dataChiTiet[i].GUID + "'>" + dataChiTiet[i].TenLoaiSong.join(", ") + "</td>" +
            "<td class='center-col'>" + dataChiTiet[i].SoLuongMau.Value + "</td>" +
            "<td class='center-col'>" + dataChiTiet[i].ThanhTien.Value + "</td>" +
            "<td class='center-col'>" +
            '<a class="edit-icon" href="javascript:OpenModal(\'' + dataChiTiet[i].ID.Value + '\',\'' + dataChiTiet[i].GUID + '\');"></a>' +
               '<a class="delete-icon" href="javascript:deleteHangHoa(\'' + dataChiTiet[i].GUID + '\');"></a>'
            + "</td>"
            + "</tr>");

    }
}
function deleteHangHoa(guid) {
    for (var i = 0; i < dataChiTiet.length; i++) {
        if (dataChiTiet[i].GUID == guid) {
            var delMatHang = dataChiTiet[i];
            dataChiTiet.splice(i, 1);
            if (delMatHang.ID.Value)
                delMatHang.markDelete(function (result) {
                    alert("Đã xóa mặt hàng.")
                });
            bindDataChiTiet(dataChiTiet);
        }
    }
}
function OpenModalKH(id) {
    $("#content_div").prop("title", "Cập nhật thông tin khách hàng");
    LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Administrator/QuanLyDonHang/KhachHang/AddOrEditKhachHang.ascx", "&id=" + id + "&type=2");
        //}
        $("#content_div").dialog({ modal: true, width: 700, height: 400 });
    }
    function CloseModalKH() {
        $("#content_div").dialog("close");
        BindKhachHang();
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
                        <span class="info-text">Cập nhật thông tin đơn hàng
                        </span>
                    </div>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block;">
                    <ul class="menu-bar">
                        <li class="menu-item icon-only" id="btn-luu">
                            <asp:Button CssClass="menu-bar-item-button icon icon-save" runat="server" ID="btnSave" /></li>
                        <li class="menu-item icon-only" id="btn-luu-print">
                            <asp:Button ToolTip="Lưu và In" CssClass="menu-bar-item-button icon icon-save-printer" runat="server" ID="btnSavePrint" />
                        </li>
                        <%--<asp:Literal ID="ltDelete" runat="server"></asp:Literal>--%>
                        <asp:Literal ID="ltUndoProcess" runat="server"></asp:Literal>
                        <asp:Literal ID="ltPrint" runat="server"></asp:Literal>
                        <li class="menu-item icon-only" id="btn-cancel">
                            <asp:Button CssClass="menu-bar-item-button icon cancel-icon" runat="server" ID="btnCancel" OnClick="btnCancel_Click" /></li>

                    </ul>
                </div>

                <div class="work-item-form">
                    <div class="work-item-view" style="margin-left: 10px;">

                        <table class="witform-layout">
                            <tbody>
                                <tr>

                                    <td style="width: 10%;"></td>
                                    <td style="width: 10%;"></td>
                                    <td style="width: 10%; text-align: right"></td>
                                    <td style="width: 70%;"></td>
                                </tr>
                                <tr>
                                    <td>
                                        <div>
                                            <span>Mã đơn hàng</span>
                                            <span style="color: red">*</span>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="workitemcontrol">
                                            <div class="combo tree drop">
                                                <div class="wrap">
                                                    <asp:TextBox ID="txtMaDonHang" runat="server"></asp:TextBox>
                                                </div>

                                            </div>
                                        </div>
                                    </td>
                                   <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td><span>Tên khách hàng</span>
                                        <span style="color: red">*</span></td>
                                    <td colspan="3">
                                        <div class="workitemcontrol" style="width: 70%">
                                            <div class="combo tree drop">
                                                <div class="wrap">
                                                    <asp:HiddenField ID="slcTenKhachHang" runat="server" />
                                                    <asp:TextBox ID="txtTenKhachHang" runat="server" Width="94%"></asp:TextBox>
                                                    <%-- <a class="icon icon-refresh" style="height:21px;margin-left:3px;" id="btnRefresh" title="Tải lại dữ liệu" onclick="BindKhachHang(); return false;"></a>--%>
                                                    <a class="icon icon-add" style="height: 21px; margin-left: 3px;" id="btnRefresh" title="Tải lại dữ liệu" onclick="OpenModalKH(-1);"></a>

                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Ngày đặt hàng</td>
                                    <td>
                                        <div class="workitemcontrol">
                                            <div class="combo tree drop">
                                                <div class="wrap">
                                                    <input type="text" id="txtNgayDatHang" placeholder="__/__/____" name="field-name" class="combo tree drop" runat="server" />
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>Ngày giao hàng</td>
                                    <td>
                                        <div class="workitemcontrol" style="width: 15%">
                                            <div class="combo tree drop">
                                                <div class="wrap">
                                                    <input type="text" id="txtNgayGiaoHang" placeholder="__/__/____" name="field-name" class="combo tree drop" runat="server" />
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Tình trạng</td>
                                    <td>
                                        <div class="workitemcontrol">
                                            <div class="combo tree drop">
                                                <div class="wrap">
                                                    <asp:DropDownList ID="ddlTinhTrang" runat="server" Enabled="false">
                                                        <asp:ListItem Value="0">Chưa xử lý</asp:ListItem>
                                                        <asp:ListItem Value="1">Đã xử lý</asp:ListItem>
                                                        <asp:ListItem Value="2">Hoàn thành</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Ghi chú</td>
                                    <td colspan="3">
                                        <asp:TextBox ID="txtGhiChu" CssClass="text-area" runat="server" TextMode="MultiLine"></asp:TextBox>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <%--<div class="work-item-bonus">
                <ul class="menu-bar">
                  <li class="menu-item icon-only" id="btn-tao-moi-san-pham" onclick="OpenModal(-1);">
                      <span class="icon icon-add"></span><a href="javascript:void(0);">Thêm chi tiết sản phẩm</a></li>
                </ul>
            </div>--%>
                        <div class="work-item-bonus">
                            <asp:Literal ID="ltButtonNewChiTietVatTuNhap" runat="server"></asp:Literal>
                        </div>
                        <asp:Panel runat="server" ID="pnChiTietVatTu">
                            <div id="" class="div-data">

                                <table class="data-table tab-detail" id="tabDanhSachPhieuNhapVatTu">
                                    <thead>
                                        <tr>
                                            <td style="width: 5%">STT</td>
                                            <td>Mã hàng theo đơn</td>
                                            <td>Mã hàng</td>
                                            <td>Tên hàng</td>
                                            <td>Số lượng</td>
                                            <td>ĐVT</td>
                                            <td>Phân loại sóng</td>
                                            <td>Dài</td>
                                            <td>Rộng</td>
                                            <td>Cao</td>
                                            <td>Loại KT</td>
                                            <td>Loại thùng</td>
                                            <td>Loại sóng</td>
                                            <td>SL màu</td>
                                            <td>Thành tiền</td>
                                            <td></td>
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
        </div>
    </div>
</div>
<div id="content_div" title="Cập nhật thông tin hàng hóa">
</div>
