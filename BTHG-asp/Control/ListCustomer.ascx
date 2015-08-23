<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ListCustomer.ascx.cs" Inherits="Control_ListCustomer" %>
<asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="customerDS" 
    DataTextField="Name" DataValueField="IDCustomer" Height="30px"
    onselectedindexchanged="DropDownList1_SelectedIndexChanged" Width="400px" 
    >
</asp:DropDownList>
<asp:SqlDataSource ID="customerDS" runat="server" 
    ConnectionString="<%$ ConnectionStrings:BTHGConnectionString %>" 
    SelectCommand="SELECT [Name], [IDCustomer] FROM [tbCustomer] ORDER BY [Name]">
</asp:SqlDataSource>

