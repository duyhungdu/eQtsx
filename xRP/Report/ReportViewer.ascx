<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReportViewer.ascx.cs" Inherits="xRP.Report.ReportViewer" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<style type="text/css">
    table {
        border-collapse: collapse !important;
    }
</style>
<asp:ScriptManager ID="ScriptManager2" runat="server"></asp:ScriptManager>
<div class="splitter horizontal hub-splitter stateful toggle-button-enabled toggle-button-hotkey-enabled">
    <asp:PlaceHolder ID="plcReportData" runat="server"></asp:PlaceHolder>
    <asp:Panel runat="server" ID="pnBaoCaoKhac" Visible="false">
        <div class="rightPane" style="left: 0px;" runat="server" id="paramPane">
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
                                <asp:Button ID="btnReport" runat="server" Visible="false" CssClass="menu-bar-item-button icon icon-save" ToolTip="Báo cáo" OnClick="btnReport_Click" />
                                <asp:Literal ID="ltQuayLai" runat="server"></asp:Literal>
                            </li>
                        </ul>
                        
                    </div>
                    <div class="work-item-view" style="display: none; margin-left: 10px; width: 100%; margin: 0px auto; padding: 0px 10px; margin-bottom: 10px;">
                        <fieldset>
                            <legend>Tiêu chí báo cáo</legend>
                            <div class="work-item-form">
                                <div class="work-item-view" style="margin-left: 10px;">
                                    <table class="witform-layout">
                                        <tbody>
                                            <tr>
                                                <td style="width: 20%;"></td>
                                                <td style="width: 30%;"></td>
                                                <td style="width: 20%;"></td>
                                                <td style="width: 30%;"></td>
                                            </tr>
                                            <tr>
                                                <td style="display: none">
                                                    <div>
                                                        <span>Kho</span>
                                                        <span style="color: red">*</span>
                                                    </div>
                                                </td>
                                                <td style="display: none">
                                                    <div class="workitemcontrol">
                                                        <div class="combo tree drop">
                                                            <div class="wrap">
                                                                <asp:TextBox ID="txtNXT_Kho" runat="server" TabIndex="2" Width="100%"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td style="display: none">
                                                    <div>
                                                        <span>Vật tư</span>
                                                        <span style="color: red">*</span>
                                                    </div>
                                                </td>
                                                <td style="display: none">
                                                    <div class="workitemcontrol">
                                                        <div class="combo tree drop">
                                                            <div class="wrap">
                                                                <asp:TextBox ID="txtNXT_VatTu" runat="server" TabIndex="2" Width="100%"></asp:TextBox>
                                                            </div>
                                                        </div>
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
                                                                <asp:TextBox ID="txtNXT_TuNgay" CssClass="cus-datepicker" runat="server" TabIndex="1"></asp:TextBox>
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
                                                                <asp:TextBox ID="txtNXT_DenNgay" CssClass="cus-datepicker" runat="server" TabIndex="2" Width="100%"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>

                            </div>
                        </fieldset>

                    </div>
                </div>
            </div>
        </div>

    </asp:Panel>
    <asp:Panel runat="server" ID="pnBaoCaoNhapXuatTon" Visible="false">
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
                                <asp:Literal ID="lblBaoCaoNhapXuatTon" runat="server"></asp:Literal>
                            </span>
                        </div>

                    </div>
                    <div class="toolbar workitem-tool-bar">
                        <ul class="menu-bar">
                            <li class="menu-item icon-only">
                                <asp:Button ID="btnBaoCaoNhapXuatTon" runat="server" CssClass="menu-bar-item-button icon icon-export" ToolTip="Báo cáo" OnClick="btnBaoCaoNhapXuatTon_Click" />


                            </li>
                            <li class="menu-item icon-only">
                                <a id='btnBaoCaoNhapXuatTonCancel' class='menu-bar-item-button icon cancel-icon' href='/Business/QuanLyVatTu/DonHang/Default.aspx?page=pktn' title='Quay lại'></a>
                            </li>
                        </ul>
                    </div>
                    <div class="work-item-view" style="margin-left: 10px; width: 100%; margin: 0px auto; padding: 0px 10px; margin-bottom: 10px;">
                        <div class="work-item-form">
                            <div class="work-item-view" style="margin-left: 10px;">
                                <table class="witform-layout">
                                    <tbody>
                                        <tr>
                                            <td style="width: 100px;"></td>
                                            <td style="width: 40%;"></td>
                                            <td style="width: 100px;"></td>
                                            <td style="width: 40%;"></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div>
                                                    <span>Kho</span>
                                                    <span style="color: red">*</span>
                                                </div>
                                            </td>
                                            <td colspan="3">
                                                <div class="workitemcontrol kho-select" style="border: 1px solid #e6e6e6;">
                                                    <%-- <span id="txtkho-select"></span>--%>
                                                    <asp:Label ID="lblKhoSelect" runat="server" EnableViewState="true" ClientIDMode="Static" ViewStateMode="Enabled"></asp:Label>
                                                    <asp:TextBox ID="txtKho" runat="server" Width="100" BorderWidth="0" Style="outline: none;"></asp:TextBox>
                                                    <asp:HiddenField ID="slcKho" runat="server" ClientIDMode="Static" />
                                                </div>
                                                <div style="display: none;">
                                                    <asp:TextBox ID="txtKhoSelect" runat="server" Rows="100"></asp:TextBox>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div>
                                                    <span>Loại vật tư</span>
                                                    <span style="color: red">*</span>
                                                </div>
                                            </td>
                                            <td colspan="3">
                                                <div class="workitemcontrol loaivattu-select" style="border: 1px solid #e6e6e6;">
                                                    <span id="txtloaivattu-select"></span>
                                                    <asp:TextBox ID="txtLoaiVatTu" runat="server" Width="100" BorderWidth="0" Style="outline: none;"></asp:TextBox>
                                                    <asp:HiddenField ID="slcLoaiVatTu" runat="server" ClientIDMode="Static" />
                                                </div>
                                                <div style="display: none;">
                                                    <asp:TextBox ID="txtLoaiVatTuSelect" runat="server" Rows="100"></asp:TextBox>
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
                                                <div class="workitemcontrol vattu-select" style="border: 1px solid #e6e6e6;">

                                                    <asp:Label ID="lblVatTu" runat="server" CssClass="txtvattu-select"> </asp:Label>
                                                    <asp:TextBox ID="txtVatTu" runat="server" CssClass="input" Width="100" BorderWidth="0" Style="outline: none;"></asp:TextBox>
                                                    <asp:HiddenField ID="slcVatTu" runat="server" ClientIDMode="Static" />

                                                </div>
                                                <div style="display: none;">
                                                    <asp:TextBox ID="txtVatTuSelect" runat="server" Rows="100"></asp:TextBox>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div>
                                                    <span>Nhà cung cấp</span>
                                                    <span style="color: red">*</span>
                                                </div>
                                            </td>
                                            <td colspan="3">
                                                <div class="workitemcontrol nhacungcap-select" style="border: 1px solid #e6e6e6;">

                                                    <asp:Label ID="lblNhaCungCap" runat="server" CssClass="txtnhacungcap-select"> </asp:Label>
                                                    <asp:TextBox ID="txtNhaCungCap" runat="server" CssClass="input" Width="100" BorderWidth="0" Style="outline: none;"></asp:TextBox>
                                                    <asp:HiddenField ID="slcNhaCungCap" runat="server" ClientIDMode="Static" />

                                                </div>
                                                <div style="display: none;">
                                                    <asp:TextBox ID="txtNhaCungCapSelect" runat="server" Rows="100"></asp:TextBox>
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
                                                            <asp:TextBox ID="txtTuNgay" CssClass="cus-datepicker" runat="server"></asp:TextBox>
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
                                                            <asp:TextBox ID="txtDenNgay" CssClass="cus-datepicker" runat="server" Width="100%"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div>
                                                    <span>Trừ lõi</span>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="workitemcontrol">
                                                    <asp:CheckBox ID="chkKhongTruLoi" runat="server"></asp:CheckBox>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div>
                                                    <span>Nhóm theo</span>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="workitemcontrol">
                                                    <div class="combo tree drop short-control-50">
                                                        <div class="wrap">
                                                            <asp:DropDownList ID="ddlGroupBy" runat="server">
                                                                <asp:ListItem Value="0" Selected="True" Text="Loại vật tư"></asp:ListItem>
                                                                <asp:ListItem Value="1" Text="Nhà cung cấp"></asp:ListItem>
                                                            </asp:DropDownList>
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
        <script type="text/javascript">
            $(document).ready(function () {
                $('.cus-datepicker').datetimepicker({
                    mask: '99/99/9999', timepicker: false,
                    format: 'd/m/Y',
                });

                ///Giữ lại giá tri khi postback
                $('#<%=lblKhoSelect.ClientID%>').append($('#<%=txtKhoSelect.ClientID%>').val());

                $('#txtloaivattu-select').append($('#<%=txtLoaiVatTuSelect.ClientID%>').val());

                $('#<%=lblVatTu.ClientID%>').append($('#<%=txtVatTuSelect.ClientID%>').val());
                $('#<%=lblNhaCungCap.ClientID%>').append($('#<%=txtNhaCungCapSelect.ClientID%>').val());

                queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataKhoVatTuNVLorThanhPhamForAutoComplete", "{TYPE:1}", function (result) {
                    var objJSON = JSON.parse(result.d);
                    $('#<%=txtKho.ClientID%>').autocomplete({
                        lookup: objJSON,
                        lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                            if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }

                        },
                        onSelect: function (suggestion) {
                            var data = $('#<%=slcKho.ClientID%>').val();
                            if ((',' + data + ',').indexOf(',' + suggestion.data + ',') < 0) {
                                var strData = "<span  id='sp-" + suggestion.data + "' style='background:silver;margin-right:2px;' value=" + suggestion.data + ">" + suggestion.value + " <span> <img src='/Styles/images/editdelete.png' span-id='sp-" + suggestion.data + "' value='" + suggestion.data + "' style=' width: 12px;cursor: pointer;' onclick='removeDataKho(this)' /></span></span>";

                                $('#<%=lblKhoSelect.ClientID%>').append(strData);
                                $('#<%=txtKhoSelect.ClientID%>').val($('#<%=txtKhoSelect.ClientID%>').val() + strData);

                                data += ',' + suggestion.data;
                                data = data.replace(',,', ',');
                                $('#<%=slcKho.ClientID%>').val(data);
                            }
                            $('#<%=txtKho.ClientID%>').val('');

                        },
                        onHint: function (hint) {
                        },
                        onInvalidateSelection: function () {
                        }
                    });
                });

                $('.vattu-select').click(function () {
                    $('#<%=txtVatTu.ClientID%>').focus();
                });
                $('.nhacungcap-select').click(function () {
                    $('#<%=txtNhaCungCap.ClientID%>').focus();
                });
                $('.kho-select').click(function () {
                    $('#<%=txtKho.ClientID%>').focus();
                });


                queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataVatTuByTenForAutoComplete", {}, function (result) {
                    var objJSON = JSON.parse(result.d);
                    $('#<%=txtVatTu.ClientID%>').autocomplete({
                        lookup: objJSON,
                        lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                            if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }

                        },
                        onSelect: function (suggestion) {
                            var data = $('#<%=slcVatTu.ClientID%>').val();
                            if ((',' + data + ',').indexOf(',' + suggestion.ID + ',') < 0) {
                                //$('.txtvattu-select').append();
                                var strData = "<span  id='sp-" + suggestion.ID + "' style='background:silver;margin-right:2px;' value=" + suggestion.ID + ">" + suggestion.value + " <span> <img src='/Styles/images/editdelete.png' span-id='sp-" + suggestion.ID + "' value='" + suggestion.ID + "' style=' width: 12px;cursor: pointer;' onclick='removeDataVatTu(this)' /></span></span>";

                                $('#<%=lblVatTu.ClientID%>').append(strData);
                                $('#<%=txtVatTuSelect.ClientID%>').val($('#<%=txtVatTuSelect.ClientID%>').val() + strData);

                                data += ',' + suggestion.ID;
                                data = data.replace(',,', ',');
                                $('#<%=slcVatTu.ClientID%>').val(data);
                            }
                            $('#<%=txtVatTu.ClientID%>').val('');
                        },
                        onHint: function (hint) {
                        },
                        onInvalidateSelection: function () {
                        }
                    });
                });



                queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataNhaCungCapForAutoComplete", {}, function (result) {
                    var objJSON = JSON.parse(result.d);
                    $('#<%=txtNhaCungCap.ClientID%>').autocomplete({
                        lookup: objJSON,
                        lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                            if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }

                        },
                        onSelect: function (suggestion) {
                            var data = $('#<%=slcNhaCungCap.ClientID%>').val();
                            if ((',' + data + ',').indexOf(',' + suggestion.ID + ',') < 0) {
                                //$('.txtvattu-select').append();
                                var strData = "<span  id='sp-" + suggestion.ID + "' style='background:silver;margin-right:2px;' value=" + suggestion.ID + ">" + suggestion.value + " <span> <img src='/Styles/images/editdelete.png' span-id='sp-" + suggestion.ID + "' value='" + suggestion.ID + "' style=' width: 12px;cursor: pointer;' onclick='removeDataNhaCungCap(this)' /></span></span>";

                                $('#<%=lblNhaCungCap.ClientID%>').append(strData);
                                $('#<%=txtNhaCungCapSelect.ClientID%>').val($('#<%=txtNhaCungCapSelect.ClientID%>').val() + strData);

                                data += ',' + suggestion.ID;
                                data = data.replace(',,', ',');
                                $('#<%=slcNhaCungCap.ClientID%>').val(data);
                            }
                            $('#<%=txtNhaCungCap.ClientID%>').val('');
                        },
                        onHint: function (hint) {
                        },
                        onInvalidateSelection: function () {
                        }
                    });
                });



                queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataLoaiVatTuForAutoComplete", {}, function (result) {
                    var objJSON = JSON.parse(result.d);
                    $('#<%=txtLoaiVatTu.ClientID%>').autocomplete({
                        lookup: objJSON,
                        lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                            if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }

                        },
                        onSelect: function (suggestion) {
                            var data = $('#<%=slcLoaiVatTu.ClientID%>').val();
                            if ((',' + data + ',').indexOf(',' + suggestion.ID + ',') < 0) {

                                var strData = "<span  id='sp-" + suggestion.ID + "' style='background:silver;margin-right:2px;' value=" + suggestion.ID + ">" + suggestion.value + " <span> <img src='/Styles/images/editdelete.png' span-id='sp-" + suggestion.ID + "' value='" + suggestion.ID + "' style=' width: 12px;cursor: pointer;' onclick='removeDataLoaiVatTu(this)' /></span></span>";

                                $('#txtloaivattu-select').append(strData);
                                $('#<%=txtLoaiVatTuSelect.ClientID%>').val($('#<%=txtLoaiVatTuSelect.ClientID%>').val() + strData);


                                data += ',' + suggestion.ID;
                                data = data.replace(',,', ',');
                                $('#<%=slcLoaiVatTu.ClientID%>').val(data);
                            }
                            $('#<%=txtLoaiVatTu.ClientID%>').val('');
                        },
                        onHint: function (hint) {
                        },
                        onInvalidateSelection: function () {

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
            function removeDataNhaCungCap(ctr) {
                var dataNhaCungCap = ',' + $('#<%=slcNhaCungCap.ClientID%>').val() + ',';
                dataNhaCungCap = dataNhaCungCap.replace(',,', ',');
                dataNhaCungCap = dataNhaCungCap.replace(',' + $(ctr).attr('value') + ',', ',');
                dataNhaCungCap = dataNhaCungCap.replace(',,', ',');
                $('#<%=slcNhaCungCap.ClientID%>').val(dataNhaCungCap);
                $('#' + $(ctr).attr('span-id')).remove();
            }

            function removeDataLoaiVatTu(ctr) {
                var dataLoaiVatTu = ',' + $('#<%=slcLoaiVatTu.ClientID%>').val() + ',';
                dataLoaiVatTu = dataLoaiVatTu.replace(',,', ',');
                dataLoaiVatTu = dataLoaiVatTu.replace(',' + $(ctr).attr('value') + ',', ',');
                dataLoaiVatTu = dataLoaiVatTu.replace(',,', ',');
                $('#<%=slcLoaiVatTu.ClientID%>').val(dataLoaiVatTu);
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
    </asp:Panel>
    <asp:Panel runat="server" ID="pnlBaoCaoFailedKCS" Visible="false">
        <script type="text/javascript">
            $(document).ready(function () {
                $('.cus-datepicker').datetimepicker({
                    mask: '99/99/9999', timepicker: false,
                    format: 'd/m/Y',
                });
                queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataNhaCungCapForAutoComplete", {}, function (result) {
                    var objJSON = JSON.parse(result.d);
                    $('#<%=txtNhaCungCapFailedKCS.ClientID%>').autocomplete({
                        lookup: objJSON,
                        lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                            if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }

                        },
                        onSelect: function (suggestion) {
                            $('#<%=hdfNhaCungCapFailedKCS.ClientID%>').val(suggestion.data);
                        },
                        onHint: function (hint) {
                        },
                        onInvalidateSelection: function () {
                            $('#<%=hdfNhaCungCapFailedKCS.ClientID%>').val("0");
                        }
                    });
                });
                queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataAllVatTu", {}, function (result) {
                    var objJSON = JSON.parse(result.d);
                    $('#<%=txtVatTuFailedKCS.ClientID%>').autocomplete({
                        lookup: objJSON,
                        lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                            if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }

                        },
                        onSelect: function (suggestion) {
                            $('#<%=hdfVatTuFailedKCS.ClientID%>').val(suggestion.data);
                        },
                        onHint: function (hint) {
                        },
                        onInvalidateSelection: function () {
                            $('#<%=hdfVatTuFailedKCS.ClientID%>').val("0");
                        }
                    });
                });

            });

        </script>
        <div class="rightPane" style="left: 0px;">
            <div class="right-hub-content">
                <div class="work-item-form">
                    <div class="workitem-info-bar">
                        <div class="info-text-wrapper">
                            <span class="info-text">
                                <asp:Literal ID="ltBaoCaoKCS" runat="server"></asp:Literal>
                            </span>
                        </div>

                    </div>
                    <div class="toolbar workitem-tool-bar">
                        <ul class="menu-bar">
                            <li class="menu-item icon-only">
                                <asp:Button ID="btnBaoCaoFailedKCS" OnClick="btnBaoCaoFailedKCS_Click" runat="server" CssClass="menu-bar-item-button icon icon-export" ToolTip="Báo cáo" />
                            </li>

                        </ul>
                    </div>
                    <div class="work-item-view" style="margin-left: 10px; width: 100%; margin: 0px auto; padding: 0px 10px; margin-bottom: 10px;">
                        <div class="work-item-form">
                            <div class="work-item-view" style="margin-left: 10px;">
                                <table class="witform-layout">
                                    <tbody>
                                        <tr>
                                             <td style="width: 10%;"></td>
                                            <td style="width: 23%;"></td>
                                             <td style="width: 10%;"></td>
                                            <td style="width: 23%;"></td>
                                              <td style="width: 10%;"></td>
                                            <td style="width: 23%;"></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div>
                                                    <span>Vật tư</span>
                                                </div>
                                            </td>
                                            <td colspan="3">
                                                <div class="workitemcontrol">
                                                    <div class="combo tree drop short-control-50">
                                                        <div class="wrap">
                                                            <asp:TextBox ID="txtVatTuFailedKCS" runat="server"></asp:TextBox>
                                                            <asp:HiddenField ID="hdfVatTuFailedKCS" Value="0" runat="server" ClientIDMode="Static" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td></td>
                                             <td></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div>
                                                    <span>Nhà cung cấp</span>
                                                </div>
                                            </td>
                                            <td colspan="3">
                                                <div class="workitemcontrol">
                                                    <div class="combo tree drop short-control-50">
                                                        <div class="wrap">
                                                            <asp:TextBox ID="txtNhaCungCapFailedKCS" runat="server"></asp:TextBox>
                                                            <asp:HiddenField ID="hdfNhaCungCapFailedKCS" Value="0" runat="server" ClientIDMode="Static" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                               <td></td>
                                             <td></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div>
                                                    <span>Từ ngày</span>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="workitemcontrol">
                                                    <div class="combo tree drop short-control-50">
                                                        <div class="wrap">
                                                            <asp:TextBox ID="txtTuNgayFailed" CssClass="cus-datepicker" runat="server"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div>
                                                    <span>Đến ngày</span>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="workitemcontrol">
                                                    <div class="combo tree drop short-control-50">
                                                        <div class="wrap">
                                                            <asp:TextBox ID="txtDenNgayFailed" CssClass="cus-datepicker" runat="server" Width="100%"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                               <td></td>
                                             <td></td>
                                        </tr>
                                         <tr>
                                            <td>
                                                <div>
                                                    <span>Tình trạng</span>
                                                </div>
                                            </td>
                                            <td colspan="3">
                                                <div class="workitemcontrol">
                                                    <div class="combo tree drop short-control-50">
                                                        <div class="wrap">
                                                            <asp:DropDownList ID="DropDownList2" runat="server">
                                                                <asp:ListItem Value="-1" Text="Không đạt"></asp:ListItem>
                                                                <asp:ListItem Value="0" Selected="True" Text="Không kiểm tra"></asp:ListItem>
                                                                <asp:ListItem Value="1" Text="Đạt"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                            </td>
                                            <td>
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

    </asp:Panel>
    <asp:Panel runat="server" ID="pnlBaoCaoSanXuatGiaoHang" Visible="false">
        <script type="text/javascript">
            $(document).ready(function () {
                $('.cus-datepicker').datetimepicker({
                    mask: '99/99/9999', timepicker: false,
                    format: 'd/m/Y',
                });
                queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONKhachHangForAutoComplete", {}, function (result) {
                    var objJSON = JSON.parse(result.d);
                    $('#<%=txtBCSXKhachHang.ClientID%>').autocomplete({
                        lookup: objJSON,
                        lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                            if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }

                        },
                        onSelect: function (suggestion) {
                            $('#<%=hdfBCSXIDKhachHang.ClientID%>').val(suggestion.data);
                        },
                        onHint: function (hint) {
                        },
                        onInvalidateSelection: function () {
                            $('#<%=hdfBCSXIDKhachHang.ClientID%>').val("0");
                        }
                    });
                });
                queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataDonHangByKhachHangForAutoComplete", "{maKhachHang:\"" + $('#<%=hdfBCSXIDKhachHang.ClientID%>').val() + "\"}", function (result) {
                    var objJSON = JSON.parse(result.d);
                    $('#<%=txtBCSXDonHang.ClientID%>').autocomplete({
                        lookup: objJSON,
                        lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                            if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }

                        },
                        onSelect: function (suggestion) {
                            $('#<%=hdfBCSXIDDonHang.ClientID%>').val(suggestion.data);
                        },
                        onHint: function (hint) {
                        },
                        onInvalidateSelection: function () {
                            $('#<%=hdfBCSXIDDonHang.ClientID%>').val("0");
                        }
                    });
                });


                queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetListMatHangAutoSuggestSource", {}, function (result) {
                    var objJSON = JSON.parse(result.d);
                    $('#<%=txtBCSXMatHang.ClientID%>').autocomplete({
                        lookup: objJSON,
                        lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                            if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }

                        },
                        onSelect: function (suggestion) {
                            $('#<%=hdfBCSXMatHang.ClientID%>').val(suggestion.data);
                        },
                        onHint: function (hint) {
                        },
                        onInvalidateSelection: function () {
                            $('#<%=hdfBCSXMatHang.ClientID%>').val("0");
                        }
                    });
                });

            });

        </script>
        <div class="rightPane" style="left: 0px;">
            <div class="right-hub-content">
                <div class="work-item-form">
                    <div class="workitem-info-bar">
                        <div class="info-text-wrapper">
                            <span class="info-text">
                                <asp:Literal ID="lblBaoCaoSanXuatGiaoHang" runat="server"></asp:Literal>
                            </span>
                        </div>

                    </div>
                    <div class="toolbar workitem-tool-bar">
                        <ul class="menu-bar">
                            <li class="menu-item icon-only">
                                <asp:Button ID="btnBaoCaoSanXuatGiaoHang" OnClick="btnBaoCaoSanXuatGiaoHang_Click" runat="server" CssClass="menu-bar-item-button icon icon-export" ToolTip="Báo cáo" />
                            </li>

                        </ul>
                    </div>
                    <div class="work-item-view" style="margin-left: 10px; width: 100%; margin: 0px auto; padding: 0px 10px; margin-bottom: 10px;">
                        <div class="work-item-form">
                            <div class="work-item-view" style="margin-left: 10px;">
                                <table class="witform-layout">
                                    <tbody>
                                        <tr>
                                            <td style="width: 10%;"></td>
                                            <td style="width: 23%;"></td>
                                             <td style="width: 10%;"></td>
                                            <td style="width: 23%;"></td>
                                              <td style="width: 10%;"></td>
                                            <td style="width: 23%;"></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div>
                                                    <span>Khách hàng</span>
                                                </div>
                                            </td>
                                            <td colspan="5">
                                                <div class="workitemcontrol">
                                                    <div class="combo tree drop short-control-50">
                                                        <div class="wrap">
                                                            <asp:TextBox ID="txtBCSXKhachHang" runat="server"></asp:TextBox>
                                                            <asp:HiddenField ID="hdfBCSXIDKhachHang" runat="server" Value="0" ClientIDMode="Static" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div>
                                                    <span>Đơn hàng</span>
                                                </div>
                                            </td>
                                            <td colspan="5">
                                                <div class="workitemcontrol">
                                                    <div class="combo tree drop short-control-50">
                                                        <div class="wrap">
                                                            <asp:TextBox ID="txtBCSXDonHang" runat="server"></asp:TextBox>
                                                            <asp:HiddenField ID="hdfBCSXIDDonHang" runat="server" Value="0" ClientIDMode="Static" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div>
                                                    <span>Mặt hàng</span>
                                                </div>
                                            </td>
                                            <td colspan="5">
                                                <div class="workitemcontrol">
                                                    <div class="combo tree drop short-control-50">
                                                        <div class="wrap">
                                                            <asp:TextBox ID="txtBCSXMatHang" runat="server"></asp:TextBox>
                                                            <asp:HiddenField ID="hdfBCSXMatHang" Value="0" runat="server" ClientIDMode="Static" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div>
                                                    <span>Ngày đặt hàng từ</span>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="workitemcontrol">
                                                    <div class="combo tree drop short-control-50">
                                                        <div class="wrap">
                                                            <asp:TextBox ID="txtNgayDatHangStart" CssClass="cus-datepicker" runat="server"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div>
                                                    <span>Ngày đặt hàng đến</span>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="workitemcontrol">
                                                    <div class="combo tree drop short-control-50">
                                                        <div class="wrap">
                                                            <asp:TextBox ID="txtNgayDatHangEnd" CssClass="cus-datepicker" runat="server"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div>
                                                    <span>Ngày giao hàng từ</span>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="workitemcontrol">
                                                    <div class="combo tree drop short-control-50">
                                                        <div class="wrap">
                                                            <asp:TextBox ID="txtNgayGiaoHangStart" CssClass="cus-datepicker" runat="server"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div>
                                                    <span>Ngày giao hàng đến</span>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="workitemcontrol">
                                                    <div class="combo tree drop short-control-50">
                                                        <div class="wrap">
                                                            <asp:TextBox ID="txtNgayGiaoHangEnd" CssClass="cus-datepicker" runat="server"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                             <td></td>
                                            <td></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </asp:Panel>
    <asp:Panel runat="server" ID="pnBaoCaoNhapXuatTonThanhPham" Visible="false">

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
                                <asp:Literal ID="lblBaoCaoNhapXuatTonThanhPham" runat="server"></asp:Literal>
                            </span>
                        </div>

                    </div>
                    <div class="toolbar workitem-tool-bar" style="display: block;">
                        <ul class="menu-bar">
                            <li class="menu-item icon-only">
                                <asp:Button ID="btnBaoCaoNhapXuatTonThanhPham" runat="server" CssClass="menu-bar-item-button icon icon-export" ToolTip="Báo cáo" OnClick="btnBaoCaoNhapXuatTonThanhPham_Click" />
                                <%-- <a id="btnReportInput" class="menu-bar-item-button icon icon-save" tooltip="Báo cáo" />--%>
                               
                            </li>
                            <li class="menu-item icon-only">
                                <a id='btnBaoCaoNhapXuatTonThanhPhamCancel' class='menu-bar-item-button icon cancel-icon' href='/Administrator/QuanLyDonHang/DonHang/default.aspx?page=dsdonhang' title='Quay lại'></a>
                            </li>
                        </ul>
                    </div>
                    <div class="work-item-view" style="margin-left: 10px; width: 100%; margin: 0px auto; padding: 0px 10px; margin-bottom: 10px;">
                        <div class="work-item-form">
                            <div class="work-item-view" style="margin-left: 10px;">
                                <table class="witform-layout">
                                    <tbody>
                                        <tr>
                                            <td style="width: 100px;"></td>
                                            <td style="width: 40%;"></td>
                                            <td style="width: 100px;"></td>
                                            <td style="width: 40%;"></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div>
                                                    <span>Kho</span>
                                                    <span style="color: red">*</span>
                                                </div>
                                            </td>
                                            <td colspan="3">
                                                <div class="workitemcontrol kho-select" style="border: 1px solid #e6e6e6;">
                                                    <asp:Label ID="lblKhoThanhPhamSelect" runat="server" EnableViewState="true" ClientIDMode="Static" ViewStateMode="Enabled"></asp:Label>
                                                    <asp:TextBox ID="txtKhoThanhPham" runat="server" TabIndex="2" Width="100" BorderWidth="0" Style="outline: none;"></asp:TextBox>
                                                    <asp:HiddenField ID="slcKhoThanhPham" runat="server" ClientIDMode="Static" />
                                                </div>
                                                <div style="display: none;">
                                                    <asp:TextBox ID="txtKhoThanhPhamSelect" runat="server" Rows="100"></asp:TextBox>
                                                </div>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td>
                                                <div>
                                                    <span>Mặt hàng</span>
                                                    <span style="color: red">*</span>
                                                </div>
                                            </td>
                                            <td colspan="3">
                                                <div class="workitemcontrol vattu-select" style="border: 1px solid #e6e6e6;">

                                                    <asp:Label ID="lblMatHangThanhPham" runat="server" CssClass="txtmathang-select"> </asp:Label>
                                                    <asp:TextBox ID="txtMatHangThanhPham" runat="server" CssClass="input" TabIndex="2" Width="100" BorderWidth="0" Style="outline: none;"></asp:TextBox>
                                                    <asp:HiddenField ID="slcMatHangThanhPham" runat="server" ClientIDMode="Static" />

                                                </div>
                                                <div style="display: none;">
                                                    <asp:TextBox ID="txtMatHangThanhPhamSelect" runat="server" Rows="100"></asp:TextBox>
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
                                                            <asp:TextBox ID="txtTuNgayThanhPham" CssClass="cus-datepicker" runat="server" TabIndex="1"></asp:TextBox>
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
                                                            <asp:TextBox ID="txtDenNgayThanhPham" CssClass="cus-datepicker" runat="server" TabIndex="2" Width="100%"></asp:TextBox>
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


        <script type="text/javascript">
            $(document).ready(function () {
                $('.cus-datepicker').datetimepicker({
                    mask: '99/99/9999', timepicker: false,
                    format: 'd/m/Y',
                });


                ///Giữ lại giá tri khi postback
                $('#<%=lblKhoThanhPhamSelect.ClientID%>').append($('#<%=txtKhoThanhPhamSelect.ClientID%>').val());

                $('#<%=lblMatHangThanhPham.ClientID%>').append($('#<%=txtMatHangThanhPhamSelect.ClientID%>').val());


                queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataKhoVatTuNVLorThanhPhamForAutoComplete", "{TYPE:2}", function (result) {
                    var objJSON = JSON.parse(result.d);
                    $('#<%=txtKhoThanhPham.ClientID%>').autocomplete({
                        lookup: objJSON,
                        lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                            if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }

                        },
                        onSelect: function (suggestion) {
                            var data = $('#<%=slcKhoThanhPham.ClientID%>').val();
                            if ((',' + data + ',').indexOf(',' + suggestion.data + ',') < 0) {
                                var strData = "<span  id='sp-" + suggestion.data + "' style='background:silver;margin-right:2px;' value=" + suggestion.data + ">" + suggestion.value + " <span> <img src='/Styles/images/editdelete.png' span-id='sp-" + suggestion.data + "' value='" + suggestion.data + "' style=' width: 12px;cursor: pointer;' onclick='removeDataKho(this)' /></span></span>";

                                $('#<%=lblKhoThanhPhamSelect.ClientID%>').append(strData);
                                $('#<%=txtKhoThanhPhamSelect.ClientID%>').val($('#<%=txtKhoThanhPhamSelect.ClientID%>').val() + strData);

                                data += ',' + suggestion.data;
                                data = data.replace(',,', ',');
                                $('#<%=slcKhoThanhPham.ClientID%>').val(data);
                            }
                            $('#<%=txtKhoThanhPham.ClientID%>').val('');

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
                    $('#<%=txtKhoThanhPham.ClientID%>').focus();
                });

                //Mặt hàng
                queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataMatHangThanhPhamForAutoComplete", {}, function (result) {
                    var objJSON = JSON.parse(result.d);
                    $('#<%=txtMatHangThanhPham.ClientID%>').autocomplete({
                        lookup: objJSON,
                        lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                            if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }

                        },
                        onSelect: function (suggestion) {
                            var data = $('#<%=slcMatHangThanhPham.ClientID%>').val();
                            if ((',' + data + ',').indexOf(',' + suggestion.data + ',') < 0) {

                                var strData = "<span  id='sp-" + suggestion.data + "' style='background:silver;margin-right:2px;' value=" + suggestion.data + ">" + suggestion.value + " <span> <img src='/Styles/images/editdelete.png' span-id='sp-" + suggestion.data + "' value='" + suggestion.data + "' style=' width: 12px;cursor: pointer;' onclick='removeDataMatHangThanhPham(this)' /></span></span>";

                                $('#<%=lblMatHangThanhPham.ClientID%>').append(strData);
                                $('#<%=txtMatHangThanhPhamSelect.ClientID%>').val($('#<%=txtMatHangThanhPhamSelect.ClientID%>').val() + strData);

                                data += ',' + suggestion.data;
                                data = data.replace(',,', ',');
                                $('#<%=slcMatHangThanhPham.ClientID%>').val(data);
                            }
                            $('#<%=txtMatHangThanhPham.ClientID%>').val('');
                        },
                        onHint: function (hint) {
                        },
                        onInvalidateSelection: function () {
                        }
                    });
                });

            });

            function removeDataMatHangThanhPham(ctr) {
                var dataMatHangThanhPham = ',' + $('#<%=slcMatHangThanhPham.ClientID%>').val() + ',';
                dataMatHangThanhPham = dataMatHangThanhPham.replace(',,', ',');
                dataMatHangThanhPham = dataMatHangThanhPham.replace(',' + $(ctr).attr('value') + ',', ',');
                dataMatHangThanhPham = dataMatHangThanhPham.replace(',,', ',');
                $('#<%=slcMatHangThanhPham.ClientID%>').val(dataMatHangThanhPham);
                $('#' + $(ctr).attr('span-id')).remove();
            }

            function removeDataKho(ctr) {
                var dataKho = ',' + $('#<%=slcKhoThanhPham.ClientID%>').val() + ',';
                dataKho = dataKho.replace(',,', ',');
                dataKho = dataKho.replace(',' + $(ctr).attr('value') + ',', ',');
                dataKho = dataKho.replace(',,', ',');
                $('#<%=slcKhoThanhPham.ClientID%>').val(dataKho);
                $('#' + $(ctr).attr('span-id')).remove();
            }
        </script>


    </asp:Panel>
    <asp:Panel runat="server" ID="pnBaoCaoSanXuatTongHop" Visible="false">
        <div class="rightPane" style="left: 0px;">
            <div class="right-hub-content">
                <div class="work-item-form">
                    <div class="workitem-info-bar">
                        <div class="info-text-wrapper">
                            <span class="info-text">
                                <asp:Literal ID="lblBaoCaoSanXuatTongHop" runat="server"></asp:Literal>
                            </span>
                        </div>

                    </div>
                    <div class="toolbar workitem-tool-bar" style="display: block;">
                        <ul class="menu-bar">
                            <li class="menu-item icon-only">
                                <asp:Button ID="btnBaoCaoSanXuatTongHop" runat="server" CssClass="menu-bar-item-button icon icon-export" ToolTip="Báo cáo" OnClick="btnBaoCaoSanXuatTongHop_Click" />
                                <%-- <a id="btnReportInput" class="menu-bar-item-button icon icon-save" tooltip="Báo cáo" />--%>
                               
                            </li>
                            <li class="menu-item icon-only">
                                <a id='btnBaoCaoSanXuatTongHopCancel' class='menu-bar-item-button icon cancel-icon' href='/Business/QuanLySanXuat/Default.aspx?page=lsx' title='Quay lại'></a>
                            </li>
                        </ul>
                    </div>
                    <div class="work-item-view" style="margin-left: 10px; width: 100%; margin: 0px auto; padding: 0px 10px; margin-bottom: 10px;">
                        <div class="work-item-form">
                            <div class="work-item-view" style="margin-left: 10px;">
                                <table class="witform-layout">
                                    <tbody>
                                        <tr>
                                            <td style="width: 100px;"></td>
                                            <td style="width: 40%;"></td>
                                            <td style="width: 100px;"></td>
                                            <td style="width: 40%;"></td>
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
                                                            <asp:TextBox ID="txtBaoCaoSanXuatTongHopTuNgay" CssClass="cus-datepicker" runat="server" TabIndex="1"></asp:TextBox>
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
                                                            <asp:TextBox ID="txtBaoCaoSanXuatTongHopDenNgay" CssClass="cus-datepicker" runat="server" TabIndex="2" Width="100%"></asp:TextBox>
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


        <script type="text/javascript">
            $(document).ready(function () {
                $('.cus-datepicker').datetimepicker({
                    mask: '99/99/9999', timepicker: false,
                    format: 'd/m/Y',
                });
            });

        </script>


    </asp:Panel>
    <div style="min-height: 700px;">
        <rsweb:ReportViewer ID="rpViewer" runat="server" ShowPrintButton="true" Width="100%" Height="100%"></rsweb:ReportViewer>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function () {
        $('.cus-datepicker').datetimepicker({
            mask: '99/99/9999', timepicker: false,
            format: 'd/m/Y',
        });
    });
</script>
