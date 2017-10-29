﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="List.ascx.cs" Inherits="xRP.Administrator.QuanLyHeThong.NhatKyHeThong.List" %>
<%@ Register Assembly="CollectionPager" Namespace="SiteUtils" TagPrefix="cc1" %>

<script src="/Scripts/utils.js"></script>
<script type="text/javascript">
    function deleteItem(id) {
        if (!confirm("Bạn có chắc muốn xóa không?")) return;
        $.ajax({
            type: "POST",
            url: "<%=Util.SERVER_NAME %><%=RootPageUrl%>Default.aspx/DeleteLogItem",
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


</script>

<script type="text/javascript">



    function OpenModal(id, text) {
        LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Administrator/QuanLyHeThong/NhatKyHeThong/AddOrEdit.ascx", "&id=" + id);
        $("#content_div").dialog({ modal: true, width: 780, height: 420, title: text });
    }
    function CloseModal() {
        $("#content_div").dialog("close");
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
                    <div class="info-text-wrapper"><span class="info-text">Danh sách nhật ký</span></div>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block;">
                    <ul class="menu-bar">
                        <%-- <li class="menu-item icon-only" id="btn-tinh-chat-xuat-nhap" onclick="OpenModal('', 'Thêm nhóm');"><span class="icon icon-add"></span><a href="javascript:void(0);">Thêm nhóm</a></li>--%>
                        <li class="menu-item icon-only" id="btn-reload" style="display: none;"><span class="icon icon-undo"></span>
                            <asp:LinkButton ID="ltrRefresh" runat="server" Text="Làm mới" OnClick="btnRefresh_Click" />
                        </li>
                        <li class="menu-item right-align icon-only">
                            <div class="search-adapter-work-items header-search search-box">
                                <label class="searchbox-label hidden" for="searchbox">Search work items</label>
                                <asp:TextBox ID="txtTimKiem" runat="server" Width="350px" placeholder="Tìm kiếm theo tên" CssClass="box-search-in-form"></asp:TextBox>
                                <asp:LinkButton ID="btTimKiem" runat="server" CssClass="icon icon-search" OnClick="btTimKiem_Click"></asp:LinkButton>
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
                                <td style="width: 120px; text-align: left;">Chức năng</td>
                                <td style="text-align: left;">Tên bảng</td>
                                <td style="width: 120px; text-align: left;">ID bản ghi tác động</td>

                                <td style="text-align: left; width: 160px;">Người thực hiện</td>
                                <%--<td style="text-align:left;">PC</td>--%>
                                <td style="text-align: left; width: 120px;">IP</td>
                                <td style="width: 130px;">Thời gian thực hiện</td>

                                <td style="width: 90px;" class="center-col">Chức năng</td>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptData" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td class="center-col" style="width: 5%"><%# Container.ItemIndex + StartIndex +1 %></td>
                                        <td style="width: 120px;"><%# Eval("DoAct") %></td>
                                        <td><%# Eval("TableName") %></td>
                                        <td><%# Eval("RecID") %></td>
                                        <td><%# Eval("UserName") %></td>
                                        <%--<td><%# Eval("PC") %></td>--%>
                                        <td><%# Eval("IP") %></td>
                                        <td style="width: 130px;"><%# string.Format("{0:dd/MM/yyyy hh:mm:tt}", Eval("Ngay_Act")) %></td>
                                        <td class="center-col" style="width: 90px;">
                                            <a class="delete-icon" href="javascript:deleteItem('<%# Eval("ID")%>');"></a></td>
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