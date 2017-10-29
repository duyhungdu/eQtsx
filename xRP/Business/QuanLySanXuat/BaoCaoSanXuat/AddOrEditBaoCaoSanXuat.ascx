<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddOrEditBaoCaoSanXuat.ascx.cs" Inherits="xRP.Business.QuanLySanXuat.BaoCaoSanXuat.AddOrEditBaoCaoSanXuat" %>
<div class="splitter horizontal hub-splitter stateful toggle-button-enabled toggle-button-hotkey-enabled">
    <div class="rightPane" style="left: 0px;">
        <div class="hub-title">
        </div>
        <div class="right-hub-content">
            <div class="work-item-form">
                <div class="workitem-info-bar">
                    <div class="info-text-wrapper">
                        <span class="info-text">Báo cáo sản xuất</span>
                    </div>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block;">
                    <ul class="menu-bar">
                        <li class="menu-item icon-only" id="btn-luu">
                            <asp:Button ToolTip="Lưu" CssClass="menu-bar-item-button icon icon-save" runat="server" ID="btnSave" /></li>
                        <li class="menu-item icon-only" id="btn-luu-print">
                            <asp:Button ToolTip="Lưu và In" CssClass="menu-bar-item-button icon icon-save-printer" runat="server" ID="btnSavePrint" />
                        </li> 
                        <% if (false)
                           { %>
                        <li class="menu-item icon-only" id="btn-print">
                            <asp:Button ToolTip="In" CssClass="menu-bar-item-button icon icon-printer" runat="server" ID="btnPrint" /></li>
                        <% } %>
                        <li class="menu-item icon-only" id="btn-cancel">
                            <asp:Button ToolTip="Hủy" CssClass="menu-bar-item-button icon cancel-icon" runat="server" OnClick="btnCancel_Click" ID="btnCancel" /></li>
                    </ul>
                </div>
                <div class="work-item-view" style="margin-left: 10px;">


                    <div id="" class="div-data">
                        <table class="data-table tab-detail" id="tabCongDoan">
                            <thead>
                                <tr>
                                    <td>Mã ĐH</td>
                                    <td>Khách hàng</td>
                                    <td>Mã hàng</td>
                                    <td>Loại sóng</td>
                                    <td>KT Tâm</td>
                                    <td>Dài</td>
                                    <td>Rộng</td>
                                    <td>Cao</td>
                                    <td>Loại KT</td>
                                    <td>Loại hộp</td>
                                    <td>Tổng dao</td>
                                    <td>Xả</td>
                                    <td>Khổ giấy</td>
                                    <td>Chặt dài</td>
                                    <td>SL tấm</td>
                                    <td>SL hộp</td>
                                    <td>Cần SX</td>
                                    <td>SL SX</td>
                                    <td>SL hỏng</td>
                                    <td></td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="center-col">DH004</td>
                                    <td>Toàn Phát</td>
                                    <td>Thùng bế Icool line sets 50FT</td>
                                    <td class="center-col">3A2VD</td>
                                    <td class="center-col">1350x1350</td>
                                    <td class="center-col">1,200</td>
                                    <td class="center-col">65</td>
                                    <td class="center-col">1,200</td>
                                    <td class="center-col">KTN</td>
                                    <td class="center-col">Nắp trùm</td>
                                    <td class="center-col">1,330</td>
                                    <td class="center-col">1</td>
                                    <td class="center-col">K135</td>
                                    <td class="center-col">1,350</td>
                                    <td class="center-col">2,000</td>
                                    <td class="center-col">1,000</td>
                                    <td class="center-col">5000</td>
                                    <td class="center-col">
                                        <input type="text" style="width: 30px;" value="5000" /></td>
                                    <td class="center-col">
                                        <input type="text" style="width: 30px;" value="58" /></td>
                                    <td class="center-col"><a title="Go up" class="icon-up cns-icon"></a><a class="icon-down cns-icon" title="Go down"></a></td>
                                </tr>
                                <tr>
                                    <td class="center-col">DH001</td>
                                    <td>Dokyoung</td>
                                    <td>Phôi 5 lớp</td>
                                    <td class="center-col">5A2VT</td>
                                    <td class="center-col">1350x2030</td>
                                    <td class="center-col">560</td>
                                    <td class="center-col">430</td>
                                    <td class="center-col">320</td>
                                    <td class="center-col">KTN</td>
                                    <td class="center-col">Thường</td>
                                    <td class="center-col">755</td>
                                    <td class="center-col">2</td>
                                    <td class="center-col">K155</td>
                                    <td class="center-col">2030</td>
                                    <td class="center-col">150</td>
                                    <td class="center-col">300</td>
                                    <td class="center-col">1200</td>
                                    <td class="center-col">
                                        <input type="text" style="width: 30px;" value="1200" /></td>
                                    <td class="center-col">
                                        <input type="text" style="width: 30px;" value="17" /></td>
                                    <td class="center-col"><a title="Go up" class="icon-up cns-icon"></a><a class="icon-down cns-icon" title="Go down"></a></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>
        </div>

        <div class="clear"></div>
    </div>
</div>
