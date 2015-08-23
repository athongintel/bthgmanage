<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Director/Director.master" AutoEventWireup="true" CodeFile="Account.aspx.cs" Inherits="Manage_Director_Account" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div align="center" style="padding: 12px; color: #0066FF; font-size: large;">
        DANH SÁCH TÀI KHOẢN ĐĂNG NHẬP
    </div>
    <table width="100%">
        <tr>
            <td></td>
        </tr>
        <tr>
            <td>

                <asp:GridView ID="GridView1" Width="100%" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="Username" DataSourceID="loginDS">
                    <Columns>
                        <asp:BoundField DataField="Username" HeaderText="Tên đăng nhập" ReadOnly="True" SortExpression="Username">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Mật khẩu" SortExpression="Password">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtPassword" runat="server" Text='<%# Bind("Password") %>' TextMode="Password"></asp:TextBox>
                                </asp:CustomValidator><asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtPassword" runat="server" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>                                
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Global.censorPassword((string)Eval("Password")) %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Nhân viên" SortExpression="IDStaff">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Global.getStaffName((int)Eval("IDStaff")) %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Quyền" SortExpression="Role">
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("Role") %>'>
                                    <asp:ListItem Value="2">Admin</asp:ListItem>
                                    <asp:ListItem Value="1">Thư ký</asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Global.getRoleName((int)Eval("Role")) %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:CommandField CancelText="Hủy" DeleteText="Xóa" EditText="Sửa" ShowDeleteButton="True" ShowEditButton="True" UpdateText="Lưu">
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

                <asp:SqlDataSource ID="loginDS" runat="server" ConnectionString="<%$ ConnectionStrings:BTHGConnectionString %>"
                    DeleteCommand="DELETE FROM [tbLogin] WHERE [Username] = @Username"
                    SelectCommand="SELECT [Password], [Username], [IDStaff], [Role] FROM [tbLogin]"
                    UpdateCommand="UPDATE [tbLogin] SET [Password] = @Password, [Role] = @Role WHERE [Username] = @Username">
                    <DeleteParameters>
                        <asp:Parameter Name="Username" Type="String" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="Password" Type="String" />
                        <asp:Parameter Name="IDStaff" Type="Int32" />
                        <asp:Parameter Name="Role" Type="Int32" />
                        <asp:Parameter Name="Username" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>

            </td>
        </tr>
        <tr>
            <td style="vertical-align: middle; text-align: right">
                <asp:Button ID="btCancel" runat="server" Width="150px" Text="Hủy" CausesValidation="false" Visible="False" OnClick="btCancel_Click" Height="30px" />
                <asp:Button ID="btAdd" runat="server" Width="150px" Text="Thêm tài khoản" OnClick="btAdd_Click" Height="30px" />
            </td>
        </tr>
        <tr>
            <td>
                <table width="100%">
                    <tr>
                        <td>
                            <asp:Panel runat="server" ID="pnAdd" Visible="False">
                                <table width="100%">
                                    <tr>
                                        <td style="vertical-align: middle; text-align: left; background-color: #e4e4e4; width: 211px;">
                                            Tên đăng nhập
                                        </td>
                                        <td style="vertical-align: middle; text-align: right">
                                            <asp:TextBox ID="txtUsername" Width="80%" runat="server" AutoCompleteType="None"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Text="*" ForeColor="Red" ControlToValidate="txtUsername"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="vertical-align: middle; text-align: left; background-color: #e4e4e4; width: 211px;">
                                            Mật khẩu
                                        </td>
                                        <td style="vertical-align: middle; text-align: right">
                                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Width="80%" AutoCompleteType="None"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Text="*" ControlToValidate="txtPassword" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="vertical-align: middle; text-align: left; background-color: #e4e4e4; width: 211px;">
                                            Xác nhận mật khẩu
                                        </td>
                                        <td style="vertical-align: middle; text-align: right">
                                            <asp:TextBox ID="txtRePassword" runat="server" TextMode="Password" Width="80%"></asp:TextBox>
                                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtPassword" ControlToValidate="txtRePassword" ForeColor="Red">*</asp:CompareValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="vertical-align: middle; text-align: left; background-color: #e4e4e4; width: 211px;">
                                            Nhân viên sử dụng
                                        </td>
                                        <td style="vertical-align: middle; text-align: right">
                                            <asp:DropDownList ID="liStaff" runat="server" Height="25px" Width="80%" DataSourceID="staffDS" DataTextField="Name" DataValueField="IDStaff">
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="staffDS" runat="server" ConnectionString="<%$ ConnectionStrings:BTHGConnectionString %>" SelectCommand="SELECT [IDStaff], [Name] FROM [tbStaff]"></asp:SqlDataSource>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="vertical-align: middle; text-align: left; background-color: #e4e4e4; height: 23px; width: 211px;">
                                            Quyền
                                        </td>
                                        <td style="vertical-align: middle; text-align: right;">
                                            <asp:DropDownList ID="liRole" Width="80%" Height="25px" runat="server">
                                                <asp:ListItem Value="2">Admin</asp:ListItem>
                                                <asp:ListItem Value="1">Thư ký</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="vertical-align: middle; text-align: right">
                                            <asp:Button ID="btAddAccount" runat="server" Text="Thêm" Width="100px" OnClick="btAddAccount_Click" Height="30px" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>

