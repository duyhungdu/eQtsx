<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DetailLenhSanXuat.ascx.cs" Inherits="xRP.Business.QuanLySanXuat.TaoLenhSanXuat.DetailLenhSanXuat" %>
<%@ Register Assembly="CollectionPager" Namespace="SiteUtils" TagPrefix="cc1" %>

<script type="text/javascript">
    var dataLenhSanXuatChiTiet = [];
    var dataVatTu = [];

    $(function () {
        ///Init All Data
        if ("<%=IDLenhSanXuat%>" != "") {
            //Init list data LenhSanXuatChiTiet.
            dataLenhSanXuatChiTiet = new LenhSanXuat({ ID: parseInt("<%=IDLenhSanXuat%>") }).getDanhSachLenhSanXuatChiTietForDetail();
            for (var i = 0; i < dataLenhSanXuatChiTiet.length; i++) {
                //Init list data DinhMucVatTu  
                dataLenhSanXuatChiTiet[i].data.dataDinhMucVatTu = dataLenhSanXuatChiTiet[i].getDanhSachDinhMucVatTu();

                console.log(dataLenhSanXuatChiTiet[i].data.dataDinhMucVatTu);


                if (dataLenhSanXuatChiTiet[i].data.ID > 0) {
                    //Add khi sửa.
                    dataLenhSanXuatChiTiet[i].data.SoLuongYeuCauSanXuatKeHoachConLai += dataLenhSanXuatChiTiet[i].data.SoLuongYeuCau;
                    dataLenhSanXuatChiTiet[i].data.IsSave = 1;
                }
            }
            //console.log(dataLenhSanXuatChiTiet);
            InitTableLenhSanXuatChiTiet(dataLenhSanXuatChiTiet);
        }

    });


    function InitTableLenhSanXuatChiTiet(dataLenhSanXuatChiTiet) {
        console.log(dataLenhSanXuatChiTiet);
        $("#tabDanhSachLenhSanXuat tbody").text("");
        for (var i = 0; i < dataLenhSanXuatChiTiet.length; i++) {
            //console.log(dataLenhSanXuatChiTiet[i]);
            var data = "<tr>";
            data += "<td class='center-col sothutu' >" + (i + 1) + "</td>";
            data += "<td class='center-col'>" + dataLenhSanXuatChiTiet[i].data.MaHieuDonHang + "</td>";
            data += "<td  >" + dataLenhSanXuatChiTiet[i].data.TenMatHang + "</td>";
            data += "<td class='center-col'>" + dataLenhSanXuatChiTiet[i].data.MaHieuMatHang + "</td>";
            data += "<td class='center-col'>" + dataLenhSanXuatChiTiet[i].data.KiHieuCoCauGiay + "</td>";
            data += "<td class='center-col'>" + dataLenhSanXuatChiTiet[i].data.KTTam + "</td>";
            data += "<td class='center-col'>" + dataLenhSanXuatChiTiet[i].data.KichThuoc + "</td>";
            data += "<td class='center-col'>" + dataLenhSanXuatChiTiet[i].data.MaHieuKichThuoc + "</td>";
            data += "<td class='center-col'>" + dataLenhSanXuatChiTiet[i].data.TenLoaiSanPham + "</td>";
            data += "<td class='center-col'>" + dataLenhSanXuatChiTiet[i].data.TongDao + "</td>";
            data += "<td class='center-col'>" + dataLenhSanXuatChiTiet[i].data.Xa + "</td>";
            data += "<td class='center-col'>" + dataLenhSanXuatChiTiet[i].data.KhoGiay + "</td>";
            data += "<td class='center-col'>" + dataLenhSanXuatChiTiet[i].data.ChatDai + "</td>";
            data += "<td class='center-col'>" + dataLenhSanXuatChiTiet[i].data.SoLuongTam + "</td>";
            data += "<td class='center-col'>" + dataLenhSanXuatChiTiet[i].data.SoLuongHop + "</td>";
            //SoLuongYeuCauSanXuatKeHoach: 0,
            //SoLuongYeuCauSanXuatKeHoachConLai: 0,
            data += "<td class='center-col'>" + dataLenhSanXuatChiTiet[i].data.SoLuongYeuCauSanXuatKeHoachConLai + "</td>";
            data += "<td class='center-col'>" + dataLenhSanXuatChiTiet[i].data.SoLuongYeuCau + "</td>";
            data += "<td class='center-col'>" + dataLenhSanXuatChiTiet[i].data.SoLuongDatDuoc + "</td>";
            data += "<td class='center-col'>" + dataLenhSanXuatChiTiet[i].data.SoLuongConLai + "</td>";
            data += "<td class='center-col'>" + dataLenhSanXuatChiTiet[i].data.SoLuongLoi + "</td>";
            //data += "<td class='center-col'><input value='" + dataLenhSanXuatChiTiet[i].data.TT + "'   index='" + i + "'   id='txt-TT-" + dataLenhSanXuatChiTiet[i].data.IDYeuCauSanXuat + "'  style='width: 50px' readonly='true' class='number thutu-uutien' /></td>";
            // data += "<td class='center-col'><a title='Go up' class='icon-up-cs cns-icon'></a><a class='icon-down-cs cns-icon' title='Go down'></a>";
            //data += "<td><a id='update-icon' title='Dịnh mức vật tư' href='javascript:OpenTinhDinhMucVatTu(" + i + ");'><b> ... </b> </a></td> ";
            data += "</tr>";
            $("#tabDanhSachLenhSanXuat tbody").append(data);
        }
    }

    //Init Table
    function InitTableDinhMucVatTu(dinhMucVatTuData, index) {

        $("#tabDinhMucVatTu tbody").text("");

        //test
        if (dinhMucVatTuData.length < 0) {
            for (var i = 0; i < dinhMucVatTuData.length; i++) {
                //console.log(dinhMucVatTuData[i]);
                var dataStr = dinhMucVatTuData[i].data.MaHieuVatTu;
                if (dataStr.length > 0) dataStr += ' - ';
                var data = "<tr><td class='center-col'>" + (i + 1) + "</td>";
                data += "<td class=''>" + dinhMucVatTuData[i].data.TenLop + "</td>";
                data += "<td class='center-col'> <input type='text' value='" + dataStr + dinhMucVatTuData[i].data.TenVatTu + "'  class='clsTenVatTu' index='" + i + "' dinhmucvattu='" + dinhMucVatTuData[i].data.IDPhatSinhTieuHaoVatTu + "'  id='txt-IDVatTu-" + dinhMucVatTuData[i].data.IDPhatSinhTieuHaoVatTu + "' style='min-width:350px'    /></td>";
                data += "<td class='center-col'><input value='" + dinhMucVatTuData[i].data.HeSoTieuHao + "'  id='txt-HeSoTieuHao-" + dinhMucVatTuData[i].data.IDPhatSinhTieuHaoVatTu + "' class='clsHeSoTieuHao number-monney' index='" + i + "' dinhmucvattu='" + dinhMucVatTuData[i].data.IDPhatSinhTieuHaoVatTu + "' style='width:70px' /></td>";
                data += "<td class='center-col'><input value='" + dinhMucVatTuData[i].data.DonViTinh + "'  id='txt-DonViTinh-" + dinhMucVatTuData[i].data.IDPhatSinhTieuHaoVatTu + "'  readonly='readonly' style='width:100px'  /></td>";
                data += "<td class='center-col'><input value='" + Number(dinhMucVatTuData[i].data.SoLuong).toFixed(3) + "'  id='txt-SoLuong-" + dinhMucVatTuData[i].data.IDPhatSinhTieuHaoVatTu + "'   style='width:100px' class='number-monney' /></td>";
                data += "</td></tr>";
                $("#tabDinhMucVatTu tbody").append(data);
            }
        } else {
            $("#tabDinhMucVatTu tbody").append("<tr><td class='center-col' colspan='6' style='padding:20px 5px;' ><b > Lệnh sản xuất này chưa được định nghĩa lớp sóng </b></td>");
            $('#btnSaveDinhMucVatTu').hide();
        }
        //console.log(dataVatTu);
        $('.clsTenVatTu').autocomplete({
            lookup: dataVatTu,
            lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) { return true; } else { return false; }

            },
            onSelect: function (suggestion) {

                var _index = parseInt($(this).attr("index"));
                var dinhmucvattu = parseInt($(this).attr("dinhmucvattu"));

                dataLenhSanXuatChiTiet[index].data.dataDinhMucVatTu[_index].data.IDVatTu = suggestion.ID;
                dataLenhSanXuatChiTiet[index].data.dataDinhMucVatTu[_index].data.TenVatTu = suggestion.value;
                dataLenhSanXuatChiTiet[index].data.dataDinhMucVatTu[_index].data.IDDonViTinh = suggestion.IDDonViTinh;
                dataLenhSanXuatChiTiet[index].data.dataDinhMucVatTu[_index].data.DonViTinh = suggestion.DonViTinh;
                dataLenhSanXuatChiTiet[index].data.dataDinhMucVatTu[_index].data.DinhLuong = suggestion.DinhLuong;
                dataLenhSanXuatChiTiet[index].data.dataDinhMucVatTu[_index].data.SoLuong = calSoLuong(dataLenhSanXuatChiTiet[index].data.dataDinhMucVatTu[_index], dataLenhSanXuatChiTiet[index]);
                $('#txt-SoLuong-' + dinhmucvattu).val(dataLenhSanXuatChiTiet[index].data.dataDinhMucVatTu[_index].data.SoLuong);
                $('#txt-DonViTinh-' + dinhmucvattu).val(suggestion.DonViTinh);

                // console.log(dataLenhSanXuatChiTiet[index].data.dataDinhMucVatTu[_index]);
            },
            onHint: function (hint) {
            },
            onInvalidateSelection: function () {

            }
        });
        $('.clsHeSoTieuHao').change(function () {
            var _index = parseInt($(this).attr("index"));
            var dinhmucvattu = parseInt($(this).attr("dinhmucvattu"));
            dataLenhSanXuatChiTiet[index].data.dataDinhMucVatTu[_index].data.HeSoTieuHao = $(this).val();
            dataLenhSanXuatChiTiet[index].data.dataDinhMucVatTu[_index].data.SoLuong = calSoLuong(dataLenhSanXuatChiTiet[index].data.dataDinhMucVatTu[_index], dataLenhSanXuatChiTiet[index]);
            $('#txt-SoLuong-' + dinhmucvattu).val(dataLenhSanXuatChiTiet[index].data.dataDinhMucVatTu[_index].data.SoLuong);
        });
    }


    function DinhMucVatTuBindData(index) {

        var lenhSanXuatChiTietData = dataLenhSanXuatChiTiet[index];
        var dinhMucVatTuData = dataLenhSanXuatChiTiet[index].data.dataDinhMucVatTu;
        InitTableDinhMucVatTu(dinhMucVatTuData, index);

    }


    function OpenTinhDinhMucVatTu(index) {

        DinhMucVatTuBindData(index);
        var title = "Thông tin định mức vật tư";
        $("#content_div").dialog({ modal: true, width: 920, height: 500, title: title });
    }
    function CloseModal(index) {
        $("#content_div").dialog("close");
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
                <div class="toolbar workitem-tool-bar" style="display: none;">
                    <ul class="menu-bar">
                        <li class="menu-item icon-only" id="btn-cancel">
                            <asp:Button ToolTip="Hủy" CssClass="menu-bar-item-button icon cancel-icon" runat="server" ID="Button3" OnClick="btnCancel_Click" />
                        </li>
                    </ul>
                </div>
                <div class="work-item-view" style="margin-left: 10px;">

                    <table class="witform-layout">
                        <tbody>
                            <tr>
                                <td style="width: 15%;"></td>
                                <td style="width: 40%;"></td>
                                <td style="width: 10%;"></td>
                                <td style="width: 35%;"></td>
                            </tr>
                            <tr>
                                <td>Công đoạn sản xuất</td>
                                <td>
                                    <div class="workitemcontrol short-control-50">
                                        <div>
                                            <div class="wrap" style="display: block">
                                                <asp:DropDownList ID="ddlCongDoan" runat="server" DataTextField="TenCongDoan" DataValueField="ID" ViewStateMode="Enabled" AutoPostBack="false" onchange="onChangeCongDoan(this)" Enabled="false">
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
                                    <asp:TextBox ID="txtNgayTao" runat="server" ReadOnly="true"></asp:TextBox></td>
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
                                        <td>SL tấm</td>
                                        <td>SL hộp</td>
                                        <td>SL yêu cầu</td>
                                        <td>Cần SX</td>
                                        <td>SL đạt</td>
                                        <td>SL còn lại</td>
                                        <td>SL lỗi</td>
                                        <%--//<td></td>--%>
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
                        <div class="info-text-wrapper">
                            <span class="info-text">Định mức vật tư cho mặt hàng <span id="spMaHieuMatHang"></span>
                            </span>
                            <span style="float: right; text-align: right; font-size: 13px; font-weight: bold;">Số lượng yêu cầu:
                        <input id="txtSoLuongYeuCau" readonly="readonly" style="width: 120px" />
                                Số lượng cần sản xuất:
                        <input id="txtSoLuongCanSanXuat" style="width: 120px" readonly="readonly"   />
                            </span>
                        </div>
                    </div>
                    <div class="work-item-form">
                        <div class="work-item-view" style="margin-left: 10px;">
                            <asp:Panel runat="server" ID="pnChiTietVatTu">
                                <div id="" class="div-data">
                                    <table class="data-table tab-detail" id="tabDinhMucVatTu">
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
                <%--<input id="btTiepTuc" type="button" class="xrp-button" value="Lưu" />--%>
                <input id="btnSaveDinhMucVatTu" type="button" class="xrp-button" value="Lưu" onclick="CloseModal()" />
            </div>
        </div>
    </div>
</div>
