<%@ Page Language="C#" AutoEventWireup="true" CodeFile="jobs.aspx.cs" Inherits="jobs" MasterPageFile="~/Site.master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Jobs &amp; Internships | KUET Career Club
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

  <section class="portal-hero py-5">
    <div class="container">
      <div class="row align-items-center gy-4">
        <div class="col-lg-7">
          <h1>Jobs &amp; Internships</h1>
          <p class="lead mb-4">Search current openings, internships and work-study opportunities for KUET students and alumni.</p>
        </div>
        <div class="col-lg-5">
          <div class="portal-hero-card p-4">
            <h5>Ready to apply?</h5>
            <p class="mb-0">Filter roles by department, type, and location to find the best fit.</p>
            <div class="mt-3">
              <a href="post-job.aspx" class="btn btn-outline-primary btn-sm">Post a job</a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <section class="portal-search-section py-5 bg-white border-bottom">
    <div class="container">
      <div class="row g-3 align-items-end">
        <div class="col-md-5">
          <label class="form-label small fw-bold text-muted">Search Keyword</label>
          <asp:TextBox ID="jobSearch" runat="server" CssClass="form-control" TextMode="Search" placeholder="Search jobs, companies or skills" AutoPostBack="true" OnTextChanged="FilterJobsServer"></asp:TextBox>
        </div>
        <div class="col-md-3">
          <label class="form-label small fw-bold text-muted">Department</label>
          <asp:DropDownList ID="jobCategory" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="FilterJobsServer">
            <asp:ListItem Value="all">All Departments</asp:ListItem>
            <asp:ListItem Value="CSE">CSE</asp:ListItem>
            <asp:ListItem Value="EEE">EEE</asp:ListItem>
            <asp:ListItem Value="ME">ME</asp:ListItem>
            <asp:ListItem Value="Civil">Civil</asp:ListItem>
          </asp:DropDownList>
        </div>
        <div class="col-md-2">
          <label class="form-label small fw-bold text-muted">Job Type</label>
          <asp:DropDownList ID="jobType" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="FilterJobsServer">
            <asp:ListItem Value="all">All Types</asp:ListItem>
            <asp:ListItem Value="Full-time">Full-time</asp:ListItem>
            <asp:ListItem Value="Internship">Internship</asp:ListItem>
            <asp:ListItem Value="Part-time">Part-time</asp:ListItem>
          </asp:DropDownList>
        </div>
        <div class="col-md-2 d-grid">
          <asp:Button ID="btnClearFilters" runat="server" CssClass="btn btn-outline-danger fw-semibold" Text="Clear Filters" OnClick="btnClearFilters_Click" />
        </div>
      </div>
    </div>
  </section>

  <section class="portal-listing py-5">
    <div class="container">
      <div class="row g-4" id="jobGrid">
        
        <asp:Repeater ID="rptJobs" runat="server">
            <ItemTemplate>
                <div class="col-md-6">
                  <article class="job-card p-4 h-100 shadow-sm rounded-3">
                    <div class="d-flex justify-content-between align-items-start mb-3">
                      <div>
                        <h5><%# Eval("JobTitle") %></h5>
                        <p class="text-muted small mb-0"><i class="bi bi-building me-1"></i><%# Eval("CompanyName") %></p>
                      </div>
                      <span class='<%# GetBadgeClass(Eval("JobType").ToString()) %>'>
                          <%# Eval("JobType") %>
                      </span>
                    </div>
                    <p class="text-muted mb-3">
                      <%# (Eval("Description") == null) ? String.Empty :
                          (Eval("Description").ToString().Length > 160 ? Eval("Description").ToString().Substring(0,160) + "..." : Eval("Description")) %>
                    </p>
                    <div class="d-flex justify-content-between align-items-center mt-auto pt-2 border-top">
                        <span class="small text-muted"><strong>Dept:</strong> <%# Eval("Department") %></span>
                        <a href='<%# Eval("JobID", "/jobdetails.aspx?id={0}") %>' class="btn btn-outline-custom btn-sm fw-semibold">
                          <i class="bi bi-eye me-1" aria-hidden="true"></i> View Details
                        </a>
                    </div>
                  </article>
                </div>
            </ItemTemplate>
            <FooterTemplate>
                <asp:Panel ID="pnlNoData" runat="server" Visible='<%# rptJobs.Items.Count == 0 %>' CssClass="col-12 text-center py-5">
                    <i class="bi bi-briefcase text-muted display-4"></i>
                    <p class="text-muted mt-3">No job openings found matching your criteria.</p>
                </asp:Panel>
            </FooterTemplate>
        </asp:Repeater>

      </div>
    </div>
  </section>

</asp:Content>