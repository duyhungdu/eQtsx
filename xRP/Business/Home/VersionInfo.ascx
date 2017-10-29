<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="VersionInfo.ascx.cs" Inherits="xRP.Business.Home.VersionInfo" %>
<style type="text/css">
    .version-info {
        width: 100%;
    }

        .version-info tr td {
            width: 100%;
            padding: 5px;
            vertical-align: top;
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
                    <div class="grid-cell" style="width: 640px;">
                        <div id="13" class="account-home-view-about-tfs-panel">
                            <ul class="grid-list">
                                <li class="grid-cell-title"><span class="cell-title">Thông tin phiên bản</span></li>
                            </ul>
                        </div>
                    </div>
                    <div class="grid-cell" style="width: 100%;">
                        <h3>Cập nhật lần cuối: <%=buildDate %>
                        </h3>
                        <%--<table class="version-info"><tr><td style="width: 25%;">Số hiệu:</td><td>1.0.0.25</td></tr><tr><td style="width: 25%;">Ngày cập nhật:</td><td>21/11/2014</td></tr><tr><td style="width: 25%;">Thông tin:</td><td><ul><li>Bổ sung thông tin phiên bản</li><li>Bổ sung quản trị hệ thống, nhật ký hệ thống</li><li>Bổ sung module xuất vật tư</li><li>Bổ sung HTML module quản lý bán hàng</li></ul></td></tr><tr><td style="width: 25%;">Phiên bản trước</td><td>1.0.0.24 (19/11/2014)</td></tr><tr><td colspan="2" style="padding-top:40px;"><a href="javascript:alert('Đang cập nhật');">Thông tin giấy phép</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:alert('Đang cập nhật');">Quyền hạn người dùng cuối</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:alert('Đang cập nhật');">Chính sách riêng tư</a>&nbsp;&nbsp;&nbsp;</td></tr><tr><td colspan="2" ><span style="color: #ccc; font-size: 11px; font-style: italic;">xRP và source code xRP là sản phẩm độc quyền của NVM</span></td></tr></table>--%>
                        <asp:Literal ID="ltThongTinPhienBan" runat="server"></asp:Literal>
                    </div>

                </div>
            </div>
        </div>
        <div class="account-home-view">
        </div>



    </div>
</div>
