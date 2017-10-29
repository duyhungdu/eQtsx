<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddOrEditTruLoi.ascx.cs" Inherits="xRP.Administrator.QuanLyVatTu.TruLoi.AddOrEditTruLoi" %>

<script type="text/javascript">
    function save_data() {
        var id = "<%=ID_TruLoi%>";
        var maloaivattu = $("#<%=txtLoaiVatTu.ClientID%>").val().trim();
        if (maloaivattu == "") {
            alert("Xin vui lòng nhập mã hiệu loại vật tư");
            $('#<%=txtLoaiVatTu.ClientID%>').focus();
            return;
        }
        var kichthuoc = $("#<%=txtKichThuoc.ClientID%>").val().trim();
        if (kichthuoc == "") {
            alert("Xin vui lòng nhập kích thước");
            $('#<%=txtKichThuoc.ClientID%>').focus();
            return;
        }
        var sosanh = $("#<%=txtSoSanh.ClientID%>").val().trim();
        if (sosanh == "") {
            alert("Xin vui lòng nhập giá trị so sánh");
            $('#<%=txtSoSanh.ClientID%>').focus();
            return;
        }
        var truloi = $("#<%=txtTruLoi.ClientID%>").val().trim();
        if (truloi == "") {
            alert("Xin vui lòng nhập giá trị trừ lõi");
            $('#<%=txtTruLoi.ClientID%>').focus();
            return;
        }
        var objData = {
            id: id,
            maloaivattu: maloaivattu,
            kichthuoc: kichthuoc,
            sosanh: sosanh,
            truloi: truloi
        };
        $.ajax({
            type: "POST",
            url: "<%#Util.SERVER_NAME %>/Administrator/QuanLyVatTu/TruLoi/Default.aspx/AddOrEditTruLoi",
            data: JSON.stringify(objData),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            cache: false,
            success: function (msg) {
                if (msg.d == 'SUCCESS') {
                    window.location.reload(true);
                }
                else {
                    alert(msg.d);
                }
            }
        });
    }

</script>

<div class="work-item-form">
    <div class="work-item-view" style="height: 100px">
        <table class="witform-layout">
            <tbody>
                <tr>
                    <td style="width: 15%;"></td>
                    <td style="width: 35%;"></td>
                    <td style="width: 15%;"></td>
                    <td style="width: 35%;"></td>
                </tr>
                <tr>
                    <td>Loại vật tư
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtLoaiVatTu" runat="server" />
                                    <asp:TextBox ID="hdfMaLoaiVatTu" runat="server" />
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>Kích thước
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtKichThuoc" runat="server" />
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>So sánh
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtSoSanh" runat="server" />
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>Trừ lõi
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtTruLoi" runat="server" />
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>

            </tbody>
        </table>
    </div>
</div>
<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix button-list">
    <input type="button" id="btnSave" class="xrp-button" onclick="save_data();" value="Lưu" />
    <input type="button" class="xrp-button" onclick="CloseModal();" value="Hủy" />
</div>
