<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddOrEditLoaiSanPham.ascx.cs" Inherits="xRP.Administrator.QuanLyDonHang.LoaiSanPham.AddOrEditLoaiSanPham" %>
<script type="text/javascript">
    $(document).ready(function () {
        $("#<%=txtTenLoaiSanPham.ClientID%>").focus();
    });
    function themLoaiSanPham() {
        var id = "<%=ID_LoaiSanPham%>";
        var tenLoaiSP = $("#<%=txtTenLoaiSanPham.ClientID%>").val().trim();
        if (tenLoaiSP == "") {
            alert("Tên loại sản phẩm không được trống");
            $('#<%=txtTenLoaiSanPham.ClientID%>').focus();
            return;
        }

        var congThuc = $("#<%=txtCongThuc.ClientID%>").val().trim();
        if (congThuc == "") {
            alert("Công thức tính diện tích sản phẩm không được trống");
            $('#<%=txtCongThuc.ClientID%>').focus();
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
        $.ajax({
            type: "POST",
            url: "<%#Util.SERVER_NAME %>/Administrator/QuanLyDonHang/Default.aspx/ThemLoaiSanPham",
            data: "{id:'" + id + "',tenLoaiSanPham:'" + tenLoaiSP + "', congThuc:'"+congThuc+"',kichHoat: '" + kichHoat + "',ghiChu:'" + ghichu + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            cache: false,
            success: function (msg) {
                var r = msg.d;
                if (r != "SUCCESS")
                    alert(r);
                else
                window.location.href = "<%#Util.SERVER_NAME %>/Administrator/QuanLyDonHang/Default.aspx?page=dmlsp&trang=" + trang + "";
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
                    <td style="width: 30%;"></td>
                    <td style="width: 20%;"></td>
                    <td style="width: 30%;"></td>
                </tr>
                <tr>
                    <td>
                        <div>
                            <span>Tên loại sản phẩm</span>
                            <span style="color: red">*</span>
                        </div>
                    </td>
                    <td colspan="2">
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtTenLoaiSanPham" runat="server" TabIndex="1"></asp:TextBox>
                                </div>

                            </div>
                        </div>
                    </td>

                </tr>
                <tr>
                    <td>
                        <div>
                            <span>Kích hoạt</span>
                        </div>
                    </td>
                    <td colspan="3">
                        <asp:CheckBox ID="chkKichHoat" runat="server"></asp:CheckBox>
                    </td>
                </tr>
                <tr>
                    <td>
                            <div>
                                <span>Công thức tính diện tích</span>
                            </div>
                    </td>
                    <td colspan="3">
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                <asp:TextBox ID="txtCongThuc" runat="server" />
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
    <input type="button" value="Lưu dữ liệu" class="xrp-button" onclick="themLoaiSanPham();" tabindex="12" />
    <input type="button" value="Hủy" onclick="CloseModal();" class="xrp-button" tabindex="13" />
</div>
