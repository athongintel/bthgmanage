<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Director/Director.master" AutoEventWireup="true" CodeFile="AddSupplier.aspx.cs" Inherits="Manage_Director_AddSupplier" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div align="center" style="padding: 12px; color: #0066FF; font-size: x-large;">
        THÊM NHÀ CUNG CẤP
    </div>
    <asp:Panel runat="server" ID="pnNew">
                    <table width="100%" style="padding: 10px">
                        <tr>
                            <td style="vertical-align: middle; text-align: left; background-color: #e4e4e4; width: 150px;">Tên nhà cung cấp</td>
                            <td style="vertical-align: middle; text-align: right">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName" ForeColor="Red">*</asp:RequiredFieldValidator>
                                <asp:TextBox ID="txtName" runat="server" Width="90%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="vertical-align: middle; text-align: left; background-color: #e4e4e4; width: 150px;">Địa chỉ</td>
                            <td style="vertical-align: middle; text-align: right">

                                <asp:TextBox ID="txtAddress" runat="server" Width="90%"></asp:TextBox>

                            </td>
                        </tr>
                        <tr>
                            <td style="vertical-align: middle; text-align: left; background-color: #e4e4e4; width: 233px;">Điện thoại</td>
                            <td style="vertical-align: middle; text-align: right">
                                <asp:TextBox ID="txtTel" runat="server" Width="90%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="vertical-align: middle; text-align: left; background-color: #e4e4e4; width: 233px;">Website</td>
                            <td style="vertical-align: middle; text-align: right">
                                <asp:TextBox ID="txtWebsite" runat="server" Width="90%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="vertical-align: middle; text-align: left; background-color: #e4e4e4; width: 233px;">IBAN</td>
                            <td style="vertical-align: middle; text-align: right">

                                <asp:TextBox ID="txtIBAN" runat="server" Width="90%"></asp:TextBox>

                            </td>
                        </tr>
                        <tr>
                            <td style="vertical-align: middle; text-align: left; background-color: #e4e4e4; width: 150px;">Ngân hàng</td>
                            <td style="vertical-align: middle; text-align: right">

                                <asp:TextBox ID="txtBank" runat="server" Width="90%"></asp:TextBox>

                            </td>
                        </tr>
                        <tr>
                            <td style="vertical-align: middle; text-align: left; background-color: #e4e4e4; width: 150px;">Địa chỉ ngân hàng</td>
                            <td style="vertical-align: middle; text-align: right">

                                <asp:TextBox ID="txtBankAddress" runat="server" Width="90%"></asp:TextBox>

                            </td>
                        </tr>
                        <tr>
                            <td style="vertical-align: middle; text-align: left; background-color: #e4e4e4; width: 233px;">SWIFT</td>
                            <td style="vertical-align: middle; text-align: right">

                                <asp:TextBox ID="txtSWIFT" runat="server" Width="90%"></asp:TextBox>

                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" style="text-align: right; vertical-align: middle">

                                <asp:Button ID="btAdd" runat="server" Text="Thêm" Width="100px" OnClick="btAdd_Click" Height="30px" />

                            </td>
                        </tr>
                    </table>
                </asp:Panel>
</asp:Content>

