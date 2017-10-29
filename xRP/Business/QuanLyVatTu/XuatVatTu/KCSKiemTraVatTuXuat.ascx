<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="KCSKiemTraVatTuXuat.ascx.cs" Inherits="xRP.Business.QuanLyVatTu.XuatVatTu.KCSKiemTraVatTuXuat" %>

<script type="text/javascript">
    $(document).ready(function () {
        //$("#txtMaPhieu").focus();
        //document.getElementById("txtMaPhieu").focus();
        $("#<%=txtMaPhieu.ClientID%>").focus();
        $('#txtNgayNhap').datetimepicker({
            mask: '99/99/9999', timepicker: false,
            format: 'd/m/Y',
        });
    });
</script>

<div class="splitter horizontal hub-splitter stateful toggle-button-enabled toggle-button-hotkey-enabled">
    <div class="rightPane" style="left: 0px;">
        <div class="hub-title">
        </div>
        <div class="right-hub-content">
            <div class="work-item-form">
                 <div class="workitem-info-bar">
                    <div class="info-text-wrapper"><span class="info-text">
                        KSC phiếu xuất</span></div>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block;">
                    <ul class="menu-bar">
                        <li class="menu-item icon-only" id="btn-luu">
                            <asp:Button CssClass="menu-bar-item-button icon icon-save" runat="server" ID="btnSave" ToolTip="Lưu thông tin" /></li>
                        <li class="menu-item icon-only" id="btn-cancel">
                            <asp:Button CssClass="menu-bar-item-button icon cancel-icon" runat="server" ID="btnCancel" ToolTip="Thoát lưu dữ liệu" /></li>
                        <li class="menu-item icon-only" id="Li1">
                            <asp:Button CssClass="icon-printer" runat="server" ID="Button1" ToolTip="In dữ liệu" />
                            <%--<a title="In" class="icon-printer" href="javascript:void(0)" ></a>--%>

                        </li>
                    </ul>
                </div>
                <div class="work-item-view" style="margin-left: 10px;">

                    <table class="witform-layout">
                        <tbody>
                            <tr>
                                <td style="width: 15%;"></td>
                                <td style="width: 40%;"></td>
                                <td style="width: 10%;"></td>
                                <td style="width: 35%;"></td>
                            </tr>
                            <tr>
                                <td>Mã phiếu
                                </td>
                                <td>
                                   <%-- <div class="workitemcontrol">
                                        <div class="combo tree drop short-control-30">
                                            <div class="wrap">--%>
                                                <asp:TextBox ID="txtMaPhieu" runat="server" ToolTip="CNS"></asp:TextBox>
                                                <%--<input type="text" id="txtMaPhieu" autocomplete="off" maxlength="255" title="CNS" runat="server" />--%>
                                           <%-- </div>

                                        </div>
                                    </div>--%>
                                </td>
                                <td>Ngày nhập
                                </td>
                                <td>
                                   <%-- <div class="workitemcontrol">
                                        <div class="combo tree drop short-control-50">
                                            <div class="wrap">--%>
                                                <input type="text" id="txtNgayNhap" placeholder="__/__/____" name="field-name" class="combo tree drop" style="width:40%" />
                                           <%-- </div>
                                        </div>
                                    </div>--%>
                                </td>
                            </tr>
                            <tr>
                                <td>Khách hàng</td>
                                <td>
                                    <%--<div class="workitemcontrol">
                                        <div class="combo tree drop short-control-50">
                                            <div class="wrap">--%>
                                                <asp:HiddenField ID="slcTenNhaCungCap" runat="server" />
                                                <input type="text" id="txtTenNhaCungCap" autocomplete="off" maxlength="255" title="CNS" runat="server" style="width:400px" />
                                            <%--</div>
                                        </div>
                                    </div>--%>
                                </td>
                                <td>Kho xuất</td>
                                <td>
                                    <%--<div class="workitemcontrol">
                                        <div class="combo tree drop short-control-50">
                                            <div class="wrap">--%>
                                                <asp:HiddenField ID="slcKhoChua" runat="server" />
                                                <input type="text" id="txtKhoChua" autocomplete="off" maxlength="255" title="CNS" runat="server" style="width:100%" />
                                            <%--</div>
                                        </div>
                                    </div>--%>
                                </td>
                            </tr>
                          <%--  <tr>
                            <td>Cảm quan</td>
                            <td colspan="3">
                              <asp:TextBox ID="txtCamQuanKiemTra" runat="server" Width="100%" MaxLength="254" />
                           </td>
                            </tr>--%>
                            <tr>
                                <td>Tính chất nhập xuất</td>
                                <td>
                                    <%--<div class="workitemcontrol">
                                        <div class="combo tree drop short-control-50">
                                            <div class="wrap" style="display:block">--%>
                                                <asp:DropDownList ID="ddlTinhChat" runat="server" Width="400px"></asp:DropDownList>
                                            <%--</div>
                                        </div>
                                    </div>--%>
                                </td>
                                <td>Người xuất</td>
                                <td>
                                   <%-- <div class="workitemcontrol">
                                        <div class="combo tree drop short-control-50">
                                            <div class="wrap">--%>
                                               <asp:TextBox ID="TextBox1" runat="server" Width="100%"></asp:TextBox>
                                            <%--</div>
                                        </div>
                                    </div>--%>
                                </td>
                            </tr>
                             <tr>
                    <td>Ghi chú
                    </td>
                    <td colspan="3">
                        <asp:TextBox ID="txtGhiChu" TextMode="MultiLine" runat="server" />
                    </td>
                </tr>
                        </tbody>
                    </table>
                    <div class="work-item-bonus">
                        <asp:Literal ID="ltButtonNewChiTietVatTuXuat" runat="server"></asp:Literal>
                    </div>
                    <asp:Panel runat="server" ID="pnChiTietVatTu">
                        <div id="" class="div-data">
                            <table class="data-table tab-detail" id="tabDanhSachPhieuXuatVatTu">
                                <thead>
                                    <tr>
                                        <td>STT</td>
                                        <td>Mã VT</td>
                                        <td>Tên VT</td>
                                        <td>Kích thước TC</td>
                                        <td>Định lượng TC</td>
                                        <td>Kích thước KT</td>
                                        <td>Định lượng KT</td>
                                        <td>Độ ẩm KT</td>
                                         <td>Cảm quan</td>
                                        <td>Trạng thái</td>
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