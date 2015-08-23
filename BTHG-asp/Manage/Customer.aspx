<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Manage.master"
    AutoEventWireup="true" CodeFile="Customer.aspx.cs" Inherits="Manage_Director_Customer" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/Control/ListCustomer.ascx" TagName="ListCustomer" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <style type="text/css">
        .biginfo {
            font-size: 20px;
            color: Teal;
        }

        .auto-style1 {
            width: 150px;
        }

        .auto-style2 {
            width: 143px;
        }
    </style>
    <asp:Panel runat="server">
        <div align="center" style="padding: 12px; color: #0066FF; font-size: x-large;">
            THÔNG TIN KHÁCH HÀNG
        </div>
        <cc1:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0" Width="100%"
            OnActiveTabChanged="tabchanged" AutoPostBack="true">
            <cc1:TabPanel ID="TabPanel3" runat="server" HeaderText="Thông tin khách hàng">
                <ContentTemplate>
                    <table width="100%">
                        <tr>
                            <td>
                                <asp:Label ID="Label6" runat="server" Text="Chọn khách hàng"></asp:Label></td>
                        </tr>
                        <tr>
                            <td>
                                <uc1:ListCustomer runat="server" ID="listCustomer2" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div align="center"></div>
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp</td>
                        </tr>
                        <tr>
                            <td>
                                <table width="100%">
                                    <tr>
                                        <td style="background-color: #e4e4e4" class="auto-style1">
                                            <asp:Label ID="Label7" runat="server" Text="Tên khách hàng" Font-Names="Arial"></asp:Label></td>
                                        <td>
                                            <asp:Label ID="lbCustomerName" runat="server" Font-Bold="False" Font-Size="11pt" ForeColor="Blue" Font-Names="Arial"></asp:Label>
                                            <asp:TextBox ID="txtEditName" runat="server" Visible="False" Width="100%"></asp:TextBox>
                                        </td>
                                        <td style="background-color: #e4e4e4" class="auto-style2">
                                            <asp:Label ID="Label13" runat="server" Text="Mã khách hàng" Font-Names="Arial"></asp:Label></td>
                                        <td>
                                            <asp:Label ID="lbCustomerCode" runat="server" Font-Bold="False" Font-Size="11pt" ForeColor="Black" Font-Names="Arial"></asp:Label>
                                            <asp:TextBox ID="txtEditCode" runat="server" Visible="False" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="background-color: #e4e4e4" class="auto-style1">
                                            <asp:Label ID="Label8" runat="server" Text="Số điện thoại" Font-Names="Arial"></asp:Label></td>
                                        <td>
                                            <asp:Label ID="lbTel" runat="server" Font-Size="11pt" Font-Bold="False" Font-Names="Arial" ForeColor="Black"></asp:Label><asp:TextBox ID="txtEditTel" runat="server" Width="100%" Visible="False"></asp:TextBox></td>
                                        <td style="background-color: #e4e4e4" class="auto-style2">
                                            <asp:Label ID="Label9" runat="server" Text="Số Fax" Font-Names="Arial"></asp:Label></td>
                                        <td>
                                            <asp:Label ID="lbFax" runat="server" Font-Size="11pt" ForeColor="Black" Font-Bold="False" Font-Names="Arial"></asp:Label><asp:TextBox ID="txtEditFax" runat="server" Width="100%" Visible="False"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td style="background-color: #e4e4e4" class="auto-style1">
                                            <asp:Label ID="Labelx" runat="server" Text="Mã số thuế" Font-Names="Arial"></asp:Label></td>
                                        <td>
                                            <asp:Label ID="lbTaxNumber" runat="server" Font-Bold="False" Font-Size="11pt" ForeColor="Black" Font-Names="Arial"></asp:Label><asp:TextBox ID="txtEditTax" runat="server" Width="100%" Visible="False"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td style="background-color: #e4e4e4" class="auto-style1">
                                            <asp:Label ID="Label10" runat="server" Text="Địa chỉ" Font-Names="Arial"></asp:Label></td>
                                        <td colspan="4">
                                            <asp:Label ID="lbAddress" runat="server" Font-Bold="False" Font-Names="Arial" Font-Size="11pt" ForeColor="Black"></asp:Label><asp:TextBox ID="txtEditAddress" runat="server" Width="100%" Visible="False"></asp:TextBox></td>
                                        <td>&nbsp;</td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right; vertical-align: middle">
                                <asp:Button ID="btEdit" runat="server" Text="Sửa (admin)" Width="100px" OnClick="btEdit_Click" Visible="False" Height="30px" />&nbsp;
                                <asp:Button ID="btSave" runat="server" Text="Lưu" Width="100px" OnClick="btSave_Click" Visible="False" Height="30px" />&nbsp;
                                <asp:Button ID="btCancel" runat="server" Text="Hủy" Width="100px" OnClick="btCancel_Click1" Visible="False" Height="30px" /></td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <div align="center">
                                    <asp:Label ID="Label12" runat="server" Text="DANH SÁCH NGƯỜI LIÊN HỆ" CssClass="bigfont" Font-Size="12pt"></asp:Label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:GridView ID="gvContact" runat="server" AutoGenerateColumns="False" CellPadding="3"
                                    DataKeyNames="IDCustomerContact"
                                    ShowHeaderWhenEmpty="True" Width="100%" DataSourceID="contactDS" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Họ tên" SortExpression="FirstName">
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="liTitle" Height="25px" Width="90%" SelectedValue='<%# Bind("Title") %>' runat="server">
                                                    <asp:ListItem>Mr.</asp:ListItem>
                                                    <asp:ListItem>Ms.</asp:ListItem>
                                                    <asp:ListItem>Mrs.</asp:ListItem>
                                                </asp:DropDownList> 
                                                <br />
                                                Họ: &nbsp;<asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("FirstName") %>'></asp:TextBox>
                                                <br />
                                                Tên: <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("LastName") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("Title") + "" +Eval("FirstName") +" " +Eval("LastName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Position" HeaderText="Chức vụ" SortExpression="Position" >
                                        <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Tel" HeaderText="Điện thoại" SortExpression="Tel" >
                                        <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                                        <asp:BoundField DataField="Commission" HeaderText="Hoa hồng" SortExpression="Commission" >
                                        <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:CommandField ShowEditButton="True" CancelText="Hủy" EditText="Sửa" UpdateText="Lưu" >
                                        <ItemStyle HorizontalAlign="Center" />
                                        </asp:CommandField>
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
                                <asp:SqlDataSource ID="contactDS" runat="server"
                                    ConnectionString="<%$ ConnectionStrings:BTHGConnectionString %>"
                                    OldValuesParameterFormatString="original_{0}"
                                    SelectCommand="SELECT * FROM [tbCustomerContact] WHERE ([IDCustomer] = @IDCustomer)"
                                    UpdateCommand="UPDATE [tbCustomerContact] SET [FirstName] = @FirstName, [LastName] = @LastName, [Title] = @Title, [Position] = @Position, [Tel] = @Tel, [Email] = @Email, [Commission] = @Commission WHERE [IDCustomerContact] = @original_IDCustomerContact" DeleteCommand="DELETE FROM [tbCustomerContact] WHERE [IDCustomerContact] = @original_IDCustomerContact" InsertCommand="INSERT INTO [tbCustomerContact] ([IDCustomer], [FirstName], [LastName], [Title], [Position], [Tel], [Email], [Commission]) VALUES (@IDCustomer, @FirstName, @LastName, @Title, @Position, @Tel, @Email, @Commission)">
                                    <DeleteParameters>
                                        <asp:Parameter Name="original_IDCustomerContact" Type="Int32" />
                                    </DeleteParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="IDCustomer" Type="Int32" />
                                        <asp:Parameter Name="FirstName" Type="String" />
                                        <asp:Parameter Name="LastName" Type="String" />
                                        <asp:Parameter Name="Title" Type="String" />
                                        <asp:Parameter Name="Position" Type="String" />
                                        <asp:Parameter Name="Tel" Type="String" />
                                        <asp:Parameter Name="Email" Type="String" />
                                        <asp:Parameter Name="Commission" Type="Int32" />
                                    </InsertParameters>
                                    <SelectParameters>
                                        <asp:FormParameter DefaultValue="" FormField="IDCustomer" Name="IDCustomer" Type="Int32" />
                                    </SelectParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="IDCustomer" Type="Int32" />
                                        <asp:Parameter Name="FirstName" Type="String" />
                                        <asp:Parameter Name="LastName" Type="String" />
                                        <asp:Parameter Name="Title" Type="String" />
                                        <asp:Parameter Name="Position" Type="String" />
                                        <asp:Parameter Name="Tel" Type="String" />
                                        <asp:Parameter Name="Email" Type="String" />
                                        <asp:Parameter Name="Commission" Type="Int32" />
                                        <asp:Parameter Name="original_IDCustomerContact" Type="Int32" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right; vertical-align: middle;">
                                <br />
                                <asp:Button ID="btAddContact" runat="server" Text="Thêm người liên hệ (admin)" Width="200px" Height="30px" OnClick="btAdd_Click" CausesValidation="False" Visible="False" /><br />
                            </td>
                            <caption>
                                <br />
                            </caption>
                        </tr>
                        <tr>
                            <td>
                                <asp:Panel runat="server" ID="pnAdd" Width="100%" Visible="False">
                                    <table width="100%">
                                        <tr>
                                            <td style="background-color: #e4e4e4; text-align: left; vertical-align: middle">
                                                <asp:Label ID="Label2" runat="server" Text="Họ"></asp:Label></td>
                                            <td style="vertical-align: middle; text-align: right" colspan="2">
                                                <asp:TextBox ID="txtFirstName" runat="server" Width="90%" Height="25px" Font-Size="12pt"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td style="background-color: #e4e4e4; text-align: left; vertical-align: middle">
                                                <asp:Label ID="Label11" runat="server" Text="Tên"></asp:Label></td>
                                            <td style="vertical-align: middle; text-align: right" colspan="2">
                                                <asp:TextBox ID="txtLastName" runat="server" Width="90%" Height="25px" Font-Size="12pt"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td style="background-color: #e4e4e4; text-align: left; vertical-align: middle">
                                                <asp:Label ID="Label16" runat="server" Text="Danh xưng"></asp:Label>

                                            </td>
                                            <td style="text-align: right; vertical-align: middle">
                                                <asp:DropDownList ID="liTitle" Height="25px" Width="90%" runat="server" Font-Size="12pt">
                                                    <asp:ListItem>Mr.</asp:ListItem>
                                                    <asp:ListItem>Ms.</asp:ListItem>
                                                    <asp:ListItem>Mrs.</asp:ListItem>
                                                </asp:DropDownList>                                            
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="background-color: #e4e4e4; text-align: left; vertical-align: middle">
                                                <asp:Label ID="Label4" runat="server" Text="Chức vụ"></asp:Label></td>
                                            <td style="vertical-align: middle; text-align: right" colspan="2">
                                                <asp:TextBox ID="tbPosition" runat="server" Height="25px" Width="90%" Font-Size="12pt"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td style="background-color: #e4e4e4; text-align: left; vertical-align: middle">
                                                <asp:Label ID="Label3" runat="server" Text="Số điện thoại"></asp:Label></td>
                                            <td style="vertical-align: middle; text-align: right" colspan="2">
                                                <asp:TextBox ID="tbTel" runat="server" Height="25px" Width="90%" Font-Size="12pt"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td style="background-color: #e4e4e4; text-align: left; vertical-align: middle">
                                                <asp:Label ID="Label14" runat="server" Text="Email"></asp:Label></td>
                                            <td style="vertical-align: middle; text-align: right" colspan="2">
                                                <asp:TextBox ID="tbEmail" runat="server" Height="25px" Width="90%" Font-Size="12pt"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td style="background-color: #e4e4e4; text-align: left; vertical-align: middle">
                                                <asp:Label ID="Label5" runat="server" Text="Hoa hồng"></asp:Label></td>
                                            <td style="vertical-align: middle; text-align: right" colspan="2">
                                                <asp:TextBox ID="tbCommission" runat="server" Height="25px" Width="90%" Font-Size="12pt">0</asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:Label ID="Label15" runat="server" Text="%"></asp:Label>

                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td style="text-align: right">
                                                <asp:Button ID="btAdd" runat="server" Text="Thêm" OnClick="btAddContact_Click" Height="30px" Width="100px" /></td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </cc1:TabPanel>            
        </cc1:TabContainer>
    </asp:Panel>
</asp:Content>
