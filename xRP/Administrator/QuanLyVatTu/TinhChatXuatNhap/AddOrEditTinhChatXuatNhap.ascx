<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddOrEditTinhChatXuatNhap.ascx.cs" Inherits="xRP.Administrator.QuanLyVatTu.TinhChatXuatNhap.AddOrEditTinhChatXuatNhap" %>

<script type="text/javascript">
    $(document).ready(function () {
        $('#<%=txtTenTinhChat.ClientID%>').focus();
    });
    function loadhtml() {
        window.location.reload(true);
    }
    function save_data() {
        var id = "<%=ID_TinhChat%>";
        var matinhchat = $("#<%=txtMaTinhChat.ClientID%>").val().trim();
        if (matinhchat == "") {
            alert("Mã tính chất nhập xuất không được trống");
            $('#<%=txtMaTinhChat.ClientID%>').focus();
            return;
        }
        var tentinhchat = $("#<%=txtTenTinhChat.ClientID%>").val().trim();
        if (tentinhchat == "") {
            alert("Tên tính chất nhập xuất không được trống");
            $('#<%=txtTenTinhChat.ClientID%>').focus();
            return;
        }
        var ghichu = $("#<%=txtGhiChu.ClientID%>").val();
        var rbvalue = $("input[name='<%=rbtnPhanLoai.UniqueID%>']:radio:checked").val();
        var kichHoat = "";
        var value = document.getElementById("<%=ckKichHoat.ClientID %>").checked;
        if (value == true) {
            kichHoat = "1";
        }
        if (value == false) {
            kichHoat = "0";
        }
        var noibo = "";
        var laNB = document.getElementById("<%=chkNoiBo.ClientID %>").checked;
        if (laNB == true) {
            noibo = "1";
        }
        if (laNB == false) {
            noibo = "0";
        }
        var trang = "<%=trang%>";
        $.ajax({
            type: "POST",
            url: "<%#Util.SERVER_NAME %>/Administrator/QuanLyVatTu/TinhChatXuatNhap/Default.aspx/ThemTinhChatXuatNhap",
            data: "{id:'" + id + "', maTinhChatNhapXuat: '" + matinhchat + "',tenTinhChat:'" + tentinhchat + "',phanLoai:'" + rbvalue + "',kichHoat: '" + kichHoat + "',ghiChu: '" + ghichu + "',lanoibo:'" + noibo + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                cache: false,
                success: function (msg) {
                    window.location.href = "<%#Util.SERVER_NAME %>/Administrator/QuanLyVatTu/TinhChatXuatNhap/Default.aspx?page=tcnx&trang=" + trang + "";
                }
            });
            }
</script>
<div class="work-item-form">
    <div class="work-item-view">

        <table class="witform-layout">
            <tbody>
                <tr>
                    <td style="width: 35%;"></td>
                    <td style="width: 15%;"></td>
                    <td style="width: 35%;"></td>
                    <td style="width: 25%;"></td>
                </tr>
                <tr>
                    <td>
                        <div>
                            <span>Mã chất nhập xuất</span>
                            <span style="color: red">*</span>
                        </div>
                    </td>
                    <td colspan="3">
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtMaTinhChat" runat="server" TabIndex="1"></asp:TextBox>
                                </div>

                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div>
                            <span>Tên tính chất nhập xuất</span>
                            <span style="color: red">*</span>
                        </div>
                    </td>
                    <td colspan="3">
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtTenTinhChat" runat="server" TabIndex="1"></asp:TextBox>
                                </div>

                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:CheckBox ID="ckKichHoat" runat="server" Checked="true" TabIndex="2" Text="Kích hoạt"></asp:CheckBox>
                    </td>
                    <td>Phân loại</td>
                    <td>
                        <asp:RadioButtonList ID="rbtnPhanLoai" runat="server" TabIndex="2" RepeatColumns="3">
                            <asp:ListItem Value="1" Text="Nhập" Selected="True" />
                            <asp:ListItem Value="2" Text="Xuất" />
                        </asp:RadioButtonList>
                    </td>
                    <td>
                        <asp:CheckBox ID="chkNoiBo" runat="server" Checked="true" TabIndex="4" Text="Nội bộ"></asp:CheckBox>
                    </td>
                    <tr>
                        <td>Ghi chú</td>
                        <td colspan="3">
                            <asp:TextBox ID="txtGhiChu" runat="server" TextMode="MultiLine" TabIndex="5"></asp:TextBox>
                        </td>
                    </tr>
            </tbody>
        </table>
    </div>
</div>
<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix button-list">
    <input type="button" value="Lưu" class="xrp-button" onclick="save_data();" tabindex="5" />
    <input type="button" value="Hủy" onclick="CloseModal();" class="xrp-button" tabindex="6" />
</div>
