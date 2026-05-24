<%@ Page Language="C#" AutoEventWireup="true" CodeFile="alumni.aspx.cs" Inherits="alumni" MasterPageFile="~/Site.master" %>
<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">Graduate Corner | KUET Career Club</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <meta name="viewport" content="width=device-width,initial-scale=1" />
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">


    <section class="portal-hero py-5">
      <div class="container">
        <div class="row align-items-center gy-4">
          <div class="col-lg-7">
            <h1>Graduate Corner</h1>
            <p class="lead mb-4">Connect with KUET alumni, review success stories, and explore mentorship and hiring opportunities.</p>
          </div>
          <div class="col-lg-5">
            <div class="portal-hero-card p-4">
              <h5>Alumni impact</h5>
              <p>Find experienced professionals in technology, research, startups, and leadership roles.</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="portal-listing py-5 bg-white">
      <div class="container">
        <div class="row g-4">
          <div class="col-md-6 col-lg-4">
            <article class="alumni-card p-4 h-100">
              <h5>Sabbir Ahmed</h5>
              <p class="text-muted small mb-3">Final-year EEE student turned AI research intern. Experienced in machine learning, signal processing, and IoT systems.</p>
              <p class="mb-2"><strong>Skills:</strong> Python, PyTorch, TensorFlow, OpenCV</p>
              <a href="#" class="btn btn-outline-custom btn-sm">View Story</a>
            </article>
          </div>
          <div class="col-md-6 col-lg-4">
            <article class="alumni-card p-4 h-100">
              <h5>Ratul Mondal</h5>
              <p class="text-muted small mb-3">Chemical Engineering graduate with a passion for innovation and sustainability in industrial processes.</p>
              <p class="mb-2"><strong>Skills:</strong> Process Design, MATLAB, Simulation</p>
              <a href="#" class="btn btn-outline-custom btn-sm">View Story</a>
            </article>
          </div>
          <div class="col-md-6 col-lg-4">
            <article class="alumni-card p-4 h-100">
              <h5>S.M. Arnob</h5>
              <p class="text-muted small mb-3">Undergrad @ ME, active in automotive technology and product development.</p>
              <p class="mb-2"><strong>Skills:</strong> Public Speaking, Problem Solving, Teamwork</p>
              <a href="#" class="btn btn-outline-custom btn-sm">View Story</a>
            </article>
          </div>
        </div>
      </div>
    </section>


</asp:Content>
