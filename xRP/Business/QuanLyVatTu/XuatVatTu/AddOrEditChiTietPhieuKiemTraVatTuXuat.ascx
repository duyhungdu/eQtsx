<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddOrEditChiTietPhieuKiemTraVatTuXuat.ascx.cs" Inherits="xRP.Business.QuanLyVatTu.XuatVatTu.AddOrEditChiTietPhieuKiemTraVatTuXuat" %>

<script>
    var isXuatTraLai = false;
    $(document).ready(function () {
        var tinhChat = $("#ddlTinhChat").val();;
        if (tinhChat && dataTinhChatNhapXuat) {
            for (var i = 0; i < dataTinhChatNhapXuat.length; i++) {
                if (tinhChat == dataTinhChatNhapXuat[i].ID && dataTinhChatNhapXuat[i].TenTinhChatNhapXuat == "Xuất trả lại") {
                    isXuatTraLai = true;
                }
            }
        }
        /*
        Load vat tu data
        */
        if (!isEditable) {
            $("#btnSaveVatTu").css("display", "none");
            $("#<%=txtTenVatTu.ClientID%>").attr("disabled", "disabled");
            $("#<%=txtSoLuongDauCuon.ClientID%>").attr("disabled", "disabled");
            $("#<%=txtGiaXuat.ClientID%>").attr("disabled", "disabled");
            $("#<%=txtSoLuongLamPhieu.ClientID%>").attr("disabled", "disabled");
            $("#<%=txtDinhLuongThucTe.ClientID%>").attr("disabled", "disabled");
            $("#<%=txtKichThuocThucTe.ClientID%>").attr("disabled", "disabled");
            $("#<%=txtGhiChu.ClientID%>").attr("disabled", "disabled");
            $("#trSoLuongCuoiNgay").css("display", "none");
        }
        var i = 0;
        var currentVatTuXuat = {};
        for (i = 0; i < dataChiTiet.length; i++) {
            if (dataChiTiet[i].data.RandomID == "<%=ID_VatTu%>") {
                currentVatTuXuat = dataChiTiet[i];
                bindCurrentData(currentVatTuXuat.data);
                currentVatTuXuat.getThongTinVatTuByID();
                break;
            }
        }

        if (i == dataChiTiet.length) {
            currentVatTuXuat = new VatTuXuat();
            bindCurrentData(currentVatTuXuat.data);
        }

        $("#<%=txtTenVatTu.ClientID%>").focus();
        if (typeof (phieuYeuCau) != "undefined" && !phieuYeuCau) {
            queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataVatTuByKhoForAutoComplete", "{maKho:" + $("#slcKhoChua").val() + "}", function (result) {
                var objJSON = JSON.parse(result.d);
                $('#<%=txtTenVatTu.ClientID%>').autocomplete({
                    lookup: objJSON,
                    lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                        if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }
                    },
                    onSelect: function (suggestion) {
                        var existed = false;
                        for (var i = 0; i < dataChiTiet.length; i++) {
                            if (dataChiTiet[i].data.MaVatTuNhap == suggestion.ID) {
                                alert("Vật tư đã tồn tại, hãy chọn vật tư khác");
                                $('#<%=txtTenVatTu.ClientID%>').val("");
                            $('#<%=txtTenVatTu.ClientID%>').focus();
                            return;
                        }
                    }
                    if (!existed) {
                        currentVatTuXuat.setMaHieuVatTu(suggestion.data);
                        currentVatTuXuat.setMaVatTu(suggestion.ID);
                        $('#<%=txtMaVatTu.ClientID%>').val(suggestion.data);
                        $('#<%=txtTenVatTu.ClientID%>').trigger("change");
                    }
                },
                    onHint: function (hint) {
                    },
                    onInvalidateSelection: function () {
                        currentVatTuXuat.setMaHieuVatTu("");
                        $('#<%=txtMaVatTu.ClientID%>').val("");
                    $('#<%=txtTenVatTu.ClientID%>').trigger("change");
                    $('#<%=txtSoLuongTon.ClientID%>').val(0);
                }
                });
            });
    } else if (typeof (phieuYeuCau) != "undefined") {
        queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataVatTuByPYCForAutoComplete", "{id:" + phieuYeuCau + ",maKho:" + $("#slcKhoChua").val() + "}", function (result) {
            var objJSON = JSON.parse(result.d);
            $('#<%=txtTenVatTu.ClientID%>').autocomplete({
                lookup: objJSON,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }

                },
                onSelect: function (suggestion) {
                    var existed = false;
                    for (var i = 0; i < dataChiTiet.length; i++) {
                        if (dataChiTiet[i].data.MaVatTuNhap == suggestion.ID) {
                            alert("Vật tư đã tồn tại, hãy chọn vật tư khác");
                            $('#<%=txtTenVatTu.ClientID%>').val("");
                                $('#<%=txtTenVatTu.ClientID%>').focus();
                                return;
                            }
                        }
                        if (!existed) {
                            currentVatTuXuat.setMaHieuVatTu(suggestion.data);
                            currentVatTuXuat.setMaVatTu(suggestion.ID);
                            $('#<%=txtMaVatTu.ClientID%>').val(suggestion.data);
                            $('#<%=txtTenVatTu.ClientID%>').trigger("change");
                            //phamkhuong102
                            $('#<%=txtSoLuongTon.ClientID%>').val(suggestion.soLuongConLai);
                            colorSoLuongConLai(suggestion.soLuongConLai);
                        }
                    },
                    onHint: function (hint) {
                    },
                    onInvalidateSelection: function () {
                        currentVatTuXuat.setMaHieuVatTu("");
                        $('#<%=txtMaVatTu.ClientID%>').val("");
                        $('#<%=txtTenVatTu.ClientID%>').trigger("change");
                        $('#<%=txtSoLuongTon.ClientID%>').val(0);
                    }
                });
        });
        }

        $(currentVatTuXuat).on("DataChanged", function (evt) {
            switch (evt.fieldName) {
                case "MaHieuVatTu":
                    $("#<%=txtMaVatTu.ClientID%>").val(evt.value);
                    break;
                case "TenVatTu":
                    //$("#<%=txtTenVatTu.ClientID%>").val(evt.value);
                    break;
                case "DonViTinh":
                    $("#<%=txtDonViTinh.ClientID%>").val(evt.value);
                    break;
                case "DonGia":
                    $("#<%=txtGiaXuat.ClientID%>").val(evt.value);
                    break;
                case "SoLuongThucXuat":
                    $("#<%=txtSoLuongThucXuat.ClientID%>").val(evt.value);
                    break;
                case "SoLuongDauCuonBanDau":
                    $("#<%=txtSoLuongDauCuonBanDau.ClientID%>").val(evt.value);
                    colorSoLuongDauCuon(evt.value);
                    break;
                case "SoLuongTonTheoCuon":
                    $("#<%=txtSoLuongTon.ClientID%>").val(evt.value);
                    colorSoLuongConLai(evt.values);
                    break;
                case "SoLuongDauCuonHienTai":
                    $("#<%=txtSoLuongDauCuon.ClientID%>").val(evt.value);
                    colorSoLuongDauCuon(evt.values);
                    break;
                case "SoLuongLamPhieuXuat":
                    $("#<%=txtSoLuongLamPhieu.ClientID%>").val(evt.value);
                    break;
                case "DinhLuongTieuChuan":
                    $("#<%=txtDinhLuongTieuChuan.ClientID%>").val(evt.value);
                    break;
                case "DinhLuongThucTe":
                    $("#<%=txtDinhLuongThucTe.ClientID%>").val(evt.value);
                    break;
                case "KichThuocTieuChuan":
                    $("#<%=txtKichThuocTieuChuan.ClientID%>").val(evt.value);
                    break;
                case "KichThuocThucTe":
                    $("#<%=txtKichThuocThucTe.ClientID%>").val(evt.value);
                    break;
                case "ChenhLechDinhLuong":
                    $("#<%=txtChenhLechDinhLuong.ClientID%>").val(evt.value);
                    break;
                case "DinhLuongTinhTru":
                    $("#<%=txtDinhLuongTru.ClientID%>").val(evt.value);
                    break;
                case "TruThuaKichThuoc":
                    $("#<%=txtTruKichThuoc.ClientID%>").val(evt.value);
                    break;
                case "KhoiLuongTru":
                    $("#<%=txtKhoiLuongTru.ClientID%>").val(evt.value);
                    break;
                case "TruLoi":
                    $("#<%=txtTruLoi.ClientID%>").val(evt.value);
                    break;
                case "SoLuongChenhLechKhongTinh":
                    $("#<%=txtSoLuongChenhLech.ClientID%>").val(evt.value);
                    break;
                case "ThanhTien":
                    $("#<%=txtThanhTien.ClientID%>").val(evt.value);
                    break;
                case "GhiChu":
                    $("#<%=txtGhiChu.ClientID%>").val(evt.value);
                    break;
            }
        });

        $("#<%=txtGiaXuat.ClientID%>").on("change", function (evt) {
            if (!currentVatTuXuat.setDonGia(this.value)) {
                this.value = 0;
                evt.preventDefault();
            }
        });

        $("#<%=txtSoLuongDauCuon.ClientID%>").on("change", function () {
            currentVatTuXuat.setSoLuongDauCuon(this.value);
        });

        $("#<%=txtSoLuongLamPhieu.ClientID%>").on("blur", function () {
            currentVatTuXuat.setSoLuongConLaiCuoiNgay(this.value);
        });

        $("#<%=txtGhiChu.ClientID%>").on("change", function () {
            currentVatTuXuat.setGhiChu(this.value);
        });

        $("#btnSaveVatTu").on("click", function () {
            if (!currentVatTuXuat.data.MaVatTuNhap) {
                alert("Bạn chưa chọn vật tư");
                $("#<%=txtMaVatTu.ClientID%>").focus();
                return;
            }
            if (!currentVatTuXuat.data.DonGia) {
                //alert("Bạn chưa nhập đơn giá");
                //$("#<%=txtGiaXuat.ClientID%>").focus();
                //return;
            }
            if (!currentVatTuXuat.data.SoLuongDauCuonHienTai) {
                alert("Bạn chưa nhập số lượng đầu cuộn hiện tại");
                $("#<%=txtSoLuongDauCuon.ClientID%>").focus();
                return;
            }
            if (isNaN(currentVatTuXuat.data.SoLuongConLaiCuoiNgay)) {
                alert("Bạn chưa nhập số lượng còn lại cuối ngày");
                $("#<%=txtSoLuongLamPhieu.ClientID%>").focus();
                return;
            }
            if (!currentVatTuXuat.data.DinhLuongThucTe) {
                alert("Bạn chưa nhập định lượng thực tế");
                $("#<%=txtDinhLuongThucTe.ClientID%>").focus();
                return;
            }
            if (!currentVatTuXuat.data.KichThuocThucTe) {
                alert("Bạn chưa nhập kích thước thực tế");
                $("#<%=txtKichThuocThucTe.ClientID%>").focus();
                return;
            }
            if (currentVatTuXuat.data.SoLuongLamPhieuXuat > currentVatTuXuat.data.SoLuongDauCuon) {
                alert("Số lượng còn lại cuối ngày không thể lớn hơn số lượng tồn");
                $("#<%=txtSoLuongLamPhieu.ClientID%>").focus();
                return;
            }
            var isExisted = false;
            for (var i = 0; i < dataChiTiet.length; i++) {
                if (dataChiTiet[i].data.RandomID == currentVatTuXuat.data.RandomID) {
                    isExisted = true;
                }
            }
            if (!isExisted) {
                dataChiTiet.push(currentVatTuXuat);
            }
            bindDataChiTiet(dataChiTiet);
            CloseModal();
        });
    });

    function bindCurrentData(data) {
        $("#<%=txtMaVatTu.ClientID%>").val(data.MaVatTuNhap);
        $("#<%=txtTenVatTu.ClientID%>").val(data.TenVatTu);
        $("#<%=txtDonViTinh.ClientID%>").val(data.DonViTinh);
        $("#<%=txtGiaXuat.ClientID%>").val(data.DonGia);

        $("#<%=txtSoLuongDauCuonBanDau.ClientID%>").val(data.SoLuongDauCuonBanDau);
        $("#<%=txtSoLuongTon.ClientID%>").val(data.SoLuongConLai);
        $("#<%=txtSoLuongDauCuon.ClientID%>").val(data.SoLuongConLai);
        $("#<%=txtSoLuongLamPhieu.ClientID%>").val(data.SoLuongConLaiCuoiNgay);

        $("#<%=txtSoLuongThucXuat.ClientID%>").val(data.SoLuongThucXuat);
        $("#<%=txtDinhLuongTieuChuan.ClientID%>").val(data.DinhLuongTieuChuan);
        $("#<%=txtDinhLuongThucTe.ClientID%>").val(data.DinhLuongThucTe);
        $("#<%=txtKichThuocTieuChuan.ClientID%>").val(data.KichThuocTieuChuan);
        $("#<%=txtKichThuocThucTe.ClientID%>").val(data.KichThuocThucTe);
        $("#<%=txtChenhLechDinhLuong.ClientID%>").val(data.ChenhLechDinhLuong);
        $("#<%=txtDinhLuongTru.ClientID%>").val(data.DinhLuongTinhTru);
        $("#<%=txtTruKichThuoc.ClientID%>").val(data.TruThuaKichThuoc);
        $("#<%=txtKhoiLuongTru.ClientID%>").val(data.KhoiLuongTru);
        $("#<%=txtTruLoi.ClientID%>").val(data.TruLoi);
        $("#<%=txtSoLuongChenhLech.ClientID%>").val(data.SoLuongChenhLechKhongTinh);
        $("#<%=txtThanhTien.ClientID%>").val(data.ThanhTien);
        $("#<%=txtGhiChu.ClientID%>").val(data.GhiChu);

    }

    ///phamkhuong102
    function colorSoLuongConLai(soLuongConLai) {
        var constTonVattu = 170;
        //>= thì màu xanh
        //nhỏ hơn và lớn hơn 0 thì để màu vàng
        //bang 0 thì để màu đỏ 
        var bg = "text-align: center;";
        if (soLuongConLai == 0)
            bg += "background-color: red; color: white;";
        else if (soLuongConLai > 0 && soLuongConLai < constTonVattu)
            bg += "background-color: yellow; color: black;";
        else bg += "background-color: blue; color: white;";

        $("#<%=txtSoLuongTon.ClientID%>").attr('style', bg);
    }
    ///phamkhuong102
    function colorSoLuongDauCuon(soLuongDauCuon) {
        //  alert('khuong - check bindata');
        var constDauCuon = 120;
        //>= thì màu xanh
        //nhỏ hơn và lớn hơn 0 thì để màu vàng
        //bang 0 thì để màu đỏ 
        var bg = "text-align: center;";
        if (soLuongDauCuon == 0)
            bg += "background-color: red; color: white;";
        else if (soLuongDauCuon > 0 && soLuongDauCuon < constDauCuon)
            bg += "background-color: yellow; color: black;";
        else bg += "background-color: blue; color: white;";

        $("#<%= txtSoLuongDauCuonBanDau.ClientID%>").attr('style', bg);
    }
