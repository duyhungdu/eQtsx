<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="List.ascx.cs" Inherits="xRP.Administrator.QuanLyHeThong.PhongBan.List" %>
<script src="/Scripts/utils.js"></script>

<%--<link href="/Scripts/plugins/superfish/dist/css/superfish.css" rel="stylesheet" />--%>
<style>
    .tr-header th { color: #8c8c8c; font-weight: normal; padding: 5px; }
        .tr-header th:hover { background-color: #e6e6e6; }
    .tr-row:hover { background-color: #f2f7fd; border: 1px solid #b8d6fb; }
    /*border: 1px solid #b8d6fb;*/
    .tr-row { border: 0px solid #fff; color: #000000; cursor: default; overflow: hidden; width: 100%; }
    .tr-row-normal { }
    .tr-row td { padding: 4px; }


    .tr-user { border: 0px solid #fff; color: #000000; cursor: default; overflow: hidden; width: 100%; }
        .tr-user:hover { background-color: #f2f7fd; border: 1px solid #b8d6fb; }




    .level0 td.tr-row-title { padding-left: 16px; }
    .level1 td.tr-row-title { padding-left: 48px; }
    .level2 td.tr-row-title { padding-left: 80px; }
    .level3 td.tr-row-title { padding-left: 112px; }
    .level4 td.tr-row-title { padding-left: 144px; }
    .level5 td.tr-row-title { padding-left: 176px; }
    /*.level6 td.tr-row-title { padding-left: 112px; }
        .level8 td.tr-row-title { padding-left: 128px; }
        .level9 td.tr-row-title { padding-left: 144px; }*/

    .grid-cell { border: medium none; cursor: default; display: table-cell; float: left; height: 100%; overflow: hidden; padding: 4px; position: relative; text-align: left; text-overflow: ellipsis; vertical-align: middle; white-space: nowrap; width: 100px; }


    .tr-focus { background-color: #f2f7fd; border: 1px solid #b8d6fb; }

    .collapse .toggle { display: inline-block; height: 16px; overflow: hidden; vertical-align: middle; width: 16px; background: url("/Styles/images/tfs-icons.png") no-repeat scroll -6640px -16px rgba(0, 0, 0, 0) !important; }
    .expand .toggle { display: inline-block; height: 16px; overflow: hidden; vertical-align: middle; width: 16px; background: url("/styles/images/tfs-icons-large.png") no-repeat scroll -6800px -16px rgba(0, 0, 0, 0) !important; }
    .toggle { height: 16px; width: 16px; display: inline-block; }

    .content-header { border-bottom: 4px solid #dfdfdf; }
    .identity-image { border: 0 none; height: 20px; position: absolute; vertical-align: middle; width: 20px; }
    .identity-name { margin-left: 28px; white-space: pre; }
</style>
<script src="/Scripts/plugins/knockout/jquery.knob.js"></script>
<script src="/Scripts/plugins/knockout/knockout-2.3.0.js"></script>
<script>

    function User(item) {
        var self = this;
        self.ID = ko.observable(item.ID);
        self.TenCanBo = ko.observable(item.TenCanBo);
        self.UserName = ko.observable(item.UserName);

        self.EditUserLink = ko.computed(function () {
            return "/default.axpx?page=editstaff&id=" + self.ID();
        }, self);
    }

    function Role(item) {
        var self = this;
        self.Id = ko.observable(item.Id);
        self.Name = ko.observable(item.Name);
    }

    var vm = {
        users: ko.observableArray(),
        roles: ko.observableArray(),
        username: ko.observable(""),
        name: ko.observable(""), //current department name
        id: ko.observable(0), //current department id
        selectStaff: ko.observable(null),

        getUers: function () {
            $.ajax({
                url: "<%#Util.SERVER_NAME %>/Administrator/QuanLyHeThong/Default.aspx/GetUsersByDepartment",
                type: "POST",
                data: "{departmentId: " + vm.id() + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                cache: false,
            }).done(function (data) {
                setTimeout(function () {
                }, 1000);
                vm.users([]);
                result = JSON.parse(data.d);
                if (result.items != null && result.items.length > 0) {
                    $.map(result.items, function (item) {
                        vm.users.push(new User(item));
                    });
                    //vm.count(data.Count);
                } else {
                    // vm.allowLoad(false);
                }
            });
        },

        showStaffDetail: function (staff) {
            vm.selectStaff(staff);
            vm.getRoles();
        },

        getRoles: function () {
            $.ajax({
                url: "<%#Util.SERVER_NAME %>/Administrator/QuanLyHeThong/Default.aspx/GetRoleForStaff",
                type: "POST",
                data: "{username: '" + vm.selectStaff().UserName() + "'}",
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

                } else {
                }
            });
        },
    }

    function deleteItem(id) {
        if (!confirm("Bạn có chắc muốn xóa không?")) return;
        $.ajax({
            type: "POST",
            url: "<%=Util.SERVER_NAME %><%=RootPageUrl%>Default.aspx/DeletePositionItem",
            data: "{\"itemID\":'" + id + "'}",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (result) {
                result = JSON.parse(result.d);
                var isSuccess = result.IsSuccess;
                var message = result.Message;
                if (isSuccess) {
                    window.location.reload(true);
                } else {
                    alert("Lỗi:  " + message);
                }
            }
        });
    }


    function deleteUserItem(id) {
        if (!confirm("Bạn có chắc muốn xóa không?")) return;
        $.ajax({
            type: "POST",
            url: "<%=Util.SERVER_NAME %><%=RootPageUrl%>Default.aspx/DeleteStaffItem",
            data: "{\"itemID\":'" + id + "'}",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (result) {
                result = JSON.parse(result.d);
                var isSuccess = result.IsSuccess;
                var message = result.Message;
                if (isSuccess) {
                    window.location.reload(true);
                } else {
                    alert("Lỗi:  " + message);
                }
            }
        });
    }

    $(function () {
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


        $('.tr-row').click(function () {
            var name = $(this).attr('data-name');
            var id = $(this).attr('data-id')

            $('.tr-row').removeClass('tr-focus');
            $(this).addClass('tr-focus');

            vm.name(name);
            vm.id(id);
            vm.getUers();
        });

        $('.tr-user').click(function () {
            //var name = $(this).attr('data-name');
            //var id = $(this).attr('data-id')

            $('.tr-user').removeClass('tr-focus');
            $(this).addClass('tr-focus');

            //vm.name(name);
            //vm.id(id);
            //vm.getUers();
        });



        ko.applyBindings(vm, $('#vm')[0]);


        $('.tr-row').first().trigger('click', null);

        //jQuery(document).ready(function () {
        //    jQuery('#staffMenu').superfish();
        //});
    });

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
                    <div class="info-text-wrapper"><span class="info-text">Danh sách phòng ban, người dùng</span></div>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block;">
                    <ul class="menu-bar">

                        <li class="menu-item icon-only" id="btn-tinh-chat-xuat-nhap">
                            <a href="Default.aspx?page=adddepartment">
                                <span class="icon icon-add"></span><span class="text">Thêm phòng ban</span>
                            </a>
                        </li>

                        <li class="menu-item icon-only" style="display: none;"><span class="icon icon-undo"></span>
                            <asp:LinkButton ID="LinkButton1" runat="server" Text="Làm mới" />
                        </li>

                        <li class="menu-focus-container">
                            <div class="menu-focus-receiver" tabindex="0" role="menu"></div>
                        </li>
                    </ul>

                </div>
                <div class="work-item-view" style="display: block;">


                    <table width="100%" cellspacing="0" cellpadding="0" border="0" class="post_content" style="min-height: 600px;">
                        <tbody>
                            <tr>
                                <td valign="top" align="left" style="width: 30%; vertical-align: top; border-right: 1px solid #ddd; padding: 0 23px 23px 0; vertical-align: top;">

                                    <table style="width: 100%">
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <div class="content-header skip-header">
                                                        <table cellspacing="0">
                                                            <tbody>
                                                                <tr>
                                                                    <td style="padding: 10px 0;">
                                                                        <b>Phòng ban</b>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <table id="department_table" style="width: 100%;">
                                                        <thead class="tr-header">
                                                            <tr>
                                                                <th style="text-align: left;">Tên nhóm </th>
                                                                <th style="text-align: left;">Thao tác</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <%=DeparmentTree %>
                                                        </tbody>
                                                    </table>


                                                </td>
                                            </tr>

                                        </tbody>
                                    </table>

                                </td>


                                <td style="vertical-align: top; padding: 0 23px 23px 23px; width: 70%;">

                                    <table style="width: 100%">
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <div class="content-header skip-header">
                                                        <table cellspacing="0">
                                                            <tbody>
                                                                <tr>
                                                                    <td style="padding: 10px 0;">
                                                                        <b data-bind="text: name"></b>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <br />

                                    <table width="100%" cellspacing="0" cellpadding="0" border="0" class="post_content">
                                        <tbody>
                                            <tr>
                                                <td style="padding: 0 23px 23px 23px; vertical-align: top; border-right: 1px solid #eee;">
                                                    <div data-bind="visible: vm.users().length == 0">
                                                        <br />
                                                        Hiện tại chưa có cán bộ nào thuộc phòng ban này...
                                                    </div>
                                                    <table style="width: 90%;" cellspacing="2">
                                                        <thead class="tr-header">
                                                            <tr>
                                                                <th style="text-align: left;">Tên cán bộ </th>
                                                                <th style="text-align: left;">Tài khoản</th>
                                                            </tr>
                                                        </thead>

                                                        <tbody data-bind="foreach: vm.users">
                                                            <tr class="tr-user" data-bind="click: $parent.showStaffDetail">
                                                                <td style="vertical-align: middle;">
                                                                    <img
                                                                        src="/Styles/images/user-avatar.png">
                                                                    <span data-bind="text: TenCanBo"></span>
                                                                </td>
                                                                <td>
                                                                    <span style="color: green" data-bind="text: UserName() "></span>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>

                                                <td style="vertical-align: top; width: 35%; padding: 5px 23px 23px 23px;">

                                                    <%--    <div data-bind="if: selectStaff() != null">
                                                        <span data-bind="text: selectStaff().TenCanBo"></span>
                                                        <span data-bind="text: selectStaff().UserName"></span>
                                                    </div>--%>


                                                    <div class="permission-header">
                                                        <div class="header">Quyền</div>
                                                        <div class="secondary-guidance">Danh sách quyền được phân cho người dùng</div>
                                                    </div>

                                                    <div class="permission-content fill-content">
                                                        <div class="display-permissions-error-pane"></div>
                                                        <div class="content">


                                                            <%--  <div class="permission-warning">You do not have the necessary rights to manage these permissions.</div>--%>
                                                            <div class="ace-control permissions-effective">
                                                                <table class="permissions-table">
                                                                    <tbody data-bind="foreach: vm.roles ">
                                                                        <tr class="permission-row permission-not-editable">
                                                                            <td data-bind="text: Name"></td>
                                                                        </tr>

                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>

                                                    </div>

                                                </td>
                                            </tr>
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


<asp:Literal runat="server" ID="lblDeparmentRowFormat" Visible="false" Text="<tr data-name='{0}' data-id='{2}' data-depth='{1}' class='collapse level{1} tr-row'><td class='tr-row-title'><span class='toggle collapse'></span>{0}</td><td><a class='edit-icon' href='default.aspx?page=adddepartment&id={2}'></a><a class='delete-icon' onclick='deleteItem({2})' href='javascript:void(0)'></a></td></tr>">
</asp:Literal>