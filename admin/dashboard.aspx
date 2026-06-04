<%@ Page Language="C#" AutoEventWireup="true" CodeFile="dashboard.aspx.cs" Inherits="admin_dashboard" MasterPageFile="~/admin/Admin.master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">Admin Dashboard | KUET Career Club</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <meta charset="utf-8" />
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
  <section class="py-5">
    <div class="container">
      <div class="row">
        <div class="col-12 d-flex justify-content-between align-items-center mb-4">
          <h3 class="mb-0">Admin Dashboard</h3>
          <div>
            <a href="pending-jobs.aspx" class="btn btn-outline-primary me-2">Pending Jobs</a>
            <a href="queued-emails.aspx" class="btn btn-outline-primary">Queued Emails</a>
          </div>
        </div>
      </div>

      <asp:Literal ID="litStatus" runat="server"></asp:Literal>

      <div class="row g-4">
        <div class="col-md-3">
          <div class="card p-3 text-center">
            <div class="card-body">
              <div class="h1 mb-0" id="jobsCount"><asp:Literal ID="litJobsCount" runat="server"></asp:Literal></div>
              <div class="text-muted small">Published Jobs</div>
            </div>
          </div>
        </div>
        <div class="col-md-3">
          <div class="card p-3 text-center">
            <div class="card-body">
              <div class="h1 mb-0" id="pendingCount"><asp:Literal ID="litPendingCount" runat="server"></asp:Literal></div>
              <div class="text-muted small">Pending Submissions</div>
            </div>
          </div>
        </div>
        <div class="col-md-3">
          <div class="card p-3 text-center">
            <div class="card-body">
              <div class="h1 mb-0" id="queuedCount"><asp:Literal ID="litQueuedCount" runat="server"></asp:Literal></div>
              <div class="text-muted small">Queued Emails</div>
            </div>
          </div>
        </div>
        <div class="col-md-3">
          <div class="card p-3 text-center">
            <div class="card-body">
              <div class="h1 mb-0" id="errorsCount"><asp:Literal ID="litErrorsCount" runat="server"></asp:Literal></div>
              <div class="text-muted small">Recent Errors</div>
            </div>
          </div>
        </div>
      </div>

      <div class="row mt-4 g-4">
        <div class="col-lg-6">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">Recent Pending Submissions</h5>
              <asp:Repeater ID="rptRecentPending" runat="server">
                <ItemTemplate>
                  <div class="d-flex justify-content-between align-items-start py-2 border-bottom">
                    <div>
                      <div class="fw-bold"><%# Eval("JobTitle") %></div>
                      <div class="small text-muted"><%# Eval("CompanyName") %> • <%# Eval("Department") %></div>
                    </div>
                    <div><a class="btn btn-sm btn-outline-secondary" href='<%# Eval("Path") %>' target="_blank">View</a></div>
                  </div>
                </ItemTemplate>
              </asp:Repeater>
            </div>
          </div>
        </div>

        <div class="col-lg-6">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">Recent Queued Emails</h5>
              <asp:Repeater ID="rptRecentQueued" runat="server">
                <ItemTemplate>
                  <div class="d-flex justify-content-between align-items-start py-2 border-bottom">
                    <div>
                      <div class="fw-bold"><%# Eval("Name") %></div>
                      <div class="small text-muted"><%# Eval("Info") %></div>
                    </div>
                    <div><a class="btn btn-sm btn-outline-primary" href='queued-emails-file.ashx?file=<%# Server.UrlEncode(Eval("Name").ToString()) %>' target="_blank">Download</a></div>
                  </div>
                </ItemTemplate>
              </asp:Repeater>
            </div>
          </div>
        </div>
      </div>

      <div class="row mt-4">
        <div class="col-12">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">Recent Error Log</h5>
              <pre class="small"><asp:Literal ID="litErrorLog" runat="server"></asp:Literal></pre>
            </div>
          </div>
        </div>
      </div>

    </div>
  </section>
</asp:Content>
