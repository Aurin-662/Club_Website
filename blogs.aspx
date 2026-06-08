<%@ Page Language="C#" AutoEventWireup="true" CodeFile="blogs.aspx.cs" Inherits="blogs" MasterPageFile="~/Site.master" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <style>
    .bcc-blog-card { border: 1px solid rgba(0,0,0,0.08); border-radius: 12px; transition: all 0.3s ease; background: #fff; }
    .bcc-blog-card:hover { transform: translateY(-4px); box-shadow: 0 10px 20px rgba(0,0,0,0.05); }
    .blog-badge { padding: 4px 10px; border-radius: 20px; font-size: 0.75rem; font-weight: 600; text-transform: uppercase; }
    .badge-tech { background: #eef6ff; color: #004080; }
    .blog-aside-card { background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 12px; padding: 20px; }
    .blog-title { font-size: 1.35rem; font-weight: 700; color: #1a202c; }
  </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <section class="blog-header py-5" style="background: linear-gradient(135deg, #f8fafc 0%, #eef6ff 100%);">
      <div class="container text-center">
        <div class="d-flex justify-content-center align-items-center gap-2 mb-2">
          <i class="bi bi-journal-text fs-3 text-primary"></i>
          <h1 class="fw-bold mb-0" style="color: #2d3748;">Knowledge Hub & Insights</h1>
        </div>
        <p class="text-muted mb-4">Read career roadmaps, placement stories, and preparation guides from the KUET community.</p>
        
        <div class="blog-search-bar mb-4">
          <div class="input-group mx-auto" style="max-width:560px;">
            <span class="input-group-text bg-white border-end-0"><i class="bi bi-search text-muted"></i></span>
            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control border-start-0 p-2" placeholder="Search resources or keywords..." AutoPostBack="true" OnTextChanged="txtSearch_TextChanged"></asp:TextBox>
          </div>
        </div>

        <div class="d-flex justify-content-center gap-2 flex-wrap">
          <asp:LinkButton ID="btnAll" runat="server" CssClass="btn btn-dark blog-category-btn" OnClick="FilterCategory_Click" CommandArgument="All">All Articles</asp:LinkButton>
          <asp:LinkButton ID="btnSE" runat="server" CssClass="btn btn-outline-secondary blog-category-btn" OnClick="FilterCategory_Click" CommandArgument="Software Engineering">Software Engineering</asp:LinkButton>
          <asp:LinkButton ID="btnIP" runat="server" CssClass="btn btn-outline-secondary blog-category-btn" OnClick="FilterCategory_Click" CommandArgument="Interview Prep">Interview Prep</asp:LinkButton>
          <asp:LinkButton ID="btnHE" runat="server" CssClass="btn btn-outline-secondary blog-category-btn" OnClick="FilterCategory_Click" CommandArgument="Higher Education">Higher Education</asp:LinkButton>
        </div>
      </div>
    </section>

    <main class="container py-5">
      <div class="row gy-4">
        <div class="col-xl-8">
          
          <asp:Panel ID="pnlNoArticles" runat="server" Visible="false" CssClass="text-center py-5 border rounded-3 bg-white">
             <i class="bi bi-patch-question text-muted display-4"></i>
             <h5 class="mt-3 text-secondary fw-bold">No match found!</h5>
             <p class="text-muted mb-0">Try searching with another keyword or change the category.</p>
          </asp:Panel>

          <div class="row g-4">
            <asp:Repeater ID="rptArticles" runat="server">
              <ItemTemplate>
                <div class="col-md-6">
                  <div class="bcc-blog-card h-100">
                    <div class="card-body p-4 d-flex flex-column">
                      <div class="d-flex gap-2 mb-3 flex-wrap">
                        <span class="blog-badge badge-tech"><i class="bi bi-tag-fill me-1"></i><%# Eval("Category") %></span>
                      </div>
                      <h3 class="blog-title"><%# Eval("Title") %></h3>
                      <p class="blog-description my-3 text-muted small"><%# Eval("Summary") %></p>
                      <div class="mt-auto pt-3 border-top d-flex align-items-center justify-content-between">
                        <small class="text-muted"><i class="bi bi-calendar3 me-1"></i><%# Eval("PublishedAt", "{0:MMM yyyy}") %></small>
                        <a href='<%# "article.aspx?id=" + Eval("Slug") %>' class="btn btn-primary btn-sm fw-bold px-3 rounded-2">Read Article <i class="bi bi-arrow-right"></i></a>
                      </div>
                    </div>
                  </div>
                </div>
              </ItemTemplate>
            </asp:Repeater>
          </div>
        </div>

        <aside class="col-xl-4">
          <div class="blog-aside-card mb-4">
            <h4 class="fw-bold mb-3" style="font-size:1.1rem;">Quick Links</h4>
            <ul class="list-unstyled mb-0 d-flex flex-column gap-2">
              <li><a href="blogs.aspx" class="text-decoration-none text-secondary small"><i class="bi bi-chevron-right me-1"></i>Latest Stories</a></li>
              <li><a href="blogs.aspx?cat=Interview Prep" class="text-decoration-none text-secondary small"><i class="bi bi-chevron-right me-1"></i>Interview Preparation</a></li>
              <li><a href="blogs.aspx?cat=Software Engineering" class="text-decoration-none text-secondary small"><i class="bi bi-chevron-right me-1"></i>CV & Cover Letters</a></li>
            </ul>
          </div>

          <div class="blog-aside-card">
            <h4 class="fw-bold mb-2" style="font-size:1.1rem;">Need Help?</h4>
            <p class="text-muted small">Contact the KUET Career Club team for blog contributions, guest posts, or event coverage.</p>
            <p class="mb-0 small"><strong>Email:</strong> <a href="mailto:contact@kuetcareerclub.bd" class="text-primary text-decoration-none">contact@kuetcareerclub.bd</a></p>
          </div>
        </aside>
      </div>
    </main>
</asp:Content>