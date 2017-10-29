<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" MasterPageFile="~/Site.Master" Inherits="xRP.Administrator.QuanLyVatTu.NhaCungCap.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">

        function deleteNhaCungCap(id,title) {
            var answer = confirm("Bạn có thực sự muốn xóa \"" + title + "\"?")
            if (answer) {

                $.ajax({
                    type: "POST",
                    url: "<%#Util.SERVER_NAME %>/Administrator/QuanLyVatTu/NhaCungCap/Default.aspx/DeleteItem",
                    data: "{\"itemID\":" + id + "}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    cache: false,
                    success: function (msg) {
                        window.location.href = "<%#Util.SERVER_NAME %>/Administrator/QuanLyVatTu/NhaCungCap/Default.aspx?page=dsnhacungcap";
                    }
                });
            }
            else {
                this.close();

            }
        }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
     <asp:PlaceHolder ID="plcContent" runat="server"></asp:PlaceHolder>
</asp:Content>
