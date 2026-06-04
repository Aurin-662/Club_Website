<%@ Page Language="C#" AutoEventWireup="true" CodeFile="jobdetails.aspx.cs" Inherits="jobdetails" MasterPageFile="~/Site.master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Job Details | KUET Career Club
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
  <section class="py-5">
    <div class="container">
      <asp:Panel ID="pnlNotFound" runat="server" Visible="false" CssClass="text-center py-5">
        <h3 class="mb-3">Job not found</h3>
        <p class="text-muted">The job you are looking for could not be found or may have been removed.</p>
        <a href="jobs.aspx" class="btn btn-outline-secondary mt-3">Back to Jobs</a>
      </asp:Panel>

      <asp:Panel ID="pnlDetails" runat="server" Visible="false">
        <div class="row">
          <div class="col-lg-8 mx-auto">
            <div class="card shadow-sm rounded-3 p-4">
              <h2 id="lblJobTitle" runat="server" class="card-title"></h2>
              <p class="text-muted mb-1"><strong>Company:</strong> <asp:Label ID="lblCompany" runat="server" /></p>
              <p class="text-muted mb-1"><strong>Department:</strong> <asp:Label ID="lblDept" runat="server" /></p>
              <p class="text-muted mb-1"><strong>Type:</strong> <asp:Label ID="lblType" runat="server" /></p>
              <hr />
              <div class="mb-3">
                <p id="lblDescription" runat="server" class="text-muted"></p>
              </div>
              <div class="d-flex justify-content-between align-items-center">
                <a href="jobs.aspx" class="btn btn-outline-secondary">Back to Jobs</a>
                <a id="applyLink" runat="server" class="btn btn-primary">Apply Now</a>
              </div>
            </div>
          </div>
        </div>
      </asp:Panel>
    </div>
  </section>
</asp:Content>