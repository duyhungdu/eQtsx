<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddOrEditDonViTinh.ascx.cs" Inherits="xRP.Administrator.QuanLyVatTu.DonViTinh.AddOrEditDonViTinh" %>
<script type="text/javascript">
    function save_data() {
        var id = "<%=ID_DVT%>";
        var tentinhchat = $("#<%=txtTenDonViTinh.ClientID%>").val().trim();
        if (tentinhchat == "") {
            alert("Tên tính chất nhập xuất không được trống");
            $('#<%=txtTenDonViTinh.ClientID%>').focus();
            return;
        }
      
        $.ajax({
            type: "POST",
            url: "<%#Util.SERVER_NAME %>/Administrator/QuanLyVatTu/DonViTinh/Default.aspx/ThemDonViTinh",
            data: "{id:'" + id + "',tenTinhChat:'" + tentinhchat + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            cache: false,
            success: function (msg) {
                window.location.reload(true);
                }
        });
            }

</script>

<div class="work-item-form">
    <div class="toolbar workitem-tool-bar">
        <ul class="menu-bar">
            <%--<li class="menu-item icon-only disabled"><span class="icon icon-add"></span></li>--%>
        </ul>
    </div>
    <div class="work-item-view" style="height: 100px">
        <table class="witform-layout">
            <tbody>
                <tr>
                    <td style="width: 30%;"></td>
                    <td style="width: 70%;"></td>
                    
                </tr>
                <tr>
                    <td>Tên đơn vị tính
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtTenDonViTinh" runat="server" />
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                

            </tbody>
        </table>
    </div>
</div>
<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix button-list">
    <input type="button" id="btnSave" class="xrp-button" onclick="save_data();" value="Lưu" />
    <input type="button" class="xrp-button" onclick="CloseModal();" value="Hủy" />
</div>
