<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BaoCaoXuatNhapTonVatTu.ascx.cs" Inherits="xRP.Report.QuanLyVatTu.NhapXuatTon.BaoCaoXuatNhapTonVatTu" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<style type="text/css">
    .autocomplete-suggestions {
        min-width: 300px;
    }
</style>

<div class="rightPane" style="left: 0px;">
    <div class="right-hub-content">
        <div class="work-item-form">
            <div class="workitem-info-bar">
                <div class="info-text-wrapper">
                    <span class="info-text">
                        <asp:Literal ID="ltPageTitle" runat="server"></asp:Literal>
                    </span>
                </div>

            </div>
            <div class="toolbar workitem-tool-bar" style="display: block;">
                <ul class="menu-bar">
                    <li class="menu-item icon-only" id="btn-cancel">
                        <asp:Button ID="btnReport" runat="server" CssClass="menu-bar-item-button icon icon-save" ToolTip="Báo cáo" OnClick="btnReport_Click" />
                        <%--<a id="btnReportInput" class="menu-bar-item-button icon icon-save" tooltip="Báo cáo" />--%>
                        <a id='btnCancel' class='menu-bar-item-button icon cancel-icon' href='/Business/QuanLyVatTu/DonHang/Default.aspx?page=pktn' title='Quay lại'></a>
                    </li>
                </ul>
            </div>
            <div class="work-item-view" style="margin-left: 10px; width: 100%; margin: 0px auto; padding: 0px 10px;">
                <div class="work-item-form">
                    <div class="work-item-view" style="margin-left: 10px;">
                        <table class="witform-layout">
                            <tbody>
                                <tr>
                                    <td style="width: 100px;"></td>
                                    <td style="width: 30%;"></td>
                                    <td style="width: 100px;"></td>
                                    <td style="width: 30%;"></td>
                                </tr>
                                <tr>
                                    <td>
                                        <div>
                                            <span>Kho</span>
                                            <span style="color: red">*</span>
                                        </div>
                                    </td>
                                    <td colspan="3">
                                        <div class="workitemcontrol kho-select" style="border: 1px solid silver;">

                                            <span id="txtkho-select"></span>
                                            <asp:TextBox ID="txtKho" runat="server" TabIndex="2" Width="100" BorderWidth="0" Style="outline: none;"></asp:TextBox>
                                            <asp:HiddenField ID="slcKho" runat="server" ClientIDMode="Static" />

                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div>
                                            <span>Vật tư</span>
                                            <span style="color: red">*</span>
                                        </div>
                                    </td>
                                    <td colspan="3">
                                        <div class="workitemcontrol vattu-select" style="border: 1px solid silver;">

                                            <span id="txtvattu-select"></span>
                                            <asp:TextBox ID="txtVatTu" runat="server" CssClass="input" TabIndex="2" Width="100" BorderWidth="0" Style="outline: none;"></asp:TextBox>
                                            <asp:HiddenField ID="slcVatTu" runat="server" ClientIDMode="Static" />

                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div>
                                            <span>Từ ngày</span>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="workitemcontrol">
                                            <div class="combo tree drop">
                                                <div class="wrap">
                                                    <asp:TextBox ID="txtTuNgay" CssClass="cus-datepicker" runat="server" TabIndex="1"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div>
                                            <span>Đến ngày</span>
                                            <span style="color: red">*</span>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="workitemcontrol">
                                            <div class="combo tree drop">
                                                <div class="wrap">
                                                    <asp:TextBox ID="txtDenNgay" CssClass="cus-datepicker" runat="server" TabIndex="2" Width="100%"></asp:TextBox>
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
        </div>
    </div>
</div>
<%-- anh Nam
    <rsweb:ReportViewer ID="rpViewerDataTam" runat="server" ShowPrintButton="true" Width="100%" Height="100%"></rsweb:ReportViewer>
    anh nam--%>

