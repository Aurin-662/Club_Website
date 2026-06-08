<%@ Page Language="C#" AutoEventWireup="true" CodeFile="alumni.aspx.cs" Inherits="alumni" MasterPageFile="~/Site.master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">Graduate Corner | KUET Career Club</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <style>
    .alumni-skills span { display: inline-block; background: #eef2f6; color: #475569; padding: 2px 8px; border-radius: 4px; font-size: 0.75rem; margin-right: 4px; margin-bottom: 4px; font-weight: 500; }
    .portal-hero-card { background: #f8fafc; border-left: 4px solid #ffcc00; border-radius: 8px; }
    .btn-outline-custom { border: 1px solid #004080; color: #004080; transition: 0.2s; font-weight: 600; }
    .btn-outline-custom:hover { background: #004080; color: white; }
  </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <section class="portal-hero py-5" style="background: linear-gradient(135deg, #ffffff 0%, #f4f9ff 100%);">
      <div class="container">
        <div class="row align-items-center gy-4">
          <div class="col-lg-7">
            <h1 class="fw-bold text-dark">Graduate Corner</h1>
            <p class="lead text-muted mb-4">Connect with KUET alumni, review success stories, and explore mentorship and hiring opportunities.</p>
          </div>
          <div class="col-lg-5">
            <div class="portal-hero-card p-4 shadow-sm bg-white">
              <h5 class="fw-bold text-dark"><i class="bi bi-mortarboard-fill text-warning me-2"></i>Alumni Impact</h5>
              <p class="text-muted small mb-0">Find experienced professionals in technology, research, engineering industries, startups, and global leadership roles.</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="portal-listing py-5 bg-white">
      <div class="container">
        <div class="row g-4">
          <asp:Repeater ID="rptAlumni" runat="server">
            <ItemTemplate>
              <div class="col-md-6 col-lg-4 alumni-item" 
                   data-name='<%# HttpUtility.HtmlAttributeEncode(Eval("FullName").ToString()) %>'
                   data-story='<%# HttpUtility.HtmlAttributeEncode(Eval("FullStory").ToString()) %>'>
                <article class="alumni-card p-4 h-100 shadow-sm border rounded-3 d-flex flex-column">
                  <h5 class="fw-bold text-dark mb-2"><%# Eval("FullName") %></h5>
                  <p class="text-secondary small mb-3 flex-grow-1"><%# Convert.ToString(Eval("DesignationBio")) %></p>
                  
                  <div class="mb-3">
                    <strong class="small d-block text-muted mb-1">Skills:</strong>
                    <div class="alumni-skills">
                        <%# RenderSkills(Convert.ToString(Eval("Skills"))) %>
                    </div>
                  </div>
                  <a href="#" class="btn btn-outline-custom btn-sm btn-view-story w-100 mt-auto">View Story</a>
                </article>
              </div>
            </ItemTemplate>
          </asp:Repeater>
        </div>
      </div>
    </section>

    <div class="modal fade" id="storyModal" tabindex="-1" aria-labelledby="storyModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">
          <div class="modal-header bg-light">
            <h5 class="modal-title fw-bold text-dark" id="storyModalLabel">Success Story</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body p-4">
            <p id="storyContent" class="text-secondary" style="line-height: 1.6; white-space: pre-line;"></p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            document.addEventListener('click', function (e) {
                if (e.target && e.target.classList.contains('btn-view-story')) {
                    e.preventDefault();
                    
                    var card = e.target.closest('.alumni-item');
                    if (!card) return;

                    var name = card.dataset.name || '';
                    var story = card.dataset.story || 'No extended story drafted yet.';

                    document.getElementById('storyModalLabel').textContent = name + "'s Success Journey";
                    document.getElementById('storyContent').textContent = story;

                    var bsModal = new bootstrap.Modal(document.getElementById('storyModal'));
                    bsModal.show();
                }
            });
        });
    </script>
</asp:Content>