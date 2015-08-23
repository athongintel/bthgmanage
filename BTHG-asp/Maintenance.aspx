<%@ Page Title="" Language="C#" MasterPageFile="~/Super.master" AutoEventWireup="true" CodeFile="Maintenance.aspx.cs" Inherits="Maintenance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder" Runat="Server">
    <div style="text-align:center; padding:100px; font-size:xx-large">
        Trang web đang được bảo trì, dự kiến kết thúc:
        <br/>
        <asp:Label runat="server" ID="lbTime"></asp:Label>
        <br />
        <br />
        <a href="Default.aspx">Tải lại</a>
    </div>
</asp:Content>

