<%@ Page Language="C#" AutoEventWireup="true" CodeFile="jobs.aspx.cs" Inherits="jobs" MasterPageFile="~/Site.master" %>
<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">Jobs &amp; Internships | KUET Career Club</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

  <section class="portal-hero py-5">
    <div class="container">
      <div class="row align-items-center gy-4">
        <div class="col-lg-7">
          <h1>Jobs &amp; Internships</h1>
          <p class="lead mb-4">Search current openings, internships and work-study opportunities for KUET students and alumni.</p>
        </div>
        <div class="col-lg-5">
          <div class="portal-hero-card p-4">
            <h5>Ready to apply?</h5>
            <p class="mb-0">Filter roles by department, type, and location to find the best fit.</p>
          </div>
        </div>
      </div>
    </div>
  </section>

  <section class="portal-search-section py-5 bg-white border-bottom">
    <div class="container">
      <div class="row g-3 align-items-end">
        <div class="col-md-5">
          <asp:TextBox ID="jobSearch" runat="server" ClientIDMode="Static" CssClass="form-control" TextMode="Search" placeholder="Search jobs, companies or skills"></asp:TextBox>
        </div>
        <div class="col-md-3">
          <asp:DropDownList ID="jobCategory" runat="server" ClientIDMode="Static" CssClass="form-select">
            <asp:ListItem Value="all">All Departments</asp:ListItem>
            <asp:ListItem Value="CSE">CSE</asp:ListItem>
            <asp:ListItem Value="EEE">EEE</asp:ListItem>
            <asp:ListItem Value="ME">ME</asp:ListItem>
            <asp:ListItem Value="Civil">Civil</asp:ListItem>
          </asp:DropDownList>
        </div>
        <div class="col-md-2">
          <asp:DropDownList ID="jobType" runat="server" ClientIDMode="Static" CssClass="form-select">
            <asp:ListItem Value="all">All Types</asp:ListItem>
            <asp:ListItem Value="Full-time">Full-time</asp:ListItem>
            <asp:ListItem Value="Internship">Internship</asp:ListItem>
            <asp:ListItem Value="Part-time">Part-time</asp:ListItem>
          </asp:DropDownList>
        </div>
        <div class="col-md-2 d-grid">
          <asp:Button ID="clearJobFilters" runat="server" ClientIDMode="Static" CssClass="btn btn-outline-custom" Text="Clear" UseSubmitBehavior="false" OnClientClick="clearJobFiltersClient(); return false;" />
        </div>
      </div>
    </div>
  </section>

  <section class="portal-listing py-5">
    <div class="container">
      <div class="row g-4" id="jobGrid">

        <div class="col-md-6">
          <article class="job-card p-4 h-100" data-title="Software Engineer Intern" data-company="TechNova Solutions" data-department="CSE" data-type="Internship">
            <div class="d-flex justify-content-between align-items-start mb-3">
              <div>
                <h5>Software Engineer Intern</h5>
                <p class="text-muted small mb-0">TechNova Solutions</p>
              </div>
              <span class="badge bg-info">Internship</span>
            </div>
            <p class="text-muted mb-3">Support web applications, automation and product development.</p>
            <p class="small text-muted mb-3"><strong>Location:</strong> Dhaka</p>
            <a href="#" class="btn btn-outline-custom btn-sm">View Details</a>
          </article>
        </div>

        <div class="col-md-6">
          <article class="job-card p-4 h-100" data-title="Electrical Design Engineer" data-company="GreenGrid Engineering" data-department="EEE" data-type="Full-time">
            <div class="d-flex justify-content-between align-items-start mb-3">
              <div>
                <h5>Electrical Design Engineer</h5>
                <p class="text-muted small mb-0">GreenGrid Engineering</p>
              </div>
              <span class="badge bg-success">Full-time</span>
            </div>
            <p class="text-muted mb-3">Design power systems and contribute to green energy engineering.</p>
            <p class="small text-muted mb-3"><strong>Location:</strong> Chittagong</p>
            <a href="#" class="btn btn-outline-custom btn-sm">View Details</a>
          </article>
        </div>

        <div class="col-md-6">
          <article class="job-card p-4 h-100" data-title="Project Coordinator" data-company="BuildWorks Ltd." data-department="Civil" data-type="Part-time">
            <div class="d-flex justify-content-between align-items-start mb-3">
              <div>
                <h5>Project Coordinator</h5>
                <p class="text-muted small mb-0">BuildWorks Ltd.</p>
              </div>
              <span class="badge bg-warning text-dark">Part-time</span>
            </div>
            <p class="text-muted mb-3">Coordinate construction schedules and project communications.</p>
            <p class="small text-muted mb-3"><strong>Location:</strong> Khulna</p>
            <a href="#" class="btn btn-outline-custom btn-sm">View Details</a>
          </article>
        </div>

        <div class="col-md-6">
          <article class="job-card p-4 h-100" data-title="Product Analyst" data-company="NextGen Labs" data-department="CSE" data-type="Full-time">
            <div class="d-flex justify-content-between align-items-start mb-3">
              <div>
                <h5>Product Analyst</h5>
                <p class="text-muted small mb-0">NextGen Labs</p>
              </div>
              <span class="badge bg-success">Full-time</span>
            </div>
            <p class="text-muted mb-3">Analyze product requirements and support user testing workflows.</p>
            <p class="small text-muted mb-3"><strong>Location:</strong> Dhaka</p>
            <a href="#" class="btn btn-outline-custom btn-sm">View Details</a>
          </article>
        </div>

      </div>
    </div>
  </section>

  <script>
      document.addEventListener('DOMContentLoaded', function () {
          var cards = document.querySelectorAll('#jobGrid .job-card');
          var search = document.getElementById('jobSearch');
          var category = document.getElementById('jobCategory');
          var type = document.getElementById('jobType');

          function filterJobs() {
              var query = (search ? search.value : '').trim().toLowerCase();
              var cat = category ? category.value : 'all';
              var typeValue = type ? type.value : 'all';

              cards.forEach(function (card) {
                  var title = (card.dataset.title || '').toLowerCase();
                  var company = (card.dataset.company || '').toLowerCase();
                  var matchesQuery = query === '' || title.includes(query) || company.includes(query);
                  var matchesCategory = cat === 'all' || card.dataset.department === cat;
                  var matchesType = typeValue === 'all' || card.dataset.type === typeValue;

                  card.style.display = matchesQuery && matchesCategory && matchesType ? '' : 'none';
              });
          }

          if (search) search.addEventListener('input', filterJobs);
          if (category) category.addEventListener('change', filterJobs);
          if (type) type.addEventListener('change', filterJobs);

          // expose global for clear button
          window.refreshJobFilters = filterJobs;
      });

      function clearJobFiltersClient() {
          var s = document.getElementById('jobSearch'); if (s) s.value = '';
          var cat = document.getElementById('jobCategory'); if (cat) cat.value = 'all';
          var t = document.getElementById('jobType'); if (t) t.value = 'all';
          if (typeof window.refreshJobFilters === 'function') window.refreshJobFilters();
      }
  </script>

</asp:Content>
