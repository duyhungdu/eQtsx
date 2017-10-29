<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Add.ascx.cs" Inherits="xRP.Administrator.QuanLyHeThong.PhongBan.Deparment.AddRoot" %>

<script type="text/javascript">
    $(document).ready(function () {
        $('#<%=txtCode.ClientID%>').focus();
        var parentId=<%= parentID %>;
        $('#ddlDepartment').val(parentId);
    });

    function loadhtml() {
        window.location.reload(true);
    }

    function loadurl() {

        var id = "<%= id %>";

        var nameId = "#<%=txtName.ClientID%>";
        var codeId = "#<%=txtCode.ClientID%>";
        var noteId = "#<%=txtNote.ClientID%>";

        var name = $(nameId).val();
        var code = $(codeId).val();
        var note = $(noteId).val();


        var message = "";

        if (Utils.isEmpty(name) || name.length < 3) {
            message += "Tên không được để trống, tối thiểu 3 ký tự. \n";
        }

        
        //if (Utils.isEmpty(code) || code.length < 3) {
        //    message += "Tên không được để trống, tối thiểu 3 ký tự. \n";
        //}

        if (Utils.isEmpty(code) || code.length < 3) {
            message += "Mã không được để trống, tối thiểu 3 ký tự. \n";
        }

        if (message.length > 0) {
            alert(message);
            return;
        }

        var trang = "<%=trang%>";

        $.ajax({
            type: "POST",
            url: "<%#Util.SERVER_NAME %>/Administrator/QuanLyHeThong/Default.aspx/AddDepartment",
            data: "{name:'" + name + "',note: '" + note + "',code:'" + code + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            cache: false,
            success: function (result) {
                result = JSON.parse(result.d);
                var isSuccess = result.IsSuccess;
                var message = result.Message;
                if (isSuccess) {
                    window.location.href = "<%#Util.SERVER_NAME %>/Administrator/QuanLyHeThong/Default.aspx?page=department&trang=" + trang + "";
                } else {
                    alert("Lỗi:  " + message);
                }
            }
        });
    }
</script>
<style>
    .data-item { cursor: pointer; }
    .error { color: red; font-size: 11px; }
    .success { color: green; font-size: 11px; }
    .permission-name-column { color: #000; }
    .content-header { border-bottom: 4px solid #dfdfdf; }
    .grant-permission { color: green; }
    .deny-permission { color: #ff6a00; }
    .delete-permission { color: red; }
</style>

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
                    <% if (id == "0")
                       { %>
                    <div class="info-text-wrapper"><span class="info-text">Thêm phòng ban</span></div>
                    <% } %>
                    <% if (id != "0")
                       { %>
                    <div class="info-text-wrapper"><span class="info-text">Sửa phòng ban</span></div>
                    <% } %>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block;">
                    <ul class="menu-bar">
                        <li id="btn-luu" class="menu-item icon-only">
                            <asp:Button runat="server" ID="btnSave" CssClass="menu-bar-item-button icon icon-save" title="Lưu" OnClick="btnSave_Click" />
                        </li>

                        <li id="btn-cancel" class="menu-item icon-only">
                            <a class="menu-bar-item-button icon cancel-icon" href="default.aspx?page=department" title="Hủy"></a>
                        </li>

                        <li class="menu-item">
                            <asp:Label runat="server" ID="lblMessage"></asp:Label>
                        </li>
                    </ul>
                </div>
                <div class="work-item-view" style="display: block;">
                    <table class="witform-layout " style="width: 600px;">
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
                                        <span>Mã phòng ban</span>
                                        <span style="color: red">*</span>
                                    </div>
                                </td>
                                <td colspan="3">
                                    <div class="workitemcontrol">
                                        <div>
                                            <div class="wrap">
                                                <asp:TextBox ID="txtCode" Width="260px" runat="server" TabIndex="1"></asp:TextBox>

                                                <asp:RequiredFieldValidator ControlToValidate="txtCode" ID="RequiredFieldValidator1" runat="server" ErrorMessage=""></asp:RequiredFieldValidator>
                                                <br />
                                                <asp:Label runat="server" ID="lblNameError" CssClass="error"></asp:Label>

                                            </div>

                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div>
                                        <span>Tên phòng ban</span>
                                        <span style="color: red">*</span>
                                    </div>
                                </td>
                                <td colspan="3">
                                    <div class="workitemcontrol">
                                        <div>
                                            <div class="wrap">
                                                <asp:TextBox Width="260px" ID="txtName" runat="server" TabIndex="1"></asp:TextBox>
                                                <asp:RequiredFieldValidator ControlToValidate="txtName" ID="RequiredFieldValidator2" runat="server" ErrorMessage=""></asp:RequiredFieldValidator>
                                            </div>

                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div>
                                        <span>Đơn vị cấp trên</span>
                                        <span style="color: red">*</span>
                                    </div>
                                </td>
                                <td colspan="3">
                                    <div class="workitemcontrol">
                                        <div>
                                            <div class="wrap">
                                                <select id="ddlDepartment" name="ddlDepartment" style="width: 260px">
                                                    <option value="0">Cấp cao nhất</option>
                                                    <%= Nodes %>
                                                </select>
                                            </div>

                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div>
                                        <span>Ghi chú</span>

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
                        </tbody>
                    </table>

                </div>
            </div>
        </div>
    </div>
</div>


<asp:Label runat="server" ID="lblNodeFormat" Text="<option value={0}>{1}</option>" Visible="false"></asp:Label>