<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Director/Director.master" AutoEventWireup="true" CodeFile="Staff.aspx.cs" Inherits="Manage_Director_Staff" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div align="center" style="padding: 12px; color: #0066FF; font-size: x-large;">
        DANH SÁNH NHÂN VIÊN
    </div>
    <table width="100%">
        <tr>
            <td></td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="GridView1" Width="100%" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="IDStaff" DataSourceID="staffDS">
                    <Columns>
                        <asp:BoundField DataField="Name" HeaderText="Họ và tên" />
                        <asp:BoundField DataField="Position" HeaderText="Chức vụ" SortExpression="Position">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Email" SortExpression="Email">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Width="200px" Text='<%# Bind("Email") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("Email") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Tel" HeaderText="Điện thoại" SortExpression="Tel">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:TemplateField ShowHeader="False">
                            <EditItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="false" CommandName="Update" Text="Lưu"></asp:LinkButton>
                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Hủy"></asp:LinkButton>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Sửa"></asp:LinkButton>
                            </ItemTemplate>
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
                <asp:SqlDataSource ID="staffDS" runat="server" ConnectionString="<%$ ConnectionStrings:BTHGConnectionString %>"
                    DeleteCommand="DELETE FROM [tbStaff] WHERE [IDStaff] = @IDStaff"
                    InsertCommand="INSERT INTO [tbStaff] ([Name], [Position], [Email], [Tel]) VALUES (@Name, @Position, @Email, @Tel)"
                    SelectCommand="SELECT [IDStaff], [Name], [Position], [Email], [Tel] FROM [tbStaff]"
                    UpdateCommand="UPDATE [tbStaff] SET [Name] = @Name, [Position] = @Position, [Email] = @Email, [Tel] = @Tel WHERE [IDStaff] = @IDStaff">
                    <DeleteParameters>
                        <asp:Parameter Name="IDStaff" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="Name" Type="String" />
                        <asp:Parameter Name="Position" Type="String" />
                        <asp:Parameter Name="Email" Type="String" />
                        <asp:Parameter Name="Tel" Type="String" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="Name" Type="String" />
                        <asp:Parameter Name="Position" Type="String" />
                        <asp:Parameter Name="Email" Type="String" />
                        <asp:Parameter Name="Tel" Type="String" />
                        <asp:Parameter Name="IDStaff" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td style="text-align: right">
                <asp:Button ID="btCancel" runat="server" Text="Hủy" Visible="False" Width="150px" CausesValidation="false" OnClick="btCancel_Click" Height="30px" />
                <asp:Button ID="btAdd" runat="server" Text="Thêm nhân viên" Width="150px" OnClick="btAdd_Click" Height="30px" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Panel runat="server" ID="pnAdd" Visible="False">
                    <table width="100%">
                        <tr>
                            <td style="text-align: left; vertical-align: middle; background-color: #e4e4e4; width: 146px;">Họ và tên
                            </td>
                            <td style="text-align: right; vertical-align: middle">
                                <asp:TextBox ID="txtName" Width="80%" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName" ForeColor="Red">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: left; vertical-align: middle; background-color: #e4e4e4; width: 146px;">Chức vụ
                            </td>
                            <td style="text-align: right; vertical-align: middle">
                                <asp:TextBox ID="txtPosition" Width="80%" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtPosition" ForeColor="Red">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: left; vertical-align: middle; background-color: #e4e4e4; width: 146px;">Email
                            </td>
                            <td style="text-align: right; vertical-align: middle">
                                <asp:TextBox ID="txtEmail" Width="80%" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtEmail" ForeColor="Red">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: left; vertical-align: middle; background-color: #e4e4e4; width: 146px;">Điện thoại
                            </td>
                            <td style="text-align: right; vertical-align: middle">
                                <asp:TextBox ID="txtTel" Width="80%" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtTel" ForeColor="Red">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-align: right; vertical-align: middle">
                                <asp:Button ID="btAddStaff" runat="server" Text="Thêm" Width="100px" OnClick="btAddStaff_Click" Height="30px" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
    </table>
</asp:Content>

