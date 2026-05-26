<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" MasterPageFile="~/Site.master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Sign In | KUET Career Club
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <main class="auth-page py-5">
      <div class="container">
        <div class="row justify-content-center align-items-center">
          <div class="col-lg-6">
            <div class="auth-card shadow-sm">
              <div class="auth-card-header text-center p-4">
                <h2>Sign In</h2>
                <p class="text-muted">Access your KUET Career Club profile, internships, and portal resources.</p>
              </div>
              <div class="auth-card-body p-4">
                <div class="row g-4">
                  <div class="col-12">
                    <label class="form-label" for="txtLoginEmail">KUET Email</label>
                    <asp:TextBox ID="txtLoginEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="name@stud.kuet.ac.bd"></asp:TextBox>
                  </div>
                  
                  <div class="col-12">
                    <label class="form-label" for="txtLoginPassword">Password</label>
                    <asp:TextBox ID="txtLoginPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter your password"></asp:TextBox>
                  </div>
                  
                  <div class="col-12 d-flex align-items-center justify-content-between flex-column flex-sm-row gap-2">
                    <div class="form-check">
                      <asp:CheckBox ID="chkRemember" runat="server" CssClass="form-check-input" />
                      <label class="form-check-label" for="<%= chkRemember.ClientID %>">Remember me</label>
                    </div>
                    <a href="#" class="text-decoration-none small text-primary">Forgot password?</a>
                  </div>
                  
                  <div class="col-12">
                    <asp:Button ID="btnSignIn" runat="server" CssClass="btn btn-primary-bcc w-100" Text="Sign In" OnClick="BtnSignIn_Click" />
                  </div>
                  
                  <div class="col-12 text-center auth-form-footer mt-2">
                    <span>New to KUET Career Club? <a href="register.aspx">Create an account</a></span>
                  </div>
                </div>
                
                <div class="text-center mt-3">
                    <asp:Label ID="lblMessage" runat="server" Font-Bold="true" aria-live="polite" />
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>
</asp:Content>