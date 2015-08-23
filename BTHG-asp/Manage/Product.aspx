<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Manage.master" AutoEventWireup="true" CodeFile="Product.aspx.cs" Inherits="Manage_Director_Product" %>

<%@ Register src="../Control/ProductGroup.ascx" tagname="ProductGroup" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Panel runat="server">
        <div align="center" style="padding: 12px; color: #0066FF; font-size: x-large;">
        DANH SÁCH SẢN PHẨM</div>
        <div align="center">
            <table width="100%">
                <tr>
                    <td style="text-align: left" colspan="2">
                        <asp:RadioButton ID="rbShowAll" runat="server" Text="Hiển thị tất cả" GroupName="grSearcch" />
                    </td>

                    <td rowspan="3" style="text-align: center">
                        <asp:Button ID="btFindProduct" runat="server" Text="Tìm" OnClick="btFindProduct_Click" Width="100px" Height="100px" />
                    </td>
                </tr>
                <tr>
                    <td style="text-align: left; vertical-align: top;">
                        <asp:RadioButton ID="rbShowByType" runat="server" Text="Tìm theo loại sản phẩm" GroupName="grSearcch" Checked="True" />
                    </td>
                    <td style="text-align: left">
                        <asp:DropDownList ID="liGroup" runat="server" DataSourceID="groupDS" DataTextField="Name" DataValueField="IDGroup" Height="30px" Width="300px" AutoPostBack="True" OnSelectedIndexChanged="liGroup_SelectedIndexChanged">
                        </asp:DropDownList>
                        <asp:DropDownList ID="liType" runat="server" Height="30px" Width="300px" AutoPostBack="True" DataTextField="Name" DataValueField="IDProductType" OnSelectedIndexChanged="liType_SelectedIndexChanged">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="groupDS" runat="server" ConnectionString="<%$ ConnectionStrings:BTHGConnectionString %>" SelectCommand="SELECT [IDGroup], [Name] FROM [tbProductGroup] ORDER BY [Name]"></asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: left; vertical-align: middle; text-indent: 30px;">- Thương hiệu</td>
                    <td style="vertical-align: middle; text-align: left">
                        <asp:DropDownList ID="liBrand" runat="server" Height="30px" Width="605px" DataTextField="Name" DataValueField="IDBrand"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:GridView ID="GridView1" runat="server" Width="100%" ShowHeaderWhenEmpty="True" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <Columns>
                                <asp:TemplateField HeaderText="Loại sản phẩm">   
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" Text='<%# Global.getProductTypeName((int)Eval("IDProductType")) %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Thương hiệu">                                   
                                    <ItemTemplate>
                                        <asp:Label ID="Label3" runat="server" Text='<%# Global.getBrandName((int)Eval("IDBrand")) %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Model">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="Label2" runat="server" Text='<%# Eval("Model") %>' NavigateUrl='<%# "~/Manage/ProductDetail.aspx?mode=view&IDProduct=" + Eval("IDProduct")%>'></asp:HyperLink>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="Tồn kho" DataField="AvailableNumber">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Giá">
                                    <ItemTemplate>
                                        <asp:Label ID="lbprice" runat="server" Text='<%# Global.currencyFormat((double)Eval("Price")) %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:TemplateField>
                            </Columns>
                            <EditRowStyle BackColor="#999999" />
                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#E9E7E2" />
                            <SortedAscendingHeaderStyle BackColor="#506C8C" />
                            <SortedDescendingCellStyle BackColor="#FFFDF8" />
                            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                        </asp:GridView>
                    </td>
                </tr>
            </table>
        </div>
    </asp:Panel>
</asp:Content>

