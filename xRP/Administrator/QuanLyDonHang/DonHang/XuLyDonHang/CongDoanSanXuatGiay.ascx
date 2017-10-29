<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CongDoanSanXuatGiay.ascx.cs" Inherits="xRP.Administrator.QuanLyDonHang.DonHang.XuLyDonHang.CongDoanSanXuatGiay" %>
<script type="text/javascript">
    $(function () {
        $('.cs-out').focusout(function () {
            var data = $(this).attr('focus-to');
            var soLuongCanSanXuat = $('.' + data).val();
            var soLuongDaSanXuat = $(this).val();
            if (soLuongCanSanXuat < soLuongDaSanXuat) {
                if (confirm('Số lượng cần sản xuất lớn hơn số lượng yêu cầu. Bạn có muốn thiết lập đúng')) {
                    $(this).val(soLuongCanSanXuat);
                }
            }
        });
    });

    function OpenModal(id) {
        LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Administrator/QuanLyDonHang/DonHang/XuLyDonHang/AddOrEditCongDoanSanXuatGiay.ascx", "&id=" + id);
        $("#content_div").dialog({ modal: true, width: 500, height: 350 });
    }
    function CloseModal() {
        $("#content_div").dialog("close");
    }

    function choncocaugiay() {
        $("input").prop("disabled", true);
        var c = 0;
        var error = "";

        for (var i = 0; i < dsCongDoanSX.length; i++) {

            if (dsCongDoanSX[i]["Selected"].Value && dsCongDoanSX[i]["SoLuongCanSanXuat"].Value == 0) {
                error += "\nCông đoạn: " + dsCongDoanSX[i]["TenCongDoan"].Value + " số lượng cần sản xuất phải > 0";
            }
            if (dsCongDoanSX[i]["IDCongDoan"].Value == 1) {
                var objMatHangUpdate = {
                    id: '<%=ID_MatHang%>',
                    soluong: dsCongDoanSX[i]["SoLuongCanSanXuat"].Value
                }
                $.ajax({
                    type: "POST",
                    url: "<%#Util.SERVER_NAME %>/Business/QuanLySanXuat/Default.aspx/UpdateMatHangSoLuongThung",
                    data: JSON.stringify(objMatHangUpdate),
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        console.log("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                    },
                    success: function (result) {
                        if (result.d == "SUCCESS") {

                        } else {
                            alert("Có lỗi trong quá trình xử lý\n" + result.d);
                        }
                    }
                });
            }
        }
        if (error != "") {
            alert(error);
            return;
        }
        for (var i = 0; i < dsCongDoanSX.length; i++) {
            dsCongDoanSX[i].save(function (d) {
                c++;
                if (c == dsCongDoanSX.length) {
                    $("input").prop("disabled", false);
                    window.location.href = "<%#Util.SERVER_NAME %>/Business/QuanLySanXuat/Default.aspx?page=cccg&mathangid=<%=ID_MatHang%>";
                }
            });
        }
        return false;
    }

    var dsCongDoanSX = [];
    $(function () {
        queryData("<%#Util.SERVER_NAME %>/Business/QuanLySanXuat/Default.aspx/GetCongDoanSanXuat", "{IDMatHang:<%=ID_MatHang%>}", function (data) {
            var dataYC = JSON.parse(data.d);
            var hasItem = dataYC.length > 0;
            queryData("<%#Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataCongDoan", "{}", function (data) {
                var dsCongDoan = JSON.parse(data.d);
                for (var i = 0; i < dsCongDoan.length; i++) {
                    var curYC = null;
                    for (var j = 0; j < dataYC.length; j++) {
                        if (dataYC[j].IDCongDoan == dsCongDoan[i].ID)
                            curYC = dataYC[j]
                    }
                    var yc = new YeuCauSanXuat({
                        ID: curYC == null ? 0 : curYC.ID,
                        IDCongDoan: dsCongDoan[i].ID,
                        IDMatHang: "<%=ID_MatHang%>",
                        TenCongDoan: dsCongDoan[i].TenCongDoan,
                        SoLuongDonHang: parseInt("<%=SoLuongYeuCau%>"),
                        SoLuongLoi: curYC == null ? 0 : curYC.SoLuongLoi,
                        SoLuongCanSanXuat: curYC == null ? parseInt("<%=SoLuongYeuCau%>") : curYC.SoLuongCanSanXuat,
                        GhiChu: curYC == null ? "" : curYC.GhiChu,
                        TinhTrang: false,
                        Selected: curYC != null,
                        ThuTuThucHienCongDoan: curYC == null || curYC.ThuTuThucHienCongDoan == null || (typeof curYC.ThuTuThucHienCongDoan == "undefined") ? 0 : curYC.ThuTuThucHienCongDoan
                    });
                    if (yc.SoLuongCanSanXuat.Value == 0)
                        yc.SoLuongCanSanXuat.setValue(yc.SoLuongDonHang.Value);
                    dsCongDoanSX.push(yc);
                }
                sortDS(dsCongDoanSX);
                for (var i = 0; i < dsCongDoanSX.length; i++) {
                    dsCongDoanSX[i]["ThuTuThucHienCongDoan"].Value = i + 1;
                }
                bindCongDoanSanXuat(hasItem);
            });
        });
    });

    function sortDS(danhsach) {
        danhsach.sort(function (a, b) {
            var tta = a["ThuTuThucHienCongDoan"].Value;
            if (!tta) tta = 1000000;
            var ttb = b["ThuTuThucHienCongDoan"].Value;
            if (!ttb) ttb = 1000000;
            return tta - ttb;
        });
    }
    function back() {
        window.location.href = "/Business/QuanLySanXuat/Default.aspx?page=xldh&donhangid=<%=ID_DonHang%>";
    }
    function bindCongDoanSanXuat(hasItem) {
        console.log(hasItem);
        $("#tabDanhSachPhieuNhapVatTu tbody").text("");
        var tableBody = $("#tabDanhSachPhieuNhapVatTu tbody");
        var nextLastRow = false;
        for (var i = 0; i < dsCongDoanSX.length; i++) {
            var tr = $("<tr/>").appendTo(tableBody);
            //Column STT
            $("<td/>", {
                text: (i + 1)
            }).appendTo(tr);
            //Column name
            $("<td/>", {
                text: dsCongDoanSX[i]["TenCongDoan"].Value
            }).appendTo(tr);
            var txtSLDonHang = $("<input/>", { idcongdoan: dsCongDoanSX[i]["IDCongDoan"].Value, type: "text", value: dsCongDoanSX[i]["SoLuongDonHang"].Value }).appendTo($("<td/>").appendTo(tr));
            txtSLDonHang.change(function () {
                var idcongdoan = parseInt($(this).attr("idcongdoan"));
                for (var i = 0; i < dsCongDoanSX.length; i++) {
                    if (idcongdoan == dsCongDoanSX[i]["IDCongDoan"].Value) {
                        if (!dsCongDoanSX[i]["SoLuongDonHang"].setValue($(this).val())) {
                            $(this).val("");
                            $(this).focus();
                        }
                    }
                }

            });
            var txtSLCanSX = $("<input/>", { idcongdoan: dsCongDoanSX[i]["IDCongDoan"].Value, type: "text", value: dsCongDoanSX[i]["SoLuongCanSanXuat"].Value }).appendTo($("<td/>").appendTo(tr));
            txtSLCanSX.change(function () {
                var idcongdoan = parseInt($(this).attr("idcongdoan"));
                for (var i = 0; i < dsCongDoanSX.length; i++) {
                    if (idcongdoan == dsCongDoanSX[i]["IDCongDoan"].Value) {
                        if (!dsCongDoanSX[i]["SoLuongCanSanXuat"].setValue($(this).val())) {
                            $(this).val("");
                            $(this).focus();
                        }
                    }
                }

            });
            var txtGhiChu = $("<input/>", { idcongdoan: dsCongDoanSX[i]["IDCongDoan"].Value, type: "text", style: "width:100%", value: dsCongDoanSX[i]["GhiChu"].Value }).appendTo($("<td/>").appendTo(tr));
            txtGhiChu.on("change", function () {
                var idcongdoan = parseInt($(this).attr("idcongdoan"));
                for (var i = 0; i < dsCongDoanSX.length; i++) {
                    if (idcongdoan == dsCongDoanSX[i]["IDCongDoan"].Value) {
                        dsCongDoanSX[i]["GhiChu"].setValue($(this).val());
                    }
                }
            });
            var cbChon = $("<input/>", { idcongdoan: dsCongDoanSX[i]["IDCongDoan"].Value, type: "checkbox", value: "0" }).appendTo($("<td/>").appendTo(tr));
            if (typeof dsCongDoanSX[i]["Selected"].Value != "undefined" && dsCongDoanSX[i]["Selected"].Value != null && dsCongDoanSX[i]["Selected"].Value)
                cbChon.prop("checked", true);
            else {
                if (!nextLastRow && !hasItem) {
                    cbChon.prop("checked", true);
                    dsCongDoanSX[i]["Selected"].setValue(true);
                }
                if (!hasItem) {
                    cbChon.prop("checked", true);
                    dsCongDoanSX[i]["Selected"].setValue(true);
                }
            }
            cbChon.change(function () {
                var idcongdoan = parseInt($(this).attr("idcongdoan"));
                for (var i = 0; i < dsCongDoanSX.length; i++) {
                    if (idcongdoan == dsCongDoanSX[i]["IDCongDoan"].Value) {
                        dsCongDoanSX[i]["Selected"].setValue($(this).is(':checked'));
                    }
                }

            });
            var tdThuTu = $("<td/>", {
                style: "white-space:nowrap;width:55px;"
            }).appendTo(tr);
            if (i != 0) {
                var btnLen = $("<a/>", {
                    congdoanorder: dsCongDoanSX[i]["ThuTuThucHienCongDoan"].Value,
                    href: "javascript:void(0)",
                    class: "icon-up cns-icon"
                }).appendTo(tdThuTu);

                btnLen.click(function () {
                    var congdoanorder = parseInt($(this).attr("congdoanorder"));
                    var prevItem = dsCongDoanSX[congdoanorder - 2];
                    prevItem["ThuTuThucHienCongDoan"].setValue(prevItem["ThuTuThucHienCongDoan"].Value + 1);
                    var curItem = dsCongDoanSX[congdoanorder - 1];
                    curItem["ThuTuThucHienCongDoan"].setValue(curItem["ThuTuThucHienCongDoan"].Value - 1);
                    sortDS(dsCongDoanSX);
                    bindCongDoanSanXuat();
                });
            }
            if (i != dsCongDoanSX.length - 1) {
                var btnXuong = $("<a/>", {
                    congdoanorder: dsCongDoanSX[i]["ThuTuThucHienCongDoan"].Value,
                    href: "javascript:void(0)",
                    class: "icon-down cns-icon"
                }).appendTo(tdThuTu);
                btnXuong.click(function () {
                    var congdoanorder = parseInt($(this).attr("congdoanorder"));
                    var nextItem = dsCongDoanSX[congdoanorder];
                    nextItem["ThuTuThucHienCongDoan"].setValue(nextItem["ThuTuThucHienCongDoan"].Value - 1);
                    var curItem = dsCongDoanSX[congdoanorder - 1];
                    curItem["ThuTuThucHienCongDoan"].setValue(curItem["ThuTuThucHienCongDoan"].Value + 1);
                    sortDS(dsCongDoanSX);
                    bindCongDoanSanXuat();
                });
            }
            if (dsCongDoanSX[i]["IDCongDoan"].Value == "<%=CongDoanCuoi%>")
                nextLastRow = true;
        }
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
                        <span class="info-text">Chọn công đoạn sản xuất cho mặt hàng
                        </span>
                    </div>
                </div>

            </div>
            <div class="work-item-form">
                <div class="work-item-view" style="margin-left: 10px;">
                    <div class="work-item-bonus">
                        <asp:Literal ID="lblChonCongDoanSanXuatGiay" runat="server"></asp:Literal>
                    </div>
                    <asp:Panel runat="server" ID="pnChiTietVatTu">
                        <div id="" class="div-data">
                            <div>
                                <table class="data-table tab-detail">
                                    <tr>
                                        <td style="width:70px;">Mã hàng:</td>
                                        <td style="width: 200px;">
                                            <div class="workitemcontrol">
                                                <div class="combo tree drop">
                                                    <div class="wrap">
                                                        <input type="text" id="txtMaHang" value="<%=MaHieuMatHang %>" />
                                                    </div>
                                                </div>
                                            </div>

                                        </td>
                                        <td style="width:90px;">Tên mặt hàng:</td>
                                        <td style="width: 200px;">
                                             <div class="workitemcontrol">
                                                <div class="combo tree drop">
                                                    <div class="wrap">
                                                        <input type="text" id="txtTenMatHang" value="<%=TenMatHang %>" />
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                        <td style="width:90px;">Số lượng tồn:</td>
                                        <td style="width: 200px;">
                                             <div class="workitemcontrol">
                                                <div class="combo tree drop">
                                                    <div class="wrap">
                                                        <input type="text" id="txtSoLuongTon" value="<%=SoLuongTon %>" />
                                                    </div>
                                                </div>
                                            </div>
                                            
                                        </td>
                                        <td></td>
                                        <td >
                                        </td>
                                    </tr>
                                  
                                </table>
                            </div>
                            <table class="data-table tab-detail" id="tabDanhSachPhieuNhapVatTu">
                                <thead>
                                    <tr>
                                        <td style="width: 5%">STT</td>
                                        <td>Tên công đoạn</td>
                                        <td style="width: 100px">SL đơn hàng</td>
                                        <td style="width: 100px">SL cần sản xuất</td>
                                        <td>Ghi chú</td>
                                        <td style="width: 1%">Chọn</td>
                                        <td></td>
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
        <input id="btTiepTuc" type="button" class="xrp-button" value="Tiếp tục" onclick="choncocaugiay();" />
        <input id="btQuayLai" type="button" class="xrp-button" value="Quay lại" onclick="back();" />
    </div>
</div>

<div id="content_div" title="Cập nhật công đoạn sản xuất">
</div>
