<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddOrEditPhieuYeuCauVatTuChiTiet.ascx.cs" Inherits="xRP.Business.QuanLySanXuat.YeuCauVatTu.AddOrEditPhieuYeuCauVatTuChiTiet" %>

<script type="text/javascript">
    function formatNumber(num, tp) {
        if ($.isNumeric(num)) {
            num = parseFloat(num);
            var tpInput = 2;
            if (tp != null && $.isNumeric(tp) && tp >= 0)
                tpInput = tp;

            var p = num.toFixed(tpInput).split(".");

            if (tpInput == 0)
                return p[0].split("").reverse().reduce(function (acc, num, i, orig) {
                    return num + (i && !(i % 3) ? "." : "") + acc;
                }, "");
            else
                return p[0].split("").reverse().reduce(function (acc, num, i, orig) {
                    return num + (i && !(i % 3) ? "." : "") + acc;
                }, "") + "," + p[1];

        }
        return 0;
    }
    var dataVatTu = [];
    $(document).ready(function () {
        dataVatTu = JSON.parse('<%=DataVatTu%>');
        queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataVatTuByTenForAutoComplete", {}, function (result) {
            var objJSON = JSON.parse(result.d);
            $('#<%=txtTenVatTu.ClientID%>').autocomplete({
                lookup: objJSON,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }

                },
                onSelect: function (suggestion) {
                    $('#<%=txtMaVatTu.ClientID%>').val(suggestion.data);
                    $('#<%=txtTenVatTu.ClientID%>').trigger("change");
                },
                onHint: function (hint) {
                },
                onInvalidateSelection: function () {
                    $('#<%=txtMaVatTu.ClientID%>').val("");
                    $('#<%=txtTenVatTu.ClientID%>').trigger("change");
                }
            });
        });

        /*
        Load vat tu data
        */
        var i = 0;
        var currentVatTuYeuCauChiTiet = {};
        for (i = 0; i < dataChiTiet.length; i++) {
            if (dataChiTiet[i].data.RandomID == '<%=randID%>') {
                currentVatTuYeuCauChiTiet = dataChiTiet[i];
                bindCurrentData(currentVatTuYeuCauChiTiet.data);
                break;
            }
        }
        if (i == dataChiTiet.length) {
            currentVatTuYeuCauChiTiet = new PhieuYeuCauVatTuChiTiet();
            bindCurrentData(currentVatTuYeuCauChiTiet.data);
        }

        $(currentVatTuYeuCauChiTiet).on("DataChanged", function (evt) {
            switch (evt.fieldName) {
                case "IDVatTu":
                    $("#<%=txtMaVatTu.ClientID%>").val(evt.value);
                    break;
                case "TenVatTu":
                    $("#<%=txtTenVatTu.ClientID%>").val(evt.value);
                    break;
                case "IDDonViTinh":
                    $("#<%=txtDonViTinhID.ClientID%>").val(evt.value);
                    break;
                case "DonViTinh":
                    $("#<%=txtDonViTinh.ClientID%>").val(evt.value);
                    break;
                case "DonViTinhID":
                    $("#<%=txtDonViTinhID.ClientID%>").val(evt.value);
                    break;
                case "SoLuongYeuCau":
                    $("#<%=txtSoLuongYeuCau.ClientID%>").val(evt.value);
                    break;
                case "GhiChu":
                    $("#<%=txtGhiChu.ClientID%>").val(evt.value);
                    break;
            }
        });

        $("#<%=txtTenVatTu.ClientID%>").focus();

        $("#<%=txtTenVatTu.ClientID%>").on("change", function () {
            var tenVatTu = $("#<%=txtTenVatTu.ClientID%>").val();
            var $this = this;
            queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataVatTu", "", function (result) {
                var list = $.parseJSON(result.d);
                for (var i = 0; i < list.length; i++) {
                    if (list[i].MaVatTu.trim().toLowerCase() + " - " + list[i].TenVatTu.toLowerCase() == $this.value.toLowerCase()) {

                        currentVatTuYeuCauChiTiet.setPhieuYeuCauVatTuID(parseInt('<%= phieuYeuCauID%>'));
                        currentVatTuYeuCauChiTiet.setMaVatTu(list[i].ID);
                        currentVatTuYeuCauChiTiet.setMaHieuVatTu(list[i].MaVatTu);

                        if (list[i].MaVatTu != '')
                            currentVatTuYeuCauChiTiet.setTenVatTu(list[i].MaVatTu + " - " + list[i].TenVatTu);
                        else currentVatTuYeuCauChiTiet.setTenVatTu(list[i].TenVatTu);

                        currentVatTuYeuCauChiTiet.setMaDonViTinh(list[i].DonViTinhID);
                        currentVatTuYeuCauChiTiet.setTenDonViTinh(list[i].DonViTinh);
                        currentVatTuYeuCauChiTiet.setSoLuongYeuCau(0);
                        currentVatTuYeuCauChiTiet.setTinhTrang(0);
                        currentVatTuYeuCauChiTiet.setGhiChu('');
                    }
                }

            });
        });


        $("#<%=txtSoLuongYeuCau.ClientID%>").on("change", function () {
            if ($.isNumeric(this.value)) {
                currentVatTuYeuCauChiTiet.setSoLuongYeuCau(this.value);
                //  console.log(currentVatTuYeuCauChiTiet.data.SoLuongYeuCau);
            } else {
                alert("Dữ liệu sai, xin hãy thử lại");
                this.value = 0;
                this.focus();
            }
        });

        $("#<%=txtGhiChu.ClientID%>").on("change", function () {
            currentVatTuYeuCauChiTiet.setGhiChu(this.value);
        });

        $("#btnSave").on("click", function () {

            var phieuYeuCauChiTietId = parseInt('<%=phieuYeuCauChiTietID%>');
            var ranId = parseInt('<%=randID%>');

            if (!currentVatTuYeuCauChiTiet.data.IDVatTu) {
                alert("Bạn chưa chọn vật tư");
                $("#<%=txtMaVatTu.ClientID%>").focus();
                return;
            }
            currentVatTuYeuCauChiTiet.data.RandomID = ranId;
            //if (phieuYeuCauChiTietId < 1)
            //    currentVatTuYeuCauChiTiet.data.RandomID = generateUUID();
            //else
            //    currentVatTuYeuCauChiTiet.data.RandomID = phieuYeuCauChiTietId;

            $("#<%=txtDonViTinh.ClientID%>").val(currentVatTuYeuCauChiTiet.data.DonViTinh);
            $("#<%=txtDonViTinhID.ClientID%>").val(currentVatTuYeuCauChiTiet.data.IDDonViTinh);

            if (currentVatTuYeuCauChiTiet.data.SoLuongYeuCau <= 0) {
                alert("Bạn chưa nhập số lượng yêu cầu");
                $("#<%=txtSoLuongYeuCau.ClientID%>").focus();
                return;
            }

            var isExisted = false;

            for (var i = 0; i < dataChiTiet.length; i++) {

                if (dataChiTiet[i].data.RandomID == currentVatTuYeuCauChiTiet.data.RandomID) {
                    isExisted = true;
                }
            }

            if (!isExisted) {
                dataChiTiet.push(currentVatTuYeuCauChiTiet);
            }

            bindDataChiTiet(dataChiTiet);

            CloseModal();


        });
    });

    function bindCurrentData(data) {
        if (data.MaHieuVatTu != null || data.MaHieuVatTu != '' || data.MaHieuVatTu != 'undefined') {
            $("#<%=txtMaVatTu.ClientID%>").val(data.IDVatTu);
            $("#<%=txtMaHieuVatTu.ClientID%>").val(data.MaHieuVatTu);

            if (data.MaHieuVatTu.length > 0)
                $("#<%=txtTenVatTu.ClientID%>").val(data.MaHieuVatTu + " - " + data.TenVatTu);
            else
                $("#<%=txtTenVatTu.ClientID%>").val(data.TenVatTu);
        }
        $("#<%=txtDonViTinh.ClientID%>").val(data.DonViTinh);
        $("#<%=txtDonViTinhID.ClientID%>").val(data.IDDonViTinh);
        $("#<%=txtSoLuongYeuCau.ClientID%>").val(formatNumber(data.SoLuongYeuCau, 0));
        $("#<%=txtGhiChu.ClientID%>").val(data.GhiChu);
    }


