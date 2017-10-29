<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="XuLyDonHang.ascx.cs" Inherits="xRP.Administrator.QuanLyDonHang.DonHang.XuLyDonHang.XuLyDonHang" %>


<script type="text/javascript">


    var dataChiTiet = [];
    var listDonViTinh = JSON.parse('<%=ListDonViTinh%>');
    $(function () {
        new DonHang({ ID: parseInt("<%=ID_DonHang%>") }).getChiTietHangHoa(function (result) {
            var dsHangHoa = [];
            for (var i = 0; i < result.length; i++) {
                var exist = false;
                for (var j = 0; j < dsHangHoa.length; j++) {
                    if (dsHangHoa[j].ID == result[i].ID)
                        exist = true;
                }
                if (!exist)
                    dsHangHoa.push(result[i]);
            }
            for (var i = 0; i < dsHangHoa.length; i++) {
                dsHangHoa[i].IDDonViTinh = dsHangHoa[i].IDDonVitinh;
                dataChiTiet.push(new MatHang(dsHangHoa[i]));
            }
            bindDataChiTiet(dataChiTiet);

        });
        $("#btn-reload").on("click", function () {
            window.location.href = "/Business/QuanLySanXuat/Default.aspx?page=dh";
        })
    });
    function huyxulymathang(id)
    {
        new MatHang({
            ID: id
        }).huyXuLy();
    }
    function TinhTrangText(status) {
        var data = '';
        if (status == null)
            return 'Chưa xử lý';
        var data = '';
        switch (status) {
            case 0: data = 'Chưa xử lý'; break;
            case 1: data = 'Đã xử lý'; break;
            default: data = 'Đã xử lý'; break;
        }
        return data;
    }
    function print() {
        window.location.href = "/Administrator/QuanLyDonHang/Default.aspx?page=ppdathhang&id=<%=ID_DonHang%>";
    }
    function TinhTrangFunction(status, id) {
        var data = '';
        if (status == null)
            return '<a href="/Business/QuanLySanXuat/Default.aspx?page=cdsx&mathangid=' + id + '" title="Xử lý hàng hóa"><span class="icon icon-kcs"></span><span class="text">Xử lý</span></a>';
        var data = '';
        switch (status) {
            case 0: data = '<a href="/Business/QuanLySanXuat/Default.aspx?page=cdsx&mathangid=' + id + '" title="Xử lý hàng hóa"><span class="icon icon-kcs"></span><span class="text">Xử lý</span></a>'; break;
            case 1: data = '<a href="javascript:huyxulymathang(' + id + ')" title="Hủy xử lý"><span class="icon delete-icon"></span><span class="text">Hủy xử lý</span></a>'; break;
            default: data = ''; break;
        }
        return data;
    }
    function bindDataChiTiet(dataChiTiet) {
        $("#tabDanhSachPhieuNhapVatTu tbody").text("");
        for (var i = 0; i < dataChiTiet.length; i++) {
            $("#tabDanhSachPhieuNhapVatTu tbody").append("<tr><td class='center-col'>" + (i + 1) + "</td>" +
                "<td>" + dataChiTiet[i].MaHieuMatHang.Value + "</td>" +
                "<td>" + dataChiTiet[i].TenMatHang.Value + "</td>" +
                "<td>" + dataChiTiet[i].SoLuong.Value + "</td>" +
                "<td class='center-col'>" + getDonViTinh(dataChiTiet[i].IDDonViTinh.Value).DonViTinh + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].ChieuDai.Value + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].ChieuRong.Value + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].ChieuCao.Value + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].LoaiKichThuoc.Value + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].TenLoaiSanPham.Value + "</td>" +
                "<td class='center-col' id='song_" + dataChiTiet[i].GUID + "'>" + dataChiTiet[i].TenLoaiSong.join(", ") + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].SoLuongMau.Value + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].ThanhTien.Value + "</td>" +
                 "<td class='center-col'>" + TinhTrangText(dataChiTiet[i].TinhTrang.Value) + "</td>" +
                "<td class='center-col'>" + TinhTrangFunction(dataChiTiet[i].TinhTrang.Value, dataChiTiet[i].ID.Value)
                + "</td>"
                + "</tr>");
            //getDSSong(dataChiTiet[i]);
        }
    }
    function getDonViTinh(id) {
        for (var i = 0; i < listDonViTinh.length; i++)
            if (listDonViTinh[i].ID == id)
                return listDonViTinh[i];
    }
    function getDSSong(item) {
        item.getDSSong(function (result) {
            var data = JSON.parse(result.d);
            for (var j = 0; j < data.length; j++) {
                $("#song_" + item.data.RandomID + "").text(
                       $("#song_" + item.data.RandomID + "").text() +
                       data[j].TenSong + ", "
                );
            }
        });
    }
    function xulydonhang() {
        queryData("/Business/QuanLySanXuat/Default.aspx/XuLyDonHang", "{IDDonHang:<%=ID_DonHang%>}", function (result) {
            window.location.href = "/Business/QuanLySanXuat/Default.aspx?page=dh";
        }, function () {

        }, false);
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
                    <div class="info-text-wrapper">
                        <span class="info-text">Xử lý đơn hàng 
                        <asp:Label ID="lblMaDonHang" runat="server"></asp:Label></span>
                    </div>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block">
                    <ul class="menu-bar">
                        <li class="menu-item icon-only" id="btn-print">
                            <asp:Button ToolTip="Lưu và In" CssClass="menu-bar-item-button icon icon-printer" runat="server" ID="btnSavePrint" OnClientClick="print(); return false;" />
                        </li>
                        <li class="menu-item icon-only" id="btn-reload"><span class="icon icon-undo"></span>
                        </li>
                    </ul>
                </div>
                <div class="work-item-view" style="display: block;">

                    <asp:Panel runat="server" ID="pnChiTietVatTu">
                        <div id="" class="div-data">

                            <table class="data-table tab-detail" id="tabDanhSachPhieuNhapVatTu">
                                <thead>
                                    <tr>
                                        <td style="width: 5%">STT</td>
                                        <td>Mã hàng</td>
                                        <td>Tên hàng</td>
                                        <td>SL</td>
                                        <td>ĐVT</td>
                                        <td>Dài</td>
                                        <td>Rộng</td>
                                        <td>Cao</td>
                                        <td>Loại KT</td>
                                        <td>Loại thùng</td>
                                        <td>Loại sóng</td>
                                        <td>SL màu</td>
                                        <td>Thành tiền</td>
                                        <td>Tình trạng</td>
                                        <td style="width: 100px;"></td>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="25"></td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </asp:Panel>

                </div>
            </div>
            <div class="work-item-view-pager">
            </div>
        </div>

    </div>
</div>
<%-- thử checkin --%>
