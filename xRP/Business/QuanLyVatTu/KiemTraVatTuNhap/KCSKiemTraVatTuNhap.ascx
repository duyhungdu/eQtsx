<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="KCSKiemTraVatTuNhap.ascx.cs" Inherits="xRP.Business.QuanLyVatTu.KiemTraVatTuNhap.KCSKiemTraVatTuNhap" %>
<%@ Register Assembly="CollectionPager" Namespace="SiteUtils" TagPrefix="cc1" %>

<script type="text/javascript">
    var dataChiTiet = [];
    var dataPhieuNhap = {};
    $(function () {
        dataPhieuNhap = JSON.parse('<%=DataPhieuNhap%>');
        
        new PhieuNhap({ ID: parseInt("<%=ID_PhieuNhap%>") }).getChiTietPhieuNhap(function (result) {
            for (var i = 0; i < result.length; i++) {
                dataChiTiet.push(new VatTuNhap(result[i]));
            }
            bindDataChiTietKCS(dataChiTiet);
            $("[item-id]").on("change", function (evt) {
                var rand_id = $(this).attr("item-id");
                var fieldName = $(this).attr("item-property");
                var val = $(this).val();
                for (var i = 0; i < dataChiTiet.length; i++) {
                    if (dataChiTiet[i].GUID == rand_id) {
                        switch (fieldName) {
                            case "DinhLuongKiemTra":
                                if (!dataChiTiet[i].DinhLuongKiemTra.setValue(val)) {
                                    $(this).val("0");
                                    $(this).focus();
                                    evt.preventDefault();
                                }
                                break;
                            case "KichThuocKiemTra":
                                if (!dataChiTiet[i].KichThuocKiemTra.setValue(val)) {
                                    $(this).val("0");
                                    $(this).focus();
                                    evt.preventDefault();
                                }
                                break;
                            case "DoMucKiemTra":
                                if (!dataChiTiet[i].DoMucKiemTra.setValue(val)) {
                                    $(this).val("0");
                                    $(this).focus();
                                    evt.preventDefault();
                                }
                                break;
                            case "DoAmKiemTra":
                                if (!dataChiTiet[i].DoAmKiemTra.setValue(val)) {
                                    $(this).val("0");
                                    $(this).focus();
                                    evt.preventDefault();
                                }
                                break;
                            case "CamQuanKiemTra":
                                dataChiTiet[i].CamQuanKiemTra.setValue(val);
                                break;
                            case "TinhTrang":
                                dataChiTiet[i].TinhTrang.setValue(val);
                                break;
                        }
                    }
                }
            });

        });

        $('#<%=txtNgayNhap.ClientID%>').datetimepicker({
            mask: '99/99/9999', timepicker: false,
            format: 'd/m/Y',
            formatDate: 'd/m/Y',
            minDate: '-1970/01/02',
            maxDate: '+1970/01/02'
        });
        $('.date').mask('00/00/0000');

        $("#<%=txtMaPhieu.ClientID%>").focus();
    });
   
    function savePhieuNhap() {
        try {
            var idPhieu = "<%=ID_PhieuNhap%>";
            if (!$.isNumeric(idPhieu)) idPhieu = 0;

            dataPhieuNhap.TinhTrang = 1;
            dataPhieuNhap.GhiChu=$("#<%=txtGhiChu.ClientID%>").val();

            var phieuNhap = new PhieuNhap(dataPhieuNhap);
            phieuNhap.save(function (result) {
                var newid = result.d;
                if ($.isNumeric(newid)) {
                    var c = 0;
                    var allResult = "";
                    var msg = "";
                    $("input[type=submit]").prop("disabled", true);
                    $.each(dataChiTiet, function (idx, vattunhap) {
                        vattunhap.MaPhieuNhap.setValue(newid);
                        if (vattunhap.TinhTrang.Value != 0) {
                            if (vattunhap.KichThuocKiemTra.Value <= 0) {
                                msg += "Vật tư: " + vattunhap.MaHieuVatTu.Value + "Chưa nhập kích thước kiểm tra\n";
                            }
                            if (vattunhap.DinhLuongKiemTra.Value <= 0) {
                                msg += "Vật tư: " + vattunhap.MaHieuVatTu.Value + "Chưa nhập định lượng kiểm tra\n";
                            }
                        }
                        vattunhap.save(function (result) {
                            c++;
                            if (result.d && result.d != "SUCCESS") {
                                allResult += "\n" + result.d;
                            }
                            if (c == dataChiTiet.length && allResult != "") {
                                alert("Có lỗi trong quá trình xử lý: " + allResult);
                                $("input[type=submit]").prop("disabled", false);
                            }
                            if (c == dataChiTiet.length) {
                                if (msg == "")
                                    window.location.href = "<%=Util.SERVER_NAME %>/Business/QuanLyVatTu/Default.aspx?page=pktn";
                                else {
                                    alert(msg);
                                    $("input[type=submit]").prop("disabled", false);
                                }
                            }
                        });
                    });
                    //alert("Đã lưu thông tin!");
                } else {
                    alert("Có lỗi khi lưu dữ liệu\n" + result.d);
                }
            })
        } catch (e) { }
        return false;
    }


    function saveVatTuNhapKCS(randID) {
        for (var i = 0; i < dataChiTiet.length; i++) {
            if (dataChiTiet[i].data.RandomID == randID) {
                dataChiTiet[i].data.maPhieuNhap = "<%= ID_PhieuNhap%>";
                //bindDataChiTietKCS(dataChiTiet);
                dataChiTiet[i].save(function (result) {
                    if (result.d && result.d != "SUCCESS") {
                        allResult += "\n" + result.d;
                    } else alert("Đã lưu thông tin!");
                });
            }
        }
    }

    function setVatTuNhapKCS(obj, randID, status) {
        for (var i = 0; i < dataChiTiet.length; i++) {
            if (dataChiTiet[i].GUID == randID) {
                dataChiTiet[i].TinhTrang = status;
                bindDataChiTietKCS(dataChiTiet);
            }
        }
    }

    function bindDataChiTietKCS(dataChiTiet) {
        $("#tabDanhSachPhieuNhapVatTuKCS tbody").text("");
        for (var i = 0; i < dataChiTiet.length; i++) {
            $("#tabDanhSachPhieuNhapVatTuKCS tbody").append("<tr><td class='center-col'>" + (i + 1) + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].MaHieuVatTu.Value + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].TenVatTu.Value + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].KichThuocTieuChuan.Value + "</td>" +
                "<td class='center-col'>" + dataChiTiet[i].DinhLuongTieuChuan.Value + "</td>" +
                "<td class='center-col'><input type='text' item-id='" + dataChiTiet[i].GUID + "' item-property='KichThuocKiemTra' value='" + dataChiTiet[i].KichThuocKiemTra.Value + "' style='width:30px'></td>" +
                "<td class='center-col'><input type='text' item-id='" + dataChiTiet[i].GUID + "' item-property='DinhLuongKiemTra' value='" + dataChiTiet[i].DinhLuongKiemTra.Value + "' style='width:30px'></td>" +
                "<td class='center-col'><input type='text' item-id='" + dataChiTiet[i].GUID + "' item-property='DoMucKiemTra' value='" + dataChiTiet[i].DoMucKiemTra.Value + "' style='width:30px'></td>" +
                "<td class='center-col'><input type='text' item-id='" + dataChiTiet[i].GUID + "' item-property='DoAmKiemTra' value='" + dataChiTiet[i].DoAmKiemTra.Value + "' style='width:30px'></td>" +
                "<td class='center-col'><input type='text' item-id='" + dataChiTiet[i].GUID + "' item-property='CamQuanKiemTra' value='" + dataChiTiet[i].CamQuanKiemTra.Value + "' style='width:220px'></td>" +
                "<td class='center-col'><select item-id='" + dataChiTiet[i].GUID + "' item-property='TinhTrang'>" +
                "<option value=0" + (dataChiTiet[i].TinhTrang.Value == 0 ? " selected='selected'" : "") + ">Không kiểm tra</option>" +
                "<option value='1'" + (dataChiTiet[i].TinhTrang.Value == 1 ? " selected='selected'" : "") + ">Đạt</option>" +
                "<option value='-1'" + (dataChiTiet[i].TinhTrang.Value == -1 ? " selected='selected'" : "") + ">Không đạt</option></select></td>" +
                "</tr>");
        }
        if (dataChiTiet.length > 0)
            $("[item-id='" + dataChiTiet[0].GUID + "']:first").focus()
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
                        <span class="info-text">
                            <asp:Literal ID="ltTitle" runat="server"></asp:Literal></span>
                    </div>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block;">
                    <ul class="menu-bar">
                        <li class="menu-item icon-only" id="btn-luu">

                            <asp:Button CssClass="menu-bar-item-button icon icon-save" ID="btnSave" runat="server" OnClientClick="savePhieuNhap(); return false;" /></li>
                        <li class="menu-item icon-only" id="btn-cancel">
                            <asp:Button CssClass="menu-bar-item-button icon cancel-icon" runat="server" ID="btnCancel" OnClick="btnCancel_Click" /></li>
                        <li class="menu-item icon-only" id="Li1">
                            <asp:Button CssClass="menu-bar-item-button icon icon-printer" runat="server" ID="btnPrint" /></li>
                    </ul>
                </div>
                <div class="work-item-view" style="margin-left: 10px;">

                    <table class="witform-layout">
                        <tbody>
                            <tr>
                                <td style="width: 10%;"></td>
                                <td style="width: 40%;"></td>
                                <td style="width: 10%;"></td>
                                <td style="width: 40%;"></td>
                            </tr>
                            <tr>
                                <td>Mã phiếu
                                </td>
                                <td>
                                    <div class="workitemcontrol">
                                        <div class="combo tree drop short-control-30">
                                            <div class="wrap">
                                                <input type="text" class="disable-textbox" id="txtMaPhieu" autocomplete="off" maxlength="255" title="CNS" runat="server" readonly="true" />
                                            </div>

                                        </div>
                                    </div>
                                </td>
                                <td>Ngày nhập
                                </td>
                                <td>
                                    <div class="workitemcontrol">
                                        <div class="combo tree drop short-control-50">
                                            <div class="wrap">
                                                <input type="text" id="txtNgayNhap" autocomplete="off" maxlength="255" title="CNS" runat="server" readonly="true" />
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>Đơn vị cung cấp</td>
                                <td colspan="3">
                                    <div class="workitemcontrol">
                                        <div class="combo tree drop">
                                            <div class="wrap">
                                                <input type="text" id="txtTenNhaCungCap" autocomplete="off" maxlength="255" title="CNS" runat="server" readonly="true" />
                                            </div>
                                        </div>
                                    </div>
                                </td>

                            </tr>
                            <tr>
                                <td>Tính chất nhập xuất</td>
                                <td>
                                    <div class="workitemcontrol">
                                        <div class="combo tree drop short-control-50">
                                            <div class="wrap">
                                                <input type="text" id="txtTinhChat" autocomplete="off" maxlength="255" readonly="true" runat="server" />
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td>Kho chứa</td>
                                <td>
                                    <div class="workitemcontrol">
                                        <div class="combo tree drop short-control-50">
                                            <div class="wrap">
                                                <input type="text" id="txtKhoChua" autocomplete="off" maxlength="255" title="CNS" runat="server" readonly="true" />
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>Ghi chú
                                </td>
                                <td colspan="3">
                                    <asp:TextBox TextMode="MultiLine" ID="txtGhiChu" runat="server" CssClass="text-area"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4"></td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="work-item-bonus">
                        <asp:Literal ID="ltButtonNewChiTietVatTuNhap" runat="server"></asp:Literal>
                    </div>
                    <asp:Panel runat="server" ID="pnChiTietVatTu">
                        <div id="" class="div-data">
                            <table class="data-table tab-detail" id="tabDanhSachPhieuNhapVatTuKCS">
                                <thead>
                                    <tr>
                                        <td>STT</td>
                                        <td>Mã VT</td>
                                        <td>Tên VT</td>
                                        <td>KT tiêu chuẩn</td>
                                        <td>ĐL tiêu chuẩn</td>
                                        <td>KT kiểm tra</td>
                                        <td>ĐL kiểm tra</td>
                                        <td>Độ bục kiểm tra</td>
                                        <td>Độ ẩm kiểm tra</td>
                                        <td>Cảm quan</td>
                                        <td>Trạng thái</td>
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
</div>
