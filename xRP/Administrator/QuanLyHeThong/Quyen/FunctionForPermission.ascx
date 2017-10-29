<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FunctionForPermission.ascx.cs" Inherits="xRP.Administrator.QuanLyHeThong.Quyen.FunctionForPermission" %>
<%@ Register Assembly="CollectionPager" Namespace="SiteUtils" TagPrefix="cc1" %>

<style type="text/css">
    .cls-root {
        background-color: #ebebeb;
        font-weight: bold;
    }

    .child-cls {
        padding-left: 20px !important;
    }
</style>
<script type="text/javascript">
    function OpenModal(id, text) {
        LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Administrator/QuanLyHeThong/Quyen/AddOrEditFunction.ascx", "&id=" + id);
        $("#content_div").dialog({ modal: true, width: 650, height: 360, title: text });
    }
    function CloseModal() {
        $("#content_div").dialog("close");
    }
    $(function () {
        $("#checkall").change(function () {
            var allCheckboxes = $('[type=checkbox]');
            if (this.checked) {
                allCheckboxes.prop('checked', true);
            }
            else {
                allCheckboxes.prop('checked', false);
            }
        });
    });
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
                    <div class="info-text-wrapper">
                        <span class="info-text">
                            <asp:Literal ID="ltChucNang" runat="server"></asp:Literal></span>

                    </div>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block;">
                    <ul class="menu-bar">
                        <li id="btn-luu" class="menu-item icon-only">
                            <input type="button" class="xrp-button   menu-bar-item-button icon icon-save" title="Lưu" id="btnSave" onclick="onSaveRoleFunction()" />
                        </li>
                        <li id="btn-cancel" class="menu-item icon-only">
                            <asp:Button ToolTip="Hủy" CssClass="menu-bar-item-button icon cancel-icon" runat="server" ID="btnCancel" OnClick="btnCancel_Click" />
                        </li>
                        <li class="menu-item"></li>
                    </ul>
                </div>
                <div class="work-item-view" style="display: block;">
                    <table class="witform-layout">
                        <tbody>
                            <asp:Panel ID="pnlThongTinQuyen" runat="server">
                                <tr>
                                    <td style="width: 10%;"></td>
                                    <td style="width: 40%;"></td>
                                    <td style="width: 10%;"></td>
                                    <td style="width: 40%;"></td>
                                </tr>
                                <tr>
                                    <td>Mã quyền
                                    </td>
                                    <td>
                                        <div class="workitemcontrol">
                                            <div class="combo tree drop short-control-30">
                                                <div class="wrap">
                                                    <input id="txtCode" value="<%=role.Code %>" readonly="readonly" />
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>Tên quyền
                                    </td>
                                    <td>
                                        <div class="workitemcontrol">
                                            <div class="combo tree drop short-control-50">
                                                <div class="wrap">
                                                    <input id="txtName" value="<%=role.Name %>" readonly="readonly" />
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Mô tả</td>
                                    <td colspan="3">
                                        <textarea id="txtDescription" readonly="readonly"><%=role.Description %> </textarea>
                                    </td>
                                </tr>
                            </asp:Panel>
                            <tr>

                                <td colspan="4">

                                    <div class="work-item-view" style="display: block;">
                                        <table class="data-table" id="tabDanhSachChucNang">
                                            <thead>
                                                <tr>
                                                    <td style="width: 35px" class="center-col">STT</td>
                                                    <td>TÊN CHỨC NĂNG</td>
                                                    <td style="width: 100px;">STT MENU</td>
                                                    <td style="width: 100px;">ÁP DỤNG</td>
                                                    <td style="width: 100px;">CHƯC NĂNG</td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 35px" class="center-col"></td>
                                                    <td></td>
                                                    <td style="width: 100px;"></td>
                                                    <td style="width: 100px;">
                                                        <input name="checkall" id="checkall" type="checkbox" /></td>
                                                    <td style="width: 100px;"></td>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:Repeater runat="server" ID="rptFunctions">
                                                    <ItemTemplate>
                                                        <tr class="permission-row permission-not-editable data-item  <%# Eval("ParentID").ToString()!="0" ? "group-"+Eval("ParentID").ToString():"cls-root group-root-"+Eval("ID").ToString()   %>">
                                                            <td>
                                                                <span class="sothutu"><%#  Container.ItemIndex + 1 %></span></td>
                                                            <td class="permission-name-column <%# Eval("ParentID").ToString()!="0" ? "child-cls":""   %>">
                                                                <asp:HiddenField runat="server" ID="hdfRole" Value='<%# Eval("ID") %>' />
                                                                <span style="color: #000;">
                                                                    <%# Eval("TenChucNang") %>
                                                                </span>

                                                            </td>
                                                            <td style="text-align: center;">
                                                                <%#Eval("ThuTu") %>
                                                            </td>
                                                            <td class="center-col" tabindex="0">
                                                                <%--<asp:CheckBox runat="server" ID="chkAdd" funcid='<%# Eval("ID") %>' />--%>
                                                                <input type="checkbox" id='chkAdd-<%# Eval("ID") %>' <%# Eval("Selected").ToString()=="True" ? "checked='checked'":""   %> funcid='<%# Eval("ID") %>' rolefuncid='<%# Eval("RoleFunctionId") %>' class="cls-allow" />
                                                            </td>
                                                            <td style="text-align: center;">
                                                                <a class="edit-icon" id="edit-icon" href="javascript:OpenModal('<%# Eval("ID")%>','Cập nhật chức năng')"></a>
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="work-item-view-pager">
                                        <cc1:CollectionPager ID="colPager" runat="server" PageSize="100" PagingMode="QueryString"
                                            QueryStringKey="trang" BackText="Trước"
                                            FirstText="Đầu" LastText="Cuối" NextText="Sau"
                                            LabelText="" PageNumbersSeparator="&amp;nbsp;&amp;nbsp;" PageNumbersStyle="color:#007acc;font-size:12px;padding:5px;"
                                            PageNumberStyle="color: #555;padding: 3px 8px;text-decoration: underline;" ResultsLocation="Bottom"
                                            ResultsStyle="font-family:Arial;font-size:12px;text-align:right;margin-top:5px;"
                                            ShowLabel="True" BackNextButtonStyle="border:none;background:red;" BackNextDisplay="HyperLinks"
                                            BackNextLinkSeparator="&nbsp;&nbsp;-&nbsp;&nbsp;" ControlStyle="text-align:right;margin:5px;float:right;" BackNextLocation="Split" ResultsFormat="Hiển thị {0}-{1} (trong tổng số {2} bản ghi)" ShowFirstLast="True" ControlCssClass="paging_tool_bar" EnableViewState="False" MaxPages="10" SectionPadding="5" SliderSize="10">
                                        </cc1:CollectionPager>
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
<script type="text/javascript">

    function onSaveRoleFunction() {

        var array = new Array();
        $('#tabDanhSachChucNang .cls-allow:checkbox:checked').each(function () {
            //console.log($(this).attr('funcid'));
            var obj = new Object();
            obj.ID = $(this).attr('rolefuncid');
            obj.RoleID = '<%=role.ID %>';
            obj.FunctionID = $(this).attr('funcid');
            array.push(obj);
        });
        // console.log(JSON.stringify(array));
        // return;

        $.ajax({
            type: "POST",
            url: "<%#Util.SERVER_NAME %>/Administrator/QuanLyHeThong/Default.aspx/AddOrUpdateFunctionRole",
            //data: "{id:'" + id + "',name:'" + name + "',note: '" + note + "',code:'" + code + "'}",
            data: "{roleId:'" + '<%=role.ID %>' + "',lsFunction:'" + JSON.stringify(array) + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            cache: false,
            success: function (result) {
                result = JSON.parse(result.d);
                var isSuccess = result.IsSuccess;
                var message = result.Message;
                if (isSuccess) {
                    var page;
                    if ($.QueryString("trang") != null) {
                        page = $.QueryString("trang")
                    }
                    else
                        page = 1;
                    window.location.href = "<%#Util.SERVER_NAME %>/Administrator/QuanLyHeThong/Default.aspx?page=permission&trang=" + page + "";
                } else {
                    alert("Lỗi:  " + message);
                }
            }
        });
    }

</script>
<div id="content_div" style="z-index: 1002;" title="Cập nhật người dùng">
</div>
