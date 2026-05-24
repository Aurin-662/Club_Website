<%@ Page Language="C#" AutoEventWireup="true" CodeFile="help.aspx.cs" Inherits="help" MasterPageFile="~/Site.master" %>
<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">Help Center | KUET Career Club</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

  <main class="container py-5">
    <div class="bg-white rounded-4 shadow-sm p-5 mb-5">
      <div class="row align-items-center gy-4">
        <div class="col-lg-7">
          <h1 class="display-5 mb-3">Help Center</h1>
          <p class="lead text-muted">Find quick answers, support guides, and step-by-step resources for students, alumni, and employers using the KUET Career Club platform.</p>
          <p class="mb-0">Our support team is available to help with registration, profile setup, company partnerships, and event inquiries.</p>
        </div>
        <div class="col-lg-5">
          <div class="p-4 rounded-4 bg-light">
            <h5 class="mb-3">Need immediate assistance?</h5>
            <p class="text-muted mb-3">Review our FAQs or send a message through the feedback page to connect with KUET Career Club support.</p>
            <a href="feedback.aspx" class="btn text-white" style="background: #8B2D31;">Contact Support</a>
          </div>
        </div>
      </div>
    </div>

    <div class="row g-4 mb-5">
      <div class="col-md-4">
        <div class="card card-feature h-100 border-0 shadow-sm">
          <div class="card-body p-4">
            <h5 class="card-title">Student Support</h5>
            <p class="card-text text-muted">Get help with user profiles, job applications, portal access, and event registration for KUET students.</p>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card card-feature h-100 border-0 shadow-sm">
          <div class="card-body p-4">
            <h5 class="card-title">Employer Support</h5>
            <p class="card-text text-muted">Receive assistance with company sign-up, job posting, campus collaborations, and hiring event planning.</p>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card card-feature h-100 border-0 shadow-sm">
          <div class="card-body p-4">
            <h5 class="card-title">Alumni Support</h5>
            <p class="card-text text-muted">Access alumni resources, networking guides, and event participation support for KUET graduates.</p>
          </div>
        </div>
      </div>
    </div>

    <section class="bg-white rounded-4 shadow-sm p-5">
      <div class="row g-4">
        <div class="col-lg-6">
          <h2>Support Topics</h2>
          <ul class="list-unstyled text-muted mt-4">
            <li class="mb-3"><i class="bi bi-check-circle-fill text-success me-2"></i>Account setup and login issues</li>
            <li class="mb-3"><i class="bi bi-check-circle-fill text-success me-2"></i>Job application help and resume tips</li>
            <li class="mb-3"><i class="bi bi-check-circle-fill text-success me-2"></i>Event registration and partner inquiries</li>
            <li class="mb-3"><i class="bi bi-check-circle-fill text-success me-2"></i>Policy, privacy, and terms clarification</li>
          </ul>
        </div>
        <div class="col-lg-6">
          <div class="p-4 rounded-4 bg-light h-100">
            <h5>Support resources</h5>
            <p class="text-muted mb-3">Use these quick links to go directly to the right resource:</p>
            <ul class="list-unstyled">
              <li class="mb-2"><a href="faq.aspx" class="text-decoration-none">Frequently Asked Questions</a></li>
              <li class="mb-2"><a href="feedback.aspx" class="text-decoration-none">Send feedback or request help</a></li>
              <li class="mb-2"><a href="privacy.aspx" class="text-decoration-none">Privacy policy details</a></li>
              <li><a href="terms.aspx" class="text-decoration-none">Terms of service</a></li>
            </ul>
          </div>
        </div>
      </div>
    </section>

  </main>


</asp:Content>
