<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DatePicker.ascx.cs" Inherits="Manage_DatePicker" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<style type="text/css">
    .text {
        font-size: 16px;
    }

    .table {
        border-spacing: 1px;
    }

        .table td {
            padding: 1px;
        }
</style>
<table>
    <tr>
        <td>
            <asp:TextBox ID="tbDate" CssClass="text" Width="113px" runat="server" Text='<%# Global.getCurrentDateTime().ToString("dd-MM-yyyy") %>'
                Height="25px"></asp:TextBox>
        </td>
        <td>
            <asp:ImageButton runat="Server" ID="Image2" ImageUrl="~/Image/calendar-mini.png" />
        </td>
    </tr>
</table>


<ajaxToolkit:CalendarExtender ID="calendarButtonExtender2" runat="server"
    TargetControlID="tbDate" PopupButtonID="Image2" Format="dd-MM-yyyy" />
