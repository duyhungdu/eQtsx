<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddOrEditCoCauGiay.ascx.cs" Inherits="xRP.Business.QuanLySanXuat.CoCauGiay.AddOrEditCoCauGiay" %>
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
                    <td>
                        <div>
                            <span>Phân loại sóng</span>
                            <span style="color: red">*</span>
                        </div>
                    </td>
                    <td colspan="3">
                        <asp:HiddenField ID="slcIDCoCauGiay" runat="server" ClientIDMode="Static" Value="0" />
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtIDCoCauGiay" runat="server" TabIndex="2" Width="100%"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                  <tr>
                    <td>
                        <div>
                            <span>Loại giấy</span>
                            <span style="color: red">*</span>
                        </div>
                    </td>
                    <td colspan="3">
                        <asp:HiddenField ID="slcLoaiGiay" runat="server" ClientIDMode="Static" Value="0" />
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtLoaiGiay" runat="server" TabIndex="2" Width="100%"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div>
                            <span>Tên lớp giấy</span>
                            <span style="color: red">*</span>
                        </div>
                    </td>
                    <td colspan="3">
                        <asp:HiddenField ID="slcIDLopGiay" runat="server" ClientIDMode="Static" Value="0" />
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtIDLopGiay" runat="server" TabIndex="2" Width="100%"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Thứ tự lớp giấy</td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtThuTu" MaxLength="2" runat="server" TabIndex="9"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>Kích hoạt</td>
                    <td>
                        <asp:CheckBox ID="ckKichHoat" runat="server" Checked="true" TabIndex="10"></asp:CheckBox>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix button-list">
    <input type="button" value="Lưu" class="xrp-button" onclick="save_data();" tabindex="12" />
    <input type="button" value="Hủy" onclick="CloseModal();" class="xrp-button" tabindex="13" />
</div>
<script type="text/javascript">
    $(function () {
        $('#<%=txtIDCoCauGiay.ClientID%>').focus();

        //Phân loại sóng
        queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONPhanLoaiSongForAutoComplete_KyHieu", {}, function (result) {
            var objJSON = JSON.parse(result.d);
            $('#<%=txtIDCoCauGiay.ClientID%>').autocomplete({
                lookup: objJSON,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }
                     
                },
                onSelect: function (suggestion) {
                    $('#<%=slcIDCoCauGiay.ClientID%>').val(suggestion.data);
                },
                onHint: function (hint) {
                },
                onInvalidateSelection: function () {
                }
            });
        });
        //End-Phân loại sóng

        //Tên lớp giấy
        queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONTenLopGiayForAutoComplete", {}, function (result) {
            var objJSON = JSON.parse(result.d);
            $('#<%=txtIDLopGiay.ClientID%>').autocomplete({
                lookup: objJSON,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }
                     
                },
                onSelect: function (suggestion) {
                    $('#<%=slcIDLopGiay.ClientID%>').val(suggestion.data);
                },
                onHint: function (hint) {
                },
                onInvalidateSelection: function () {
                }
            });
        });
        queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataLoaiVatTuForAutoComplete", {}, function (result) {
            var objJSON = JSON.parse(result.d);
            $('#<%=txtLoaiGiay.ClientID%>').autocomplete({
                lookup: objJSON,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }

                },
                onSelect: function (suggestion) {
                    $('#<%=slcLoaiGiay.ClientID%>').val(suggestion.data);
                },
                onHint: function (hint) {
                },
                onInvalidateSelection: function () {
                }
            });
        });
        //End-Phân loại sóng
    });

        function save_data() {
            try {

                if (!confirm("Bạn có chắc muốn lưu thông tin cơ cấu giấy không?")) {
                    return;
                }

                var data = new Object();
                var coCauGiayId = "<%=coCauGiayId%>";
                if (!$.isNumeric(coCauGiayId)) coCauGiayId = 0;
                data.itemID = parseInt(coCauGiayId);
                data.coCauGiayId = $("#<%=slcIDCoCauGiay.ClientID%>").val().trim();
                data.lopGiayId = $("#<%=slcIDLopGiay.ClientID%>").val().trim();
                data.loaiGiayID = $("#<%=slcLoaiGiay.ClientID%>").val().trim();
                data.thuTu = $("#<%=txtThuTu.ClientID%>").val().trim();
                data.kichHoat = $("#<%=ckKichHoat.ClientID%>").checked;
                 
                if (data.coCauGiayId == "") {
                    alert("Bạn chưa nhập Phân loại sóng.");
                    $("#<%=txtIDCoCauGiay.ClientID%>").focus();
                    return;
                }

                if (data.lopGiayId == "") {
                    alert("Bạn chưa nhập tên lớp giấy.");
                    $("#<%=txtIDLopGiay.ClientID%>").focus();
                    return;
                }
                if (data.loaiGiayID == "") {
                    alert("Bạn chưa chọn loại giấy.");
                    $("#<%=txtLoaiGiay.ClientID%>").focus();
                    return;
                }
                var coCauGiay = new CoCauGiay(data); 
                coCauGiay.save(function (result) { 
                    var newid = result.d;
                    if ($.isNumeric(newid)) {
                        window.location.reload(true);

                    } else {
                        alert("Có lỗi khi lưu dữ liệu\n" + result.d);
                    }
                })
            } catch (e) { }

            return false;
        }
        function CloseModal() {
            $("#content_div").dialog("close");
        }
</script>
