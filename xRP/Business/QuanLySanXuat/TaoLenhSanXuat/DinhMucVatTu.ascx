<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DinhMucVatTu.ascx.cs" Inherits="xRP.Business.QuanLySanXuat.TaoLenhSanXuat.DinhMucVatTu" %>
<script type="text/javascript">
    var randomId = '<%=RanID%>';
    $(function () {
        var dsLop = [];
        queryData("<%#Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataCongDoanTheoSong", "{LoaiSong:<%=IDCoCauGiay%>}", function (data) {
            var dsLopGiay = JSON.parse(data.d);
            for (var i = 0; i < dsLopGiay.length; i++) {
                dsLopGiay[i].ID = 0;
                dsLop.push(new DinhMucVatTu(dsLopGiay[i]));
                dsLop[i].ID.Value = 0;
                dsLop[i].IDMatHang.setValue("<%=matHang.ID%>");
                dsLop[i].IDDonHang.setValue("<%=matHang.IDDonHang%>");
                dsLop[i].KhoGiay.setValue("<%=matHang.KhoGiay.HasValue?matHang.KhoGiay.Value:0%>");
                dsLop[i].SoLuongTam.setValue("<%=matHang.SoLuongTam.HasValue?matHang.SoLuongTam.Value:0%>");
                dsLop[i].ChatDai.setValue("<%=matHang.ChatDai.HasValue?matHang.ChatDai.Value:0%>");
            }
            $("#btTiepTuc").on("click", function () {
                save(dsLop);
            });
        }, null, false);
        $('#txtSoLuongCanSanXuat').change(function () {
            for (var i = 0; i < dsLop.length; i++) {
                dsLop[i].SoLuongTam.setValue($(this).val());
            }
            bindDSCongDoan(dsLop);
        });

        var dataDinhMuc = new HangHoa({ ID: parseInt("<%=matHang.ID%>") }).getDSDinhMucVatTu();

        for (var i = 0; i < dataDinhMuc.length; i++) {
            for (var j = 0; j < dsLop.length; j++) {
                if (dsLop[j].IDPhatSinhTieuHaoVatTu.Value == dataDinhMuc[i].IDPhatSinhTieuHaoVatTu) {
                    dsLop[j].setData(dataDinhMuc[i]);
                }
            }
        }
        for (var i = 0; i < dataDinhMuc.length; i++) {
            for (var j = 0; j < dsLop.length; j++) {
                if (dsLop[j].IDPhatSinhTieuHaoVatTu.Value == dataDinhMuc[i].IDPhatSinhTieuHaoVatTu) {
                    dsLop[j].SoLuong.setValue(dataDinhMuc[i].SoLuong);
                }
            }
        }
        bindDSCongDoan(dsLop);
    });

    function bindDSCongDoan(dsLopGiay) {
        var dataVatTu = [];
        queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataVatTuByTenForAutoComplete", {}, function (result) {
            var temp = JSON.parse(result.d);
            for (var i = 0; i < temp.length; i++) {
                if (temp[i].SoLuongTon > 0)
                    dataVatTu.push(temp[i]);
            }
        }, null, false);

        $("#tabDanhSachPhieuNhapVatTu tbody").text("");
        var tableBody = $("#tabDanhSachPhieuNhapVatTu tbody");
        for (var i = 0; i < dsLopGiay.length; i++) {
            var tr = $("<tr/>").appendTo(tableBody);
            //Column STT
            $("<td/>", {
                text: (i + 1)
            }).appendTo(tr);
            //Column name
            $("<td/>", {
                text: dsLopGiay[i].TenLop.Value
            }).appendTo(tr);
            var tdLoaiVT = $("<td/>").appendTo(tr);
            var txtLoaiVatTu = $("<input/>", { idlopgiay: dsLopGiay[i].IDLopGiay.Value, name: 'txtloaivt', type: "text", style: "width:100%" }).appendTo(tdLoaiVT);
            if (dsLopGiay[i].MaHieuVatTu.Value && dsLopGiay[i].TenVatTu.Value)
                txtLoaiVatTu.val(dsLopGiay[i].MaHieuVatTu.Value.trim() + " - " + dsLopGiay[i].TenVatTu.Value);
            txtLoaiVatTu.autocomplete({
                lookup: dataVatTu,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    var re = new RegExp('\\b' + $.Autocomplete.utils.escapeRegExChars(queryLowerCase), 'gi');
                    return re.test(suggestion.value);
                },
                onSelect: function (suggestion) {
                    var idlopgiay = $(this).attr("idlopgiay");

                    for (var c = 0; c < dsLopGiay.length; c++) {
                        if (dsLopGiay[c].IDLopGiay.Value == idlopgiay) {
                            dsLopGiay[c].IDVatTu.setValue(suggestion.ID);
                            dsLopGiay[c].IDDonViTinh.setValue(suggestion.IDDonViTinh);
                            dsLopGiay[c].DonViTinh.setValue(suggestion.DonViTinh);
                            dsLopGiay[c].DinhLuong.setValue(suggestion.DinhLuong);
                            dsLopGiay[c].SoLuongTon.setValue(suggestion.DinhLuong);
                        }
                    }
                },
                onHint: function (hint) {
                },
                onInvalidateSelection: function () {
                    var idlopgiay = $(this).attr("idlopgiay");
                    $(this).val("");
                    for (var c = 0; c < dsLopGiay.length; c++) {
                        if (dsLopGiay[c].IDLopGiay.Value == idlopgiay) {
                            dsLopGiay[c].IDVatTu.setValue(0);
                            dsLopGiay[c].IDDonViTinh.setValue(0);
                            dsLopGiay[c].DonViTinh.setValue(suggestion.DonViTinh);
                            dsLopGiay[c].DinhLuong.setValue(0);
                            dsLopGiay[c].SoLuong.setValue(0);
                            dsLopGiay[c].SoLuongTon.setValue(0);
                        }
                    }
                }
            });
            var txtHeSoTieuHao = $("<input/>", { idlopgiay: dsLopGiay[i].IDLopGiay.Value, name: "txthesotieuhao", type: "text", style: 'width:100px', value: dsLopGiay[i].HeSoTieuHao.Value }).appendTo($("<td/>").appendTo(tr));
            txtHeSoTieuHao.on("blur", function () {
                var idlopgiay = $(this).attr("idlopgiay");
                for (var c = 0; c < dsLopGiay.length; c++) {
                    if (dsLopGiay[c].IDLopGiay.Value == idlopgiay) {
                        if (!dsLopGiay[c].HeSoTieuHao.setValue(this.value)) {
                            this.focus();
                            this.value = "";
                        }
                    }
                }
            });
            var txtDonViTinh = $("<label/>", { idlopgiay: dsLopGiay[i].GUID, name: "txtdonvitinh", text: dsLopGiay[i].DonViTinh.Value }).appendTo($("<td/>").appendTo(tr));
            var txtSoLuong = $("<input/>", { idlopgiay: dsLopGiay[i].GUID, name: 'txttongso', type: "text", value: dsLopGiay[i].SoLuong.Value }).appendTo($("<td/>").appendTo(tr));
            $(dsLopGiay[i]).on("DataChanged", function (evt) {
                //console.log("[idlopgiay='" + evt.target.GUID + "'][name='txttongso']")
                if (evt.fieldName === "HeSoTieuHao" || evt.fieldName === "DinhMuc")
                    evt.target.calTongSo();
                if (evt.fieldName === "SoLuong") {
                    $("[idlopgiay='" + evt.target.GUID + "'][name='txttongso']").val(evt.value)
                }
                if (evt.fieldName === "DonViTinh") {
                    $("[idlopgiay='" + evt.target.GUID + "'][name='txtdonvitinh']").text(evt.value)
                }
            })
        }
        $("#txtSoLuongCanSanXuat").change(function () {
            var data = $(this).val();
            if (!parseInt(data)) {
                $("#txtSoLuongCanSanXuat").val('0');
                $("#txtSoLuongCanSanXuat").focus();
            }
        });

    }
    function save(data) {

        var error = "";
        var c = 0, c1 = 0;
        for (var i = 0; i < dataLenhSanXuatChiTiet.length; i++) {
            if (dataLenhSanXuatChiTiet[i].data.RanID == randomId) {

                for (var i = 0; i < data.length; i++) {
                    if (!data[i].IDVatTu) {
                        error += "\nBạn chưa chọn vật tư cho " + data[i].TenLop.Value;
                        c1++;
                        if (c1 == data.length && error) {
                            alert("Có lỗi trong quá trình lưu dữ liệu:" + error);
                            return;
                        }
                    }
                    else if (!data[i].HeSoTieuHao) {
                        error += "\nBạn chưa nhập hệ số tiêu hao cho " + data[i].TenLop.Value;
                        c1++;
                        if (c1 == data.length && error) {
                            alert("Có lỗi trong quá trình lưu dữ liệu:" + error);
                            return;
                        }
                    } else {

                        dataLenhSanXuatChiTiet[i].data.dataDinhMucVatTu.push(data[i]);
                        dataLenhSanXuatChiTiet[i].data.SoLuongDatDuoc = $('#txtSoLuongCanSanXuat').val();
                    }
                }
            }
        }
        bindDataLenhSanXuatChiTiet(dataLenhSanXuatChiTiet);
        CloseModal();
    }
    function back() {
        window.location.href = "/Business/QuanLySanXuat/Default.aspx?page=cccg&mathangid=<%= matHang.ID %>";
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
                        <span class="info-text">Định mức vật tư cho mặt hàng <%= matHang.MaHieuMatHang %>
                        </span>
                        <span style="float: right; text-align: right; font-size: 13px; font-weight: bold;">Số lượng yêu cầu:
                        <input id="txtSoLuongYeuCau" readonly="readonly" style="width: 120px" value="<%= matHang.SoLuong %>" />
                            Số lượng cần sản xuất:
                        <input id="txtSoLuongCanSanXuat" style="width: 120px" value="<%= matHang.SoLuong %>" />
                        </span>
                    </div>
                </div>
                <div class="work-item-form">
                    <div class="work-item-view" style="margin-left: 10px;">
                        <asp:Panel runat="server" ID="pnChiTietVatTu">
                            <div id="" class="div-data">
                                <table class="data-table tab-detail" id="tabDanhSachPhieuNhapVatTu">
                                    <thead>
                                        <tr>
                                            <td style="width: 5%">STT</td>
                                            <td style="width: 20%">Điểm phát sinh tiêu hao</td>
                                            <td style="width: 40%">Vật tư</td>
                                            <td style="width: 120px">Hệ số tiêu hao</td>
                                            <td style="width: 120px">Đơn vị tính</td>
                                            <td>Số lượng tiêu hao</td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </asp:Panel>


                    </div>
                </div>
            </div>
        </div>
        <div style="margin-top: 10px; text-align: right">
            <input id="btTiepTuc" type="button" class="xrp-button" value="Lưu" />
            <input id="btQuayLai" type="button" class="xrp-button" value="Hủy" onclick="CloseModal()" />
        </div>
    </div>
</div>
