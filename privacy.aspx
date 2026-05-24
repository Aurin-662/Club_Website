<%@ Page Language="C#" AutoEventWireup="true" CodeFile="privacy.aspx.cs" Inherits="privacy" MasterPageFile="~/Site.master" %>
<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">Privacy Policy | KUET Career Club</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

  <main class="container py-5">
    <div class="bg-white rounded-4 shadow-sm p-5 mb-5">
      <div class="row align-items-center gy-4">
        <div class="col-lg-7">
          <h1 class="display-5 mb-3">Privacy Policy</h1>
          <p class="lead text-muted">Learn how KUET Career Club collects, uses, and protects your personal information while you use the platform.</p>
          <p class="mb-0">Your privacy is important to us. We strive to keep your data secure and transparent.</p>
        </div>
        <div class="col-lg-5">
          <div class="p-4 rounded-4 bg-light">
            <h5 class="mb-3">Data protection</h5>
            <p class="text-muted mb-0">We only process the information required to support your career journey, job applications, and partner connections.</p>
          </div>
        </div>
      </div>
    </div>

    <section class="bg-white rounded-4 shadow-sm p-5 mb-4">
      <h2>Information We Collect</h2>
      <p class="text-muted">We collect profile details, contact information, academic department, skills, and resume data when you register and use KUET Career Club.</p>
      <ul class="list-unstyled text-muted">
        <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i>Profile names, email addresses, and department details</li>
        <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i>Resume files, skills, and project summaries</li>
        <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i>Application history, event participation, and feedback messages</li>
      </ul>
    </section>

    <section class="bg-white rounded-4 shadow-sm p-5 mb-4">
      <h2>How We Use Your Data</h2>
      <p class="text-muted">Your information is used to improve your experience, connect you with employers, and deliver relevant career opportunities.</p>
      <ul class="list-unstyled text-muted">
        <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i>Manage account registration and authentication</li>
        <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i>Share profiles with employers for job matching</li>
        <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i>Improve site features and support services</li>
      </ul>
    </section>

    <section class="bg-white rounded-4 shadow-sm p-5 mb-4">
      <h2>Security and Sharing</h2>
      <p class="text-muted">We protect your data with appropriate security measures and never sell your personal information to third parties.</p>
      <p class="text-muted mb-0">Authorized employers may view your profile only after you submit applications or approve connections.</p>
    </section>

    <section class="bg-white rounded-4 shadow-sm p-5">
      <h2>Your Choices</h2>
      <p class="text-muted">You can update your profile, change notification preferences, and request support through our Feedback page.</p>
      <p class="mb-0"><strong>Contact:</strong> <a href="mailto:privacy@kuetcareerclub.edu">privacy@kuetcareerclub.edu</a></p>
    </section>

  </main>


</asp:Content>
