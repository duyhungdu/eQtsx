<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddOrEditCongDoan.ascx.cs" Inherits="xRP.Business.QuanLySanXuat.CongDoan.AddOrEditCongDoan" %>
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
                            <span>Mã hiệu công đoạn</span>
                            <span style="color: red">*</span>
                        </div>
                    </td>
                    <td colspan="3">
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-30">
                                <div class="wrap">
                                    <asp:TextBox ID="txtMaHieuCongDoan" runat="server" TabIndex="2" Width="100%"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div>
                            <span>Tên công đoạn</span>
                            <span style="color: red">*</span>
                        </div>
                    </td>
                    <td colspan="3">
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtCongDoan" runat="server" TabIndex="2" Width="100%"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Đơn vị phụ trách</td>
                    <td>
                        <asp:HiddenField ID="slcDonViPhuTrach" runat="server" ClientIDMode="Static" Value="0" />
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtDonViPhuTrach" runat="server" TabIndex="9"></asp:TextBox>
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
    $(function () {
        $('#<%=txtMaHieuCongDoan.ClientID%>').focus();

        //Đơn vị phụ trách
        queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataDonVi", {}, function (result) {
            var objJSON = JSON.parse(result.d);
            $('#<%=txtDonViPhuTrach.ClientID%>').autocomplete({
                lookup: objJSON,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) {return true;}else {return false;}
                     
                },
                onSelect: function (suggestion) {
                    $('#<%=slcDonViPhuTrach.ClientID%>').val(suggestion.data);
                },
                onHint: function (hint) {
                },
                onInvalidateSelection: function () {
                }
            });
        });
        //End-Đơn vị phụ trách

    });

        function save_data() {
            try {

                if (!confirm("Bạn có chắc muốn lưu thông tin công đoạn không?")) {
                    return;
                }

                var data = new Object();
                var congDoanId = "<%=congDoanId%>";
                if (!$.isNumeric(congDoanId)) congDoanId = 0;
                data.itemID = parseInt(congDoanId);
                data.maDonViPhuTrach = $("#<%=slcDonViPhuTrach.ClientID%>").val().trim();
                data.tenCongDoan = $("#<%=txtCongDoan.ClientID%>").val().trim();
                //data.kichHoat = '<-%=ckKichHoat.Checked%>';

                if ($("#<%=ckKichHoat.ClientID%>").is(':checked'))
                    data.kichHoat = true;
                else
                    data.kichHoat = false;

                data.maHieuCongDoan = $("#<%=txtMaHieuCongDoan.ClientID%>").val().trim();
                data.ghiChu = $("#<%=txtGhiChu.ClientID%>").val().trim();

                if (data.maHieuCongDoan == "") {
                    alert("Bạn chưa nhập Mã hiệu công đoạn.");
                    $("#<%=txtMaHieuCongDoan.ClientID%>").focus();
                    return;
                }

                if (data.tenCongDoan == "") {
                    alert("Bạn chưa nhập Tên công đoạn.");
                    $("#<%=txtCongDoan.ClientID%>").focus();
                    return;
                }


               
                var congDoan = new CongDoan(data);

                congDoan.save(function (result) {
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
        function CloseModal() {
            $("#content_div").dialog("close");
        }
</script>
