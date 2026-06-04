<%@ Page Language="C#" AutoEventWireup="true" CodeFile="forgot-password.aspx.cs" Inherits="forgot_password" MasterPageFile="~/Site.master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">Forgot Password | KUET Career Club</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
  <section class="py-5">
    <div class="container">
      <div class="row">
        <div class="col-md-6 mx-auto">
          <div class="card p-4">
            <h3>Forgot Password</h3>
            <p class="text-muted">Enter your registered email. If an account exists, we'll send a reset link.</p>
            <asp:Label ID="lblMessage" runat="server" CssClass="mb-2" />
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control mb-2" Placeholder="Your KUET email"></asp:TextBox>
            <asp:Button ID="btnSend" runat="server" CssClass="btn btn-primary" Text="Send Reset Link" OnClick="BtnSend_Click" />
          </div>
        </div>
      </div>
    </div>
  </section>
</asp:Content>
