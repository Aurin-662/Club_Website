<%@ Page Language="C#" AutoEventWireup="true" CodeFile="queued-emails.aspx.cs" Inherits="admin_queued_emails" MasterPageFile="~/admin/Admin.master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Queued Emails (Admin)
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <meta charset="utf-8" />
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
  <section class="py-5">
    <div class="container">
      <div class="row">
        <div class="col-lg-10 mx-auto">
          <nav aria-label="breadcrumb" class="mb-3">
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="~/home.aspx">Dashboard</a></li>
              <li class="breadcrumb-item active" aria-current="page">Queued Emails</li>
            </ol>
          </nav>

          <div class="d-flex justify-content-between align-items-center mb-3">
            <div>
              <h3 class="mb-0">Queued Emails</h3>
              <div class="text-muted small">Queued application emails that failed to send. Retry or remove entries here. If you see pickup directory errors, configure SMTP delivery or set a writable pickup folder (recommended: App_Data/mailpickup).</div>
            </div>
            <div>
              <asp:Button ID="btnAdminSignOut" runat="server" CssClass="btn btn-outline-secondary me-2" Text="Sign out" OnClick="BtnAdminSignOut_Click" />
              <asp:Button ID="btnRefresh" runat="server" CssClass="btn btn-primary" Text="Refresh" OnClick="BtnRefresh_Click" />
            </div>
          </div>

          <asp:Literal ID="litStatus" runat="server" />

          <asp:Repeater ID="rptQueued" runat="server" OnItemCommand="rptQueued_ItemCommand">
            <HeaderTemplate>
              <div class="list-group">
            </HeaderTemplate>
            <ItemTemplate>
              <div class="list-group-item d-flex justify-content-between align-items-start">
                <div>
                  <div class="fw-bold"><%# Eval("Name") %></div>
                  <div class="small text-muted"><%# Eval("Info") %></div>
                </div>
                <div>
                  <asp:Button runat="server" CssClass="btn btn-sm btn-outline-secondary me-2" CommandName="view" CommandArgument='<%# Eval("Path") %>' Text="View" />
                  <asp:Button runat="server" CssClass="btn btn-sm btn-outline-primary me-2" CommandName="retry" CommandArgument='<%# Eval("Path") %>' Text="Retry" />
                  <asp:Button runat="server" CssClass="btn btn-sm btn-outline-danger" CommandName="delete" CommandArgument='<%# Eval("Path") %>' Text="Delete" />
                </div>
              </div>
            </ItemTemplate>
            <FooterTemplate>
              </div>
            </FooterTemplate>
          </asp:Repeater>

          <div class="card mt-4">
            <div class="card-body">
              <h5 class="card-title">Preview / Logs</h5>
              <asp:Literal ID="litContent" runat="server"></asp:Literal>

              <!-- Edit & Resend panel -->
              <asp:Panel ID="pnlEdit" runat="server" CssClass="mt-3" Visible="false">
                <div class="mb-2"><strong>Edit recipient and resend</strong></div>
                <div class="mb-2">
                  <asp:TextBox ID="txtEditEmail" runat="server" CssClass="form-control" />
                </div>
                <div>
                  <asp:Button ID="btnResendEdit" runat="server" CssClass="btn btn-primary me-2" Text="Resend" OnClick="BtnResendEdit_Click" />
                  <asp:Button ID="btnCancelEdit" runat="server" CssClass="btn btn-outline-secondary" Text="Cancel" OnClick="BtnCancelEdit_Click" />
                </div>
              </asp:Panel>
            </div>
          </div>

        </div>
      </div>
    </div>
  </section>
</asp:Content>