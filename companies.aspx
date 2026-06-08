<%@ Page Language="C#" AutoEventWireup="true" CodeFile="companies.aspx.cs" Inherits="companies" MasterPageFile="~/Site.master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">Companies | KUET Career Club</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <style>
    .portal-hero-card { background: #f8fafc; border-left: 4px solid #ffcc00; border-radius: 8px; }
    .btn-outline-custom { border: 1px solid #004080; color: #004080; transition: 0.2s; font-weight: 600; }
    .btn-outline-custom:hover { background: #004080; color: white; }
    .company-card { background: #ffffff; border: 1px solid rgba(0,0,0,0.08); border-radius: 12px; transition: transform 0.2s, box-shadow 0.2s; }
    .company-card:hover { transform: translateY(-3px); box-shadow: 0 10px 20px rgba(0,0,0,0.05); }
  </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
  <section class="portal-hero py-5" style="background: linear-gradient(135deg, #ffffff 0%, #f4f9ff 100%);">
    <div class="container">
      <div class="row align-items-center gy-4">
        <div class="col-lg-7">
          <h1 class="fw-bold text-dark">Companies</h1>
          <p class="lead text-muted mb-4">Discover partner companies, hiring employers, and workplace opportunities for KUET students and alumni.</p>
        </div>
        <div class="col-lg-5">
          <div class="portal-hero-card p-4 shadow-sm bg-white">
            <h5 class="fw-bold text-dark"><i class="bi bi-building-check text-warning me-2"></i>Discover Employers</h5>
            <p class="mb-0 text-muted small">Review company profiles, open programs, and industry categories that work closely with KUET talent pool.</p>
          </div>
        </div>
      </div>
    </div>
  </section>

  <section class="portal-listing py-5 bg-white">
    <div class="container">
      <div class="row g-4">
        <asp:Repeater ID="rptCompanies" runat="server">
          <ItemTemplate>
            <div class="col-md-6 company-item" 
                 data-name='<%# HttpUtility.HtmlAttributeEncode(Eval("CompanyName").ToString()) %>'
                 data-focus='<%# HttpUtility.HtmlAttributeEncode(Eval("FocusArea").ToString()) %>'
                 data-profile='<%# HttpUtility.HtmlAttributeEncode(Eval("FullProfile").ToString()) %>'
                 data-url='<%# HttpUtility.HtmlAttributeEncode(Eval("WebsiteUrl").ToString()) %>'>
              <article class="company-card p-4 h-100 d-flex flex-column">
                <h5 class="fw-bold text-dark mb-2"><%# Convert.ToString(Eval("CompanyName")) %></h5>
                <p class="text-secondary small mb-3 flex-grow-1"><%# Convert.ToString(Eval("ShortDescription")) %></p>
                <p class="mb-3 small"><strong>Focus:</strong> <span class="text-primary"><%# Convert.ToString(Eval("FocusArea")) %></span></p>
                <a href="#" class="btn btn-outline-custom btn-sm btn-view-company w-100 mt-auto">View Company</a>
              </article>
            </div>
          </ItemTemplate>
        </asp:Repeater>
      </div>
    </div>
  </section>

  <div class="modal fade" id="companyModal" tabindex="-1" aria-labelledby="companyModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-md">
      <div class="modal-content border-0 shadow">
        <div class="modal-header bg-light">
          <h5 class="modal-title fw-bold text-dark" id="companyModalLabel">Company Profile</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body p-4">
          <div class="mb-3">
             <span class="badge bg-secondary-subtle text-dark p-2" id="modalFocusArea"></span>
          </div>
          <p id="modalFullProfile" class="text-secondary mb-4" style="line-height: 1.6; white-space: pre-line;"></p>
          <div class="border-top pt-3">
             <a id="modalWebsiteLink" href="#" target="_blank" class="btn btn-primary-custom btn-sm w-100 fw-bold">
                <i class="bi bi-globe me-2"></i>Visit Official Website
             </a>
          </div>
        </div>
      </div>
    </div>
  </div>

  <script>
      document.addEventListener('DOMContentLoaded', function () {
          document.addEventListener('click', function (e) {
              if (e.target && e.target.classList.contains('btn-view-company')) {
                  e.preventDefault();

                  var item = e.target.closest('.company-item');
                  if (!item) return;

                  var name = item.dataset.name || '';
                  var focus = item.dataset.focus || '';
                  var profile = item.dataset.profile || 'No extended profile data provided.';
                  var url = item.dataset.url || '#';

                  document.getElementById('companyModalLabel').textContent = name;
                  document.getElementById('modalFocusArea').textContent = "Industry Focus: " + focus;
                  document.getElementById('modalFullProfile').textContent = profile;

                  var webBtn = document.getElementById('modalWebsiteLink');
                  if (url === '#' || url === '') {
                      webBtn.classList.add('disabled');
                      webBtn.innerHTML = '<i class="bi bi-link-45deg me-2"></i>No Website Available';
                  } else {
                      webBtn.classList.remove('disabled');
                      webBtn.href = url;
                      webBtn.innerHTML = '<i class="bi bi-globe me-2"></i>Visit Official Website';
                  }

                  var bsModal = new bootstrap.Modal(document.getElementById('companyModal'));
                  bsModal.show();
              }
          });
      });
  </script>
</asp:Content>