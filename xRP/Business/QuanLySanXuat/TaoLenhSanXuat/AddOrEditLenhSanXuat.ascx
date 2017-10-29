<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddOrEditLenhSanXuat.ascx.cs" Inherits="xRP.Business.QuanLySanXuat.TaoLenhSanXuat.AddOrEditLenhSanXuat" %>
<%@ Register Assembly="CollectionPager" Namespace="SiteUtils" TagPrefix="cc1" %>

<script type="text/javascript">
    var thoiGianCanSanXuat = parseFloat("<%=thoiGianCanSanXuat%>");
    var congXuatMaySong = parseFloat("<%=congXuatMaySong%>");
    var dataYeuCauSanXuat = [];
    var lsLenhSXChiTiet = [];
    var lenhsanxuatId = parseInt(0 + "<%=IDLenhSanXuat%>");
    var lenhSanXuat;
    $(function () {

        if (lenhsanxuatId > 0) {
            lenhSanXuat = new LenhSanXuat({ ID: lenhsanxuatId, IDCongDoan: parseInt("<%=IDCongDoan%>") });
            lenhSanXuat.data.Status = 'Pending';
            lsLenhSXChiTiet = lenhSanXuat.getDanhSachLenhSanXuatChiTiet();
            for (var i = 0; i < lsLenhSXChiTiet.length; i++) {
                lsLenhSXChiTiet[i].data.dataDinhMucVatTu = lsLenhSXChiTiet[i].getDanhSachDinhMucVatTu();
                //lsLenhSXChiTiet[i].data.dataVatTu = lsLenhSXChiTiet[i].getDanhSachVatTu();                
                if (lsLenhSXChiTiet[i].data.ID > 0) {
                    //Add khi sửa.                
                    lsLenhSXChiTiet[i].data.IsSave = 1;
                }
            }
            InitTableLenhSanXuatChiTiet(lsLenhSXChiTiet);
        } else {
            lenhSanXuat = new LenhSanXuat({ ID: 0, IDCongDoan: parseInt("<%=IDCongDoan%>") });
            lenhSanXuat.data.Status = 'Draft';
        }

        $('.icon-up-cs, .icon-down-cs').click(function () {
            upDown(this);
        });

        $('#txtSoLuongCanSanXuat').change(function () {
            var index = $(this).attr("index");
            var soLuongYeuCau = parseInt($('#txtSoLuongYeuCau').val());

            if ($.isNumeric($(this).val())) {

                var soLuongCanSanXuat = parseInt($(this).val());

                if (soLuongCanSanXuat < 0 || soLuongCanSanXuat > soLuongYeuCau) {
                    alert('Số lượng cần sản xuất phải lớn hơn 0 và nhỏ hơn hoặc bằng số lượng yêu cầu');
                    $(this).focus();
                    return;
                }
                $(this).val(soLuongCanSanXuat);
                changeSoLuongYeuCau(index, soLuongCanSanXuat);
            } else {
                $(this).focus();
                return;
            }
        });


        $("#btn-luu").on("click", function () {
            addOrEditLenhSanXuat();
            return false;
        });

        $("#btn-luu-print").on("click", function () {
            addOrEditLenhSanXuat(true);
            return false;
        });
        $('#<%=txtNgayTao.ClientID%>').datetimepicker({
            mask: '99/99/9999', timepicker: false,
            format: 'd/m/Y'
        });
        $('.date').mask('00/00/0000');

        BindKhachHang();
        BindYeuCauSanXuatTextBox();

        $('#<%=txtTenKhachHang.ClientID%>').keypress(function () {
            if (event.which == 13) {
                event.preventDefault();
                $('#<%=txtDonHang.ClientID%>').focus();
                return false;
            }
        });

        $('#<%=txtDonHang.ClientID%>').keypress(function () {
            if (event.which == 13) {
                event.preventDefault();
                $('#btnSeach').focus();
                return false;
            }
        });


        $('.rbo-phuongan').change(function () {

            var index = $(this).attr('index');
            var dinhMucVatTuData = lsLenhSXChiTiet[index].data.dataDinhMucVatTu;
            if (dinhMucVatTuData.length > 0) {
                for (var i = 0; i < dinhMucVatTuData.length; i++) {
                    lsLenhSXChiTiet[index].data.dataDinhMucVatTu[i].data.ID = 0;
                    lsLenhSXChiTiet[index].data.dataDinhMucVatTu[i].data.IDVatTu = 0;
                    lsLenhSXChiTiet[index].data.dataDinhMucVatTu[i].data.TenVatTu = '';
                    lsLenhSXChiTiet[index].data.dataDinhMucVatTu[i].data.IDDonViTinh = 0;
                    lsLenhSXChiTiet[index].data.dataDinhMucVatTu[i].data.DonViTinh = '';
                    lsLenhSXChiTiet[index].data.dataDinhMucVatTu[i].data.DinhLuong = 0;
                    lsLenhSXChiTiet[index].data.dataDinhMucVatTu[i].data.SoLuong = 0;
                }
            }

            if (lsLenhSXChiTiet[index].data.DoiPhuongAn == 0)
                lsLenhSXChiTiet[index].data.DoiPhuongAn = 1;

            InitTableDinhMucVatTu(dinhMucVatTuData, index);
            $('.clsTenVatTu').val('');
        });
    });

    function upDown(control) {
        var row = $(control).parents('tr:first'), $reindex_start;
        if ($(control).is('.icon-up-cs')) {
            row.insertBefore(row.prev());
            $reindex_start = row;
        }
        else {
            $reindex_start = row.next()
            row.insertAfter($reindex_start);
        }
        var index = $reindex_start.index() + 1;
        $reindex_start.nextAll().andSelf().each(function (i) {
            $(this).find('.sothutu').html(index + i);
            var ctr = $(this).find('.thutu-uutien');

            $(ctr).val(index + i);

            var dataIndex = $(ctr).attr('index');
            lsLenhSXChiTiet[dataIndex].data.TT = index + i;
        });
    }

    function BindKhachHang() {
        queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONKhachHangForAutoComplete", "{}", function (result) {
            var objJSON = JSON.parse(result.d);
            $('#<%=txtTenKhachHang.ClientID%>').autocomplete({
                lookup: objJSON,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }

                },
                onSelect: function (suggestion) {
                    $('#<%=slcTenKhachHang.ClientID%>').val(suggestion.data);

                    BindDonHang(suggestion.data);
                },
                onHint: function (hint) {
                },
                onInvalidateSelection: function () {
                    $('#<%=slcTenKhachHang.ClientID%>').val("");
                }
            });
        });
    }

    function BindDonHang(makhachhang) {
        queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataDonHangForAutoComplete", "{maKhachHang:\"" + makhachhang + "\"}", function (result) {
            var objJSON = JSON.parse(result.d);
            $('#<%=txtDonHang.ClientID%>').autocomplete({
                lookup: objJSON,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }

                },
                onSelect: function (suggestion) {
                    $('#<%=slcDonHang.ClientID%>').val(suggestion.data);

                },
                onHint: function (hint) {
                },
                onInvalidateSelection: function () {
                    $('#<%=txtDonHang.ClientID%>').val("");
                }
            });
        });
    }

    function addOrEditLenhSanXuat(isPrint, notshowConfirm, notReload) {
        if (!notshowConfirm == true)
            if (!confirm("Bạn có muốn lưu lệnh sản xuất này không?")) return;

        var congDoanId = $("#<%=ddlCongDoan.ClientID%>").val();
        var ngayTao = $("#<%=txtNgayTao.ClientID%>").val();

        try {
            var date = $.datepicker.parseDate('dd/mm/yy', ngayTao);
        }
        catch (err) {
            alert("Bạn chưa nhập Ngày sản xuất.");
            $("#<%=txtNgayTao.ClientID%>").focus();
            return;
        }
        var countLenhSanXuatChiTiet = 0;
        var countDinhMuc = 0;
        $.each(lsLenhSXChiTiet, function (idx, lenhSanXuatChiTiet) {
            if (lenhSanXuatChiTiet.data.SoLuongYeuCau > 0 && lenhSanXuatChiTiet.data.IsSave > 0) {
                countLenhSanXuatChiTiet++;//có lệnh chi tiết.
            }

            $.each(lenhSanXuatChiTiet.data.dataDinhMucVatTu, function (idx, dmVatTu) {
                if (dmVatTu.data.IDVatTu < 1)
                    countDinhMuc++; 
            });

        });

        if (lsLenhSXChiTiet.length < 1) {
            if (!confirm("Lệnh sản xuất chưa có lệnh sản xuất chi tiết, bạn có muốn tiếp tục lưu?")) {
                $("#<%=ddlCongDoan.ClientID%>").focus();
                return;
            }
        } else {
            if (countLenhSanXuatChiTiet < 1 && !confirm("Lệnh sản xuất chưa có số lượng yêu cầu, bạn có muốn tiếp tục lưu?")) {
                $("#<%=ddlCongDoan.ClientID%>").focus();
                return;
            }
        }

        if (countDinhMuc > 0) {
            if (!confirm("Lệnh sản xuất chưa có định mức vật tư, bạn có muốn tiếp tục lưu?")) {
                $("#<%=ddlCongDoan.ClientID%>").focus();
                return;
            }
        }
        lenhSanXuat.dataChiTiet = lsLenhSXChiTiet;
        lenhSanXuat.data.ID = lenhsanxuatId;
        lenhSanXuat.data.DanhSachYeuCauSanXuat = '';
        lenhSanXuat.data.IDCongDoan = $("#<%=ddlCongDoan.ClientID%>").val();
        lenhSanXuat.data.NgaySanXuat = $("#<%=txtNgayTao.ClientID%>").val();
        lenhSanXuat.data.ThoiGianCanSanXuat = thoiGianCanSanXuat;
        lenhSanXuat.save(onSucessLenhSanXuat, isPrint, notshowConfirm, notReload);

    }
    function onSucessLenhSanXuat(result, isPrint, notshowConfirm, notReload) {
        if (result != 0) {
            if (notReload != true) {
                if (isPrint == true)
                    window.location = '/Business/QuanLySanXuat/Default.aspx?page=plsx&cd=<%=IDCongDoan%>' + '&lenhSanXuatId=' + Math.abs(result);
                else
                    window.location = '/Business/QuanLySanXuat/Default.aspx?page=lsx';
            }
        }
        else
            alert('Có lỗi trong quá trình cập nhật lệnh sản xuất');
    }

    function OpenTinhDinhMucVatTu(index) {

        if (lenhsanxuatId < 1) {
            //if (confirm("Lệnh sản xuất chưa được tạo, bạn phải tạo lệnh sản xuất trước khi tính định mức vật tư, bạn có muốn tạo lệnh sản xuất?"))
            SaveYeuCauSanXuat();
            //else
            //    return;
        } else {

            InitDataDinhMucVatTu();
            DinhMucVatTuBindData(index);
            var title = "Cập nhật định mức vật tư";

            $("#btnSaveDinhMucVatTu").attr("onclick", "SaveDinhMucVatTu(" + index + ")");

            $('.rbo-phuongan').attr("index", index);


            $("#txtSoLuongCanSanXuat").attr("index", index);

            $("#content_div").dialog({ modal: true, width: 1024, height: 600, title: title });
        }
    }

    //Init Table
    function InitTableDinhMucVatTu(dinhMucVatTuData, index) {

        $("#tabDinhMucVatTu tbody").text("");
        if (dinhMucVatTuData.length > 0) {
            for (var i = 0; i < dinhMucVatTuData.length; i++) {
                var dataStr = dinhMucVatTuData[i].data.MaHieuVatTu;


                if (dataStr.length > 0) dataStr += ' - ';
                var data = "<tr><td class='center-col'>" + (i + 1) + "</td>";
                data += "<td class=''>" + dinhMucVatTuData[i].data.TenLop + "</td>";
                data += "<td class=''>" + dinhMucVatTuData[i].data.TenLoaiVatTu + "</td>";
                //data += "<td class='center-col'> <input type='text' lsxctid='" + dinhMucVatTuData[i].data.IDLenhSanXuatChiTiet + "' value='" + dataStr + dinhMucVatTuData[i].data.TenVatTu + "' soLuongCanSanXuat='" + lsLenhSXChiTiet[index].data.SoLuong + "' yeuCauSanXuatId='" + lsLenhSXChiTiet[index].data.IDYeuCauSanXuat + "' loaigiayid='" + dinhMucVatTuData[i].data.IDLoaiGiay + "' khogiay='" + dinhMucVatTuData[i].data.KhoGiay + "'  class='clsTenVatTu' index='" + i + "' dinhmucvattu='" + dinhMucVatTuData[i].data.IDPhatSinhTieuHaoVatTu + "'  id='txt-IDVatTu-" + dinhMucVatTuData[i].data.IDPhatSinhTieuHaoVatTu + "' style='min-width:350px'    /></td>";
                data += "<td class='center-col'> <input type='text' class='clsTenVatTu' value='" + dataStr + dinhMucVatTuData[i].data.TenVatTu + "' id='txt-IDVatTu-" + dinhMucVatTuData[i].data.IDPhatSinhTieuHaoVatTu + "' index='" + i + "' style='min-width:350px'  /></td>";

                data += "<td class='center-col'><input value='" + dinhMucVatTuData[i].data.HeSoTieuHao + "'  id='txt-HeSoTieuHao-" + dinhMucVatTuData[i].data.IDPhatSinhTieuHaoVatTu + "' class='clsHeSoTieuHao number-monney' index='" + i + "' dinhmucvattu='" + dinhMucVatTuData[i].data.IDPhatSinhTieuHaoVatTu + "' style='width:70px' /></td>";
                data += "<td class='center-col'><input value='" + dinhMucVatTuData[i].data.DonViTinh + "'  id='txt-DonViTinh-" + dinhMucVatTuData[i].data.IDPhatSinhTieuHaoVatTu + "'  readonly='readonly' style='width:100px'  /></td>";
                data += "<td class='center-col'><input value='" + formatNumber(dinhMucVatTuData[i].data.SoLuong, 0) /*Number(dinhMucVatTuData[i].data.SoLuong).toFixed(3) */ + "'  id='txt-SoLuong-" + dinhMucVatTuData[i].data.IDPhatSinhTieuHaoVatTu + "'   style='width:100px' class='number-monney' /></td>";
                data += "</td></tr>";
                $("#tabDinhMucVatTu tbody").append(data);
            }
            $('.clsTenVatTu').focus(function () {

                var idx = parseInt($(this).attr('index'));
                var dataStr = "{yeuCauSanXuatId:" + lsLenhSXChiTiet[index].data.IDYeuCauSanXuat;
                dataStr += ",soLuongCanSanXuat:" + lsLenhSXChiTiet[index].data.SoLuong;
                dataStr += ",idLoaiGiay:" + dinhMucVatTuData[idx].data.IDLoaiGiay;
                dataStr += ",loaiPhuongAn:'" + $('input[name="phuongan"]:checked').val() + "'";
                dataStr += ",lenhSanXuatChiTietID:" + lsLenhSXChiTiet[index].data.ID + "}";

                queryData("/WebService/DanhMuc.asmx/GetJSONDataVatTuDapUngByTenForAutoComplete", dataStr, function (result) {
                    var returnDataObject = JSON.parse(result.d);
                    $('.clsTenVatTu').autocomplete({
                        lookup: returnDataObject,
                        lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                            if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }
                        },
                        onSelect: function (suggestion) {
                            var _index = parseInt($(this).attr("index"));
                            var dinhmucvattu = dinhMucVatTuData[_index].data.IDPhatSinhTieuHaoVatTu;
                            lsLenhSXChiTiet[index].data.dataDinhMucVatTu[_index].data.IDVatTu = suggestion.ID;
                            lsLenhSXChiTiet[index].data.dataDinhMucVatTu[_index].data.TenVatTu = suggestion.value;
                            lsLenhSXChiTiet[index].data.dataDinhMucVatTu[_index].data.IDDonViTinh = suggestion.IDDonViTinh;
                            lsLenhSXChiTiet[index].data.dataDinhMucVatTu[_index].data.DonViTinh = suggestion.DonViTinh;
                            lsLenhSXChiTiet[index].data.dataDinhMucVatTu[_index].data.DinhLuong = suggestion.DinhLuong;
                            lsLenhSXChiTiet[index].data.dataDinhMucVatTu[_index].data.SoLuong = formatNumber(calSoLuong(lsLenhSXChiTiet[index].data.dataDinhMucVatTu[_index], lsLenhSXChiTiet[index]), 0);
                            $('#txt-SoLuong-' + dinhmucvattu).val(lsLenhSXChiTiet[index].data.dataDinhMucVatTu[_index].data.SoLuong);
                            $('#txt-DonViTinh-' + dinhmucvattu).val(suggestion.DonViTinh);
                        },
                        onHint: function (hint) {
                        },
                        onInvalidateSelection: function () {

                        }
                    });
                });
            });

        } else {
            $("#tabDinhMucVatTu tbody").append("<tr><td class='center-col' colspan='6' style='padding:20px 5px;' ><b>Loại sóng này chưa được định nghĩa cơ cấu giấy. <a href='" + "<%=Util.SERVER_NAME%>/Business/QuanLySanXuat/Default.aspx?page=ccg" + "' target='_blank' title='Định nghĩa cơ cấu giấy'>Click vào đây để định nghĩa</a></b></td>");
            $('#btnSaveDinhMucVatTu').hide();
        }

        $('.clsHeSoTieuHao').change(function () {
            var _index = parseInt($(this).attr("index"));
            var dinhmucvattu = parseInt($(this).attr("dinhmucvattu"));
            lsLenhSXChiTiet[index].data.dataDinhMucVatTu[_index].data.HeSoTieuHao = $(this).val();
            lsLenhSXChiTiet[index].data.dataDinhMucVatTu[_index].data.SoLuong = formatNumber(calSoLuong(lsLenhSXChiTiet[index].data.dataDinhMucVatTu[_index], lsLenhSXChiTiet[index]), 0);
            $('#txt-SoLuong-' + dinhmucvattu).val(lsLenhSXChiTiet[index].data.dataDinhMucVatTu[_index].data.SoLuong);
        });
    }
    function DinhMucVatTuBindData(index) {
        var yeuCauSanXuatId = lsLenhSXChiTiet[index].data.IDYeuCauSanXuat;
        var lenhsanxuatchitietId = lsLenhSXChiTiet[index].data.ID;
        lenhsanxuatchitietId = $.isNumeric(lenhsanxuatchitietId) == false ? 0 : lenhsanxuatchitietId;
        if (yeuCauSanXuatId != null && yeuCauSanXuatId != "" && yeuCauSanXuatId != "0") {
            queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetDanhSachPhuongAnLsx", "{yeucausanxuatId:" + yeuCauSanXuatId + ",lenhsanxuatchitietId:" + lenhsanxuatchitietId + "}", function (result) {
                var objJSON = JSON.parse(result.d);
                if (objJSON.length > 0) {
                    $("#tabDanhSachPhuongAnSX tbody").text("");
                    var dataintab = "";
                    for (var i = 0; i < objJSON.length; i++) {
                        $("#tabDanhSachPhuongAnSX tbody").append("<tr><td class='center-col'>" + (i + 1) + "</td><td>" + objJSON[i].TenLoaiVatTu + "</td><td class='center-col'>" + objJSON[i].KhoGiayYeuCau + "</td><td class='center-col'>" + objJSON[i].TongHeSoTieuHao + "</td><td>" + objJSON[i].VatTuThoaMan + "</td></tr>");
                    }
                }
            });
        }


        if (yeuCauSanXuatId != null && yeuCauSanXuatId != "" && yeuCauSanXuatId != "0") {
            queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetDanhSachPhuongAnVatTuToiUuLsx", "{yeucausanxuatId:" + yeuCauSanXuatId + ",lenhsanxuatchitietId:" + lenhsanxuatchitietId + "}", function (result) {
                var objJSON = JSON.parse(result.d);
                if (objJSON.length > 0) {
                    $("#tabDanhSachPhuongAnVatTuToiUu tbody").text("");
                    var dataintab = "";
                    for (var i = 0; i < objJSON.length; i++) {

                        $("#tabDanhSachPhuongAnVatTuToiUu tbody").append("<tr><td class='center-col'>" + (i + 1) + "</td><td>" + objJSON[i].TenLoaiVatTu + "</td><td class='center-col'>" + objJSON[i].KhoGiayYeuCau + "</td><td class='center-col'>" + objJSON[i].TongHeSoTieuHao + "</td><td>" + objJSON[i].VatTuThoaMan + "</td></tr>");
                    }
                }
            });
        }


        //--Lấy lệnh sản xuất chi tiết và danh sách định mức vật tư theo lệnh sản xuất chi tiết.  
        var lenhSanXuatChiTietData = lsLenhSXChiTiet[index];
        var dinhMucVatTuData = lsLenhSXChiTiet[index].data.dataDinhMucVatTu;
        var dataVatTu = lsLenhSXChiTiet[index].data.dataVatTu;
        if (parseInt(lenhSanXuatChiTietData.data.SoLuongYeuCau) < 1) {
            lenhSanXuatChiTietData.data.SoLuongYeuCau = lenhSanXuatChiTietData.data.SoLuongYeuCauSanXuatKeHoachConLai;
        }

        $("#txtLoaiSong").val(lenhSanXuatChiTietData.data.KiHieuCoCauGiay + ' - ' + lenhSanXuatChiTietData.data.MoTaCoCauGiay);
        $("#txtSolop").val(lenhSanXuatChiTietData.data.SoLop);


        $("#txtSoLuongYeuCau").val(lenhSanXuatChiTietData.data.SoLuongYeuCauSanXuatKeHoachConLai);
        $("#txtSoLuongCanSanXuat").val(lenhSanXuatChiTietData.data.SoLuongYeuCau);
        $("#spMaHieuMatHang").html(lenhSanXuatChiTietData.data.TenMatHang);
        $('#btnSaveDinhMucVatTu').attr('vatTuId', lenhSanXuatChiTietData.data.MaMatHang);
        InitTableDinhMucVatTu(dinhMucVatTuData, index);

    }

    function CloseModal(index) {
        var lenhSanXuatChiTietData = lsLenhSXChiTiet[index];
        var dataDinhMucVatTu = lenhSanXuatChiTietData.data.dataDinhMucVatTu;
        for (var i = 0; i < dataDinhMucVatTu.length; i++) {
            if (dataDinhMucVatTu[i].data.IDVatTu < 1) {
                alert('Hãy chọn vật tư tính định mức');
                return;
            }
        }
        lsLenhSXChiTiet[index].data.IsSave = 1;
        InitTableLenhSanXuatChiTiet(lsLenhSXChiTiet);
        $('#txtSoLuongCanSanXuat').removeAttr("index");
        $("#content_div").dialog("close");
    }

    function changeSoLuongYeuCau(index, soLuongYeuCau) {
        lsLenhSXChiTiet[index].data.SoLuongYeuCau = soLuongYeuCau;
        //lsLenhSXChiTiet[index].data.SoLuongYeuCauSanXuatKeHoachConLai = lsLenhSXChiTiet[index].data.SoLuongYeuCauSanXuatKeHoachConLai - soLuongYeuCau;

        for (var i = 0; i < lsLenhSXChiTiet[index].data.dataDinhMucVatTu.length; i++) {
            lsLenhSXChiTiet[index].data.dataDinhMucVatTu[i].data.SoLuong = calSoLuong(lsLenhSXChiTiet[index].data.dataDinhMucVatTu[i], lsLenhSXChiTiet[index]);
        }
        InitTableDinhMucVatTu(lsLenhSXChiTiet[index].data.dataDinhMucVatTu, index);
        InitTableLenhSanXuatChiTiet(lsLenhSXChiTiet);
        return;
    }


    function getDisplayTime(value) {
        var displayTime = '0h 0" 0s';
        if (!isNaN(value) && isFinite(value)) {
            value = value / 60;
            //.toFixed(2)
            var time = Math.floor(value);
            var minute = (value - Math.floor(value)) * 60;
            var second = (minute - Math.floor(minute)) * 60;
            //  Math.floor((value - Math.floor(value)) * 60);
            displayTime = time + 'h ' + Math.floor(minute) + '" ' + Math.round(second) + "s";
        }
        return displayTime;
    }

    function InitTableLenhSanXuatChiTiet(lsLenhSXChiTiet) {
        var tongMetDai = 0, tongThoiGianSanXuat = 0, tongSoLuongYeuCau = 0, tongSoLuongCanSanXuat = 0;
        $("#tabDanhSachLenhSanXuat tbody").text("");

        for (var i = 0; i < lsLenhSXChiTiet.length; i++) {
            var data = "<tr>";
            if (lsLenhSXChiTiet[i].data.IsSave == 1) {
                data = "<tr class='table-tr-select'>";
            }

            var tyle = 1;
            if (lsLenhSXChiTiet[i].data.SoLuongYeuCauSanXuatKeHoachConLai > 0)
                tyle = lsLenhSXChiTiet[i].data.SoLuongYeuCau / lsLenhSXChiTiet[i].data.SoLuongYeuCauSanXuatKeHoachConLai;

            lsLenhSXChiTiet[i].data.QuyDoiMetDai = (tyle * lsLenhSXChiTiet[i].data.ChatDai * lsLenhSXChiTiet[i].data.SoLuongTam) / 1000;
            lsLenhSXChiTiet[i].data.ThoiGianSanXuat = 60 * lsLenhSXChiTiet[i].data.QuyDoiMetDai / congXuatMaySong;//thoiGianCanSanXuat;


            // lsLenhSXChiTiet[i].data.ThoiGianSanXuat = (tyle * lsLenhSXChiTiet[i].data.ChatDai * lsLenhSXChiTiet[i].data.SoLuongTam) / (1000 * thoiGianCanSanXuat);  
            data += "<td class='center-col sothutu' >" + (i + 1) + "</td>";
            data += "<td class='center-col'>" + lsLenhSXChiTiet[i].data.MaHieuDonHang + "</td>";
            data += "<td  >" + lsLenhSXChiTiet[i].data.TenMatHang + "</td>";
            data += "<td class='center-col'>" + lsLenhSXChiTiet[i].data.MaHieuMatHang + "</td>";
            data += "<td class='center-col'>" + lsLenhSXChiTiet[i].data.KiHieuCoCauGiay + "</td>";
            data += "<td class='center-col'>" + lsLenhSXChiTiet[i].data.KTTam + "</td>";
            data += "<td class='center-col'>" + lsLenhSXChiTiet[i].data.KichThuoc + "</td>";
            data += "<td class='center-col'>" + lsLenhSXChiTiet[i].data.MaHieuKichThuoc + "</td>";
            data += "<td class='center-col'>" + lsLenhSXChiTiet[i].data.TenLoaiSanPham + "</td>";
            data += "<td class='center-col'>" + lsLenhSXChiTiet[i].data.TongDao + "</td>";
            data += "<td class='center-col'>" + lsLenhSXChiTiet[i].data.Xa + "</td>";
            data += "<td class='center-col'>" + lsLenhSXChiTiet[i].data.KhoGiay + "</td>";
            data += "<td class='center-col'>" + lsLenhSXChiTiet[i].data.ChatDai + "</td>";
            data += "<td class='center-col'><input type='text' style='width:60px;' readonly='readonly' value='" + formatNumber(lsLenhSXChiTiet[i].data.QuyDoiMetDai, 2) + "'/></td>";
            data += "<td class='center-col'><input type='text' style='width:60px;' readonly='readonly' value='" + getDisplayTime(lsLenhSXChiTiet[i].data.ThoiGianSanXuat) + "'/></td>";
            data += "<td class='center-col'>" + lsLenhSXChiTiet[i].data.SoLuongTam + "</td>";
            data += "<td class='center-col'>" + lsLenhSXChiTiet[i].data.SoLuongHop + "</td>";
            //  data += "<td class='center-col'>" + lsLenhSXChiTiet[i].data.SoLuongYeuCauSanXuatKeHoachConLai + "</td>";
            data += "<td class='center-col'><input value='" + lsLenhSXChiTiet[i].data.SoLuongYeuCau + "'   index='" + i + "' readonly='readonly'  id='txt-SLDaSanXuat-" + lsLenhSXChiTiet[i].data.SoLuongYeuCau + "' class='number parse-data yeucau-select' style='width: 60px' /></td>";
            data += "<td class='center-col'><input value='" + lsLenhSXChiTiet[i].data.TT + "'   index='" + i + "'   id='txt-TT-" + lsLenhSXChiTiet[i].data.IDYeuCauSanXuat + "'  style='width: 50px' readonly='true' class='number thutu-uutien' /></td>";
            // data += "<td class='center-col'><a title='Go up' class='icon-up-cs cns-icon'></a><a class='icon-down-cs cns-icon' title='Go down'></a>";
            data += "<td class='center-col'>";
            if ($('#<%=ddlCongDoan.ClientID%>').val() == 1) {
                data += "<a id='update-icon' title='Tính định mức vật tư' href='javascript:OpenTinhDinhMucVatTu(" + i + ");'>";
                data += "<span class='icon icon-kcs'></span></a>";
            }

            data += "<a id='update-icon' title='Xóa' href='javascript:deleteYeuCauSanXuat(" + lsLenhSXChiTiet[i].data.ID + "," + i + ");'>";
            data += "<span class='icon icon-delete'></span></a>";


            data += "</td></tr>";
            $("#tabDanhSachLenhSanXuat tbody").append(data);

            if (!isNaN(lsLenhSXChiTiet[i].data.QuyDoiMetDai) && isFinite(lsLenhSXChiTiet[i].data.QuyDoiMetDai))
                tongMetDai += parseFloat(lsLenhSXChiTiet[i].data.QuyDoiMetDai);

            if (!isNaN(lsLenhSXChiTiet[i].data.ThoiGianSanXuat) && isFinite(lsLenhSXChiTiet[i].data.ThoiGianSanXuat))
                tongThoiGianSanXuat += parseFloat(lsLenhSXChiTiet[i].data.ThoiGianSanXuat);

            if (parseInt(lsLenhSXChiTiet[i].data.SoLuongYeuCau) > 0)
                tongSoLuongYeuCau += parseInt(lsLenhSXChiTiet[i].data.SoLuongYeuCau);

            //tongSoLuongCanSanXuat += parseInt(lsLenhSXChiTiet[i].data.SoLuongYeuCau);
        }

        var dataSum = "<tr style='background-color: #ebebeb; border-top: 2px solid white;'><td class='center-col' colspan='13'><b>Tổng số</b></td>";

        dataSum += "<td  ><b>" + formatNumber(tongMetDai, 2) + "</b></td>";
        dataSum += "<td class='center-col'><b>" + getDisplayTime(tongThoiGianSanXuat) + "</b></td>";
        dataSum += "<td class='center-col' colspan='2'> &nbsp; </td>";
        dataSum += "<td class='center-col'><b>" + tongSoLuongYeuCau + "</b></td>";
        dataSum += "<td><b></b></td>";
        //dataSum += "<td><b>" + tongSoLuongCanSanXuat + "</b></td>";
        dataSum += "<td class='center-col' colspan='2'> &nbsp;</td></tr>";
        $("#tabDanhSachLenhSanXuat tbody").append(dataSum);

        $('.yeucau-select').change(function () {

            var index = $(this).attr("index");
            var soLuongYeuCau = $(this).val();
            if (!$.isNumeric(soLuongYeuCau)) {
                alert('Nhập sai dữ liệu số lượng');
                $(this).focus();
                return;
            }
            changeSoLuongYeuCau(index, soLuongYeuCau);
        });

        $('.icon-up-cs, .icon-down-cs').click(function () {
            upDown(this);
        });
    }

    function InitDataDinhMucVatTu() {
        $('#txtSoLuongYeuCau').val("");
        $('#txtSoLuongCanSanXuat').val("");
        $("#txtLoaiSong").val("");
        $("#txtSoLop").val("");
        $("#tabDinhMucVatTu tbody").text("");
    }

    function calSoLuong(dataDinhMucVatTu, lsLenhSXChiTiet) {
        // alert("Định lượng:" + dataDinhMucVatTu.data.DinhLuong + "Khổ:" + lsLenhSXChiTiet.data.KhoGiay + "Chặt dài:" + lsLenhSXChiTiet.data.ChatDai + "Số lượng tấm:" + lsLenhSXChiTiet.data.SoLuongTam + "Hệ số tiêu hao:" + lsLenhSXChiTiet.data.HeSoTieuHao + "Số lượng yêu cầu/Số lượng yêu cầu sản xuất kế hoạck" + (lsLenhSXChiTiet.data.SoLuongYeuCau / lsLenhSXChiTiet.data.SoLuongYeuCauSanXuatKeHoach) + "/1000000000");
        var alog = "DinhLuong:" + dataDinhMucVatTu.data.DinhLuong;
        alog += ",KhoGiay:" + lsLenhSXChiTiet.data.KhoGiay;
        alog += ",ChatDai:" + lsLenhSXChiTiet.data.ChatDai;
        alog += ",SoLuongTam:" + lsLenhSXChiTiet.data.SoLuongTam;
        alog += ",HeSoTieuHao:" + dataDinhMucVatTu.data.HeSoTieuHao;
        alog += "SoLuongYeuCau[" + lsLenhSXChiTiet.data.SoLuongYeuCau + "]/SoLuongYeuCauSanXuatKeHoach[" + lsLenhSXChiTiet.data.SoLuongYeuCauSanXuatKeHoach + "]:" + (lsLenhSXChiTiet.data.SoLuongYeuCau / lsLenhSXChiTiet.data.SoLuongYeuCauSanXuatKeHoach);
        var ketqua;
        $.ajax({
            type: "POST",
            url: "<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSonKhoGiayByIDVatTu",
            data: "{id:\"" + dataDinhMucVatTu.data.IDVatTu + "\"}",
            cache: false,
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            async: false,
            error: function (XMLHttpRequest, textStatus, errorThrown) {

            },
            success: function (result) {
                ketqua = dataDinhMucVatTu.data.DinhLuong
                                                 * parseFloat(result.d)
                                                 * lsLenhSXChiTiet.data.ChatDai
                                                 * lsLenhSXChiTiet.data.SoLuongTam
                                                 * dataDinhMucVatTu.data.HeSoTieuHao
                                                 * (lsLenhSXChiTiet.data.SoLuongYeuCau / lsLenhSXChiTiet.data.SoLuongYeuCauSanXuatKeHoach)
                                                 / 1000000000;
                return ketqua;
            }
        });
        return ketqua;

    }


    function BindYeuCauSanXuatTextBox() {
        var congDoan = $("#<%=ddlCongDoan.ClientID%>").val();
        var khachHangId = $("#<%=slcTenKhachHang.ClientID%>").val();
        var donHangId = $("#<%=slcDonHang.ClientID%>").val();
        queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataYeuCauSanXuatForAutoComplete", "{congDoan:'" + congDoan + "',khachHangId:'" + khachHangId + "',donHangId:'" + donHangId + "'}", function (result) {
            var objJSON = JSON.parse(result.d);
            $('#<%=txtYeuCauSanXuat.ClientID%>').autocomplete({
                lookup: objJSON,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }
                },
                onSelect: function (suggestion) {
                    if (lenhsanxuatId < 1) {
                        SaveYeuCauSanXuat();
                    }

                    BindDataLenhSanXuat(suggestion.data);
                    $('#<%=txtYeuCauSanXuat.ClientID%>').val('');
                },
                onHint: function (hint) {
                },
                onInvalidateSelection: function () {
                    $('#<%=txtDonHang.ClientID%>').val("");
                }
            }).focus(function () {
                $(this).val('');
            });;
        });
    }

    function checkSoLuongCanSanXuat(index) {
        var lenhChiTiet = lsLenhSXChiTiet[index];
        var soluong = 0;
        $.each(lsLenhSXChiTiet, function (dx, lct) {
            if (lct.data.MaHieuDonHang == lenhChiTiet.data.MaHieuDonHang) {
                soluong += lct.data.SoLuongYeuCau;
            }
        });
        if (soluong > lenhChiTiet.data.SoLuongYeuCauSanXuatKeHoach) {
            alert("Tổng số số lượng cần sản xuất của mặt hàng:'" + lenhChiTiet.data.MaHieuMatHang + " - " + lenhChiTiet.data.TenMatHang + "' lớn hơn số lượng cần sản xuất.");
            return false;
        }
        return true;
    }

    function InitTableYeuCauSanXuat() {
        var title = "Danh sách yêu cầu sản xuất";
        $("#content_yeucausanxuat").dialog({ modal: true, width: 1024, height: 600, title: title });

        LoadYeuCauSanXuat();
    }
    function BindDataLenhSanXuat(yeuCauSanXuatId) {
        $('#<%=slcYeuCauSanXuat.ClientID%>').val(yeuCauSanXuatId);
        var lsSanXuatChiTiet = new LenhSanXuat({ ID: lenhsanxuatId, YeuCauSanXuatID: yeuCauSanXuatId }).getLenhSanXuatChiTiet();
        for (var i = 0; i < lsSanXuatChiTiet.length; i++) {

            if (lsSanXuatChiTiet[i].data.SoLuongYeuCauSanXuatKeHoachConLai > 0) {
                //Init list data DinhMucVatTu  
                lsSanXuatChiTiet[i].data.dataDinhMucVatTu = lsSanXuatChiTiet[i].getDanhSachDinhMucVatTu();
                //lsSanXuatChiTiet[i].data.dataVatTu = lsSanXuatChiTiet[i].getDanhSachVatTu();                
                if (lsSanXuatChiTiet[i].data.ID > 0) {
                    //Add khi sửa.
                    //lsSanXuatChiTiet[i].data.SoLuongYeuCauSanXuatKeHoachConLai += lsSanXuatChiTiet[i].data.SoLuongYeuCau;
                    lsSanXuatChiTiet[i].data.IsSave = 1;
                }
                lsLenhSXChiTiet.push(lsSanXuatChiTiet[i]);
            } else
                alert("Mặt hàng này có đã hết số lượng cần sản xuất.");
        }

        InitTableLenhSanXuatChiTiet(lsLenhSXChiTiet);
    }
    function deleteYeuCauSanXuat(id, index) {

        if (lsLenhSXChiTiet.length == 1) {
            if (!confirm("Bạn có muốn xóa mặt hàng cuối cùng trong lệnh?")) return;
        } else
            if (!confirm("Bạn có muốn xóa yêu cầu sản xuất này không?")) return;
        //Thực hiện xóa 
        /*                
        + Xóa định mức vật tư.<Sp_Qlsx_DinhMucVatTu_Deli>
        + Xóa lệnh sản xuất chi tiết <Sp_Qlsx_DinhMucVatTu_Deli>
        */
        lsLenhSXChiTiet[index].markDelete(onDeleteYeuCauSanXuat, index);
    }
    function onDeleteYeuCauSanXuat(result, index) {
        var data = 0;
        if (!isNaN(result.d)) {
            data = parseInt(result.d);
            if (data != 0) {
                lsLenhSXChiTiet.splice(index, 1);
                InitTableLenhSanXuatChiTiet(lsLenhSXChiTiet);
            }
            else
                alert('Có lỗi trong quá trình xóa lệnh sản xuất');
        }
        else if (result.d == 'Định mức Vật tư của Mặt hàng này không tồn tại, không xóa được') {
            lsLenhSXChiTiet.splice(index, 1);
            InitTableLenhSanXuatChiTiet(lsLenhSXChiTiet);

        }
        else alert(result.d);
    }


    function LoadYeuCauSanXuat() {
        var congDoan = $("#<%=ddlCongDoan.ClientID%>").val();
        var maKhachHang = $("#<%=slcTenKhachHang.ClientID%>").val();
        var donHang = $("#<%=slcDonHang.ClientID%>").val();
        $("#tabDanhSachYeuCauSanXuat tbody").text("");

        queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataYeuCauSanXuatForAutoComplete", "{congDoan:'" + congDoan + "',khachHangId:'" + maKhachHang + "',donHangId:'" + donHang + "'}", function (result) {
            dataYeuCauSanXuat = JSON.parse(result.d);
            for (var i = 0; i < dataYeuCauSanXuat.length; i++) {
                var dataHtml = "<tr><td class='center-col'>" + (i + 1) + "</td>";
                dataHtml += "<td class='center-col'>" + dataYeuCauSanXuat[i].mahieudonhang + "</td>";
                dataHtml += "<td>" + dataYeuCauSanXuat[i].tenmathang + "</td>";
                dataHtml += "<td class='center-col'>" + dataYeuCauSanXuat[i].mahieumathang + "</td>";
                dataHtml += "<td class='center-col'>" + dataYeuCauSanXuat[i].kttam + "</td>";
                dataHtml += "<td class='center-col'>" + dataYeuCauSanXuat[i].kichthuoc + "</td>";
                dataHtml += "<td class='center-col'>" + dataYeuCauSanXuat[i].solop + "</td>";
                dataHtml += "<td class='center-col'>" + dataYeuCauSanXuat[i].khogiay + "</td>";
                dataHtml += "<td class='center-col'>" + dataYeuCauSanXuat[i].tongdao + "</td>";
                dataHtml += "<td class='center-col'>" + dataYeuCauSanXuat[i].chatdai + "</td>";
                dataHtml += "<td class='center-col'>" + dataYeuCauSanXuat[i].soluongtam + "</td>";
                dataHtml += "<td class='center-col'>" + dataYeuCauSanXuat[i].soluonghop + "</td>";
                dataHtml += "<td class='center-col'>" + dataYeuCauSanXuat[i].soluongconlaicansanxuat + "</td>";
                dataHtml += "<td><a href='javascript:;' onclick='BindDataLenhSanXuat(" + dataYeuCauSanXuat[i].data + "); $(\"#content_yeucausanxuat\").dialog(\"close\");' >Chọn</a></td>";
                $("#tabDanhSachYeuCauSanXuat tbody").append(dataHtml);
            }
        });
    }



    function SaveYeuCauSanXuat() {
        lenhSanXuat.data.ID = lenhsanxuatId;
        lenhSanXuat.data.DanhSachYeuCauSanXuat = '';
        lenhSanXuat.data.IDCongDoan = $("#<%=ddlCongDoan.ClientID%>").val();
        lenhSanXuat.data.NgaySanXuat = $("#<%=txtNgayTao.ClientID%>").val();
        lenhSanXuat.saveYeuCauSanXuat(onSucessYeuCauSanXuat);
        return;
    }
    function onSucessYeuCauSanXuat(result) {
        if (result < 1) {
            var url = '';
            if (lsLenhSXChiTiet.length == 1) {
                if (confirm('Lệnh sản xuất đã tồn tại, hãy thêm lệnh sản xuất chi tiết'))
                    url = '/Business/QuanLySanXuat/Default.aspx?page=tlsx&cd=' + $('#<%= ddlCongDoan.ClientID%>').val() + '&lenhSanXuatId=' + Math.abs(result);
                else
                    url = '/Business/QuanLySanXuat/Default.aspx?page=lsx';
            }
            else
                url = '/Business/QuanLySanXuat/Default.aspx?page=lsx';
            window.location = url;
        }
        else {
            lenhsanxuatId = Math.abs(result);
            for (var i = 0; i < lsLenhSXChiTiet.length; i++) {
                lsLenhSXChiTiet[i].data.IDLenhSanXuat = lenhsanxuatId;
            }
        }
    }
    function SaveDinhMucVatTu(index) {
        var lenhSanXuatChiTietData = lsLenhSXChiTiet[index];
        var dataDinhMucVatTu = lenhSanXuatChiTietData.data.dataDinhMucVatTu;
        for (var i = 0; i < dataDinhMucVatTu.length; i++) {
            if (dataDinhMucVatTu[i].data.IDVatTu < 1) {
                alert('Hãy chọn vật tư tính định mức');
                return;
            }
        }
        var lsKiemTraVatTu = '';
        for (var i = 0; i < 10; i++) {
            if (dataDinhMucVatTu[i] != null) {
                if (i == 0)
                    lsKiemTraVatTu += 'IDVatTu' + (i + 1) + ':' + dataDinhMucVatTu[i].data.IDVatTu;
                else
                    lsKiemTraVatTu += ',IDVatTu' + (i + 1) + ':' + dataDinhMucVatTu[i].data.IDVatTu;

                lsKiemTraVatTu += ',SoLuongCan' + (i + 1) + ':' + dataDinhMucVatTu[i].data.SoLuong;
            } else {
                lsKiemTraVatTu += ',IDVatTu' + (i + 1) + ':' + 0;
                lsKiemTraVatTu += ',SoLuongCan' + (i + 1) + ':' + 0;
            }
        }

        $.ajax({
            type: "POST",
            url: "Default.aspx/KiemTraVatTu",
            data: "{" + lsKiemTraVatTu + "}",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Request: " + XMLHttpRequest + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                alert('Có lỗi trong quá trình xử lý');
            },
            success: function (result) {
                var data = 0;
                if (!isNaN(result.d)) {
                    data = parseInt(result.d);
                    if (data == 0) {
                       // if (checkSoLuongCanSanXuat(index))
                            lenhSanXuatChiTietData.save();
                    }
                    else if (data == 1) {
                        alert("Có lỗi trong quá trình tính định mức vật tư. Không đủ vật tư để sản xuất."); return;

                    }
                }
                else alert(result.d);
            }
        });

        InitTableLenhSanXuatChiTiet(lsLenhSXChiTiet);
        $("#content_div").dialog("close");
        //CloseModal(0);
    }
    // End định mức vật tư
