<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Director/Director.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Manage_Director_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div align="center" style="padding: 12px; color: #0066FF; font-size: x-large;">
        THÔNG TIN CÔNG TY
    </div>
    <table width="100%">
        <tr>
            <td style="vertical-align: middle; text-align: left; width: 264px;">Tên công ty

            </td>
            <td>
                <asp:Label ID="lbName" runat="server" Text=""></asp:Label>
                <asp:TextBox ID="txtName" Width="100%" runat="server" Visible="False"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td style="vertical-align: middle; text-align: left; width: 264px;">Lĩnh vực kinh doanh

            </td>
            <td>
                <asp:Label ID="lbDomain" runat="server" Text=""></asp:Label>
                <asp:TextBox ID="txtDomain" Width="100%" runat="server" Visible="False"></asp:TextBox>
            </td>
        </tr>

        <tr>
            <td style="vertical-align: middle; text-align: left; width: 264px;">Thông tin liên hệ

            </td>
            <td>
                <asp:Label ID="lbInfo" runat="server" Text=""></asp:Label>
                <asp:TextBox ID="txtInfo" Width="100%" runat="server" Visible="False" ></asp:TextBox>
            </td>
        </tr>

        <tr>
            <td style="vertical-align: middle; text-align: left; width: 264px;">Địa chỉ

            </td>
            <td>
                <asp:Label ID="lbAddress" runat="server" Text=""></asp:Label>
                <asp:TextBox ID="txtAddress" Width="100%" runat="server" Visible="False"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align:right">

                <asp:Button ID="btEdit" runat="server" Text="Sửa" Width="100px" OnClick="btEdit_Click" Height="30px" />
                <asp:Button ID="btSave" runat="server" Text="Lưu" Width="100px" Visible="False" OnClick="btSave_Click" Height="30px" />
                <asp:Button ID="btCancel" runat="server" Text="Hủy" width="100px" Visible="False" OnClick="btCancel_Click" Height="30px"/>                
            </td>
        </tr>
        <tr>
            <td></td>
        </tr>
    </table>
</asp:Content>

