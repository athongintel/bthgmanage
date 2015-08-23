<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SetDeliveryDate.ascx.cs" Inherits="Control_SetDeliveryDate" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<%@ Register Src="DatePicker.ascx" TagName="DatePicker" TagPrefix="uc1" %>

<style type="text/css">
    .Background 
    {
        background-color: Black;
        filter: alpha(opacity=90);
        opacity: 0.5;
    }
    .Popup
    {
        background-color: #FFFFFF;
        border-width: 3px;
        border-style: solid;
        border-color: black;
        padding-top: 10px;
        padding-left: 10px;
        width: 400px;
        height: 350px;
    }
</style>

<asp:Label ID="lbDelivery" runat="server" Text=""></asp:Label>
<asp:LinkButton ID="lkbDelivery" runat="server" Text="Chọn ngày giao hàng" Visible="False"></asp:LinkButton>

<cc1:ModalPopupExtender ID="mdlPopupPayment" runat="server"
    TargetControlID="lkbDelivery" PopupControlID="pnSetDate"
    CancelControlID="btClose" DropShadow="true"
    BackgroundCssClass="Background">
</cc1:ModalPopupExtender>

<asp:Panel ID="pnSetDate" CssClass="Popup" style = "display:none; vertical-align:middle" runat="server" Width="300px" Height="120px">
    <table>
        <tr>
            <td>
                Mã báo giá
            </td>
            <td>
                <asp:Label ID="lbOrderNo" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                Ngày giao hàng
            </td>
            <td>
                <uc1:DatePicker ID="DatePicker1" runat="server" />
            </td>
        </tr>
        <tr>
            <td></td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: right">
                <asp:Button ID="btClose" runat="server" Text="Hủy" Width="100px" Height="25px" />&nbsp;
                <asp:Button ID="btSet" runat="server" Text="Chọn" Width="100px"  Height="25px" OnClick="btSet_Click" />
            </td>
        </tr>
    </table>

</asp:Panel>

