<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="YeuCauSanXuat.ascx.cs" Inherits="xRP.Business.QuanLySanXuat.TaoLenhSanXuat.YeuCauSanXuat" %>
<%@ Register Assembly="CollectionPager" Namespace="SiteUtils" TagPrefix="cc1" %>
<style type="text/css">
    .f-dropdown {
        max-width: 162px !important;
    }
</style>
<script type="text/javascript">
    var dataLenhSanXuatChiTiet = [];
    var dataVatTu = [];
    $(function () {
        $("#btnSearch").click(function () {
            var congdoan = $("#<%=ddlCongDoan.ClientID%>").val();
            var tinhtrang = $("#<%=ddlTinhTrang.ClientID%>").val();
            window.location.href = "<%=Util.SERVER_NAME%>/Business/QuanLySanXuat/Default.aspx?page=dsycsx&cd=" + congdoan + "&tinhtrang=" + tinhtrang;
        });
        BindKhachHang();
    });
    function KetThucYeuCau(id) {
        if (!confirm("Bạn có chắc chắn muốn kết thúc yêu cầu?")) {
            return;
        }
        new QLSXYeuCauSanXuat({ ID: id }).KetThucYeuCau();
    }
    function HuyYeuCau(id) {
        if (!confirm("Bạn có chắc chắn muốn hủy yêu cầu?")) {
            return;
        }
        new QLSXYeuCauSanXuat({ ID: id }).HuyYeuCau();
    }
    function HuyKetThucYeuCau(id) {
        if (!confirm("Bạn có chắc chắn muốn hủy kết thúc yêu cầu?")) {
            return;
        }
        new QLSXYeuCauSanXuat({ ID: id }).HuyKetThucYeuCau();
    }
    function HuyHuy(id) {
        if (!confirm("Bạn có chắc chắn muốn khôi phục yêu cầu?")) {
            return;
        }
        new QLSXYeuCauSanXuat({ ID: id }).HuyHuyYeuCau();
    }
    function BindKhachHang() {
        queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONKhachHangForAutoComplete", "{}", function (result) {
            var objJSON = JSON.parse(result.d);

            $('#<%=txtKhachHangID.ClientID%>').autocomplete({
                lookup: objJSON,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }

                },
                onSelect: function (suggestion) {


                    $('#<%=slcKhachHangID.ClientID%>').val(suggestion.data);
                    BindDonHang(suggestion.data);
                },
                onHint: function (hint) {
                },
                onInvalidateSelection: function () {
                    $('#<%=txtKhachHangID.ClientID%>').val("");
                }
            });
        });
    }

    function BindDonHang(makhachhang) {
        queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataDonHangForAutoComplete", "{maKhachHang:\"" + makhachhang + "\"}", function (result) {
            var objJSON = JSON.parse(result.d);
            $('#<%=txtDonHangID.ClientID%>').autocomplete({
                lookup: objJSON,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }

                },
                onSelect: function (suggestion) {
                    $('#<%=slcDonHangID.ClientID%>').val(suggestion.data);

                },
                onHint: function (hint) {
                },
                onInvalidateSelection: function () {
                    $('#<%=txtDonHangID.ClientID%>').val("");
                }
            });
        });
    }
