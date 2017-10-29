<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddOrEditLopGiay.ascx.cs" Inherits="xRP.Business.QuanLySanXuat.LopGiay.AddOrEditLopGiay" %>
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
                            <span>Tên lớp giấy</span>
                            <span style="color: red">*</span>
                        </div>
                    </td>
                    <td colspan="3">
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtTenLop" runat="server" TabIndex="2" Width="100%"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td>Tên sóng</td>
                    <td>
                        <asp:HiddenField ID="slcDanhMucSong" runat="server" ClientIDMode="Static" Value="0" />
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <asp:TextBox ID="txtDanhMucSong" runat="server" TabIndex="4"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </td>


                    <td>Kích hoạt</td>
                    <td>
                        <asp:CheckBox ID="ckKichHoat" runat="server" Checked="true" TabIndex="10"></asp:CheckBox>
                    </td>
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
        $('#<%=txtTenLop.ClientID%>').focus();

        //Danh mục sóng
        queryData("<%=Util.SERVER_NAME %>/WebService/DanhMuc.asmx/GetJSONDataDanhMucSongForAutoComplete", {}, function (result) {
            var objJSON = JSON.parse(result.d);
            $('#<%=txtDanhMucSong.ClientID%>').autocomplete({
                lookup: objJSON,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    var re = new RegExp('\\b' + $.Autocomplete.utils.escapeRegExChars(queryLowerCase), 'gi');
                    return re.test(suggestion.value);
                },
                onSelect: function (suggestion) {
                    $('#<%=slcDanhMucSong.ClientID%>').val(suggestion.data);
                },
                onHint: function (hint) {
                },
                onInvalidateSelection: function () {
                }
            });
        });
        //End-Danh mục sóng


        /// End- Thuộc công đoạn
    });

        function save_data() {
            try {

                if (!confirm("Bạn có chắc muốn lưu thông tin danh mục sóng không?")) {
                    return;
                }

                var data = new Object();
                var lopGiayId = "<%=lopGiayId%>";
                if (!$.isNumeric(lopGiayId)) lopGiayId = 0;
                data.itemID = parseInt(lopGiayId);
                data.danhMucSong = $("#<%=txtDanhMucSong.ClientID%>").val().trim();
                data.tenLop = $("#<%=txtTenLop.ClientID%>").val().trim();;
                data.kichHoat = $("#<%=ckKichHoat.ClientID%>").Checked;
                if (data.nguonLuc == "") {
                    alert("Bạn chưa nhập Tên lớp.");
                    $("#<%=txtTenLop.ClientID%>").focus();
                    return;
                }

                var tenLopGiay = new TenLopGiay(data);

                tenLopGiay.save(function (result) {
                    var newid = result.id;
                    if ($.isNumeric(newid)) {
                        window.location.href = "<%=Util.SERVER_NAME %>/Business/QuanLySanXuat/Default.aspx?page=lg";

                    } else {
                        alert("Có lỗi khi lưu dữ liệu\n" + result.d);
                    }
                })
            } catch (e) { }

            return false;
        }
</script>
