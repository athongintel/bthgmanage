<%@ Page Title="" Language="C#" MasterPageFile="~/Manage/Director/Director.master" AutoEventWireup="true" CodeFile="Languages.aspx.cs" Inherits="Manage_Director_Languages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <div>
        <table style="width:100%;border: 1px solid silver; padding:10px;">
            <tr>
                <td style="width:50%; text-align:center; vertical-align:middle">
                    CONCEPT
                </td>
                <td style="width:50%; text-align:center; vertical-align:middle">
                    TRANSLATION
                </td>
            </tr>
            <tr>
                <td style="width:50%; text-align:center; vertical-align:top">
                    <br/>
                    <asp:ListBox style="width:100%; height:200px" ID="listConcept" runat="server" DataSourceID="SqlDataSource1" DataTextField="LanguageConcept" DataValueField="LanguageConcept" OnSelectedIndexChanged="listConcept_SelectedIndexChanged" AutoPostBack="true"></asp:ListBox>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BTHGConnectionString %>" SelectCommand="SELECT [LanguageConcept] FROM [tbLanguageConcept] ORDER BY [LanguageConcept]"></asp:SqlDataSource>
                </td>
                <td style="width:50%; text-align:left; vertical-align:top">
                    <br />
                    <asp:Repeater runat="server" ID="listTranslation" DataMember="x">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lbLanguageID" Text='<%# Eval("LanguageID") %>' Visible="false" />
                            <asp:Label runat="server" Text='<%# Eval("LanguageName") %>' />
                            <br />
                            <asp:TextBox style="width:100%" runat="server" TextMode="MultiLine" ID="txtTranslation" Text='<%# Eval("Translation") %>' />
                            <br />
                            <br />
                        </ItemTemplate>
                    </asp:Repeater>
                    <br />
                    <asp:Button runat="server" ID="btUpdateTranslation" OnClick="btUpdateTranslation_Click" Text="Update" />
                    <asp:Button ID="btRemoveConcept" runat="server" Text="Remove" OnClick="btRemoveConcept_Click" />
                </td>
            </tr>
            <tr>
                <td>
                    New concept
                    <div style="font-style: italic">Example: this_is_a_concept</div>
                    <br />
                    <asp:TextBox style="width:100%" runat="server" ID="txtNewConcept"></asp:TextBox>
                    <br />
                    <asp:Button runat="server" ID="btAddConcept" Text="Add Concept" OnClick="btAddConcept_Click" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>

