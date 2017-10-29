<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddOrEditNguonLuc.ascx.cs" Inherits="xRP.Business.QuanLySanXuat.NguonLuc.AddOrEditNguonLuc" %>
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
                            <span>Tên nguồn lực</span>
                            <span style="color: red">*</span>
                        </div>
                    </td>
                    <td colspan="3">
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtNguonLuc" runat="server" TabIndex="2" Width="100%"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td>Mức tải</td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtMucTai" runat="server" TabIndex="4"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>Đơn vị tính</td>
                    <td>
                        <asp:HiddenField ID="slcDonViTinh" runat="server" ClientIDMode="Static" Value="0" />
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtDonViTinh" runat="server" TabIndex="5"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Thuộc công đoạn</td>
                    <td>
                        <asp:HiddenField ID="slcThuocCongDoan" runat="server" ClientIDMode="Static" Value="0" />
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtThuocCongDoan" runat="server" TabIndex="9"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>Kích hoạt</td>
                    <td>
                        <asp:CheckBox ID="ckKichHoat" runat="server" Checked="true" TabIndex="10"></asp:CheckBox>
                    </td>
                </tr>
                <tr>
                    <td>Ghi chú
                    </td>
                    <td colspan="3">
                        <asp:TextBox TextMode="MultiLine" ID="txtGhiChu" runat="server" CssClass="text-area" TabIndex="11"></asp:TextBox>
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
    <input type="button" value="Lưu" class="xrp-button" onclick="save_data();" tabindex="12" />
    <input type="button" value="Hủy" onclick="CloseModal();" class="xrp-button" tabindex="13" />
</div>
<script type="text/javascript">
    $(document).ready(function () {
        $('#<%=txtNguonLuc.ClientID%>').focus();


        //Đơn vị tính
        queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataDonViTinhForAutoComplete", {}, function (result) {
            var objJSON = JSON.parse(result.d);
            $('#<%=txtDonViTinh.ClientID%>').autocomplete({
                lookup: objJSON,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) {return true;}else {return false;}
                     
                },
                onSelect: function (suggestion) {
                    $('#<%=slcDonViTinh.ClientID%>').val(suggestion.data);
                },
                onHint: function (hint) {
                },
                onInvalidateSelection: function () {
                }
            });
        });
        //End-Đơn vị tính

        /// Thuộc công đoạn
        queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataCongDoanForAutoComplete", {}, function (result) {
            var objJSON = JSON.parse(result.d);
            $('#<%=txtThuocCongDoan.ClientID%>').autocomplete({
                lookup: objJSON,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) {return true;}else {return false;}
                     
                },
                onSelect: function (suggestion) {
                    $('#<%=slcThuocCongDoan.ClientID%>').val(suggestion.data);
                },
                onHint: function (hint) {
                },
                onInvalidateSelection: function () {
                }
            });
        });
        /// End- Thuộc công đoạn
    });

        function save_data() {
            try {

                if (!confirm("Bạn có chắc muốn lưu thông tin nguồn lực không?")) {
                    return;
                }

                var data = new Object();
                var nguonLucId = "<%=nguonLucId%>";
                if (!$.isNumeric(nguonLucId)) nguonLucId = 0;
                data.itemID = parseInt(nguonLucId);
                data.nguonLuc = $("#<%=txtNguonLuc.ClientID%>").val().trim();
                data.mucTai = $("#<%=txtMucTai.ClientID%>").val().trim();
                data.donViTinh = $("#<%=slcDonViTinh.ClientID%>").val().trim();
                data.thuocCongDoan = $("#<%=slcThuocCongDoan.ClientID%>").val().trim();
                data.kichHoat = $("#<%=ckKichHoat.ClientID%>").checked;
                data.ghiChu.Text = $("#<%=txtGhiChu.ClientID%>").val().trim();

                if (data.nguonLuc == "") {
                    alert("Bạn chưa nhập Nguồn lực.");
                    $("#<%=txtNguonLuc.ClientID%>").focus();
                    return;
                }

                var nguonLuc = new NguonLuc(data);

                nguonLuc.save(function (result) {
                    var newid = result.id;
                    if ($.isNumeric(newid)) {
                        window.location.href = "<%=Util.SERVER_NAME %>/Business/QuanLySanXuat/Default.aspx?page=ngl";

                    } else {
                        alert("Có lỗi khi lưu dữ liệu\n" + result.d);
                    }
                })
            } catch (e) { }

            return false;
        }
</script>
