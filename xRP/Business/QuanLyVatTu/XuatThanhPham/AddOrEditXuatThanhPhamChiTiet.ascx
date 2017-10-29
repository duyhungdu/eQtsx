﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddOrEditXuatThanhPhamChiTiet.ascx.cs" Inherits="xRP.Business.QuanLyVatTu.XuatThanhPham.AddOrEditXuatThanhPhamChiTiet" %>
<asp:HiddenField ID="hdfSoLuongTon" runat="server" />
<div class="work-item-view" style="margin-left: 10px;">
    <table class="witform-layout">
        <tr>
            <td style="width: 20%;"></td>
            <td style="width: 30%;"></td>
            <td style="width: 20%;"></td>
            <td style="width: 30%;"></td>
        </tr>
        <tr>
            <td>
                <div>
                    <span>Mặt hàng</span>
                    <span style="color: red">*</span>
                </div>
            </td>
            <td colspan="3">
                <asp:HiddenField ID="slcIDMatHang" runat="server" ClientIDMode="Static" Value="0" />
                <div class="workitemcontrol">
                    <div class="combo tree drop">
                        <div class="wrap">
                            <asp:TextBox ID="txtIDMatHang" runat="server" Width="100%"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span>Tên xuất bán</span>
                    <span style="color: red">*</span>
                </div>
            </td>
            <td colspan="3">
                <div class="workitemcontrol">
                    <div class="combo tree drop">
                        <div class="wrap">
                            <asp:TextBox ID="txtTenXuatBan" runat="server"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span>Mã SP theo phiếu</span>
                    <span style="color: red">*</span>
                </div>
            </td>
            <td>
                <div class="workitemcontrol">
                    <div class="combo tree drop">
                        <div class="wrap">
                            <asp:TextBox ID="txtMaTheoPhieu" runat="server"></asp:TextBox>
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
                    <span>Chiều dài</span>
                </div>
            </td>
            <td>
                <div class="workitemcontrol">
                    <div class="combo tree drop">
                        <div class="wrap">
                            <asp:TextBox ID="txtChieuDai" runat="server" Enabled="false"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </td>
            <td>
                <div>
                    <span>Chiều Rộng</span>
                </div>
            </td>
            <td>
                <div class="workitemcontrol">
                    <div class="combo tree drop">
                        <div class="wrap">
                            <asp:TextBox ID="txtChieuRong" runat="server" Enabled="false"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span>Chiều cao</span>
                </div>
            </td>
            <td>
                <div class="workitemcontrol">
                    <div class="combo tree drop">
                        <div class="wrap">
                            <asp:TextBox ID="txtChieuCao" runat="server" Enabled="false"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </td>
            <td>
                <div>
                    <span>Số lớp</span>
                </div>
            </td>
            <td>
                <div class="workitemcontrol">
                    <div class="combo tree drop">
                        <div class="wrap">
                            <asp:TextBox ID="txtSoLop" runat="server" Enabled="false"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <span>Loại sản phẩm</span>
                </div>
            </td>
            <td>
                <div class="workitemcontrol">
                    <div class="combo tree drop">
                        <div class="wrap">
                            <asp:TextBox ID="txtLoaiSanPham" runat="server" Enabled="false"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </td>
            <td>
                <div>
                    <span>Loại kích thước</span>
                </div>
            </td>
            <td>
                <div class="workitemcontrol">
                    <div class="combo tree drop">
                        <div class="wrap">
                            <asp:TextBox ID="txtLoaiKichThuoc" runat="server" Enabled="false"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>Số lượng xuất</td>
            <td>
                <div class="workitemcontrol">
                    <div class="combo tree drop">
                        <div class="wrap">
                            <asp:TextBox ID="txtSoLuongXuat" runat="server" Text="0"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </td>
            <td>Đơn vi tính</td>
            <td>
                <asp:HiddenField ID="slcIDDonViTinh" runat="server" ClientIDMode="Static" Value="0" />
                <div class="workitemcontrol">
                    <div class="combo tree drop">
                        <div class="wrap">
                            <asp:TextBox ID="txtIDDonViTinh" runat="server" Width="100%" Enabled="false"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>Đơn giá</td>
            <td>
                <div class="workitemcontrol">
                    <div class="combo tree drop">
                        <div class="wrap">
                            <asp:TextBox ID="txtDonGia" runat="server" Text="0"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </td>
            <td>Thành tiền</td>
            <td>
                <div class="workitemcontrol">
                    <div class="combo tree drop">
                        <div class="wrap">
                            <asp:TextBox ID="txtThanhTien" runat="server" Text="0" Enabled="false"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>Ghi chú</td>
            <td colspan="3">
                <asp:TextBox ID="txtGhiChu" TextMode="MultiLine" runat="server" Width="100%" />
            </td>
        </tr>
    </table>
