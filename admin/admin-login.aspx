<%@ Page Language="C#" AutoEventWireup="true" CodeFile="admin-login.aspx.cs" Inherits="admin_login" MasterPageFile="~/site.master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Admin Sign In | KUET Career Club
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
                <h2>Admin Sign In</h2>
                <p class="text-muted">Enter admin credentials to access administrative pages.</p>
              </div>
              <div class="auth-card-body p-4">
                <div class="row g-4">
                  <div class="col-12">
                    <label class="form-label" for="txtAdminUser">Username</label>
                    <asp:TextBox ID="txtAdminUser" runat="server" CssClass="form-control" placeholder="admin"></asp:TextBox>
                  </div>

                  <div class="col-12">
                    <label class="form-label" for="txtAdminPass">Password</label>
                    <asp:TextBox ID="txtAdminPass" runat="server" CssClass="form-control" TextMode="Password" placeholder="password"></asp:TextBox>
                  </div>

                  <div class="col-12">
                    <asp:Button ID="btnAdminSignIn" runat="server" CssClass="btn btn-primary-custom w-100" Text="Sign In" OnClick="BtnAdminSignIn_Click" />
                  </div>
                </div>

                <div class="text-center mt-3">
                    <asp:Literal ID="litAdminMessage" runat="server" />
                </div>
                <div class="text-muted small mt-2">Note: Default admin credentials are configured in Web.config under AppSettings (AdminUser / AdminPass). Change them before production.</div>
                <div class="text-center mt-2"><a href="../forgot-password.aspx">Forgot password?</a></div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>
</asp:Content>