</script>
<div class="splitter horizontal hub-splitter stateful toggle-button-enabled toggle-button-hotkey-enabled">
    <div class="rightPane" style="left: 0px;">
        <div class="hub-title">
        </div>
        <div class="right-hub-content">
            <div class="work-item-form">
                <div class="workitem-info-bar">
                    <div class="info-text-wrapper">
                        <span class="info-text">
                            <asp:Literal ID="lblTitle" runat="server"></asp:Literal></span>
                    </div>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block;">
                    <ul class="menu-bar">
                        <li class="menu-item icon-only">
                            <input type="button" tooltip="Lưu" id="btn-luu" class="menu-bar-item-button icon icon-save" />
                        </li>
                        <li class="menu-item icon-only">
                            <input type="button" tooltip="Lưu và in" id="btn-luu-print" class="menu-bar-item-button icon icon-save-printer" />
                        </li>
                        <asp:Literal ID="ltPrint" runat="server"></asp:Literal>
                        <asp:Literal ID="ltAccept" runat="server"></asp:Literal>

                        <li class="menu-item icon-only" id="btn-cancel">
                            <asp:Button ToolTip="Hủy" CssClass="menu-bar-item-button icon cancel-icon" runat="server" ID="Button3" OnClick="btnCancel_Click" />
                        </li>
                    </ul>
                </div>

                <div class="">
                </div>
                <div class="work-item-view" style="margin-left: 10px;">
                    <table class="witform-layout">
                        <tbody>
                            <tr>
                                <td style="width: 10%;"></td>
                                <td style="width: 40%;"></td>
                                <td style="width: 10%;"></td>
                                <td style="width: 35%;"></td>
                                <td style="width: 5%;"></td>
                            </tr>
                            <tr>
                                <td>
                                    <div>
                                        <span>Công đoạn sản xuất</span>
                                        <span style="color: red">*</span>
                                    </div>
                                </td>
                                <td>
                                    <div class="workitemcontrol">
                                        <div class="combo tree drop">
                                            <div class="wrap">
                                                <asp:DropDownList ID="ddlCongDoan" runat="server" DataTextField="TenCongDoan" DataValueField="ID" Enabled="false" ViewStateMode="Enabled" AutoPostBack="false" onchange="onChangeCongDoan(this)">
                                                    <asp:ListItem Text="Tạo sóng" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="In" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="In lưới" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="Ghim" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="Dán" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="Chạp" Value="1"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td>Ngày sản xuất</td>
                                <td>
                                    <div class="workitemcontrol">
                                        <div class="combo tree drop short-control-30">
                                            <div class="wrap">
                                                <asp:TextBox ID="txtNgayTao" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <%--<input type="button" id="btnSaveTmp" class="icon icon-save" style="cursor: pointer; border: medium none;" onclick="SaveYeuCauSanXuat(); return false;" />--%>

                                </td>

                            </tr>
                            <tr>
                                <td>Chọn mặt hàng</td>
                                <td colspan="3">
                                    <asp:HiddenField ID="slcYeuCauSanXuat" runat="server" />
                                    <asp:TextBox ID="txtYeuCauSanXuat" runat="server" Width="100%"></asp:TextBox>
                                </td>
                                <td>
                                    <input type="button" id="btnSearch" class="icon icon-search" style="cursor: pointer;" onclick="InitTableYeuCauSanXuat(); return false;" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="work-item-bonus">
                        <asp:Literal ID="ltButtonNewChiTietVatTuNhap" runat="server"></asp:Literal>
                    </div>
                    <asp:Panel runat="server" ID="pnLenhSanXuatChiTiet">
                        <div id="" class="div-data">
                            <table class="data-table tab-detail" id="tabDanhSachLenhSanXuat">
                                <thead>
                                    <tr>
                                        <td>STT</td>
                                        <td>Mã ĐH</td>
                                        <td>Tên mặt hàng</td>
                                        <td>Mã hàng</td>
                                        <td>Loại sóng</td>
                                        <td>KT Tâm</td>
                                        <td>Kích thước</td>
                                        <td>Loại KT</td>
                                        <td>Loại hộp</td>
                                        <td>Tổng dao</td>
                                        <td>Xả</td>
                                        <td>Khổ giấy</td>
                                        <td>Chặt dài</td>
                                        <td>Mét dài (m)</td>
                                        <td>Thời gian thực hiện</td>
                                        <td>SL tấm</td>
                                        <td>SL hộp</td>
                                        <%--  <td>SL yêu cầu</td>--%>
                                        <td>Cần SX</td>
                                        <td>Độ ưu tiên</td>
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
        <div class="paging">
            <cc1:CollectionPager ID="colPage" runat="server" PageSize="10" PagingMode="QueryString"
                QueryStringKey="trang" BackText="Trước"
                FirstText="Đầu" LastText="Cuối" NextText="Sau"
                LabelText="" PageNumbersSeparator="&amp;nbsp;&amp;nbsp;" PageNumbersStyle="color:#ea1111;font-size:12px;padding:5px;"
                PageNumberStyle="color:#555;padding:3px 8px;border:solid 1px #ccc;" ResultsLocation="Bottom"
                ResultsStyle="font-family:Arial;font-size:12px;text-align:right;margin-top:5px;"
                ShowLabel="True" BackNextButtonStyle="border:none;background:red;" BackNextDisplay="HyperLinks"
                BackNextLinkSeparator="&nbsp;&nbsp;-&nbsp;&nbsp;" ControlStyle="text-align:right;margin:5px;float:right;" BackNextLocation="Split" ResultsFormat="Hiển thị {0}-{1} (trong tổng số {2} bản ghi)" ShowFirstLast="True" ControlCssClass="paging_tool_bar" EnableViewState="False" MaxPages="10" SectionPadding="5" SliderSize="5">
            </cc1:CollectionPager>
        </div>
        <div class="clear"></div>

    </div>
    <div class="ui-dialog-buttonset">
    </div>
