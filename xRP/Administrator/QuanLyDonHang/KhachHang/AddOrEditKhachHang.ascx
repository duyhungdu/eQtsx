<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddOrEditKhachHang.ascx.cs" Inherits="xRP.Administrator.QuanLyDonHang.KhachHang.AddOrEditKhachHang" %>

<script type="text/javascript">
    $(document).ready(function () {
        $("#<%=txtMaKhachHang.ClientID%>").focus();
    });
    function themKhachHang() {
        var id = "<%=ID_NhomKH%>";
        var makhachhang = $("#<%=txtMaKhachHang.ClientID%>").val().trim();
        if (makhachhang == "")
        {
            alert("Mã khách hàng không được trống");
            $("#<%=txtMaKhachHang.ClientID%>").focus();
            return;
        }
         var tenkhachhang = $("#<%=txtTenKhachHang.ClientID%>").val().trim();
        if (tenkhachhang == "") {
             alert("Tên khách hàng không được trống");
             $('#<%=txtTenKhachHang.ClientID%>').focus();
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
        var trang = "<%=trang%>";
        var idNhomKH=$("#<%=dropNhomKH.ClientID%>").val();
        var diaChiKH=$("#<%=txtDiaChiKhachHang.ClientID%>").val();
        var dienthoaiLienHe=$("#<%=txtSoDienThoaiLienHe.ClientID%>").val();
        var thongtinlienhe=$("#<%=txtNguoiLienLac.ClientID%>").val();
        var email=$("#<%=txtEmail.ClientID%>").val();
        var fax=$("#<%=txtSoMayFax.ClientID%>").val();

        $.ajax({
            type: "POST",
            url: "<%#Util.SERVER_NAME %>/Administrator/QuanLyDonHang/Default.aspx/ThemKhachHang",
            data: "{id:'" + id + "',maKhachHang:'" + makhachhang + "',tenKhachHang: '" + tenkhachhang + "',idNhomKhachHang:'" + idNhomKH + "',diaChi:'"+diaChiKH+"',dienthoaiLienHe:'"+dienthoaiLienHe+"',fax:'"+fax+"',email:'"+email+"',thongtinLienHe:'"+thongtinlienhe+"',kichHoat:'"+kichHoat+"',ghiChu:'"+ghichu+"'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            cache: false,
            success: function (msg) {
                var r = msg.d;
                if (r != "SUCCESS")
                    alert(r);
                else
                    if ('<%=type%>' == "2")
                    {
                        CloseModalKH();
                    }
                    else
                    {
                        window.location.href = "<%#Util.SERVER_NAME %>/Administrator/QuanLyDonHang/Default.aspx?page=dmkh&trang=" + trang + "";
                    }
            }
        });
        }
</script>
 
<div class="work-item-form">
        <div class="work-item-view" style="margin-left: 10px;">

            <table class="witform-layout">
                <tbody>
                    <tr>

                        <td style="width: 20%;"></td>
                        <td style="width: 20%;"></td>
                        <td style="width: 20%;"></td>
                        <td style="width: 45%;"></td>
                    </tr>
                    <tr>
                        <td >
                            <div>
                                  <span>Mã khách hàng</span>
                                 <span style="color:red">*</span>
                             </div>
                        </td>
                        <td >
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtMaKhachHang" runat="server" TabIndex="1"></asp:TextBox>
                                    </div>

                                </div>
                            </div>
                        </td>
                       
                        <td>
                             <div>
                                  <span>Tên khách hàng</span>
                                 <span style="color:red">*</span>
                             </div>
                        </td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                       <asp:TextBox ID="txtTenKhachHang" runat="server" TabIndex="2" Width="100%"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>Nhóm khách hàng</td>
                        <td>
                            <asp:DropDownList ID="dropNhomKH" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td>
                            Kích hoạt
                        </td>
                        <td>
                           <asp:CheckBox ID="chkKichHoat" runat="server"></asp:CheckBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Địa chỉ khách hàng</td>
                        <td colspan="3">
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                       <asp:TextBox ID="txtDiaChiKhachHang" runat="server" TabIndex="3"></asp:TextBox>

                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>Số điện thoại liên hệ</td>
                        <td>
                           <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                       <asp:TextBox ID="txtSoDienThoaiLienHe" runat="server" TabIndex="4"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td>Số máy fax</td>
                        <td>
                           <div class="workitemcontrol">
                                <div class="combo tree drop  short-control-50">
                                    <div class="wrap">
                                      <asp:TextBox ID="txtSoMayFax" runat="server" TabIndex="5"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>Email</td>
                        <td>
                             <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                       <asp:TextBox ID="txtEmail" runat="server" TabIndex="6"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td>Thông tin liên hệ</td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                       <asp:TextBox ID="txtNguoiLienLac" runat="server" TabIndex="7"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>Ghi chú</td>
                        <td colspan="3">
                            <asp:TextBox ID="txtGhiChu" runat="server" TextMode="MultiLine" Rows="3"></asp:TextBox>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix button-list">
    <input type="button" value="Lưu dữ liệu" class="xrp-button" onclick="themKhachHang();" tabindex="12" />
    <input type="button" value="Hủy" onclick="CloseModal();" class="xrp-button" tabindex="13" />
</div>
