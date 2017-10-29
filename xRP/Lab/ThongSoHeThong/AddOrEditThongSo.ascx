<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddOrEditThongSo.ascx.cs" Inherits="xRP.Lab.ThongSoHeThong.AddOrEditThongSo" %>


<script type="text/javascript">
    $(document).ready(function () {
        $('#datetimepicker_mask').datetimepicker({
            mask: '99/99/9999', timepicker: false,
            format: 'd/m/Y',
        });
        $('.date').mask('00/00/0000');
        $("#txtTinhChatNhapXuat").focus();



        $("#btnSave").click(function () {
            var lvt = new LoaiVatTu({
               /* itemID: "<%=ID_LoaiVatTu%>",
                maLoai: $("#<%=AddOrEditLoaiVatTu_txtMaLoai.ClientID%>").val(),
                tenLoai: $("#<%=AddOrEditLoaiVatTu_txtTenLoai.ClientID%>").val(),
                ghiChu: $("#<%=AddOrEditLoaiVatTu_txtGhiChu.ClientID%>").val() */
            });
            if (lvt.data.maLoai == "") {
                alert("Bạn chưa nhập mã đơn vị tính");
                $("#<%=AddOrEditLoaiVatTu_txtMaLoai.ClientID%>").focus();
                 return;
             }
            if (lvt.data.maLoai == "") {
                alert("Bạn chưa nhập tên đơn vị tính");
                $("#<%=AddOrEditLoaiVatTu_txtTenLoai.ClientID%>").focus();
                 return;
             }
            lvt.save(function () {
                CloseModal();
            });
        });

    });



</script>
<script type="text/javascript">
    $(function () {
        var tinhchat = '<%=ListTinhChatNhapXuat%>';
        var objJSON = JSON.parse(tinhchat);
        var countriesArray = $.map(objJSON, function (value, key) { return { value: value, data: key }; });
        $('#txtTinhChatNhapXuat').autocomplete({
            lookup: countriesArray,
            lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                if (suggestion.value.toLowerCase().indexOf(queryLowerCase) >= 0) {return true;}else {return false;}
                if (queryLowerCase == "*") {
                    return re;
                }
                else {
                     
                }

            },
            onSelect: function (suggestion) {
                $('#selction-ajax').html('You selected: ' + suggestion.value + ', ' + suggestion.data);
            },
            onHint: function (hint) {
                $('#autocomplete-ajax-x').val(hint);
            },
            onInvalidateSelection: function () {
                $('#selction-ajax').html('You selected: none');
            }
        });
    });
</script>
<div class="work-item-form">
    <div class="work-item-view">
        <table class="witform-layout">
            <tbody>
                <tr>
                    <td style="width: 12%;"></td>
                    <td style="width: 38%;"></td>
                    <td style="width: 12%;"></td>
                    <td style="width: 38%;"></td>
                </tr>
                <tr>

                    <td>Mã (tự sinh)
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop short-control-50">
                                <div class="wrap">
                                    <asp:TextBox ID="txtMaLoai" ReadOnly="true" runat="server" />
                                </div>

                            </div>
                        </div>
                    </td>
                    <td>Tính chất
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <input type="text" id="txtTinhChatNhapXuat" />
                                    <div id="selction-ajax"></div>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Datetime
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <input type="text" placeholder="__/__/____" name="field-name" data-mask="00/00/0000" />
                                </div>

                            </div>
                        </div>
                    </td>
                    <td>Datetime picker with mask
                    </td>
                    <td>
                        <div class="workitemcontrol">
                            <div class="combo tree drop">
                                <div class="wrap">
                                    <input type="text" value="" id="datetimepicker_mask" />
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Mô tả
                    </td>
                    <td colspan="3">
                        <asp:TextBox ID="txtMoTa" TextMode="MultiLine" runat="server" />
                    </td>
                </tr>

            </tbody>
        </table>
    </div>
</div>
<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix button-list">
    <p id="result_suggest" style="display: none;"></p>
    <input type="button" id="btnSave" class="xrp-button" value="Lưu" />
    <input type="button" class="xrp-button" onclick="CloseModal();" value="Hủy" />
</div>
