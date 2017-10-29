<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DanhMucKho.ascx.cs" Inherits="xRP.Administrator.QuanLyVatTu.Kho.DanhMucKho" %>
<%@ Register Assembly="CollectionPager" Namespace="SiteUtils" TagPrefix="cc1" %>

<script type="text/javascript">
    function OpenModal(id) {
        var paging = $.QueryString("trang");
        if (paging != null) {
            LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Administrator/QuanLyVatTu/Kho/AddOrEditKho.ascx", "&id=" + id + "&trang=" + paging);
        }
        else {
            LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Administrator/QuanLyVatTu/Kho/AddOrEditKho.ascx", "&id=" + id);
        }
        $("#content_div").dialog({ modal: true, width: 700, height: 400 });
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
                    <div class="info-text-wrapper"><span class="info-text">Danh sách kho</span></div>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block;">
                    <ul class="menu-bar">

                        <li class="menu-item icon-only" id="btn-tao-kho-vat-tu" onclick="OpenModal(-1);"><span class="icon icon-add"></span><span class="text">Tạo mới kho vật tư</span></li>
                          <li class="menu-item icon-only" id="btn-reload" style="display: none;"><span class="icon icon-undo"></span>
                            <asp:LinkButton ID="ltrRefresh" runat="server" Text="Làm mới" OnClick="ltrRefresh_Click"/>
                        </li>
                        <%--<li class="menu-item right-align icon-only">
                            <div class="search-adapter-work-items header-search search-box">
                                <label class="searchbox-label hidden" for="searchbox">Search work items</label>
                                 <asp:TextBox ID="txtTimKiem" runat="server" placeholder="Tìm kiếm theo mã hoặc tên kho" CssClass="box-search-in-form"></asp:TextBox>
                                <asp:HiddenField ID="hdfIdKho" runat="server"></asp:HiddenField>
                                    <a class="icon icon-search" href="javascript:timKiem();"></a>
                            </div>
                        </li>--%>

                        <li class="menu-focus-container">
                            <div class="menu-focus-receiver" tabindex="0" role="menu"></div>
                        </li>
                    </ul>
                </div>
                <div class="work-item-view" style="display: block;">
                    <table class="data-table" id="tabDanhSachPhieuNhapVatTu">
                        <thead>
                            <tr>
                                <td style="width:5%">STT</td>
                                <td>Mã kho</td>
                                <td>Tên kho vật tư</td>
                                <td>Loại kho</td>
                                <td>Địa chỉ</td>
                                <td>Số điện thoại</td>
                                <td>Người phụ trách</td>
                                <td>Kích hoạt</td>
                                <td>Chức năng</td>
                            </tr>
                        </thead>
                        <tbody>
                             <asp:Repeater ID="rptDanhMuckho" runat="server">
                                <ItemTemplate>
                            <tr>
                                <td class="center-col" style="width:5%"><%# Container.ItemIndex+1 %></td>
                                <td class="center-col"><%# Eval("MaHieuKho") %></td>
                                <td ><%# Eval("TenKhoVatTu") %></td>
                                <td><%# Eval("LoaiKhoText") %></td>
                                <td ><%# Eval("DiaChi") %></td>
                                <td class="center-col"><%# Eval("SoDienThoai") %></td>
                                <td><%# Eval("NguoiPhuTrach") %></td>
                                <td class="center-col"><%#Eval("KichHoatText") %></td>
                                <td class="center-col"><a class="edit-icon" href="javascript:OpenModal('<%# Eval("ID")%>');"></a>
                                    <a class="delete-icon" href="javascript:deleteKho('<%# Eval("ID")%>','<%#Eval("TenKhoVatTu") %>');"></a></td>
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
<div id="content_div" title="Cập nhật danh mục kho">
</div>