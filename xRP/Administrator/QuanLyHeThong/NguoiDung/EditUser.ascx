<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EditUser.ascx.cs" Inherits="xRP.Administrator.QuanLyHeThong.NguoiDung.EditUser" %>
<link href="/Styles/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
<script src="/Scripts/utils.js"></script>

<script type="text/javascript">
    var tab = function (active) {
        $('.manage-view-tabs li').removeClass('selected');
        $('.user_tab').hide();
        $('#' + active).show();
        $('#<%= txtTabActive.ClientID %>').val(active);
        $("#li" + active).addClass('selected');

    }

    $(document).ready(function () {
        $('.data-item').click(function (event) {
            if (event.target.type !== 'checkbox') {
                $(':checkbox', this).trigger('click');
            }
        });

        var activeTab = $('#<%= txtTabActive.ClientID %>').val();
        if (activeTab != '') {
            tab(activeTab);
        }

        var message = "<%= message %>";
        if (message != '') {
            alert(message);
        }
    });

    var checkValid = function () {
        var pass = $("#<%= txtPassword.ClientID %>").val();
        var repass = $("#<%= txtRePassword.ClientID %>").val();
        var email = $("#<%= txtEmail.ClientID %>").val();

        var hasErrorWhenSubmitForm = false;

        if (pass != repass) {
            hasErrorWhenSubmitForm = true;
        }
        if (email.length > 0 && !Utils.isEmail(email)) {
            hasErrorWhenSubmitForm = true;
        }
        //check active tab is first tab
        var firstTabSelected = $('#liUserInfo').hasClass('selected');
        if (!firstTabSelected && hasErrorWhenSubmitForm) {
            triggerFirstPanel();
        }
    }

    var triggerFirstPanel = function () {
        //$('ul.manage-view-tabs li').removeClass("");
        tab('user_info');
        $('#liuser_group').addClass('selected');
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

<asp:TextBox runat="server" ID="txtTabActive" Value="" Style="display: none;" />
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
                    <div class="info-text-wrapper"><span class="info-text">Sửa người dùng<%--<%= user.UserName %> --%> </span></div>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block;">
                    <ul class="menu-bar">
                        <li id="btn-luu" class="menu-item icon-only">
                            <asp:Button runat="server" ID="btnAdd" class="menu-bar-item-button icon icon-save" OnClientClick="checkValid()" OnClick="btnUpdate_Click" Text="" />

                        </li>

                        <li id="btn-cancel" class="menu-item icon-only">
                            <a class="menu-bar-item-button icon cancel-icon" href="Default.aspx?page=user" title="Hủy"></a>
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
                                <li class="selected liTab" id="liuser_info" title="Tài khoản"><a href="javascript:void(0)" onclick="tab('user_info');">Thông tin tài khoản</a></li>
                                <li title="Quyền" class="liTab" id="liuser_permission"><a href="javascript:void(0)" onclick="tab('user_permission');  ">Quyền</a></li>
                                <li title="Members" class="liTab" id="liuser_group" class=""><a href="javascript:void(0)" onclick="tab('user_group');">Nhóm</a></li>
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

                                                                        </div>
                                                                    </td>
                                                                    <td colspan="2">
                                                                        <div class="workitemcontrol">
                                                                            <div class="combo tree drop">
                                                                                <div class="wrap">
                                                                                    <asp:Label ID="txtTenDangNhap" runat="server" TabIndex="1"></asp:Label>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    <td></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <div>
                                                                            <span>Mật khẩu mới</span>
                                                                        </div>
                                                                    </td>
                                                                    <td colspan="2">
                                                                        <div class="workitemcontrol">
                                                                            <div class="combo1 tree drop">
                                                                                <div class="wrap1">
                                                                                    <asp:TextBox ID="txtPassword" autocomplete="off" AutoCompleteType="Disabled" Text="" runat="server" TextMode="Password" TabIndex="1" Style="width: 100%;"></asp:TextBox>
                                                                                    <br />
                                                                                    <span style="color: #333;">Nhập vào mật khẩu mới nếu muốn thay đổi mật khẩu.</span>

                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    <td style="vertical-align: top;">
                                                                        <asp:CompareValidator CssClass="error" SetFocusOnError="true" Display="Dynamic" ID="CompareValidator2" Type="String" ControlToCompare="txtRePassword" ControlToValidate="txtPassword" runat="server" ErrorMessage="Mật khẩu và xác nhận mật khẩu không khớp nhau."></asp:CompareValidator>
                                                                        <asp:Label runat="server" ID="lblPasswordError" Visible="false" CssClass="error"></asp:Label>
                                                                        <asp:Label runat="server" ID="lblPasswordSucess" Visible="false" CssClass="success"></asp:Label>

                                                                    </td>
                                                                </tr>

                                                                <tr>
                                                                    <td>
                                                                        <div>
                                                                            <span>Nhập lại mật khẩu</span>
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
                                                                        <asp:CompareValidator CssClass="error" SetFocusOnError="true" Display="Dynamic" ID="CompareValidator1" Type="String" ControlToCompare="txtPassword" ControlToValidate="txtRePassword" runat="server" ErrorMessage="Xác nhận mật khẩu không đúng."></asp:CompareValidator>
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
                                                                        <asp:Label runat="server" ID="lblEmailSuccess" Visible="false" CssClass="success"></asp:Label>


                                                                    </td>
                                                                </tr>

                                                                <tr>
                                                                    <td>Kích hoạt
                                                                    </td>
                                                                    <td>
                                                                        <asp:CheckBox ID="chkIsLocked" runat="server" Checked="true" TabIndex="3"></asp:CheckBox>
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
                                                                <asp:Repeater runat="server" ID="rptPermissions" OnItemDataBound="rptPermissions_ItemDataBound">
                                                                    <ItemTemplate>
                                                                        <tr class="permission-row permission-not-editable data-item">
                                                                            <td class="permission-name-column">
                                                                                <span style="color: #000;">
                                                                                    <%# Eval("Role.Name") %>
                                                                                </span>
                                                                                <asp:HiddenField runat="server" ID="hdfID" Value='<%# Eval("Role.ID") %>' />
                                                                                <asp:HiddenField runat="server" ID="hdfName" Value='<%# Eval("Role.Name") %>' />

                                                                                <asp:HiddenField runat="server" ID="hdfIsGrant" Value='<%# Eval("IsGrant") %>' />
                                                                                <asp:HiddenField runat="server" ID="hdfIsDeny" Value='<%# Eval("IsDeny") %>' />
                                                                                <asp:HiddenField runat="server" ID="hdfIsOrphan" Value='<%# Eval("IsOrphan") %>' />
                                                                                <asp:HiddenField runat="server" ID="hdfIsAssigned" Value='<%# Eval("IsAssigned") %>' />
                                                                                <asp:HiddenField runat="server" ID="hdfIsOverride" Value='<%# Eval("IsOverride") %>' />
                                                                                <asp:HiddenField runat="server" ID="hdfIsInherit" Value='<%# Eval("IsInherit") %>' />


                                                                            </td>
                                                                            <td class="permission-value-column accessible" tabindex="0">
                                                                                <asp:DropDownList runat="server" ID="ddlUnAssignedOperator" Width="120" Visible="false">
                                                                                    <asp:ListItem Text="[Bạn hãy chọn]" Value="0"></asp:ListItem>
                                                                                    <asp:ListItem Text="Cho phép" Value="grant" class="grant-permission"></asp:ListItem>
                                                                                    <asp:ListItem Text="Từ chối" Value="deny" class="deny-permission"></asp:ListItem>
                                                                                </asp:DropDownList>

                                                                                <asp:DropDownList runat="server" ID="ddlAssignedOperator" Width="120" Visible="false">
                                                                                    <asp:ListItem Text="Cho phép" Value="grant" class="grant-permission"></asp:ListItem>
                                                                                    <asp:ListItem Text="Từ chối" Value="deny" class="deny-permission"></asp:ListItem>
                                                                                    <asp:ListItem Text="Xóa" Value="delete" class="deny-permission"></asp:ListItem>

                                                                                </asp:DropDownList>

                                                                                <asp:DropDownList runat="server" ID="ddlGroupOperator" Width="120" Visible="false">
                                                                                    <asp:ListItem Text="Cho phép" Value="grant" class="grant-permission"></asp:ListItem>
                                                                                    <asp:ListItem Text="Từ chối" Value="deny" class="deny-permission"></asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td class="permission-name-column">
                                                                                <asp:Label runat="server" ID="lblTip"></asp:Label>

                                                                            </td>
                                                                        </tr>
                                                                    </ItemTemplate>
                                                                </asp:Repeater>
                                                                <%--<h2>Quyền của người dùng:</h2>
                                                                <asp:Repeater runat="server" ID="rptUserPermission">
                                                                    <ItemTemplate>
                                                                        <%# Eval("Name") %>
                                                                    </ItemTemplate>
                                                                </asp:Repeater>--%>
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
                                                                            <asp:HiddenField runat="server" ID="hdfID" Value='<%# Eval("Group.ID") %>' />
                                                                            <span style="color: #000;"><%# Eval("Group.TenNhom") %>
                                                                            </span></td>
                                                                        <td class="permission-value-column accessible" tabindex="0"><%# Eval("Group.GhiChu") %></td>
                                                                        <td class="trace-permission-column">
                                                                            <asp:CheckBox runat="server" ID="chkAdd" AutoPostBack="true" OnCheckedChanged="chkAdd_CheckedChanged" Checked='<%# Eval("IsChecked") %>' />

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
<asp:Label runat="server" ID="lblGrant" Visible="false" Text="<i class='fa fa-check-circle'></i>">
</asp:Label>
<asp:Label runat="server" ID="lblDeny" Visible="false" Text="<i class='fa fa-exclamation'></i>"></asp:Label>
<asp:Label runat="server" ID="lblNote" Visible="false" Text="<span style='color:gray'>Bị từ chối do quyền trực tiếp của người dùng.</span>">
</asp:Label>
<asp:Label runat="server" ID="lblOverride" Visible="false" Text="<span style='color:gray'>Ghi đè quyền của nhóm.</span>">
</asp:Label>
<asp:Label runat="server" ID="lblInheritFromGroup" Visible="false" Text="<i class='fa fa-chain'></i>&nbsp;<span style='color:gray'>Kế thừa từ nhóm.</span>">
</asp:Label>
<asp:Label runat="server" ID="lblOrphan" Visible="false" Text="<i class='fa fa-ellipsis-h '></i>&nbsp;<span style='color:gray'>Chưa được gán.</span>">
</asp:Label>

<%--<i class='fa fa-ellipsis-h '></i>&nbsp;<span style='color:gray'>Chưa được gán quyền.</span>--%>