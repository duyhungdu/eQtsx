<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DanhSachMatHang.ascx.cs" Inherits="xRP.Administrator.QuanLyDonHang.MatHang.DanhSachMatHang" %>
<%@ Register Assembly="CollectionPager" Namespace="SiteUtils" TagPrefix="cc1" %>
<script type="text/javascript">
    function OpenModal(id) {
        LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Administrator/QuanLyDonHang/LoaiSanPham/AddOrEditLoaiSanPham.ascx", "&id=" + id);
        $("#content_div").dialog({ modal: true, width: 700, height: 300 });
    }
    function CloseModal() {
        $("#content_div").dialog("close");
    }
    function xoa(id) {

        var answer = confirm("Bạn có thực sự muốn xóa không?")
        if (answer) {

            $.ajax({
                type: "POST",
                url: "<%#Util.SERVER_NAME %>/Administrator/QuanLyDonHang/Default.aspx/XoaMatHang",
                data: "{id:" + id + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                cache: false,
                success: function (msg) {
                    window.location.reload(true);
                }
            });
        }
        else {
            this.close();

        }

    };
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
                    <div class="info-text-wrapper"><span class="info-text">Danh sách mặt hàng</span></div>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block;">
                    <ul class="menu-bar">
                        <li class="menu-item right-align icon-only">
                            <div class="search-adapter-work-items header-search search-box">
                                <label class="searchbox-label hidden" for="searchbox">Search work items</label>
                                <asp:TextBox ID="txtTimKiem" runat="server" placeholder="Tìm kiếm theo mã hoặc tên mặt hàng" CssClass="box-search-in-form"></asp:TextBox>
                                <asp:HiddenField ID="hdfTuKhoa" runat="server"></asp:HiddenField>
                                <asp:Button ID="btnSeach" runat="server" Text="" CssClass="icon icon-search" OnClick="btnSeach_Click" />
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
                                <td style="width: 150px;">Mã hiệu mặt hàng</td>
                                <td>Tên mặt hàng</td>
                                <td style="width:120px;">Chiều dài</td>
                                <td style="width:120px;">Chiều rộng</td>
                                <td style="width:120px;">Chiều cao</td>
                                 <td style="width:120px;">Số lớp</td>
                                <td style="width:120px;">Khổ giấy</td>
                                <td style="width:120px;">Tổng dao</td>
                                <td style="width:120px;">Chặt dài</td>
                                 <td style="width:120px;">Xả</td>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptDanhMucHeSoTongGiao" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td class="center-col" style="width: 5%"><%# (colPage.CurrentPage - 1) * colPage.PageSize + Container.ItemIndex + 1 %></td>
                                        <td><%# Eval("MaHieuMatHang") %></td>
                                        <td><%# Eval("TenMatHang") %></td>
                                         <td class="center-col"><%# Eval("ChieuDai") %></td>
                                         <td class="center-col"><%# Eval("ChieuRong") %></td>
                                         <td class="center-col"><%# Eval("ChieuCao") %></td>
                                         <td class="center-col"><%# Eval("SoLop") %></td>
                                         <td class="center-col"><%# Eval("KhoGiay") %></td>
                                         <td class="center-col"><%# Eval("TongDao") %></td>
                                        <td class="center-col"><%# Eval("ChatDai") %></td>
                                        <td class="center-col"><%# Eval("Xa") %></td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
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
<div id="content_div" title="Cập nhật danh mục mặt hàng">
</div>
