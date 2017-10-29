<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddOrEditPhanLoaiSong.ascx.cs" Inherits="xRP.Business.QuanLySanXuat.PhanLoaiSong.AddOrEditPhanLoaiSong" %>
<div class="work-item-form">
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
                            <span>Ký hiệu cơ cấu giấy</span>
                            <span style="color: red">*</span>
                        </div>
                    </td>
                    <td colspan="3">
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtKiHieuCoCauGiay" runat="server" TabIndex="1" Width="100%"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Mô tả cơ cấu giấy</td>
                    <td colspan="3">
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox TextMode="MultiLine" ID="txtMoTaCoCauGiay" runat="server" CssClass="text-area" TabIndex="2"></asp:TextBox>
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
                                    <asp:TextBox ID="txtSoLop" runat="server" TabIndex="9"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>Kích hoạt</td>
                    <td>
                        <asp:CheckBox ID="ckKichHoat" runat="server" Checked="true" TabIndex="10"></asp:CheckBox>
                    </td>
                </tr>
                <tr>
                    <td>Kí hiệu quy đổi</td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtKiHieuQuyDoi" runat="server" TabIndex="9"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>Ghi chú
                    </td>
                    <td colspan="3">
                        <asp:TextBox TextMode="MultiLine" ID="txtGhiChu" runat="server" CssClass="text-area" TabIndex="11"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="4"></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix button-list">
    <input type="button" value="Lưu" class="xrp-button" onclick="save_data();" tabindex="12" />
    <input type="button" value="Hủy" onclick="CloseModal();" class="xrp-button" tabindex="13" />
</div>
<script type="text/javascript">
    $(document).ready(function () {
        $('#<%=txtKiHieuCoCauGiay.ClientID%>').focus();

    });

    function save_data() {
        try {

            if (!confirm("Bạn có chắc muốn lưu thông tin phân loại sóng không?")) {
                return;
            }
            var data = new Object();
            var phanLoaiSongId = "<%=phanLoaiSongId%>";
            if (!$.isNumeric(phanLoaiSongId)) phanLoaiSongId = 0;
            data.itemID = parseInt(phanLoaiSongId);

            data.kiHieuCoCauGiay = $("#<%=txtKiHieuCoCauGiay.ClientID%>").val().trim();
            data.kiHieuQuyDoi = $("#<%=txtKiHieuQuyDoi.ClientID%>").val().trim();
            data.moTaCoCauGiay = $("#<%=txtMoTaCoCauGiay.ClientID%>").val().trim();

            var _SoLop = $("#<%=txtSoLop.ClientID%>").val().trim();
            if (!$.isNumeric(_SoLop)) _SoLop = 0;
            data.soLop = _SoLop;

            if ($("#<%=ckKichHoat.ClientID%>").is(':checked'))
                data.kichHoat = true;
            else
                data.kichHoat = false;


            data.ghiChu = $("#<%=txtGhiChu.ClientID%>").val().trim();


            if (data.kiHieuCoCauGiay == "") {
                alert("Bạn chưa nhập Ký hiệu cơ cấu giấy.");
                $("#<%=txtKiHieuCoCauGiay.ClientID%>").focus();
                return;
            }


            var phanLoaiSong = new PhanLoaiSong(data);

            phanLoaiSong.save(function (result) {
                console.log(result.d);
                var newid = result.d;
                if ($.isNumeric(newid))
                    // if (parseInt(newid) > 0)
                    window.location.href = "<%=Util.SERVER_NAME %>/Business/QuanLySanXuat/Default.aspx?page=pls";
                else
                    alert("Có lỗi khi lưu dữ liệu\n" + result.d);

            })
        } catch (e) {
            console.log(e);
        }

        return false;
    }
</script>
