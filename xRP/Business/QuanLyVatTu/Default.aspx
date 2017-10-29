<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="xRP.Business.QuanLyVatTu.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script>
        var dataKho = [];
        var dataTinhChatNhapXuat = [];
        $(function () {
            dataKho = JSON.parse('<%=DataKho%>');
            dataTinhChatNhapXuat = JSON.parse('<%=DataTinhChatXuatNhap%>');
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <asp:PlaceHolder ID="plcContent" runat="server"></asp:PlaceHolder>
</asp:Content>
