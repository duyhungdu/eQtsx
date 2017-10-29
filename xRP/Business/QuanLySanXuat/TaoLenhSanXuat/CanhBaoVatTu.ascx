<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CanhBaoVatTu.ascx.cs" Inherits="xRP.Business.QuanLySanXuat.TaoLenhSanXuat.CanhBaoVatTu" %>
<style type="text/css">
    #tablesanxuat tbody tr td {
        padding: 3px;
    }

    #tabDanhSachPhieuNhapVatTu tbody tr td {
        padding: 5px !important;
    }

    #tabDanhSachPhieuNhapVatTu thead tr td {
        padding: 10px 0px !important;
    }

    .align-right {
        text-align: right;
    }

    input {
        padding: 0px 3px;
    }
   
</style>
<script type="text/javascript">
    $("#btTiepTuc").click(function () {
        var id = "<%=ID_YEUCAUSANXUAT%>";
        window.location.href = "<%=Util.SERVER_NAME%>/Business/QuanLySanXuat/Default.aspx?page=pavt&id=" + id;
    });
</script>
<div class="work-item-form">
    <div class="work-item-view" style="margin: 0px;" >
        <table class="witform-layout" id="tablesanxuat">
            <tbody>
                <tr>
                    <td style="width: 14%; padding: 0px !important;"></td>
                    <td style="width: 36%; padding: 0px !important;"></td>
                    <td style="width: 14%; padding: 0px !important;"></td>
                    <td style="width: 36%; padding: 0px !important;"></td>
                </tr>
                <tr>
                    <td colspan="4">
                        <b>THÔNG TIN MẶT HÀNG</b>
                    </td>
                </tr>
                <tr>
                    <td>Mã hàng:</td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ReadOnly="true" ID="txtMaHang" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>Tên hàng:</td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ReadOnly="true" ID="txtTenHang" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Thuộc đơn hàng:</td>
                    <td colspan="3">
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ReadOnly="true" ID="txtDonHang" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Ngày đặt hàng:</td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ReadOnly="true" ID="txtNgayDat" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>Ngày giao hàng:</td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ReadOnly="true" ID="txtNgayGiaoHang" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Loại sản phẩm:</td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ReadOnly="true" ID="txtLoaiSanPham" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>Số lượng đặt:</td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ReadOnly="true" CssClass="align-right" ID="txtSoLuongDat" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Loại kích thước:</td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ReadOnly="true" ID="txtLoaiKichThuoc" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>Kích thước:</td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ReadOnly="true" ID="txtKichThuoc" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <b>THÔNG TIN XỬ LÝ</b>
                    </td>
                </tr>
                <tr>
                    <td>Loại sóng:</td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ReadOnly="true" ID="txtLoaiSong" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>Số lớp:</td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ReadOnly="true" CssClass="align-right" ID="txtSoLop" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Tổng dao:</td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ReadOnly="true" CssClass="align-right" ID="txtTongDao" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>Chặt dài:</td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ReadOnly="true" CssClass="align-right" ID="txtChatDai" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Tai:</td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ReadOnly="true" CssClass="align-right" ID="txtTai" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>Lề:</td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ReadOnly="true" CssClass="align-right" ID="txtLe" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Khổ giấy:</td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ReadOnly="true" CssClass="align-right" ID="txtKhoGiay" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>Kích thước tấm:</td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ReadOnly="true" CssClass="align-right" ID="txtKichThuocTam" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Số lượng tấm:</td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ReadOnly="true" CssClass="align-right" ID="txtSoLuongTam" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>Số lượng hộp:</td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ReadOnly="true" CssClass="align-right" ID="txtSoLuongHop" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Diện tích xuất bán:</td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ReadOnly="true" CssClass="align-right" ID="txtDienTichXuatBan" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>Số lượng cần sản xuất:</td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ReadOnly="true" CssClass="align-right" ID="txtSoLuongSanXuat" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                 <tr>
                    <td colspan="4" style="padding: 10px 0px 0px 0px;">
                        <b>PHƯƠNG ÁN VẬT TƯ TỐI ƯU</b>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:Panel runat="server" ID="Panel1">
                            <div id="divdiv" class="div-data"  style="overflow-y:auto;" >
                                <table class="data-table tab-detail" id="tablepavt2">
                                    <thead>
                                        <tr>
                                            <td style="width: 30px">TT</td>
                                            <td style="width: 15%">Tên loại vật tư</td>
                                            <td style="width: 110px">Khổ giấy yêu cầu</td>
                                            <td style="width: 100px">Hệ số tiêu hao</td>
                                            <td>Vật tư đáp ứng yêu cầu</td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="rptPAVT2" runat="server">
                                            <ItemTemplate>
                                                <tr>
                                                    <td class="center-col"><%# Container.ItemIndex + 1 %></td>
                                                    <td><%#Eval("TenLoaiVatTu") %></td>
                                                    <td class="center-col"><%#Eval("KhoGiayYeuCau") %></td>
                                                    <td class="center-col"><%#Eval("TongHeSoTieuHao") %></td>
                                                    <td><%#Eval("VatTuThoaMan") %></td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </tbody>
                                </table>
                            </div>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td colspan="4" style="padding: 10px 0px 0px 0px;">
                        <b>PHƯƠNG ÁN VẬT TƯ TỔNG THỂ</b>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:Panel runat="server" ID="pnChiTietVatTu">
                            <div id="" class="div-data"  style="overflow-y:auto;min-height:300px;" >
                                <table class="data-table tab-detail" id="tabDanhSachPhieuNhapVatTu">
                                    <thead>
                                        <tr>
                                            <td style="width: 30px">TT</td>
                                            <td style="width: 15%">Tên loại vật tư</td>
                                            <td style="width: 110px">Khổ giấy yêu cầu</td>
                                            <td style="width: 100px">Hệ số tiêu hao</td>
                                            <td>Vật tư đáp ứng yêu cầu</td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="rptPhuongAnSanXuat" runat="server">
                                            <ItemTemplate>
                                                <tr>
                                                    <td class="center-col"><%# Container.ItemIndex + 1 %></td>
                                                    <td><%#Eval("TenLoaiVatTu") %></td>
                                                    <td class="center-col"><%#Eval("KhoGiayYeuCau") %></td>
                                                    <td class="center-col"><%#Eval("TongHeSoTieuHao") %></td>
                                                    <td><%#Eval("VatTuThoaMan") %></td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </tbody>
                                </table>
                            </div>
                        </asp:Panel>
                    </td>
                </tr>
            </tbody>
        </table>

    </div>
</div>
<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix button-list">
    <input id="btTiepTuc" type="button" class="xrp-button" value="In" />
    <input id="btQuayLai" type="button" class="xrp-button" value="Đóng" onclick="CloseModal()" />
</div>
