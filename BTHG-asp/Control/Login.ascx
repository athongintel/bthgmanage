<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Login.ascx.cs" Inherits="Control_Login" %>
<style type="text/css">
    .errormessage
    {
        color: Red;
        font-style: italic;
    }
</style>
<asp:Table ID="tbLogin" runat="server" Width="50%" CellSpacing="10" CssClass="verticalmiddled">
    <asp:TableRow>
        <asp:TableCell>
            <asp:Label ID="Label1" runat="server" Text="Tên đăng nhập"></asp:Label>
        </asp:TableCell>
        <asp:TableCell>
            <asp:TextBox ID="tbUserName" runat="server" TabIndex="1"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red"
                ControlToValidate="tbUserName">*</asp:RequiredFieldValidator>
        </asp:TableCell>
        <asp:TableCell RowSpan="2" TabIndex="3">
            <asp:Button ID="btLogin" runat="server" Text="Đăng nhập" Height="100%" Width="100%"
                OnClick="btLogin_Click" />
        </asp:TableCell>
    </asp:TableRow>
    <asp:TableRow>
        <asp:TableCell>
            <asp:Label ID="Label2" runat="server" Text="Mật khẩu"></asp:Label>
        </asp:TableCell>
        <asp:TableCell>
            <asp:TextBox ID="tbPassword" runat="server" TextMode="Password" TabIndex="2"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ForeColor="Red"
                ControlToValidate="tbPassword">*</asp:RequiredFieldValidator>
        </asp:TableCell>
    </asp:TableRow>
    <asp:TableRow>
        <asp:TableCell ColumnSpan="3">
            <asp:Label CssClass="errormessage" runat="server" ID="lbInfo"></asp:Label>
        </asp:TableCell>
    </asp:TableRow>
</asp:Table>
