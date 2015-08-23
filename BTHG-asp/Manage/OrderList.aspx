<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Manage.master" AutoEventWireup="true" CodeFile="OrderList.aspx.cs" Inherits="Manage_Director_OrderList" %>

<%@ Register Src="~/Control/SetDeliveryDate.ascx" TagPrefix="uc1" TagName="SetDeliveryDate" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div align="center" style="padding: 12px; color: #0066FF; font-size: x-large;">
        DANH SÁCH BÁO GIÁ
    </div>
    <table width="100%">
        <tr>
            <td style="text-align: left; background-color: #e4e4e4;">Chọn khách hàng
            </td>
            <td style="height: 23px; text-align: right;">

                <asp:DropDownList ID="DropDownList1" runat="server" Height="25px" Width="400px" AutoPostBack="True" DataSourceID="customerDS" DataTextField="Name" DataValueField="IDCustomer" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                </asp:DropDownList>

                <asp:SqlDataSource ID="customerDS" runat="server" ConnectionString="<%$ ConnectionStrings:BTHGConnectionString %>" SelectCommand="SELECT [IDCustomer], [Name] FROM [tbCustomer] ORDER BY [Name]"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td></td>
        </tr>
        <tr>
            <td colspan="2">

                <asp:GridView ID="GridView1" runat="server" Width="100%" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
                    <Columns>
                        <asp:TemplateField HeaderText="Tên báo giá">
                            <ItemTemplate>
                                <asp:HyperLink ID="hpl" Text='<%# Eval("OrderName") %>' NavigateUrl='<%# "~/Manage/OrderDetails.aspx?order=" + Eval("OrderNo") %>' runat="server"></asp:HyperLink>
                            </ItemTemplate>                        
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Ngày tạo" DataField="OrderDate" DataFormatString="{0: dd/MM/yyyy ___ HH:mm}">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Người tạo">
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Global.getStaffName((int)Eval("IDStaff")) %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Ngày giao hàng">
                            <ItemTemplate>
                                <uc1:SetDeliveryDate runat="server" ID="SetDeliveryDate" DeliveryDate='<%# Eval("DeliveryDate")==null? DateTime.Parse("01-01-1010"):Eval("DeliveryDate") %>' orderNo='<%# Eval("OrderNo") %>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="lbkModify" runat="server" Text="Điều chỉnh" OnClick="lbkModify_Click" CommandArgument='<%# Eval("OrderNo") %>' Visible='<%# (Eval("DeliveryDate")==null)%>'></asp:LinkButton>
                                <asp:LinkButton ID="lbkDelete" runat="server" Text="Xóa" OnClick="lbkDelete_Click" CommandArgument='<%# Eval("OrderNo") %>' Visible='<%# (Eval("DeliveryDate")==null) && (Global.getCurrentIDStaff()==(int)Eval("IDStaff")) %>'></asp:LinkButton>
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

            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: right">
                <asp:Panel runat="server" ID="pnStat">
                    Thống kê:
                    <asp:Label ID="lbSold" runat="server" Font-Bold="True" Font-Size="Large"></asp:Label>
                    &nbsp;đơn hàng /
                <asp:Label ID="lbOrder" runat="server" Font-Bold="True" Font-Size="Large"></asp:Label>
                    &nbsp;báo giá
                </asp:Panel>
            </td>
        </tr>
    </table>

</asp:Content>

