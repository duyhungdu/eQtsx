<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddOrEditNhapThanhPhamChiTiet.ascx.cs" Inherits="xRP.Business.QuanLyVatTu.NhapThanhPham.AddOrEditNhapThanhPhamChiTiet" %>

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

                <td>
                    <div>
                        <span>Mặt hàng</span>
                        <span style="color: red">*</span>
                    </div>
                </td>
                <td colspan="3">
                    <asp:HiddenField ID="txtMaHieuMatHang" runat="server" ClientIDMode="Static" Value="0" />
                    <asp:HiddenField ID="txtRandom" runat="server" ClientIDMode="Static" Value="0" />
                    <asp:HiddenField ID="slcIDMatHang" runat="server" ClientIDMode="Static" Value="0" />
                    <div class="workitemcontrol">
                        <div class="combo tree drop">
                            <div class="wrap">
                                <asp:TextBox ID="txtIDMatHang" runat="server" TabIndex="2" Width="100%"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </td>
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
                                <asp:TextBox ID="txtChieuDai" runat="server" ReadOnly="true"></asp:TextBox>
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
                                <asp:TextBox ID="txtChieuRong" runat="server" ReadOnly="true"></asp:TextBox>
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
                                <asp:TextBox ID="txtChieuCao" runat="server" ReadOnly="true"></asp:TextBox>
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
                                <asp:TextBox ID="txtSoLop" runat="server" ReadOnly="true"></asp:TextBox>
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
                                <asp:TextBox ID="txtLoaiSanPham" runat="server" ReadOnly="true"></asp:TextBox>
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
                                <asp:TextBox ID="txtLoaiKichThuoc" runat="server" ReadOnly="true"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>Số lượng nhập</td>
                <td>
                    <div class="workitemcontrol">
                        <div class="combo tree drop">
                            <div class="wrap">
                                <asp:TextBox ID="txtSoLuongNhap" runat="server" TabIndex="9" Text="0"></asp:TextBox>
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
                                <asp:TextBox ID="txtIDDonViTinh" runat="server" TabIndex="2" Width="100%"></asp:TextBox>
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
                                <asp:TextBox ID="txtDonGia" runat="server" TabIndex="9" Text="0"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </td>
                <td>Thành tiền</td>
                <td>
                    <div class="workitemcontrol">
                        <div class="combo tree drop">
                            <div class="wrap">
                                <asp:TextBox ID="txtThanhTien" runat="server" TabIndex="9" Text="0"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </tbody>
    </table>
</div>
<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix button-list">
    <input type="button" id="Button1" class="xrp-button" onclick="save_data()" value="Lưu" />
    <input type="button" class="xrp-button" onclick="CloseModal();" value="Hủy" />
</div>


