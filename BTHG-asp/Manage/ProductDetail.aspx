<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Manage.master" AutoEventWireup="true" CodeFile="ProductDetail.aspx.cs" Inherits="Manage_Director_ProductDetail" %>
<%@ Register Src="~/Control/ImageUploader.ascx" TagName="ImageUploader" TagPrefix="uc2" %>
<%@ Register Src="~/Control/Brand.ascx" TagPrefix="uc1" TagName="Brand" %>
<%@ Register src="~/Control/Supplies.ascx" tagname="Supplies" tagprefix="uc3" %>
<%@ Register src="../Control/ProductGroup.ascx" tagname="ProductGroup" tagprefix="uc4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
    </style>
    <asp:Panel ID="pnEdit" runat="server" HorizontalAlign="Center">
        <div align="center" style="padding: 12px; color: #0066FF; font-size: x-large;">
        CHI TIẾT SẢN PHẨM</div>
        <br />
        <table cellpadding="5" cellspacing="5" width="100%" border="1" style="border-style: none">
            <tr>
                <td style="background-color: #e4e4e4; vertical-align: middle; text-align: center">
                    <asp:Label ID="Label7" runat="server" Text="Loại sản phẩm: &amp;nbsp;"></asp:Label>
                </td>
                <td bgcolor="#ccccff" style="background-color: #FFFFFF">
                    <asp:Label ID="lbProductType" runat="server" Visible="False"></asp:Label>
                    <asp:DropDownList ID="liGroup" runat="server" AutoPostBack="True" DataSourceID="groupDS" DataTextField="Name" DataValueField="IDGroup" Height="30px" OnSelectedIndexChanged="liGroup_SelectedIndexChanged" Width="100%">
                    </asp:DropDownList>
                    <asp:DropDownList ID="liType" runat="server" Height="30px" Width="100%" DataTextField="Name" DataValueField="IDProductType">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="groupDS" runat="server" ConnectionString="<%$ ConnectionStrings:BTHGConnectionString %>" SelectCommand="SELECT [IDGroup], [Name] FROM [tbProductGroup] ORDER BY [Name]"></asp:SqlDataSource>
                </td>
                <td style="background-color: #e4e4e4; vertical-align: middle; text-align: center">
                    <asp:Label ID="Label3" runat="server" Text="Model: &amp;nbsp"></asp:Label>
                </td>
                <td bgcolor="#ccccff" style="background-color: #FFFFFF; vertical-align: middle; text-align: center;">
                    <asp:Label ID="lbModel" runat="server" Visible="False"></asp:Label>
                    <asp:TextBox ID="txtModel" runat="server" Visible="False" Width="100%"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtModel" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
                <td style="background-color: #e4e4e4; text-align: center; vertical-align: middle;">
                    <asp:Label ID="Label8" runat="server" Text="Thương hiệu: &amp;nbsp;"></asp:Label>
                </td>
                <td bgcolor="#ccccff" style="background-color: #FFFFFF">
                    <asp:Label ID="lbBrand" runat="server"></asp:Label>
                    <uc1:Brand runat="server" ID="Brand1" Visible="False" />
                </td>
            </tr>
            <tr>
                <td style="background-color: #e4e4e4; vertical-align: middle; text-align: center">

                    Giá đầu vào</td>
                <td bgcolor="#ccccff" style="background-color: #FFFFFF">
                    <asp:Label ID="lbDiscount" runat="server" Visible="False"></asp:Label>
                    <asp:TextBox ID="txtDiscount" runat="server" Width="90%" Visible="False">0</asp:TextBox>

                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtDiscount" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>

                </td>
                <td style="background-color: #e4e4e4; vertical-align: middle; text-align: center">
                    Giá bán ra</td>
                <td bgcolor="#ccccff" style="background-color: #FFFFFF; vertical-align: middle; text-align: center;">
                    <asp:Label ID="lbPrice" runat="server" Visible="False"></asp:Label>
                    <asp:TextBox ID="txtPrice" runat="server" Visible="False" Width="90%">0</asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtPrice" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
                <td style="background-color: #e4e4e4; text-align: center; vertical-align: middle;">
                    <asp:Label ID="Label5" runat="server" Text="Tồn kho: &amp;nbsp;"></asp:Label>
                </td>
                <td bgcolor="#ccccff" style="background-color: #FFFFFF; vertical-align: middle; text-align: center;">
                    <asp:Label ID="lbAvailable" runat="server" Visible="False"></asp:Label>
                    <asp:TextBox ID="txtAvailable" runat="server" Visible="False" Width="90%">0</asp:TextBox>

                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtAvailable" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>

                </td>
                
            </tr>
            <tr>
                <td style="background-color: #e4e4e4; text-align: center; vertical-align: middle;">
                    <asp:Label ID="Label9" runat="server" Text="Các nhà cung cấp:"></asp:Label>
                </td>
                <td colspan="5">
                    <uc3:Supplies ID="Supplies1" runat="server" />
                </td>
            </tr>
            <tr>
                <td style="background-color: #e4e4e4; vertical-align: middle; text-align: center">
                    <asp:Label ID="Label10" runat="server" Text="Ảnh"></asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Image ID="img1" runat="server" Width="200px" Visible="False" />
                    <uc2:ImageUploader ID="ImageUploader1" runat="server" Visible="False" />
                </td>
                <td colspan="2">
                    <asp:Image ID="img2" runat="server" Width="200px" Visible="False" />
                    <uc2:ImageUploader ID="ImageUploader2" runat="server" Visible="False" />
                </td>
                <td colspan="2">
                    <asp:Image ID="img3" runat="server" Width="200px" Visible="False" />
                    <uc2:ImageUploader ID="ImageUploader3" runat="server" Visible="False" />
                </td>
            </tr>
            <tr>
                <td colspan="6">
                    <asp:Label ID="Label6" runat="server" Text="Đặc điểm kỹ thuật: "></asp:Label>
                    <br />
                    <asp:TextBox ID="txtSpecification" runat="server" TextMode="MultiLine" Height="250px" Width="100%"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="6" align="right" style="border: none">
                    <asp:Panel runat="server" ID="pnAdmin" Visible="False">
                        <asp:CheckBox ID="chkKeep" Text="Giữ trang để thêm tiếp" runat="server" Visible="False" />
                        <asp:Button ID="btSave" runat="server" Text="Lưu thông tin" Visible="False" OnClick="btSave_Click" Height="30px" />
                        <asp:Button ID="btCancel" runat="server" CausesValidation="False" OnClick="btCancel_Click" Text="Hủy" Visible="False" Width="87px" Height="30px" />
                        <asp:Button ID="btEdit" runat="server" Text="Thay đổi thông tin (admin)" Visible="False" OnClick="btEdit_Click" CausesValidation="false" Height="30px" />
                        <asp:Button ID="btAdd" runat="server" Text="Thêm sản phẩm (admin)" OnClick="btAdd_Click" Visible="False" Height="30px" />
                    </asp:Panel>
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>

