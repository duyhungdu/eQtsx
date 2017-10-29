<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddOrEditNhaCungCap.ascx.cs" Inherits="xRP.Administrator.QuanLyVatTu.NhaCungCap.AddOrEditNhaCungCap" %>
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
                            <span>Mã nhà cung cấp</span>
                            <span style="color: red">*</span>
                        </div>
                    </td>
                    <td colspan="2">
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtMaNCC" runat="server"></asp:TextBox>
                                </div>

                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div>
                            <span>Tên nhà cung cấp</span>
                            <span style="color: red">*</span>
                        </div>
                    </td>
                    <td colspan="3">
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtTenNhaCungCap" runat="server" Width="100%"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Địa chỉ nhà cung cấp</td>
                    <td colspan="3">
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtDiaChiNhaCungCap" runat="server"></asp:TextBox>

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
                                    <asp:TextBox ID="txtSoDienThoaiLienHe" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>Số máy fax</td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtSoMayFax" runat="server"></asp:TextBox>
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
                                    <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>Tài khoản ngân hàng</td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtTaiKhoanNganHang" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Mở tại ngân hàng</td>
                    <td colspan="3">
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtMoTaiNganHang" runat="server"></asp:TextBox>
                                </div>

                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Địa chỉ website</td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtDiaChiWebsite" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>Kích hoạt</td>
                    <td>
                        <asp:CheckBox ID="ckKichHoat" runat="server" Checked="true"></asp:CheckBox>
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
    </div>
</div>
<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix button-list">
    <input type="button" value="Lưu" class="xrp-button" onclick="save_data();"/>
    <input type="button" value="Hủy" onclick="CloseModal();" class="xrp-button"/>
</div>
<script type="text/javascript">

    $(document).ready(function () {
        $('#<%=txtMaNCC.ClientID%>').focus();
    });
    function save_data() {
        var id = "<%=ID_NhaCungCap%>";
        var sotrang = "<%=trang%>";
        var manhacc = $("#<%=txtMaNCC.ClientID%>").val().trim();
        if (manhacc == "") {
            alert("Mã nhà cung cấp không được trống");
            $('#<%=txtMaNCC.ClientID%>').focus();
            return;
        }
        var tennhacungcap = $("#<%=txtTenNhaCungCap.ClientID%>").val().trim();
        if (tennhacungcap == "") {
            alert("Tên nhà cung cấp không được trống");
            $('#<%=txtTenNhaCungCap.ClientID%>').focus();
            return;
        }
        var diachi = $("#<%=txtDiaChiNhaCungCap.ClientID%>").val();
        var dienthoai = $("#<%=txtSoDienThoaiLienHe.ClientID%>").val();
        var fax = $("#<%=txtSoMayFax.ClientID%>").val();
        var email = $("#<%=txtEmail.ClientID%>").val();
        var taikhoan = $("#<%=txtTaiKhoanNganHang.ClientID%>").val();
        var nganhang = $("#<%=txtMoTaiNganHang.ClientID%>").val();
        var website = $("#<%=txtDiaChiWebsite.ClientID%>").val();
        var ghichu = $("#<%=txtGhiChu.ClientID%>").val();
        var rbkichhoat = "";
        var value = document.getElementById("<%=ckKichHoat.ClientID %>").checked;

        if (value == true) {
            rbkichhoat = "1";
        }
        if (value == false) {
            rbkichhoat = "0";
        }


        $.ajax({
            type: "POST",
            url: "<%#Util.SERVER_NAME %>/Administrator/QuanLyVatTu/NhaCungCap/Default.aspx/UpdateNhaCungCap",
            data: "{id:'" + id + "',manhacc:'" + manhacc + "',tennhacungcap:'" + tennhacungcap + "',diaChi: '" + diachi + "',sodienthoai: '"
                + dienthoai + "',somayfax:'" + fax + "',email:'" + email + "',taikhoannganhang:'" + taikhoan + "',motainganhang: '" + nganhang + "',diachiweb: '"
                + website + "',kichhoat:'" + rbkichhoat + "',ghichu:'" + ghichu + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            cache: false,
            success: function (msg) {
                window.location.reload(true);
                window.location.href = "<%#Util.SERVER_NAME %>/Administrator/QuanLyVatTu/NhaCungCap/Default.aspx?page=dsnhacungcap&trang=" + sotrang + "";
            }
        });
    }
</script>
