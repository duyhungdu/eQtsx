<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Default.aspx.cs" Inherits="xRP.Administrator.QuanLyVatTu.TinhChatXuatNhap.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        function deleteTinhChatNhapXuat(id, title) {
            var answer = confirm("Bạn có thực sự muốn xóa \"" + title + "\"?")
            if (answer) {
                $.ajax({
                    type: "POST",
                    url: "<%#Util.SERVER_NAME %>/Administrator/QuanLyVatTu/TinhChatXuatNhap/Default.aspx/XoaTinhChat",
                data: "{id:" + id + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                cache: false,
                success: function (msg) {
                    window.location.reload(true);
                }
            });
        }
        else {
            this.close();
        }
    };
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:PlaceHolder ID="plcContent" runat="server"></asp:PlaceHolder>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