</div>

<div id="content_div" title="Định mức vật tư" style="display: none;">

    <div class="splitter horizontal hub-splitter stateful toggle-button-enabled toggle-button-hotkey-enabled">
        <div class="rightPane" style="left: 0px;">
            <div class="hub-title">
            </div>
            <div class="right-hub-content">
                <div class="work-item-form">

                    <div class="workitem-info-bar">
                        <table style="width: 100%; font-size: 13px;" cellspacing="5" cellpadding="5">
                            <tr>
                                <td style="width: 10%"></td>
                                <td style="width: 40%"></td>
                                <td style="width: 10%"></td>
                                <td style="width: 15%"></td>
                                <td style="width: 15%"></td>
                                <td style="width: 10%"></td>
                            </tr>
                            <tr>
                                <td colspan="2" style="line-height: 30px"><span class="info-text" style="font-size: 14px; font-weight: bold;">Định mức vật tư cho mặt hàng <span id="spMaHieuMatHang"></span></span></td>
                                <td>Số lượng yêu cầu:</td>
                                <td>
                                    <input id="txtSoLuongYeuCau" readonly="readonly" />
                                </td>
                                <td>Số lượng cần sản xuất: </td>
                                <td>
                                    <input id="txtSoLuongCanSanXuat" style="width: 100%; padding-left: 10px;" />
                                </td>
                            </tr>
                            <tr>
                                <td><span class="info-text">Loại sóng:</span> </td>
                                <td style="padding-right: 10px;" colspan="3">
                                    <input id="txtLoaiSong" style="width: 100%; padding-left: 10px;" readonly="readonly" />
                                </td>
                                <td>Số lớp: </td>
                                <td>
                                    <input id="txtSolop" style="width: 100%; padding-left: 10px;" readonly="readonly" />
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td style="padding: 10px 0px 0px 0px;">
                                    <input id="rdPhuongAnToiUu" name="phuongan" type="radio" value="TOIUU" checked="checked" class="rbo-phuongan" />
                                    Phương án tối ưu                               
                                    <input id="rdPhuongAnTronGoi" name="phuongan" type="radio" value="TONGTHE" class="rbo-phuongan" />
                                    Phương án trọn gói</td>
                            </tr>
                        </table>
                    </div>
                    <div class="work-item-form">
                        <div class="work-item-view" style="margin-left: 10px;">
                            <asp:Panel runat="server" ID="pnChiTietVatTu">
                                <div id="" class="div-data">
                                    <table class="data-table tab-detail" id="tabDinhMucVatTu">
                                        <thead>
                                            <tr>
                                                <td style="width: 5%">TT</td>
                                                <td style="width: 20%">Điểm phát sinh tiêu hao</td>
                                                <td style="width: 15%">Loại giấy </td>
                                                <td style="width: 30%">Vật tư</td>
                                                <td style="width: 120px">Hệ số tiêu hao</td>
                                                <td style="width: 120px">Đơn vị tính</td>
                                                <td>Số lượng tiêu hao</td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="div-data" style="margin-top: 15px;">
                                    <b>PHƯƠNG ÁN VẬT TƯ TỐI ƯU</b>
                                </div>
                                <div class="div-data">
                                    <table class="data-table tab-detail" id="tabDanhSachPhuongAnVatTuToiUu">
                                        <thead>
                                            <tr>
                                                <td style="width: 30px">TT</td>
                                                <td style="width: 15%">Tên loại vật tư</td>
                                                <td style="width: 110px">Khổ giấy yêu cầu</td>
                                                <td style="width: 100px">Hệ số tiêu hao</td>
                                                <td>Vật tư đáp ứng yêu cầu</td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%--<asp:Repeater ID="rptPAVT2" runat="server">
                                                <ItemTemplate>
                                                    <tr>
                                                        <td class="center-col"><%# Container.ItemIndex + 1 %></td>
                                                        <td><%#Eval("TenLoaiVatTu") %></td>
                                                        <td class="center-col"><%#Eval("KhoGiayYeuCau") %></td>
                                                        <td class="center-col"><%#Eval("TongHeSoTieuHao") %></td>
                                                        <td><%#Eval("VatTuThoaMan") %></td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>--%>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="div-data" style="margin-top: 15px;">
                                    <b>PHƯƠNG ÁN VẬT TƯ SẢN XUẤT</b>
                                </div>
                                <div class="div-data">
                                    <table class="data-table tab-detail" id="tabDanhSachPhuongAnSX">
                                        <thead>
                                            <tr>
                                                <td style="width: 30px">TT</td>
                                                <td style="width: 15%">Tên loại vật tư</td>
                                                <td style="width: 110px">Khổ giấy yêu cầu</td>
                                                <td style="width: 100px">Hệ số tiêu hao</td>
                                                <td>Vật tư đáp ứng yêu cầu</td>
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
                <input id="btnSaveDinhMucVatTu" type="button" class="xrp-button" value="Lưu" onclick="SaveDinhMucVatTu();" />
                <br />
                <br />
            </div>
        </div>
    </div>
