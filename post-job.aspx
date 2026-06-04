<%@ Page Language="C#" AutoEventWireup="true" CodeFile="post-job.aspx.cs" Inherits="post_job" MasterPageFile="~/Site.master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Post a Job | KUET Career Club
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
  <section class="py-5">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-lg-8">
          <div class="card p-4">
            <h3>Post a Job</h3>
            <p class="text-muted">Submit job details and an admin will review before publishing.</p>

            <asp:Label ID="lblPostMsg" runat="server" CssClass="d-block mb-3"></asp:Label>

            <div>
              <div class="mb-3">
                <label class="form-label">Job Title</label>
                <asp:TextBox ID="txtJobTitle" runat="server" CssClass="form-control"></asp:TextBox>
              </div>
              <div class="mb-3">
                <label class="form-label">Company Name</label>
                <asp:TextBox ID="txtCompany" runat="server" CssClass="form-control"></asp:TextBox>
              </div>
              <div class="mb-3">
                <label class="form-label">Contact Email</label>
                <asp:TextBox ID="txtCompanyEmail" runat="server" CssClass="form-control" placeholder="hr@company.com"></asp:TextBox>
              </div>
              <div class="mb-3">
                <label class="form-label">Company Website (optional)</label>
                <asp:TextBox ID="txtCompanyWebsite" runat="server" CssClass="form-control" placeholder="https://example.com"></asp:TextBox>
              </div>
              <div class="mb-3">
                <label class="form-label">Department</label>
                <asp:TextBox ID="txtDept" runat="server" CssClass="form-control"></asp:TextBox>
              </div>
              <div class="mb-3">
                <label class="form-label">Job Type</label>
                <asp:DropDownList ID="ddlType" runat="server" CssClass="form-select">
                  <asp:ListItem>Full-time</asp:ListItem>
                  <asp:ListItem>Internship</asp:ListItem>
                  <asp:ListItem>Part-time</asp:ListItem>
                </asp:DropDownList>
              </div>
              <div class="mb-3">
                <label class="form-label">Description</label>
                <asp:TextBox ID="txtDesc" runat="server" TextMode="MultiLine" CssClass="form-control" Rows="6"></asp:TextBox>
              </div>
              <div class="d-grid">
                <asp:Button ID="btnSubmitJob" runat="server" CssClass="btn btn-primary" Text="Submit for review" OnClick="BtnSubmitJob_Click" />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</asp:Content>
