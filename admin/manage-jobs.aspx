<%@ Page Language="C#" AutoEventWireup="true" CodeFile="manage-jobs.aspx.cs" Inherits="admin_manage_jobs" MasterPageFile="~/admin/Admin.master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Manage Jobs (Admin)
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <meta charset="utf-8" />
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
  <section class="py-5">
    <div class="container">
      <div class="row">
        <div class="col-lg-10 mx-auto">
          <h3>Manage Published Jobs</h3>
          <p class="text-muted">View and remove published job listings.</p>

          <div class="d-flex gap-2 mb-3">
            <a href="pending-jobs.aspx" class="btn btn-sm btn-outline-secondary">Pending Jobs</a>
          </div>

          <asp:Repeater ID="rptManage" runat="server" OnItemCommand="rptManage_ItemCommand">
            <HeaderTemplate>
              <div class="list-group">
            </HeaderTemplate>
            <ItemTemplate>
              <div class="list-group-item">
                <div class="d-flex justify-content-between align-items-start">
                  <div>
                    <div class="fw-bold"><%# Eval("JobTitle") %> <small class="text-muted">- <%# Eval("CompanyName") %></small></div>
                    <div class="small text-muted mb-2"><%# Eval("Department") %> • <%# Eval("JobType") %></div>
                    <div class="mb-2"><%# Eval("Description") %></div>
                  </div>
                  <div class="text-end">
                    <asp:Button runat="server" CssClass="btn btn-sm btn-outline-secondary me-2" CommandName="view" CommandArgument='<%# Eval("JobID") %>' Text="View" />
                    <asp:Button runat="server" CssClass="btn btn-sm btn-danger" CommandName="delete" CommandArgument='<%# Eval("JobID") %>' Text="Delete" />
                  </div>
                </div>
              </div>
            </ItemTemplate>
            <FooterTemplate>
              </div>
            </FooterTemplate>
          </asp:Repeater>

          <asp:Literal ID="litManageStatus" runat="server" />
        </div>
      </div>
    </div>
  </section>
</asp:Content>
