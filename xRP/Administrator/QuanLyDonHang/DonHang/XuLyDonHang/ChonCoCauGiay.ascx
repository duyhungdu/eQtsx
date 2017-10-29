<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ChonCoCauGiay.ascx.cs" Inherits="xRP.Administrator.QuanLyDonHang.DonHang.XuLyDonHang.ChonCoCauGiay" %>

<script type="text/javascript">
    function ChonDinhMucVatTu() {
        window.location.href = "<%#Util.SERVER_NAME %>/Business/QuanLySanXuat/Default.aspx?page=dmvattu&mathangid=<%=matHang.ID%>";
    }
    function back() {
        window.location.href = "/Business/QuanLySanXuat/Default.aspx?page=cdsx&mathangid=<%=matHang.ID%>";
    }
    $(function () {
        $("#<%=txtTai.ClientID%>").focus();
        var hang = new MatHang({
            ID: parseInt("<%=matHang.ID%>"),
            MaLoaiKichThuoc: "<%=MaLoaiKichThuoc%>",
            ChieuDai: "<%=matHang.ChieuDai.HasValue?matHang.ChieuDai.Value:0%>",
            ChieuRong: "<%=matHang.ChieuRong.HasValue?matHang.ChieuRong.Value:0%>",
            ChieuCao: "<%=matHang.ChieuCao.HasValue?matHang.ChieuCao.Value:0%>",
            ChatDai: "<%=matHang.ChatDai.HasValue?matHang.ChatDai.Value:0%>",
            Xa: "<%=matHang.Xa.HasValue?matHang.Xa.Value:0%>",
            SoLuongTam: "<%=matHang.SoLuongTam.HasValue?matHang.SoLuongTam.Value:0%>",
            SoLuongHop: "<%=matHang.SoLuongHop.HasValue?matHang.SoLuongHop.Value:(0+ (matHang.SoLuong.HasValue ?matHang.SoLuong.Value:0))%>",
            SoLuong: "<%=matHang.SoLuong.HasValue?matHang.SoLuong.Value:0%>",
            IDLoaiGiay: "<%=matHang.IDLoaiGiay.HasValue?matHang.IDLoaiGiay.Value:0%>",
            LoaiSongSanXuat: "<%=matHang.IDLoaiSongSanXuat.HasValue?matHang.IDLoaiSongSanXuat.Value:0%>",
            TongDao: "<%=matHang.TongDao.HasValue?matHang.TongDao.Value:0%>",
            HeSoTongDao: "<%=HeSoTongDao%>",
            HeSoChatDai: "<%=HeSoChatDai%>",
            KhoGiay: "<%=matHang.KhoGiay.HasValue?matHang.KhoGiay.Value:0%>",
            Tai: "<%=matHang.Tai.HasValue?matHang.Tai.Value:0%>",
            Le: "<%=matHang.Le.HasValue?matHang.Le.Value:0%>"
        });
        if (hang.TinhTrang.Value == 0) {
            hang.initCalField();
        }
        hang.StopValueChangedEvent = true;
        /**
            Init field data
         */
        $("#<%=txtHeSoTongGiao.ClientID%>").val(hang.HeSoTongDao.Value);
        $("#<%=txtTongGiao.ClientID%>").val(hang.TongDao.Value);
        $("#<%=txtHeSoChatDai.ClientID%>").val(hang.HeSoChatDai.Value);
        $("#<%=txtChatDai.ClientID%>").val(hang.ChatDai.Value);
        $("#<%=txtXa.ClientID%>").val(hang.Xa.Value);
        $("#<%=txtSoLuongTam.ClientID%>").val(hang.SoLuongTam.Value);
        $("#<%=txtSoLuongHop.ClientID%>").val(hang.SoLuongHop.Value);
        $("#<%=txtTai.ClientID%>").val(hang.Tai.Value);
        $("#<%=txtLe.ClientID%>").val(hang.Le.Value);
        $("#<%=txtKhoGiay.ClientID%>").val(hang.KhoGiay.Value);
        $("#<%=dropLoaiSong.ClientID%>").val(hang.LoaiSongSanXuat.Value);

        if (hang.LoaiSongSanXuat.Value == 0) {
            hang.LoaiSongSanXuat.setValue($("#<%=dropLoaiSong.ClientID%>").val());
        }
        //Get DS Song
        var dsSong = hang.getTenDSSong();
        var sDSSong = "";
        for (var i = 0; i < dsSong.length; i++) {
            if (sDSSong != "") sDSSong += ", ";
            sDSSong += dsSong[i].TenSong;
        }
        $("#<%=txtSong.ClientID%>").val(sDSSong);


        $(hang).on("DataChanged", function (evt) {
            if (hang.StopValueChangedEvent && evt.fieldName === "MaLoaiKichThuoc" || evt.fieldName === "ChieuDai" || evt.fieldName === "ChieuCao" || evt.fieldName === "HeSoTongDao")
                hang.calTongDao();
            if (hang.StopValueChangedEvent && evt.fieldName === "ChieuCao" || evt.fieldName === "ChieuDai" || evt.fieldName === "ChieuRong" || evt.fieldName === "HeSoChatDai")
                hang.calChatDai();
            if (hang.StopValueChangedEvent && evt.fieldName === "TongDao")
                hang.calXa();
            if (hang.StopValueChangedEvent && evt.fieldName === "SoLuongHop" || evt.fieldName === "Xa" || evt.fieldName === "ChieuDai" || evt.fieldName === "ChieuRong")
                hang.calSoLuongTam();
            switch (evt.fieldName) {
                case "TongDao":
                    $("#<%=txtTongGiao.ClientID%>").val(hang.TongDao.Value);
                    break;
                case "Xa":
                    $("#<%=txtXa.ClientID%>").val(hang.Xa.Value);
                    break;
                case "ChatDai":
                    $("#<%=txtChatDai.ClientID%>").val(hang.ChatDai.Value);
                    break;
                case "SoLuongTam":
                    $("#<%=txtSoLuongTam.ClientID%>").val(hang.SoLuongTam.Value);
                    break;
                case "SoLuongHop":
                    $("#<%=txtSoLuongHop.ClientID%>").val(hang.SoLuongHop.Value);
                    break;
                case "KhoGiay":
                    $("#<%=txtKhoGiay.ClientID%>").val(hang.KhoGiay.Value);
                    break;
            }
        });
        $("[data-field]").on('blur', function () {
            var fieldName = $(this).attr("data-field");
            if (!hang[fieldName].setValue(this.value)) {
                this.value = "";
                this.focus();
            }
        });
        $("#btnSave").on("click", function () {
            SaveData(true);
        });
        $("#btnSaveAnShowCanhBao").on("click", function () {
            SaveData(false);
        });
        function SaveData(quaylai) {
            $("input[type=button]").prop("disabled", true);
            hang.chonCoCauGiay(function () {
                queryData("Default.aspx/KetThucXuLyDonHang", "{ID:<%=matHang.IDDonHang%>}", function (result) {
                    if (result.d) {
                        alert(result.d);
                    }
                    if (quaylai) {
                        window.location.href = "/Business/QuanLySanXuat/Default.aspx?page=xldh&donhangid=<%=matHang.IDDonHang%>";
                    }
                    else {
                        queryData("Default.aspx/GetYeuCauByMatHangID", "{ID:<%=matHang.ID%>}", function (result) {
                            var id_ycsx = result.d;
                            OpenModalCanhBaoVatTu(id_ycsx);
                        });
                    }
                    $("input[type=button]").prop("disabled", false);
                }, null, false);
            });
        }

        $("#btnRecal").on("click", function () {
            console.log("start")
            hang.StopValueChangedEvent = false;
            hang.initCalField();
            //$("#<%=txtKhoGiay.ClientID%>").val(($("#<%=txtTongGiao.ClientID%>").val()) * 2);
            hang.StopValueChangedEvent = true;
            console.log("end")
        });
    });

