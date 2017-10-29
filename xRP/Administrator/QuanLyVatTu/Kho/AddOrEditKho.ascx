<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddOrEditKho.ascx.cs" Inherits="xRP.Administrator.QuanLyVatTu.Kho.AddOrEditKho" %>
<script type="text/javascript">
  
</script>
<script type="text/javascript"> 
   
    $(document).ready(function () {
        $('#<%=txtMaKho.ClientID%>').focus();
    });

    function save_data() {
        var id = "<%=ID_Kho%>";
        var makho = $("#<%=txtMaKho.ClientID%>").val();
        if (makho == "")
        {
            alert("Mã kho không được trống");
            $('#<%=txtMaKho.ClientID%>').focus();
            return;
        }
        var tenkho = $("#<%=txtTenKho.ClientID%>").val();
        if (tenkho == "")
        {
            alert("Tên kho không được trống");
            $('#<%=txtTenKho.ClientID%>').focus();
            return;
        }
        var diaChi = $("#<%=txtDiaChi.ClientID%>").val();
        var sodienthoai = $("#<%=txtSoDienThoai.ClientID%>").val();
        var nguoiphutrach = $("#<%=txtNguoiPhuTrach.ClientID%>").val();
        var ghichu = $("#<%=txtGhiChu.ClientID%>").val();
        var thuoctongkho = $("#<%=dropThuocTongKho.ClientID%>").val();
        if (thuoctongkho == "0")
        {
            alert("Bạn chưa chọn tổng kho");
            $("#<%=dropThuocTongKho.ClientID%>").focus();
            return;
        }

        var trang = "<%=trang%>";
        var rbkichhoat = "";
        var value = document.getElementById("<%=ckKichHoat.ClientID %>").checked;

        if (value == true) {
            rbkichhoat = "1";
        }
        if (value == false) {
            rbkichhoat = "0";
        }
        var rdBtn = document.getElementById('<%=rdlLoaiKho.ClientID%>');                             
        var rdButton = rdBtn.getElementsByTagName("input");  
        var loaikho="";

        for (var i = 0; i < rdButton.length; i++) {                                                          
            if (rdButton[i].checked) {                                                                       
                loaikho="True";                                      
            }                  
            else
            {
                loaikho="False";
            }
        }            


        var trang = "<%=trang%>";
        $.ajax({
            type: "POST",
            url: "<%#Util.SERVER_NAME %>/Administrator/QuanLyVatTu/Kho/Default.aspx/UpdateKho",
            data: "{id:'" + id + "',maKho:'" + makho + "',tenKho:'" + tenkho + "',diaChi: '" + diaChi + "',sodienthoai: '"
                    + sodienthoai + "',nguoiphutrach:'" + nguoiphutrach + "',kichHoat:'" + rbkichhoat + "',ghiChu:'" + ghichu + "',thuocTongKho:'" + thuoctongkho + "',loaiKho:'"+loaikho+"'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            cache: false,
            success: function (msg) {
                window.location.href = "<%#Util.SERVER_NAME %>/Administrator/QuanLyVatTu/Kho/Default.aspx?page=dskho&trang="+trang+"";
            }
        });
    }
</script>

<div class="work-item-form">
    
        <div class="work-item-view" style="margin-left: 10px;">

            <table class="witform-layout">
                <tbody>
                    <tr>
                        <td style="width: 25%;"></td>
                        <td style="width: 35%;"></td>
                        <td style="width: 20%;"></td>
                        <td style="width: 35%;"></td>
                    </tr>
                    <tr>
                        <td>
                            <div>
                                  <span>Mã kho</span>
                                 <span style="color:red">*</span>
                             </div>
                        </td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtMaKho" runat="server" TabIndex="1"></asp:TextBox>
                                    </div>

                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        
                        <td>
                            <div>
                                  <span>Tên kho</span>
                                 <span style="color:red">*</span>
                             </div>
                        </td>
                        <td colspan="3">
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtTenKho" runat="server" TabIndex="2"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><div>
                                  <span>Thuộc tổng kho</span>
                                 <span style="color:red">*</span>
                             </div></td>
                        <td>
                                        <asp:DropDownList ID="dropThuocTongKho" runat="server" TabIndex="3"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>Địa chỉ</td>
                        <td colspan="3">
                           <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtDiaChi" runat="server" TabIndex="4"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>Số điện thoại</td>
                        <td>
                           <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtSoDienThoai" runat="server" TabIndex="5"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td>Người phụ trách</td>
                        <td>
                             <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtNguoiPhuTrach" runat="server" TabIndex="6"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                     <tr>
                        <td>Kích hoạt</td>
                        <td>
                          <asp:CheckBox ID="ckKichHoat" runat="server" TabIndex="7" />
                        </td>
                        <td>Loại kho</td>
                        <td><asp:RadioButtonList ID="rdlLoaiKho" runat="server" RepeatColumns="2">
                                <asp:ListItem Text="NVL" Value="0" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Thành phẩm" Value="1"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td>Ghi chú
                        </td>
                        <td colspan="3">
                            <asp:TextBox TextMode="MultiLine" ID="txtGhiChu" runat="server" CssClass="text-area" TabIndex="8"></asp:TextBox>
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
    <input type="button" value="Lưu" class="xrp-button" onclick="save_data()" tabindex="9"/>
    <input type="button" value="Hủy" onclick="CloseModal();" class="xrp-button" tabindex="10" />
</div>