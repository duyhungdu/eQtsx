<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DanhSachPhieuYeuCauVatTu.ascx.cs" Inherits="xRP.Business.QuanLySanXuat.YeuCauVatTu.DanhSachPhieuYeuCauVatTu" %>
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
                    <div class="info-text-wrapper"><span class="info-text">Danh sách phiếu yêu cầu vật tư</span></div>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block;">
                    <ul class="menu-bar">
                        <li class="menu-item icon-only" id="btn-tinh-chat-xuat-nhap"><a href="/Business/QuanLySanXuat/Default.aspx?page=cnpycvt"><span class="icon icon-add"></span><span class="text">Tạo phiếu yêu cầu vật tư</span></a></li>
                        <li class="menu-item right-align icon-only">
                            <div class="search-adapter-work-items header-search search-box">
                                <span></span>&nbsp;&nbsp;
                                <span style="text-align: center">Từ ngày
                                <span>
                                    <input type="text" id="txtStartDate" style="width: 100px" placeholder="__/__/____" name="field-name" class="combo tree drop" runat="server" />
                                </span>&nbsp &nbsp
                                Đến ngày
                                <span>
                                    <input type="text" id="txtEndDate" style="width: 100px" placeholder="__/__/____" name="field-name" class="combo tree drop" runat="server" /></span>
                                    <input type="text" class="box-search-in-form" id="searchbox" runat="server" placeholder="Tìm kiếm">
                                    <asp:Button ID="btnSeach" runat="server" Text="" CssClass="icon icon-search" />
                                </span>
                            </div>
                        </li>

                        <li class="menu-focus-container">
                            <div class="menu-focus-receiver" tabindex="0" role="menu"></div>
                        </li>
                    </ul>
                </div>
                <div class="work-item-view" style="display: block;">
                    <table class="data-table" id="tabDanhSachPhieuYeuCauVatTu">
                        <thead>
                            <tr>
                                <td class="center-col" style="width: 5%;">STT</td>
                                <td>Tên vật tư</td>
                                <td>Tên đơn vị</td>
                                <td>Mã hiệu tham chiếu</td>
                                <td>Số lượng yêu cầu</td>
                                <td>Ngày sử dụng</td>
                                <td>Người yêu cầu</td>
                                <td>Tình trạng</td>
                                <td>Chức năng
                                </td>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptPhieuYeuCauVatTu" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td class="center-col" style="width: 15px">
                                            <span class="sothutu"><%# (colPage.CurrentPage - 1) * colPage.PageSize + Container.ItemIndex + 1 %></span>
                                        </td>
                                        <td style="width: 120px"><%# Eval("TenVatTu") %></td>
                                        <td style="width: 120px"><%# Eval("TenDonVi") %></td>
                                        <td style="width: 120px"><%# Eval("MaHieuThamChieu") %></td>
                                        <td style="width: 120px"><%# Eval("SoLuongYeuCau") %></td>
                                        <td class="center-col" style="width: 100px"><%# string.Format("{0:dd/MM/yyyy}", Eval("NgaySuDung")) %> </td>
                                        <td style="width: 120px"><%# Eval("NguoiYeuCau") %></td>
                                        <td class="center-col" style="width: 120px"><%# Eval("Tinhtrang") %></td>
                                        <td class="center-col" style="width: 110px">
                                            <p>
                                                <a aria-expanded="false" aria-controls="tinyDrop" data-dropdown="tinyDrop<%# Eval("ID")%>" class="button">Chức năng</a>
                                            </p>
                                            <ul aria-hidden="true" tabindex="-1" data-dropdown-content="" class="f-dropdown" id='tinyDrop<%# Eval("ID")%>'>
                                                <li class="menu-item" style="text-align: left">
                                                    <a id="edit-icon" title="Sửa lệnh sản xuất" href="javascript:onEditPhieuYeuCauVatTu('<%# Eval("ID")%>');">
                                                        <span class="icon edit-icon"></span><span class="text">Sửa</span></a>
                                                </li>
                                                <%--  <li class="menu-item" style="text-align: left">
                                                    <a id="printer-icon" title="In phiếu yêu cầu vật tư" href="javascript:onPrintPhieuYeuCauVatTu('<%# Eval("ID")%>');">
                                                        <span class="icon icon-printer"></span><span class="text">In phiếu</span></a>

                                                </li>--%>
                                                <li class="menu-item" style="display: none; text-align: left"><a class="delete-icon" id="delete-icon" href="javascript:xoa('<%# Eval("ID")%>');" title="Xóa phiếu yêu cầu vật tư">Xóa</a></li>
                                            </ul>
                                        </td>


                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
                <div class="work-item-view-pager">
                    <cc1:CollectionPager ID="colPage" runat="server" PageSize="10" PagingMode="QueryString"
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

<script type="text/javascript">
    function onEditPhieuYeuCauVatTu(id) {
        window.location = '/Business/QuanLySanXuat/Default.aspx?page=cnpycvt&PhieuYeuCauVatTuId=' + id;
    }
    function onPrintPhieuYeuCauVatTu(id) {
        window.location = '/Business/QuanLySanXuat/Default.aspx?page=inpycvt&PhieuYeuCauVatTuId=' + id;
    }
</script>
