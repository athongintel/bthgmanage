<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Manage.master" AutoEventWireup="true" CodeFile="PriceChange.aspx.cs" Inherits="Manage_PriceChange" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div align="center" style="padding: 12px; color: #0066FF; font-size: x-large;">
        LỊCH SỬ THAY ĐỔI GIÁ
    </div>
    <table width="100%" style="padding: 10px">
        <tr>
            <td style="text-align: left; vertical-align: middle; background-color: #e4e4e4;">Chọn loại sản phẩm:
            </td>
            <td style="vertical-align: middle; text-align: right">

                <asp:DropDownList ID="liGroup" runat="server" Height="30px" Width="300px" AutoPostBack="True" DataSourceID="groupDS" DataTextField="Name" DataValueField="IDGroup" OnSelectedIndexChanged="liGroup_SelectedIndexChanged">
                </asp:DropDownList>

                <asp:DropDownList ID="liProductType" runat="server" Height="30px" Width="300px" DataTextField="Name" DataValueField="IDProductType" OnSelectedIndexChanged="liProductType_SelectedIndexChanged" AutoPostBack="True">
                </asp:DropDownList>

                <asp:SqlDataSource ID="groupDS" runat="server" ConnectionString="<%$ ConnectionStrings:BTHGConnectionString %>" SelectCommand="SELECT [IDGroup], [Name] FROM [tbProductGroup] ORDER BY [Name]"></asp:SqlDataSource>

            </td>
        </tr>

        <tr>
            <td style="text-align: left; vertical-align: middle; background-color: #e4e4e4;">Chọn sản phẩm:
            </td>
            <td style="text-align: right; vertical-align: middle">

                <asp:DropDownList ID="liProduct" runat="server" Height="30px" Width="605px" DataTextField="Model" DataValueField="IDProduct" OnSelectedIndexChanged="liProduct_SelectedIndexChanged" AutoPostBack="True">
                </asp:DropDownList>

            </td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="2">

                <asp:GridView ID="GridView1" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeaderWhenEmpty="True" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
                    <Columns>
                        <asp:BoundField HeaderText="Ngày thay đổi" DataField="ChangeDate" DataFormatString="{0: dd/MM/yyyy HH:mm:ss}">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Giá cũ">
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Global.currencyFormat((double)Eval("FromPrice")) %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Giá mới">
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Global.currencyFormat((double)Eval("ToPrice")) %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Người thay đổi">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# getStaffName((int)Eval("IDStaff")) %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="White" ForeColor="#000066" />
                    <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                    <RowStyle ForeColor="#000066" />
                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#007DBB" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#00547E" />
                </asp:GridView>

            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: right; vertical-align: middle; background-color: #e4e4e4">

                &nbsp;</td>
        </tr>
    </table>
</asp:Content>