<script type="text/javascript">
    $(document).ready(function () {
        $('.cus-datepicker').datetimepicker({
            mask: '99/99/9999', timepicker: false,
            format: 'd/m/Y',
        });

        queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataKhoVatTuNVLorThanhPhamForAutoComplete", "{TYPE:1}", function (result) {
            var objJSON = JSON.parse(result.d);
            $('#<%=txtKho.ClientID%>').autocomplete({
                lookup: objJSON,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) {return true;}else {return false;}
                     
                },
                onSelect: function (suggestion) {
                    var data = $('#<%=slcKho.ClientID%>').val();
                    if ((',' + data + ',').indexOf(',' + suggestion.data + ',') < 0) {
                        $('#txtkho-select').append("<span  id='sp-" + suggestion.data + "' style='background:silver;margin-right:2px;' value=" + suggestion.data + ">" + suggestion.value + " <span> <img src='/Styles/images/editdelete.png' span-id='sp-" + suggestion.data + "' value='" + suggestion.data + "' style=' width: 12px;cursor: pointer;' onclick='removeDataKho(this)' /></span></span>");
                        data += ',' + suggestion.data;
                        data = data.replace(',,', ',');
                        $('#<%=slcKho.ClientID%>').val(data);
                    }
                    $('#<%=txtKho.ClientID%>').val('');

                },
                onHint: function (hint) {
                },
                onInvalidateSelection: function () {
                    // $('#<-%=slcTenNhaCungCap.ClientID%>').val("");
                    //$('#txtkho-select').html('');
                    // $('#slcKho').val('');
                }
            });
        });

        $('.vattu-select').click(function () {
            $('#<%=txtVatTu.ClientID%>').focus();
        });
        $('.kho-select').click(function () {
            $('#<%=txtKho.ClientID%>').focus();
        });


        queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataVatTuByTenForAutoComplete", {}, function (result) {
            var objJSON = JSON.parse(result.d);
            $('#<%=txtVatTu.ClientID%>').autocomplete({
                lookup: objJSON,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) {return true;}else {return false;}
                     
                },
                onSelect: function (suggestion) {
                    var data = $('#<%=slcVatTu.ClientID%>').val();
                    if ((',' + data + ',').indexOf(',' + suggestion.ID + ',') < 0) {
                        $('#txtvattu-select').append("<span  id='sp-" + suggestion.ID + "' style='background:silver;margin-right:2px;' value=" + suggestion.ID + ">" + suggestion.value + " <span> <img src='/Styles/images/editdelete.png' span-id='sp-" + suggestion.ID + "' value='" + suggestion.ID + "' style=' width: 12px;cursor: pointer;' onclick='removeDataVatTu(this)' /></span></span>");
                        data += ',' + suggestion.ID;
                        data = data.replace(',,', ',');
                        $('#<%=slcVatTu.ClientID%>').val(data);
                    }
                    $('#<%=txtVatTu.ClientID%>').val('');
                },
                onHint: function (hint) {
                },
                onInvalidateSelection: function () {
                    //console.log('khuong--aa');
                    //$('#txtvattu-select').html('');
                    //$('#slcVatTu').val('');
                }
            });
        });
    });

    function removeDataVatTu(ctr) {
        var dataVatTu = ',' + $('#<%=slcVatTu.ClientID%>').val() + ',';
        dataVatTu = dataVatTu.replace(',,', ',');
        dataVatTu = dataVatTu.replace(',' + $(ctr).attr('value') + ',', ',');
        dataVatTu = dataVatTu.replace(',,', ',');
        $('#<%=slcVatTu.ClientID%>').val(dataVatTu);
        $('#' + $(ctr).attr('span-id')).remove();
    }

    function removeDataKho(ctr) {
        var dataKho = ',' + $('#<%=slcKho.ClientID%>').val() + ',';
        dataKho = dataKho.replace(',,', ',');
        dataKho = dataKho.replace(',' + $(ctr).attr('value') + ',', ',');
        dataKho = dataKho.replace(',,', ',');
        $('#<%=slcKho.ClientID%>').val(dataKho);
        $('#' + $(ctr).attr('span-id')).remove();
    }
</script>
