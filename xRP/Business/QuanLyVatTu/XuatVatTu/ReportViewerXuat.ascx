<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReportViewerXuat.ascx.cs" Inherits="xRP.Business.QuanLyVatTu.XuatVatTu.ReportViewerXuat" %>
<%@ Register Assembly="DevExpress.XtraReports.v15.1.Web, Version=15.1.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>
<script type="text/javascript">
    function cancel() {
        window.location.href = "<%#Util.SERVER_NAME %>/Business/QuanLyVatTu/Default.aspx?page=pktx";
    }
    function duyetPhieuXuat(id) {
        new PhieuXuat({
            itemID: id
        }).duyetPhieuXuat();
    }
</script>
<asp:ScriptManager ID="ScriptManager2" runat="server"></asp:ScriptManager>

<div class="splitter horizontal hub-splitter stateful toggle-button-enabled toggle-button-hotkey-enabled">
    <div class="rightPane" style="left: 0px;">
        <div class="right-hub-content">
            <div class="work-item-form">
                <div class="workitem-info-bar">
                    <div class="info-text-wrapper">
                        <span class="info-text">In phiếu xuất vật tư
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
                <div class="work-item-view" style="margin-left: 10px; margin: 0px auto;">
                    <div class="work-item-view view_report" style="display: block; text-align: center; min-height: 500px;">
                        <dx:ASPxDocumentViewer ID="ASPxDocumentViewer1" runat="server"></dx:ASPxDocumentViewer>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

