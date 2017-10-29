<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddChiTietSanPham.ascx.cs" Inherits="xRP.Administrator.QuanLyDonHang.DonHang.AddChiTietSanPham" %>

<script type="text/javascript">
    function loadPhanLoaiSong(solop) {
        //Auto complete phan loai song
        queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONPhanLoaiSongForAutoComplete_KyHieu", {}, function (result) {
            var tempObjJSON = JSON.parse(result.d);
            var objJSON = [];
            if (solop != 0)
                for (var i = 0; i < tempObjJSON.length; i++) {
                    if (tempObjJSON[i].solop == solop)
                        objJSON.push(tempObjJSON[i]);
                }
            else
                objJSON = tempObjJSON;
            $('#<%=txtLoaiGiay.ClientID%>').autocomplete({
                lookup: objJSON,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }
                },
                onSelect: function (suggestion) {
                    currentHangHoa.LoaiSongSanXuat.setValue(suggestion.data);
                    currentHangHoa.TenLoaiSongSanXuat.setValue(suggestion.value);
                    $('#<%=hdfLoaiGiay.ClientID%>').val(suggestion.data);
                },
                onHint: function (hint) {
                },
                onInvalidateSelection: function () {
                    currentHangHoa.LoaiSongSanXuat.setValue(0);
                    currentHangHoa.TenLoaiSongSanXuat.setValue("");
                }
            });

        });
    }
    var currentHangHoa = {};
    $(document).ready(function () {
        $('#<%=txtNgayGH.ClientID%>').datetimepicker({
            mask: '99/99/9999', timepicker: false,
            format: 'd/m/Y',
        });

        $('#<%=txtMaHang.ClientID%>').on('keyup', function () {
            $(this).val($(this).val().toUpperCase());
        });
        //Auto complete don vi tinh
        queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataDonViTinhForAutoComplete", {}, function (result) {
            var objJSON = JSON.parse(result.d);
            $('#<%=txtDonViTinh.ClientID%>').autocomplete({
                lookup: objJSON,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }

                },
                onSelect: function (suggestion) {
                    $('#<%=txtMaDonViTinh.ClientID%>').val(suggestion.data);
                    $('#<%=txtDonViTinh.ClientID%>').trigger("change");
                },
                onHint: function (hint) {
                },
                onInvalidateSelection: function () {
                    $('#<%=txtMaDonViTinh.ClientID%>').val("0");
                    //$('#<%=txtDonViTinh.ClientID%>').val("");
                    $('#<%=txtDonViTinh.ClientID%>').trigger("change");
                }
            });
        });


        var i = 0;

        for (i = 0; i < dataChiTiet.length; i++) {
            if (dataChiTiet[i].GUID == "<%=ID_HangHoa%>") {
                currentHangHoa = dataChiTiet[i];
                if (currentHangHoa.LoaiSongSanXuat.Value != 0 && currentHangHoa.TenLoaiSongSanXuat.Value == "") {
                    queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONPhanLoaiSongForAutoComplete_KyHieu", {}, function (result) {
                        var objJSON = JSON.parse(result.d);
                        for (var c = 0; c < objJSON.length; c++) {
                            if (objJSON[c].data == currentHangHoa.LoaiSongSanXuat.Value) {
                                currentHangHoa.TenLoaiSongSanXuat.setValue(objJSON[c].value);
                                $('#<%=txtLoaiGiay.ClientID%>').val(objJSON[c].value);
                            }
                        }
                    });
                }
                currentHangHoa.calMaQuyDoi();
                bindCurrentData(currentHangHoa);
                break;
            }
        }
        if (i == dataChiTiet.length) {
            currentHangHoa = new MatHang();
            currentHangHoa.IDLoaiKichThuoc.setValue($("#<%=dropLoaiKichThuoc.ClientID%>").val());
            currentHangHoa.LoaiKichThuoc.setValue($("#<%=dropLoaiKichThuoc.ClientID%> option:selected").text());
            currentHangHoa.IDLoaiSanPham.setValue($("#<%=dropLoaiThung.ClientID%>").val());
            currentHangHoa.TenLoaiSanPham.setValue($("#<%=dropLoaiThung.ClientID%> option:selected").text());
            currentHangHoa.LoaiSongSanXuat.setValue(0);
            currentHangHoa.CongDoanCuoi.setValue($("#<%=dropCongDoanKetThuc.ClientID%>").val());
        }

        loadPhanLoaiSong(0);
        $("#btnRefreshPhanLoaiSong").on("click", function () {
            loadPhanLoaiSong(currentHangHoa.SoLop.Value);
        });

        $(currentHangHoa).on("DataChanged", function (evt) {
            switch (evt.fieldName) {
                case "ThanhTien":
                    $("#<%=txtThanhTien.ClientID%>").val(evt.value);
                    break;
                case "MaHieuMatHang":
                    $("#<%=txtMaHang.ClientID%>").val(evt.value);
                    break;
                case "MaHangTheoDon":
                    $("#<%=txtMaHangTheoDon.ClientID%>").val(evt.value);
                        break;
                case "TenMatHang":
                    $("#<%=txtTenHang.ClientID%>").val(evt.value);
                    break;
                case "IDDonVitinh":
                    $("#<%=txtMaDonViTinh.ClientID%>").val(evt.value);
                    break;
                case "DonViTinh":
                    $("#<%=txtDonViTinh.ClientID%>").val(evt.value);
                    break;
                case "ChieuDai":
                    $("#<%=txtChieuDai.ClientID%>").val(evt.value);
                    currentHangHoa.calTongDao();
                    currentHangHoa.calChatDai();
                    break;
                case "ChieuRong":
                    $("#<%=txtChieuRong.ClientID%>").val(evt.value);
                    currentHangHoa.calTongDao();
                    currentHangHoa.calChatDai();
                    break;
                case "ChieuCao":
                    $("#<%=txtChieuCao.ClientID%>").val(evt.value);
                    currentHangHoa.calTongDao();
                    currentHangHoa.calChatDai();
                    currentHangHoa.calKhoGiay();
                    break;
                case "IDLoaiKichThuoc":
                    $("#<%=dropLoaiKichThuoc.ClientID%>").val(evt.value);
                    break;
                case "IDLoaiSanPham":
                    $("#<%=dropLoaiThung.ClientID%>").val(evt.value);
                    break;
                case "SoLuongMau":
                    $("#<%=txtSoLuongMau.ClientID%>").val(evt.value);
                    break;
                case "MauSacMatNgoai":
                    $("#<%=txtMauSacMatNgoai.ClientID%>").val(evt.value);
                    break;
                case "SoLop":
                    $("#<%=txtSoLop.ClientID%>").val(evt.value);

                    //Bind phan loai song theo so lop
                    //Auto complete phan loai song
                    loadPhanLoaiSong(evt.value);
                    break;
                case "TongDao":
                    currentHangHoa.calXa();
                    break;
                case "DonGia":
                    $("#<%=txtDonGia.ClientID%>").val(evt.value);
                    break;

                case "DienTichSanXuat":
                    $("#<%=txtDienTichSanPham.ClientID%>").val(evt.value);
                    break;
                case "MaQuyDoi":
                    $("#<%=txtMaQuyDoi.ClientID%>").val(evt.value);
                    break;
                    
                }
        });

        
        queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataHangHoaByCodeForAutoComplete", "{filter:\"" + $("#<%=txtMaHang.ClientID%>").val() + "\"}", function (result) {
            var objJSON = JSON.parse(result.d);
            $('#<%=txtMaHang.ClientID%>').autocomplete({
                lookup: objJSON,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    if (suggestion.value && suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }
                },
                onSelect: function (suggestion) {
                    currentHangHoa.MaHieuMatHang.setValue(suggestion.value.trim());
                    currentHangHoa.IDMatHang.setValue(suggestion.IDMatHang);
                    currentHangHoa.TenMatHang.setValue(suggestion.data);
                    $('#<%=txtMaHang.ClientID%>').trigger("change");
                },
                onHint: function (hint) {
                },
                onInvalidateSelection: function () {
                    currentHangHoa.MaHieuMatHang.setValue($('#<%=txtMaHang.ClientID%>').val());
                    currentHangHoa.IDMatHang.setValue(0);
                    if ($('#<%=txtMaHang.ClientID%>').val() == "")
                        $('#<%=txtMaHang.ClientID%>').focus();
                }
            });
        });
        $("#<%=txtMaHang.ClientID%>").on("change", function () {
            var tenHang = $("#<%=txtTenHang.ClientID%>").val();
            var $this = this;
            queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataHangHoaByID", "{ID:" + currentHangHoa.IDMatHang.Value + "}", function (result) {
                var list = $.parseJSON(result.d);
                currentHangHoa.MaHieuMatHang.setValue($('#<%=txtMaHang.ClientID%>').val());
                currentHangHoa.TenMatHang.setValue($('#<%=txtTenHang.ClientID%>').val());
                //for (var i = 0; i < list.length; i++) {
                if (list.ID == currentHangHoa.IDMatHang.Value) {

                    currentHangHoa.MaHieuMatHang.setValue(list.MaHieuMatHang);
                    currentHangHoa.TenMatHang.setValue(list.TenMatHang);
                    if (currentHangHoa.ID.Value == 0) {
                        currentHangHoa.IDDonViTinh.setValue(list.IDDonVitinh);
                        for (var dvt = 0; dvt < listDonViTinh.length; dvt++) {
                            if (listDonViTinh[dvt].ID == list.IDDonVitinh) {
                                currentHangHoa.DonViTinh.setValue(listDonViTinh[dvt].DonViTinh);
                            }
                        }

                        currentHangHoa.ChieuDai.setValue(list.ChieuDai);
                        currentHangHoa.ChieuRong.setValue(list.ChieuRong);
                        currentHangHoa.ChieuCao.setValue(list.ChieuCao);
                        currentHangHoa.IDLoaiKichThuoc.setValue(list.IDLoaiKichThuoc);
                        currentHangHoa.IDLoaiSanPham.setValue(list.IDLoaiSanPham);
                        currentHangHoa.SoLuongMau.setValue(list.SoLuongMau);
                        currentHangHoa.MauSacMatNgoai.setValue(list.MauSacMatNgoai);
                        currentHangHoa.SoLop.setValue(list.SoLop);
                        currentHangHoa.DonGia.setValue(list.DonGia);
                        var hh = new HangHoa(list);
                        hh.getDSSong(function (result1) {
                            var datasong = JSON.parse(result1.d);
                            for (var j = 0; j < datasong.length; j++) {
                                $('#<%=cblLoaiSong.ClientID%> input').each(function () {
                                    if (this.value == datasong[j].ID)
                                        $(this).attr('checked', 'checked')
                                });
                            }
                        });
                        //break;
                    }
                }
                //}

            });
        });
        $("[data-field]").on("change", function () {
            var field = $(this).attr("data-field");
            switch (field) {
                case "DonViTinh":
                    if ($("#<%=txtMaDonViTinh.ClientID%>").val()) {
                        currentHangHoa.IDDonViTinh.setValue($("#<%=txtMaDonViTinh.ClientID%>").val());
                    } else {
                        currentHangHoa.IDDonViTinh.setValue(0);
                    }
                    break;
                case "MaHangTheoDon":
                    if ($("#<%=txtMaHangTheoDon.ClientID%>").val()) {
                            currentHangHoa.MaHangTheoDon.setValue($("#<%=txtMaHangTheoDon.ClientID%>").val());
                    } else {
                        currentHangHoa.MaHangTheoDon.setValue("");
                    }
                    break;
                case "LoaiKichThuoc":
                    currentHangHoa.IDLoaiKichThuoc.setValue(this.value);
                    currentHangHoa.LoaiKichThuoc.setValue($("#<%=dropLoaiKichThuoc.ClientID%> option:selected").text());
                    currentHangHoa.calTongDao();
                    currentHangHoa.calChatDai();
                    currentHangHoa.calMaHangHoa();
                    break;
                case "TenLoaiSanPham":
                    currentHangHoa.IDLoaiSanPham.setValue(this.value);
                    currentHangHoa.TenLoaiSanPham.setValue($("#<%=dropLoaiThung.ClientID%> option:selected").text());
                    break;
                case "DienTichSanPham":
                    currentHangHoa.DienTichSanXuat.setValue(this.value);
                    currentHangHoa.DienTichXuatBan.setValue(this.value);
                    break;
                case "LoaiSongSanXuat":
                    currentHangHoa.LoaiSongSanXuat.setValue(this.value);
                    currentHangHoa.TenLoaiSongSanXuat.setValue($("#<%=dropLoaiThung.ClientID%> option:selected").text());
                    break;
                case "CongDoanCuoi":
                    currentHangHoa.CongDoanCuoi.setValue($(this).val());
                    currentHangHoa.calMaHangHoa();
                    break;
                case "SoLop":
                    currentHangHoa.SoLop.setValue(this.value);
                    currentHangHoa.calTongDao();
                    currentHangHoa.calChatDai();
                    break;
                    //case "ChieuDai":

                    //    break;
                    //case "ChieuRong":

                    //    break;
                    //case "ChieuCao":

                    //    break;
                default:
                    if (!currentHangHoa[field].setValue(this.value)) {
                        this.focus();
                        $(this).val("");
                    }
                    break;
            }
        });
        $.each($("[data-field]"), function () {
            var field = $(this).attr("data-field");
            if (currentHangHoa[field] && (currentHangHoa[field].Type === "int" || currentHangHoa[field].Type === "float")) {
                $(this).css("text-align", "right");
            }
        });

        $("#btnSave").on("click", function () {

            if (!currentHangHoa.MaHieuMatHang.Value) {
                alert("Bạn chưa nhập hàng hóa");
                $("#<%=txtTenHang.ClientID%>").focus();
                return;
            }
            if (!currentHangHoa.IDDonViTinh.Value) {
                alert("Bạn chưa nhập đơn vị tính");
                $("#<%=txtDonViTinh.ClientID%>").focus();
                return;
            }
            if (!currentHangHoa.ChieuDai.Value) {
                alert("Bạn chưa nhập chiều dài");
                $("#<%=txtChieuDai.ClientID%>").focus();
                return;
            }
            if (!currentHangHoa.ChieuRong.Value) {
                alert("Bạn chưa nhập chiều rộng");
                $("#<%=txtChieuRong.ClientID%>").focus();
                return;
            }
            if (!currentHangHoa.ChieuCao.Value) {
                currentHangHoa.ChieuCao.setValue(0);
            }
            if (!currentHangHoa.IDLoaiKichThuoc) {
                alert("Bạn chưa nhập loại kích thước");
                $("#<%=dropLoaiKichThuoc.ClientID%>").focus();
                return;
            }
            if (!currentHangHoa.IDLoaiSanPham.Value) {
                alert("Bạn chưa nhập Loại thùng");
                $("#<%=dropLoaiThung.ClientID%>").focus();
                return;
            }

            if (currentHangHoa.LoaiSong.length == 0) {
                $("#<%=cblLoaiSong.ClientID%>").focus();
            }
            if (!currentHangHoa.SoLop.Value) {
                alert("Bạn chưa nhập số lớp");
                $("#<%=txtSoLop.ClientID%>").focus();
                return;
            }
            if ($("#<%=hdfLoaiGiay.ClientID%>").val() == "") {
                alert('Bạn chưa chọn phân loại sóng');
                $("#<%=txtLoaiGiay.ClientID%>").focus();
                return;
            }
            //loai song
            var loaisong = [];
            $('#<%=cblLoaiSong.ClientID%> input:checked').each(function () {
                loaisong.push(this.value);
            });
            currentHangHoa.LoaiSong = loaisong;
            currentHangHoa.TenLoaiSong = [];
            $.each(currentHangHoa.getTenDSSong(), function (i, item) {
                currentHangHoa.TenLoaiSong.push(item.TenSong);
            })
            var isExisted = false;
            for (var i = 0; i < dataChiTiet.length; i++) {
                if (dataChiTiet[i].GUID == currentHangHoa.GUID) {
                    isExisted = true;
                }
            }
            if (!isExisted) {
                dataChiTiet.push(currentHangHoa);
            }
            bindDataChiTiet(dataChiTiet);
            CloseModal();
        });



        $("#<%=txtMaHang.ClientID%>").focus();
    });

    function bindCurrentData(hh) {
        var data = hh;
        if (data.MaHieuMatHang.Value != "") {
            $("#<%=txtMaHang.ClientID%>").val(data.MaHieuMatHang.Value);
            $("#<%=txtTenHang.ClientID%>").val(data.TenMatHang.Value);
        }
        $("#<%=txtMaDonViTinh.ClientID%>").val(data.IDDonViTinh.Value);
        $("#<%=txtMaHangTheoDon.ClientID%>").val(data.MaHangTheoDon.Value);
        $("#<%=txtDonViTinh.ClientID%>").val(getTenDonViTinh(data.IDDonViTinh.Value));
        $("#<%=txtSoLuong.ClientID%>").val(data.SoLuong.Value);
        $("#<%=txtChieuDai.ClientID%>").val(data.ChieuDai.Value);
        $("#<%=txtChieuRong.ClientID%>").val(data.ChieuRong.Value);
        $("#<%=txtChieuCao.ClientID%>").val(data.ChieuCao.Value);
        $("#<%=dropLoaiKichThuoc.ClientID%>").val(data.IDLoaiKichThuoc.Value);
        $("#<%=dropLoaiThung.ClientID%>").val(data.IDLoaiSanPham.Value);
        $("#<%=txtSoLuongMau.ClientID%>").val(data.SoLuongMau.Value);
        $("#<%=txtMauSacMatNgoai.ClientID%>").val(data.MauSacMatNgoai.Value);
        $("#<%=txtSoLop.ClientID%>").val(data.SoLop.Value);
        $("#<%=txtIDLoaiGiay.ClientID%>").val(data.LoaiSongSanXuat.Value);
        //Get ten loai giay
        $("#<%=txtLoaiGiay.ClientID%>").val(data.TenLoaiSongSanXuat.Value);
        $("#<%=hdfLoaiGiay.ClientID%>").val(data.LoaiSongSanXuat.Value);

        $("#<%=txtKhoGiay.ClientID%>").val(data.KhoGiay.Value);
        $("#<%=txtDinhLuong.ClientID%>").val(data.DinhLuong.Value);
        $("#<%=txtTai.ClientID%>").val(data.Tai.Value);
        $("#<%=txtLe.ClientID%>").val(data.Le.Value);
        $("#<%=txtDienTichSanPham.ClientID%>").val(data.DienTichSanXuat.Value);
        $("#<%=dropCongDoanKetThuc.ClientID%>").val(data.CongDoanCuoi.Value);
        $("#<%=txtDonGia.ClientID%>").val(data.DonGia.Value);
        $("#<%=txtThanhTien.ClientID%>").val(data.ThanhTien.Value);
        $("#<%=txtGhiChu.ClientID%>").val(data.GhiChu.Value);

        for (var j = 0; j < data.LoaiSong.length; j++) {
            $('#<%=cblLoaiSong.ClientID%> input').each(function () {
                if (this.value == data.LoaiSong[j])
                    $(this).attr('checked', 'checked')
            });
        }
    }
