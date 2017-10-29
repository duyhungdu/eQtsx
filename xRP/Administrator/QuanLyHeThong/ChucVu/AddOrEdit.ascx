<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddOrEdit.ascx.cs" Inherits="xRP.Administrator.QuanLyHeThong.ChucVu.AddOrEdit" %>
<script type="text/javascript">
    $(document).ready(function () {
        $('#<%=txtName.ClientID%>').focus();
    });

    function loadhtml() {
        window.location.reload(true);
    }

    function loadurl() {

        var id = "<%= id %>";

        var nameId = "#<%=txtName.ClientID%>";
        var noteId = "#<%=txtNote.ClientID%>";
        var isActive = document.getElementById("<%=ckKichHoat.ClientID %>").checked;
        var name = $(nameId).val();
        var note = $(noteId).val();
        
        var message = "";

        if (Utils.isEmpty(name) || name.length < 3) {
            message += "Tên không được để trống, tối thiểu 3 ký tự. \n";
        }

        if (message.length > 0) {
            alert(message);
            return;
        }

        $.ajax({
            type: "POST",
            url: "<%#Util.SERVER_NAME %>/Administrator/QuanLyHeThong/Default.aspx/AddOrUpdatePositionItem",
            data: "{id:'" + id + "',name:'" + name + "',note: '" + note + "',isactive:" + isActive + "}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            cache: false,
            success: function (result) {
                result = JSON.parse(result.d);
                var isSuccess = result.IsSuccess;
                var message = result.Message;
                if (isSuccess) {
                    window.location.href = "<%#Util.SERVER_NAME %>/Administrator/QuanLyHeThong/Default.aspx?page=position";//&trang=" + trang + "";
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
                            <span>Tên chức vụ</span>
                            <span style="color: red">*</span>
                        </div>
                    </td>
                    <td colspan="3">
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtName" runat="server" TabIndex="1"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div>
                            <span>Ghi chú</span>
                        </div>
                    </td>
                    <td colspan="3">
                        <div class="workitemcontrol">
                            <div class="wrap">
                                <asp:TextBox TextMode="MultiLine" ID="txtNote" runat="server" TabIndex="1"></asp:TextBox>
                            </div>

                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Kích hoạt
                    </td>
                    <td>
                        <asp:CheckBox ID="ckKichHoat" runat="server" Checked="true" TabIndex="3"></asp:CheckBox>
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
