<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Manage.master" AutoEventWireup="true" CodeFile="OrderDetails.aspx.cs" Inherits="Manage_Director_OrderDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div align="center" style="padding: 12px; color: #0066FF; font-size: x-large;">
        CHI TIẾT BÁO GIÁ
    </div>
    <div align="center">
        <table width="100%" cellspacing="5">
            <tr>
                <td style="text-align: left; ">
                    <asp:Label ID="Label3" runat="server" Text="Tên báo giá"></asp:Label>
                </td>
                <td colspan="3" style="text-align: left">
                    <asp:Label ID="lbOrderName" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="text-align: left; ">
                    <asp:Label ID="Label2" runat="server" Text="Khách hàng"></asp:Label>
                </td>
                <td style="text-align: left">
                    <asp:Label ID="lbCustomer" runat="server" Text=""></asp:Label>
                </td>
                <td style="text-align: left;">
                    <asp:Label ID="Label6" runat="server" Text="Số báo giá"></asp:Label>
                </td>
                <td style="text-align: right">
                    <asp:Label ID="lbOrderNo" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="text-align: left; ">
                    <asp:Label ID="Label4" runat="server" Text="Người liên hệ"></asp:Label>
                </td>
                <td style="text-align: left">
                    <asp:Label ID="lbContact" runat="server" Text=""></asp:Label>
                </td>

                <td style="text-align: left;">
                    <asp:Label ID="Label8" runat="server" Text="Ngày báo giá"></asp:Label>
                </td>
                <td style="text-align: right">
                    <asp:Label ID="lbOrderDate" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="text-align: left;">
                    <asp:Label ID="Label10" runat="server" Text="Giá trị đơn hàng"></asp:Label>
                </td>
                <td style="text-align: left">
                    <asp:Label ID="lbTotalPrice" runat="server" Text=""></asp:Label>
                </td>
                <td style="text-align: left; ">
                    <asp:Label ID="Label1" runat="server" Text="Người lập"></asp:Label>
                </td>
                <td style="text-align: right">
                    <asp:Label ID="lbStaff" runat="server" Text=""></asp:Label>
                </td>

            </tr>
            <tr>
                <td colspan="4">
                    <br />
                    <asp:GridView ID="gvProduct" Width="100%" runat="server" AutoGenerateColumns="False" ShowHeaderWhenEmpty="True">
                        <Columns>
                            <asp:BoundField HeaderText="STT" DataField="Order">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField HeaderText="Tên sản phẩm" DataField="Name" />
                            <asp:BoundField HeaderText="Model" DataField="Model" >
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Hình ảnh">
                                <ItemTemplate>
                                    <asp:Image ID="image" Width="200px" runat="server" ImageUrl='<%# Global.PATH_PRODUCTIMAGE + Eval("Image") %>'></asp:Image>
                                </ItemTemplate>
                                <ItemStyle Width="200px" />
                            </asp:TemplateField>
                            <asp:BoundField HeaderText="Số lượng" DataField="Quantity">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Giá (tại thời điểm lập)">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Global.currencyFormat((double)Eval("Price")) %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Điều chỉnh giá">                                
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("Scale") +" %" %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="Note" HeaderText="Ghi chú">
                                <ItemStyle HorizontalAlign="Justify" />
                            </asp:BoundField>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="vertical-align: middle; text-align: left; background-color: #e4e4e4">Điều kiện và điều khoản
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <asp:TextBox ID="txtTerms" Width="100%" Height="200px" Enabled="false" TextMode="MultiLine" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="4" style="text-align: right">
                    <br />
                    <asp:Button ID="btExcel" runat="server" Text="Xuất ra Excel (admin)" OnClick="btExcel_Click" Visible="False" />
                    &nbsp;<asp:Button ID="btPDF" runat="server" Text="Xuất ra PDF" OnClick="btPDF_Click" Visible="False" />
                </td>
            </tr>
            <tr>
                <td></td>
            </tr>
        </table>
    </div>
</asp:Content>

