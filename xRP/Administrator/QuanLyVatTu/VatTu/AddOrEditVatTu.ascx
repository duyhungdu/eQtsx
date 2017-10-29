<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddOrEditVatTu.ascx.cs" Inherits="xRP.Administrator.QuanLyVatTu.VatTu.AddOrEditVatTu" %>
<script type="text/javascript">
    $(document).ready(function () {
        $("#<%=txtMaVatTu.ClientID%>").on("blur", function () {
            var ma = $(this).val().trim();
            if (ma.length >= 13) {
                var tenVatTu = "";
                var maLoaiVT = ma[5];
                var kichThuoc = ma.substring(6, 10);
                $("#<%=txtKichThuocVatTu.ClientID%>").val(kichThuoc)
                var dinhLuong = ma.substring(10, 13);
                $("#<%=txtDinhLuong.ClientID%>").val(dinhLuong)
                queryData("/WebService/DanhMuc.asmx/GetJSONDataLoaiVatTuForAutoComplete", "{}", function (result) {
                    var listLoaiVatTu = JSON.parse(result.d);
                    for (var i = 0; i < listLoaiVatTu.length; i++) {
                        if (listLoaiVatTu[i].mahieu.trim() == maLoaiVT) {
                            tenVatTu = listLoaiVatTu[i].value;
                            tenVatTu += "-K" + kichThuoc.substring(0, 3) + "-ĐL" + dinhLuong;
                            $("#<%=txtTenVatTu.ClientID%>").val(tenVatTu);
                            $("#<%=cboLoaiVatTu.ClientID%>").val(listLoaiVatTu[i].data);
                        }
                    }
                });
            }
        });
    });
    $("#btnSave").click(function () {
        var ma = $("#<%=txtMaVatTu.ClientID%>").val();
        if (ma == "" || ma == null)
        {
            alert('Xin vui lòng nhập mã vật tư');
            $("#<%=txtMaVatTu.ClientID%>").focus();
            return;
        }
        var ten = $("#<%=txtTenVatTu.ClientID%>").val();
        if (ten == "" || ten == null) {
            alert('Xin vui lòng nhập tên vật tư');
            $("#<%=txtTenVatTu.ClientID%>").focus();
            return;
        }
        var loai = $("#<%=cboLoaiVatTu.ClientID%>").val();
        if (loai == "" || loai == null) {
            alert('Xin vui lòng chọn loại vật tư');
            $("#<%=cboLoaiVatTu.ClientID%>").focus();
             return;
         }
        var kichThuoc = $("#<%=txtKichThuocVatTu.ClientID%>").val();
        if (kichThuoc == "" || kichThuoc == null) {
            alert('Xin vui lòng nhập kích thước vật tư');
            $("#<%=txtKichThuocVatTu.ClientID%>").focus();
            return;
        }
        var dinhLuong = $("#<%=txtDinhLuong.ClientID%>").val();
        if (dinhLuong == "" || dinhLuong == null) {
            alert('Xin vui lòng nhập định lượng vật tư');
            $("#<%=txtDinhLuong.ClientID%>").focus();
            return;
        }
        var donViTinh = $("#<%=hdfDonViTinh.ClientID%>").val();
        if (donViTinh == "" || donViTinh == null) {
            alert('Xin vui lòng nhập đơn vị tính');
            $("#<%=txtDonViTinh.ClientID%>").focus();
            return;
        }
        var kichHoat = $("#<%=chkKichHoat.ClientID%>").is(":checked");
        var tonToiThieu = $("#<%=txtTonToiThieu.ClientID%>").val();
        if (tonToiThieu == "" || tonToiThieu == null) {
            alert('Xin vui lòng nhập số lượng tồn tối thiểu');
            $("#<%=txtTonToiThieu.ClientID%>").focus();
            return;
        }
        var ghiChu = $("#<%=txtGhiChu.ClientID%>").val();
        var id = "<%=ItemID%>";
        addOrUpdateItem(id, ma, ten, loai, kichThuoc, dinhLuong, donViTinh, tonToiThieu, kichHoat, ghiChu, function () {
            CloseModal();
        });
    });
    $("#<%=txtMaVatTu.ClientID%>").focus();
    $.ajax({
        type: "POST",
        url: "<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataDonViTinhForAutoComplete",
            data: "{}",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
            },
            success: function (result) {
                var objJSON = JSON.parse(result.d);
                console.log(objJSON)
                $('#<%=txtDonViTinh.ClientID%>').autocomplete({
                    lookup: objJSON,
                    lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                        if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) {return true;}else {return false;}
                         
                    },
                    onSelect: function (suggestion) {
                        $('#<%=hdfDonViTinh.ClientID%>').val(suggestion.data);
                    },
                    onHint: function (hint) {
                    },
                    onInvalidateSelection: function () {
                    }
                });
            }
    });
</script>
<div class="work-item-form">
    <div class="work-item-view" style="margin-left: 10px;">
        <table class="witform-layout">
            <tbody>
                <tr>
                    <td style="width: 20%;"></td>
                    <td style="width: 30%;"></td>
                    <td style="width: 20%;"></td>
                    <td style="width: 30%;"></td>
                </tr>
                <tr>
                    <td>Mã vật tư
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtMaVatTu" runat="server" MaxLength="255"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>Tên vật tư
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtTenVatTu" runat="server" MaxLength="255"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Loại vật tư</td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:DropDownList ID="cboLoaiVatTu" runat="server"></asp:DropDownList>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>Kích thước vật tư</td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtKichThuocVatTu" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Định lượng</td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtDinhLuong" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>Đơn vị tính</td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                     <asp:HiddenField ID="hdfDonViTinh" runat="server" />
                                    <asp:TextBox ID="txtDonViTinh" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td>Số lượng tồn tối thiểu</td>
                    <td>
                       <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtTonToiThieu" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>Kích hoạt</td>
                    <td><asp:CheckBox runat="server" ID="chkKichHoat" Checked="true" /></td>
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
    </div>
</div>
<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix button-list">
    <input type="button" id="btnSave" value="Lưu" class="xrp-button" />
    <input type="button" value="Hủy" onclick="CloseModal();" class="xrp-button" />
</div>
