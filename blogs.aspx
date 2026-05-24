<%@ Page Language="C#" AutoEventWireup="true" CodeFile="blogs.aspx.cs" Inherits="blogs" MasterPageFile="~/Site.master" %>
<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <meta name="viewport" content="width=device-width,initial-scale=1" />
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Navigation is provided by Site.master; removed page-level header/offcanvas to avoid duplicates -->

    <section class="blog-header py-5">
      <div class="container text-center">
        <div class="d-flex justify-content-center align-items-center gap-2 mb-2">
          <i class="bi bi-journal-text fs-3 text-danger"></i>
          <h1 class="fw-bold mb-0" style="color: #2d3748;">Knowledge Hub & Insights</h1>
        </div>
        <p class="text-muted mb-4">Read career roadmaps, placement stories, and preparation guides from the KUET community.</p>
        <div class="blog-search-bar mb-4">
          <div class="input-group mx-auto" style="max-width:560px;">
            <span class="input-group-text bg-white border-end-0"><i class="bi bi-search text-muted"></i></span>
            <asp:TextBox ID="txtSearch" runat="server" ClientIDMode="Static" CssClass="form-control border-start-0 p-2" placeholder="Search resources or keywords..."></asp:TextBox>
          </div>
        </div>
        <div class="d-flex justify-content-center gap-2 flex-wrap">
          <button type="button" class="btn btn-dark blog-category-btn">All Articles</button>
          <button type="button" class="btn btn-outline-secondary blog-category-btn">Software Engineering</button>
          <button type="button" class="btn btn-outline-secondary blog-category-btn">Interview Prep</button>
          <button type="button" class="btn btn-outline-secondary blog-category-btn">Higher Education</button>
        </div>
      </div>
    </section>

    <main class="container py-5">
      <div class="row gy-4">
        <div class="col-xl-8">
          <div class="row g-4">
            <div class="col-md-6">
              <div class="bcc-blog-card h-100">
                <div class="card-body p-4 d-flex flex-column">
                  <div class="d-flex gap-2 mb-3 flex-wrap">
                    <span class="blog-badge badge-tech"><i class="bi bi-laptop me-1"></i>Tech Career</span>
                    <span class="blog-badge badge-featured"><i class="bi bi-bookmark-star-fill me-1"></i>Featured</span>
                  </div>
                  <h3 class="blog-title">Cracking the Software Engineering Interview</h3>
                  <p class="blog-description my-3">A deep-dive template explaining how KUET graduates passed interviews at top local and international tech firms, with a practical interview preparation timeline.</p>
                  <div class="mt-auto pt-3 border-top d-flex align-items-center justify-content-between">
                    <small class="text-muted"><i class="bi bi-calendar3 me-1"></i> May 2026</small>
                    <a href="#" class="btn btn-bcc-read">Read Article</a>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-md-6">
              <div class="bcc-blog-card h-100">
                <div class="card-body p-4 d-flex flex-column">
                  <div class="d-flex gap-2 mb-3">
                    <span class="blog-badge badge-career"><i class="bi bi-file-earmark-person me-1"></i>Resume Tips</span>
                  </div>
                  <h3 class="blog-title">Resume & CV Formatting Guide</h3>
                  <p class="blog-description my-3">Standard guidelines to pass ATS screening, with advice on highlighting lab projects, Git contributions, and internship accomplishments.</p>
                  <div class="mt-auto pt-3 border-top d-flex align-items-center justify-content-between">
                    <small class="text-muted"><i class="bi bi-calendar3 me-1"></i> April 2026</small>
                    <a href="#" class="btn btn-bcc-read">Read Article</a>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-md-6">
              <div class="bcc-blog-card h-100">
                <div class="card-body p-4 d-flex flex-column">
                  <div class="d-flex gap-2 mb-3">
                    <span class="blog-badge badge-higher-ed"><i class="bi bi-globe me-1"></i>Higher Ed</span>
                  </div>
                  <h3 class="blog-title">Post-Graduation Masters & PhD Plans</h3>
                  <p class="blog-description my-3">Balancing GRE, TOEFL, and research publication timelines with final-year course schedules and application planning.</p>
                  <div class="mt-auto pt-3 border-top d-flex align-items-center justify-content-between">
                    <small class="text-muted"><i class="bi bi-calendar3 me-1"></i> March 2026</small>
                    <a href="#" class="btn btn-bcc-read">Read Article</a>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-md-6">
              <div class="bcc-blog-card h-100">
                <div class="card-body p-4 d-flex flex-column">
                  <div class="d-flex gap-2 mb-3">
                    <span class="blog-badge badge-career"><i class="bi bi-people me-1"></i>HR Rounds</span>
                  </div>
                  <h3 class="blog-title">Mastering Behavioral Interview Stories</h3>
                  <p class="blog-description my-3">How to frame engineering challenges and campus projects into compelling STAR-style responses for HR and leadership rounds.</p>
                  <div class="mt-auto pt-3 border-top d-flex align-items-center justify-content-between">
                    <small class="text-muted"><i class="bi bi-calendar3 me-1"></i> February 2026</small>
                    <a href="#" class="btn btn-bcc-read">Read Article</a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <aside class="col-xl-4">
          <div class="blog-aside-card mb-4">
            <h4>Quick links</h4>
            <ul class="list-unstyled mb-0">
              <li><a href="#">Latest stories</a></li>
              <li><a href="#">Interview preparation</a></li>
              <li><a href="#">CV & cover letters</a></li>
              <li><a href="#">Graduate study plans</a></li>
            </ul>
          </div>

          <div class="blog-aside-card mb-4">
            <h4>Popular categories</h4>
            <ul class="list-unstyled mb-0">
              <li><a href="#">Campus life</a></li>
              <li><a href="#">Career advice</a></li>
              <li><a href="#">Events & workshops</a></li>
              <li><a href="#">Success stories</a></li>
            </ul>
          </div>

          <div class="blog-aside-card">
            <h4>Need help?</h4>
            <p class="text-muted">Contact the KUET Career Club team for blog contributions, guest posts, or event coverage.</p>
            <p class="mb-0"><strong>Email:</strong> <a href="mailto:contact@kuetcareerclub.bd">contact@kuetcareerclub.bd</a></p>
          </div>
        </aside>
      </div>
    </main>


</asp:Content>
