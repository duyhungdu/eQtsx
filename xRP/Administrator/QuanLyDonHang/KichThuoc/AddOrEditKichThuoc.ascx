<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddOrEditKichThuoc.ascx.cs" Inherits="xRP.Administrator.QuanLyDonHang.KichThuoc.AddOrEditKichThuoc" %>

<script type="text/javascript">
    $(document).ready(function () {
        $("#<%=txtMaKichThuoc.ClientID%>").focus();
    });
    function themKichThuoc() {
        var id = "<%=ID_KichThuoc%>";
        var maKichThuoc = $("#<%=txtMaKichThuoc.ClientID%>").val().trim();
        if (maKichThuoc == "") {
            alert("Mã kích thước không được trống");
            $('#<%=txtMaKichThuoc.ClientID%>').focus();
            return;
        }
        var tenKichThuoc = $("#<%=txtTenKichThuoc.ClientID%>").val().trim();
        if (tenKichThuoc == "")
        {
            alert("Tên kích thước không được trống");
            $("#<%=txtTenKichThuoc.ClientID%>").focus();
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
        var hesochatdai = $("#<%=txtHeSoChatDai.ClientID%>").val();
        var trang = "<%=trang%>";
        $.ajax({
            type: "POST",
            url: "<%#Util.SERVER_NAME %>/Administrator/QuanLyDonHang/Default.aspx/ThemKichThuoc",
            data: "{id:'" + id + "',tenKichThuoc:'" + tenKichThuoc + "',maKichThuoc: '" + maKichThuoc + "',heSoChatDai:'"+hesochatdai+"',kichHoat: '" + kichHoat + "',ghiChu:'" + ghichu + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            cache: false,
            success: function (msg) {
                var r = msg.d;
                if (r != "SUCCESS")
                    alert(r);
                else
                window.location.href = "<%#Util.SERVER_NAME %>/Administrator/QuanLyDonHang/Default.aspx?page=dmkt&trang=" + trang + "";
            }
        });
        }
</script>

<div class="work-item-form">
        <div class="work-item-view" style="margin-left: 10px;">

            <table class="witform-layout">
                <tbody>
                    <tr>

                        <td style="width: 15%;"></td>
                        <td style="width: 20%;"></td>
                        <td style="width: 15%;"></td>
                        <td style="width: 40%;"></td>
                    </tr>
                    <tr>
                        <td >
                            <div>
                                  <span>Mã kích thước</span>
                                 <span style="color:red">*</span>
                             </div>
                        </td>
                        <td>
                            <%--<div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">--%>
                                        <asp:TextBox ID="txtMaKichThuoc" runat="server" TabIndex="1"></asp:TextBox>
                                   <%-- </div>

                                </div>
                            </div>--%>
                        </td>
                        <td >
                            <div>
                                  <span>Tên kích thước</span>
                                 <span style="color:red">*</span>
                             </div>
                        </td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtTenKichThuoc" runat="server" TabIndex="1"></asp:TextBox>
                                    </div>

                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>Hệ số chặt dài</td>
                        <td>
                            <asp:TextBox ID="txtHeSoChatDai" runat="server" TabIndex="1"></asp:TextBox>
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
    <input type="button" value="Lưu dữ liệu" class="xrp-button" onclick="themKichThuoc();" tabindex="12" />
    <input type="button" value="Hủy" onclick="CloseModal();" class="xrp-button" tabindex="13" />
</div>