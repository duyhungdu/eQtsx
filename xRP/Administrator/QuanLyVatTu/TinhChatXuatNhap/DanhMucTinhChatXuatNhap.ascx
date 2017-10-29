﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DanhMucTinhChatXuatNhap.ascx.cs" Inherits="xRP.Administrator.QuanLyVatTu.TinhChatXuatNhap.DanhMucTinhChatXuatNhap" %>
<%@ Register Assembly="CollectionPager" Namespace="SiteUtils" TagPrefix="cc1" %>
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
                    <div class="info-text-wrapper"><span class="info-text">Danh mục tính chất nhập xuất</span></div>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block;">
                    <ul class="menu-bar">

                        <li class="menu-item icon-only" id="btn-tinh-chat-xuat-nhap" onclick="OpenModal(-1);"><span class="icon icon-add"></span><span class="text">Thêm loại</span></li>
                        <li class="menu-focus-container">
                            <div class="menu-focus-receiver" tabindex="0" role="menu"></div>
                        </li>
                    </ul>
                </div>
                <div class="work-item-view" style="display: block;">
                    <table class="data-table" id="tabDanhSachPhieuNhapVatTu">
                        <thead>
                            <tr>
                                <td style="width: 5%">STT</td>
                                <td>Mã tính nhập xuất</td>
                                <td>Tên tính nhập xuất</td>
                                <td>Tính chất</td>
                                <td>Người tạo</td>
                                <td>Nội bộ</td>
                                <td>Điều chuyển</td>
                                <td>Kích hoạt</td>
                                <td>Chức năng</td>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptDanhMucTinhChatXuatNhap" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td class="center-col" style="width: 5%">
                                            <%# (CollectionPager1.CurrentPage - 1) * CollectionPager1.PageSize + Container.ItemIndex + 1 %>
                                        </td>
                                        <td><%# Eval("MaTinhChatNhapXuat") %></td>
                                        <td><%# Eval("TenTinhChatNhapXuat") %></td>
                                        <td class="center-col"><%#Util.RerenderInOut(Eval("PhanLoaiNhapXuat"),"Nhập","Xuất") %></td>
                                        <td><%# Eval("UserName") %></td>
                                        <td class="center-col">
                                            <%# Eval("LaNoiBo") %>
                                        </td>
                                         <td class="center-col">
                                            <%# Eval("LaDieuChuyen") %>
                                        </td>
                                        <td class="center-col"><%# Eval("KichHoatText") %></td>
                                        <td class="center-col">
                                            <a class="edit-icon" id="edit-icon" href="javascript:OpenModal('<%# Eval("ID")%>');"></a>
                                            <a class="delete-icon" href="javascript:deleteTinhChatNhapXuat('<%# Eval("ID")%>','<%#Eval("TenTinhChatNhapXuat") %>');"></a>
                                        </td>
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
<div id="content_div" style="z-index: 1002;" title="Cập nhật tính chất nhập xuất">
</div>
<script type="text/javascript">
    function OpenModal(id) {
        var paging = $.QueryString("trang");
        if (paging != null) {
            LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Administrator/QuanLyVatTu/TinhChatXuatNhap/AddOrEditTinhChatXuatNhap.ascx", "&id=" + id + "&trang=" + paging);
        }
        else {
            LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Administrator/QuanLyVatTu/TinhChatXuatNhap/AddOrEditTinhChatXuatNhap.ascx", "&id=" + id);
        }
        $("#content_div").dialog({ modal: true, width: 700, height: 400 });
    }
    function CloseModal() {
        $("#content_div").dialog("close");
    }
</script>