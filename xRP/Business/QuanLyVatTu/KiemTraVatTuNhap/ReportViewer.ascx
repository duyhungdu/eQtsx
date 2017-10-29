<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReportViewer.ascx.cs" Inherits="xRP.Business.QuanLyVatTu.KiemTraVatTuNhap.ReportViewer" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<script type="text/javascript">
    function cancel() {
        window.location.href = "<%#Util.SERVER_NAME %>/Business/QuanLyVatTu/Default.aspx?page=pktn";
    }
    function duyetPhieuNhap(id) {
        new PhieuNhap({
            ID: id
        }).duyetPhieuNhap();
    }
</script>

<div class="splitter horizontal hub-splitter stateful toggle-button-enabled toggle-button-hotkey-enabled">
    <div class="rightPane" style="left: 0px;">
        <div class="right-hub-content">
            <div class="work-item-form">
                <div class="workitem-info-bar">
                    <div class="info-text-wrapper">
                        <span class="info-text">In phiếu nhập vật tư
                        </span>
                    </div>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block;">
                    <ul class="menu-bar">
                        <asp:Literal ID="ltAccept" runat="server"></asp:Literal>
                        <li class="menu-item icon-only" id="btn-cancel">
                            <input id="btnCancel" type="button" class="menu-bar-item-button icon cancel-icon" onclick="cancel()" />
                        </li>
                    </ul>
                </div>
                <div class="work-item-view" style="margin-left: 10px; width: 100%; margin: 0px auto; padding: 0px 10px;min-height:700px;">
                    <rsweb:ReportViewer ID="rpViewer" runat="server" ShowPrintButton="true" Width="100%" Height="100%"></rsweb:ReportViewer>
                </div>
            </div>
        </div>
    </div>
</div>
