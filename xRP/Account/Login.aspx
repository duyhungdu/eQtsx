<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="xRP.Account.Login" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Đăng nhập hệ thống xRP</title>

    <link href="~/Styles/images/ico.gif" rel="shortcut icon" type="image/x-icon" />
    <link href="~/Styles/login.css" rel="stylesheet" />
    <style>
        .input[type='checkbox'] { opacity: 1; !important; }

        BODY:not(.IE_M9) input[type="checkbox"], BODY:not(.IE_M9) input[type="radio"] { opacity: 1; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="height: 40px;"></div>
        <div id="shellTD" class="centerParent" style="width: 100%;">
            <div id="shellTBL" class="center" style="width: 935px;">
                <div class="centerParent">
                    <div id="mainTD" class="center" style="width: 895px;">
                        <div id="brandModeTD" class="floatLeft" style="width: 475px;">
                            <div id="productTD" style="width: 475px; background: #eee; padding: 20px; text-align: center;">
                                <img src="../Styles/images/ERP_129530330.png" style="width: 350px;" />
                            </div>
                        </div>
                        <div id="signInTD" class="floatLeft" style="width: 420px; position: relative;">
                            <div style="height: 40px;"></div>
                            <div id="i0272" class="signInHeader">
                                <div class="brand-logo">
                                    <h1>ĐĂNG NHẬP
                                        <asp:Literal ID="ltName" runat="server"></asp:Literal></h1>
                                </div>
                            </div>
                            <div style="height: 30px;"></div>
                            <div class="floatLeft" style="width: 100px; height: 370px;"></div>
                            <div class="floatLeft" style="width: 320px;">
                                <div id="rightTD">
                                    <div name="f1">
                                        <div class="section">
                                            <div id="idTd_Tile_Error" aria-live="assertive" aria-relevant="text" aria-atomic="true">
                                                <div class="errorDiv first" id="idTd_Tile_ErrorMsg_Login">
                                                </div>
                                            </div>
                                            <div id="idDiv_PWD_UsernameTb" class="row textbox">
                                                <div style="position: relative; width: 100%;">
                                                    <asp:TextBox runat="server" ID="txtEmail" MaxLength="113" CssClass="ltr_override" />

                                                </div>
                                            </div>

                                            <div id="idDiv_PWD_PasswordTb" class="row textbox">
                                                <div style="position: relative; width: 100%;">
                                                    <asp:TextBox runat="server" ID="txtPassword" MaxLength="113" TextMode="Password" CssClass="ltr_override" />
                                                </div>
                                            </div>

                                            <div class="row textbox">
                                                <div style="position: relative; width: 100%;">
                                                    <asp:CheckBox runat="server" ID="chkRememberMe" CssClass="default ltr_override" Text="Ghi nhớ" />
                                                </div>
                                            </div>
                                        </div>
                                        <div id="idTd_PWD_SubmitCancelTbl" class="section">
                                            <asp:Button runat="server" ID="idSIButton9" Text="Đăng nhập" CssClass="default" OnClick="idSIButton9_Click" />
                                        </div>
                                        <div class="section">
                                            <div id="idDiv_PWD_ForgotPassword" class="row small">
                                                <a href="ForgotPassword.aspx" id="idA_PWD_ForgotPassword">Không thể truy cập tài khoản của bạn?</a>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div style="height: 50px; clear: both;"></div>
            </div>
        </div>
        <div id="evDiv" class="footerHeight">
            <img height="0" id="ev" alt="" style="visibility: hidden;">
        </div>
        <div id="footerTD" class="footer centerParent" style="clear: both; margin-left: 0px;">
            <div class="center" style="width: 895px;">
                <div id="idDiv_MSLogo" class="mslogo"></div>
            </div>
            <div class="center" style="width: 895px; clear: both;">
                <table cellspacing="0" cellpadding="0" class="footer">
                    <tbody>
                        <tr>
                            <td align="right">
                                <table cellspacing="0" cellpadding="0">
                                    <tbody>
                                        <tr>
                                            <td style="text-align: right;"><span></span></td>
                                            <td class="footerspace" aria-hidden="true">&nbsp;</td>
                                            <td class="footerspace" aria-hidden="true">&nbsp;</td>
                                            <td style="text-align: right;"><a href="javascript:alert('Chức năng đang hoàn thiện')" class="footerlink" id="ftrFdbk">Liên hệ</a></td>
                                            <td class="footerspace" aria-hidden="true">&nbsp;</td>
                                            <td class="footerspace" aria-hidden="true">&nbsp;</td>
                                            <td style="text-align: right;"><span id="ftrCopy" class="secondary ltr">&copy;<%=DateTime.Now.Year %> NVM</span></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </form>
</body>



</html>
