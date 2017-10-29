<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddOrEditLoaiVatTu.ascx.cs" Inherits="xRP.Administrator.QuanLyVatTu.LoaiVatTu.AddOrEditLoaiVatTu" %>
<script type="text/javascript">
    $("#btnSave").click(function () {
        var lvt = new LoaiVatTu({
            itemID: "<%=ID_LoaiVatTu%>",
            maLoai: $("#<%=AddOrEditLoaiVatTu_txtMaLoai.ClientID%>").val(),
            tenLoai: $("#<%=AddOrEditLoaiVatTu_txtTenLoai.ClientID%>").val(),
            ghiChu: $("#<%=AddOrEditLoaiVatTu_txtGhiChu.ClientID%>").val()
        });
        if (lvt.data.maLoai == "") {
            alert("Bạn chưa nhập mã loại vật tư");
            $("#<%=AddOrEditLoaiVatTu_txtMaLoai.ClientID%>").focus();
            return;
        }
        if (lvt.data.maLoai == "") {
            alert("Bạn chưa nhập tên loại vật tư");
            $("#<%=AddOrEditLoaiVatTu_txtTenLoai.ClientID%>").focus();
            return;
        }
        lvt.save(function () {
            CloseModal();
        });
    });

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
                    <td style="width: 10%;"></td>
                    <td style="width: 40%;"></td>
                    <td style="width: 10%;"></td>
                    <td style="width: 40%;"></td>
                </tr>
                <tr>
                    <td>Mã loại
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="AddOrEditLoaiVatTu_txtMaLoai" runat="server" />
                                </div>

                            </div>
                        </div>
                    </td>
                    <td>Tên loại
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="AddOrEditLoaiVatTu_txtTenLoai" runat="server" />
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Ghi chú:
                    </td>
                    <td colspan="3">
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="AddOrEditLoaiVatTu_txtGhiChu" runat="server" />
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
    <input type="button" id="btnSave" class="xrp-button" value="Lưu" />
    <input type="button" class="xrp-button" onclick="CloseModal();" value="Hủy" />
</div>
