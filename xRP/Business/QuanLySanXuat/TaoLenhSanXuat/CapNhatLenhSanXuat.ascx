<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CapNhatLenhSanXuat.ascx.cs" Inherits="xRP.Business.QuanLySanXuat.TaoLenhSanXuat.CapNhatLenhSanXuat" %>
<%@ Register Assembly="CollectionPager" Namespace="SiteUtils" TagPrefix="cc1" %>

<div class="splitter horizontal hub-splitter stateful toggle-button-enabled toggle-button-hotkey-enabled">
    <div class="rightPane" style="left: 0px;">
        <div class="hub-title">
        </div>
        <div class="right-hub-content">
            <div class="work-item-form">
                <div class="workitem-info-bar">
                    <div class="info-text-wrapper">
                        <span class="info-text">Cập nhật kết quả sản xuất</span>
                    </div>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block;">
                    <ul class="menu-bar">
                        <li class="menu-item icon-only" id="btn-luu">
                            <%--<asp:Button ToolTip="Lưu" CssClass="menu-bar-item-button icon icon-save" runat="server" ID="btnSave" />--%>
                            <input type="button" title="Lưu" class="menu-bar-item-button icon icon-save" id="btnSave" onclick="onSaveData()" />
                        </li>

                        <li class="menu-item icon-only" id="btn-LuuEnd">
                            <%--<asp:Button ToolTip="Lưu" CssClass="menu-bar-item-button icon icon-save" runat="server" ID="btnSave" />--%>
                            <input type="button" title="Lưu và kết thúc" class="menu-bar-item-button icon icon-save-done" id="btnSaveEnd" onclick="onSaveEndData()" />
                        </li>


                        <%--<li class="menu-item icon-only" id="btn-luu-print">
                            <input title="Lưu và In" class="menu-bar-item-button icon icon-save-printer" id="btnSavePrint" onclick="onSaveData(true);" />
                        </li>--%>
                        <li class="menu-item icon-only" id="btn-print">
                            <input title="In" class="menu-bar-item-button icon icon-printer" id="btnPrint" onclick="onPrint()" /></li>
                        <%--   <li class="menu-item icon-only" id="btn-Import">
                            <input title="In" class="menu-bar-item-button icon icon-import" id="btnImport" onclick="onImport()" /></li>--%>

                        <li class="menu-item icon-only" id="btn-cancel">
                            <asp:Button ToolTip="Hủy" CssClass="menu-bar-item-button icon cancel-icon" runat="server" OnClick="btnCancel_Click" ID="btnCancel" /></li>
                    </ul>
                </div>
                <div class="work-item-view" style="margin-left: 10px;">

                    <table class="witform-layout">
                        <tbody>
                            <tr>
                                <td style="width: 15%;"></td>
                                <td style="width: 35%;"></td>
                                <td style="width: 15%;"></td>
                                <td style="width: 35%;"></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td>Ngày cập nhật sản xuất</td>
                                <td>
                                    <asp:TextBox ID="txtNgayTao" runat="server"></asp:TextBox></td>
                            </tr>
                        </tbody>
                    </table>

                    <div class="work-item-view" style="display: block;">
                        <table class="data-table tab-detail" id="tbLenhSanXuatChiTiet">
                            <thead>
                                <tr>
                                    <td>STT</td>
                                    <td>Mã ĐH</td>
                                    <td>Mã hàng</td>
                                    <td>Tên mặt hàng</td>
                                    <td>Loại sóng</td>
                                    <td>KT Tâm</td>
                                    <td>Kích thước</td>
                                    <td>Mã hiệu KT</td>
                                    <td>Loại hộp</td>
                                    <td>Tổng dao</td>
                                    <td>Xả</td>
                                    <td>Khổ giấy</td>
                                    <td>Chặt dài</td>
                                    <td>SL tấm</td>
                                    <td>SL hộp</td>
                                    <td>Thứ tự ưu tiên</td>
                                    <td>Cần SX</td>
                                    <td>SL đã sx</td>
                                    <td>SL hỏng</td>
                                    <td style="width: 50px"></td>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptYeuCauSanXuat" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td class="center-col" style="width: 15px; display: none">
                                                <input id='ck-select-<%# Eval("IDYeuCauSanXuat") %>' checked="checked" class="yeucau-select" type="checkbox" onclick="onChecked(this)" lenhsanxuat-chitiet="<%# Eval("ID") %>" lenhsanxuat-id="<%# Eval("IDLenhSanXuat") %>" yeucau-sanxuat-id="<%# Eval("IDYeuCauSanXuat") %>" tt="txt-TT-<%# Eval("IDYeuCauSanXuat") %>" soluong-yeucau="<%# Eval("SoLuongYeuCau") %>" soluong-dasanxuat='txt-SoLuong-DaSanXuat-<%# Eval("IDYeuCauSanXuat") %>' soluongloi='txt-SoLuongLoi-<%# Eval("IDYeuCauSanXuat") %>' />
                                            </td>
                                            <td class="center-col" style="width: 15px">
                                                <span class="sothutu stt-<%# Eval("ID") %>"><%# (CollectionPager1.CurrentPage - 1) * CollectionPager1.PageSize + Container.ItemIndex + 1 %></span>
                                            </td>
                                            <td class="center-col"><%# Eval("MaHieuDonHang") %></td>
                                            <td><%# Eval("MaHieuMatHang") %></td>
                                            <td><%# Eval("TenMatHang") %></td>
                                            <td class="center-col"><%# Eval("KiHieuCoCauGiay") %></td>
                                            <td class="center-col"><%# Eval("KTTam") %></td>
                                            <td class="center-col"><%# Eval("KichThuoc") %></td>
                                            <td class="center-col"><%# Eval("MaHieuKichThuoc") %></td>
                                            <td class="center-col"><%# Eval("TenLoaiSanPham") %></td>
                                            <td class="center-col"><%# Eval("TongDao") %></td>
                                            <td class="center-col"><%# Eval("Xa") %></td>
                                            <td class="center-col"><%# Eval("KhoGiay") %></td>
                                            <td class="center-col"><%# Eval("ChatDai") %></td>
                                            <td class="center-col"><%# Eval("SoLuongTam") %></td>
                                            <td class="center-col"><%# Eval("SoLuongHop") %></td>
                                            <td class="center-col"><%# Eval("TT") %>
                                                <%-- <input value="<%# Eval("TT") %>" id='txt-TT-<%# Eval("IDYeuCauSanXuat") %>' style="width: 50px" readonly="true" class="number" />--%>
                                            </td>
                                            <td class="center-col"><%# Eval("SoLuongYeuCau") %></td>
                                            <td class="center-col">
                                                <input value="<%# Eval("SoLuongDatDuoc") %>" parse-data="<%# Eval("SoLuongYeuCau") %>" soluongloi='txt-SoLuongLoi-<%# Eval("IDYeuCauSanXuat") %>' id='txt-SoLuong-DaSanXuat-<%# Eval("IDYeuCauSanXuat") %>' class="number parse-data" style="width: 60px" />
                                            </td>
                                            <td class="center-col">
                                                <input value="<%# Eval("SoLuongLoi") %>" id='txt-SoLuongLoi-<%# Eval("IDYeuCauSanXuat") %>' class="number parse-data" style="width: 60px" />
                                            </td>
                                            <td class="center-col"><a title="Go up" class="icon-up cns-icon"></a><a class="icon-down cns-icon" title="Go down"></a></td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </div>
                    <div class="work-item-view-pager">
                        <cc1:CollectionPager ID="CollectionPager1" runat="server" PageSize="10" PagingMode="QueryString"
                            QueryStringKey="trang" BackText="Trước"
                            FirstText="Đầu" LastText="Cuối" NextText="Sau"
                            LabelText="" PageNumbersSeparator="&amp;nbsp;&amp;nbsp;" PageNumbersStyle="color:#007acc;font-size:12px;padding:5px;"
                            PageNumberStyle="color: #555;padding: 3px 8px;text-decoration: underline;" ResultsLocation="Bottom"
                            ResultsStyle="font-family:Arial;font-size:12px;text-align:right;margin-top:5px;"
                            ShowLabel="True" BackNextButtonStyle="border:none;background:red;" BackNextDisplay="HyperLinks"
                            BackNextLinkSeparator="&nbsp;&nbsp;-&nbsp;&nbsp;" ControlStyle="text-align:right;margin:5px;float:right;" BackNextLocation="Split" ResultsFormat="Hiển thị {0}-{1} (trong tổng số {2} bản ghi)" ShowFirstLast="True" ControlCssClass="paging_tool_bar" EnableViewState="False" MaxPages="10" SectionPadding="5" SliderSize="10">
                        </cc1:CollectionPager>
                    </div>
                </div>
            </div>
        </div>

        <div class="clear"></div>
        <div>
            &nbsp;
        </div>
    </div>
