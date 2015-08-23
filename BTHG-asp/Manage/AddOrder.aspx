<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Manage.master" AutoEventWireup="true" CodeFile="AddOrder.aspx.cs" Inherits="Manage_Director_AddOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div align="center" style="padding: 12px; color: #0066FF; font-size: x-large;">
        TẠO BÁO GIÁ
    </div>
    <table width="100%">
        <tr>
            <td style="vertical-align: top" colspan="2">&nbsp;</td>
        </tr>
        <tr>
            <td style="background-color: #e4e4e4;">
                <asp:Label ID="Label9" runat="server" Text="Tên báo giá"></asp:Label>
            </td>
            <td style="vertical-align: middle; text-align: right">
                <asp:TextBox ID="txtOrderName" Width="100%" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td style="background-color: #e4e4e4;">
                <asp:Label ID="Label1" runat="server" Text="Chọn khách hàng"></asp:Label>
            </td>
            <td style="vertical-align: middle; text-align: right">
                <asp:DropDownList ID="liCustomer" runat="server" Height="25px" Width="400px" AutoPostBack="True" DataSourceID="customerDS" DataTextField="Name" DataValueField="IDCustomer" OnSelectedIndexChanged="liCustomer_SelectedIndexChanged">
                </asp:DropDownList>
                <asp:SqlDataSource ID="customerDS" runat="server" ConnectionString="<%$ ConnectionStrings:BTHGConnectionString %>" SelectCommand="SELECT [IDCustomer], [Name] FROM [tbCustomer] ORDER BY [Name]"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td style="background-color: #e4e4e4;">
                <asp:Label ID="Label2" runat="server" Text="Chọn người liên hệ"></asp:Label>
            </td>
            <td style="vertical-align: middle; text-align: right">
                <asp:DropDownList ID="liContact" runat="server" Height="25px" Width="200px" DataTextField="LastName" DataValueField="IDCustomerContact">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td style="background-color: #e4e4e4;">
                <asp:Label ID="Label3" runat="server" Text="Số báo giá"></asp:Label>
            </td>
            <td style="text-align: right">
                <asp:Label ID="lbOrderNumber" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td></td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: justify; vertical-align: top;">
                <table width="100%">
                    <tr>
                        <td style="vertical-align:top; width: 559px;">
                            <table>
                                <tr>
                                    <td style="background-color: #E4E4E4; width: 303px;">
                                        Nhóm sản phẩm
                                    </td>
                                    <td style="vertical-align: middle; text-align: right; width: 661px;">
                                        <asp:DropDownList ID="liGroup" runat="server" AutoPostBack="true" Height="25px" Width="100%" DataSourceID="groupDS" DataTextField="Name" DataValueField="IDGroup" OnSelectedIndexChanged="liGroup_SelectedIndexChanged">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="groupDS" runat="server" 
                                            ConnectionString="<%$ ConnectionStrings:BTHGConnectionString %>" 
                                            SelectCommand="SELECT [IDGroup], [Name] FROM [tbProductGroup] ORDER BY [Name]">
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="background-color: #E4E4E4; width: 303px;">
                                        <asp:Label ID="Label12" runat="server" Text="Loại"></asp:Label>
                                    </td>
                                    <td style="vertical-align: middle; text-align: right; width: 661px;">
                                        <asp:DropDownList ID="liType" runat="server" Height="25px" Width="100%" AutoPostBack="True" DataTextField="Name" DataValueField="IDProductType" OnSelectedIndexChanged="liType_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>

                                </tr>
                                <tr>
                                    <td style="background-color: #E4E4E4; width: 303px;">
                                        <asp:Label ID="Label8" runat="server" Text="Thương hiệu"></asp:Label>
                                    </td>
                                    <td style="vertical-align: middle; text-align: right; width: 661px;">
                                        <asp:DropDownList ID="liBrand" runat="server" Height="25px" Width="100%" DataTextField="Name" DataValueField="IDBrand" AutoPostBack="True" OnSelectedIndexChanged="liBrand_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="background-color: #E4E4E4; width: 303px;">
                                        <asp:Label ID="Label5" runat="server" Text="Model"></asp:Label>
                                    </td>
                                    <td style="vertical-align: middle; text-align: right; width: 661px;">
                                        <asp:DropDownList ID="liProduct" runat="server" Height="25px" Width="100%" DataTextField="Model" DataValueField="IDProduct" AutoPostBack="True" OnSelectedIndexChanged="liProduct_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td style="background-color: #E4E4E4; width: 303px;">
                                        <asp:Label ID="Label6" runat="server" Text="Số lượng"></asp:Label>
                                    </td>
                                    <td style="vertical-align: middle; text-align: right; width: 661px;">
                                        <asp:TextBox ID="txtQuantity" runat="server" Text="1" Width="95%"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtQuantity" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="background-color: #E4E4E4; width: 303px;">
                                        <asp:Label ID="Label4" runat="server" Text="Điều chỉnh giá (%)"></asp:Label>
                                    </td>
                                    <td style="vertical-align: middle; text-align: right; width: 661px;">
                                        <asp:TextBox ID="txtScale" runat="server" Width="95%">0</asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtScale" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="background-color: #E4E4E4; width: 303px;">
                                        <asp:Label ID="Label7" runat="server" Text="Ghi chú"></asp:Label>
                                    </td>
                                    <td style="vertical-align: middle; text-align: right; width: 661px;">
                                        <asp:TextBox ID="txtNote" runat="server" Text="" Width="100%"></asp:TextBox>
                                    </td>

                                </tr>
                                <tr>
                                    <td style="width: 303px"></td>
                                    <td style="vertical-align: middle; text-align: right; width: 661px;">
                                        <asp:Button ID="btAdd" runat="server" Text="Thêm vào" Width="123px" OnClick="btAdd_Click" Height="30px" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td style="vertical-align: text-top">
                            <table style="width:100%; height:100%">
                                <tr>
                                    <td style="vertical-align: middle; text-align: center; background-color: #e4e4e4;">
                                        Hình ảnh sản phẩm
                                    </td>
                                    <td style="vertical-align: middle; text-align: center; background-color: #e4e4e4;">
                                        Thông số kỹ thuật
                                    </td>
                                </tr>
                                <tr>
                                    <td style="border: thin dashed #C0C0C0;">
                                        <asp:Image ID="imgProduct" Width="200px" runat="server" />
                                    </td>
                                    <td style="text-align:justify; vertical-align:top">
                                        <asp:TextBox TextMode="MultiLine" ReadOnly="true" runat="server" ID="txtSpec" Width="200px" Height="200px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="vertical-align: middle; text-align: center; background-color: #e4e4e4;">Giá sản phẩm</td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="vertical-align: middle; text-align: center">
                                        <asp:Label runat="server" ID="lbPrice"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>

        <tr>
            <td style="vertical-align: top" colspan="2">
                <asp:GridView ID="gvProduct" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeaderWhenEmpty="True">
                    <Columns>
                        <asp:BoundField DataField="Order" HeaderText="STT" />
                        <asp:BoundField DataField="ProductType" HeaderText="Loại sản phẩm">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Model" HeaderText="Model" />
                        <asp:BoundField DataField="Quantity" HeaderText="Số lượng" />
                        <asp:TemplateField HeaderText="Giá trước điều chỉnh">                            
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Global.currencyFormat((double)Eval("Price")) %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="Scale" HeaderText="Mức điều chỉnh giá (%)">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Chênh lệch">                            
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Global.currencyFormat((double)Eval("Price")*(double)Eval("Scale")/100) %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="Note" HeaderText="Ghi chú" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="lkbRemove" Text='Xóa' OnClick="lkbRemove_Click" CommandArgument='<%#Eval("Order")%>'></asp:LinkButton>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle BackColor="#99CCFF" />
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td></td>
        </tr>
        <tr>
            <td style="background-color: #e4e4e4; height: 29px;">Điều khoản và điều kiện</td>
            <td style="text-align: right; height: 29px;">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:TextBox ID="txtTerms" Width="100%" Height="200px" TextMode="MultiLine" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td style="vertical-align: middle; text-align: left">
                <asp:Button ID="btSaveTerms" runat="server" Text="Lưu điều khoản mẫu (admin)" Width="204px" OnClick="btSaveTerms_Click" Height="30px" />
            </td>
            <td style="text-align: right;">&nbsp;
                <asp:Button ID="btSaveOrder" runat="server" OnClick="btSaveOrder_Click" Text="Lưu báo giá" Width="108px" Height="30px" />
            </td>
        </tr>
    </table>
</asp:Content>