</div>

<div id="content_yeucausanxuat" style="display: none;">
    <div class="work-item-view">
        <table class="witform-layout">
            <tbody>
                <tr>
                    <td style="width: 10%;"></td>
                    <td style="width: 40%;"></td>
                    <td style="width: 10%;"></td>
                    <td style="width: 35%;"></td>
                    <td style="width: 5%;"></td>
                </tr>
                <tr>
                    <td>Khách hàng</td>
                    <td>
                        <div class="wrap" style="display: block">
                            <asp:HiddenField ID="slcTenKhachHang" runat="server" />
                            <asp:TextBox ID="txtTenKhachHang" runat="server" Width="100%"></asp:TextBox>
                        </div>

                    </td>
                    <td>Đơn hàng</td>
                    <td>
                        <div class="wrap" style="display: block">
                            <asp:HiddenField ID="slcDonHang" runat="server" />
                            <asp:TextBox ID="txtDonHang" runat="server" Width="100%"></asp:TextBox>
                        </div>
                    </td>

                    <td>
                        <input type="button" class="icon icon-search" id="btnSearchYeuCauSanXuat" onclick="LoadYeuCauSanXuat()" style="cursor: pointer;" />
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <table class="data-table" id="tabDanhSachYeuCauSanXuat">
        <thead>
            <tr>
                <td>STT</td>
                <td style="width: 80px;">Mã ĐH</td>
                <td>Mặt hàng</td>
                <td>Mã hàng</td>
                <td style="width: 80px;">KT tâm</td>
                <td style="width: 80px;">Kích thước</td>
                <td style="width: 80px;">Số lớp</td>
                <td style="width: 80px;">Khổ giấy</td>
                <td style="width: 80px;">Tổng dao</td>
                <td style="width: 80px;">Chặt dài</td>
                <td style="width: 80px;">SL tấm</td>
                <td style="width: 80px;">SL hộp</td>
                <td style="width: 80px;">SL yêu cầu</td>
                <td style="width: 100px;"></td>
            </tr>
        </thead>
        <tbody>
        </tbody>
    </table>

</div>
