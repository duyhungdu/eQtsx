<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Default.aspx.cs" Inherits="xRP.Administrator.QuanLyVatTu.VatTu.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        function deleteItem(id) {
            if (!confirm("Bạn có chắc muốn xóa không?")) return;
            $.ajax({
                type: "POST",
                url: "<%=Util.SERVER_NAME %>/Administrator/QuanLyVatTu/VatTu/Default.aspx/DeleteItem",
                data: "{\"itemID\":" + id + "}",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                },
                success: function (result) {
                    if (result.d == "SUCCESS") {
                        window.location.reload(true);
                    } else {
                        alert("Có lỗi trong quá trình xử lý, hãy thử lại!");
                    }
                }
            });
        }

        function addOrUpdateItem(id, ma, ten, loai, kichThuoc, dinhLuong, donViTinh, tonToiThieu, kichHoat, ghiChu, onComplete) {
            if (!confirm("Bạn có chắc chắn muốn lưu dữ liệu?")) return;
            $.ajax({
                type: "POST",
                url: "<%=Util.SERVER_NAME %>/Administrator/QuanLyVatTu/VatTu/Default.aspx/AddOrUpdateItem",
                data: "{\"itemID\":" + id + ", \"ma\":\"" + ma + "\", \"ten\":\"" + ten + "\", \"loai\":\"" + loai + "\", \"kichThuoc\":" + kichThuoc + ", \"dinhLuong\":" + dinhLuong + ", \"donViTinh\":\"" + donViTinh + "\", \"tonToiThieu\":" + tonToiThieu + ", \"kichHoat\":" + kichHoat + ", \"ghiChu\":\"" + ghiChu + "\"}",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    console.log("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                    if (onComplete)
                        onComplete();
                },
                success: function (result) {
                    if (result.d == "SUCCESS") {
                        window.location.reload(true);
                        if (onComplete)
                            onComplete();
                    } else {
                        console.log(result);
                        if (onComplete)
                            onComplete();
                    }
                }
            });
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
     <asp:PlaceHolder ID="plcContent" runat="server"></asp:PlaceHolder>
</asp:Content>
