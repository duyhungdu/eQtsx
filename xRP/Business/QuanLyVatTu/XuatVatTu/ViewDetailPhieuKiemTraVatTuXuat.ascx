<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ViewDetailPhieuKiemTraVatTuXuat.ascx.cs" Inherits="xRP.Business.QuanLyVatTu.XuatVatTu.ViewDetailPhieuKiemTraVatTuXuat" %>
<%@ Register Src="~/Business/QuanLyVatTu/XuatVatTu/AddOrEditChiTietPhieuKiemTraVatTuXuat.ascx" TagPrefix="uc1" TagName="AddOrEditChiTietPhieuKiemTraVatTuXuat" %>

<script type="text/javascript">
    var dataChiTiet = [];
    var dataVatTu = [];
    var isEditable = false;
    $(document).ready(function () {
        dataVatTu = JSON.parse('<%=DataVatTu%>');
        var phieuNhapData = "";

        new PhieuXuat({ itemID: parseInt("<%=ID_PhieuXuat%>") }).getChiTietPhieuXuat(function (result) {
            for (var i = 0; i < result.length; i++) {
                dataChiTiet.push(new VatTuXuat(result[i]));
            }
            bindDataChiTiet(dataChiTiet);
        });

        $("#btnCancel").on("click", function () {
            window.location.href = "<%=Util.SERVER_NAME %>/Business/QuanLyVatTu/Default.aspx?page=pktx";
        });

        $("#btnPrint").click(function () {
            window.location.href = "<%= Util.SERVER_NAME%>/Business/QuanLyVatTu/Default.aspx?page=ppx&id=<%= ID_PhieuXuat %>";
        });

    });

    function bindDataChiTiet(dataChiTiet) {
        $("#tabDanhSachPhieuXuatVatTu tbody").text("");
        for (var i = 0; i < dataChiTiet.length; i++) {
            $("#tabDanhSachPhieuXuatVatTu tbody").append("<tr><td class='center-col'>" + (i + 1) + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.MaHieuVatTu + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.TenVatTu + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.DonViTinh + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.SoLuongDauCuon + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.SoLuongLamPhieuXuat + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.DinhLuongTieuChuan + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.DinhLuongThucTe + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.KichThuocTieuChuan + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.KichThuocThucTe + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.SoLuongThucXuat + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.DonGia + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].data.ThanhTien + "</td>" +
                "<td class='center-col'>" +
                '<a class="edit-icon" href="javascript:OpenChiTietVatTu(\'' + dataChiTiet[i].data.ID + '\',\'' + dataChiTiet[i].data.RandomID + '\');"></a>'
                + "</td>"
                + "</tr>");
        }
    }


    function OpenChiTietVatTu(id, randID) {
        //$("#content_div").prop('title', 'Chỉnh sửa chi tiết vật tư nhập: ' + id);
        LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Business/QuanLyVatTu/XuatVatTu/AddOrEditChiTietPhieuKiemTraVatTuXuat.ascx", "&id=" + randID);
            var title = "Xem chi tiết vật tư xuất";
            $("#content_div").dialog({ modal: true, width: 920, height: 500, title: title });
        }
        function CloseModal() {
            $("#content_div").dialog("close");
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
                            <input type="button" class="menu-bar-item-button icon cancel-icon" id="btnCancel" title="Thoát lưu dữ liệu" />
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
                                <td>Ngày xuất
                                </td>
                                <td>
                                    <div class="workitemcontrol">
                                        <div class="combo tree drop short-control-50">
                                            <div class="wrap">
                                                <asp:Literal ID="txtNgayXuat" runat="server"></asp:Literal>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>Tính chất nhập xuất</td>
                                <td>
                                    <div class="workitemcontrol">
                                        <div class="combo tree drop short-control-50">
                                            <div class="wrap" style="display: block">
                                                <asp:Literal ID="ddlTinhChat" runat="server"></asp:Literal>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td>Kho xuất</td>
                                <td>
                                    <div class="workitemcontrol">
                                        <div class="combo tree drop short-control-50">
                                            <div class="wrap">
                                                <asp:Label ID="lblKhoChua" runat="server" Text=""></asp:Label>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td><span id="lblKhachHang" runat="server" /></td>
                                <td colspan="3">
                                    <div class="workitemcontrol">
                                        <div class="combo tree drop">
                                            <div class="wrap">
                                                <asp:Literal ID="txtKhachHang" runat="server" />
                                            </div>
                                        </div>
                                    </div>
                                </td>

                            </tr>
                            <asp:Panel ID="rKhoDen" runat="server">
                                <tr id="rowKhoDen">
                                    <td><span id="lblKhoDen" runat="server" /></td>
                                    <td>
                                        <div class="workitemcontrol">
                                            <div class="combo tree drop short-control-50">
                                                <div class="wrap">
                                                    <asp:TextBox ID="txtKhoDen" runat="server"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td></td>
                                    <td></td>
                                </tr>
                            </asp:Panel>
                            <tr>
                                <td>Ghi chú</td>
                                <td colspan="3">
                                    <asp:Literal ID="txtGhiChu" runat="server" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <asp:Panel runat="server" ID="pnChiTietVatTu">
                        <div id="" class="div-data">
                            <table class="data-table tab-detail" id="tabDanhSachPhieuXuatVatTu">
                                <thead>
                                    <tr>
                                        <td>STT</td>
                                        <td>Mã VT</td>
                                        <td>Tên VT</td>
                                        <td>Đơn vị tính</td>
                                        <td>SL đầu cuộn</td>
                                        <td>SL làm PX</td>
                                        <td>ĐL tiêu chuẩn</td>
                                        <td>ĐL thực tế</td>
                                        <td>Kích thước TC</td>
                                        <td>Kích thước TT</td>
                                        <td>SL thực xuất</td>
                                        <td>Giá xuất</td>
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
        <div class="clear"></div>
    </div>
</div>
<div id="content_div" title="Thêm mới vật tư xuất">
</div>

<script type="text/ecmascript">
    function CloseModal() {
        $("#content_div").dialog("close");
    }
    $(function () {
        $("#btn-tao-moi-chi-tiet-kiem-tra-vat-tu-xuat").click(function () {
            $("#content_div").prop('title', 'Thêm mới vật tư xuất');
            LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Business/QuanLyVatTu/XuatVatTu/AddOrEditChiTietPhieuKiemTraVatTuXuat.ascx", "&id=;");
            $("#content_div").dialog({ modal: true, width: 800, height: 500 });
        });
    });
</script>
