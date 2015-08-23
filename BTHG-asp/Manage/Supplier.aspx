<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Manage.master" AutoEventWireup="true" CodeFile="Supplier.aspx.cs" Inherits="Manage_Director_Supplier" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div align="center" style="padding: 12px; color: #0066FF; font-size: x-large;">
        DANH SÁCH NHÀ CUNG CẤP
    </div>
    <table width="100%" style="margin: 10px; padding: 10px;">
        <tr>
            <td style="vertical-align: middle; text-align: left; background-color: #e4e4e4; width: 245px;">Chọn nhà cung cấp</td>
            <td style="width: 523px; vertical-align: middle; text-align: right;">
                <asp:DropDownList ID="liSupplier" runat="server" Height="25px" Width="250px" DataSourceID="supplierDS" DataTextField="Name" DataValueField="IDSupplier" AutoPostBack="True" OnSelectedIndexChanged="liSupplier_SelectedIndexChanged"></asp:DropDownList>
                <asp:SqlDataSource ID="supplierDS" runat="server" ConnectionString="<%$ ConnectionStrings:BTHGConnectionString %>" SelectCommand="SELECT [IDSupplier], [Name] FROM [tbSupplier] ORDER BY [Name]"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td style="width: 245px"></td>
        </tr>
        <tr>
            <td style="text-align: left; vertical-align: middle; background-color: #e4e4e4; width: 245px;">Tên nhà cung cấp
            </td>
            <td style="vertical-align: middle; text-align: left;">

                <asp:Label ID="lbName" runat="server" Text=""></asp:Label>

                <asp:TextBox ID="txtEditName" Width="90%" runat="server" Visible="False"></asp:TextBox>

                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtEditName" ForeColor="Red" Visible="False">*</asp:RequiredFieldValidator>

            </td>
        </tr>
        <tr>
            <td style="text-align: left; vertical-align: middle; background-color: #e4e4e4; width: 245px;">Địa chỉ
            </td>
            <td style="vertical-align: middle; text-align: left;">

                <asp:Label ID="lbAddress" runat="server" Text=""></asp:Label>

                <asp:TextBox ID="txtEditAddress" runat="server" Width="90%" Visible="False"></asp:TextBox>

            </td>
        </tr>
        <tr>
            <td style="vertical-align: middle; text-align: left; background-color: #e4e4e4; width: 245px;">Số điện thoại</td>
            <td style="vertical-align: middle; text-align: left;">

                <asp:Label ID="lbTel" runat="server" Text=""></asp:Label>

                <asp:TextBox ID="txtEditTel" runat="server" Width="90%" Visible="False"></asp:TextBox>

            </td>
        </tr>
        <tr>

            <td style="vertical-align: middle; text-align: left; background-color: #e4e4e4; width: 245px;">Website</td>
            <td style="vertical-align: middle; text-align: left;">

                <asp:Label ID="lbWebsite" runat="server" Text=""></asp:Label>

                <asp:TextBox ID="txtEditWebsite" runat="server" Width="90%" Visible="False"></asp:TextBox>

            </td>
        </tr>
        <tr>
            <td style="vertical-align: middle; text-align: left; background-color: #e4e4e4; width: 245px;">IBAN</td>
            <td style="vertical-align: middle; text-align: left;">

                <asp:Label ID="lbIBAN" runat="server" Text=""></asp:Label>

                <asp:TextBox ID="txtEditIBAN" runat="server" Width="90%" Visible="False"></asp:TextBox>

            </td>
        </tr>
        <tr>
            <td style="text-align: left; vertical-align: middle; background-color: #e4e4e4; width: 245px;">Ngân hàng
            </td>
            <td style="vertical-align: middle; text-align: left;">

                <asp:Label ID="lbBank" runat="server" Text=""></asp:Label>

                <asp:TextBox ID="txtEditBank" runat="server" Width="90%" Visible="False"></asp:TextBox>

            </td>
        </tr>
        <tr>
            <td style="text-align: left; vertical-align: middle; background-color: #e4e4e4; width: 245px;">Địa chỉ ngân hàng
            </td>
            <td style="vertical-align: middle; text-align: left;">

                <asp:Label ID="lbBankAddress" runat="server" Text=""></asp:Label>

                <asp:TextBox ID="txtEditBankAddress" runat="server" Width="90%" Visible="False"></asp:TextBox>

            </td>
        </tr>

        <tr>

            <td style="vertical-align: middle; text-align: left; background-color: #e4e4e4; width: 245px;">SWIFT</td>
            <td style="vertical-align: middle; text-align: left;">

                <asp:Label ID="lbSWIFT" runat="server" Text=""></asp:Label>

                <asp:TextBox ID="txtEditSWIFT" runat="server" Width="90%" Visible="False"></asp:TextBox>

            </td>
        </tr>




        <tr>
            <td style="width: 245px"></td>
        </tr>
        <tr>
            <td style="text-align: left; vertical-align: middle">&nbsp;</td>
            <td style="vertical-align: middle; text-align: right; height: 23px;">

                <asp:Button ID="btEdit" runat="server" Text="Sửa (admin)" Width="100px" OnClick="btEdit_Click" Visible="False" Height="30px" />

                <asp:Button ID="btSave" runat="server" Text="Lưu" Width="100px" Visible="False" OnClick="btSave_Click" Height="30px" />

                <asp:Button ID="btCancel" runat="server" Text="Hủy" Width="100px" Visible="False" OnClick="btCancel_Click" CausesValidation="false" Height="30px" />

            </td>
        </tr>
        <tr>
            <td></td>
        </tr>
        <tr>
            <td colspan="4">


                <asp:GridView ID="GridView1" ShowHeaderWhenEmpty="True" runat="server" AutoGenerateColumns="False" BackColor="White" Width="100%" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="IDSupplierContact" DataSourceID="supplierContactDS">
                    <Columns>
                        <asp:BoundField DataField="Name" HeaderText="Tên liên hệ" SortExpression="Name">
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Tel" HeaderText="Số điện thoại" SortExpression="Tel" ConvertEmptyStringToNull="false">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" ConvertEmptyStringToNull="false">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:TemplateField ShowHeader="False">
                            <EditItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Lưu"></asp:LinkButton>
                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Hủy"></asp:LinkButton>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" Visible='<%# Global.isAdmin() %>' CausesValidation="False" CommandName="Edit" Text="Sửa"></asp:LinkButton>
                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" Visible='<%# Global.isAdmin() %>' CausesValidation="False" CommandName="Delete" Text="Xóa"></asp:LinkButton>
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

                <asp:SqlDataSource ID="supplierContactDS" runat="server" ConnectionString="<%$ ConnectionStrings:BTHGConnectionString %>" 
                    DeleteCommand="DELETE FROM [tbSupplierContact] WHERE [IDSupplierContact] = @IDSupplierContact"                     
                    SelectCommand="SELECT [IDSupplierContact], [IDSupplier], [Name], [Tel], [Email] FROM [tbSupplierContact] WHERE ([IDSupplier] = @IDSupplier) ORDER BY [Name]" 
                    UpdateCommand="UPDATE [tbSupplierContact] SET [Name] = @Name, [Tel] = @Tel, [Email] = @Email WHERE [IDSupplierContact] = @IDSupplierContact">
                    <DeleteParameters>
                        <asp:Parameter Name="IDSupplierContact" Type="Int32" />
                    </DeleteParameters>
                    <SelectParameters>
                        <asp:FormParameter FormField="IDSupplier" Name="IDSupplier" Type="Int32" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="IDSupplier" Type="Int32" />
                        <asp:Parameter Name="Name" Type="String" />
                        <asp:Parameter Name="Tel" Type="String" />
                        <asp:Parameter Name="Email" Type="String" />
                        <asp:Parameter Name="IDSupplierContact" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>

            </td>
        </tr>
        <tr>
            <td></td>
            <td style="vertical-align: middle; text-align: right">
                <asp:Button ID="btCancelAdd" runat="server" Text="Hủy" Width="150px" CausesValidation="false" Height="30px" Visible="False" Style="margin-bottom: 0px" OnClick="btCancelAdd_Click" />
                <asp:Button ID="btAddContact" runat="server" Text="Thêm liên hệ (admin)" Width="150px" Height="30px" CausesValidation="false" Visible="False" OnClick="btAddContact_Click" />
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Panel runat="server" ID="pnAdd" Visible="False">
                    <table width="100%">
                        <tr>
                            <td style="vertical-align: middle; text-align: left; background-color: #e4e4e4">Tên liên hệ
                            </td>
                            <td style="vertical-align: middle; text-align: right">

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName" ForeColor="Red">*</asp:RequiredFieldValidator>

                                <asp:TextBox ID="txtName" runat="server" Height="20px" Width="90%"></asp:TextBox>

                            </td>
                        </tr>
                        <tr>
                            <td style="vertical-align: middle; text-align: left; background-color: #e4e4e4">Số điện thoại
                            </td>
                            <td style="vertical-align: middle; text-align: right">

                                <asp:TextBox ID="txtTel" runat="server" Height="20px" Width="90%"></asp:TextBox>

                            </td>
                        </tr>
                        <tr>
                            <td style="vertical-align: middle; text-align: left; background-color: #e4e4e4">Email
                            </td>
                            <td style="vertical-align: middle; text-align: right">

                                <asp:TextBox ID="txtEmail" runat="server" Height="20px" Width="90%"></asp:TextBox>

                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td style="vertical-align: middle; text-align: right">

                                <asp:Button ID="btAdd" runat="server" Text="Thêm" Width="150px" Height="30px" OnClick="btAdd_Click" />

                            </td>
                        </tr>

                    </table>
                </asp:Panel>
            </td>
        </tr>
    </table>
</asp:Content>

