<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MainBox.ascx.cs" Inherits="xRP.Business.Home.MainBox" %>
<%@ Register Assembly="CollectionPager" Namespace="SiteUtils" TagPrefix="cc1" %>
<style type="text/css">
    .grid-cell-item {
        padding-bottom: 5px !important;
    }
</style>
<div class="hub-view home-view">
    <div class="hub-content">
        <div class="tfs-unsupported-browser-notification"></div>
        <div class="tfs-host-notifications&#32;tfs-upgrade-notification">
        </div>
        <div class="responsive-grid-container">
            <div class="responsive-grid">
                <div class="section1">
                    <div class="grid-cell" style="width: 640px; height: 160px;">
                        <div id="13" class="account-home-view-about-tfs-panel">
                            <ul class="grid-list">
                                <li class="grid-cell-title"><span class="cell-title">Bàn làm việc</span></li>
                                <table class="hgrid-table">
                                    <tbody>
                                        <tr class="hgrid-row">
                                            <td class="hgrid-cell-item">
                                                <div class="grid-cell-bgfill DefaultTileClass">
                                                    <a href="javascript:void(0);window.location='/Business/QuanLyVatTu/Default.aspx?page=null';">
                                                        <div class="grid-cell-content"><span class="grid-cell-item-title">Quản lý vật tư</span><span class="grid-cell-item-subTitle"></span></div>
                                                        <span class="icon icon-arrow-forward"></span></a>
                                                </div>
                                            </td>
                                            <td class="hgrid-cell-item">
                                                <div class="grid-cell-bgfill DefaultTileClass">
                                                    <a href="javascript:void(0);window.location='/Administrator/QuanLyDonHang/DonHang/default.aspx?page=dsdonhang'">
                                                        <div class="grid-cell-content"><span class="grid-cell-item-title">Quản lý đơn hàng</span><span class="grid-cell-item-subTitle"></span></div>
                                                        <span class="icon icon-arrow-forward"></span></a>
                                                </div>
                                            </td>
                                            <td class="hgrid-cell-item">
                                                <div class="grid-cell-bgfill DefaultTileClass">
                                                    <a
                                                        href="javascript:void(0);window.location='/Business/QuanLySanXuat/Default.aspx?page=lsx'">
                                                        <div class="grid-cell-content"><span class="grid-cell-item-title">Quản lý sản xuất</span><span class="grid-cell-item-subTitle"></span></div>
                                                        <span class="icon icon-arrow-forward"></span></a>
                                                </div>
                                            </td>
                                            <td class="hgrid-cell-item">
                                                <div class="grid-cell-bgfill DefaultTileClass">
                                                    <a
                                                        href="javascript:void(0);window.location='/Administrator/QuanLyHeThong/Default.aspx?page=department'">
                                                        <div class="grid-cell-content"><span class="grid-cell-item-title">Quản trị hệ thống</span><span class="grid-cell-item-subTitle"></span></div>
                                                        <span class="icon icon-arrow-forward"></span></a>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </ul>
                        </div>
                    </div>
                    <div class="grid-cell" style="width: 640px;">
                        <div id="14" class="account-home-view-team-project-panel">
                            <ul class="grid-list">
                                <li class="grid-cell-title"><span class="cell-title">Cảnh báo vật tư</span>
                                    <a class="actionlink view-all-news" href="/Administrator/QuanLyVatTu/VatTu/default.aspx?page=dmvt&cbtk=1">Xem tất cả</a></li>

                                <div class="no-item-message" style="text-align: justify; line-height: 18px;">
                                    <style type="text/css">
                                        .canh_bao_vat_tu {
                                            width: 100%;
                                        }

                                            .canh_bao_vat_tu thead tr td {
                                                text-align: center;
                                                font-weight: bold;
                                                padding: 5px 3px;
                                            }

                                            .canh_bao_vat_tu tbody tr td {
                                                padding: 3px 3px;
                                            }
                                    </style>
                                    <table class="canh_bao_vat_tu">
                                        <thead>
                                            <tr>
                                                <td>STT</td>
                                                <td>Mã vật tư</td>
                                                <td>Tên vật tư</td>
                                                <td>Tồn tối thiểu</td>
                                                <td>Tồn thực tế</td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <asp:Literal ID="ltTest" runat="server"></asp:Literal>
                                            <asp:Repeater ID="rptCanhBaoTonKho" runat="server">
                                                <ItemTemplate>
                                                    <tr>
                                                        <td style="text-align: center;"><%#Container.ItemIndex+1 %></td>
                                                        <td><%#Eval("MaHieuVatTu") %></td>
                                                        <td><%#Eval("TenVatTu") %></td>
                                                        <td style="text-align: center;"><%#Eval("SoLuongTonToiThieu") %></td>
                                                        <td style="text-align: center;"><%#Eval("SoLuongTon") %></td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>


                                        </tbody>
                                    </table>
                                </div>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="section2" style="width: 320px;">
                    <div class="grid-cell" style="width: 320px;">
                        <div id="25" class="account-home-view-news-panel">
                            <ul class="grid-list">
                                <li class="grid-cell-title"><span class="cell-title">Đơn hàng mới</span>
                                    <a class="actionlink view-all-news" href="javascript:void(0);javascript:void(0);window.location='/Administrator/QuanLyDonHang/DonHang/default.aspx?page=dsdonhang'" target="_blank">Xem tất cả</a></li>
                                <asp:Repeater ID="rptDonHang" runat="server">
                                    <ItemTemplate>
                                        <li class="grid-cell-item">
                                            <span class="grid-cell-item-text">
                                                <span>
                                                    <div class="grid-cell-item-title">
                                                        <a style="display: block" title="- Mã đơn hàng <%# Eval("MaHieuDonHang") %>" href="javascript:void(0);window.location='/Administrator/QuanLyDonHang/Default.aspx?page=ppdathhang&id=<%# Eval("ID") %>'">- Mã đơn hàng: <%# Eval("MaHieuDonHang") %> </a>
                                                    </div>
                                                    <span title="" class=""></span>
                                                    <span class="grid-cell-item-subTitle">- Khách hàng: đơn hàng của <%# Eval("TenKhachHang") %></span>
                                                    <span title="" class=""></span>
                                                    <span class="grid-cell-item-subTitle">- Người tạo:  <%# Eval("UserName") %></span>
                                                    <span class="grid-cell-item-subTitle">- Ngày đặt hàng: <%# string.Format("{0:dd/MM/yyyy}",Eval("NgayDatHang")) %>
                                                    </span>
                                                </span>
                                            </span>
                                        </li>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </ul>
                        </div>
                        <div class="work-item-view-pager">
                            <cc1:CollectionPager ID="colPageDonHang" runat="server" PageSize="10" PagingMode="QueryString"
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
                <div class="section3">
                    <div class="grid-cell" style="width: 320px;">
                        <div id="27" class="account-home-view-news-panel">
                            <ul class="grid-list">
                                <li class="grid-cell-title">
                                    <span class="cell-title">Phiếu nhập vật tư mới</span>
                                    <a class="actionlink view-all-news" href="javascript:void(0);window.location='/Business/QuanLyVatTu/Default.aspx?page=pktn'" target="_blank">Xem tất cả</a></li>
                                <asp:Repeater ID="rptDanhMucNhapVatTu" runat="server">
                                    <ItemTemplate>
                                        <li class="grid-cell-item">
                                            <span class="grid-cell-item-text">
                                                <span>
                                                    <div class="grid-cell-item-title">
                                                        <a style="display: block" title="- Mã phiếu nhập: <%# Eval("MaHieuPhieuNhap") %>" href="javascript:void(0);window.location='/Business/QuanLyVatTu/Default.aspx?page=ppn&id=<%# Eval("ID") %>'">- Mã phiếu nhập: <%# Eval("MaHieuPhieuNhap") %></a>
                                                    </div>
                                                    <span title="" class=""></span>
                                                    <span class="grid-cell-item-subTitle">- Nhà cung cấp: <%# ((xRPDAL.Sp_Qlvt_PhieuNhap_SelectResult)Container.DataItem).TenNhaCungCap%></span>
                                                    <span title="" class=""></span>
                                                    <span class="grid-cell-item-subTitle">- Người tạo:  <%# Eval("UserName") %></span>
                                                    <span class="grid-cell-item-subTitle">- Ngày giờ tạo:<%-- <%#Util.FormatDateTime(Eval("NgayTao")) %>--%>
                                                        <%# string.Format("{0:dd/MM/yyyy}",Eval("NgayTao")) %> | <%# string.Format("{0:HH:mm:ss}",Eval("NgayTao")) %> 
                                                    </span>
                                                </span>
                                            </span>
                                        </li>
                                    </ItemTemplate>
                                </asp:Repeater>


                            </ul>
                            <ul class="grid-list">
                                <li class="grid-cell-title">
                                    <span class="cell-title">Phiếu xuất vật tư mới</span>
                                    <a class="actionlink view-all-news" href="javascript:void(0);window.location='/Business/QuanLyVatTu/Default.aspx?page=pktx'" target="_blank">Xem tất cả</a></li>
                                <asp:Repeater ID="rptDanhMucXuatVatTu" runat="server">
                                    <ItemTemplate>
                                        <li class="grid-cell-item">
                                            <span class="grid-cell-item-text">
                                                <div class="grid-cell-item-title">
                                                    <a style="display: block" title="- Mã phiếu xuất: <%# Eval("MaHieuPhieuXuat") %>" href="javascript:void(0);window.location='/Business/QuanLyVatTu/Default.aspx?page=pktx&id=<%# Eval("ID") %>'">- Mã phiếu xuất: <%# Eval("MaHieuPhieuXuat") %></a>
                                                </div>
                                                <span title="" class=""></span>
                                                <span class="grid-cell-item-subTitle">- Nhà cung cấp: <%# ((xRPDAL.Sp_Qlvt_PhieuXuat_SelectResult)Container.DataItem).TenDonVi%></span>
                                                <span title="" class=""></span>
                                                <span class="grid-cell-item-subTitle">- Người tạo:  <%# Eval("UserName") %></span>
                                                <span class="grid-cell-item-subTitle">- Ngày giờ tạo: <%# string.Format("{0:dd/MM/yyyy}",Eval("NgayTao")) %> | <%# string.Format("{0:HH:mm:ss}",Eval("NgayTao")) %> 
                                                </span>
                                            </span>
                                        </li>
                                    </ItemTemplate>
                                </asp:Repeater>


                            </ul>
                        </div>
                        <div class="paging">
                            <cc1:CollectionPager ID="colPageNhapVatTu" runat="server" PageSize="10" PagingMode="QueryString"
                                QueryStringKey="trang" BackText="Trước"
                                FirstText="Đầu" LastText="Cuối" NextText="Sau"
                                LabelText="" PageNumbersSeparator="&amp;nbsp;&amp;nbsp;" PageNumbersStyle="color:#ea1111;font-size:12px;padding:5px;"
                                PageNumberStyle="color:#555;padding:3px 8px;border:solid 1px #ccc;" ResultsLocation="Bottom"
                                ResultsStyle="font-family:Arial;font-size:12px;text-align:right;margin-top:5px;"
                                ShowLabel="True" BackNextButtonStyle="border:none;background:red;" BackNextDisplay="HyperLinks"
                                BackNextLinkSeparator="&nbsp;&nbsp;-&nbsp;&nbsp;" ControlStyle="text-align:right;margin:5px;float:right;" BackNextLocation="Split" ResultsFormat="Hiển thị {0}-{1} (trong tổng số {2} bản ghi)" ShowFirstLast="True" ControlCssClass="paging_tool_bar" EnableViewState="False" MaxPages="10" SectionPadding="5" SliderSize="5">
                            </cc1:CollectionPager>
                            <cc1:CollectionPager ID="colPageXuatVatTu" runat="server" PageSize="10" PagingMode="QueryString"
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
        </div>
        <div class="account-home-view">
        </div>
    </div>
</div>
