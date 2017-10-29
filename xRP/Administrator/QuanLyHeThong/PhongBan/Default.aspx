<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="xRP.Administrator.QuanLyHeThong.PhongBan.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <%--<link href="/Scripts/plugins/superfish/dist/css/superfish.css" rel="stylesheet" />--%>
    <style>
        .tr-header th { color: #8c8c8c; font-weight: normal; padding: 5px; }
            .tr-header th:hover { background-color: #e6e6e6; }
        .tr-row:hover { background-color: #f2f7fd; border: 1px solid #b8d6fb; }
        /*border: 1px solid #b8d6fb;*/
        .tr-row { border: 1px solid #fff; color: #000000; cursor: default; overflow: hidden; width: 100%; }
        .tr-row-normal { }
        .tr-row td { padding: 4px; }


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


        .collapse .toggle { display: inline-block; height: 16px; overflow: hidden; vertical-align: middle; width: 16px; background: url("/Styles/images/tfs-icons.png") no-repeat scroll -6640px -16px rgba(0, 0, 0, 0) !important; }
        .expand .toggle { display: inline-block; height: 16px; overflow: hidden; vertical-align: middle; width: 16px; background: url("/styles/images/tfs-icons-large.png") no-repeat scroll -6800px -16px rgba(0, 0, 0, 0) !important; }
        .toggle { height: 16px; width: 16px; display: inline-block; }

        .content-header { border-bottom: 4px solid #dfdfdf; }
        .identity-image { border: 0 none; height: 20px; position: absolute; vertical-align: middle; width: 20px; }
        .identity-name { margin-left: 28px; white-space: pre; }
    </style>
    <%--  <script src="/Scripts/plugins/superfish/dist/js/hoverIntent.js"></script>
    <script src="/Scripts/plugins/superfish/dist/js/superfish.js"></script>--%>
    <script>
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


            //jQuery(document).ready(function () {
            //    jQuery('#staffMenu').superfish();
            //});
        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

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
                        <div class="info-text-wrapper"><span class="info-text">Danh sách phòng ban, người dùng</span></div>
                    </div>
                    <div class="toolbar workitem-tool-bar" style="display: block;">
                        <ul class="menu-bar">
                            <li class="menu-item icon-only" id="Li1">
                                <span class="text">Thêm</span>
                            </li>

                            <li class="menu-item icon-only" id="Li3">
                                <span class="text">Thêm phòng ban con</span>
                            </li>

                            <li class="menu-item icon-only" id="Li2" style="display: none;"><span class="icon icon-undo"></span>
                                <asp:LinkButton ID="LinkButton1" runat="server" Text="Làm mới" />
                            </li>
                            <%--  <li class="menu-item right-align icon-only">
                                <div class="search-adapter-work-items header-search search-box">
                                    <label class="searchbox-label hidden" for="searchbox">Search work items</label>
                                    <asp:TextBox ID="TextBox1" runat="server" Width="350px" placeholder="Tìm kiếm theo tên  " CssClass="box-search-in-form"></asp:TextBox>
                                    <asp:LinkButton ID="LinkButton2" runat="server" CssClass="icon icon-search"></asp:LinkButton>
                                </div>
                            </li>--%>

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
                                                                <tr data-depth="0" class="collapse level0 tr-row">
                                                                    <td class="tr-row-title"><span class="toggle collapse"></span>Công ty Cổ phần tin học NOAH</td>
                                                                    <td>
                                                                        <a class="edit-icon" href="#"></a>
                                                                        <a class="delete-icon" href="#"></a>
                                                                    </td>
                                                                </tr>
                                                                <tr data-depth="1" class="collapse level1 tr-row">

                                                                    <td class="tr-row-title"><span class="toggle"></span>Ban giám đốc</td>
                                                                    <td>
                                                                        <a class="edit-icon" href="#"></a>
                                                                        <a class="delete-icon" href="#"></a>
                                                                    </td>
                                                                </tr>
                                                                <tr data-depth="2" class="collapse level2 tr-row">
                                                                    <td class="tr-row-title">Phòng kế toán</td>
                                                                    <td>
                                                                        <a class="edit-icon" href="#"></a>
                                                                        <a class="delete-icon" href="#"></a>
                                                                    </td>
                                                                </tr>
                                                                <tr data-depth="1" class="collapse level1 tr-row">

                                                                    <td class="tr-row-title">Phòng hành chính tổng hợp</td>
                                                                    <td>
                                                                        <a class="edit-icon" href="#"></a>
                                                                        <a class="delete-icon" href="#"></a>
                                                                    </td>
                                                                </tr>
                                                                <tr data-depth="0" class="collapse collapsable level0 tr-row">

                                                                    <td class="tr-row-title"><span class="toggle collapse"></span>Khối sản xuất</td>
                                                                    <td>
                                                                        <a class="edit-icon" href="#"></a>
                                                                        <a class="delete-icon" href="#"></a>
                                                                    </td>
                                                                </tr>
                                                                <tr data-depth="1" class="collapse collapsable level1 tr-row">

                                                                    <td class="tr-row-title">Khối dịch vụ, support khách hàng</td>
                                                                    <td>
                                                                        <a class="edit-icon" href="#"></a>
                                                                        <a class="delete-icon" href="#"></a>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>


                                                    </td>
                                                </tr>

                                            </tbody>
                                        </table>

                                    </td>


                                    <td style="vertical-align: top; padding: 0 23px 23px 23px; width: 70%;">

                                        <%--  <ul id="staffMenu" class="sf-menu sf-arrows">
                                            <li class="current">
                                                <a class="sf-with-ul" href="#a">menu item</a>
                                                <ul style="display: none;">
                                                    <li>
                                                        <a href="#aa">menu item</a>
                                                    </li>
                                                    <li class="current">
                                                        <a class="sf-with-ul" href="#ab">menu item</a>
                                                        <ul style="display: none;">
                                                            <li class="current"><a href="#">menu item</a></li>
                                                            <li><a href="#aba">menu item</a></li>
                                                            <li><a href="#abb">menu item</a></li>
                                                            <li><a href="#abc">menu item</a></li>
                                                            <li><a href="#abd">menu item</a></li>
                                                        </ul>
                                                    </li>
                                                    <li>
                                                        <a class="sf-with-ul" href="#">menu item</a>
                                                        <ul style="display: none;">
                                                            <li><a href="#">menu item</a></li>
                                                            <li><a href="#">menu item</a></li>
                                                            <li><a href="#">menu item</a></li>
                                                            <li><a href="#">menu item</a></li>
                                                            <li><a href="#">menu item</a></li>
                                                        </ul>
                                                    </li>
                                                    <li>
                                                        <a class="sf-with-ul" href="#">menu item</a>
                                                        <ul style="display: none;">
                                                            <li><a href="#">menu item</a></li>
                                                            <li><a href="#">menu item</a></li>
                                                            <li><a href="#">menu item</a></li>
                                                            <li><a href="#">menu item</a></li>
                                                            <li><a href="#">menu item</a></li>
                                                        </ul>
                                                    </li>
                                                </ul>
                                            </li>
                                            <li>
                                                <a href="#">menu item</a>
                                            </li>
                                            <li>
                                                <a class="sf-with-ul" href="#">menu item</a>
                                                <ul style="display: none;">
                                                    <li>
                                                        <a class="sf-with-ul" href="#">menu item</a>
                                                        <ul style="display: none;">
                                                            <li><a href="#">menu item</a></li>
                                                            <li><a href="#">menu item</a></li>
                                                            <li><a href="#">menu item</a></li>
                                                            <li><a href="#">menu item</a></li>
                                                            <li><a href="#">menu item</a></li>
                                                        </ul>
                                                    </li>
                                                    <li>
                                                        <a class="sf-with-ul" href="#">menu item</a>
                                                        <ul style="display: none;">
                                                            <li><a href="#">menu item</a></li>
                                                            <li><a href="#">menu item</a></li>
                                                            <li><a href="#">menu item</a></li>
                                                            <li><a href="#">menu item</a></li>
                                                            <li><a href="#">menu item</a></li>
                                                        </ul>
                                                    </li>
                                                    <li>
                                                        <a class="sf-with-ul" href="#">menu item</a>
                                                        <ul style="display: none;">
                                                            <li><a href="#">menu item</a></li>
                                                            <li><a href="#">menu item</a></li>
                                                            <li><a href="#">menu item</a></li>
                                                            <li><a href="#">menu item</a></li>
                                                            <li><a href="#">menu item</a></li>
                                                        </ul>
                                                    </li>
                                                    <li>
                                                        <a class="sf-with-ul" href="#">menu item</a>
                                                        <ul style="display: none;">
                                                            <li><a href="#">menu item</a></li>
                                                            <li><a href="#">menu item</a></li>
                                                            <li><a href="#">menu item</a></li>
                                                            <li><a href="#">menu item</a></li>
                                                            <li><a href="#">menu item</a></li>
                                                        </ul>
                                                    </li>
                                                    <li>
                                                        <a class="sf-with-ul" href="#">menu item</a>
                                                        <ul style="display: none;">
                                                            <li><a href="#">menu item</a></li>
                                                            <li><a href="#">menu item</a></li>
                                                            <li><a href="#">menu item</a></li>
                                                            <li><a href="#">menu item</a></li>
                                                            <li><a href="#">menu item</a></li>
                                                        </ul>
                                                    </li>
                                                </ul>
                                            </li>
                                            <li>
                                                <a href="#">menu item</a>
                                            </li>
                                        </ul>--%>

                                        <table style="width: 100%">
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <div class="content-header skip-header">
                                                            <table cellspacing="0">
                                                                <tbody>
                                                                    <tr>
                                                                        <td style="padding: 10px 0;">
                                                                            <b>Công ty Cổ phần tin học NOAH</b>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>

                                        <table width="100%" cellspacing="0" cellpadding="0" border="0" class="post_content">
                                            <tbody>
                                                <tr>
                                                    <td>
                                                    <tr>
                                                        <td style="padding: 0 23px 23px 23px; vertical-align: top; border-right: 1px solid #eee;">
                                                            <style type="text/css">
                                                                .menu-bar > .menu-item > .drop { background: url("../../../Images/tfs-icons.png") no-repeat scroll -1329px 50% rgba(0, 0, 0, 0) !important; display: inline-block; height: 16px; overflow: hidden; position: relative; vertical-align: middle; width: 16px; }
                                                            </style>
                                                            <div class="identity-list-section vertical-fill-layout" id="74" style="position: absolute;">

                                                                <div class="identity-search-box fixed-header">
                                                                    <div class="toolbar">
                                                                        <ul class="menu-bar">
                                                                            <li class="menu-item icon-only" id="Li4">
                                                                                <span class="text">Thêm người dùng</span>
                                                                            </li>
                                                                            <li class="menu-item icon-only" id="Li5">
                                                                                <span class="text">Chọn từ danh sách</span>
                                                                            </li>
                                                                        </ul>
                                                                        <ul id="75" class="menu-bar">
                                                                            <li id="mi_77" class="menu-item drop-visible" title="Add...">
                                                                                <span class="text">Add...</span><span class="drop"></span>
                                                                                <ul id="170" class="menu sub-menu" style="z-index: 20000; top: 154px; left: 435px; display: none;">
                                                                                    <li id="mi_176" class="menu-item disabled" title="Add user" command="admin-explicit-member-permissions" disabled="disabled" style="-moz-user-focus: ignore;"><span class="text">Add user</span></li>
                                                                                    <li id="mi_178" class="menu-item disabled" title="Add VSO Group" command="admin-explicit-tfsgroup-permissions" disabled="disabled" style="-moz-user-focus: ignore;"><span class="text">Add VSO Group</span></li>
                                                                                </ul>
                                                                            </li>
                                                                            <li id="mi_79" class="menu-item drop-visible" title="Inheritance enabled" command="inheritance-settings" style="-moz-user-focus: ignore;">
                                                                                <span class="text">Inheritance</span><span class="drop"></span>
                                                                                <ul id="169" class="menu sub-menu" style="z-index: 20000; top: 154px; left: 507px; display: none;">
                                                                                    <li id="mi_172" class="menu-item disabled" title="On" command="inheritance-on" disabled="disabled" style="-moz-user-focus: ignore;"><span class="icon icon-tick"></span><span class="text">On</span></li>
                                                                                    <li id="mi_174" class="menu-item disabled" title="Off" command="inheritance-off" disabled="disabled" style="-moz-user-focus: ignore;"><span class="icon"></span><span class="text">Off</span></li>
                                                                                </ul>
                                                                            </li>
                                                                            <li class="menu-focus-container">
                                                                                <div class="menu-focus-receiver" tabindex="0" role="menu"></div>
                                                                            </li>
                                                                        </ul>
                                                                    </div>
                                                                    <div class="identity-search-control">
                                                                        <div class="search-input-wrapper">
                                                                            <label class="hidden" for="identitySearchBox">Search identities...</label><input type="text" class="search-input watermark" name="identitySearchBox">
                                                                        </div>
                                                                        <span class="cancel-button" tabindex="0" style="display: none;"></span><span class="search-button" tabindex="0"></span><span class="go-button" style="display: none;"></span>
                                                                    </div>
                                                                </div>
                                                                <div class="main-identity-grid fill-content grid identity-grid" style="top: 77px; right: 0px; bottom: 0px; left: 0px; position: absolute; overflow: auto;" id="80">
                                                                    <div class="grid-focus" tabindex="0" role="grid"></div>

                                                                    <table style="width: 90%;" cellspacing="1">
                                                                        <tr class="tr-row">
                                                                            <td>
                                                                                <img class="identity-picture identity-336aaa2d-a873-4c12-849a-76a368fec1ad identity-image"
                                                                                    src="/Styles/images/IdentityImage.svg" alt="Image of [DefaultCollection]\Project Collection Administrators"><span class="identity-name">Project Collection Administrators</span>

                                                                            </td>
                                                                            <td style="width: 60px;">
                                                                                <a class="edit-icon" href="#"></a>
                                                                                <a class="delete-icon" href="#"></a>
                                                                            </td>
                                                                        </tr>
                                                                        <tr class="tr-row">
                                                                            <td>
                                                                                <img class="identity-picture identity-336aaa2d-a873-4c12-849a-76a368fec1ad identity-image"
                                                                                    src="/Styles/images/IdentityImage.svg" alt="Image of [DefaultCollection]\Project Collection Administrators"><span class="identity-name">Project Collection Administrators</span>

                                                                            </td>
                                                                            <td style="width: 60px;">
                                                                                <a class="edit-icon" href="#"></a>
                                                                                <a class="delete-icon" href="#"></a>
                                                                            </td>
                                                                        </tr>
                                                                        <tr class="tr-row">
                                                                            <td>
                                                                                <img class="identity-picture identity-336aaa2d-a873-4c12-849a-76a368fec1ad identity-image"
                                                                                    src="/Styles/images/IdentityImage.svg" alt="Image of [DefaultCollection]\Project Collection Administrators"><span class="identity-name">Project Collection Administrators</span>

                                                                            </td>
                                                                            <td style="width: 60px;">
                                                                                <a class="edit-icon" href="#"></a>
                                                                                <a class="delete-icon" href="#"></a>
                                                                            </td>
                                                                        </tr>
                                                                        <tr class="tr-row">
                                                                            <td>
                                                                                <img class="identity-picture identity-336aaa2d-a873-4c12-849a-76a368fec1ad identity-image"
                                                                                    src="/Styles/images/IdentityImage.svg" alt="Image of [DefaultCollection]\Project Collection Administrators"><span class="identity-name">Project Collection Administrators</span>

                                                                            </td>
                                                                            <td style="width: 60px;">
                                                                                <a class="edit-icon" href="#"></a>
                                                                                <a class="delete-icon" href="#"></a>
                                                                            </td>
                                                                        </tr>
                                                                        <tr class="tr-row">
                                                                            <td>
                                                                                <img class="identity-picture identity-336aaa2d-a873-4c12-849a-76a368fec1ad identity-image"
                                                                                    src="/Styles/images/IdentityImage.svg" alt="Image of [DefaultCollection]\Project Collection Administrators"><span class="identity-name">Project Collection Administrators</span>

                                                                            </td>
                                                                            <td style="width: 60px;">
                                                                                <a class="edit-icon" href="#"></a>
                                                                                <a class="delete-icon" href="#"></a>
                                                                            </td>
                                                                        </tr>
                                                                        <tr class="tr-row">
                                                                            <td>
                                                                                <img class="identity-picture identity-336aaa2d-a873-4c12-849a-76a368fec1ad identity-image"
                                                                                    src="/Styles/images/IdentityImage.svg" alt="Image of [DefaultCollection]\Project Collection Administrators"><span class="identity-name">Project Collection Administrators</span>

                                                                            </td>
                                                                            <td style="width: 60px;">
                                                                                <a class="edit-icon" href="#"></a>
                                                                                <a class="delete-icon" href="#"></a>
                                                                            </td>
                                                                        </tr>
                                                                        <tr class="tr-row">
                                                                            <td>
                                                                                <img class="identity-picture identity-336aaa2d-a873-4c12-849a-76a368fec1ad identity-image"
                                                                                    src="/Styles/images/IdentityImage.svg" alt="Image of [DefaultCollection]\Project Collection Administrators"><span class="identity-name">Project Collection Administrators</span>

                                                                            </td>
                                                                            <td style="width: 60px;">
                                                                                <a class="edit-icon" href="#"></a>
                                                                                <a class="delete-icon" href="#"></a>
                                                                            </td>
                                                                        </tr>
                                                                        <tr class="tr-row">
                                                                            <td>
                                                                                <img class="identity-picture identity-336aaa2d-a873-4c12-849a-76a368fec1ad identity-image"
                                                                                    src="/Styles/images/IdentityImage.svg" alt="Image of [DefaultCollection]\Project Collection Administrators"><span class="identity-name">Project Collection Administrators</span>

                                                                            </td>
                                                                            <td style="width: 60px;">
                                                                                <a class="edit-icon" href="#"></a>
                                                                                <a class="delete-icon" href="#"></a>
                                                                            </td>
                                                                        </tr>
                                                                    </table>

                                                                    <%--                                                                    <div class="grid-canvas" style="display: block;">
                                                                        <div class="grid-content-spacer" style="height: 210px;"></div>
                                                                        <div class="identity-info-message" style="display: none;"></div>
                                                                        <div class="grid-row grid-row-normal grid-row-selected-blur grid-row-current" id="row_80_0" style="top: 0px; left: 0px; height: 30px; -moz-user-focus: ignore;">
                                                                            <div class="grid-cell identity-cell" style="width: 100%;" title="">
                                                                                <img class="identity-picture identity-336aaa2d-a873-4c12-849a-76a368fec1ad identity-image"
                                                                                    src="../../../Styles/images/IdentityImage.svg" alt="Image of [DefaultCollection]\Project Collection Administrators"><span class="identity-name">Project Collection Administrators</span>

                                                                            </div>

                                                                        </div>
                                                                        <div class="grid-row grid-row-normal grid-row-current" id="row_80_1" style="top: 30px; left: 0px; height: 30px; -moz-user-focus: ignore;">
                                                                            <div class="grid-cell identity-cell" style="width: 100%;" title="">
                                                                                <img class="identity-picture identity-896ccfcb-6715-42ee-8a84-215167cc8014 identity-image"
                                                                                    src="../../../Styles/images/IdentityImage.svg" alt="Image of [DefaultCollection]\Project Collection Build Service Accounts"><span class="identity-name">Project Collection Build Service Accounts</span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="grid-row grid-row-normal grid-row-current" id="row_80_2" style="top: 60px; left: 0px; height: 30px; -moz-user-focus: ignore;">
                                                                            <div class="grid-cell identity-cell" style="width: 100%;" title="">
                                                                                <img class="identity-picture identity-330e1511-afba-432d-95ca-bb98ca024454 identity-image"
                                                                                    src="../../../Styles/images/IdentityImage.svg" alt="Image of [DefaultCollection]\Project Collection Service Accounts"><span class="identity-name">Project Collection Service Accounts</span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="grid-row grid-row-normal grid-row-current" id="row_80_3" style="top: 90px; left: 0px; height: 30px; -moz-user-focus: ignore;">
                                                                            <div class="grid-cell identity-cell" style="width: 100%;" title="">
                                                                                <img class="identity-picture identity-f7b5af7d-6fb4-43b3-91d4-f08fadc54bc5 identity-image"
                                                                                    src="../../../Styles/images/IdentityImage.svg" alt="Image of [xRP]\Build Administrators"><span class="identity-name">Build Administrators</span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="grid-row grid-row-normal grid-row-current" id="row_80_4" style="top: 120px; left: 0px; height: 30px; -moz-user-focus: ignore;">
                                                                            <div class="grid-cell identity-cell" style="width: 100%;" title="">
                                                                                <img class="identity-picture identity-477584e2-9139-4bf5-a63f-3b8e7c557f5a identity-image"
                                                                                    src="../../../Styles/images/IdentityImage.svg" alt="Image of [xRP]\Contributors"><span class="identity-name">Contributors</span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="grid-row grid-row-normal grid-row-current" id="row_80_5" style="top: 150px; left: 0px; height: 30px; -moz-user-focus: ignore;">
                                                                            <div class="grid-cell identity-cell" style="width: 100%;" title="">
                                                                                <img class="identity-picture identity-7745c393-744b-45f3-b790-a24f18426784 identity-image"
                                                                                    src="../../../Styles/images/IdentityImage.svg" alt="Image of [xRP]\Project Administrators"><span class="identity-name">Project Administrators</span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="grid-row grid-row-normal grid-row-current" id="row_80_6" style="top: 180px; left: 0px; height: 30px; -moz-user-focus: ignore;">
                                                                            <div class="grid-cell identity-cell" style="width: 100%;" title="">
                                                                                <img class="identity-picture identity-0351a20e-d1fe-434c-a71a-becf9b7dbe30 identity-image"
                                                                                    src="../../../Styles/images/IdentityImage.svg" alt="Image of [xRP]\Readers"><span class="identity-name">Readers</span>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    --%>

                                                                    <div class="grid-canvas grid-canvas-droppable">
                                                                        <div class="identity-info-message" style="display: none;"></div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                        </td>

                                                        <td style="vertical-align: top; width: 35%; padding: 5px 23px 23px 23px;">
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
                                                                            <tbody>
                                                                                <tr class="permission-row permission-not-editable">
                                                                                    <td class="permission-name-column">Administer labels</td>
                                                                                    <td class="permission-value-column accessible" tabindex="0">Inherited allow</td>
                                                                                    <td class="trace-permission-column"><a class="trace-permission-action" style="visibility: hidden;">| <span tabindex="0">Why?</span></a></td>
                                                                                </tr>
                                                                                <tr class="permission-row permission-not-editable">
                                                                                    <td class="permission-name-column">Check in</td>
                                                                                    <td class="permission-value-column accessible" tabindex="0">Inherited allow</td>
                                                                                    <td class="trace-permission-column"><a class="trace-permission-action" style="visibility: hidden;">| <span tabindex="0">Why?</span></a></td>
                                                                                </tr>
                                                                                <tr class="permission-row permission-not-editable">
                                                                                    <td class="permission-name-column">Check in other users' changes</td>
                                                                                    <td class="permission-value-column accessible" tabindex="0">Inherited allow</td>
                                                                                    <td class="trace-permission-column"><a class="trace-permission-action" style="visibility: hidden;">| <span tabindex="0">Why?</span></a></td>
                                                                                </tr>
                                                                                <tr class="permission-row permission-not-editable">
                                                                                    <td class="permission-name-column">Check out</td>
                                                                                    <td class="permission-value-column accessible" tabindex="0">Inherited allow</td>
                                                                                    <td class="trace-permission-column"><a class="trace-permission-action" style="visibility: hidden;">| <span tabindex="0">Why?</span></a></td>
                                                                                </tr>
                                                                                <tr class="permission-row permission-not-editable">
                                                                                    <td class="permission-name-column">Label</td>
                                                                                    <td class="permission-value-column accessible" tabindex="0">Inherited allow</td>
                                                                                    <td class="trace-permission-column"><a class="trace-permission-action" style="visibility: hidden;">| <span tabindex="0">Why?</span></a></td>
                                                                                </tr>
                                                                                <tr class="permission-row permission-not-editable">
                                                                                    <td class="permission-name-column">Lock</td>
                                                                                    <td class="permission-value-column accessible" tabindex="0">Inherited allow</td>
                                                                                    <td class="trace-permission-column"><a class="trace-permission-action" style="visibility: hidden;">| <span tabindex="0">Why?</span></a></td>
                                                                                </tr>
                                                                                <tr class="permission-row permission-not-editable">
                                                                                    <td class="permission-name-column">Manage branch</td>
                                                                                    <td class="permission-value-column accessible" tabindex="0">Inherited allow</td>
                                                                                    <td class="trace-permission-column"><a class="trace-permission-action" style="visibility: hidden;">| <span tabindex="0">Why?</span></a></td>
                                                                                </tr>
                                                                                <tr class="permission-row permission-not-editable">
                                                                                    <td class="permission-name-column">Manage permissions</td>
                                                                                    <td class="permission-value-column accessible" tabindex="0">Inherited allow</td>
                                                                                    <td class="trace-permission-column"><a class="trace-permission-action" style="visibility: hidden;">| <span tabindex="0">Why?</span></a></td>
                                                                                </tr>
                                                                                <tr class="permission-row permission-not-editable">
                                                                                    <td class="permission-name-column">Merge</td>
                                                                                    <td class="permission-value-column accessible" tabindex="0">Inherited allow</td>
                                                                                    <td class="trace-permission-column"><a class="trace-permission-action" style="visibility: hidden;">| <span tabindex="0">Why?</span></a></td>
                                                                                </tr>
                                                                                <tr class="permission-row permission-not-editable">
                                                                                    <td class="permission-name-column">Read</td>
                                                                                    <td class="permission-value-column accessible" tabindex="0">Inherited allow</td>
                                                                                    <td class="trace-permission-column"><a class="trace-permission-action" style="visibility: hidden;">| <span tabindex="0">Why?</span></a></td>
                                                                                </tr>
                                                                                <tr class="permission-row permission-not-editable">
                                                                                    <td class="permission-name-column">Revise other users' changes</td>
                                                                                    <td class="permission-value-column accessible" tabindex="0">Inherited allow</td>
                                                                                    <td class="trace-permission-column"><a class="trace-permission-action" style="visibility: hidden;">| <span tabindex="0">Why?</span></a></td>
                                                                                </tr>
                                                                                <tr class="permission-row permission-not-editable">
                                                                                    <td class="permission-name-column">Undo other users' changes</td>
                                                                                    <td class="permission-value-column accessible" tabindex="0">Inherited allow</td>
                                                                                    <td class="trace-permission-column"><a class="trace-permission-action" style="visibility: hidden;">| <span tabindex="0">Why?</span></a></td>
                                                                                </tr>
                                                                                <tr class="permission-row permission-not-editable">
                                                                                    <td class="permission-name-column">Unlock other users' changes</td>
                                                                                    <td class="permission-value-column accessible" tabindex="0">Inherited allow</td>
                                                                                    <td class="trace-permission-column"><a class="trace-permission-action" style="visibility: hidden;">| <span tabindex="0">Why?</span></a></td>
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

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
