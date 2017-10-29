<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ViewDetailPhieuKiemTraVatTuNhap.ascx.cs" Inherits="xRP.Business.QuanLyVatTu.KiemTraVatTuNhap.ViewDetailPhieuKiemTraVatTuNhap" %>
<%@ Register Assembly="CollectionPager" Namespace="SiteUtils" TagPrefix="cc1" %>
<script type="text/javascript">
    var dataChiTiet = [];
    var dataVatTu = [];
    var isEditable = false;
    $(function () {
        if (isEditable) {
            $("#btnSave").css("display", "none");
        }
        if ("<%=ID_PhieuNhap%>" != "") {
            dataChiTiet = new PhieuNhap({ ID: parseInt("<%=ID_PhieuNhap%>") }).getChiTietPhieuNhap();
            bindDataChiTiet(dataChiTiet);
        }
        dataVatTu = JSON.parse('<%=DataVatTu%>');

       
            $("#btnPrint").click(function () {
                window.location.href = "<%= Util.SERVER_NAME%>/Business/QuanLyVatTu/Default.aspx?page=ppn&id=<%= ID_PhieuNhap %>";
            });
       
    });

    function OpenChiTietVatTu(id, randID) {
        LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Business/QuanLyVatTu/KiemTraVatTuNhap/AddOrEditChiTietPhieuKiemTraVatTuNhap.ascx", "&id=" + randID);
        var title = "Xem chi tiết vật tư nhập";
        $("#content_div").dialog({ modal: true, width: 920, height: 500, title: title });
    }
    function CloseModal() {
        $("#content_div").dialog("close");
    }

    function bindDataChiTiet(dataChiTiet) {
        $("#tabDanhSachPhieuNhapVatTu tbody").text("");
        for (var i = 0; i < dataChiTiet.length; i++) {
            if (!dataChiTiet[i].MarkDelete.Value)
                $("#tabDanhSachPhieuNhapVatTu tbody").append("<tr><td class='center-col'>" + (i + 1) + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].MaCuon.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].MaHieuVatTu.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].TenVatTu.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].DonViTinh.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].DonGia.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].SoLuongThucNhap.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].SoLuongDauCuon.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].SoLuongLamPhieuNhap.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].DinhLuongTieuChuan.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].DinhLuongThucTe.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].KichThuocTieuChuan.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].KichThuocThucTe.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].ChenhLechDinhLuong.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].DinhLuongTinhTru.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].TruThuaKichThuoc.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].KhoiLuongTru.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].TruLoi.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].SoLuongChenhLechKhongTinh.Value + "</td>" +
                    "<td class='center-col'>" + dataChiTiet[i].ThanhTien.Value + "</td>" +
                    "<td class='center-col'>" +
                    '<a class="edit-icon" href="javascript:OpenChiTietVatTu(\'' + dataChiTiet[i].ID.Value + '\',\'' + dataChiTiet[i].GUID + '\');"></a>'
                    + "</td>"
                    + "</tr>");
        }
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
                            <asp:Literal ID="ltTitle" runat="server"></asp:Literal></span>
                    </div>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block;">
                    <ul class="menu-bar">
                        <asp:Literal ID="ltPrint" runat="server"></asp:Literal>
                        <li class="menu-item icon-only" id="btn-cancel">
                            <asp:Button ToolTip="Hủy" CssClass="menu-bar-item-button icon cancel-icon" runat="server" ID="btnCancel" OnClick="btnCancel_Click" />
                        </li>
                    </ul>
                </div>
                <div class="work-item-view" style="margin-left: 10px;">

                    <table class="witform-layout">
                        <tbody>
                            <tr>
                                <td style="width: 10%;"></td>
                                <td style="width: 40%;"></td>
                                <td style="width: 10%;"></td>
                                <td style="width: 40%;"></td>
                            </tr>
                            <tr>
                                <td>Mã phiếu
                                </td>
                                <td>
                                    <div class="workitemcontrol">
                                        <div class="combo tree drop short-control-30">
                                            <div class="wrap">
                                                <asp:Literal ID="txtMaPhieu" runat="server"></asp:Literal>
                                            </div>

                                        </div>
                                    </div>
                                </td>
                                <td>Ngày nhập
                                </td>
                                <td>
                                    <div class="workitemcontrol">
                                        <div class="combo tree drop short-control-50">
                                            <div class="wrap">
                                                <asp:Literal ID="txtNgayNhap" runat="server"></asp:Literal>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>Nhà cung cấp</td>
                                <td colspan="3">
                                    <div class="workitemcontrol">
                                        <div class="combo tree drop">
                                            <div class="wrap">
                                                <asp:Literal ID="txtTenNhaCungCap" runat="server" />
                                            </div>
                                        </div>
                                    </div>
                                </td>

                            </tr>
                            <tr>
                                <td>Tính chất nhập xuất</td>
                                <td>
                                    <div class="workitemcontrol">
                                        <div class="short-control-50">
                                            <div class="wrap" style="display: block">
                                                <asp:Literal ID="ddlTinhChat" runat="server"></asp:Literal>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td>Kho chứa</td>
                                <td>
                                    <div class="workitemcontrol">
                                        <div class="combo tree drop short-control-50">
                                            <div class="wrap">
                                                <asp:Literal ID="txtKhoChua" runat="server"></asp:Literal>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>Theo phiếu xuất:</td>
                                <td>
                                    <div class="workitemcontrol">
                                        <div class="combo tree drop short-control-50">
                                            <div class="wrap">
                                                <label id="txtTheoPhieuXuat" runat="server" />
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <asp:Literal ID="ltTinhTrang" runat="server" Text="Tình trạng"></asp:Literal></td>
                                <td>
                                    <asp:Label ID="lblTinhTrang" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>Ghi chú
                                </td>
                                <td colspan="3">
                                    <asp:Literal ID="txtGhiChu" runat="server"></asp:Literal>
                                    <%--<asp:TextBox TextMode="MultiLine" ID="txtGhiChu" runat="server" CssClass="text-area" Enabled="false"></asp:TextBox>--%>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4"></td>
                            </tr>
                        </tbody>
                    </table>
                    <asp:Panel runat="server" ID="pnChiTietVatTu">
                        <div id="" class="div-data">
                            <table class="data-table tab-detail" id="tabDanhSachPhieuNhapVatTu">
                                <thead>
                                    <tr>
                                        <td>STT</td>
                                        <td>Mã cuộn</td>
                                        <td>Mã VT</td>
                                        <td>Tên VT</td>
                                        <td>ĐV Tính</td>
                                        <td>Giá nhập</td>
                                        <td>SL thực nhập</td>
                                        <td>SL đầu cuộn</td>
                                        <td>SL làm phiếu</td>
                                        <td>ĐL tiêu chuẩn</td>
                                        <td>ĐL thực tế</td>
                                        <td>KT tiêu chuẩn</td>
                                        <td>KT thực tế</td>
                                        <td>Chênh lệch ĐL</td>
                                        <td>ĐL tính trừ</td>
                                        <td>Trừ KT</td>
                                        <td>KL trừ</td>
                                        <td>Trừ lõi</td>
                                        <td>SL chênh lệch không tính</td>
                                        <td>Thành tiền</td>
                                        <td>Chức năng</td>
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
<div id="content_div" title="Xem chi tiết vật tư nhập">
</div>

<script type="text/ecmascript">
    function CloseModal() {
        $("#content_div").dialog("close");
    }
</script>
