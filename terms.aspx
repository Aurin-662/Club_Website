<%@ Page Language="C#" AutoEventWireup="true" CodeFile="terms.aspx.cs" Inherits="terms" MasterPageFile="~/Site.master" %>
<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">Terms of Service | KUET Career Club</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <link rel="stylesheet" href="style.css" />
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="container py-5">
      <div class="bg-white rounded-4 shadow-sm p-5 mb-5">
        <div class="row align-items-center gy-4">
          <div class="col-lg-7">
            <h1 class="display-5 mb-3">Terms of Service</h1>
            <p class="lead text-muted">These terms define how KUET Career Club operates and what you agree to when using the platform.</p>
            <p class="mb-0">By using our site, you accept these terms and agree to behave respectfully and responsibly.</p>
          </div>
          <div class="col-lg-5">
            <div class="p-4 rounded-4 bg-light">
              <h5 class="mb-3">User expectations</h5>
              <p class="text-muted mb-0">Keep your profile accurate, respect others, and use the platform for legitimate career activities.</p>
            </div>
          </div>
        </div>
      </div>

      <section class="bg-white rounded-4 shadow-sm p-5 mb-4">
        <h2>Account Use</h2>
        <p class="text-muted">Users must provide accurate information when registering and are responsible for safeguarding their login credentials.</p>
      </section>

      <section class="bg-white rounded-4 shadow-sm p-5 mb-4">
        <h2>Allowed Activities</h2>
        <p class="text-muted">KUET Career Club is for career networking, job discovery, event registration, and academic collaboration.</p>
        <ul class="list-unstyled text-muted">
          <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i>Post and apply for relevant opportunities</li>
          <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i>Communicate professionally with students and employers</li>
          <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i>Submit feedback and request support</li>
        </ul>
      </section>

      <section class="bg-white rounded-4 shadow-sm p-5 mb-4">
        <h2>Prohibited Conduct</h2>
        <p class="text-muted">Users may not misuse the site, harass others, post false information, or upload inappropriate content.</p>
        <ul class="list-unstyled text-muted">
          <li class="mb-2"><i class="bi bi-x-circle-fill text-danger me-2"></i>No fraud, harassment, or unauthorized data sharing</li>
          <li class="mb-2"><i class="bi bi-x-circle-fill text-danger me-2"></i>No copyrighted material without permission</li>
          <li class="mb-2"><i class="bi bi-x-circle-fill text-danger me-2"></i>No impersonation or misleading profiles</li>
        </ul>
      </section>

      <section class="bg-white rounded-4 shadow-sm p-5">
        <h2>Disclaimer</h2>
        <p class="text-muted mb-0">KUET Career Club does not guarantee placement, and all job decisions are made by employers. We provide a platform for connections and information only.</p>
      </section>
    </main>

</asp:Content>
