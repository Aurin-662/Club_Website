<%@ Page Language="C#" AutoEventWireup="true" CodeFile="apply.aspx.cs" Inherits="apply" MasterPageFile="~/Site.master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Apply | KUET Career Club
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
  <section class="py-5">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-lg-8">
          <div class="card shadow-sm rounded-3 p-4">
            <h3 id="lblJobTitle" runat="server">Apply for Job</h3>
            <p class="text-muted mb-4" id="lblCompany" runat="server"></p>

            <asp:Panel ID="pnlForm" runat="server">
              <div class="mb-3">
                <label class="form-label">Full name</label>
                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Your full name"></asp:TextBox>
              </div>

              <div class="mb-3">
                <label class="form-label">Email address</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="you@domain.com"></asp:TextBox>
              </div>

              <div class="mb-3">
                <label class="form-label">Cover letter / message</label>
                <asp:TextBox ID="txtCover" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5" placeholder="Tell us why you're a good fit"></asp:TextBox>
              </div>

              <div class="mb-3">
                <label class="form-label">Resume (PDF / DOC / DOCX)</label>
                <asp:FileUpload ID="fileResume" runat="server" CssClass="form-control" />
                <small class="text-muted">Max size 4MB</small>
              </div>

              <div class="d-flex justify-content-between align-items-center">
                <asp:Button ID="btnApply" runat="server" CssClass="btn btn-primary-bcc" Text="Submit Application" OnClick="btnApply_Click" />
                <a href="jobs.aspx" class="btn btn-outline-secondary">Back to jobs</a>
              </div>

              <div class="mt-3">
                <asp:Label ID="lblApplyMessage" runat="server" CssClass="d-block"></asp:Label>
              </div>
            </asp:Panel>

            <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="text-center py-4">
              <h4 class="mb-2">Application submitted</h4>
              <p class="text-muted">Thank you for applying. We will contact you if your application matches the role.</p>
              <a href="jobs.aspx" class="btn btn-outline-secondary mt-3">Back to jobs</a>
            </asp:Panel>

          </div>
        </div>
      </div>
    </div>
  </section>
</asp:Content>