</script>
<div class="splitter horizontal hub-splitter stateful toggle-button-enabled toggle-button-hotkey-enabled">
    <div class="rightPane" style="left: 0px;">
        <div class="hub-title">
        </div>
        <div class="right-hub-content">
            <div class="work-item-form">
                <div class="workitem-info-bar">
                    <div class="info-text-wrapper">
                        <span class="info-text">
                            <asp:Literal ID="lblTitle" runat="server" Text="Danh sách yêu cầu sản xuất"></asp:Literal></span>
                    </div>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block;">
                    <ul class="menu-bar">
                        <li class="menu-item icon-only" id="btn-cancel">
                            <asp:Button ToolTip="Hủy" CssClass="menu-bar-item-button icon cancel-icon" runat="server" ID="Button3" OnClick="btnCancel_Click" />
                        </li>
                    </ul>

                </div>
                <div>

                    <table class="witform-layout">
                        <tbody>
                            <tr>
                                <td></td>
                                <td style="width: 10%;"></td>
                                <td style="width: 14%;"></td>
                                <td style="width: 8%;"></td>
                                <td style="width: 16%;"></td>
                                <td style="width: 8%;"></td>
                                <td style="width: 16%;"></td>
                                <td style="width: 10%;"></td>
                                <td style="width: 14%;"></td>
                                <td style="width: 30px; text-align: right;"></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td style="text-align: right;">Công đoạn sản xuất</td>
                                <td>
                                    <div class="workitemcontrol">
                                        <div>
                                            <div class="wrap" style="display: block">
                                                <asp:DropDownList ID="ddlCongDoan" runat="server" DataTextField="TenCongDoan" DataValueField="ID" ViewStateMode="Enabled" AutoPostBack="false">
                                                    <asp:ListItem Text="Tạo sóng" Selected="True" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="Hoàn thiện" Value="8"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td style="text-align: right;">Khách hàng</td>
                                <td>
                                    <div class="workitemcontrol">
                                        <div>
                                            <div class="wrap" style="display: block">
                                                <asp:HiddenField ID="slcKhachHangID" runat="server" />
                                                <asp:TextBox Width="250" ID="txtKhachHangID" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td style="text-align: right;">Đơn hàng</td>
                                <td>
                                    <div class="workitemcontrol">
                                        <div>
                                            <div class="wrap" style="display: block">
                                                <asp:HiddenField ID="slcDonHangID" runat="server" />
                                                <asp:TextBox ID="txtDonHangID" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td style="text-align: right;">Tình trạng yêu cầu</td>
                                <td>
                                    <div class="workitemcontrol">
                                        <div>
                                            <div class="wrap" style="display: block">
                                                <asp:DropDownList ID="ddlTinhTrang" runat="server" DataTextField="TenTinhTrang" DataValueField="ID" ViewStateMode="Enabled" AutoPostBack="false">
                                                    <asp:ListItem Text="Tất cả" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="Đang sản xuất" Value="2"></asp:ListItem>
                                                    <asp:ListItem Text="Đã hoàn thành" Value="3"></asp:ListItem>
                                                    <asp:ListItem Text="Đã hủy" Value="4"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <input type="button" class="icon icon-search" id="btnSearch" style="cursor: pointer;" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="work-item-view" style="display: block;">
                    <table class="data-table" id="tabDanhSachYeuCauSanXuat">
                        <thead>
                            <tr>
                                <td>STT</td>
                                <td style="width: 80px;">Mã ĐH</td>
                                <td>Tên mặt hàng</td>
                                <td>Mã hàng</td>
                                <td style="width: 80px;">KT tâm</td>
                                <td style="width: 80px;">Kích thước</td>
                                <td style="width: 80px;">Số lớp</td>
                                <td style="width: 80px;">Khổ giấy</td>
                                <td style="width: 80px;">Tổng dao</td>
                                <td style="width: 80px;">Chặt dài</td>
                                <td style="width: 80px;">SL tấm</td>
                                <td style="width: 80px;">SL hộp</td>
                                <td style="width: 80px;">SL yêu cầu</td>
                                <td style="width: 100px;">Tình trạng</td>
                                <td style="width: 100px;"></td>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptYeuCauSanXuat" runat="server" OnItemDataBound="rptYeuCauSanXuat_ItemDataBound">
                                <ItemTemplate>
                                    <tr>
                                        <td class="center-col" style="width: 15px">
                                            <span class="sothutu"><%# (colPage.CurrentPage - 1) * colPage.PageSize + Container.ItemIndex + 1 %></span>
                                        </td>
                                        <td class='center-col'><%# Eval("MaHieuDonHang") %></td>
                                        <td><%# Eval("TenMatHang") %></td>
                                        <td class='center-col'><%# Eval("MaHieuMatHang") %></td>
                                        <td class='center-col'><%# Eval("KTTam") %></td>
                                        <td class='center-col'><%# Eval("KichThuoc") %></td>
                                        <td class='center-col'><%# Eval("SoLop") %></td>
                                        <td class='center-col'><%# Eval("KhoGiay") %></td>
                                        <td class='center-col'><%# Eval("TongDao") %></td>
                                        <td class='center-col'><%# Eval("ChatDai") %></td>
                                        <td class='center-col'><%# Eval("SoLuongTam") %></td>
                                        <td class='center-col'><%# Eval("SoLuongHop") %></td>
                                        <td class='center-col'><%# Eval("SoLuong") %></td>
                                        <td class="center-col">
                                            <asp:Literal ID="ltTinhTrang" runat="server"></asp:Literal></td>
                                        <td>
                                            <p>
                                                <a aria-expanded="false" aria-controls="tinyDrop" data-dropdown="tinyDrop<%# Eval("ID")%>" class="button">Chức năng</a>
                                            </p>
                                            <ul aria-hidden="true" tabindex="-1" data-dropdown-content="" class="f-dropdown" id='tinyDrop<%# Eval("ID")%>'>
                                                <asp:Literal ID="ltFunction" runat="server"></asp:Literal>
                                            </ul>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
                <div class="work-item-view-pager">
                    <cc1:CollectionPager ID="colPageYeuCauSanXuat" runat="server" PageSize="10" PagingMode="QueryString"
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
        <div class="clear"></div>

    </div>
    <div class="ui-dialog-buttonset">
    </div>
