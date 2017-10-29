<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DanhMucThongSo.ascx.cs" Inherits="xRP.Lab.ThongSoHeThong.DanhMucThongSo" %>
<%@ Register Assembly="CollectionPager" Namespace="SiteUtils" TagPrefix="cc1" %>

<script type="text/javascript">
    function OpenModal(id) {
        LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Lab/ThongSoHeThong/AddOrEditThongSo.ascx", "&id=" + id);
        $("#content_div").dialog({ modal: true, width: 800, height: 400 });
    }
    function CloseModal() {
        $("#content_div").dialog("close");
    }
    function xoa(id) {
        var answer = confirm("Bạn chắc chắn muốn xóa bản ghi này?")
        if (answer) {

            $.ajax({
                type: "POST",
                url: "<%#Util.SERVER_NAME %>/Lab/ThongSoHeThong/ThongSoHeThong.aspx/XoaThongSo",
                data: "{id:" + id + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                cache: false,
                success: function (msg) {
                    window.location.href = "<%#Util.SERVER_NAME %>/Lab/ThongSoHeThong/ThongSoHeThong.aspx?page=tsht";
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
        <div class="right-hub-content">
            <div class="work-item-form" style="display: block;">
                <div class="workitem-info-bar">
                    <div class="info-text-wrapper"><span class="info-text">Danh mục thông số hệ thống</span></div>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block;">
                    <ul class="menu-bar">
                        <li class="menu-item icon-only disabled" id="btn-luu">
                            <input class="menu-bar-item-button icon icon-save" title="Lưu" type="button" style="cursor: default;" /></li>
                        <li class="menu-item icon-only" id="btn-thong-so-he-thong" onclick="OpenModal(-1);"><span class="icon icon-add"></span><a href="javascript:void(0);">Thêm thông số</a></li>
                        <li class="menu-item icon-only" id="btn-reload" style="display: none;"><span class="icon icon-undo"></span>
                            <asp:LinkButton ID="ltrRefresh" runat="server" Text="Làm mới" OnClick="ltrRefresh_Click" />
                        </li>
                        <li class="menu-item right-align icon-only">
                            <div class="search-adapter-work-items header-search search-box">
                                <label class="searchbox-label hidden" for="searchbox">Search work items</label><input type="text" class="box-search-in-form" id="searchbox"><span class="icon icon-search"></span>
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
                                <td>Thông số</td>
                                <td>Giá trị</td>
                                <td>Mô tả</td>
                                <td>Chức năng</td>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptThongSoHeThong" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td class="center-col" style="width: 5%;"><%# (colPage.CurrentPage - 1) * colPage.PageSize + Container.ItemIndex + 1 %></td>
                                        <td class="left-col" style="width: 15%;"><%# Eval("ThongSo") %></td>
                                        <td class="left-col" style="width: 35%;"><%# Eval("GiaTri") %></td>
                                        <td class="left-col" style="width: 30%;"><%# Eval("MoTa") %></td>
                                        <td class="center-col" style="width: 15%;"><a class="edit-icon" id="edit-icon" href="javascript:OpenModal('<%# Eval("ThongSo")%>');"></a>
                                            <a class="delete-icon" href="javascript:xoa('<%# Eval("ThongSo")%>');"></a></td>
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
                        BackNextLinkSeparator="&nbsp;&nbsp;-&nbsp;&nbsp;" ControlStyle="text-align:right;margin:5px;float:right;" BackNextLocation="Split" ResultsFormat="Hiển thị {0}-{1} (trong tổng số {2} bản ghi)" ShowFirstLast="True" ControlCssClass="paging_tool_bar" EnableViewState="False" MaxPages="10" SectionPadding="5" SliderSize="10" HideOnSinglePage="False">
                    </cc1:CollectionPager>
                </div>
            </div>

        </div>

    </div>
</div>
<div id="content_div" title="Thêm mới thông số hệ thống">
</div>
<%--END Modal --%>