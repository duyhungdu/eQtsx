<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddorEditHeSoTongGiao.ascx.cs" Inherits="xRP.Administrator.QuanLyDonHang.HeSoTongGiao.AddorEditHeSoTongGiao" %>
<script type="text/javascript">
    $(document).ready(function () {
        $("#<%=txtKichThuoc.ClientID%>").focus();
    });
    function themHeSoTongGiao() {
        var id = "<%=ID_HeSoTongGiao%>";
        var kichthuoc = $("#<%=txtKichThuoc.ClientID%>").val().trim();
        if (kichthuoc == "") {
            alert("Kích thước không được trống");
            $("#<%=txtKichThuoc.ClientID%>").focus();
            return;
        }
        var idLoaiKichThuoc = $("#<%=slcKichThuoc.ClientID%>").val();
        var hesotonggiao = $("#<%=txtHeSoTongGiao.ClientID%>").val().trim();
        if (hesotonggiao == "") {
            alert("Hệ số tổng giao không được trống");
            $('#<%=txtHeSoTongGiao.ClientID%>').focus();
             return;
         }
         var ghichu = $("#<%=txtGhiChu.ClientID%>").val();

        var kichHoat = "";
        var value = document.getElementById("<%=chkKichHoat.ClientID %>").checked;

         if (value == true) {
             kichHoat = "1";
         }
         if (value == false) {
             kichHoat = "0";
         }
         var trang = "<%=trang%>";
        var soLop = $("#<%=txtSoLop.ClientID%>").val();

        $.ajax({
            type: "POST",
            url: "<%#Util.SERVER_NAME %>/Administrator/QuanLyDonHang/Default.aspx/ThemHeSoTongGiao",
            data: "{id:'" + id + "',idLoaiKichThuoc:'" + idLoaiKichThuoc + "',soLop: '" + soLop + "',heSoTongGiao:'" + hesotonggiao + "',ghiChu:'" + ghichu + "',kichHoat:'" + kichHoat + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            cache: false,
            success: function (msg) {
                var r = msg.d;
                if (r != "SUCCESS")
                    alert(r);
                else
                window.location.href = "<%#Util.SERVER_NAME %>/Administrator/QuanLyDonHang/Default.aspx?page=hstg&trang=" + trang + "";
            }
        });
        }
</script>
 
<div class="work-item-form">
        <div class="work-item-view" style="margin-left: 10px;">

            <table class="witform-layout">
                <tbody>
                    <tr>

                        <td style="width: 20%;"></td>
                        <td style="width: 20%;"></td>
                        <td style="width: 50%;"></td>
                        <td style="width: 10%;"></td>
                    </tr>
                    <tr>
                        <td >
                            <div>
                                  <span>Kích thước</span>
                                 <span style="color:red">*</span>
                             </div>
                        </td>
                        <td colspan="3">
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                        <asp:HiddenField ID="slcKichThuoc" runat="server" />
                                        <asp:TextBox ID="txtKichThuoc" runat="server" TabIndex="1"></asp:TextBox>
                                    </div>

                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                             <div>
                                  <span>Hệ số tổng giao</span>
                                 <span style="color:red">*</span>
                             </div>
                        </td>
                        <td>
                            <div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">
                                       <asp:TextBox ID="txtHeSoTongGiao" runat="server" TabIndex="2" Width="100%"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </td>
                       <td style="width:100%">
                           <table style="width:100%">
                               <tr>
                                   
                        <td >
                            <div>
                                  <span>Số lớp</span>
                                 <span style="color:red">*</span>
                             </div>
                        </td>
                        <td>
                            <%--<div class="workitemcontrol">
                                <div class="combo tree drop">
                                    <div class="wrap">--%>
                                        <asp:TextBox ID="txtSoLop" runat="server" TabIndex="1"></asp:TextBox>
                                    <%--</div>

                                </div>
                            </div>--%>
                        </td>
                        <td>
                             <div>
                                  <span>Kích hoạt</span>
                                 <span style="color:red">*</span>
                             </div>
                        </td>
                        <td>
                           <asp:CheckBox ID="chkKichHoat" runat="server"></asp:CheckBox>
                        </td>
                               </tr>
                           </table>
                       </td>

                    </tr>
                    <tr>
                        <td>Ghi chú</td>
                        <td colspan="3">
                          <asp:TextBox ID="txtGhiChu" runat="server" TextMode="MultiLine" Rows="3"></asp:TextBox>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix button-list">
    <input type="button" value="Lưu dữ liệu" class="xrp-button" onclick="themHeSoTongGiao();" tabindex="12" />
    <input type="button" value="Hủy" onclick="CloseModal();" class="xrp-button" tabindex="13" />
</div>
