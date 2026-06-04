<%@ Page Language="C#" AutoEventWireup="true" CodeFile="pending-jobs.aspx.cs" Inherits="admin_pending_jobs" MasterPageFile="~/admin/Admin.master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Pending Job Submissions (Admin)
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <meta charset="utf-8" />
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
  <section class="py-5">
    <div class="container">
      <div class="row">
        <div class="col-lg-10 mx-auto">
          <h3>Pending Job Submissions</h3>
          <p class="text-muted">Jobs submitted by companies appear here for review. Approve to publish on Jobs page.</p>

          <asp:Repeater ID="rptPending" runat="server" OnItemCommand="rptPending_ItemCommand">
            <HeaderTemplate>
              <div class="list-group">
            </HeaderTemplate>
            <ItemTemplate>
              <div class="list-group-item">
                <div class="d-flex justify-content-between align-items-start">
                  <div>
                    <div class="fw-bold"><%# Eval("JobTitle") %> <small class="text-muted">- <%# Eval("CompanyName") %></small></div>
                    <div class="small text-muted mb-2"><%# Eval("Department") %> • <%# Eval("JobType") %></div>
                    <div class="small text-muted mb-2">Contact: <%# Eval("ContactEmail") %> <%# Eval("CompanyWebsite") != null && Eval("CompanyWebsite").ToString() != "" ? ("• " + Eval("CompanyWebsite")) : "" %></div>
                    <div class="mb-2"><%# Eval("Description") %></div>
                  </div>
                  <div class="text-end">
                    <asp:Button runat="server" CssClass="btn btn-sm btn-outline-secondary me-2" CommandName="view" CommandArgument='<%# Eval("Path") %>' Text="View" />
                    <asp:Button runat="server" CssClass="btn btn-sm btn-success me-2" CommandName="approve" CommandArgument='<%# Eval("Path") %>' Text="Approve" />
                    <asp:Button runat="server" CssClass="btn btn-sm btn-danger" CommandName="decline" CommandArgument='<%# Eval("Path") %>' Text="Decline" />
                  </div>
                </div>
              </div>
            </ItemTemplate>
            <FooterTemplate>
              </div>
            </FooterTemplate>
          </asp:Repeater>

          <asp:Literal ID="litPendingStatus" runat="server" />
        </div>
      </div>
    </div>
  </section>
</asp:Content>