</script>

<div class="work-item-form">
    <div class="work-item-view">
        <table class="witform-layout">
            <tbody>
                <tr>
                    <td style="width: 22%;"></td>
                    <td style="width: 25%;"></td>
                    <td style="width: 25%;"></td>
                    <td style="width: 28%;"></td>
                </tr>

                <tr>
                    <td>Vật tư
                    </td>
                    <td colspan="3">

                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:HiddenField ID="txtIDVatTu" runat="server" />
                                    <asp:HiddenField ID="txtMaVatTu" runat="server" />
                                    <asp:TextBox ID="txtTenVatTu" runat="server" />
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span style="float: left;">Số lượng đầu cuộn</span>
                    </td>
                    <td>
                        <div class="workitemcontrol" style="width: 100%; float: left">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtSoLuongDauCuonBanDau" runat="server" Enabled="false" />
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>
                        <span style="float: left">Số lượng tồn theo cuộn</span>
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtSoLuongTon" runat="server" Enabled="false" />
                                </div>
                            </div>
                        </div>
                    </td>

                </tr>
                <tr>
                    <td>Số lượng đầu cuộn hiện tại
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtSoLuongDauCuon" runat="server" />
                                </div>
                            </div>
                        </div>
                    </td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>Đơn vị tính
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtDonViTinh" runat="server" Enabled="false" />
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>Giá xuất
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ID="txtGiaXuat" runat="server" />
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>

                <tr id="trSoLuongCuoiNgay">
                    <%-- <td>Số lượng đầu cuộn hiện tại
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtSoLuongDauCuon" runat="server" />
                                </div>
                            </div>
                        </div>
                    </td>--%>
                    <td>Số lượng còn lại cuối ngày
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
                    <td>Trừ lõi
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtTruLoi" runat="server" Enabled="false" Text="0" />
                                </div>
                            </div>
                        </div>
                    </td>

                    <td>Số lượng thực xuất
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ID="txtSoLuongThucXuat" runat="server" Enabled="false" Text="0" />
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
                            <div class="combo tree drop">
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
                                    <asp:TextBox ID="txtDinhLuongThucTe" runat="server" Enabled="false" />
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>

                    <td>Kích thước tiêu chuẩn (mm)
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtKichThuocTieuChuan" runat="server" Enabled="false" Text="0" />
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>Kích thước thực tế (mm)
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ID="txtKichThuocThucTe" runat="server" Enabled="false" />
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
                            <div class="combo tree drop">
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
                    <td>Trừ thừa kích thước (mm)
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
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
                    <td>Số lượng chênh lệch
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
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
    <input type="button" id="btnSaveVatTu" class="xrp-button" value="Lưu" />
    <input type="button" class="xrp-button" onclick="CloseModal();" value="Hủy" />
</div>