</div>
<div id="content_div2" title="Định mức vật tư" style="display: none;">
    <div class="splitter horizontal hub-splitter stateful toggle-button-enabled toggle-button-hotkey-enabled">
        <div class="rightPane" style="left: 0px;">
            <div class="hub-title">
            </div>
            <div class="right-hub-content">
                <div class="work-item-form">
                    <div class="workitem-info-bar">
                        <div class="info-text-wrapper">
                            <span class="info-text">Định mức vật tư cho mặt hàng <span id="spMaHieuMatHang"></span>
                            </span>
                            <span style="float: right; text-align: right; font-size: 13px; font-weight: bold;">Số lượng yêu cầu:
                        <input id="txtSoLuongYeuCau" readonly="readonly" style="width: 120px" />
                                Số lượng cần sản xuất:
                        <input id="txtSoLuongCanSanXuat" style="width: 120px" readonly="readonly" />
                            </span>
                        </div>
                    </div>
                    <div class="work-item-form">
                        <div class="work-item-view" style="margin-left: 10px;">
                            <asp:Panel runat="server" ID="pnChiTietVatTu">
                                <div id="" class="div-data">
                                    <table class="data-table tab-detail" id="tabDinhMucVatTu">
                                        <thead>
                                            <tr>
                                                <td style="width: 5%">STT</td>
                                                <td style="width: 20%">Điểm phát sinh tiêu hao</td>
                                                <td style="width: 40%">Vật tư</td>
                                                <td style="width: 120px">Hệ số tiêu hao</td>
                                                <td style="width: 120px">Đơn vị tính</td>
                                                <td>Số lượng tiêu hao</td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                </div>
            </div>
            <div style="margin-top: 10px; text-align: right">
                <input id="btnSaveDinhMucVatTu" type="button" class="xrp-button" value="Lưu" onclick="CloseModal()" />
            </div>
        </div>
    </div>
</div>
<div id="content_div" style="z-index: 1002;" title="Phương án sản xuất">
</div>
<script type="text/javascript">
    function OpenModalCanhBaoVatTu(id) {
        var paging = $.QueryString("trang");
        var congdoan = $.QueryString("cd");
        if (congdoan != null) {
        }
        else {
            congdoan = "1";
        }
        if (paging != null) {
            LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Business/QuanLySanXuat/TaoLenhSanXuat/CanhBaoVatTu.ascx", "&id=" + id + "&cd=" + congdoan + "&trang=" + paging);
        }
        else {
            LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Business/QuanLySanXuat/TaoLenhSanXuat/CanhBaoVatTu.ascx", "&id=" + id + "&cd=" + congdoan);
        }
        $("#content_div").dialog({ modal: true, width: 1024, height: 600 });
    }
    function CloseModal() {
        $("#content_div").dialog("close");
    }
</script>
