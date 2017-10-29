<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DanhMucDonHang.ascx.cs" Inherits="xRP.Administrator.QuanLyDonHang.DonHang.DanhMucDonHang" %>
<%@ Register Assembly="CollectionPager" Namespace="SiteUtils" TagPrefix="cc1" %>
<script type="text/javascript">
    $(document).ready(function () {
        $('#<%=datepicker.ClientID%>').datetimepicker({
            mask: '99/99/9999', timepicker: false,
            format: 'd/m/Y',
        });


        $('#<%=datepicker1.ClientID%>').datetimepicker({
            mask: '99/99/9999', timepicker: false,
            format: 'd/m/Y',
        });
    });
    function xoa(id) {
        new DonHang({
            ID: id
        }).markDelete();
    }
    function huyxuly(id) {
        new DonHang({
            ID: id
        }).undoProcess();
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
                    <div class="info-text-wrapper"><span class="info-text">Danh sách đơn hàng</span></div>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block;">
                    <ul class="menu-bar">
                        
                        <li style="<%=display_button%>" class="menu-item icon-only" id="btn-tao-moi-don-hang"><a href="/Administrator/QuanLyDonHang/DonHang/Default.aspx?page=addoreditdonhang"><span class="icon icon-add"></span><span class="text">Tạo mới đơn hàng</span></a></li>
                       
                        <li class="menu-item icon-only" id="btn-reload" style="display: none;"><span class="icon icon-undo"></span>
                        </li>
                        <li class="menu-item right-align icon-only">
                            <div class="search-adapter-work-items header-search search-box">

                                <span style="text-align: center">Từ ngày
                                <span>
                                    <input type="text" id="datepicker" style="width: 100px" placeholder="__/__/____" name="field-name" class="combo tree drop" runat="server" />
                                </span>&nbsp &nbsp
                                Đến ngày
                                <span>
                                    <input type="text" id="datepicker1" style="width: 100px" placeholder="__/__/____" name="field-name" class="combo tree drop" runat="server" /></span>

                                    <label class="searchbox-label hidden" for="searchbox">Search work items</label>
                                    <%--<input type="text" class="box-search-in-form" id="searchbox">--%>
                                    <asp:TextBox ID="txtTimKiem" runat="server" placeholder="Tìm kiếm theo mã hoặc tên đơn hàng" CssClass="box-search-in-form"></asp:TextBox>
                                    <asp:LinkButton ID="btTimKiem" runat="server" CssClass="icon icon-search" OnClick="btTimKiem_Click"></asp:LinkButton>
                                </span>

                            </div>
                        </li>

                        <li class="menu-focus-container">
                            <div class="menu-focus-receiver" tabindex="0" role="menu"></div>
                        </li>
                    </ul>
                </div>
                <div class="work-item-view" style="display: block;">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <td style="width: 5%">STT</td>
                                <td>Mã đơn hàng</td>
                                <td>Mã khách hàng</td>
                                <td>Tên khách hàng</td>
                                <td>Ngày đặt hàng</td>
                                <td>Ngày giao hàng</td>
                                <td>Tình trạng</td>
                                <td>Ngày cập nhật</td>
                                <td>Người cập nhật</td>
                                <td style="width: 70px;"></td>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptDonHang" runat="server" OnItemDataBound="rptDonHang_ItemDataBound">
                                <ItemTemplate>
                                    <tr>
                                        <td class="center-col" style="width: 5%"><%# (CollectionPager1.CurrentPage - 1) * CollectionPager1.PageSize + Container.ItemIndex + 1 %></td>
                                        <td><%# Eval("MaHieuDonHang") %></td>
                                        <td><%# Eval("MaHieuKhachHang")  %></td>
                                        <td><%# Eval("TenKhachHang") %></td>
                                        <td class="center-col"><%# string.Format("{0:dd/MM/yyyy}",Eval("NgayDatHang")) %></td>
                                        <td class="center-col"><%# string.Format("{0:dd/MM/yyyy}", Eval("NgayGiaoHang")) %></td>
                                        <td class="center-col"><%# TinhTrang[((xRPDAL.Sp_Qldh_DonHang_SelectResult)Container.DataItem).TinhTrang.Value]%></td>
                                        <td class="center-col"><%# string.Format("{0:dd/MM/yyyy}", Eval("NgayThayDoi")) %></td>
                                        <td class="center-col"><%# string.Format("{0:dd/MM/yyyy}", Eval("UserName")) %></td>
                                        <td>
                                            <p>
                                                <a aria-expanded="false" aria-controls="tinyDrop" data-dropdown="tinyDrop<%# Eval("ID")%>" class="button">Chức năng</a>
                                            </p>
                                            <ul aria-hidden="true" tabindex="-1" data-dropdown-content="" class="f-dropdown" id='tinyDrop<%# Eval("ID")%>'>
                                                <asp:Literal ID="ltEditItem" runat="server"></asp:Literal>
                                                <li class="menu-item">
                                                    <asp:Literal ID="ltXuLyDonHang" runat="server"></asp:Literal></li>
                                                    <asp:Literal ID="ltXoaDonHang" runat="server"></asp:Literal></li>
                                                    <asp:Literal ID="ltUndoProcess" runat="server"></asp:Literal></li>
                                                <li class="menu-item">
                                                    <a href="/Administrator/QuanLyDonHang/Default.aspx?page=ppdathhang&id=<%# Eval("ID")%>" title="In đơn hàng">
                                                        <span class="icon icon-printer"></span>
                                                        <span class="text">In</span></a></li>

                                            </ul>

                                        </td>

                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="work-item-view-pager">
                <cc1:CollectionPager ID="CollectionPager1" runat="server" PageSize="15" PagingMode="QueryString"
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
