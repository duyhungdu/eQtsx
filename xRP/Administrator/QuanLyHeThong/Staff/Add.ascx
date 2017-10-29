<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Add.ascx.cs" Inherits="xRP.Administrator.QuanLyHeThong.Staff.Add" %>


<style>
    .tr-header th { color: #8c8c8c; font-weight: normal; padding: 5px; }
        .tr-header th:hover { background-color: #e6e6e6; }
    .tr-row:hover { background-color: #f2f7fd; border: 1px solid #b8d6fb; }
    .tr-row { border: 0px solid #fff; color: #000000; cursor: default; overflow: hidden; width: 100%; }
    .tr-row-normal { }
    .tr-row td { padding: 4px; }
    .level0 td.tr-row-title { padding-left: 16px; }
    .level1 td.tr-row-title { padding-left: 48px; }
    .level2 td.tr-row-title { padding-left: 80px; }
    .level3 td.tr-row-title { padding-left: 112px; }
    .level4 td.tr-row-title { padding-left: 144px; }
    .level5 td.tr-row-title { padding-left: 176px; }
    .grid-cell { border: medium none; cursor: default; display: table-cell; float: left; height: 100%; overflow: hidden; padding: 4px; position: relative; text-align: left; text-overflow: ellipsis; vertical-align: middle; white-space: nowrap; width: 100px; }
    .collapse .toggle { display: inline-block; height: 16px; overflow: hidden; vertical-align: middle; width: 16px; background: url("/Styles/images/tfs-icons.png") no-repeat scroll -6640px -16px rgba(0, 0, 0, 0) !important; }
    .expand .toggle { display: inline-block; height: 16px; overflow: hidden; vertical-align: middle; width: 16px; background: url("/styles/images/tfs-icons-large.png") no-repeat scroll -6800px -16px rgba(0, 0, 0, 0) !important; }
    .toggle { height: 16px; width: 16px; display: inline-block; }
    .content-header { border-bottom: 4px solid #dfdfdf; }
    .identity-image { border: 0 none; height: 20px; position: absolute; vertical-align: middle; width: 20px; }
    .identity-name { margin-left: 28px; white-space: pre; }
    .data-item { cursor: pointer; }
    .error { color: red; font-size: 11px; }
    .success { color: green; font-size: 11px; }
    .permission-name-column { color: #000; }
    .content-header { border-bottom: 4px solid #dfdfdf; }
    .grant-permission { color: green; }
    .deny-permission { color: #ff6a00; }
    .delete-permission { color: red; }
</style>


<script src="/Scripts/plugins/knockout/jquery.knob.js"></script>
<script src="/Scripts/plugins/knockout/knockout-2.3.0.js"></script>
<script type="text/javascript">
    var tab = function (active) {
        $('.manage-view-tabs li').removeClass();
        $('.user_tab').hide();
        $('#' + active).show();
    }

    function Role(item) {
        var self = this;
        self.ID = ko.observable(item.ID);
        self.Name = ko.observable(item.Name);
        self.Description = ko.observable(item.Description);
    }

    var vm = {
        users: ko.observableArray(),
        roles: ko.observableArray(),
        //name: ko.observable(""), //current department name
        username: ko.observable(0), //current department id
        getRoles: function () {
            $.ajax({
                url: "<%#Util.SERVER_NAME %>/Administrator/QuanLyHeThong/Default.aspx/GetPermisionForAccount",
                type: "POST",
                data: "{username: '" + vm.username() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                cache: false,
            }).done(function (data) {
                setTimeout(function () {
                }, 1000);
                vm.roles([]);
                result = JSON.parse(data.d);
                if (result.items != null && result.items.length > 0) {
                    $.map(result.items, function (item) {
                        vm.roles.push(new Role(item));
                    });
                    //console.log(vm.roles());
                    //vm.count(data.Count);
                } else {
                    // vm.allowLoad(false);
                }
            });
        }
    }

    $(document).ready(function () {

        $('#department_table').on('click', '.toggle', function () {
            //Gets all <tr>'s  of greater depth
            //below element in the table
            var findChildren = function (tr) {
                var depth = tr.data('depth');
                return tr.nextUntil($('tr').filter(function () {
                    return $(this).data('depth') <= depth;
                }));
            };

            var el = $(this);
            var tr = el.closest('tr'); //Get <tr> parent of toggle button
            var children = findChildren(tr);

            //Remove already collapsed nodes from children so that we don't
            //make them visible. 
            //(Confused? Remove this code and close Item 2, close Item 1 
            //then open Item 1 again, then you will understand)
            var subnodes = children.filter('.expand');
            subnodes.each(function () {
                var subnode = $(this);
                var subnodeChildren = findChildren(subnode);
                children = children.not(subnodeChildren);
            });

            //Change icon and hide/show children
            if (tr.hasClass('collapse')) {
                tr.removeClass('collapse').addClass('expand');
                children.hide();
            } else {
                tr.removeClass('expand').addClass('collapse');
                children.show();
            }
            return children;
        });
        $('.tr-row').click(function (e) {
            e.stopPropagation();
            var chkCheck = $(this).find("input[type='checkbox']");
            var checked = chkCheck.prop("checked");
            chkCheck.prop("checked", !checked);
            $(this).find("select").prop("disabled", checked);
        });
        $('.tr-row select').click(function (e) {
            e.stopPropagation();
        });

        $('.tr-row input[type="checkbox"]').click(function (e) {
            e.stopPropagation();
            var checked = $(this).prop("checked");
            $(this).parent().parent().parent().find("select").prop("disabled", !checked);
        });



        $('.data-item').click(function (event) {
            if (event.target.type !== 'checkbox') {
                $(':checkbox', this).trigger('click');
            }
        });

        ko.applyBindings(vm, $('#vm')[0]);

        $('#<%= ddlAccount.ClientID %>').change(function () {
            vm.username($(this).val());
            vm.getRoles();
        });

        vm.username($('#<%= ddlAccount.ClientID %>').val());
        vm.getRoles();
    });


    var triggerFirstPanel = function () {
        //$('ul.manage-view-tabs li').removeClass("");
        tab('user_info');
        $('#liUserInfo').addClass('selected');
    }

</script>


<div class="splitter horizontal hub-splitter stateful toggle-button-enabled toggle-button-hotkey-enabled" id="vm">

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
                    <div class="info-text-wrapper">
                        <% if (!string.IsNullOrEmpty(StaffName))
                           { %>
                        <span class="info-text"><%= StaffName %></span>
                        <% }
                           else
                           { %>
                        <span class="info-text">Thêm cán bộ</span>
                        <% } %>
                    </div>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block;">
                    <ul class="menu-bar">
                        <li id="btn-luu" class="menu-item icon-only">
                            <asp:Button runat="server" ID="btnAdd" class="menu-bar-item-button icon icon-save" OnClientClick="triggerFirstPanel()" OnClick="btnAdd_Click" Text="" />
                        </li>
                        <li id="btn-cancel" class="menu-item icon-only">
                            <a class="menu-bar-item-button icon cancel-icon" href="Default.aspx?page=staff" title="Hủy"></a>
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
                                <li class="selected" id="liUserInfo" title="Tài khoản"><a href="javascript:void(0)" onclick="tab('user_info');$(this).parent().addClass('selected');">Thông tin tài khoản</a></li>
                                <li title="Chức vụ"><a href="javascript:void(0)" onclick="tab('user_department'); $(this).parent().addClass('selected'); ">Phòng ban</a></li>
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
                                                                    <td style="vertical-align: top;">
                                                                        <div>
                                                                            <span>Tên cán bộ</span>
                                                                            <span style="color: red">*</span>
                                                                        </div>
                                                                    </td>
                                                                    <td colspan="3">
                                                                        <div class="workitemcontrol">
                                                                            <asp:TextBox ID="txtName" runat="server" TabIndex="1" Width="260px"></asp:TextBox>
                                                                            <br />
                                                                            <asp:Label runat="server" ID="lblNameError" CssClass="error"></asp:Label>
                                                                            <asp:RequiredFieldValidator runat="server" ID="requireFieldValidator" ControlToValidate="txtName" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                                                        </div>

                                                                    </td>
                                                                </tr>


                                                                <tr>
                                                                    <td style="vertical-align: top;">
                                                                        <div>
                                                                            <span>Tài khoản</span>
                                                                        </div>
                                                                    </td>
                                                                    <td colspan="3">
                                                                        <div class="workitemcontrol">
                                                                            <asp:DropDownList runat="server" Width="260px" ID="ddlAccount" CssClass="ddl"></asp:DropDownList>
                                                                        </div>

                                                                    </td>
                                                                </tr>


                                                                <tr>
                                                                    <td style="vertical-align: top;">
                                                                        <div>
                                                                            <span>Số điện thoại</span>

                                                                        </div>
                                                                    </td>
                                                                    <td colspan="3">
                                                                        <div class="workitemcontrol">
                                                                            <asp:TextBox ID="txtSoDienThoai" runat="server" TabIndex="1" Width="260px"></asp:TextBox>

                                                                        </div>

                                                                    </td>
                                                                </tr>


                                                                <tr>
                                                                    <td style="vertical-align: top;">
                                                                        <div>
                                                                            <span>Email</span>

                                                                        </div>
                                                                    </td>
                                                                    <td colspan="3">
                                                                        <div class="workitemcontrol">
                                                                            <asp:TextBox ID="txtEmail" runat="server" TabIndex="1" Width="260px"></asp:TextBox>
                                                                            <br />
                                                                            <asp:Label runat="server" ID="lblEmailError" Visible="false" CssClass="error"></asp:Label>
                                                                            <asp:RegularExpressionValidator ControlToValidate="txtEmail" ID="RegularExpressionValidator1" runat="server" ErrorMessage="Email không đúng định dạng" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
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
                                                                <tr>
                                                                    <td style="vertical-align: top;">Quyền
                                                                    </td>
                                                                    <td>
                                                                        <ul style="list-style: none;" data-bind="foreach: vm.roles">
                                                                            <li data-bind="text: Name"></li>

                                                                        </ul>
                                                                        <div data-bind="visible: vm.roles().length == 0 && vm.username() != ''">
                                                                            Tài khoản <b data-bind="text: vm.username"></b>chưa được phân quyền...
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

                                <div class="identity-details-section user_tab" id="user_department" style="display: none; height: auto;">

                                    <div class="manage-info">
                                        <div class=" vertical-fill-layout">
                                            <div class="permission-content fill-content">
                                                <div class="display-permissions-error-pane"></div>
                                                <div class="content">
                                                    <div class="ace-control permissions-effective">

                                                        <table class="witform-layout " style="width: 600px;">
                                                            <tbody>

                                                                <tr>
                                                                    <td>
                                                                        <table id="department_table" style="width: 100%;">
                                                                            <thead class="tr-header">
                                                                                <tr>
                                                                                    <th style="text-align: left;">Phòng ban</th>
                                                                                    <th style="text-align: left;">Chọn</th>
                                                                                    <th style="text-align: left;">Chức vụ</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <asp:Repeater runat="server" ID="rptDepartment" OnItemDataBound="rptDepartment_ItemDataBound">
                                                                                    <ItemTemplate>
                                                                                        <tr class="collapse level<%# Eval("Level") %> tr-row" data-depth="<%# Eval("Level") %>" data-id="<%# Eval("ID") %>" data-name="<%# Eval("Name") %>">
                                                                                            <td class="tr-row-title"><span class="toggle collapse"></span><%# Eval("Name") %></td>
                                                                                            <td>
                                                                                                <asp:CheckBox runat="server" ID="chkCheck" CssClass="chkCheck" />
                                                                                                <asp:HiddenField runat="server" ID="hdfID" Value='<%# Eval("ID") %>' />
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList runat="server" ID="ddlPosition" Enabled="false" DataTextField="TenChucVu" DataValueField="ID">
                                                                                                </asp:DropDownList>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </ItemTemplate>
                                                                                </asp:Repeater>
                                                                                <%=DeparmentTree %>
                                                                            </tbody>
                                                                        </table>
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



                            </td>
                        </tr>
                    </table>

                </div>
            </div>
        </div>
    </div>
</div>

<asp:Literal runat="server" ID="lblDeparmentRowFormat" Visible="false" Text="<tr data-name='{0}' data-id='{2}' data-depth='{1}' class='collapse level{1} tr-row'><td class='tr-row-title'><span class='toggle collapse'></span>{0}</td><td><a class='edit-icon' href='default.aspx?page=adddepartment&id={2}'></a><a class='delete-icon' onclick='deleteItem({2})' href='javascript:void(0)'></a></td></tr>">
</asp:Literal>