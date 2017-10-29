<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DanhMucVatTu.ascx.cs" Inherits="xRP.Administrator.QuanLyVatTu.VatTu.DanhMucVatTu" %>
<%@ Register Assembly="CollectionPager" Namespace="SiteUtils" TagPrefix="cc1" %>

<script type="text/javascript">
    function OpenModal(id, text) {
        LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Administrator/QuanLyVatTu/VatTu/AddOrEditVatTu.ascx", "&id=" + id);
        $("#content_div").dialog({ modal: true, width: 780, height: 420, title: text });
    }
    function CloseModal() {
        $("#content_div").dialog("close");
    }
</script>
<style type="text/css">
    .canh_bao_ton {
        color: red;
        font-weight: bold;
    }
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
                    <div class="info-text-wrapper"><span class="info-text">Danh mục vật tư</span></div>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block;">
                    <ul class="menu-bar">

                        <li class="menu-item icon-only" id="btn-tao-nha-cung-cap" onclick="OpenModal(-1,'Thêm mới vật tư');"><span class="icon icon-add"></span><span class="text">Tạo mới vật tư</span></li>
                        <li class="menu-item icon-only" id="btn-reload" style="display: none;"><span class="icon icon-undo"></span>
                            <asp:LinkButton ID="ltrRefresh" runat="server" Text="Làm mới" />
                        </li>
                        <li class="menu-item right-align icon-only">

                            <div class="search-adapter-work-items header-search search-box">
                                <label class="searchbox-label hidden" for="searchbox">Search work items</label>
                                <span>Vật tư cảnh báo tồn kho </span>
                                <span>
                                    <asp:CheckBox ID="chkCanhBaoTonKho" runat="server" />&nbsp;&nbsp;&nbsp;</span>
                                <asp:TextBox ID="searchbox" runat="server"></asp:TextBox>
                                <asp:Button ID="btnSeach" runat="server" Text="" CssClass="icon icon-search" OnClick="btnSeach_Click" />
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
                                <td style="width: 5%">STT</td>
                                <td>Mã vật tư</td>
                                <td>Tên vật tư</td>
                                <td>Đơn vị tính</td>
                                <td>Kích thước</td>
                                <td>Định lượng</td>
                                <td>Số lượng tồn tối thiểu</td>
                                <td>Số lượng tồn</td>
                                <td>Số lượng tồn kế hoạch</td>
                                <td>Kích hoạt</td>

                                <td>Chức năng</td>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptDanhMucVatTu" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td class="center-col <%#Eval("GhiChu") %>"><%# (CollectionPager1.CurrentPage - 1) * CollectionPager1.PageSize + Container.ItemIndex + 1 %></td>
                                        <td class="center-col <%#Eval("GhiChu") %>"><%# Eval("MaHieuVatTu") %></td>
                                        <td class="<%#Eval("GhiChu") %>"><%#Eval("TenVatTu") %></td>
                                        <td class="<%#Eval("GhiChu") %>"><%#Eval("DonViTinh")%></td>
                                        <td class="right-col <%#Eval("GhiChu") %>"><%# Eval("KichThuocVatTu") %></td>
                                        <td class="right-col <%#Eval("GhiChu") %>"><%# Eval("DinhLuong") %></td>
                                        <td class="right-col <%#Eval("GhiChu") %>"><%# Eval("SoLuongTonToiThieu") %></td>
                                        <td class="right-col <%#Eval("GhiChu") %>"><%# Eval("SoLuongTon") %></td>
                                        <td class="right-col <%#Eval("GhiChu") %>"><%# Eval("SoLuongTonKeHoach") %></td>
                                        <td class="center-col <%#Eval("GhiChu") %>"><%#Util.RerenderStatus(Eval("KichHoat"),"Đã kích hoạt","Chưa kích hoạt") %></td>
                                        <td class="center-col <%#Eval("GhiChu") %>"><a class="edit-icon" id="edit-icon" href="javascript:OpenModal('<%# Eval("ID")%>','Chỉnh sửa vật tư');"></a>
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
<div id="content_div" title="Thêm mới vật tư">
</div>
