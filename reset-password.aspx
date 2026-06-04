<%@ Page Language="C#" AutoEventWireup="true" CodeFile="reset-password.aspx.cs" Inherits="reset_password" MasterPageFile="~/Site.master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">Reset Password | KUET Career Club</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
  <section class="py-5">
    <div class="container">
      <div class="row">
        <div class="col-md-6 mx-auto">
          <div class="card p-4">
            <h3>Reset Password</h3>
            <asp:Label ID="lblMessage" runat="server" CssClass="mb-2" />
            <asp:Panel ID="pnlForm" runat="server" Visible="false">
              <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control mb-2" Placeholder="New password"></asp:TextBox>
              <asp:TextBox ID="txtPassword2" runat="server" TextMode="Password" CssClass="form-control mb-2" Placeholder="Confirm password"></asp:TextBox>
              <asp:Button ID="btnReset" runat="server" CssClass="btn btn-primary" Text="Reset Password" OnClick="BtnReset_Click" />
            </asp:Panel>
          </div>
        </div>
      </div>
    </div>
  </section>
</asp:Content>
