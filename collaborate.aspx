<%@ Page Language="C#" AutoEventWireup="true" CodeFile="collaborate.aspx.cs" Inherits="collaborate" MasterPageFile="~/Site.master" %>
<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">Collaborate | KUET Career Club</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <meta name="viewport" content="width=device-width,initial-scale=1">
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

  <!-- Header and mobile menu removed to avoid duplication with Site.master master page -->

  <main class="container py-5">
    <div class="bg-white rounded-4 shadow-sm p-5 mb-5">
      <div class="row align-items-center gy-4">
        <div class="col-lg-7">
          <h1 class="display-5 mb-3">Collaborate with KUET Career Club</h1>
          <p class="lead text-muted">Bring industry, students, and alumni together through strategic partnerships, campus events, and talent pipelines designed for engineering excellence.</p>
          <p class="mb-0">Our collaboration platform helps corporate teams sponsor events, hire interns, host workshops, and launch projects with KUET’s brightest students.</p>
        </div>
        <div class="col-lg-5">
          <div class="p-4 rounded-4 bg-light">
            <h5 class="mb-3">Start a partnership</h5>
            <p class="text-muted">Submit your collaboration interest and our team will reach out with the best match for your goals.</p>
            <asp:Button ID="btnSubmitCollab" runat="server" ClientIDMode="Static" CssClass="btn text-white" Text="Submit Collaboration Request" style="background: #8B2D31;" PostBackUrl="~/feedback.aspx" />
          </div>
        </div>
      </div>
    </div>

    <div class="row g-4 mb-5">
      <div class="col-md-4">
        <div class="card card-feature h-100 border-0 shadow-sm">
          <div class="card-body">
            <h5 class="card-title">Industry Partnerships</h5>
            <p class="card-text text-muted">Work with KUET departments on recruiting, research projects, and co-branded career events tailored to engineering majors.</p>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card card-feature h-100 border-0 shadow-sm">
          <div class="card-body">
            <h5 class="card-title">Campus Events</h5>
            <p class="card-text text-muted">Host workshops, hackathons, and career fairs that connect your company directly with motivated KUET students and alumni.</p>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card card-feature h-100 border-0 shadow-sm">
          <div class="card-body">
            <h5 class="card-title">Student Projects</h5>
            <p class="card-text text-muted">Sponsor real-world student challenges, capstone projects, and internship collaborations to solve business problems.</p>
          </div>
        </div>
      </div>
    </div>

    <section class="bg-white rounded-4 shadow-sm p-5">
      <div class="row g-4">
        <div class="col-lg-6">
          <h2>Partner Inquiry Form</h2>
          <p class="text-muted">Tell us about your collaboration goals and we’ll help design a KUET partnership that fits your timeline and needs.</p>
          
          <div class="mb-3">
            <label class="form-label">Organization Name</label>
            <asp:TextBox ID="txtOrgName" runat="server" ClientIDMode="Static" CssClass="form-control" placeholder="Enter your organization"></asp:TextBox>
          </div>
          <div class="mb-3">
            <label class="form-label">Contact Email</label>
            <asp:TextBox ID="txtOrgEmail" runat="server" ClientIDMode="Static" CssClass="form-control" TextMode="Email" placeholder="name@company.com"></asp:TextBox>
          </div>
          <div class="mb-3">
            <label class="form-label">Collaboration Interest</label>
            <asp:DropDownList ID="ddlCollabInterest" runat="server" ClientIDMode="Static" CssClass="form-select">
              <asp:ListItem Text="Select type" Value="" Selected="True"></asp:ListItem>
              <asp:ListItem Text="Recruitment & Internships" Value="Recruitment"></asp:ListItem>
              <asp:ListItem Text="Hackathon / Workshop" Value="Workshop"></asp:ListItem>
              <asp:ListItem Text="Research Project" Value="Research"></asp:ListItem>
              <asp:ListItem Text="Event Sponsorship" Value="Sponsorship"></asp:ListItem>
            </asp:DropDownList>
          </div>
          <div class="mb-3">
            <label class="form-label">Message</label>
            <asp:TextBox ID="txtCollabMessage" runat="server" ClientIDMode="Static" CssClass="form-control" TextMode="MultiLine" Rows="4" placeholder="Tell us about your initiative"></asp:TextBox>
          </div>
          <asp:Button ID="btnSendInquiry" runat="server" ClientIDMode="Static" CssClass="btn text-white" style="background: #8B2D31;" Text="Send Inquiry" UseSubmitBehavior="true" />
        </div>
        <div class="col-lg-6">
          <div class="p-4 rounded-4 bg-light h-100">
            <h5>Why collaborate with us?</h5>
            <ul class="list-unstyled text-muted mt-3">
              <li class="mb-3"><i class="bi bi-check-circle-fill text-success me-2"></i>Access trained KUET talent across engineering disciplines.</li>
              <li class="mb-3"><i class="bi bi-check-circle-fill text-success me-2"></i>Build custom campus programming and project-based learning.</li>
              <li class="mb-3"><i class="bi bi-check-circle-fill text-success me-2"></i>Grow brand visibility among students and alumni nationwide.</li>
            </ul>
            <p class="mb-0"><strong>Email us:</strong> <a href="mailto:collaborate@kuetcareerclub.edu">collaborate@kuetcareerclub.edu</a></p>
          </div>
        </div>
      </div>
    </section>
  </main>


</asp:Content>
