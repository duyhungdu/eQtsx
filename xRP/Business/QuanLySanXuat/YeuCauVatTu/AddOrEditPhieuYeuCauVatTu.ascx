<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddOrEditPhieuYeuCauVatTu.ascx.cs" Inherits="xRP.Business.QuanLySanXuat.YeuCauVatTu.AddOrEditPhieuYeuCauVatTu" %>

<%@ Register Assembly="CollectionPager" Namespace="SiteUtils" TagPrefix="cc1" %>
<script type="text/javascript">
    function formatNumber(num, tp) {
        if ($.isNumeric(num)) {
            num = parseFloat(num);
            var tpInput = 2;
            if (tp != null && $.isNumeric(tp) && tp >= 0)
                tpInput = tp;

            var p = num.toFixed(tpInput).split(".");

            if (tpInput == 0)
                return p[0].split("").reverse().reduce(function (acc, num, i, orig) {
                    return num + (i && !(i % 3) ? "." : "") + acc;
                }, "");
            else
                return p[0].split("").reverse().reduce(function (acc, num, i, orig) {
                    return num + (i && !(i % 3) ? "." : "") + acc;
                }, "") + "," + p[1];

        }
        return 0;
    }
    var dataChiTiet = [];
    var dataVatTu = [];
    $(function () {

        $('#<%=txtNgaySuDung.ClientID%>').datetimepicker({
            mask: '99/99/9999', timepicker: false,
            format: 'd/m/Y'
        });
        $('.date').mask('00/00/0000');

        dataVatTu = JSON.parse('<%=DataVatTu%>');

        new PhieuYeuCauVatTu({ itemID: parseInt("<%=phieuYeuCauID%>") }).getPhieuYeuCauVatTuChiTiet(function (result) {
            for (var i = 0; i < result.length; i++) {
                var dataPhieuYeuCauVatTuChiTiet = new PhieuYeuCauVatTuChiTiet(result[i]);
                dataPhieuYeuCauVatTuChiTiet.data.RandomID = generateUUID();
                dataChiTiet.push(dataPhieuYeuCauVatTuChiTiet);
            }

            //console.log(dataChiTiet);
            bindDataChiTiet(dataChiTiet);
        });

        $("#btn-luu").click(function () {
            savePhieuNhap();
            return false;
        });


        $("#btn-luu-print").click(function () {
            savePhieuNhap(true);
            return false;
        });

        $("#btnPrint").click(function () {
            window.location.href = "<%=Util.SERVER_NAME %>/Business/QuanLySanXuat/Default.aspx?page=inpycvt&phieuYeuCauVatTuId=<%=phieuYeuCauID%>";
        });

    });
    function duyetPhieuNhap(id) {
        new PhieuNhap({
            itemID: id
        }).duyetPhieuNhap();
    }
    function savePhieuNhap(print) {
        try {
            if (!confirm("Bạn có chắc muốn lưu thông tin phiếu yêu cầu vật tư không?")) {
                return;
            }
            var data = new Object();
            var idPhieu = "<%=phieuYeuCauID%>";

            if (!$.isNumeric(idPhieu)) idPhieu = 0;

            data.itemID = parseInt(idPhieu);
            data.ID = parseInt(idPhieu);
            data.IDDonViYeuCau = 1;
            if (data.MaHieuThamChieu == "") {
                alert("Bạn chưa nhập mã phiếu.");
                $("#<%=txtMaHieuThamChieu.ClientID%>").focus();
                return;
            }
            data.MaHieuThamChieu = $("#<%=txtMaHieuThamChieu.ClientID%>").val().trim();
            data.NgaySuDung = $("#<%=txtNgaySuDung.ClientID%>").val();
            data.TinhTrang = parseInt("<%=CurrentTinhTrang%>");
            data.Mota = $("#<%=txtMoTa.ClientID%>").val();


            var yeuCauVatTuChiTiet = new Array();

            for (var i = 0; i < dataChiTiet.length; i++) {
                var obj = new Object();
                obj.ID = dataChiTiet[i].data.ID;
                obj.IDPhieuYeuCauVatTu = dataChiTiet[i].data.IDPhieuYeuCauVatTu;
                obj.IDVatTu = dataChiTiet[i].data.IDVatTu;
                obj.IDMathang = dataChiTiet[i].data.IDMathang; 
                obj.IDDonViTinh = dataChiTiet[i].data.IDDonViTinh;
                obj.SoLuongYeuCau = dataChiTiet[i].data.SoLuongYeuCau;
                obj.GhiChu = dataChiTiet[i].data.GhiChu;
                obj.TinhTrang = dataChiTiet[i].data.TinhTrang;
                yeuCauVatTuChiTiet.push(obj);
            }


            console.log(yeuCauVatTuChiTiet);

            data.lsPhieuYeuCauVatTuChiTiet = JSON.stringify(yeuCauVatTuChiTiet);

            var phieuYeuCauVatTu = new PhieuYeuCauVatTu(data);

            phieuYeuCauVatTu.saveAndChiTiet(function (result) {
                console.log(result);
                if ($.isNumeric(result.d)) {
                    if (print)
                        window.location.href = "<%=Util.SERVER_NAME %>/Business/QuanLySanXuat/Default.aspx?page=inpycvt&lenhSanXuatId=" + result;
                    else
                        window.location.href = "<%=Util.SERVER_NAME %>/Business/QuanLySanXuat/Default.aspx?page=lsx&cd=<%= congDoanId%>";

                } else {
                    alert('Có lỗi trong quá trình cập nhật yêu cầu vật tư \n' + result.d);
                }
            });

        } catch (e) { }
    }

    function OpenYeuCauVatTuChiTiet(id, ranId) {
        var phieuYeuCauVatTuId = '<%=phieuYeuCauID%>';
        LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Business/QuanLySanXuat/YeuCauVatTu/AddOrEditPhieuYeuCauVatTuChiTiet.ascx", "&id=" + id + "&randID=" + ranId + "&phieuyeucauid=" + phieuYeuCauVatTuId);
        var title = (id == "0" ? "Thêm mới" : "Chỉnh sửa") + " phiếu yêu cầu vật tư chi tiết";
        $("#content_div").dialog({ modal: true, width: 750, height: 300, title: title });
    }
    function CloseModal() {
        $("#content_div").dialog("close");
    }

    function deleteYeuCauVatTuChiTiet(mavattu) {
        if (!confirm("Bạn có chắc muốn xóa yêu cầu vật tư chi tiết này không?")) return;

        var phieuYeuCauVatTuChiTiet;
        for (var i = 0; i < dataChiTiet.length; i++) {
            if (dataChiTiet[i].data.RandomID == mavattu) {

                phieuYeuCauVatTuChiTiet = dataChiTiet[i];
                dataChiTiet.splice(i, 1);
                phieuYeuCauVatTuChiTiet.markDelete(function (result) {
                    alert("Đã xóa yêu cầu vật tư chi tiết.")
                    bindDataChiTiet(dataChiTiet);
                });

                break;
            }
        }
    }

    function bindDataChiTiet(dataChiTiet) {
        var phieuYeuCauID = 0;
        $("#tabDanhSachPhieuNhapVatTu tbody").text("");
        for (var i = 0; i < dataChiTiet.length; i++) {
            //console.log(dataChiTiet[i].data)
            $("#tabDanhSachPhieuNhapVatTu tbody").append("<tr><td class='center-col'>" + (i + 1) + "</td>" +
                //"<td class='center-col'>" + dataChiTiet[i].data.MaCuon + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.MaHieuVatTu + "</td>" +
                "<td >" + dataChiTiet[i].data.MaHieuVatTu + ' - ' + dataChiTiet[i].data.TenVatTu + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.DonViTinh + "</td>" +
                "<td class='center-col'>" + formatNumber(dataChiTiet[i].data.SoLuongYeuCau, 0) + "</td>" +
                //"<td class='center-col'>" + dataChiTiet[i].data.NguoiTao + "</td>" +
                //"<td class='center-col'>" + dataChiTiet[i].data.NgayTao + "</td>" +
                "<td class='center-col'>" +
                '<a class="edit-icon" href="javascript:OpenYeuCauVatTuChiTiet(\'' + dataChiTiet[i].data.ID + '\',\'' + dataChiTiet[i].data.RandomID + '\');"></a>' +
                '<a class="delete-icon" href="javascript:deleteYeuCauVatTuChiTiet(\'' + dataChiTiet[i].data.RandomID + '\');"></a>'
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
                        <li class="menu-item icon-only">
                            <%-- <asp:Button ToolTip="Lưu" CssClass="menu-bar-item-button icon icon-save" runat="server" ID="btnSave" />--%>
                            <input type="button" id="btn-luu" tooltip="Lưu" class="menu-bar-item-button icon icon-save" />
                        </li>
                        <li class="menu-item icon-only">
                            <input type="button" id="btn-luu-print" tooltip="Lưu và In" class="menu-bar-item-button icon icon-save-printer" />
                            <%--   <asp:Button ToolTip="Lưu và In" CssClass="menu-bar-item-button icon icon-save-printer" runat="server" ID="btnSavePrint" />--%>
                        </li>
                        <asp:Literal ID="ltPrint" runat="server"></asp:Literal>
                        <asp:Literal ID="ltAccept" runat="server"></asp:Literal>

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
                                <td>Mã phiếu tham chiếu
                                </td>
                                <td>
                                    <div class="workitemcontrol">
                                        <div class="combo tree drop short-control-30">
                                            <div class="wrap">
                                                <input type="text" class="disable-textbox" readonly="true" id="txtMaHieuThamChieu" autocomplete="off" maxlength="255" title="CNS" runat="server" />
                                            </div>

                                        </div>
                                    </div>
                                </td>
                                <td>Ngày sử dụng
                                </td>
                                <td>
                                    <div class="workitemcontrol">
                                        <div class="combo tree drop short-control-50">
                                            <div class="wrap">
                                                <input type="text" id="txtNgaySuDung" autocomplete="off" maxlength="255" title="Ngày sử dụng" runat="server" />
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <%-- <td>Nhà cung cấp</td>
                                <td>
                                    <div class="workitemcontrol">
                                        <div class="combo tree drop">
                                            <div class="wrap">
                                                <asp:HiddenField ID="slcTenNhaCungCap" runat="server" ClientIDMode="Static" />
                                                <input type="text" id="txtTenNhaCungCap" autocomplete="off" maxlength="255" title="CNS" runat="server" />
                                            </div>
                                        </div>
                                    </div>
                                </td>--%>
                                <td>Tình trạng</td>
                                <td>
                                    <asp:Label ID="lblTinhTrang" runat="server" Text=""></asp:Label>
                                    <%-- <input type="hidden" id="txtTinhTrang" autocomplete="off" maxlength="255" title="Tình trạng" runat="server" />--%>
                                    <asp:HiddenField ID="slcTinhTrang" runat="server" ClientIDMode="Static" />
                                    <%--<asp:Literal ID="ltTinhTrang" runat="server" Text="Tình trạng"></asp:Literal>--%>

                                </td>
                            </tr>

                            <tr>
                                <td>Mô tả
                                </td>
                                <td colspan="3">
                                    <asp:TextBox TextMode="MultiLine" ID="txtMoTa" runat="server" CssClass="text-area"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4"></td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="work-item-bonus">
                        <asp:Literal ID="ltButtonNewChiTietVatTuNhap" runat="server"></asp:Literal>
                    </div>
                    <asp:Panel runat="server" ID="pnChiTietVatTu">
                        <div id="" class="div-data">
                            <table class="data-table tab-detail" id="tabDanhSachPhieuNhapVatTu">
                                <thead>
                                    <tr>
                                        <td>STT</td>
                                        <td>Mã hiệu vật tư</td>
                                        <td>Tên vật tư</td>
                                        <td>Đơn vị tính</td>
                                        <td>Số lượng yêu cầu</td>
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
<div id="content_div" title="Thêm mới chi tiết vật tư nhập">
</div>

<script type="text/ecmascript">
    function CloseModal() {
        $("#content_div").dialog("close");
    }
    $(function () {
        var phieuYeuCauID = '<%=phieuYeuCauID%>';



        $("#btn-tao-moi-chi-tiet-kiem-tra-vat-tu-nhap").click(function () {
            /*if (!$("#<_%=slcTenNhaCungCap.ClientID%>").val()) {
                alert("Bạn chưa chọn nhà cung cấp");
                return;
            }*/

            var ranId = generateUUID();
            $("#content_div").prop('title', 'Thêm mới phiếu yêu cầu vật tư chi tiết');
            LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Business/QuanLySanXuat/YeuCauVatTu/AddOrEditPhieuYeuCauVatTuChiTiet.ascx", "&id=" + 0 + "&randID=" + ranId + "&phieuyeucauid=" + phieuYeuCauID);
            $("#content_div").dialog({ modal: true, width: 750, height: 300, title: 'Thêm mới phiếu yêu cầu vật tư chi tiết' });
        });

    });
</script>
