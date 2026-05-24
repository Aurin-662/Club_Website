<%@ Page Language="C#" AutoEventWireup="true" CodeFile="support.aspx.cs" Inherits="support" MasterPageFile="~/Site.master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">Support KUET | KUET Career Club</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <!-- head overrides if needed -->
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">


    <section class="portal-hero py-5">
      <div class="container">
        <div class="row align-items-center gy-4">
          <div class="col-lg-7">
            <h1>Support KUET</h1>
            <p class="lead mb-4">Help KUET career initiatives grow through mentorship, sponsorship, and platform support.</p>
          </div>
          <div class="col-lg-5">
            <div class="portal-hero-card p-4">
              <h5>Ways to support</h5>
              <p>Share expertise, sponsor events, or help students access professional development programs.</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="portal-listing py-5 bg-white">
      <div class="container">
        <div class="row g-4">
          <div class="col-md-6 col-lg-4">
            <article class="company-card p-4 h-100">
              <h5>Mentorship</h5>
              <p class="text-muted small mb-3">Volunteer time to guide students through career planning, interviews, and industry transitions.</p>
              <a href="#" class="btn btn-outline-custom btn-sm">Get Involved</a>
            </article>
          </div>
          <div class="col-md-6 col-lg-4">
            <article class="company-card p-4 h-100">
              <h5>Sponsorship</h5>
              <p class="text-muted small mb-3">Support student events, competitions, and professional development scholarships.</p>
              <a href="#" class="btn btn-outline-custom btn-sm">Sponsor an Event</a>
            </article>
          </div>
          <div class="col-md-6 col-lg-4">
            <article class="company-card p-4 h-100">
              <h5>Resources</h5>
              <p class="text-muted small mb-3">Provide technical resources, training materials, or project collaboration opportunities.</p>
              <a href="#" class="btn btn-outline-custom btn-sm">Share Resources</a>
            </article>
          </div>
        </div>
      </div>
    </section>


</asp:Content>
