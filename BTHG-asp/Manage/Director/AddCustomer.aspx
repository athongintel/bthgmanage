<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Director/Director.master" AutoEventWireup="true" CodeFile="AddCustomer.aspx.cs" Inherits="Manage_Director_AddCustomer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:Panel runat="server">
        <div align="center" style="padding: 12px; color: #0066FF; font-size: x-large;">
            THÊM KHÁCH HÀNG
        </div>
        <br />
        <table width="100%">
            <tr>
                <td class="auto-style2" style="text-align: left; vertical-align: middle; background-color: #e4e4e4; width: 19%;">
                    <asp:Label ID="Label2" runat="server" Text="Tên khách hàng"></asp:Label>
                </td>
                <td style="vertical-align: middle; text-align: right">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="txtName" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:TextBox ID="txtName" runat="server" Font-Size="12pt" Height="25px" Width="90%"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style2" style="text-align: left; vertical-align: middle; background-color: #e4e4e4; width: 19%;">
                    <asp:Label ID="Label7" runat="server" Text="Mã khách hàng"></asp:Label>
                </td>
                <td style="vertical-align: middle; text-align: right">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="*" ControlToValidate="txtCustomerCode" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:TextBox ID="txtCustomerCode" runat="server" Font-Size="12pt" Height="25px" Width="90%"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style2" style="text-align: left; vertical-align: middle; background-color: #e4e4e4; width: 19%;">
                    <asp:Label ID="Label3" runat="server" Text="Địa chỉ"></asp:Label>
                </td>
                <td style="vertical-align: middle; text-align: right">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ControlToValidate="txtAddress" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:TextBox ID="txtAddress" runat="server" Font-Size="12pt" Height="25px" Width="90%"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style2" style="text-align: left; vertical-align: middle; background-color: #e4e4e4; width: 19%;">
                    <asp:Label ID="Label4" runat="server" Text="Số điện thoại"></asp:Label>
                </td>
                <td style="vertical-align: middle; text-align: right;">
                    <asp:TextBox ID="txtTel" runat="server" Height="25px" Width="90%" Font-Size="12pt"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style2" style="text-align: left; vertical-align: middle; background-color: #e4e4e4; width: 19%;">
                    <asp:Label ID="Label5" runat="server" Text="Fax"></asp:Label>
                </td>
                <td style="vertical-align: middle; text-align: right">
                    <asp:TextBox ID="txtFax" runat="server" Height="25px" Width="90%" Font-Size="12pt"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style2" style="text-align: left; vertical-align: middle; background-color: #e4e4e4; width: 19%;">
                    <asp:Label ID="Label6" runat="server" Text="Mã số thuế"></asp:Label>
                </td>
                <td style="vertical-align: middle; text-align: right">
                    <asp:TextBox ID="txtTaxNumber" runat="server" Height="25px" Width="90%" Font-Size="12pt"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 19%">&nbsp;</td>
                <td style="text-align: right">
                    <asp:Button ID="btCancel" runat="server" Text="Hủy" OnClick="btCancel_Click" Width="94px" CausesValidation="false" Height="30px" />
                    &nbsp;&nbsp;
                    <asp:Button ID="btAddCustomer" runat="server" OnClick="btAddCustomer_Click" Text="Lưu lại" Width="102px" Height="30px" />
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>

