<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddOrEditChiTietPhieuKiemTraVatTuNhap.ascx.cs" Inherits="xRP.Business.QuanLyVatTu.KiemTraVatTuNhap.AddOrEditChiTietPhieuKiemTraVatTuNhap" %>

<script type="text/javascript">
    var dataVatTu = [];
    function loadVatTu() {
        queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataVatTuByTenForAutoComplete", {}, function (result) {
            var objJSON = JSON.parse(result.d);
            $('#<%=txtTenVatTu.ClientID%>').autocomplete({
                lookup: objJSON,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }

                },
                onSelect: function (suggestion) {
                    $('#<%=txtMaVatTu.ClientID%>').val(suggestion.data);
                    currentVatTuNhap.MaHieuVatTu.setValue(suggestion.data);
                },
                onHint: function (hint) {
                },
                onInvalidateSelection: function () {
                    $('#<%=txtMaVatTu.ClientID%>').val("");
                    currentVatTuNhap.MaHieuVatTu.setValue("");
                }
            });
        });
    }
    $(document).ready(function () {
        $("#<%=txtTenVatTu.ClientID%>").focus();
        if (isEditable) {
            $("#btnSave").css("display", "");
        } else {
            $("#btnSave").css("display", "none");
            $("#<%=txtTenVatTu.ClientID%>").attr("disabled", "disabled");
            $("#<%=txtMaCuon.ClientID%>").attr("disabled", "disabled");
            $("#<%=txtGiaNhap.ClientID%>").attr("disabled", "disabled");
            $("#<%=txtDinhLuongThucTe.ClientID%>").attr("disabled", "disabled");
            $("#<%=txtKichThuocThucTe.ClientID%>").attr("disabled", "disabled");
            $("#<%=txtSoLuongDauCuon.ClientID%>").attr("disabled", "disabled");
            $("#<%=txtSoLuongLamPhieu.ClientID%>").attr("disabled", "disabled");
            $("#<%=txtGhiChu.ClientID%>").attr("disabled", "disabled");
        }
        dataVatTu = JSON.parse('<%=DataVatTu%>');

        /*
        Load vat tu data
        */
        var i = 0;
        var currentVatTuNhap = {};
        for (i = 0; i < dataChiTiet.length; i++) {
            if (dataChiTiet[i].GUID == "<%=ID_VatTu%>") {
                currentVatTuNhap = dataChiTiet[i];
                currentVatTuNhap.MaHieuNhaCungCap.setValue($('#slcTenNhaCungCap').val());
                bindCurrentData(currentVatTuNhap);
                break;
            }
        }
        if (i == dataChiTiet.length) {
            currentVatTuNhap = new VatTuNhap();
            currentVatTuNhap.MaHieuNhaCungCap.setValue($('#slcTenNhaCungCap').val());
            bindCurrentData(currentVatTuNhap);
        }
        var maPhieuXuat = $("#slcPhieuXuat").val();
        if (maPhieuXuat) {
            queryData("Default.aspx/GetVatTuXuatJSON", "{idPhieuXuat:'" + maPhieuXuat + "'}", function (result) {
                var objJSON = JSON.parse(result.d);
                $('#<%=txtTenVatTu.ClientID%>').autocomplete({
                    lookup: objJSON,
                    lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                        if (queryLowerCase == "*") { return true; }
                        if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }
                    },
                    onSelect: function (suggestion) {
                        $('#<%=txtMaVatTu.ClientID%>').val(suggestion.data);
                        currentVatTuNhap.MaHieuVatTu.setValue(suggestion.data);
                    },
                    onHint: function (hint) {
                    },
                    onInvalidateSelection: function () {
                        $('#<%=txtMaVatTu.ClientID%>').val("");
                        currentVatTuNhap.MaHieuVatTu.setValue("");
                    }
                });
            });
        } else {
            queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataVatTuByTenForAutoComplete", {}, function (result) {
                var objJSON = JSON.parse(result.d);
                $('#<%=txtTenVatTu.ClientID%>').autocomplete({
                lookup: objJSON,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }

                },
                onSelect: function (suggestion) {
                    $('#<%=txtMaVatTu.ClientID%>').val(suggestion.data);
                    //$('#<%=txtTenVatTu.ClientID%>').trigger("change");
                    currentVatTuNhap.MaHieuVatTu.setValue(suggestion.data);
                },
                onHint: function (hint) {
                },
                onInvalidateSelection: function () {
                    $('#<%=txtMaVatTu.ClientID%>').val("");
                    currentVatTuNhap.MaHieuVatTu.setValue("");
                    //$('#<%=txtTenVatTu.ClientID%>').trigger("change");
                }
            });
            });
        }

        $(currentVatTuNhap).on("DataChanged", function (evt) {
            $("[data-field='" + evt.fieldName + "']").val(evt.value);
            //Canh bao so luong
            if (evt.fieldName === "SoLuongDauCuon" || evt.fieldName === "SoLuongLamPhieuNhap") {
                if (currentVatTuNhap.SoLuongDauCuon.Value && currentVatTuNhap.SoLuongLamPhieuNhap.Value) {
                    if (currentVatTuNhap.SoLuongDauCuon.Value < currentVatTuNhap.SoLuongLamPhieuNhap.Value) {
                        alert("Số lượng đầu cuộn không được nhỏ hơn số lượng làm phiếu nhập");
                        if (evt.fieldName !== "SoLuongDauCuon") {
                            setTimeout(function () {
                                $("[data-field='SoLuongDauCuon']").focus();
                            }, 100);
                        }
                        return false;
                    }
                }
            }
        });
        $("[data-field]").on("blur", function (evt) {
            var field = $(this).attr("data-field");
            if (!currentVatTuNhap[field].setValue(this.value)) {
                $(this).val("");
                evt.stopPropagation();
                evt.preventDefault();
                setTimeout(function () {
                    $("[data-field='" + field + "']").focus();
                }, 100);
                return false;
            }
        });

        $("#btnSave").on("click", function () {
            if (!currentVatTuNhap.MaVatTu.Value) {
                alert("Bạn chưa chọn vật tư");
                $("#<%=txtMaVatTu.ClientID%>").focus();
                return;
            }
            if (!currentVatTuNhap.DonGia.Value) {
                currentVatTuNhap.DonGia.Value = 0;
            }
            if (!currentVatTuNhap.SoLuongDauCuon.Value) {
                alert("Bạn chưa nhập số lượng đầu cuộn");
                $("#<%=txtSoLuongDauCuon.ClientID%>").focus();
                return;
            }
            if (!currentVatTuNhap.SoLuongLamPhieuNhap.Value) {
                alert("Bạn chưa nhập số lượng làm phiếu nhập");
                $("#<%=txtSoLuongLamPhieu.ClientID%>").focus();
                return;
            }
            if (currentVatTuNhap.SoLuongLamPhieuNhap.Value > currentVatTuNhap.SoLuongDauCuon.Value) {
                setTimeout(function () {
                    $("[data-field='SoLuongDauCuon']").focus();
                }, 100);
                alert("Số lượng làm phiếu nhập không được lớn hơn số lượng đầu cuộn");
                return;
            }
            if (!currentVatTuNhap.DinhLuongThucTe.Value) {
                alert("Bạn chưa nhập định lượng thực tế");
                $("#<%=txtDinhLuongThucTe.ClientID%>").focus();
                return;
            }
            if (!currentVatTuNhap.KichThuocThucTe.Value) {
                alert("Bạn chưa nhập kích thước thực tế");
                $("#<%=txtKichThuocThucTe.ClientID%>").focus();
                return;
            }
            var isExisted = false;
            for (var i = 0; i < dataChiTiet.length; i++) {
                if (dataChiTiet[i].GUID == currentVatTuNhap.GUID) {
                    isExisted = true;
                }
            }
            if (!isExisted) {
                dataChiTiet.push(currentVatTuNhap);
            }
            bindDataChiTiet(dataChiTiet);
            CloseModal();
        });
        $.each($("[data-field]"), function () {
            var field = $(this).attr("data-field");
            if (currentVatTuNhap[field] && (currentVatTuNhap[field].Type === "int" || currentVatTuNhap[field].Type === "float")) {
                $(this).css("text-align", "right");
            }
        });
    });

    function bindCurrentData(data) {
        if (data.MaHieuVatTu.Value != "") {
            $("#<%=txtMaVatTu.ClientID%>").val(data.MaHieuVatTu.Value);
            $("#<%=txtTenVatTu.ClientID%>").val(data.MaHieuVatTu.Value + " - " + data.TenVatTu.Value);
        }
        $("#<%=txtMaCuon.ClientID%>").val(data.MaCuon.Value);
        $("#<%=txtDonViTinh.ClientID%>").val(data.DonViTinh.Value);
        $("#<%=txtGiaNhap.ClientID%>").val(data.DonGia.Value);
        $("#<%=txtSoLuongThucNhap.ClientID%>").val(data.SoLuongThucNhap.Value);
        $("#<%=txtSoLuongDauCuon.ClientID%>").val(data.SoLuongDauCuon.Value);
        $("#<%=txtSoLuongLamPhieu.ClientID%>").val(data.SoLuongLamPhieuNhap.Value);
        $("#<%=txtDinhLuongTieuChuan.ClientID%>").val(data.DinhLuongTieuChuan.Value);
        $("#<%=txtDinhLuongThucTe.ClientID%>").val(data.DinhLuongThucTe.Value);
        $("#<%=txtKichThuocTieuChuan.ClientID%>").val(data.KichThuocTieuChuan.Value);
        $("#<%=txtKichThuocThucTe.ClientID%>").val(data.KichThuocThucTe.Value);
        $("#<%=txtChenhLechDinhLuong.ClientID%>").val(data.ChenhLechDinhLuong.Value);
        $("#<%=txtDinhLuongTru.ClientID%>").val(data.DinhLuongTinhTru.Value);
        $("#<%=txtTruKichThuoc.ClientID%>").val(data.TruThuaKichThuoc.Value);
        $("#<%=txtKhoiLuongTru.ClientID%>").val(data.KhoiLuongTru.Value);
        $("#<%=txtTruLoi.ClientID%>").val(data.TruLoi.Value);
        $("#<%=txtSoLuongChenhLech.ClientID%>").val(data.SoLuongChenhLechKhongTinh.Value);
        $("#<%=txtThanhTien.ClientID%>").val(data.ThanhTien.Value);
        $("#<%=txtGhiChu.ClientID%>").val(data.GhiChu.Value);
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
                            <div class="combo tree drop" style="background-color: transparent;">
                                <div class="wrap">
                                    <asp:HiddenField ID="txtMaVatTu" runat="server" />
                                    <asp:TextBox ID="txtTenVatTu" runat="server" Width="97%" />
                                    <a title="Tải lại dữ liệu" class="icon icon-refresh" id="btnRefresh" onclick="loadVatTu(); return false;"></a>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Mã cuộn
                    </td>
                    <td colspan="3">
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtMaCuon" runat="server" />
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
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>Giá nhập
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ID="txtGiaNhap" runat="server" />
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Số lượng đầu cuộn
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ID="txtSoLuongDauCuon" runat="server" />
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>Số lượng làm phiếu nhập
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ID="txtSoLuongLamPhieu" runat="server" />
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Định lượng tiêu chuẩn
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ID="txtDinhLuongTieuChuan" runat="server" Enabled="false" Text="0" />
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>Định lượng thực tế
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ID="txtDinhLuongThucTe" runat="server" />
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Kích thước tiêu chuẩn(mm)
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ID="txtKichThuocTieuChuan" runat="server" Enabled="false" Text="0" />
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>Kích thước thực tế(mm)
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ID="txtKichThuocThucTe" runat="server" />
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>

                    <td>Chênh lệch định lượng
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ID="txtChenhLechDinhLuong" runat="server" Enabled="false" Text="0" />
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>Định lượng tính trừ
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ID="txtDinhLuongTru" runat="server" Text="0" Enabled="false" />
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Trừ thừa kích thước(Kg)
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ID="txtTruKichThuoc" runat="server" Text="0" Enabled="false" />
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>Khối lượng trừ
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ID="txtKhoiLuongTru" runat="server" Text="0" Enabled="false" />
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Trừ lõi
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ID="txtTruLoi" runat="server" Enabled="false" Text="0" />
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>Số lượng thực nhập
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ID="txtSoLuongThucNhap" runat="server" Enabled="false" Text="0" />
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Số lượng chênh lệch
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ID="txtSoLuongChenhLech" runat="server" Text="0" Enabled="false" />
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>Thành tiền
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ID="txtThanhTien" runat="server" Text="0" Enabled="false" />
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
