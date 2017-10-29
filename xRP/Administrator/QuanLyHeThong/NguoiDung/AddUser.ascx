<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddUser.ascx.cs" Inherits="xRP.Administrator.QuanLyHeThong.NguoiDung.AddUser" %>
<link href="/Styles/font-awesome/css/font-awesome.min.css" rel="stylesheet" />

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

    var triggerFirstPanel = function () {
        //$('ul.manage-view-tabs li').removeClass("");
        tab('user_info');
        $('#liUserInfo').addClass('selected');
    }

</script>
<style>
    .permission-name-column { color: #000; }
    .content-header { border-bottom: 4px solid #dfdfdf; }
    .grant-permission { color: green; }
    .deny-permission { color: #ff6a00; }
    .delete-permission { color: red; }

    .error { color: red; font-size: 11px; }
    .success { color: green; font-size: 11px; }
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
                    <div class="info-text-wrapper"><span class="info-text">Thêm người dùng</span></div>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block;">
                    <ul class="menu-bar">
                        <li id="btn-luu" class="menu-item icon-only">
                            <asp:Button runat="server" ID="btnAdd" class="menu-bar-item-button icon icon-save" OnClientClick="triggerFirstPanel()" OnClick="btnAdd_Click" Text="" />

                        </li>

                        <li id="btn-cancel" class="menu-item icon-only">
                            <a class="menu-bar-item-button icon cancel-icon" href="Default.aspx?page=user" title="Hủy"></a>
                        </li>

                    
                    </ul>
                </div>
                <div class="work-item-view" style="display: block;">


                    <div class="hub-pivot">
                        <div class="views">
                            <ul class="empty pivot-view enhance manage-view-tabs" style="margin-left: 10px;">
                                <li class="selected" id="liUserInfo" title="Tài khoản"><a href="javascript:void(0)" onclick="tab('user_info');$(this).parent().addClass('selected');">Thông tin tài khoản</a></li>
                                <li title="Quyền"><a href="javascript:void(0)" onclick="tab('user_permission'); $(this).parent().addClass('selected'); ">Quyền</a></li>
                                <li title="Members" class=""><a href="javascript:void(0)" onclick="tab('user_group');$(this).parent().addClass('selected');">Nhóm</a></li>
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
                                                                            <span>Tên đăng nhập</span>
                                                                            <span style="color: red">*</span>
                                                                        </div>
                                                                    </td>
                                                                    <td colspan="2">
                                                                        <div class="workitemcontrol">
                                                                            <div class="combo tree drop">
                                                                                <div class="wrap">
                                                                                    <asp:TextBox ID="txtTenDangNhap" runat="server" TabIndex="1"></asp:TextBox>

                                                                                </div>

                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <asp:RequiredFieldValidator CssClass="error" SetFocusOnError="true" Display="Dynamic" ID="RequiredFieldValidator1" runat="server" ErrorMessage="Tên đăng nhập không được để trống." ControlToValidate="txtTenDangNhap"></asp:RequiredFieldValidator>
                                                                        <asp:Label runat="server" ID="lblNameError" Visible="false" CssClass="error"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <div>
                                                                            <span>Mật khẩu</span>
                                                                            <span style="color: red">*</span>
                                                                        </div>
                                                                    </td>
                                                                    <td colspan="2">
                                                                        <div class="workitemcontrol">
                                                                            <div class="combo tree drop">
                                                                                <div class="wrap">
                                                                                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" TabIndex="1"></asp:TextBox>


                                                                                </div>

                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <asp:RequiredFieldValidator CssClass="error" SetFocusOnError="true" Display="Dynamic" ID="RequiredFieldValidator2" runat="server" ErrorMessage="Mật khẩu không được để trống." ControlToValidate="txtPassword"></asp:RequiredFieldValidator>
                                                                        <asp:Label runat="server" ID="lblPasswordError" Visible="false" CssClass="error"></asp:Label>

                                                                    </td>
                                                                </tr>

                                                                <tr>
                                                                    <td>
                                                                        <div>
                                                                            <span>Nhập lại mật khẩu</span>
                                                                            <span style="color: red">*</span>
                                                                        </div>
                                                                    </td>
                                                                    <td colspan="2">
                                                                        <div class="workitemcontrol">
                                                                            <div class="combo tree drop">
                                                                                <div class="wrap">
                                                                                    <asp:TextBox ID="txtRePassword" runat="server" Visible="true" TextMode="Password" TabIndex="1"></asp:TextBox>
                                                                                </div>

                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <asp:RequiredFieldValidator CssClass="error" SetFocusOnError="true" Display="Dynamic" ID="RequiredFieldValidator3" runat="server" ErrorMessage="Xác nhận lại mật khẩu." ControlToValidate="txtRePassword"></asp:RequiredFieldValidator>

                                                                        <asp:CompareValidator CssClass="error" SetFocusOnError="true" Display="Dynamic" ID="CompareValidator1" Type="String" ControlToCompare="txtPassword" ControlToValidate="txtRePassword" runat="server" ErrorMessage="Mật khẩu không khớp nhau."></asp:CompareValidator>
                                                                    </td>
                                                                </tr>



                                                                <tr>
                                                                    <td>
                                                                        <div>
                                                                            <span>Email</span>

                                                                        </div>
                                                                    </td>
                                                                    <td colspan="2">
                                                                        <div class="workitemcontrol">
                                                                            <div class="combo tree drop">
                                                                                <div class="wrap">
                                                                                    <asp:TextBox ID="txtEmail" runat="server" TabIndex="1"></asp:TextBox>
                                                                                </div>

                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <asp:RegularExpressionValidator CssClass="error" ControlToValidate="txtEmail" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ID="RegularExpressionValidator1" runat="server" ErrorMessage="Email không đúng định dạng." SetFocusOnError="true"></asp:RegularExpressionValidator>
                                                                        <asp:Label runat="server" ID="lblEmailError" Visible="false" CssClass="error"></asp:Label>

                                                                    </td>
                                                                </tr>

                                                                <%-- <tr>
                                                                    <td>Kích hoạt
                                                                    </td>
                                                                    <td>
                                                                        <asp:CheckBox ID="ckKichHoat" runat="server" Checked="true" TabIndex="3"></asp:CheckBox>
                                                                    </td>

                                                                </tr>--%>
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
                                                                                <span style="color: #000;">
                                                                                    <%# Eval("Name") %>
                                                                                </span>
                                                                                <asp:HiddenField runat="server" ID="hdfID" Value='<%# Eval("ID") %>' />
                                                                                <asp:HiddenField runat="server" ID="hdfName" Value='<%# Eval("Name") %>' />

                                                                            </td>
                                                                            <td class="permission-value-column accessible" tabindex="0">
                                                                                <%--<asp:CheckBox runat="server" ID="chkAdd" />--%>
                                                                                <asp:DropDownList runat="server" ID="ddlOperator" Width="120">
                                                                                    <asp:ListItem Text="[Bạn hãy chọn]" Value="0"></asp:ListItem>
                                                                                    <asp:ListItem Text="Cho phép" Value="grant" class="grant-permission"></asp:ListItem>
                                                                                    <asp:ListItem Text="Không cho phép" Value="deny" class="deny-permission"></asp:ListItem>
                                                                                </asp:DropDownList>
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

                                <div class="identity-details-section user_tab" id="user_group" style="display: none; height: auto;">
                                    <div class="manage-info" id="Div4">
                                        <div class=" vertical-fill-layout">
                                            <div class="permission-content fill-content">
                                                <div class="display-permissions-error-pane"></div>
                                                <div class="content">
                                                    <div class="ace-control permissions-effective">
                                                        <table class="witform-layout " style="width: 800px;">

                                                            <asp:Repeater runat="server" ID="rptGroups">
                                                                <ItemTemplate>
                                                                    <tr class="permission-row permission-not-editable data-item">
                                                                        <td class="permission-name-column">
                                                                            <asp:HiddenField runat="server" ID="hdfID" Value='<%# Eval("ID") %>' />
                                                                            <span style="color: #000;"><%# Eval("TenNhom") %>
                                                                            </span></td>
                                                                        <td class="permission-value-column accessible" tabindex="0"><%# Eval("GhiChu") %></td>
                                                                        <td class="trace-permission-column">
                                                                            <asp:CheckBox runat="server" ID="chkAdd" />

                                                                        </td>
                                                                    </tr>
                                                                </ItemTemplate>
                                                            </asp:Repeater>
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
