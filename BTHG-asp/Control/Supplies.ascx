<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Supplies.ascx.cs" Inherits="Control_Supplies" %>

<asp:Label ID="lbNoInfo" runat="server" Visible="false" Text="Chưa có thông tin về nhà cung cấp"></asp:Label>
<asp:Panel runat="server" ID="pnViewMode" Visible="false">
    <asp:Repeater ID="rptView" runat="server">
        <ItemTemplate>
            <asp:HyperLink runat="server" ID="lnk" Text='<%# Global.getSupplierName((int)Eval("IDSupplier")) %>' NavigateUrl='<%# "~/Manage/Supplier.aspx?IDSupplier=" + Eval("IDSupplier") %>'></asp:HyperLink>
            ;&nbsp;
        </ItemTemplate>
    </asp:Repeater>
</asp:Panel>
<asp:Panel runat="server" ID="pnEditMode" Visible="false">
    <asp:Repeater ID="rptEdit" runat="server">
        <ItemTemplate>
            <asp:HiddenField runat="server" ID="hidden" Value='<%# Eval("IDSupplier")%>' />
            <asp:CheckBox ID="ch" Checked='<%# Global.isVendor((int)Eval("IDSupplier"),productID) %>' Text='<%# Global.getSupplierName((int)Eval("IDSupplier")) %>' runat="server" />
            &nbsp;
        </ItemTemplate>
    </asp:Repeater>
</asp:Panel>
