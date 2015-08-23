<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Director/Director.master" AutoEventWireup="true" CodeFile="ProductType.aspx.cs" Inherits="Manage_Director_ProductType" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/Control/ProductGroup.ascx" TagPrefix="uc1" TagName="ProductGroup" %>



<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <cc1:TabContainer ID="TabContainer1" runat="server" AutoPostBack="true" Width="100%" ActiveTabIndex="2" OnActiveTabChanged="TabContainer1_ActiveTabChanged">
        <cc1:TabPanel ID="TabPanel3" runat="server" HeaderText="Nhóm sản phẩm">
            <ContentTemplate>
                <table width="100%">
                    <tr>
                        <td>

                        </td>
                        <td style="vertical-align: middle; text-align: right">
                            <asp:Button ID="btGroupCancel" runat="server" Text="Hủy" Height="30px" Width="150px" CausesValidation="False" OnClick="btGroupCancel_Click" Visible="False"  />
                            <asp:Button ID="btAddGroup" runat="server" Height="30px" Text="Thêm nhóm" Width="150px" CausesValidation="False" OnClick="btAddGroup_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:Panel runat="server" ID="pnGroup" Visible="False">
                                <table width="100%">
                                    <tr>
                                        <td style="width: 174px">
                                            Tên nhóm
                                        </td>
                                        <td style="vertical-align: middle; text-align: right">
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtGroupName" ForeColor="Red">*</asp:RequiredFieldValidator>
                                            <asp:TextBox ID="txtGroupName" runat="server" Width="90%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="vertical-align: middle; text-align: right">

                                            <asp:Button ID="btAddGroup2" runat="server" Height="30px" Text="Thêm" Width="150px" OnClick="btAddGroup2_Click" />

                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">

                            <asp:GridView ID="GridView3" runat="server" Width="100%" ShowHeaderWhenEmpty="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="IDGroup" DataSourceID="productgroupDS">
                                <Columns>
                                    <asp:BoundField DataField="Name" HeaderText="Tên nhóm" SortExpression="Name" >
                                    <HeaderStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:CommandField CancelText="Hủy" EditText="Sửa" ShowEditButton="True" UpdateText="Lưu" />
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

                            <asp:SqlDataSource ID="productgroupDS" runat="server" ConnectionString="<%$ ConnectionStrings:BTHGConnectionString %>" DeleteCommand="DELETE FROM [tbProductGroup] WHERE [IDGroup] = @IDGroup" InsertCommand="INSERT INTO [tbProductGroup] ([Name]) VALUES (@Name)" SelectCommand="SELECT [Name], [IDGroup] FROM [tbProductGroup] ORDER BY [Name]" UpdateCommand="UPDATE [tbProductGroup] SET [Name] = @Name WHERE [IDGroup] = @IDGroup">
                                <DeleteParameters>
                                    <asp:Parameter Name="IDGroup" Type="Int32" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="Name" Type="String" />
                                </InsertParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="Name" Type="String" />
                                    <asp:Parameter Name="IDGroup" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>

                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </cc1:TabPanel>
        <cc1:TabPanel runat="server" HeaderText="Loại sản phẩm" ID="TabPanel1">
            <ContentTemplate>
                <asp:Panel runat="server">
                    <div align="center">
                        <asp:Label ID="Label1" runat="server" Text="DANH MỤC LOẠI SẢN PHẨM" CssClass="bigfont"></asp:Label>
                    </div>

                    <br />
                    <table width="100%">
                        <tr>
                            <td>
                                Nhóm sản phẩm
                            </td>
                            <td style="width: 664px">

                                <asp:DropDownList ID="liGroup" runat="server" Height="25px" Width="100%" AutoPostBack="True" DataSourceID="groupDS" DataTextField="Name" DataValueField="IDGroup" OnSelectedIndexChanged="liGroup_SelectedIndexChanged">
                                </asp:DropDownList>

                                <asp:SqlDataSource ID="groupDS" runat="server" ConnectionString="<%$ ConnectionStrings:BTHGConnectionString %>" SelectCommand="SELECT [Name], [IDGroup] FROM [tbProductGroup] ORDER BY [Name]"></asp:SqlDataSource>

                            </td>
                            <td style="vertical-align: middle; text-align: right">

                                <asp:Button ID="btShowhide2" runat="server" Text="Thêm loại sản phẩm" CausesValidation="False" OnClick="btShowhide2_Click" Height="30px" Width="150px" />

                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <asp:Panel runat="server" ID="pnShowHide2" Visible="False">
                                    <table width="100%">
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label2" runat="server" Text="Tên sản phẩm"></asp:Label>
                                            </td>
                                            <td colspan="2">
                                                <asp:TextBox ID="txtProductType" runat="server" Height="20px" Width="300px"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtProductType" ForeColor="Red">*</asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td style="vertical-align: middle;" colspan="2">
                                                <asp:Button ID="btAddProductType" runat="server" Height="30px" OnClick="btAddProductType_Click" Text="Thêm" Width="150px" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <asp:GridView ID="GridView1" runat="server" ShowHeaderWhenEmpty="true" AutoGenerateColumns="False" DataKeyNames="IDProductType" DataSourceID="producttypeDS" Width="100%" CellPadding="4" ForeColor="#333333" GridLines="None">
                                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Nhóm sản phẩm" SortExpression="IDGroup">
                                            <EditItemTemplate>
                                                <uc1:ProductGroup runat="server" ID="ProductGroup" SelectedValue='<%# Bind("IDGroup") %>' />
                                            </EditItemTemplate>                                            
                                            <HeaderStyle HorizontalAlign="Left" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Name" SortExpression="Name" HeaderText="Tên loại sản phẩm" >
                                        <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:CommandField CancelText="Hủy" DeleteText="Xóa" EditText="Sửa" ShowEditButton="True" UpdateText="Lưu" />
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
                                <asp:SqlDataSource ID="producttypeDS" runat="server" ConnectionString="<%$ ConnectionStrings:BTHGConnectionString %>" SelectCommand="SELECT [IDProductType], [IDGroup], [Name] FROM [tbProductType] WHERE ([IDGroup] = @IDGroup) ORDER BY [Name]" DeleteCommand="DELETE FROM [tbProductType] WHERE [IDProductType] = @IDProductType" InsertCommand="INSERT INTO [tbProductType] ([IDGroup], [Name]) VALUES (@IDGroup, @Name)" UpdateCommand="UPDATE [tbProductType] SET [IDGroup] = @IDGroup, [Name] = @Name WHERE [IDProductType] = @IDProductType">
                                    <DeleteParameters>
                                        <asp:Parameter Name="IDProductType" Type="Int32" />
                                    </DeleteParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="IDGroup" Type="Int32" />
                                        <asp:Parameter Name="Name" Type="String" />
                                    </InsertParameters>
                                    <SelectParameters>
                                        <asp:FormParameter FormField="IDGroup" Name="IDGroup" Type="Int32" />
                                    </SelectParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="IDGroup" Type="Int32" />
                                        <asp:Parameter Name="Name" Type="String" />
                                        <asp:Parameter Name="IDProductType" Type="Int32" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </ContentTemplate>
        </cc1:TabPanel>
        <cc1:TabPanel ID="TabPanel2" runat="server" HeaderText="Thương hiệu">
            <ContentTemplate>
                <asp:Panel runat="server">
                    <div align="center">
                        <asp:Label ID="Label3" runat="server" Text="DANH SÁCH THƯƠNG HIỆU" CssClass="bigfont"></asp:Label>
                    </div>
                    <br />
                    <table width="100%">
                        <tr>
                            <td>
                                <div align="center" style="text-align: right; vertical-align: middle">
                                    <asp:Button runat="server" Text="Thêm thương hiệu" ID="btShowHide" OnClick="btShowHide_Click" CausesValidation="False" Width="150px" Height="30px"></asp:Button>
                                </div>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <asp:Panel runat="server" ID="pnAdd" Width="100%" Visible="False">
                                    <table width="100%">
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label4" runat="server" Text="Tên thương hiệu"></asp:Label></td>
                                            <td style="text-align: right; vertical-align: middle">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                                <asp:TextBox ID="txtName" runat="server" Width="90%" Height="20px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label5" runat="server" Text="Xuất xứ"></asp:Label></td>
                                            <td style="text-align: right; vertical-align: middle">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtOrigin" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                                <asp:TextBox ID="txtOrigin" runat="server" Height="20px" Width="90%"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td style="vertical-align: middle; text-align: right">
                                                <asp:Button ID="btAdd" runat="server" Text="Thêm" OnClick="btAdd_Click" Height="30px" Width="150px" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>

                        <tr>
                            <td>

                                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="IDBrand" DataSourceID="brandDS" ForeColor="#333333" GridLines="None" Width="100%" PageSize="5" ShowHeaderWhenEmpty="True">
                                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                    <Columns>
                                        <asp:BoundField DataField="Name" HeaderText="Tên thương hiệu" SortExpression="Name" >
                                        <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Origin" HeaderText="Xuất xứ" SortExpression="Origin">
                                            <HeaderStyle HorizontalAlign="Left" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:CommandField CancelText="Hủy" EditText="Sửa" ShowEditButton="True" UpdateText="Lưu" />
                                    </Columns>
                                    <EditRowStyle BackColor="#999999" />
                                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                    <PagerSettings Mode="NumericFirstLast" />
                                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                                </asp:GridView>
                                <asp:SqlDataSource ID="brandDS" runat="server" ConnectionString="<%$ ConnectionStrings:BTHGConnectionString %>"
                                    DeleteCommand="DELETE FROM [tbBrand] WHERE [IDBrand] = @IDBrand"
                                    InsertCommand="INSERT INTO [tbBrand] ([Name], [Origin]) VALUES (@Name, @Origin)"
                                    SelectCommand="SELECT [IDBrand], [Name], [Origin] FROM [tbBrand] ORDER BY [Name]"
                                    UpdateCommand="UPDATE [tbBrand] SET [Name] = @Name, [Origin] = @Origin WHERE [IDBrand] = @IDBrand">
                                    <DeleteParameters>
                                        <asp:Parameter Name="IDBrand" Type="Int32" />
                                    </DeleteParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="Name" Type="String" />
                                        <asp:Parameter Name="Origin" Type="String" />
                                    </InsertParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="Name" Type="String" />
                                        <asp:Parameter Name="Origin" Type="String" />
                                        <asp:Parameter Name="IDBrand" Type="Int32" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                            </td>
                        </tr>



                    </table>
                </asp:Panel>
            </ContentTemplate>
        </cc1:TabPanel>
    </cc1:TabContainer>

</asp:Content>

