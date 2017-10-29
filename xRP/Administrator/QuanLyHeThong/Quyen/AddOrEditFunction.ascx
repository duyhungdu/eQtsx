<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddOrEditFunction.ascx.cs" Inherits="xRP.Administrator.QuanLyHeThong.Quyen.AddOrEditFunction" %>
<script type="text/javascript">
    $(document).ready(function () {
        $('#<%=txtName.ClientID%>').focus();
    });

    function loadhtml() {
        window.location.reload(true);
    }

    function loadurl() {

        var id = "<%= id %>";

        var name = $("#<%=txtName.ClientID%>").val();
        var ma = $("#<%=txtMa.ClientID%>").val();
        var hdfParentID = $("#<%=hdfParentID.ClientID%>").val();
        var href = $("#<%=txtHref.ClientID%>").val();
        var icon = $("#<%=txtIcon.ClientID%>").val();
        var thutu = $("#<%=txtOrder.ClientID%>").val();
        var message = "";

        if (name=="" || name ==null) {
            message += "Tên không được để trống, tối thiểu 3 ký tự. \n";
        }

        if (message.length > 0) {
            alert(message);
            return;
        }
       // alert("ma: " + ma + "name: " + name + "parentID: " + hdfParentID);
        
        $.ajax({
            type: "POST",
            url: "<%#Util.SERVER_NAME %>/Administrator/QuanLyHeThong/Default.aspx/AddOrUpdateFunctionItem",
            data: "{id:'" + id + "',ma:'" + ma + "',name: '" + name + "',parentID:'" + hdfParentID + "',href:'" + href + "',icon:'" + icon + "',thutu:'" + thutu + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            cache: false,
            success: function (result) {
                result = JSON.parse(result.d);
                var isSuccess = result.IsSuccess;
                var message = result.Message;
                if (isSuccess) {
                    $("#save_button").hide();
                    CloseModal();
                    alert('Cập nhật dữ liệu thành công');
                    window.location.reload();
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
                            <span>Tên chức năng</span>
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
                            <span>Mã</span>
                        </div>
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtMa" runat="server" TabIndex="2"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>
                        <div>
                            <span>Cấp cha</span>
                        </div>
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">

                                    <asp:TextBox ID="txtParent" ReadOnly="true" runat="server" TabIndex="3"></asp:TextBox>
                                    <asp:HiddenField ID="hdfParentID" runat="server" />
                                </div>
                            </div>

                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div>
                            <span>Đường dẫn</span>
                        </div>
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtHref" runat="server" TabIndex="4"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>
                        <div>
                            <span>Thứ tự</span>
                        </div>
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtOrder" runat="server" TabIndex="6"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div>
                            <span>Danh sách cấp con</span>
                        </div>
                    </td>
                    <td colspan="3">
                        <div class="workitemcontrol">
                           
                                    <asp:TextBox ID="txtIcon" TextMode="MultiLine" runat="server" TabIndex="5"></asp:TextBox>
                              
                        </div>
                    </td>

                </tr>
            </tbody>
        </table>

    </div>
</div>
<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix button-list">
    <input type="button" id="save_button" value="Lưu" class="xrp-button" onclick="loadurl();" tabindex="5" />
    <input type="button" value="Hủy" onclick="CloseModal();" class="xrp-button" tabindex="6" />
</div>