</div>
<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix button-list">
    <input type="button" id="btnSave" class="xrp-button" onclick="save_data()" value="Lưu" />
    <input type="button" class="xrp-button" onclick="CloseModal();" value="Hủy" />
</div>
<script type="text/javascript">
    $(function () {
       // console.log(dataChiTiet);
        for (var i = 0; i < dataChiTiet.length; i++) {
            //alert(dataChiTiet[i].data.randomID);
            if (dataChiTiet[i].data.randomID == '<%=randID%>') {
                binData(dataChiTiet[i].data);
                break;
            }
        }

        $('#<%=txtIDMatHang.ClientID%>').focus();

        $("#<%=txtSoLuongXuat.ClientID%>").change(function () {
            if (!$.isNumeric($("#<%=txtSoLuongXuat.ClientID%>").val().trim())) {
                alert("Nhập sai kiểu dữ liệu 'Số lượng xuất'.");
                $("#<%=txtSoLuongXuat.ClientID%>").focus();
            } else {
                if (parseInt($("#<%=txtSoLuongXuat.ClientID%>").val()) > parseInt($("#<%=hdfSoLuongTon.ClientID%>").val()))
                {
                    alert('Số lượng tồn hiện ít hơn số lượng làm phiếu xuất. Xin vui lòng nhập lại số lượng hoặc chọn mặt hàng khác');
                    $("#<%=txtSoLuongXuat.ClientID%>").val("0");
                    $("#<%=txtSoLuongXuat.ClientID%>").focus();
                    return;
                }
                else
                {
                    $("#<%=txtSoLuongXuat.ClientID%>").val(parseInt('0' + $("#<%=txtSoLuongXuat.ClientID%>").val()));
                    $("#<%=txtDonGia.ClientID%>").val(parseFloat('0' + $("#<%=txtDonGia.ClientID%>").val()));

                    var thanhTien = parseInt($("#<%=txtSoLuongXuat.ClientID%>").val()) * parseFloat($("#<%=txtDonGia.ClientID%>").val());
                    $("#<%=txtThanhTien.ClientID%>").val(thanhTien);
                }
            }
        });

        $("#<%=txtDonGia.ClientID%>").change(function () {
            if (!$.isNumeric($("#<%=txtDonGia.ClientID%>").val().trim())) {
                alert("Nhập sai kiểu dữ liệu 'Đơn giá'.");
                $("#<%=txtDonGia.ClientID%>").focus();
            } else {
                $("#<%=txtSoLuongXuat.ClientID%>").val(parseInt('0' + $("#<%=txtSoLuongXuat.ClientID%>").val()));
                $("#<%=txtDonGia.ClientID%>").val(parseFloat('0' + $("#<%=txtDonGia.ClientID%>").val()));

                var thanhTien = parseInt($("#<%=txtSoLuongXuat.ClientID%>").val()) * parseFloat($("#<%=txtDonGia.ClientID%>").val());
                $("#<%=txtThanhTien.ClientID%>").val(thanhTien);
            }
        });


        //Mặt hàng
        queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataMatHangForAutoCompleteWithTon", {}, function (result) {

            var objJSON = JSON.parse(result.d);
            $('#<%=txtIDMatHang.ClientID%>').autocomplete({
                lookup: objJSON,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }

                },
                onSelect: function (suggestion) {
                    $('#<%=slcIDMatHang.ClientID%>').val(suggestion.data);


                    if (suggestion.data > 0) {
                        queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataMatHangForAutoCompleteByID", "{Id:" + suggestion.data + "}", function (result) {
                            var dataJson = $.parseJSON(result.d);
                            console.log(dataJson.soluongton);
                            $('#<%=hdfSoLuongTon.ClientID%>').val(dataJson.soluongton);
                            if (dataJson.soluongton <= 0) {
                                alert('Mặt hàng đã hết, không thể xuất');
                                $('#<%=txtChieuDai.ClientID%>').val("");
                                $('#<%=txtChieuRong.ClientID%>').val("");
                                $('#<%=txtChieuCao.ClientID%>').val("");
                                $('#<%=txtSoLop.ClientID%>').val("");
                                $('#<%=txtLoaiSanPham.ClientID%>').val("");
                                $('#<%=txtLoaiKichThuoc.ClientID%>').val("");
                                $('#<%=slcIDDonViTinh.ClientID%>').val("");
                                $('#<%=txtIDDonViTinh.ClientID%>').val("");
                                $('#<%=txtTenXuatBan.ClientID%>').val("");
                                return;
                            }
                            if (dataJson.soluongton < $('#<%=txtSoLuongXuat.ClientID%>').val()) {
                                alert('Số lượng tồn hiện ít hơn số lượng làm phiếu xuất. Xin vui lòng nhập lại số lượng hoặc chọn mặt hàng khác');
                                $('#<%=slcIDMatHang.ClientID%>').val("");
                                return;
                            }
                            $('#<%=txtChieuDai.ClientID%>').val(dataJson.chieudai);
                            $('#<%=txtChieuRong.ClientID%>').val(dataJson.chieurong);
                            $('#<%=txtChieuCao.ClientID%>').val(dataJson.chieucao);
                            $('#<%=txtSoLop.ClientID%>').val(dataJson.solop);
                            $('#<%=txtLoaiSanPham.ClientID%>').val(dataJson.loaisanpham);
                            $('#<%=txtLoaiKichThuoc.ClientID%>').val(dataJson.loaikichthuoc);
                            $('#<%=slcIDDonViTinh.ClientID%>').val(dataJson.donvitinhid);
                            $('#<%=txtIDDonViTinh.ClientID%>').val(dataJson.donvitinh);
                            $('#<%=txtTenXuatBan.ClientID%>').val(dataJson.value);

                        });
                    }
                },
                onHint: function (hint) {
                },
                onInvalidateSelection: function () {
                }
            });
        });


        //End-Mặt hàng

        //Đơn vị
        queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataDonViTinhForAutoComplete", {}, function (result) {
            var objJSON = JSON.parse(result.d);
            $('#<%=txtIDDonViTinh.ClientID%>').autocomplete({
                lookup: objJSON,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }

                },
                onSelect: function (suggestion) {
                    $('#<%=slcIDDonViTinh.ClientID%>').val(suggestion.data);
                },
                onHint: function (hint) {
                },
                onInvalidateSelection: function () {
                }
            });
        });
        //End-Đơn vị

        $('#<%=txtIDMatHang.ClientID%>').change(function () {
            for (var i = 0; i < dataChiTiet.length; i++) {
                if (dataChiTiet[i].data.iIDMatHang == $('#<%=slcIDMatHang.ClientID%>').val()) {
                    alert('Mặt hàng đã được chọn. Vui lòng chọn mặt hàng khác');
                    $('#<%=txtIDMatHang.ClientID%>').val('');
                    $('#<%=slcIDMatHang.ClientID%>').val('');
                    $('#<%=txtChieuDai.ClientID%>').val('');
                    $('#<%=txtChieuRong.ClientID%>').val('');
                    $('#<%=txtChieuCao.ClientID%>').val('');
                    $('#<%=txtSoLop.ClientID%>').val('');
                    $('#<%=txtLoaiSanPham.ClientID%>').val('');
                    $('#<%=txtLoaiKichThuoc.ClientID%>').val('');
                    break;
                }
            }
        });
    });

    function binData(data) {
        // data.itemID = '<_%=idXuatThanhPham%>';
        $("#<%=slcIDMatHang.ClientID%>").val(data.iDMatHang);
        $("#<%=txtIDMatHang.ClientID%>").val(data.tenMatHang);
        $("#<%=txtTenXuatBan.ClientID%>").val(data.tenXuatBan);
        $("#<%=slcIDDonViTinh.ClientID%>").val(data.iDDonViTinh);
        $("#<%=txtIDDonViTinh.ClientID%>").val(data.donViTinh);
        $("#<%=txtSoLuongXuat.ClientID%>").val(data.soLuongXuat);
        $("#<%=txtDonGia.ClientID%>").val(data.donGia);
        $("#<%=txtThanhTien.ClientID%>").val(data.thanhTien);
        $("#<%=txtChieuDai.ClientID%>").val(data.dai);
        $("#<%=txtChieuRong.ClientID%>").val(data.rong);
        $("#<%=txtChieuCao.ClientID%>").val(data.cao);
        $("#<%=txtSoLop.ClientID%>").val(data.soLop);
        $("#<%=txtLoaiSanPham.ClientID%>").val(data.loaiSanPham);
        $("#<%=txtLoaiKichThuoc.ClientID%>").val(data.loaiKichThuoc);
    }
    function save_data() {
        try {

            var data = new Object();
            data.itemID = '<%=idXuatThanhPham%>';
            data.randomID = '<%=randID%>';
            data.iDMatHang = $("#<%=slcIDMatHang.ClientID%>").val().trim();
            data.tenMatHang = $("#<%=txtIDMatHang.ClientID%>").val().trim();
            data.tenXuatBan = $("#<%=txtTenXuatBan.ClientID%>").val().trim();
            data.iDDonViTinh = $("#<%=slcIDDonViTinh.ClientID%>").val().trim();
            data.donViTinh = $("#<%=txtIDDonViTinh.ClientID%>").val().trim();
            data.soLuongXuat = $("#<%=txtSoLuongXuat.ClientID%>").val().trim();
            data.donGia = $("#<%=txtDonGia.ClientID%>").val().trim();
            data.thanhTien = $("#<%=txtThanhTien.ClientID%>").val().trim();
            data.tinhTrang = '<%=tinhtrang%>';
            data.dai = $("#<%=txtChieuDai.ClientID%>").val().trim();
            data.rong = $("#<%=txtChieuRong.ClientID%>").val().trim();
            data.cao = $("#<%=txtChieuCao.ClientID%>").val().trim();
            data.soLop = $("#<%=txtSoLop.ClientID%>").val().trim();
            data.loaiSanPham = $("#<%=txtLoaiSanPham.ClientID%>").val().trim();
            data.loaiKichThuoc = $("#<%=txtLoaiKichThuoc.ClientID%>").val().trim();
            data.tinhTrang = '<%=tinhtrang%>';
            data.ghiChu = $("#<%=txtGhiChu.ClientID%>").val().trim();

            if ('<%=randID%>'.length < 2) {
                data.randomID = generateUUID();
            }
            
            if (data.iDMatHang == "") {
                alert("Bạn chưa nhập Mặt hàng.");
                $("#<%=txtIDMatHang.ClientID%>").focus();
                return;
            }
            if (data.tenXuatBan == "") {
                alert("Bạn chưa nhập Tên xuất bán.");
                $("#<%=txtTenXuatBan.ClientID%>").focus();
                return;
            }
           
            if (data.iIDMatHang == "") {
                alert("Bạn chưa nhập Mặt hàng.");
                $("#<%=txtIDMatHang.ClientID%>").focus();
                return;
            }
            if (data.soLuongXuat == 0 || data.soLuongXuat == null || data.soLuongXuat == "0" || data.soLuongXuat == "") {
                alert("Bạn chưa nhập số lượng xuất.");
                $("#<%=txtSoLuongXuat.ClientID%>").focus();
                return;
            }
            if (data.iDDonViTinh == "") {
                alert("Bạn chưa nhập Đơn vị tính.");
                $("#<%=txtIDDonViTinh.ClientID%>").focus();
                return;
            }
            if (!confirm("Bạn có chắc muốn lưu thông tin xuất thành phẩm không?")) {
                return;
            }
            var isExisted = false;
            var xuatThanhPham = new XuatThanhPham(data);
            for (var i = 0; i < dataChiTiet.length; i++) {
                if (dataChiTiet[i].data.randomID == xuatThanhPham.data.randomID) {
                    dataChiTiet[i] = xuatThanhPham;
                    isExisted = true;
                }
            }

            if (!isExisted) {
                dataChiTiet.push(xuatThanhPham);
            }


            bindDataChiTiet(dataChiTiet);
            CloseModal();

            /*
            phapThanhPham.save(function (result) {
                var newid = result.id;
                if ($.isNumeric(newid)) {
                    window.location.href = "<_%=Util.SERVER_NAME %>/Business/QuanLyVatTu/Default.aspx?page=ntp";

                } else {
                    alert("Có lỗi khi lưu dữ liệu\n" + result.d);
                }
            }) */

        } catch (e) { }

        return false;
    }

</script>