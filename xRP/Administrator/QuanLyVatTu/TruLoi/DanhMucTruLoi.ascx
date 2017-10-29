<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DanhMucTruLoi.ascx.cs" Inherits="xRP.Administrator.QuanLyVatTu.TruLoi.DanhMucTruLoi" %>
<%@ Register Assembly="CollectionPager" Namespace="SiteUtils" TagPrefix="cc1" %>
<script type="text/javascript">
    function OpenModal(id) {
        if (id == "-1")
            $("#content_div").prop('title', 'Thêm mới danh mục trừ lõi');
        else
            $("#content_div").prop('title', 'Chỉnh sửa danh mục trừ lõi');
        LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Administrator/QuanLyVatTu/TruLoi/AddOrEditTruLoi.ascx", "&id=" + id);
        $("#content_div").dialog({ modal: true, width: 500, height: 400 });
    }
    function CloseModal() {
        $("#content_div").dialog("close");
        document.getElementById("<%= ltrRefresh.ClientID %>").click();
    }
    function deleteItem(id) {
        var answer = confirm("Bạn có thực sự muốn xóa \"" + "danh mục trừ lõi" + "\"?")
        if (answer) {
            $.ajax({
                type: "POST",
                url: "<%#Util.SERVER_NAME %>/Administrator/QuanLyVatTu/TruLoi/Default.aspx/DeleteItem",
                data: "{itemID:" + id + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                cache: false,
                success: function (msg) {
                    alert(msg.d);
                    window.location.reload(true);
                }
            });
        }
        else {
            this.close();
        }
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
                    <div class="info-text-wrapper"><span class="info-text">Danh sách danh mục trừ lõi</span></div>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block;">
                    <ul class="menu-bar">
                        <li class="menu-item icon-only" id="btn-tao-phieu-nhap-kho" onclick="OpenModal(-1);"><span class="icon icon-add"></span><span class="text">Thêm danh mục trừ lõi</span></li>
                        <li class="menu-item icon-only" id="btn-reload" style="display: none;"><span class="icon icon-undo"></span>
                            <asp:LinkButton ID="ltrRefresh" runat="server" Text="Làm mới" OnClick="btnRefresh_Click" />
                        </li>
                        <li class="menu-item right-align icon-only">
                            <div class="search-adapter-work-items header-search search-box">
                                <label class="searchbox-label hidden" for="searchbox">Tìm kiếm</label>
                                <input type="text" runat="server" class="box-search-in-form" id="searchbox" /><asp:Button ID="btnSearch" runat="server" CssClass="icon icon-search" OnClick="btnSearch_Click" />
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
                                <td>Mã hiệu loại vật tư</td>
                                <td>Kích thước</td>
                                <td>Trừ lõi</td>
                                <td>Chức năng</td>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptDanhMucLoaiVatTu" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td class="center-col"><%# (colPage.CurrentPage - 1) * colPage.PageSize + Container.ItemIndex + 1 %></td>
                                        <td class="center-col">N/A</td>
                                        <td class="center-col"><%# Eval("MaHieuLoaiVatu") %></td>
                                        <td class="center-col"><%# Eval("TruLoi") %></td>
                                        <td class="center-col">
                                            <a class="edit-icon" href="javascript:OpenModal('<%# Eval("ID")%>');"></a>
                                            <a class="delete-icon" href="javascript:deleteItem('<%# Eval("ID")%>');"></a></td>
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
                    LabelText="" PageNumbersSeparator="&amp;nbsp;&amp;nbsp;" PageNumbersStyle="color:#ea1111;font-size:12px;padding:5px;"
                    PageNumberStyle="color:#555;padding:3px 8px;border:solid 1px #ccc;" ResultsLocation="Bottom"
                    ResultsStyle="font-family:Arial;font-size:12px;text-align:right;margin-top:5px;"
                    ShowLabel="True" BackNextButtonStyle="border:none;background:red;" BackNextDisplay="HyperLinks"
                    BackNextLinkSeparator="&nbsp;&nbsp;-&nbsp;&nbsp;" ControlStyle="text-align:right;margin:5px;float:right;" BackNextLocation="Split" ResultsFormat="Hiển thị {0}-{1} (trong tổng số {2} bản ghi)" ShowFirstLast="True" ControlCssClass="paging_tool_bar" EnableViewState="False" MaxPages="10" SectionPadding="5" SliderSize="7">
                </cc1:CollectionPager>
            </div>
        </div>
    </div>
</div>
<div id="content_div">
</div>