</script>

<div class="splitter horizontal hub-splitter stateful toggle-button-enabled toggle-button-hotkey-enabled content_trg">
    <div class="workitem-info-bar">
        <div class="info-text-wrapper">
            <span class="info-text">Chọn cơ cấu giấy cho mặt hàng <%=matHang.MaHieuMatHang%>
            </span>
        </div>
    </div>
    <div class="work-item-form">

        <div class="work-item-view">

            <table class="witform-layout">
                <tbody>
                    <tr>
                        <td style="width: 10%"></td>
                        <td style="width: 16%"></td>
                        <td style="width: 10%"></td>
                        <td style="width: 17%"></td>
                        <td style="width: 9%"></td>
                        <td style="width: 17%"></td>
                        <td style="width: 5%"></td>
                        <td style="width: 21%"></td>
                    </tr>
                    <tr>
                        <td>
                            <div>
                                <span>Tên hàng</span>
                                <span style="color: red">*</span>
                            </div>
                        </td>
                        <td colspan="5">
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtTenHang" Text="" runat="server" TabIndex="2" Width="100%" Enabled="false"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>Số lượng cần sản xuất</td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtSoLuong" Text="" runat="server" TabIndex="6" Enabled="false"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td>Số lớp</td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtSoLop" Text="" runat="server" TabIndex="6" Enabled="false"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td>Sóng</td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtSong" runat="server" TabIndex="6" Text="" Enabled="false"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>Dài (mm)</td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtChieuDai" Text="" runat="server" TabIndex="6" Enabled="false"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td>Rộng (mm)</td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtChieuRong" Text="" runat="server" TabIndex="6" Enabled="false"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td>Cao (mm)</td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree  drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtChieuCao" Text="" runat="server" TabIndex="6" Enabled="false"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>Phần cộng thêm tai</td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtTai" runat="server" TabIndex="6"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td>Phần cộng thêm lề</td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtLe" runat="server" TabIndex="6"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>Loại kích thước</td>
                        <td>
                            <asp:DropDownList ID="dropLoaiKichThuoc" runat="server" Enabled="false">
                                <asp:ListItem Text="Kích thước trong" Value="1"></asp:ListItem>
                                <asp:ListItem Text="Kích thước ngoài" Value="2"></asp:ListItem>
                                <asp:ListItem Text="Kích thước phủ bì" Value="3"></asp:ListItem>
                                <asp:ListItem Text="Kích thước phủ bì toàn phần" Value="4"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td>Loại hộp</td>
                        <td>
                            <asp:DropDownList ID="dropLoaiHop" runat="server" Enabled="false">
                            </asp:DropDownList>
                        </td>
                        <td colspan="2"></td>
                        <td colspan="2"></td>
                    </tr>
                    <tr>
                        <td>Hệ số tổng giao</td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree  drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtHeSoTongGiao" runat="server" TabIndex="6" Enabled="false">
                                        </asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td>Tổng giao</td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtTongGiao" Text="" runat="server" TabIndex="6"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td colspan="2"></td>
                    </tr>
                    <tr>
                        <td>Hệ số chặt dài</td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtHeSoChatDai" runat="server" TabIndex="6" Enabled="false"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td>Chặt dài</td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtChatDai" runat="server" TabIndex="6"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td colspan="2"></td>
                    </tr>
                    <tr>
                        <td>Xả</td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtXa" Text="" runat="server" TabIndex="6"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td>Số lượng tấm</td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtSoLuongTam" Text="" runat="server" TabIndex="6"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td>Số lượng hộp</td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtSoLuongHop" Text="" runat="server" TabIndex="6"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td>Khổ giấy</td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:TextBox ID="txtKhoGiay" Text="" runat="server" TabIndex="6"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td>Loại sóng</td>
                        <td colspan="2">
                            <asp:DropDownList ID="dropLoaiSong" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td colspan="2"></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div style="margin-top: 10px; text-align: right">
            <input type="button" id="btnRecal" class="xrp-button" value="Tự động tính" onclick="return false;" />
            <input type="button" id="btnSaveAnShowCanhBao" class="xrp-button" value="Đồng ý" onclick="return false;" />
            <input type="button" id="btnSave" class="xrp-button" value="Kết thúc" onclick="return false;" />
            <input type="button" value="Quay lại" class="xrp-button" tabindex="13" onclick="back();" />
        </div>
    </div>
</div>

<div id="content_div" style="z-index: 1002;" title="Phương án sản xuất">
</div>
<script type="text/javascript">
    function OpenModalCanhBaoVatTu(id) {
        var paging = $.QueryString("trang");
        if (paging != null) {
            LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Business/QuanLySanXuat/TaoLenhSanXuat/CanhBaoVatTu.ascx", "&id=" + id + "&trang=" + paging);
        }
        else {
            LoadUserControl("<%=Util.SERVER_NAME %>/Default.aspx", "/Business/QuanLySanXuat/TaoLenhSanXuat/CanhBaoVatTu.ascx", "&id=" + id);
        }
        $("#content_div").dialog({ modal: true, width: 1024, height: 600 });
    }
    function CloseModal() {
        $("#content_div").dialog("close");
    }
</script>
