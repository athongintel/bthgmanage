<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Manage.master" AutoEventWireup="true" CodeFile="OrderDetails.aspx.cs" Inherits="Manage_Director_OrderDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div align="center" style="padding: 12px; color: #0066FF; font-size: x-large;">
        CHI TIẾT BÁO GIÁ
    </div>
    <div align="center">
        <table width="100%" cellspacing="5">
            <tr>
                <td style="text-align: left;">
                    <asp:Label ID="Label3" runat="server" Text="Tên báo giá"></asp:Label>
                </td>
                <td colspan="3" style="text-align: left">
                    <asp:Label ID="lbOrderName" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="text-align: left;">
                    <asp:Label ID="Label2" runat="server" Text="Khách hàng"></asp:Label>
                </td>
                <td style="text-align: left">
                    <asp:Label ID="lbCustomer" runat="server" Text=""></asp:Label>
                </td>
                <td style="text-align: left; width: 181px;">
                    <asp:Label ID="Label6" runat="server" Text="Số báo giá"></asp:Label>
                </td>
                <td style="text-align: right">
                    <asp:Label ID="lbOrderNo" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="text-align: left;">
                    <asp:Label ID="Label4" runat="server" Text="Người liên hệ"></asp:Label>
                </td>
                <td style="text-align: left">
                    <asp:Label ID="lbContact" runat="server" Text=""></asp:Label>
                </td>

                <td style="text-align: left; width: 181px;">
                    <asp:Label ID="Label8" runat="server" Text="Ngày lập báo giá"></asp:Label>
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
                <td style="text-align: left; width: 181px;">
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
                            <asp:BoundField HeaderText="Model" DataField="Model">
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
                <td style="text-align: left; font-weight: bold;">
                    <br />
                    BÁO GIÁ ĐÃ XUẤT
                </td>
            </tr>
            <tr>
                <td colspan="4" style="text-align: left">
                    <table style="text-align: left; width: 100%">
                        <asp:Repeater ID="listExportedQuotation" runat="server" DataSourceID="ExportedQuotation">
                            <ItemTemplate>
                                <tr>
                                    <td style="text-align: left;">
                                        <asp:Label runat="server" ID="btQuotation" Text='<%# Eval("Name") + " - " + Global.dateTimeFormat((DateTime)Eval("QuoteDate")) + " (" + Eval("LanguageName") + ")"%>' CommandArgument='<%# Eval("QuoteDate")%>' />
                                    </td>
                                    <td style="text-align: right;">
                                        <asp:LinkButton runat="server" ID="btDownloadExcel" Text="Download Excel (admin)" Visible="<%# Global.isAdmin() %>" OnClick="btDownloadExcel_Click" CommandArgument='<%# Eval("IDQuotation") %>'></asp:LinkButton>
                                    </td>
                                    <td style="text-align: right;">
                                        <asp:LinkButton runat="server" ID="btDownloadPDF" Text="Download PDF" OnClick="btDownloadPDF_Click" CommandArgument='<%# Eval("IDQuotation") %>'></asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </table>
                    <asp:SqlDataSource ID="ExportedQuotation" runat="server" ConnectionString="<%$ ConnectionStrings:BTHGConnectionString %>" SelectCommand="SELECT * FROM [tbQuotation] JOIN [tbLanguage] ON [tbQuotation].LanguageID = [tbLanguage].IDLanguage JOIN [tbStaff] ON [tbQuotation].IDStaff=[tbStaff].IDStaff WHERE ([OrderNo] = @OrderNo) ORDER BY [QuoteDate]">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lbOrderNo" Name="OrderNo" PropertyName="Text" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td style="text-align: left; font-weight: bold">
                    <br />
                    XUẤT BÁO GIÁ MỚI
                </td>
                <td colspan="3" style="text-align: right">Chọn ngôn ngữ
                    <asp:DropDownList ID="listLanguage" runat="server" DataSourceID="BTHG" DataTextField="LanguageName" DataValueField="IDLanguage" AutoPostBack="true" OnSelectedIndexChanged="listLanguage_SelectedIndexChanged" OnDataBound="listLanguage_DataBound">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="BTHG" runat="server" ConnectionString="<%$ ConnectionStrings:BTHGConnectionString %>" SelectCommand="SELECT [IDLanguage], [LanguageName] FROM [tbLanguage] ORDER BY [LanguageName]"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="vertical-align: middle; text-align: left; background-color: #e4e4e4">Điều kiện và điều khoản
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <asp:TextBox ID="txtTerms" Width="100%" Height="200px" TextMode="MultiLine" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: left">
                    <asp:Button ID="btSaveDefaultTerm" runat="server" Text="Lưu điều khoản mẫu (admin)" Visible="<%# Global.isAdmin() %>" OnClick="btSaveDefaultTerm_Click" />
                </td>
                <td colspan="3" style="text-align: right">
                    <br />

                    &nbsp;&nbsp
                    &nbsp;
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

