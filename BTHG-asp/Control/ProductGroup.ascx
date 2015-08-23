<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ProductGroup.ascx.cs" Inherits="Control_ProductGroup" %>
<asp:DropDownList ID="DropDownList1" runat="server" Width="300px" Height="25px" DataSourceID="groupDS" DataTextField="Name" DataValueField="IDGroup">
</asp:DropDownList>

<asp:SqlDataSource ID="groupDS" runat="server" ConnectionString="<%$ ConnectionStrings:BTHGConnectionString %>" SelectCommand="SELECT [Name], [IDGroup] FROM [tbProductGroup] ORDER BY [Name]"></asp:SqlDataSource>


