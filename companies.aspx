<%@ Page Language="C#" AutoEventWireup="true" CodeFile="companies.aspx.cs" Inherits="companies" MasterPageFile="~/Site.master" %>
<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">Companies | KUET Career Club</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <meta name="viewport" content="width=device-width,initial-scale=1" />
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

  <!-- header/offcanvas provided by Site.master -->

  <section class="portal-hero py-5">
    <div class="container">
      <div class="row align-items-center gy-4">
        <div class="col-lg-7">
          <h1>Companies</h1>
          <p class="lead mb-4">Discover partner companies, hiring employers, and workplace opportunities for KUET students and alumni.</p>
        </div>
        <div class="col-lg-5">
          <div class="portal-hero-card p-4">
            <h5>Discover employers</h5>
            <p class="mb-0">Review company profiles, open programs, and industry categories that work with KUET talent.</p>
          </div>
        </div>
      </div>
    </div>
  </section>

  <section class="portal-listing py-5 bg-white">
    <div class="container">
      <div class="row g-4">
        
        <div class="col-md-6">
          <article class="company-card p-4 h-100">
            <h5>TechNova Solutions</h5>
            <p class="text-muted small mb-3">A leading software house hiring engineering interns and entry-level developers.</p>
            <p class="mb-2"><strong>Focus:</strong> Software, Automation, AI</p>
            <a href="#" class="btn btn-outline-custom btn-sm">View Company</a>
          </article>
        </div>
        
        <div class="col-md-6">
          <article class="company-card p-4 h-100">
            <h5>GreenGrid Engineering</h5>
            <p class="text-muted small mb-3">Engineering firm specializing in sustainable energy systems and infrastructure.</p>
            <p class="mb-2"><strong>Focus:</strong> Energy, Power Systems, Design</p>
            <a href="#" class="btn btn-outline-custom btn-sm">View Company</a>
          </article>
        </div>
        
        <div class="col-md-6">
          <article class="company-card p-4 h-100">
            <h5>BuildWorks Ltd.</h5>
            <p class="text-muted small mb-3">Construction and development company recruiting project management and civil engineering talent.</p>
            <p class="mb-2"><strong>Focus:</strong> Construction, Civil Engineering, Project Management</p>
            <a href="#" class="btn btn-outline-custom btn-sm">View Company</a>
          </article>
        </div>
        
        <div class="col-md-6">
          <article class="company-card p-4 h-100">
            <h5>NextGen Labs</h5>
            <p class="text-muted small mb-3">Startup incubator and research partner interested in product innovation and entrepreneurship.</p>
            <p class="mb-2"><strong>Focus:</strong> R&D, Startups, Technology</p>
            <a href="#" class="btn btn-outline-custom btn-sm">View Company</a>
          </article>
        </div>

      </div>
    </div>
  </section>

</asp:Content>
