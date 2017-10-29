<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddOrEditSong.ascx.cs" Inherits="xRP.Administrator.QuanLyDonHang.Song.AddOrEditSong" %>
<script type="text/javascript">
    $(document).ready(function () {
        $("#<%=txtTenSong.ClientID%>").focus();
    });
    function themSong() {
        var id = "<%=ID_Song%>";
        var tenSong = $("#<%=txtTenSong.ClientID%>").val().trim();
        if (tenSong == "") {
            alert("Tên sóng không được trống");
            $('#<%=txtTenSong.ClientID%>').focus();
            return;
        }
        var heSoTieuHao = $("#<%=txtHeSoTieuHao.ClientID%>").val();
        if (heSoTieuHao && !$.isNumeric(heSoTieuHao)) {
            alert("Hệ số tiêu hao phải là kiểu số");
            $('#<%=txtHeSoTieuHao.ClientID%>').focus();
            return;
        }
        var ghichu = $("#<%=txtGhiChu.ClientID%>").val();

        var kichHoat = "";
        var value = document.getElementById("<%=chkKichHoat.ClientID %>").checked;

        if (value == true) {
            kichHoat = "1";
        }
        if (value == false) {
            kichHoat = "0";
        }
        var hesotieuhao = $("#<%=txtHeSoTieuHao.ClientID%>").val();
        var trang = "<%=trang%>";
        $.ajax({
            type: "POST",
            url: "<%#Util.SERVER_NAME %>/Administrator/QuanLyDonHang/Default.aspx/ThemSong",
            data: "{id:'" + id + "',tenSong:'" + tenSong + "',heSoTieuHao: '" + hesotieuhao + "',kichHoat: '" + kichHoat + "',ghiChu:'" + ghichu + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            cache: false,
            success: function (msg) {
                var r = msg.d;
                if (r != "SUCCESS")
                    alert(r);
                else
                    window.location.href = "<%#Util.SERVER_NAME %>/Administrator/QuanLyDonHang/Default.aspx?page=dmsong&trang=" + trang + "";
            }
        });
    }
</script>
<div class="work-item-form">
        <div class="work-item-view" style="margin-left: 10px;">

            <table class="witform-layout">
                <tbody>
                    <tr>

                        <td style="width: 10%;"></td>
                        <td style="width: 20%;"></td>
                        <td style="width: 10%;"></td>
                        <td style="width: 60%;"></td>
                    </tr>
                    <tr>
                        <td >
                            <div>
                                  <span>Tên sóng</span>
                                 <span style="color:red">*</span>
                             </div>
                        </td>
                        <td colspan="3">
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtTenSong" runat="server" TabIndex="1"></asp:TextBox>
                                    </div>

                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>Hệ số tiêu hao</td>
                        <td>
                            <asp:TextBox ID="txtHeSoTieuHao" runat="server" TabIndex="1"></asp:TextBox>
                        </td>
                        <td>Kích hoạt</td>
                        <td>
                            <asp:CheckBox ID="chkKichHoat" runat="server"></asp:CheckBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Ghi chú</td>
                        <td colspan="3">
                            <asp:TextBox ID="txtGhiChu" runat="server" TabIndex="1" TextMode="MultiLine" Rows="3"></asp:TextBox>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix button-list">
    <input type="button" value="Lưu dữ liệu" class="xrp-button" onclick="themSong();" tabindex="12" />
    <input type="button" value="Hủy" onclick="CloseModal();" class="xrp-button" tabindex="13" />
</div>