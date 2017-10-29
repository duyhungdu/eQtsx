<%@ Page Title="" Language="C#" ValidateRequest="false" EnableEventValidation="false" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="xRP.Administrator.QuanLyHeThong.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script>
        function handlerEnterKey(controlId) {
            $("#" + controlId).focus();
            $("#" + controlId).keypress(function (e) {
                //$('form').pre
                //alert(e.keyCode);
                if (e.keyCode == 13) {
                    e.preventDefault();
                    doSearch();
                }
            });
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:PlaceHolder ID="plcContent" runat="server"></asp:PlaceHolder>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
