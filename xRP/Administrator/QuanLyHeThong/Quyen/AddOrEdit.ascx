<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddOrEdit.ascx.cs" Inherits="xRP.Administrator.QuanLyHeThong.Quyen.AddOrEdit" %>

<script type="text/javascript">
    $(document).ready(function () {
        $('#<%=txtTen.ClientID%>').focus();
    });

    function loadhtml() {
        window.location.reload(true);
    }

    function loadurl() {

        var id = "<%= id %>";

        var nameId = "#<%=txtTen.ClientID%>";
        var codeId = "#<%=txtCode.ClientID%>";
        var noteId = "#<%=txtNote.ClientID%>";

        var name = $(nameId).val();
        var code = $(codeId).val();
        var note = $(noteId).val();



        var message = "";

        if (Utils.isEmpty(name) || name.length < 3) {
            message += "Tên không được để trống, tối thiểu 3 ký tự. \n";
        }


        if (Utils.isEmpty(code) || code.length < 3) {
            message += "Mã không được để trống, tối thiểu 3 ký tự. \n";
        }

        if (message.length > 0) {
            alert(message);
            return;
        }

        var trang = "<%=trang%>";

        $.ajax({
            type: "POST",
            url: "<%#Util.SERVER_NAME %>/Administrator/QuanLyHeThong/Default.aspx/AddOrUpdatePermissionItem",
            data: "{id:'" + id + "',name:'" + name + "',note: '" + note + "',code:'" + code + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            cache: false,
            success: function (result) {
                result = JSON.parse(result.d);
                var isSuccess = result.IsSuccess;
                var message = result.Message;
                if (isSuccess) {
                    window.location.href = "<%#Util.SERVER_NAME %>/Administrator/QuanLyHeThong/Default.aspx?page=permission&trang=" + trang + "";
                } else {
                    alert("Lỗi:  " + message);
                }
            }
        });
    }
</script>


<div class="work-item-form frm">
    <div class="work-item-view">

        <table class="witform-layout ">
            <tbody>
                <tr>
                    <td style="width: 25%;"></td>
                    <td style="width: 25%;"></td>
                    <td style="width: 15%;"></td>
                    <td style="width: 35%;"></td>
                </tr>
                <tr>
                    <td>
                        <div>
                            <span>Tên </span>
                            <span style="color: red">*</span>
                        </div>
                    </td>
                    <td colspan="3">
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtTen" runat="server" TabIndex="1"></asp:TextBox>
                                </div>

                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div>
                            <span>Mã</span>
                            <span style="color: red">*</span>
                        </div>
                    </td>
                    <td colspan="3">
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtCode" runat="server" TabIndex="1"></asp:TextBox>
                                </div>

                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div>
                            <span>Mô tả</span>

                        </div>
                    </td>
                    <td colspan="3">
                        <div class="workitemcontrol">
                            <div class="wrap">
                                <asp:TextBox ID="txtNote" runat="server" TextMode="MultiLine" MaxLength="250" TabIndex="1"></asp:TextBox>
                            </div>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>

    </div>
</div>
<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix button-list">
    <input type="button" value="Lưu" class="xrp-button" onclick="loadurl();" tabindex="5" />
    <input type="button" value="Hủy" onclick="CloseModal();" class="xrp-button" tabindex="6" />
</div>