</script>

<div class="splitter horizontal hub-splitter stateful toggle-button-enabled toggle-button-hotkey-enabled content_trg">
    <div class="work-item-form">

        <div class="work-item-view">

            <table class="witform-layout">
                <tbody>
                    <tr>
                        <td style="width: 15%;"></td>
                        <td style="width: 25%;"></td>
                        <td style="width: 15%;"></td>
                        <td style="width: 45%;"></td>
                    </tr>
                    <tr>
                        <td>
                            <div>
                                <span>Mã hàng</span>
                                <span style="color: red">*</span>
                            </div>
                        </td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtMaHang" runat="server" Width="100%" CssClass="text-upper" ></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td>
                            <div>
                                <span>Tên hàng</span>
                                <span style="color: red">*</span>
                            </div>
                        </td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtTenHang" runat="server" Width="100%"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div>
                                <span>Mã hàng theo đơn</span>
                            </div>
                        </td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtMaHangTheoDon" runat="server" Width="100%" CssClass="text-upper"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td> <span>Ngày giao hàng</span></td>
                        <td>
                            <div class="workitemcontrol">
                                            <div class="combo tree drop short-control-30">
                                                <div class="wrap">
                                                    <input type="text" id="txtNgayGH" placeholder="__/__/____" runat="server" />
                                                </div>
                                            </div>
                                        </div>
                        </td>

                    </tr>
                    
                    <tr>
                        <td>Dài (mm)
                            
                        </td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtChieuDai" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td>Rộng (mm)
                        </td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree drop" style="background: none !important;">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtChieuRong" runat="server" Width="120"></asp:TextBox>
                                        &nbsp;&nbsp;&nbsp;&nbsp;Cao (mm)
                                                     <asp:TextBox ID="txtChieuCao" runat="server" Width="140"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>Số lượng</td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtSoLuong" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td>Đơn vị tính</td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree drop short-control-50">
                                    <div class="wrap">
                                        <asp:HiddenField ID="txtMaDonViTinh" runat="server" />
                                        <asp:TextBox ID="txtDonViTinh" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>Tai (mm)</td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtTai" Text="45" runat="server" Style="text-align: right;"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td>Lề (mm)</td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree  drop short-control-50">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtLe" Text="30" runat="server" Style="text-align: right;"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>Loại kích thước
                        </td>
                        <td colspan="3">
                            <asp:DropDownList ID="dropLoaiKichThuoc" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>Loại thùng</td>
                        <td>
                            <asp:DropDownList ID="dropLoaiThung" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td>Loại sóng</td>
                        <td>
                            <asp:CheckBoxList ID="cblLoaiSong" runat="server" RepeatDirection="Horizontal"></asp:CheckBoxList>
                            <input type="text" id="txtLoaiSong" onclick="OpenModalSong(-1)" style="display: none" />
                        </td>
                    </tr>
                    <tr>
                        <td>Số lượng màu</td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtSoLuongMau" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td>Màu sắc mặt ngoài</td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree  drop short-control-50">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtMauSacMatNgoai" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>Số lớp</td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtSoLop" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td>Phân loại sóng</td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree  drop">
                                    <div class="wrap">
                                        <asp:HiddenField ID="txtIDLoaiGiay" runat="server" />
                                        <table style="width: 100%">
                                            <tr>
                                                <td style="padding: 0px; width: 80%">
                                                    <div class="workitemcontrol">
                                                        <div class="combo tree  drop ">
                                                            <div class="wrap">
                                                                <asp:TextBox ID="txtLoaiGiay" runat="server" Width="90%"></asp:TextBox>
                                                                <a class="icon icon-refresh" style="height: 21px; margin-left: 3px;" id="btnRefreshPhanLoaiSong" title="Tải lại dữ liệu"></a>
                                                                <asp:HiddenField ID="hdfLoaiGiay" runat="server" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td style="padding: 0px; width: 20%;">
                                                    <div class="workitemcontrol">
                                                        <div class="combo tree  drop">
                                                            <div class="wrap">
                                                                <asp:TextBox ID="txtMaQuyDoi" runat="server" ClientIDMode="Static" Enabled="false"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>

                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr style="display: none">
                        <td>Khổ giấy</td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtKhoGiay" runat="server" Style="text-align: right;"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td>Định lượng</td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree  drop short-control-50">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtDinhLuong" runat="server" Style="text-align: right;"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td>Diện tích sản phẩm</td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtDienTichSanPham" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td>Công đoạn kết thúc</td>
                        <td>
                            <asp:DropDownList ID="dropCongDoanKetThuc" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>Đơn giá</td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree  drop short-control-50">
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
                                        <asp:TextBox ID="txtThanhTien" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>Ghi chú</td>
                        <td colspan="3">
                            <asp:TextBox ID="txtGhiChu" runat="server" TextMode="MultiLine"></asp:TextBox>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix button-list">
    <input type="button" id="btnSave" class="xrp-button" value="Lưu" />
    <input type="button" value="Hủy" onclick="CloseModal();" class="xrp-button" />
</div>
<div id="content_song" title="Danh sách sóng">
</div>
<script type="text/javascript">
    function OpenModalSong(id) {
        LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Administrator/QuanLyDonHang/DonHang/DanhSachLoaiSong.ascx", "&id=" + id, "content_song");
        $("#content_song").dialog({
            modal: true,
            width: 400,
            height: 450,
            buttons: {
                "Chọn": function () {

                },
                "Hủy": function () {
                    $("#content_song").dialog("close");;
                }
            },
        });
    }
</script>