<script type="text/javascript">
    var nhapThanhPham = new NhapThanhPham();
    $(function () {

        for (var i = 0; i < dataChiTiet.length; i++) {
            if (dataChiTiet[i].data.randomID == '<%=randID%>') {
                binData(dataChiTiet[i].data);
                break;
            }
        }

        $('#<%=txtIDMatHang.ClientID%>').focus();

        $("#<%=txtSoLuongNhap.ClientID%>").change(function () {
            if (!$.isNumeric($("#<%=txtSoLuongNhap.ClientID%>").val().trim())) {
                alert("Nhập sai kiểu dữ liệu 'Số lượng nhập'.");
                $("#<%=txtSoLuongNhap.ClientID%>").focus();
            } else {
                $("#<%=txtSoLuongNhap.ClientID%>").val(parseInt('0' + $("#<%=txtSoLuongNhap.ClientID%>").val()));
                $("#<%=txtDonGia.ClientID%>").val(parseFloat('0' + $("#<%=txtDonGia.ClientID%>").val()));


                var thanhTien = parseInt($("#<%=txtSoLuongNhap.ClientID%>").val()) * parseFloat($("#<%=txtDonGia.ClientID%>").val());
                $("#<%=txtThanhTien.ClientID%>").val(thanhTien);
            }
        });

        $("#<%=txtDonGia.ClientID%>").change(function () {
            if (!$.isNumeric($("#<%=txtDonGia.ClientID%>").val().trim())) {
                alert("Nhập sai kiểu dữ liệu 'Đơn giá'.");
                $("#<%=txtDonGia.ClientID%>").focus();
            } else {
                $("#<%=txtSoLuongNhap.ClientID%>").val(parseInt('0' + $("#<%=txtSoLuongNhap.ClientID%>").val()));
                $("#<%=txtDonGia.ClientID%>").val(parseFloat('0' + $("#<%=txtDonGia.ClientID%>").val()));

                var thanhTien = parseInt($("#<%=txtSoLuongNhap.ClientID%>").val()) * parseFloat($("#<%=txtDonGia.ClientID%>").val());
                $("#<%=txtThanhTien.ClientID%>").val(thanhTien);
            }
        });

        //Mặt hàng
        queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataMatHangThanhPhamForAutoComplete", {}, function (result) {

           // console.log(result.d);

            var objJSON = JSON.parse(result.d);
            $('#<%=txtIDMatHang.ClientID%>').autocomplete({
                lookup: objJSON,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }

                },
                onSelect: function (suggestion) {

                    <%--  $('#<%=txtChieuDai.ClientID%>').val(suggestion.chieudai);
                    $('#<%=txtChieuRong.ClientID%>').val(suggestion.chieurong);
                    $('#<%=txtChieuCao.ClientID%>').val(suggestion.chieucao);
                    $('#<%=txtSoLop.ClientID%>').val(suggestion.solop);
                    $('#<%=txtLoaiSanPham.ClientID%>').val(suggestion.loaisanpham);
                    $('#<%=txtLoaiKichThuoc.ClientID%>').val(suggestion.loaikichthuoc);
                    $('#<%=slcIDDonViTinh.ClientID%>').val(suggestion.donvitinhid);
                    $('#<%=txtIDDonViTinh.ClientID%>').val(suggestion.donvitinh);--%>

                    $('#<%=slcIDMatHang.ClientID%>').val(suggestion.data);
                    $('#<%=txtMaHieuMatHang.ClientID%>').val(suggestion.mahieumathang);

                    queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataMatHangForAutoCompleteByID", "{Id:" + suggestion.data + "}", function (result) {
                        var dataJson = $.parseJSON(result.d);
                        $('#<%=txtChieuDai.ClientID%>').val(dataJson.chieudai);
                        $('#<%=txtChieuRong.ClientID%>').val(dataJson.chieurong);
                        $('#<%=txtChieuCao.ClientID%>').val(dataJson.chieucao);
                        $('#<%=txtSoLop.ClientID%>').val(dataJson.solop);
                        $('#<%=txtLoaiSanPham.ClientID%>').val(dataJson.loaisanpham);
                        $('#<%=txtLoaiKichThuoc.ClientID%>').val(dataJson.loaikichthuoc);
                        $('#<%=slcIDDonViTinh.ClientID%>').val(dataJson.donvitinhid);
                        $('#<%=txtIDDonViTinh.ClientID%>').val(dataJson.donvitinh);
                    });
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
                    $('#<%=txtMaHieuMatHang.ClientID%>').val(''); 
                    nhapThanhPham = new NhapThanhPham(data);

                    break;
                }
            }
        });
    });
    function binData(data) {
        $('#<%=txtMaHieuMatHang.ClientID%>').val(data.maHieuMatHang);
        $("#<%=slcIDMatHang.ClientID%>").val(data.iIDMatHang);
        $("#<%=txtIDMatHang.ClientID%>").val(data.tenMatHang);
        $("#<%=slcIDDonViTinh.ClientID%>").val(data.iDDonViTinh);
        $("#<%=txtIDDonViTinh.ClientID%>").val(data.donViTinh);
        $("#<%=txtSoLuongNhap.ClientID%>").val(data.soLuongNhap);
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

            if (!confirm("Bạn có chắc muốn lưu thông tin nhập thành phẩm không?")) {
                return;
            }

            var data = new Object();
            data.itemID = '<%=idNhapThanhPham%>';
            data.randomID = '<%=randID%>';
            data.maHieuMatHang = $("#<%=txtMaHieuMatHang.ClientID%>").val().trim();
            data.iDMatHang = $("#<%=slcIDMatHang.ClientID%>").val().trim();
            data.tenMatHang = $("#<%=txtIDMatHang.ClientID%>").val().trim();
            data.iDDonViTinh = $("#<%=slcIDDonViTinh.ClientID%>").val().trim();
            data.donViTinh = $("#<%=txtIDDonViTinh.ClientID%>").val().trim();
            data.soLuongNhap = $("#<%=txtSoLuongNhap.ClientID%>").val().trim();
            data.donGia = $("#<%=txtDonGia.ClientID%>").val().trim();
            data.thanhTien = $("#<%=txtThanhTien.ClientID%>").val().trim();
            data.tinhTrang = '<%=tinhtrang%>';
            data.dai = $("#<%=txtChieuDai.ClientID%>").val().trim();
            data.rong = $("#<%=txtChieuRong.ClientID%>").val().trim();
            data.cao = $("#<%=txtChieuCao.ClientID%>").val().trim();
            data.soLop = $("#<%=txtSoLop.ClientID%>").val().trim();
            data.loaiSanPham = $("#<%=txtLoaiSanPham.ClientID%>").val().trim();
            data.loaiKichThuoc = $("#<%=txtLoaiKichThuoc.ClientID%>").val().trim();
             

            if ('<%=randID%>'.length < 2) {
                data.randomID = generateUUID();
            }
            

            if (data.iIDMatHang == "") {
                alert("Bạn chưa nhập Mặt hàng.");
                $("#<%=txtIDMatHang.ClientID%>").focus();
                return;
            }
            if (data.iDDonViTinh == "") {
                alert("Bạn chưa nhập Đơn vị tính.");
                $("#<%=txtIDDonViTinh.ClientID%>").focus();
                return;
            }

            nhapThanhPham = new NhapThanhPham(data); 
            var isExisted = false;
            for (var i = 0; i < dataChiTiet.length; i++) {
                if (dataChiTiet[i].data.randomID == nhapThanhPham.data.randomID) {
                    dataChiTiet[i] = nhapThanhPham;
                    isExisted = true;
                }
            }

            if (!isExisted) {
                dataChiTiet.push(nhapThanhPham);
            }
            bindDataChiTiet(dataChiTiet);
            CloseModal();

            /*
            var nhapThanhPham = new NhapThanhPham(data);
            nhapThanhPham.save(function (result) {
                var newid = result.id;
                if ($.isNumeric(newid)) {
                    window.location.href = "<-%=Util.SERVER_NAME %>/Business/QuanLyVatTu/Default.aspx?page=ntp";

                } else {
                    alert("Có lỗi khi lưu dữ liệu\n" + result.d);
                }
            });
            */
        } catch (e) { }

        return false;
    }

</script>
