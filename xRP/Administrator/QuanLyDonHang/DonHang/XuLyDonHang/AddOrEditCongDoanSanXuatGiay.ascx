<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddOrEditCongDoanSanXuatGiay.ascx.cs" Inherits="xRP.Administrator.QuanLyDonHang.DonHang.XuLyDonHang.AddOrEditCongDoanSanXuatGiay" %>
<script type="text/javascript">
    $(document).ready(function () {
        $("#<%=txtTenCongDoan.ClientID%>").focus();
    });
</script>
<div class="splitter horizontal hub-splitter stateful toggle-button-enabled toggle-button-hotkey-enabled content_trg">
<div class="work-item-form">

    <div class="work-item-view">

            <table class="witform-layout">
                <tbody>
                    <tr>
                    <td style="width: 25%;"></td>
                    <td style="width: 25%;"></td>
                    <td style="width: 15%;"></td>
                    <td style="width: 35%;"></td>
                    </tr>
                    <tr>
                         <td>
                             <div>
                                  <span>Tên công đoạn</span>
                                 <span style="color:red">*</span>
                             </div>
                        </td>
                        <td colspan="3">
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                       <asp:TextBox ID="txtTenCongDoan" runat="server" TabIndex="2" Width="100%"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>

                    </tr>
                    <tr>
                        <td>Số lượng sản xuất
                            <span style="color:red">*</span>
                        </td>
                        <td>
                             <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                       <asp:TextBox ID="txtSoLuongCanSanXuat" runat="server" TabIndex="6"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td></td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                         <td>Ghi chú</td>
                        <td colspan="3">
                            <asp:TextBox ID="txtGhiChu" runat="server" TabIndex="6" TextMode="MultiLine"></asp:TextBox>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
 </div>
<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix button-list">
    <input type="button" id="btnSave" class="xrp-button" value="Lưu" />
    <input type="button" value="Hủy" onclick="CloseModal();" class="xrp-button" tabindex="13" />
</div>
