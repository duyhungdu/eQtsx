<%@ Control Language="C#" AutoEventWireup="true"   CodeBehind="AddOrEdit.ascx.cs" Inherits="xRP.Administrator.QuanLyHeThong.ThongSoHeThong.AddOrEdit" %>
<script src="/Scripts/plugins/ckeditor/ckeditor.js"></script>
<script src="/Scripts/plugins/ckeditor/config.js"></script>
<style>
    .error { color: red; font-size: 11px; }
    .success { color: green; font-size: 11px; }
</style>

<script type="text/javascript">

    var loadEditor = function () {
        var oFCKeditor = CKEDITOR.replace('<%=txtValue.ClientID%>', {
            customConfig: '/Scripts/plugins/ckeditor/config.js',
            width: "800px",
            height: "260px"
        });
        oFCKeditor.BasePath = '/Scripts/plugins/ckeditor/';
    }

    $(document).ready(function () {
        $('#<%=txtTen.ClientID%>').focus();
        loadEditor();
    });

    function loadhtml() {
        window.location.reload(true);
    }

    function loadurl() {

        var id = "<%= id %>";
        var nameId = "#<%=txtTen.ClientID%>";
        var noteId = "#<%=txtNote.ClientID%>";
        var valueId = "#<%=txtValue.ClientID%>";


        var name = $(nameId).val();
        var note = $(noteId).val();
        var value = $(valueId).val();

        var message = "";

        if (Utils.isEmpty(name) || name.length < 3) {
            message += "Tên không được để trống, tối thiểu 3 ký tự. \n";
        }

        if (message.length > 0) {
            alert(message);
            return;
        }

        var trang = "<%=trang%>";

        $.ajax({
            type: "POST",
            url: "<%#Util.SERVER_NAME %>/Administrator/QuanLyHeThong/Default.aspx/AddOrUpdateConfigItem",
            data: "{id:'" + id + "',name:'" + name + "',note:'" + note + "',value: '" + value + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            cache: false,
            success: function (result) {
                result = JSON.parse(result.d);
                var isSuccess = result.IsSuccess;
                var message = result.Message;
                if (isSuccess) {
                    window.location.href = "<%#Util.SERVER_NAME %>/Administrator/QuanLyHeThong/Default.aspx?page=config&trang=" + trang + "";
                } else {
                    alert("Lỗi:  " + message);
                }
            }
        });
    }
</script>



<div class="splitter horizontal hub-splitter stateful toggle-button-enabled toggle-button-hotkey-enabled">

    <div class="rightPane" style="left: 0px;">
        <div class="hub-title">
            <div class="query-result-grid-info">
                <table>
                    <tbody>
                        <tr>
                            <td class="query-title"></td>
                            <td class="query-status hub-title-right"></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="right-hub-content">
            <div class="work-item-form" style="display: block;">
                <div class="workitem-info-bar">
                    <% if (string.IsNullOrEmpty(id))
                       { %>
                    <div class="info-text-wrapper"><span class="info-text">Thêm thông số hệ thống</span></div>
                    <% } %>
                    <% if (!string.IsNullOrEmpty(id))
                       { %>
                    <div class="info-text-wrapper"><span class="info-text"> Sửa thông số hệ thống</span></div>

                    <% } %>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block;">
                    <ul class="menu-bar">
                        <li id="btn-luu" class="menu-item icon-only">
                            <asp:Button runat="server" ID="btnAdd" OnClick="btnAdd_Click" class="menu-bar-item-button icon icon-save"  Text="" />
                        </li>

                        <li id="btn-cancel" class="menu-item icon-only">
                            <a class="menu-bar-item-button icon cancel-icon" href="Default.aspx?page=config" title="Hủy"></a>
                        </li>

                        <li class="menu-item">
                            <asp:Label runat="server" ID="lblMessage"></asp:Label>
                        </li>
                    </ul>
                </div>

                <div class="work-item-form frm">
                    <div class="work-item-view">

                        <table class="witform-layout " style="width: 800px;">
                            <tbody>
                                <tr>
                                    <td style="width: 25%;"></td>
                                    <td style="width: 25%;"></td>
                                    <td style="width: 15%;"></td>
                                    <td style="width: 35%;"></td>
                                </tr>
                                <tr>
                                    <td>
                                        <div>
                                            <span>Tên</span>
                                            <span style="color: red">*</span>
                                        </div>
                                    </td>
                                    <td colspan="3">
                                        <div class="workitemcontrol">
                                            <div class="combo tree drop">
                                                <div class="wrap">
                                                    <asp:TextBox ID="txtTen" runat="server" TabIndex="1"></asp:TextBox>
                                                </div>

                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div>
                                            <span>Mô tả</span>
                                            <span style="color: red">*</span>
                                        </div>
                                    </td>
                                    <td colspan="3">
                                        <div class="workitemcontrol">
                                            <div class="wrap">
                                                <asp:TextBox ID="txtNote" runat="server" TextMode="MultiLine" MaxLength="250" TabIndex="1"></asp:TextBox>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="vertical-align: top;">
                                        <div>
                                            <span>Giá trị</span>
                                            <span style="color: red">*</span>
                                        </div>
                                    </td>
                                    <td colspan="3">
                                        <div class="workitemcontrol">
                                            <div class="wrap">
                                                <asp:TextBox ID="txtValue" TextMode="MultiLine" runat="server" TabIndex="1"></asp:TextBox>

                                            </div>
                                        </div>
                                    </td>
                                </tr>


                            </tbody>
                        </table>

                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
