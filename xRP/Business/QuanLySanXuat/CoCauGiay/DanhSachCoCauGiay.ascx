<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DanhSachCoCauGiay.ascx.cs" Inherits="xRP.Business.QuanLySanXuat.CoCauGiay.DanhSachCoCauGiay" %>
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
                    <div class="info-text-wrapper"><span class="info-text">Danh mục cơ cấu giấy</span></div>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block;">
                    <ul class="menu-bar">

                        <li class="menu-item icon-only" id="btn-tinh-chat-xuat-nhap" onclick="OpenModal(-1);"><span class="icon icon-add"></span><span class="text">Thêm cơ cấu giấy</span></li>
                        <li class="menu-item right-align icon-only">
                            <span class="search-adapter-work-items header-search search-box">
                                <label class="searchbox-label hidden" for="searchbox">Search work items</label>
                                <span>Phân loại sóng</span>
                                <span>
                                    <asp:HiddenField ID="slcIDCoCauGiay" runat="server" Value="0" />
                                    <asp:TextBox ID="txtIDCoCauGiay" runat="server" TabIndex="2" Width="300px"></asp:TextBox>
                                </span>
                                <asp:Button ID="btnSeach" runat="server" Text="" CssClass="icon icon-search" OnClick="btnSeach_Click" />
                            </span>
                        </li>
                        <li class="menu-focus-container">
                            <div class="menu-focus-receiver" tabindex="0" role="menu"></div>
                        </li>
                    </ul>
                </div>
                <div class="work-item-view" style="display: block;">
                    <table class="data-table" id="tabDanhSachCoCauGiay">
                        <thead>
                            <tr>
                                <td style="width: 35px" class="center-col">STT</td>
                                <td style="width:10%;">Tên lớp</td>
                                <td style="width:10%;">Tên sóng</td>
                                <td style="width:10%;">Hệ số tiêu hao</td>
                                <td style="width:10%;">Kí hiệu cơ cấu giấy</td>
                                <td style="width:10%;">Số lớp</td>
                                <td>Mô tả cơ cấu giấy</td>
                                <td style="width:10%;">Loại giấy</td>
                                <td style="width:120px;"></td>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptCoCauGiay" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td class="center-col" style="width: 5%">
                                            <%# (colPager.CurrentPage - 1) * colPager.PageSize + Container.ItemIndex + 1 %>
                                        </td>
                                        <td><%# Eval("TenLop") %></td>
                                        <td><%# Eval("TenSong") %></td>
                                        <td class="center-col"><%# Eval("HeSoTieuHao") %></td>
                                        <td class="center-col"><%# Eval("KiHieuCoCauGiay") %></td>
                                        <td class="center-col"><%# Eval("SoLop") %></td>
                                        <td><%# Eval("MoTaCoCauGiay") %></td>
                                         <td><%# Eval("TenLoaiVatTu") %></td>
                                        <td class="center-col">
                                            <a class="edit-icon" id="edit-icon" href="javascript:OpenModal('<%# Eval("ID")%>');"></a>
                                            <a class="delete-icon" href="javascript:deleteCoCauGiay('<%# Eval("ID")%>');"></a>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
                <div class="work-item-view-pager">
                    <cc1:CollectionPager ID="colPager" runat="server" PageSize="10" PagingMode="QueryString"
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
<div id="content_div" style="z-index: 1002;" title="Cận nhật thông tin cơ cấu giấy">
</div>
<script type="text/javascript">
    $(function () {
        $('#<%=txtIDCoCauGiay.ClientID%>').focus();

        //Phân loại sóng
        queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONPhanLoaiSongForSearch", {}, function (result) {
            var objJSON = JSON.parse(result.d);
            $('#<%=txtIDCoCauGiay.ClientID%>').autocomplete({
                lookup: objJSON,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }
                },
                onSelect: function (suggestion) {
                    $('#<%=slcIDCoCauGiay.ClientID%>').val(suggestion.data);
                },
                onHint: function (hint) {
                },
                onInvalidateSelection: function () {
                    $('#<%=slcIDCoCauGiay.ClientID%>').val("0");
                }
            });
        });
        //End-Phân loại sóng
    });


        function OpenModal(id) {
            var paging = $.QueryString("trang");
            if (paging != null) {
                LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Business/QuanLySanXuat/CoCauGiay/AddOrEditCoCauGiay.ascx", "&id=" + id + "&trang=" + paging);
            }
            else {
                LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Business/QuanLySanXuat/CoCauGiay/AddOrEditCoCauGiay.ascx", "&id=" + id);
            }
            $("#content_div").dialog({ modal: true, width: 800, height: 400 });
        }
        function deleteCoCauGiay(id) {
            var data = new Object();
            data.itemID = id;
            data.tenLop = "";
            data.danhMucSong = "";
            data.kichHoat = true;
            var delCoCauGiay = new CoCauGiay(data);
            delCoCauGiay.markDelete(function (result) {
                alert("Đã xóa chi tiết cơ cấu giấy.");
                window.location.reload(true);
            });
        }

        function CloseModal() {
            $("#content_div").dialog("close");
        }
</script>
