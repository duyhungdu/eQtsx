<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DanhSachXuatThanhPham.ascx.cs" Inherits="xRP.Business.QuanLyVatTu.XuatThanhPham.DanhSachXuatThanhPham" %>
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
        queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataKhoVatTuNVLorThanhPhamForAutoComplete", "{TYPE:2}", function (result) {
            var objJSON = JSON.parse(result.d);
            $('#<%=txtKhoThanhPham.ClientID%>').autocomplete({
                lookup: objJSON,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }

                },
                onSelect: function (suggestion) {
                    $('#<%=slcKhoThanhPham.ClientID%>').val(suggestion.data);
                },
                onHint: function (hint) {
                },
                onInvalidateSelection: function () {
                    $('#<%=slcKhoThanhPham.ClientID%>').val("");
                }
            });
        });
        $("#btnAccept").on("click", function () {
            if ($("#<%=slcKhoThanhPham.ClientID%>").val() == "") {
                alert("Bạn chưa chọn kho vật tư");
            }
            else {
                window.location.href = "/Business/QuanLyVatTu/Default.aspx?page=cnxtp&kho=" + $("#<%=slcKhoThanhPham.ClientID%>").val();
            }
        });
    });
    function deletePhieuXuat(id) {
        new PhieuXuat({
            ID: id
        }).markDelete();
    }


    function duyetPhieuXuat(id) {
        new PhieuXuat({
            itemID: id
        }).duyetPhieuXuatThanhPham();
    }
    function OpenKCS(id) {
        LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Business/QuanLyVatTu/XuatVatTu/KCSKiemTraVatTuXuat.ascx", "&id=" + id);
        var title = "KCS vật tư xuất";
        $("#content_div").dialog({ modal: true, width: 920, height: 500, title: title });
    }
    function CloseModalKCS() {
        $("#content_div").dialog("close");
        window.location.reload(true);
    }
    function taoPhieu() {
        $("#new_phieu_dialog").dialog({ modal: true, width: 500, height: 200, title: "Chọn kho xuất" });
    }
</script>
<div class="splitter horizontal hub-splitter stateful toggle-button-enabled toggle-button-hotkey-enabled">
    <div class="rightPane" style="left: 0px;">
        <div class="hub-title">
            <div class="query-result-grid-info">
            </div>
        </div>
        <div class="right-hub-content">
            <div class="work-item-form" style="display: block;">
                <div class="workitem-info-bar">
                    <div class="info-text-wrapper"><span class="info-text">Danh sách phiếu xuất thành phẩm</span></div>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block;">
                    <ul class="menu-bar">
                        <%--<li class="menu-item icon-only" id="Li1"><span class="icon icon-add"></span><a href="/Business/QuanLyVatTu/Default.aspx?page=aoepktx" title="Tạo phiếu xuất thành phẩm">Tạo phiếu</a>
                        </li>--%>
                        <li class="menu-item icon-only" id="btn-tao-phieu-nhap-kho"><a href="javascript:taoPhieu()" title="Tạo phiếu xuất thành phẩm"><span class="icon icon-add"></span><span class="text">Tạo phiếu</span></a>
                        </li>
                        <li class="menu-item right-align icon-only">
                            <div class="search-adapter-work-items header-search search-box">
                                <input type="text" class="box-search-in-form" id="searchbox" runat="server" placeholder="Tìm kiếm">
                                <span>
                                    <asp:DropDownList ID="ddlTinhTrang" runat="server" Width="150" EnableViewState="true">
                                        <asp:ListItem Text="Toàn bộ" Value="-1"></asp:ListItem>
                                        <asp:ListItem Text="Chưa duyệt" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Đã duyệt" Value="1"></asp:ListItem>
                                    </asp:DropDownList></span>&nbsp;&nbsp;
                                <span style="text-align: center">Từ ngày
                                <span>
                                    <input type="text" id="datepicker" style="width: 100px" placeholder="__/__/____" name="field-name" class="combo tree drop" runat="server" />

                                </span>&nbsp &nbsp
                                Đến ngày
                                <span>
                                    <input type="text" id="datepicker1" style="width: 100px" placeholder="__/__/____" name="field-name" class="combo tree drop" runat="server" /></span>

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
                    <table class="data-table" id="tabDanhSachPhieuXuatThanhPham">
                        <thead>
                            <tr>
                                <td>STT</td>
                                <td>Mã phiếu</td>
                                <td>Khách hàng</td>
                                <td>Nội dung</td>
                                <td>Kho xuất</td>
                                <td>Tình trạng</td>
                                <td>Ngày xuất</td>
                                <td>Ngày cập nhật</td>
                                <td>Người cập nhật</td>
                                <td style="width: 70px;"></td>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptDanhMucLoaiVatTu" runat="server" OnItemDataBound="rptDanhMucLoaiVatTu_ItemDataBound">
                                <ItemTemplate>
                                    <tr>
                                        <td class="center-col"><%# (colPage.CurrentPage - 1) * colPage.PageSize + Container.ItemIndex + 1 %></td>
                                        <td class="center-col"><%# Eval("MaHieuPhieuXuat") %></td>
                                        <td><%# ((xRPDAL.Sp_Qlvt_PhieuXuat_SelectResult)Container.DataItem).TenDonVi%></td>
                                        <td><%# Eval("TenTinhChatNhapXuat") %></td>
                                        <td><%# ((xRPDAL.Sp_Qlvt_PhieuXuat_SelectResult)Container.DataItem).TenKhoVatTu%></td>
                                        <td><%# TinhTrangPhieu[int.Parse(Eval("TinhTrang").ToString())]%></td>
                                        <td class="center-col"><%# string.Format("{0:dd/MM/yyyy}", Eval("NgayXuat")) %></td>
                                        <td class="center-col"><%# string.Format("{0:dd/MM/yyyy}", Eval("NgayThayDoi")) %></td>
                                        <td class="center-col"><%# Eval("UserName") %></td>
                                        <td>
                                            <p>
                                                <a aria-expanded="false" aria-controls="tinyDrop" data-dropdown="tinyDrop<%# Eval("ID")%>" class="button">Chức năng</a>
                                            </p>
                                            <ul aria-hidden="true" tabindex="-1" data-dropdown-content="" class="f-dropdown" id='tinyDrop<%# Eval("ID")%>'>
                                                <asp:Literal ID="ltEdit" runat="server"></asp:Literal>
                                                <asp:Literal ID="ltDelete" runat="server"></asp:Literal>
                                                <asp:Literal ID="ltAccept" runat="server"></asp:Literal>
                                                <asp:Literal ID="ltPrint" runat="server"></asp:Literal>
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

<div id="new_phieu_dialog" title="Chọn kho xuất" style="display: none;">
    <div class="work-item-form">
        <div class="work-item-view" style="height: 100px">
            <table class="witform-layout">
                <tbody>
                    <tr>
                        <td style="width: 30%; padding: 10px 0"></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>Kho xuất:
                        </td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:HiddenField ID="slcKhoThanhPham" runat="server" />
                                        <asp:TextBox ID="txtKhoThanhPham" runat="server" />
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix button-list">
        <input type="button" id="btnAccept" class="xrp-button" value="Chấp nhận" />
        <input type="button" class="xrp-button" onclick="$('#new_phieu_dialog').dialog('close')" value="Hủy" />
    </div>

</div>
