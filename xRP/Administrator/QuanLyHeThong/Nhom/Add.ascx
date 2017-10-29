<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Add.ascx.cs" Inherits="xRP.Administrator.QuanLyHeThong.Nhom.Add" %>
 <script type="text/javascript">
     var tab = function (active) {
         $('.manage-view-tabs li').removeClass();
         $('.user_tab').hide();
         $('#' + active).show();
     }

     $(document).ready(function () {
         $('.data-item').click(function (event) {
             if (event.target.type !== 'checkbox') {
                 $(':checkbox', this).trigger('click');
             }
         });
     });
    </script>
    <style>
        .data-item { cursor: pointer; }
        .error { color: red; font-size:11px; }
        .success { color: green; font-size:11px;}
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
                        <div class="info-text-wrapper"><span class="info-text">Thêm nhóm</span></div>
                    </div>
                    <div class="toolbar workitem-tool-bar" style="display: block;">
                        <ul class="menu-bar">
                            <li id="btn-luu" class="menu-item icon-only">
                                <asp:Button runat="server" ID="btnSave" CssClass="menu-bar-item-button icon icon-save" title="Lưu" OnClick="btnSave_Click" />
                            </li>

                            <li id="btn-cancel" class="menu-item icon-only">
                                <a class="menu-bar-item-button icon cancel-icon" href="default.aspx?page=group" title="Hủy"></a>
                            </li>

                            <li class="menu-item">
                                <asp:Label runat="server" ID="lblMessage"></asp:Label>
                            </li>
                        </ul>
                    </div>
                    <div class="work-item-view" style="display: block;">
                        <div class="hub-pivot">
                            <div class="views">
                                <ul class="empty pivot-view enhance manage-view-tabs" style="margin-left: 10px;">
                                    <li class="selected" title="Tài khoản"><a href="javascript:void(0)" onclick="tab('user_info');$(this).parent().addClass('selected');">Thông tin chung</a></li>
                                    <li title="Quyền"><a href="javascript:void(0)" onclick="tab('user_permission'); $(this).parent().addClass('selected'); ">Quyền</a></li>
                                </ul>
                            </div>
                        </div>
                        <table>
                            <tr>
                                <td>
                                    <div class="identity-details-section user_tab" id="user_info" style="display: block; height: auto;">
                                        <div class="manage-info">
                                            <div class=" vertical-fill-layout">
                                                <div class="permission-content fill-content">
                                                    <div class="display-permissions-error-pane"></div>
                                                    <div class="content">
                                                        <div class="ace-control permissions-effective">
                                                            <table class="witform-layout " style="width: 600px;">
                                                                <tbody>
                                                                    <tr>
                                                                        <td style="width: 180px;"></td>
                                                                        <td style="width: 25%;"></td>
                                                                        <td style="width: 15%;"></td>
                                                                        <td style="width: 35%;"></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <div>
                                                                                <span>Tên nhóm</span>
                                                                                <span style="color: red">*</span>
                                                                            </div>
                                                                        </td>
                                                                        <td colspan="3">
                                                                            <div class="workitemcontrol">
                                                                                <asp:TextBox ID="txtName" runat="server" TabIndex="1"  Width="260px"></asp:TextBox>
                                                                                <br />
                                                                                <asp:Label runat="server" ID="lblNameError" CssClass="error"></asp:Label>
                                                                                <asp:RequiredFieldValidator runat="server" ID="requireFieldValidator" ControlToValidate="txtName" SetFocusOnError="true"></asp:RequiredFieldValidator>
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
                                                                                    <asp:TextBox TextMode="MultiLine" ID="txtNote" runat="server" TabIndex="1"></asp:TextBox>

                                                                                </div>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Kích hoạt
                                                                        </td>
                                                                        <td>
                                                                            <asp:CheckBox ID="ckKichHoat" runat="server" Checked="true" TabIndex="3"></asp:CheckBox>
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

                                    <div class="identity-details-section user_tab" id="user_permission" style="display: none; height: auto;">

                                        <div class="manage-info">
                                            <div class=" vertical-fill-layout">
                                                <%--   <div class="description fixed-header">Danh sách nhóm.</div>--%>
                                                <div class="permission-content fill-content">
                                                    <div class="display-permissions-error-pane"></div>
                                                    <div class="content">
                                                        <div class="ace-control permissions-effective">
                                                            <table class="witform-layout " style="width: 600px;">
                                                                <tbody>
                                                                    <asp:Repeater runat="server" ID="rptPermissions">
                                                                        <ItemTemplate>
                                                                            <tr class="permission-row permission-not-editable data-item">
                                                                                <td class="permission-name-column">
                                                                                    <asp:HiddenField runat="server" ID="hdfRole" Value='<%# Eval("ID") %>' />
                                                                                    <span style="color: #000;">
                                                                                        <%# Eval("Name") %>
                                                                                    </span></td>
                                                                                <td class="permission-value-column accessible" tabindex="0">
                                                                                    <asp:CheckBox runat="server" ID="chkAdd" />
                                                                                </td>
                                                                            </tr>
                                                                        </ItemTemplate>
                                                                    </asp:Repeater>

                                                                </tbody>
                                                            </table>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>


                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <asp:HiddenField runat="server" ID="hdfID" />