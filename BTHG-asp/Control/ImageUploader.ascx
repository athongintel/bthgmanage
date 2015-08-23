<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ImageUploader.ascx.cs" Inherits="Control_ImageUploader" %>
<table>
    <tr>
        <td rowspan="2">
            <asp:Image ID="Image1" Width="200px" runat="server" Visible="False" />
        </td>
        <td>
            <asp:FileUpload ID="FileUpload1" runat="server" Width="136px" />
        </td>
    </tr>
    <tr>
        <td>
            <asp:Button ID="btUpload" runat="server" Text="Upload" Width="100%" OnClick="Button1_Click" CausesValidation="false" />
        </td>
    </tr>
    <tr>
        <td>
            <asp:Button ID="btCancel" runat="server" Text="Clear" Width="100%" OnClick="btCancel_Click" Visible="False" CausesValidation="false" />
        </td>         
    </tr>
</table>

