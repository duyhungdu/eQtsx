<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Report_NhapVatTu.ascx.cs" Inherits="xRP.Report.QuanLyVatTu.NhapVatTu.Report_NhapVatTu" %>
<script type="text/javascript">
    $(document).ready(function () {
        $('#txtTuNgay').datetimepicker({
            mask: '99/99/9999', timepicker: false,
            format: 'd/m/Y',
        });
        $('#txtDenNgay').datetimepicker({
            mask: '99/99/9999', timepicker: false,
            format: 'd/m/Y',
        });
    });
    function loadReport() {
        window.location.href=("<%=Util.SERVER_NAME %>/Report/ViewReport.aspx?page=vebcnk");
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
                        <span class="info-text">Chọn điều kiện báo cáo nhập vật tư</span>
                    </div>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block;">
                    <ul class="menu-bar">
                        <li class="menu-item icon-only" id="btn-luu">
                            <a class="menu-bar-item-button icon icon-printer" title="In" ID="btnPrint" onclick="loadReport();"></a></li>
                        <li class="menu-item icon-only" id="btn-cancel">
                            <asp:Button CssClass="menu-bar-item-button icon cancel-icon" ToolTip="Hủy" runat="server" ID="btnCancel" /></li>
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
                                <td>Từ ngày
                                </td>
                                <td>
                                    <div class="workitemcontrol">
                                        <div class="combo tree drop short-control-30">
                                            <div class="wrap">
                                                <input type="text" value="" id="txtTuNgay" />
                                            </div>

                                        </div>
                                    </div>
                                </td>
                                <td>Đến ngày
                                </td>
                                <td>
                                    <div class="workitemcontrol">
                                        <div class="combo tree drop short-control-30">
                                            <div class="wrap">
                                                <input type="text" id="txtDenNgay" />
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="clear"></div>
    </div>
</div>