</div>
<script type="text/javascript">

    var lenhSanXuatId = '<%=lenhSanXuatId%>';
    var dataLenhSanXuatChiTiet = [];

    $(function () {

        dataLenhSanXuatChiTiet = new LenhSanXuat({ ID: parseInt("<%=lenhSanXuatId%>") }).getDanhSachLenhSanXuatChiTiet();

        InitLenhSanXuatChiTiet();


        $('#<%=txtNgayTao.ClientID%>').datetimepicker({
            mask: '99/99/9999', timepicker: false,
            format: 'd/m/Y'
        });

        $('.number').focusout(function () {
            if (!$.isNumeric($(this).val())) {
                alert("Sai kiểu dữ liệu: Kiểu dữ liệu phải là số tự nhiên.");
                $(this).focus();
            }
        });

        $('.parse-data').focusout(function () {
            var data = parseInt($(this).val());
            var parse = parseInt($(this).attr('parse-data'));
            if (data > parse) {
                data = parse;
                $(this).val(parse);
            }
            $('#' + $(this).attr('soluongloi')).val(parse - data);
            //txt - SoLuongLoi
        });

    });

    function InitLenhSanXuatChiTiet() {

        $("#tbLenhSanXuatChiTiet tbody").text("");
        if (dataLenhSanXuatChiTiet.length > 0) {

            $.each(dataLenhSanXuatChiTiet, function (index, value) {
                // console.log(value.data.ChatDai);
                var item = value.data;
                var data = "<tr><td class='center-col'>" + (index + 1) + "</td>";
                data += '<td class="center-col" style="width: 15px; display: none"><input id="ck-select-' + item.IDYeuCauSanXuat + '" checked="checked" class="yeucau-select" type="checkbox" /></td>';
                data += '<td class="center-col" >' + item.MaHieuDonHang + "</td>";
                data += '<td class="center-col" >' + item.MaHieuMatHang + "</td>";
                data += '<td class="center-col" >' + item.TenMatHang + "</td>";
                data += '<td class="center-col" >' + item.KiHieuCoCauGiay + "</td>";
                data += '<td class="center-col" >' + item.KTTam + "</td>";
                data += '<td class="center-col" >' + item.KichThuoc + "</td>";
                data += '<td class="center-col" >' + item.MaHieuKichThuoc + "</td>";
                data += '<td class="center-col" >' + item.TenLoaiSanPham + "</td>";
                data += '<td class="center-col" >' + item.TongDao + "</td>";

                data += '<td class="center-col" >' + item.Xa + "</td>";
                data += '<td class="center-col" >' + item.KhoGiay + "</td>";
                data += '<td class="center-col" >' + item.ChatDai + "</td>";
                data += '<td class="center-col" >' + item.SoLuongTam + "</td>";
                data += '<td class="center-col" >' + item.SoLuongHop + "</td>";
                data += '<td class="center-col" >' + item.TT + "</td>";
                data += '<td class="center-col" >' + item.SoLuongYeuCau + "</td>";
                data += '<td class="center-col" >  <input value="' + item.SoLuongDatDuoc + '"  id="txt-SoLuong-DaSanXuat-' + item.IDYeuCauSanXuat + '" class="number parse-data soluongdasanxuat" style="width: 60px" index="' + index + '" /></td>';
                data += '<td class="center-col" >  <input value="' + item.SoLuongLoi + '" id="txt-SoLuongLoi-' + item.IDYeuCauSanXuat + '"  class="number parse-data soluongloi" style="width: 60px" index="' + index + '" /></td>';
                data += '<td class="center-col" ><input id="ck-select-' + item.IDYeuCauSanXuat + "</td>";
                data += "</td></tr>";
                $("#tbLenhSanXuatChiTiet tbody").append(data);
            });
        }

        $('.soluongdasanxuat').change(function () {
            var index = $(this).attr('index');
            dataLenhSanXuatChiTiet[index].data.SoLuongDatDuoc = parseInt($(this).val());
        });
        $('.soluongloi').change(function () {
            var index = $(this).attr('index');
            dataLenhSanXuatChiTiet[index].data.SoLuongLoi = parseInt($(this).val());
        });

    }


    function onSaveData(print) {

        var ngayTao = $("#<%=txtNgayTao.ClientID%>").val();
        try {
            var date = $.datepicker.parseDate('dd/mm/yy', ngayTao);
        }
        catch (err) {
            alert("Bạn chưa nhập Ngày tạo.");
            $("#<%=txtNgayTao.ClientID%>").focus();
            return;
        }

        var lsYeuCauSanXuatData = new Array();

        //$('#tbLenhSanXuatChiTiet .yeucau-select').each(function () {
        //    if (this.checked) {
        //        var obj = new Object();
        //        obj.ID = $(this).attr('lenhsanxuat-chitiet');
        //        obj.IDYeuCauSanXuat = $(this).attr('yeucau-sanxuat-id');
        //        obj.IDLenhSanXuat = $(this).attr('lenhsanxuat-id');
        //        obj.TT = $('#' + $(this).attr('tt')).val();
        //        obj.SoLuongYeuCau = $(this).attr('soluong-yeucau');
        //        obj.SoLuongDatDuoc = $('#' + $(this).attr('soluong-dasanxuat')).val();
        //        obj.ThuTuUuTien = $('.stt-' + obj.ID).html();
        //        obj.SoLuongLoi = $('#' + $(this).attr('soluongloi')).val();
        //        lsYeuCauSanXuatData.push(obj);
        //    }
        //});
        // console.log(JSON.stringify(lsYeuCauSanXuatData).toString());

        $.each(dataLenhSanXuatChiTiet, function (index, value) {
            var obj = new Object();
            var item = value.data;
            obj.ID = item.ID;
            obj.IDYeuCauSanXuat = item.IDYeuCauSanXuat;
            obj.IDLenhSanXuat = item.IDLenhSanXuat;
            obj.TT = item.TT;
            obj.SoLuongYeuCau = item.SoLuongYeuCau;
            obj.SoLuongDatDuoc = item.SoLuongDatDuoc;
            obj.ThuTuUuTien = item.TT;
            obj.SoLuongLoi = item.SoLuongLoi;
            lsYeuCauSanXuatData.push(obj);
        });
        //return; 

        if (lsYeuCauSanXuatData.length < 1) {
            alert("Bạn hãy chọn mặt hàng cần sản xuất.");
        }


        var lsYeuCau = {
            lsYeuCauSanXuat: JSON.stringify(lsYeuCauSanXuatData).toString(),
            ngayTao: ngayTao,
            nguonLucId: ""
        };

        console.log(lsYeuCau);
        

        $.ajax({
            type: "POST",
            url: "Default.aspx/UpdateLenhSanXuat",
            data: JSON.stringify(lsYeuCau),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Request: " + XMLHttpRequest + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                // if (onComplete)
                //  onComplete({ d: "Có lỗi trong quá trình xử lý: " + errorThrown });
            },
            success: function (result) {
                //console.log(result);
                //onComplete(result);

                if (print) {
                    alert("Lưu thành công.");
                    var id = parseInt('<%=lenhSanXuatId%>');
                    window.location = '/Business/QuanLySanXuat/Default.aspx?page=plsx&lenhSanXuatId=' + id;
                } else
                    if (result.d == 1)
                        window.location = '/Business/QuanLySanXuat/Default.aspx?page=lsx&cd=<%=congDoanId%>';
            }
        });


    }
    function onSaveEndData() {

        var ngayTao = $("#<%=txtNgayTao.ClientID%>").val();
        try {
            var date = $.datepicker.parseDate('dd/mm/yy', ngayTao);
        }
        catch (err) {
            alert("Bạn chưa nhập Ngày tạo.");
            $("#<%=txtNgayTao.ClientID%>").focus();
            return;
        }

        var lsYeuCauSanXuatData = new Array();
        $.each(dataLenhSanXuatChiTiet, function (index, value) {
            var obj = new Object();
            var item = value.data;
            obj.ID = item.ID;
            obj.IDYeuCauSanXuat = item.IDYeuCauSanXuat;
            obj.IDLenhSanXuat = item.IDLenhSanXuat;
            obj.TT = item.TT;
            obj.SoLuongYeuCau = item.SoLuongYeuCau;
            obj.SoLuongDatDuoc = item.SoLuongDatDuoc;
            obj.ThuTuUuTien = item.TT;
            obj.SoLuongLoi = item.SoLuongLoi;
            lsYeuCauSanXuatData.push(obj);
        });

        //$('#tbLenhSanXuatChiTiet .yeucau-select').each(function () {
        //    if (this.checked) {
        //        var obj = new Object();
        //        obj.ID = $(this).attr('lenhsanxuat-chitiet');
        //        obj.IDYeuCauSanXuat = $(this).attr('yeucau-sanxuat-id');
        //        obj.IDLenhSanXuat = $(this).attr('lenhsanxuat-id');
        //        obj.TT = $('#' + $(this).attr('tt')).val();
        //        obj.SoLuongYeuCau = $(this).attr('soluong-yeucau');
        //        obj.SoLuongDatDuoc = $('#' + $(this).attr('soluong-dasanxuat')).val();
        //        obj.ThuTuUuTien = $('.stt-' + obj.ID).html();
        //        //console.log(obj.SoLuongDatDuoc);
        //        obj.SoLuongLoi = $('#' + $(this).attr('soluongloi')).val();
        //        lsYeuCauSanXuatData.push(obj);
        //    }
        //});
        // console.log(JSON.stringify(lsYeuCauSanXuatData).toString());



        if (lsYeuCauSanXuatData.length < 1) {
            alert("Bạn hãy chọn mặt hàng cần sản xuất.");
        }


        var lsYeuCau = {
            lsYeuCauSanXuat: JSON.stringify(lsYeuCauSanXuatData).toString(),
            ngayTao: ngayTao,
            nguonLucId: "",
            lenhSanXuatId: id = parseInt('<%=lenhSanXuatId%>'),
        };

        $.ajax({
            type: "POST",
            url: "Default.aspx/UpdateEndLenhSanXuat",
            data: JSON.stringify(lsYeuCau),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Request: " + XMLHttpRequest + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                // if (onComplete)
                //  onComplete({ d: "Có lỗi trong quá trình xử lý: " + errorThrown });
            },
            success: function (result) {
                //console.log(result);
                //onComplete(result); 

                if (result.d == 1) {
                    window.location = '/Business/QuanLySanXuat/Default.aspx?page=lsx&cd=<%=congDoanId%>';
                }
                else {
                    if (confirm("Bạn có muốn chuyển phần chưa hoàn thành sang ngày hôm sau không?")) {
                        $.ajax({
                            type: "POST",
                            url: "Default.aspx/CopyLenhSanXuat",
                            data: "{id:\"" + "<%=lenhSanXuatId%>" + "\"}",
                            contentType: 'application/json; charset=utf-8',
                            dataType: 'json',
                            error: function (XMLHttpRequest, textStatus, errorThrown) {
                                console.log("Request: " + XMLHttpRequest + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                            },
                            success: function (result) {
                                window.location = '/Business/QuanLySanXuat/Default.aspx?page=lsx&cd=<%=congDoanId%>';
                            }
                        });
                            return;
                        }
                        else {
                            window.location = '/Business/QuanLySanXuat/Default.aspx?page=lsx&cd=<%=congDoanId%>';
                    }
                }
            }
        });


    }


    function onPrint() {
        var id = parseInt('<%=lenhSanXuatId%>');
        window.location = '/Business/QuanLySanXuat/Default.aspx?page=plsx&lenhSanXuatId=' + id;
    }
    function onImport() {
        $.ajax({
            type: "POST",
            url: "Default.aspx/AddOrUpdateNhapKhoTuDong",
            data: "{'id':" + 69 + "}",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Request: " + XMLHttpRequest + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (result) {
                alert('Cập nhật thành công');
                window.reload();
            }
        });
    }
    function onChecked(ctr) {
        var tt = $(ctr).attr('tt');
        var soluongdasanxuat = $(ctr).attr('soluong-dasanxuat');
        //console.log(tt + '_' + soluong-dasanxuat); 
        if (ctr.checked) {
            $('#' + tt).removeAttr('readonly');
            $('#' + soluongdasanxuat).removeAttr('readonly');
        } else {
            $('#' + tt).attr('readonly', 'true');
            $('#' + soluongdasanxuat).attr('readonly', 'true');
        }
    }


</script>

