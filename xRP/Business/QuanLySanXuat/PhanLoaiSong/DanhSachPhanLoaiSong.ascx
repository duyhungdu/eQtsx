<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DanhSachPhanLoaiSong.ascx.cs" Inherits="xRP.Business.QuanLySanXuat.PhanLoaiSong.DanhSachPhanLoaiSong" %>
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
                    <div class="info-text-wrapper"><span class="info-text">Danh sách phân loại sóng</span></div>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block;">
                    <ul class="menu-bar">

                        <li class="menu-item icon-only" id="btn-tinh-chat-xuat-nhap" onclick="OpenModal(0);"><span class="icon icon-add"></span><span class="text">Tạo phân loại sóng</span></li>
                        <li class="menu-item right-align icon-only">
                            <div class="search-adapter-work-items header-search search-box">
                                <label class="searchbox-label hidden" for="searchbox">Search work items</label>
                                <asp:TextBox ID="txtTimKiem" runat="server" Width="300px" placeholder="Tìm kiếm" CssClass="box-search-in-form"></asp:TextBox>
                                <asp:Button ID="btnSeach" runat="server" Text="" CssClass="icon icon-search" OnClick="btnSeach_Click" />
                            </div>
                        </li>

                        <li class="menu-focus-container">
                            <div class="menu-focus-receiver" tabindex="0" role="menu"></div>
                        </li>
                    </ul>
                </div>
                <div class="work-item-view" style="display: block;">
                    <table class="data-table" id="tabDanhSachPhanLoaiSong">
                        <thead>
                            <tr>
                                <td style="width: 5%;" class="center-col">STT</td>
                                <td style="width: 15%;">Kí hiệu cơ cấu giấy</td>
                                <td>Mô tả cơ cấu giấy</td>
                                <td style="width: 15%;">Kí hiệu quy đổi</td>
                                <td style="width: 10%;">Số lớp</td>
                                <td style="width: 10%;">Kích hoạt</td>

                                <td style="width: 70px;"></td>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptPhanLoaiSong" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td class="center-col" style="width: 5%">
                                            <%# (CollectionPager1.CurrentPage - 1) * CollectionPager1.PageSize + Container.ItemIndex + 1 %>
                                        </td>
                                        <td class="center-col"><%# Eval("KiHieuCoCauGiay") %></td>
                                        <td><%# Eval("MoTaCoCauGiay") %></td>
                                        <td class="center-col"><%# Eval("KiHieuQuyDoi") %></td>
                                        <td class="center-col"><%# Eval("SoLop") %></td>
                                        <td class="center-col"><%# Eval("KichHoatText") %></td>

                                        <td class="center-col">
                                            <a class="edit-icon" id="edit-icon" href="javascript:OpenModal('<%# Eval("ID")%>');"></a>
                                            <a class="delete-icon" id="deleteicon" href="javascript:deletePhanLoaiSong('<%# Eval("ID")%>');"></a>
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
<div id="content_div" style="z-index: 1002;" title="Cập nhật phân loại sóng">
</div>
<script type="text/javascript">
    function OpenModal(id) {
        var paging = $.QueryString("trang");
        if (paging != null) {
            LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Business/QuanLySanXuat/PhanLoaiSong/AddOrEditPhanLoaiSong.ascx", "&id=" + id + "&trang=" + paging);
        }
        else {
            LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Business/QuanLySanXuat/PhanLoaiSong/AddOrEditPhanLoaiSong.ascx", "&id=" + id);
        }
        $("#content_div").dialog({ modal: true, width: 700, height: 400 });
    }
    function deletePhanLoaiSong(id) {
        try {
            var data = new Object();
            data.itemID = id;
            data.kiHieuCoCauGiay = "";
            data.moTaCoCauGiay = 0;
            data.soLop = 0;
            data.kichHoat = true;
            data.ghiChu = "";

            var phanLoaiSong = new PhanLoaiSong(data);
            phanLoaiSong.markDelete(function (result) {
                var newid = result.id;
                if ($.isNumeric(newid)) {
                    window.location.href = "<%=Util.SERVER_NAME %>/Business/QuanLySanXuat/Default.aspx?page=pls";

                } else {
                    alert("Có lỗi khi xóa dữ liệu\n" + result.d);
                }
            });

        } catch (e) { }
    }
    function timKiem() {
        alert('Tìm kiếm phân loại sóng');
    }
    function CloseModal() {
        $("#content_div").dialog("close");
    }
</script>
