<%@ Page Language="C#" AutoEventWireup="true" CodeFile="admin-create.aspx.cs" Inherits="admin_create" MasterPageFile="~/admin/Admin.master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">Create Admin | KUET Career Club</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
  <div class="card">
    <div class="card-body">
      <h5 class="card-title">Create Admin User</h5>
      <asp:Literal ID="litStatus" runat="server"></asp:Literal>

      <div class="row g-3">
        <div class="col-md-4">
          <label class="form-label">Username</label>
          <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control" />
        </div>
        <div class="col-md-4">
          <label class="form-label">Email</label>
          <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
        </div>
        <div class="col-md-4">
          <label class="form-label">Password</label>
          <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" />
        </div>
        <div class="col-md-4">
          <label class="form-label">Confirm Password</label>
          <asp:TextBox ID="txtPassword2" runat="server" CssClass="form-control" TextMode="Password" />
        </div>
        <div class="col-12">
          <asp:Button ID="btnCreate" runat="server" CssClass="btn btn-primary-custom" Text="Create Admin" OnClick="BtnCreate_Click" />
        </div>
      </div>
    </div>
  </div>
</asp:Content>
