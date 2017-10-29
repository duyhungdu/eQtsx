<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="List.ascx.cs" Inherits="xRP.Administrator.QuanLyHeThong.Quyen.List" %>
<%@ Register Assembly="CollectionPager" Namespace="SiteUtils" TagPrefix="cc1" %>
<script src="/Scripts/utils.js"></script>
<script type="text/javascript">
    function deleteItem(id) {
        if (!confirm("Bạn có chắc muốn xóa không?")) return;
        $.ajax({
            type: "POST",
            url: "<%=Util.SERVER_NAME %><%=RootPageUrl%>Default.aspx/DeletePermissionItem",
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

    $(document).ready(function () {
        handlerEnterKey('<%= txtTimKiem.ClientID %>');
    });


    function doSearch() {
        var key = $('#<%= txtTimKiem.ClientID %>').val();
        var url = "";
        if (key.length == 0) {
            url = "Default.aspx?page=permission";
        } else {
            url = "Default.aspx?page=permission" + "&s=" + key;
        }
        window.location.href = url;
    }

</script>
<script type="text/javascript">


    function LoadError() {
        alert("Loi");
    }

    function OpenModal(id, text) {
        LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Administrator/QuanLyHeThong/Quyen/AddOrEdit.ascx", "&id=" + id);
        $("#content_div").dialog({ modal: true, width: 480, height: 260, title: text });
    }
    function CloseModal() {
        $("#content_div").dialog("close");
    }
    function ConfigPer(id) {
        var page;
        if ($.QueryString("trang") != null) {
            page = $.QueryString("trang")
        }
        else
            page = 1;

        window.location.href = "/Administrator/QuanLyHeThong/Default.aspx?page=perfun&perid=" + id + "&trang=" + page;
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
                    <div class="info-text-wrapper"><span class="info-text">Danh sách quyền</span></div>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block;">
                    <ul class="menu-bar">
                        <li class="menu-item icon-only" id="btn-tinh-chat-xuat-nhap">
                            <a onclick="OpenModal('', 'Thêm quyền');" href="javascript:void(0);">
                                <span class="icon icon-add"></span><span class="text">Thêm quyền</span>
                            </a>
                        </li>
                        <li class="menu-item icon-only" id="btn-reload" style="display: none;"><span class="icon icon-undo"></span>
                            <asp:LinkButton ID="ltrRefresh" runat="server" Text="Làm mới" OnClick="btnRefresh_Click" />
                        </li>
                        <li class="menu-item right-align icon-only">
                            <div class="search-adapter-work-items header-search search-box">
                                <label class="searchbox-label hidden" for="searchbox">Search work items</label>
                                <asp:TextBox ID="txtTimKiem" runat="server" Width="350px" placeholder="Tìm kiếm theo tên" CssClass="box-search-in-form"></asp:TextBox>
                                <a href="javascript:void(0);" onclick="doSearch()" class="icon icon-search"></a>

                            </div>
                        </li>

                        <li class="menu-focus-container">
                            <div class="menu-focus-receiver" tabindex="0" role="menu"></div>
                        </li>
                    </ul>
                </div>
                <div class="work-item-view" style="display: block;">
                    <table class="data-table" id="tabDanhSachPhieuNhapVatTu">
                        <thead>
                            <tr>
                                <td style="width: 50px">STT</td>
                                <td style="text-align: left; width: 180px;">Tên quyền</td>
                                <td style="text-align: left; width: 180px;">Mã</td>
                                <td style="text-align: left;">Ghi chú</td>
                                <td style="width: 90px;" class="center-col">Chức năng</td>


                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptData" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td class="center-col" style="width: 50px"><%# Container.ItemIndex + StartIndex +1 %></td>
                                        <td style="text-align: left; width: 180px;"><%# Eval("Name") %></td>
                                        <td style="text-align: left; width: 180px;"><%# Eval("Code") %></td>
                                        <td><%# Eval("Description") %></td>
                                        <td style="width: 90px;" class="center-col">
                                            <a class="icon-kcs" title="Cấu hình quyền và chức năng" href="javascript:ConfigPer('<%#Eval("ID") %>');"></a>
                                            <a class="edit-icon" id="edit-icon" href="javascript:OpenModal('<%# Eval("Name")%>','Sửa: <%# Eval("Name") %>');"></a>
                                            <a class="delete-icon" href="javascript:deleteItem('<%# Eval("Name")%>');"></a></td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
                <div class="work-item-view-pager">
                    <cc1:CollectionPager ID="CollectionPager1" runat="server" PageSize="10" PagingMode="QueryString"
                        QueryStringKey="trang" BackText="Trước"
                        FirstText="Đầu" LastText="Cuối" NextText="Sau"
                        LabelText="" PageNumbersSeparator="&amp;nbsp;&amp;nbsp;" PageNumbersStyle="color:#007acc;font-size:12px;padding:5px;"
                        PageNumberStyle="color: #555;padding: 3px 8px;text-decoration: underline;" ResultsLocation="Bottom"
                        ResultsStyle="font-family:Arial;font-size:12px;text-align:right;margin-top:5px;"
                        ShowLabel="True" BackNextButtonStyle="border:none;background:red;" BackNextDisplay="HyperLinks"
                        BackNextLinkSeparator="&nbsp;&nbsp;-&nbsp;&nbsp;" ControlStyle="text-align:right;margin:5px;float:right;" BackNextLocation="Split" ResultsFormat="Hiển thị {0}-{1} (trong tổng số {2} bản ghi)" ShowFirstLast="True" ControlCssClass="paging_tool_bar" EnableViewState="False" MaxPages="10" SectionPadding="5" SliderSize="10">
                    </cc1:CollectionPager>
                </div>
            </div>

        </div>

    </div>
</div>
<div id="content_div" style="z-index: 1002;" title="Cập nhật người dùng">
</div>
<%--END Modal --%>