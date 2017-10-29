<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DanhSachLenhSanXuat.ascx.cs" Inherits="xRP.Business.QuanLySanXuat.TaoLenhSanXuat.DanhSachLenhSanXuat" %>
<%@ Register Assembly="CollectionPager" Namespace="SiteUtils" TagPrefix="cc1" %>
<style type="text/css">
    .f-dropdown {
        max-width: 152px !important;
    }
</style>
<script type="text/javascript">

    $(function () {
        $('#<%=txtNgaySanXuatTu.ClientID%>').datetimepicker({
            mask: '99/99/9999', timepicker: false,
            format: 'd/m/Y'
        });
        $('#<%=txtNgaySanXuatDen.ClientID%>').datetimepicker({
            mask: '99/99/9999', timepicker: false,
            format: 'd/m/Y'
        });
        $('.date').mask('00/00/0000'); 
    });

    function goToAddNew() {
        var shipList = document.getElementById('<%=ddlCongDoan.ClientID%>');
        var shipCost = shipList.options[shipList.selectedIndex].value;
        window.location.href = "/Business/QuanLySanXuat/Default.aspx?page=tlsx&cd=" + shipCost;
    }

    
</script>
<div class="splitter horizontal hub-splitter stateful toggle-button-enabled toggle-button-hotkey-enabled">
    <div class="rightPane" style="left: 0px;">
        <div class="hub-title">
            <div class="query-result-grid-info">
                <table>
                    <tbody>
                        <tr>
                            <td class="query-title"></td>
                            <td class="query-status hub-title-right"></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="right-hub-content">
            <div class="work-item-form" style="display: block;">
                <div class="workitem-info-bar">
                    <div class="info-text-wrapper"><span class="info-text">Danh sách lệnh sản xuất</span></div>
                </div>
                <div class="toolbar workitem-tool-bar" style="display: block;">

                    <div style="float: left; width: 135px; padding: 8px 5px;">
                        <a href="javascript:goToAddNew();" title="Tạo lệnh sản xuất">
                            <span class="icon icon-add"></span><span class="text">Tạo lệnh sản xuất</span>
                        </a>
                    </div>
                    <div style="margin-left: 135px; padding: 8px 5px; text-align: right;">
                        <span>Công đoạn sản xuất
                                    <asp:DropDownList Style="max-width: 150px" ID="ddlCongDoan" runat="server" DataTextField="TenCongDoan" DataValueField="ID" ViewStateMode="Enabled" AutoPostBack="false" OnSelectedIndexChanged="ddlCongDoan_SelectedIndexChanged">
                                        <asp:ListItem Text="Tạo sóng" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="In" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="In lưới" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Ghim" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Dán" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Chạp" Value="1"></asp:ListItem>
                                    </asp:DropDownList>
                        </span>
                        <span style="text-align: center">Ngày sản xuất
                                <span>
                                    <asp:TextBox ID="txtNgaySanXuatTu" runat="server" Width="100px"></asp:TextBox></span>
                            <span>
                                    <asp:TextBox ID="txtNgaySanXuatDen" runat="server" Width="100px"></asp:TextBox></span>
                        </span>
                       <%-- <span>Khách hàng
                                    <asp:HiddenField ID="slcKhachHangID" runat="server" />
                            <asp:TextBox Style="max-width: 300px" ID="txtKhachHangID" runat="server"></asp:TextBox>
                        </span>
                        <span>Đơn hàng
                                    <asp:HiddenField ID="slcDonHangID" runat="server" />
                            <asp:TextBox Style="max-width: 200px" ID="txtDonHangID" runat="server"></asp:TextBox>
                        </span>--%>
                        <span>
                            <asp:Button runat="server" ID="btnSearch" CssClass="icon icon-search" OnClick="btnSearch_Click" />
                        </span>
                    </div>


                </div>
                <div class="work-item-view" style="display: block;">
                    <table class="data-table" id="tabDanhSachLenhSanXuat">
                        <thead>
                            <tr>
                                <td class="center-col" style="width: 5%;">STT</td>
                                <td>Ngày sản xuất</td>
                                <td style="width:150px;">Lệnh công đoạn</td>
                                <td>Người tạo</td>
                                <td>Ngày tạo</td>
                                <td>Tình trạng</td>
                                 <td>Ghi chú</td>
                                <td>Chức năng
                                </td>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptLenhSanXuat" runat="server" OnItemDataBound="rptLenhSanXuat_ItemDataBound">
                                <ItemTemplate>
                                    <tr>
                                        <td class="center-col" style="width: 15px">
                                            <span class="sothutu"><%# (colPage.CurrentPage - 1) * colPage.PageSize + Container.ItemIndex + 1 %></span>
                                        </td>
                                        <td class="center-col" style="width: 100px"><%# string.Format("{0:dd/MM/yyyy}", Eval("NgaySanXuat")) %> </td>
                                        <td><%# Eval("TenCongDoan") %></td>
                                        <td style="width: 120px"><%# Eval("UserName") %></td>
                                        <td class="center-col" style="width: 90px"><%# string.Format("{0:dd/MM/yyyy}", Eval("NgayTao")) %> </td>
                                        <td class="center-col" style="width: 120px"><%# Eval("MoTaTinhtrang") %></td>
                                        <td style="width: 300px"><%# Eval("GhiChu") %></td>
                                        <td class="center-col" style="width: 110px">
                                            <asp:Literal ID="ltbFunction" runat="server"></asp:Literal>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
                <div class="work-item-view-pager">
                    <cc1:CollectionPager ID="colPage" runat="server" PageSize="10" PagingMode="QueryString"
                        QueryStringKey="trang" BackText="Trước"
                        FirstText="Đầu" LastText="Cuối" NextText="Sau"
                        LabelText="" PageNumbersSeparator="&amp;nbsp;&amp;nbsp;" PageNumbersStyle="color:#007acc;font-size:12px;padding:5px;"
                        PageNumberStyle="color: #555;padding: 3px 8px;text-decoration: underline;" ResultsLocation="Bottom"
                        ResultsStyle="font-family:Arial;font-size:12px;text-align:right;margin-top:5px;"
                        ShowLabel="True" BackNextButtonStyle="border:none;background:red;" BackNextDisplay="HyperLinks"
                        BackNextLinkSeparator="&nbsp;&nbsp;-&nbsp;&nbsp;" ControlStyle="text-align:right;margin:5px;float:right;" BackNextLocation="Split" ResultsFormat="Hiển thị {0}-{1} (trong tổng số {2} bản ghi)" ShowFirstLast="True" ControlCssClass="paging_tool_bar" EnableViewState="False" MaxPages="10" SectionPadding="5" SliderSize="10">
                    </cc1:CollectionPager>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    function onEditLenhSanXuat(id) {
        window.location = '/Business/QuanLySanXuat/Default.aspx?page=tlsx&cd=' + $('#<%= ddlCongDoan.ClientID%>').val() + '&lenhSanXuatId=' + id;
    }
    function onDetailLenhSanXuat(id) {
        window.location = '/Business/QuanLySanXuat/Default.aspx?page=dtlsx&cd=' + $('#<%= ddlCongDoan.ClientID%>').val() + '&lenhSanXuatId=' + id;
    }
    function onUpdateKetQuaSanXuat(id) {
        window.location = '/Business/QuanLySanXuat/Default.aspx?page=cnlsx&cd=' + $('#<%= ddlCongDoan.ClientID%>').val() + '&lenhSanXuatId=' + id;
    }

    function onPrintLenhSanXuat(id) {
        window.location = '/Business/QuanLySanXuat/Default.aspx?page=plsx&cd=' + $('#<%= ddlCongDoan.ClientID%>').val() + '&lenhSanXuatId=' + id;
    }
    function onAddOrEditPhieuYeuCauVatTu(id) {
        window.location = '/Business/QuanLySanXuat/Default.aspx?page=cnpycvt&cd=' + $('#<%= ddlCongDoan.ClientID%>').val() + '&lenhSanXuatId=' + id;
    }
    function onDetailPhieuYeuCauVatTu(id) {
        window.location = '/Business/QuanLySanXuat/Default.aspx?page=ctpycvt&cd=' + $('#<%= ddlCongDoan.ClientID%>').val() + '&lenhSanXuatId=' + id;
    }
    function onCopyLenhSanXuat(id) {
        $.ajax({
            type: "POST",
            url: "Default.aspx/CopyLenhSanXuat",
            data: "{\"id\":" + id + "}",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
            },
            success: function (result) {
                if (!isNaN(result.d)) {
                    window.location = '/Business/QuanLySanXuat/Default.aspx?page=tlsx&cd=' + $('#<%= ddlCongDoan.ClientID%>').val() + '&lenhSanXuatId=' + result.d;
                } else {
                    alert(result.d);
                }
            }
        });
    }
    function onDeleteLenhSanXuat(id) {
        // if (!confirm("Bạn có chắc muốn xóa lệnh sản xuất này không?")) return;
        var obj = new Object();
        obj.ID = id;
        var lenhSanXuat = new LenhSanXuat(obj);
        lenhSanXuat.markDelete();
        window.location.reload(true);
    }
</script>
