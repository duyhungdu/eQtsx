<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="XtraReportViewer.ascx.cs" Inherits="xRP.Report.XtraReportViewer" %>
<%@ Register Assembly="DevExpress.XtraReports.v15.1.Web, Version=15.1.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>
<style type="text/css">
    .witform-layout {
        margin: 0px 0px 10px 0px;
    }
</style>
<div class="splitter horizontal hub-splitter stateful toggle-button-enabled toggle-button-hotkey-enabled">
    <div class="rightPane" style="left: 0px;">
        <div class="hub-title">
            <div class="query-result-grid-info">
                <table>
                    <tbody>
                        <tr>
                            <td class="query-title"></td>
                            <td class="query-status hub-title-right"></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="right-hub-content">
            <div class="work-item-form" style="display: block;">
                <div class="workitem-info-bar">
                    <div class="info-text-wrapper">
                        <span class="info-text">
                            <asp:Literal ID="ltTitle" runat="server"></asp:Literal></span>
                    </div>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block;">
                    <ul class="menu-bar">
                        <li class="menu-item icon-only" style="display: <%=display_baocaonhapxuatton%>;">
                            <asp:Button ID="btnBaoCaoNhapXuatTon" runat="server" CssClass="menu-bar-item-button icon icon-export" ToolTip="Báo cáo" OnClick="btnBaoCaoNhapXuatTon_Click" />
                        </li>
                        <li class="menu-item icon-only" style="display: <%=display_baocaosanxuatgiaohang%>;">
                            <asp:Button ID="btnBaoCaoSanXuatGiaoHang" runat="server" CssClass="menu-bar-item-button icon icon-export" ToolTip="Báo cáo" OnClick="btnBaoCaoSanXuatGiaoHang_Click" />
                        </li>
                        <li class="menu-item icon-only" style="display: <%=display_baocaotonghopcongdoansong%>;">
                            <asp:Button ID="btnBaoCaoTongHopCongDoanSong" runat="server" CssClass="menu-bar-item-button icon icon-export" ToolTip="Báo cáo" OnClick="btnBaoCaoTongHopCongDoanSong_Click" />
                        </li>
                         <li class="menu-item icon-only" style="display: <%=display_baocaosanxuattonghop%>;">
                            <asp:Button ID="btnBaoCaoSanXuatTongHop" runat="server" CssClass="menu-bar-item-button icon icon-export" ToolTip="Báo cáo" OnClick="btnBaoCaoSanXuatTongHop_Click" />
                        </li>
                        <li class="menu-item icon-only">
                            <asp:Literal ID="ltBack" runat="server"></asp:Literal>
                        </li>
                    </ul>
                </div>
                <div class="work-item-view">
                    <asp:Panel ID="pnlBaoCaoNhapXuatTonVatTu" Visible="false" runat="server">
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
                                        </div>
                                    </td>
                                    <td colspan="3">
                                        <div class="workitemcontrol kho-select" style="border: 1px solid #e6e6e6;">
                                            <asp:Label ID="lblKhoSelect" runat="server" EnableViewState="true" ClientIDMode="Static" ViewStateMode="Enabled"></asp:Label>
                                            <asp:TextBox ID="txtKho" runat="server" Width="200" BorderWidth="0" Style="outline: none;"></asp:TextBox>
                                            <asp:HiddenField ID="slcKho" runat="server" ClientIDMode="Static" />
                                        </div>
                                        <div style="display: none;">
                                            <asp:TextBox ID="txtKhoSelect" runat="server" Rows="100"></asp:TextBox>
                                        </div>
                                    </td>
                                </tr>
                                <tr style="display: none;">
                                    <td>
                                        <div>
                                            <span>Loại vật tư</span>
                                        </div>
                                    </td>
                                    <td colspan="3">
                                        <div class="workitemcontrol loaivattu-select" style="border: 1px solid #e6e6e6;">
                                            <span id="txtloaivattu-select"></span>
                                            <asp:TextBox ID="txtLoaiVatTu" runat="server" Width="200" BorderWidth="0" Style="outline: none;"></asp:TextBox>
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
                                        </div>
                                    </td>
                                    <td colspan="3">
                                        <div class="workitemcontrol vattu-select" style="border: 1px solid #e6e6e6;">
                                            <asp:Label ID="lblVatTu" runat="server" CssClass="txtvattu-select"> </asp:Label>
                                            <asp:TextBox ID="txtVatTu" runat="server" CssClass="input" Width="320" BorderWidth="0" Style="outline: none;"></asp:TextBox>
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
                                        </div>
                                    </td>
                                    <td colspan="3">
                                        <div class="workitemcontrol nhacungcap-select" style="border: 1px solid #e6e6e6;">
                                            <asp:Label ID="lblNhaCungCap" runat="server" CssClass="txtnhacungcap-select"> </asp:Label>
                                            <asp:TextBox ID="txtNhaCungCap" runat="server" CssClass="input" Width="300" BorderWidth="0" Style="outline: none;"></asp:TextBox>
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
                                                    <asp:TextBox ID="txtDenNgay" CssClass="cus-datepicker" runat="server"></asp:TextBox>
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
                                                        <asp:ListItem Value="0" Selected="True" Text="Nhà cung cấp"></asp:ListItem>
                                                        <asp:ListItem Value="1" Text="Loại vật tư"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
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
                                                var strData = "<span  id='sp-" + suggestion.data + "' style='background:#f1f1f1;margin-right:2px;' value=" + suggestion.data + ">" + suggestion.value + " <span> <img src='/Styles/images/editdelete.png' span-id='sp-" + suggestion.data + "' value='" + suggestion.data + "' style=' width: 12px;cursor: pointer;' onclick='removeDataKho(this)' /></span></span>";

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
                                                var strData = "<span  id='sp-" + suggestion.ID + "' style='background:#f1f1f1;margin-right:2px;' value=" + suggestion.ID + ">" + suggestion.value + " <span> <img src='/Styles/images/editdelete.png' span-id='sp-" + suggestion.ID + "' value='" + suggestion.ID + "' style=' width: 12px;cursor: pointer;' onclick='removeDataVatTu(this)' /></span></span>";

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
                                                var strData = "<span  id='sp-" + suggestion.ID + "' style='background:#f1f1f1;margin-right:2px;' value=" + suggestion.ID + ">" + suggestion.value + " <span> <img src='/Styles/images/editdelete.png' span-id='sp-" + suggestion.ID + "' value='" + suggestion.ID + "' style=' width: 12px;cursor: pointer;' onclick='removeDataNhaCungCap(this)' /></span></span>";

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

                                                var strData = "<span  id='sp-" + suggestion.ID + "' style='background:#f1f1f1;margin-right:2px;' value=" + suggestion.ID + ">" + suggestion.value + " <span> <img src='/Styles/images/editdelete.png' span-id='sp-" + suggestion.ID + "' value='" + suggestion.ID + "' style=' width: 12px;cursor: pointer;' onclick='removeDataLoaiVatTu(this)' /></span></span>";

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
                    <asp:Panel ID="pnlBaoCaoSanXuatGiaoHang" Visible="false" runat="server">
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
                                        },
                                        onHint: function (hint) {
                                        },
                                        onInvalidateSelection: function () {
                                            $('#<%=hdfBCSXIDKhachHang.ClientID%>').val("0");
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
                    </asp:Panel>
                    <asp:Panel ID="pnlBaoCaoTongHopCongDoanSong" Visible="false" runat="server">
                        <script type="text/javascript">
                            $(document).ready(function () {
                                $('.cus-datepicker').datetimepicker({
                                    mask: '99/99/9999', timepicker: false,
                                    format: 'd/m/Y',
                                });
                            });
                        </script>
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
                                            <span>Từ ngày</span>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="workitemcontrol">
                                            <div class="combo tree drop short-control-50">
                                                <div class="wrap">
                                                    <asp:TextBox ID="txtTongHopSongTu" CssClass="cus-datepicker" runat="server"></asp:TextBox>
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
                                                    <asp:TextBox ID="txtTongHopSongDen" CssClass="cus-datepicker" runat="server"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td></td>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>
                    </asp:Panel>
                    <asp:Panel ID="pnlBaoCaoSanXuatTongHop" Visible="false" runat="server">
                        <script type="text/javascript">
                            $(document).ready(function () {
                                $('.cus-datepicker').datetimepicker({
                                    mask: '99/99/9999', timepicker: false,
                                    format: 'd/m/Y',
                                });
                            });
                        </script>
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
                                            <span>Từ ngày</span>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="workitemcontrol">
                                            <div class="combo tree drop short-control-50">
                                                <div class="wrap">
                                                    <asp:TextBox ID="txtBaoCaoTongHopTuNgay" CssClass="cus-datepicker" runat="server"></asp:TextBox>
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
                                                    <asp:TextBox ID="txtBaoCaoTongHopDenNgay" CssClass="cus-datepicker" runat="server"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td></td>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>
                    </asp:Panel>
                    <dx:ASPxDocumentViewer ID="ASPxDocumentViewer1" Visible="false" runat="server"></dx:ASPxDocumentViewer>
                </div>
            </div>
        </div>
    </div>
</div>