</script>

<div class="work-item-form">
    <div class="work-item-view">
        <table class="witform-layout">
            <tbody>
                <tr>
                    <td style="width: 18%;"></td>
                    <td style="width: 32%;"></td>
                    <td style="width: 18%;"></td>
                    <td style="width: 32%;"></td>
                </tr>
                <tr>
                    <td>Vật tư
                    </td>
                    <td colspan="3">
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:HiddenField ID="txtMaHieuVatTu" runat="server" />
                                    <asp:HiddenField ID="txtMaVatTu" runat="server" />
                                    <asp:TextBox ID="txtTenVatTu" runat="server" />
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td>Đơn vị tính
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ID="txtDonViTinh" runat="server" Enabled="false" />
                                    <asp:HiddenField ID="txtDonViTinhID" runat="server" />
                                </div>
                            </div>
                        </div>
                    </td>

                    <td>Số lượng yêu cầu 
                        <%--SoLuongYeuCau--%>
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ID="txtSoLuongYeuCau" runat="server" />
                                </div>
                            </div>
                        </div>
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
    </div>
</div>
<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix button-list">
    <input type="button" id="btnSave" class="xrp-button" value="Lưu" />
    <input type="button" class="xrp-button" onclick="CloseModal();" value="Hủy" />
</div>
