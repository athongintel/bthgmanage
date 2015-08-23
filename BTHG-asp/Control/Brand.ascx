<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Brand.ascx.cs" Inherits="Control_Brand" %>
<asp:DropDownList ID="liBrand" runat="server" Height="30px" Width="250px" DataSourceID="brandDS" DataTextField="Name" DataValueField="IDBrand">
</asp:DropDownList>

<asp:SqlDataSource ID="brandDS" runat="server" ConnectionString="<%$ ConnectionStrings:BTHGConnectionString %>" SelectCommand="SELECT [IDBrand], [Name] FROM [tbBrand] ORDER BY [Name]"></asp:SqlDataSource>


