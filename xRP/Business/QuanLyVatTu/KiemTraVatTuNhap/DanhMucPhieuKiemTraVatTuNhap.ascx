<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DanhMucPhieuKiemTraVatTuNhap.ascx.cs" Inherits="xRP.Business.QuanLyVatTu.KiemTraVatTuNhap.DanhMucPhieuKiemTraVatTuNhap" %>
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
    function deletePhieuNhap(id) {
        new PhieuNhap({
            ID: id
        }).markDelete();
    }
    function duyetPhieuNhap(id) {
        new PhieuNhap({
            ID: id
        }).duyetPhieuNhap();
    }
    function OpenKCS(id) {
        LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Business/QuanLyVatTu/KiemTraVatTuNhap/KCSKiemTraVatTuNhap.ascx", "&id=" + id);
        var title = "KCS";
        $("#content_div").dialog({ modal: true, width: 920, height: 500, title: title });
    }
    function CloseModalKCS() {
        $("#content_div").dialog("close");
        window.location.reload(true);
    }
</script>
<style type="text/css">
</style>
<div class="splitter horizontal hub-splitter stateful toggle-button-enabled toggle-button-hotkey-enabled">
    <div class="rightPane" style="left: 0px;">
        <div class="hub-title">
            <div class="query-result-grid-info">
            </div>
        </div>
        <div class="right-hub-content">
            <div class="work-item-form" style="display: block;">
                <div class="workitem-info-bar">
                    <div class="info-text-wrapper"><span class="info-text">Danh sách phiếu nhập vật tư</span></div>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block;">
                    <ul class="menu-bar">
                        <li id="mi_5" class="menu-item" title="Tạo phiếu" style="-moz-user-focus: ignore;"><a href="/Business/QuanLyVatTu/Default.aspx?page=aoepktn" title="Tạo phiếu kiểm tra vật tư"><span class="icon icon-add"></span><span class="text">Tạo phiếu</span></a></li>
                        <li class="menu-item right-align icon-only">
                            <div class="search-adapter-work-items header-search search-box">
                                <span>
                                    <asp:DropDownList ID="ddlTinhTrang" runat="server" Width="150" OnSelectedIndexChanged="ddlTinhTrang_SelectedIndexChanged" AutoPostBack="True">
                                        <asp:ListItem Text="Toàn bộ" Value="-1"></asp:ListItem>
                                        <asp:ListItem Text="Chưa kiểm tra" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Đã kiểm tra" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Duyệt" Value="2"></asp:ListItem>
                                    </asp:DropDownList></span>&nbsp;&nbsp;
                                <span style="text-align: center">Từ ngày
                                <span>
                                    <input type="text" id="datepicker" style="width: 100px" placeholder="__/__/____" name="field-name" class="combo tree drop" runat="server" />

                                </span>&nbsp &nbsp
                                Đến ngày
                                <span>
                                    <input type="text" id="datepicker1" style="width: 100px" placeholder="__/__/____" name="field-name" class="combo tree drop" runat="server" /></span>
                                    <input type="text" class="box-search-in-form" id="searchbox" runat="server" placeholder="Tìm kiếm">
                                    <asp:Button ID="btnSeach" runat="server" Text="" CssClass="icon icon-search" OnClick="btnSeach_Click" />
                                </span>
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
                                <td>STT</td>
                                <td>Mã phiếu</td>
                                <td>Nhà cung cấp</td>
                                <td>Kho chứa</td>
                                <td>Tính chất nhập xuất</td>
                                <td>Tình trạng</td>
                                <td>Ngày nhập kho</td>
                                <td>Ngày cập nhật</td>
                                <td>Người cập nhật</td>
                                <td style="width:70px;"></td>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptDanhMucLoaiVatTu" runat="server" OnItemDataBound="rptDanhMucLoaiVatTu_ItemDataBound">
                                <ItemTemplate>
                                    <tr>
                                        <td class="center-col"><%# (colPage.CurrentPage - 1) * colPage.PageSize + Container.ItemIndex + 1 %></td>
                                        <td class="center-col"><%# Eval("MaHieuPhieuNhap") %></td>
                                        <td><%# ((xRPDAL.Sp_Qlvt_PhieuNhap_SelectResult)Container.DataItem).TenNhaCungCap%></td>
                                        <td><%# ((xRPDAL.Sp_Qlvt_PhieuNhap_SelectResult)Container.DataItem).TenKhoVatTu%></td>
                                        <td><%# ((xRPDAL.Sp_Qlvt_PhieuNhap_SelectResult)Container.DataItem).TenTinhChatNhapXuat%></td>
                                        <td><%# ConvertStatus(Eval("TinhTrang")) %></td>
                                        <td class="center-col"><%# string.Format("{0:dd/MM/yyyy}", Eval("NgayNhap")) %></td>
                                        <td class="center-col"><%# string.Format("{0:dd/MM/yyyy HH:mm}", Eval("NgayThayDoi")) %></td>
                                        <td><%# Eval("UserName") %></td>
                                        <td>
                                            <p>
                                                <a aria-expanded="false" aria-controls="tinyDrop" data-dropdown="tinyDrop<%# Eval("ID")%>" class="button">Chức năng</a>
                                            </p>
                                            <ul aria-hidden="true" tabindex="-1" data-dropdown-content="" class="f-dropdown" id='tinyDrop<%# Eval("ID")%>'>
                                                <asp:Literal ID="ltView" runat="server"></asp:Literal>
                                                <asp:Literal ID="ltEdit" runat="server"></asp:Literal>
                                                <asp:Literal ID="ltDelete" runat="server"></asp:Literal>
                                                <asp:Literal ID="ltPrint" runat="server"></asp:Literal>
                                                <asp:Literal ID="ltPrintNCC" runat="server"></asp:Literal>
                                                <asp:Literal ID="ltAccept" runat="server"></asp:Literal>
                                                <asp:Literal ID="ltKCS" runat="server"></asp:Literal>
                                            </ul>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="paging">
                <cc1:CollectionPager ID="colPage" runat="server" PageSize="10" PagingMode="QueryString"
                    QueryStringKey="trang" BackText="Trước"
                    FirstText="Đầu" LastText="Cuối" NextText="Sau"
                    LabelText="" PageNumbersSeparator="&amp;nbsp;&amp;nbsp;" PageNumbersStyle="color:#ea1111;font-size:12px;padding:5px;"
                    PageNumberStyle="color:#555;padding:3px 8px;border:solid 1px #ccc;" ResultsLocation="Bottom"
                    ResultsStyle="font-family:Arial;font-size:12px;text-align:right;margin-top:5px;"
                    ShowLabel="True" BackNextButtonStyle="border:none;background:red;" BackNextDisplay="HyperLinks"
                    BackNextLinkSeparator="&nbsp;&nbsp;-&nbsp;&nbsp;" ControlStyle="text-align:right;margin:5px;float:right;" BackNextLocation="Split" ResultsFormat="Hiển thị {0}-{1} (trong tổng số {2} bản ghi)" ShowFirstLast="True" ControlCssClass="paging_tool_bar" EnableViewState="False" MaxPages="10" SectionPadding="5" SliderSize="5">
                </cc1:CollectionPager>
            </div>
        </div>
    </div>
</div>
<div id="content_div" title="KCS">
</div>
