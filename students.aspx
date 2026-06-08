<%@ Page Language="C#" AutoEventWireup="true" CodeFile="students.aspx.cs" Inherits="students" MasterPageFile="~/Site.master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">Student Portal | KUET Career Club</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <style>
    .student-skills span { display: inline-block; background: #f1f5f9; color: #334155; padding: 3px 8px; border-radius: 4px; font-size: 0.75rem; margin-right: 4px; margin-bottom: 4px; font-weight: 500; }
    .portal-hero-card { background: #f8fafc; border-left: 4px solid #004080; border-radius: 8px; }
    .btn-outline-custom { border: 1px solid #004080; color: #004080; transition: 0.2s; }
    .btn-outline-custom:hover { background: #004080; color: white; }
    .btn-primary-custom { background: #ffcc00; color: #111; font-weight: 600; border: none; }
    .btn-primary-custom:hover { background: #e6b800; }
  </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <section class="portal-hero py-5" style="background: linear-gradient(135deg, #f8fafc 0%, #eef6ff 100%);">
      <div class="container">
        <div class="row align-items-center gy-4">
          <div class="col-lg-7">
            <h1 class="fw-bold">Student Portal</h1>
            <p class="lead text-muted mb-4">Browse current KUET student profiles, connect with talent, and discover academic strengths and skills across departments.</p>
          </div>
          <div class="col-lg-5">
            <div class="portal-hero-card p-4 shadow-sm bg-white">
              <h5 class="fw-bold"><i class="bi bi-search-heart text-primary me-2"></i>Looking for students?</h5>
              <p class="text-muted small mb-0">Use search and filters to narrow down candidates by department, year, and skillsets instantly.</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="portal-search-section py-4 bg-white border-bottom">
      <div class="container">
        <div class="row g-3 align-items-end">
          <div class="col-md-5">
            <label class="form-label small fw-bold text-muted">Keyword Search</label>
            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search by name, ID or skill..." AutoPostBack="true" OnTextChanged="Filter_Changed"></asp:TextBox>
          </div>
          <div class="col-md-2">
            <label class="form-label small fw-bold text-muted">Department</label>
            <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed">
              <asp:ListItem Value="all">All Departments</asp:ListItem>
              <asp:ListItem Value="CSE">CSE</asp:ListItem>
              <asp:ListItem Value="EEE">EEE</asp:ListItem>
              <asp:ListItem Value="ME">ME</asp:ListItem>
              <asp:ListItem Value="CE">CE</asp:ListItem>
              <asp:ListItem Value="IPE">IPE</asp:ListItem>
            </asp:DropDownList>
          </div>
          <div class="col-md-2">
            <label class="form-label small fw-bold text-muted">Level/Year</label>
            <asp:DropDownList ID="ddlYear" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed">
              <asp:ListItem Value="all">All Years</asp:ListItem>
              <asp:ListItem Value="Level 2">Level 2</asp:ListItem>
              <asp:ListItem Value="Level 3">Level 3</asp:ListItem>
              <asp:ListItem Value="Level 4">Level 4</asp:ListItem>
              <asp:ListItem Value="Final">Final</asp:ListItem>
            </asp:DropDownList>
          </div>
          <div class="col-md-2">
            <label class="form-label small fw-bold text-muted">Sort By</label>
            <asp:DropDownList ID="ddlSort" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed">
              <asp:ListItem Value="FullName">Sort by Name</asp:ListItem>
              <asp:ListItem Value="Department">Sort by Dept</asp:ListItem>
              <asp:ListItem Value="StudyLevel">Sort by Level</asp:ListItem>
            </asp:DropDownList>
          </div>
          <div class="col-md-1 d-grid">
            <asp:Button ID="btnClear" runat="server" Text="Reset" CssClass="btn btn-outline-secondary btn-sm" OnClick="btnClear_Click" />
          </div>
        </div>
        <div class="row mt-3">
          <div class="col-12">
            <p class="text-muted small mb-0">Showing <strong class="text-dark"><asp:Literal ID="litCount" runat="server">0</asp:Literal></strong> students found</p>
          </div>
        </div>
      </div>
    </section>

    <section class="portal-listing py-5 bg-light">
      <div class="container">
        <div class="row g-4">
          <asp:Repeater ID="rptStudents" runat="server">
            <ItemTemplate>
              <div class="col-md-6 col-lg-4 student-card" 
                   data-name='<%# HttpUtility.HtmlAttributeEncode(Eval("FullName").ToString()) %>' 
                   data-id='<%# HttpUtility.HtmlAttributeEncode(Eval("RollID").ToString()) %>'
                   data-department='<%# HttpUtility.HtmlAttributeEncode(Eval("Department").ToString()) %>' 
                   data-year='<%# HttpUtility.HtmlAttributeEncode(Eval("StudyLevel").ToString()) %>' 
                   data-skills='<%# HttpUtility.HtmlAttributeEncode(Eval("Skills").ToString()) %>' 
                   data-bio='<%# HttpUtility.HtmlAttributeEncode(Eval("Bio").ToString()) %>' 
                   data-experience='<%# HttpUtility.HtmlAttributeEncode(Eval("Experience").ToString()) %>' 
                   data-projects='<%# HttpUtility.HtmlAttributeEncode(Eval("Projects").ToString()) %>' 
                   data-email='<%# HttpUtility.HtmlAttributeEncode(Eval("Email").ToString()) %>' 
                   data-phone='<%# HttpUtility.HtmlAttributeEncode(Eval("Phone").ToString()) %>' 
                   data-resume='<%# HttpUtility.HtmlAttributeEncode(Eval("ResumePath").ToString()) %>'>
                <div class="card p-4 h-100 shadow-sm border-0">
                  <div class="d-flex justify-content-between align-items-start mb-3">
                    <div>
                      <h5 class="fw-bold mb-1 text-dark"><%# Eval("FullName") %></h5>
                      <p class="text-muted small mb-0"><%# Eval("RollID") %> • <%# Eval("StudyLevel") %></p>
                    </div>
                    <span class="badge bg-primary px-2.5 py-1.5"><%# Eval("Department") %></span>
                  </div>
                  <p class="text-secondary small mb-3 flex-grow-1"><%# Eval("Bio") %></p>
                  <div class="student-skills mb-4">
                        <%# RenderSkills(Eval("Skills").ToString()) %>
                  </div>
                  <div class="d-flex gap-2 mt-auto">
                    <a href="#" class="btn btn-outline-custom btn-sm btn-view-profile flex-grow-1 fw-bold">View Profile</a>
                    <button type="button" class="btn btn-primary-custom btn-sm btn-connect-card px-3 fw-bold">Connect</button>
                  </div>
                </div>
              </div>
            </ItemTemplate>
          </asp:Repeater>
        </div>
      </div>
    </section>


    <!-- Profile Modal -->
    <div class="modal fade" id="profileModal" tabindex="-1" aria-labelledby="profileModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="profileModalLabel">Profile</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <p id="profileId" class="small text-muted"></p>
            <p id="profileBio" class="mb-2"></p>
            <p><strong>Experience:</strong> <span id="profileExperience"></span></p>
            <p><strong>Projects:</strong> <span id="profileProjects"></span></p>
            <div id="profileSkills" class="mb-2"></div>
            <p><strong>Email:</strong> <span id="profileEmail"></span></p>
            <p><strong>Phone:</strong> <span id="profilePhone"></span></p>
          </div>
          <div class="modal-footer">
            <a id="downloadResume" href="#" class="btn btn-outline-secondary btn-sm"><i class="bi bi-download me-1"></i> Download CV</a>
            <button id="connectStudentBtn" type="button" class="btn btn-primary btn-sm">Message / Connect</button>
          </div>
        </div>
      </div>
    </div>

    <!-- Contact Modal -->
    <div class="modal fade" id="contactModal" tabindex="-1" aria-labelledby="contactModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="contactModalLabel">Contact Student</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <p>Send a networking message to <strong id="contactStudentName"></strong></p>
            <div class="mb-2"><input id="contactEmail" class="form-control" placeholder="Your email" /></div>
            <div class="mb-2"><input id="contactSubject" class="form-control" placeholder="Subject" /></div>
            <div class="mb-2"><textarea id="contactMessage" class="form-control" rows="4" placeholder="Message"></textarea></div>
          </div>
          <div class="modal-footer">
            <button id="sendMessageBtn" type="button" class="btn btn-primary btn-sm">Send Message</button>
            <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Cancel</button>
          </div>
        </div>
      </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    document.addEventListener('DOMContentLoaded', function () {
        // প্যারেন্ট কার্ড খোঁজার হেল্পার ফাংশন
        function findCard(el) { 
            return el.closest('.student-card'); 
        }

        // ১. View Profile বাটন ফাংশনালিটি (ডাইনামিক ডেলিগেশন দিয়ে হ্যান্ডেল করা হয়েছে)
        document.addEventListener('click', function (e) {
            if (e.target && e.target.classList.contains('btn-view-profile')) {
                e.preventDefault();
                var btn = e.target;
                var card = findCard(btn);
                if (!card) return;

                // ডাটা রিসিভ করা
                var name = card.dataset.name || '';
                var id = card.dataset.id || '';
                var bio = card.dataset.bio || 'No bio available.';
                var experience = card.dataset.experience || 'No experience listed.';
                var projects = card.dataset.projects || 'No projects listed.';
                var skills = (card.dataset.skills || '').split(/[,\s]+/); // স্পেস বা কমা দিয়ে স্প্লিট
                var email = card.dataset.email || '';
                var phone = card.dataset.phone || 'N/A';
                var resume = card.dataset.resume || '#';

                var profileModal = document.getElementById('profileModal');
                if (!profileModal) return;

                // মোডাল ফিলগুলো ডাটা দিয়ে পপুলেট করা
                document.getElementById('profileModalLabel').textContent = name;
                document.getElementById('profileId').textContent = id + " • " + card.dataset.department + " (" + card.dataset.year + ")";
                document.getElementById('profileBio').textContent = bio;
                document.getElementById('profileExperience').textContent = experience;
                document.getElementById('profileProjects').textContent = projects;

                // স্কিল ব্যাজ জেনারেট করা
                var skillsContainer = document.getElementById('profileSkills');
                skillsContainer.innerHTML = '';
                skills.filter(Boolean).forEach(function (s) {
                    var span = document.createElement('span');
                    span.className = 'badge bg-secondary-subtle text-dark me-1 mb-1 p-2 small';
                    span.textContent = s;
                    skillsContainer.appendChild(span);
                });

                document.getElementById('profileEmail').textContent = email;
                document.getElementById('profilePhone').textContent = phone;

                var download = document.getElementById('downloadResume');
                if (download) { 
                    download.href = resume; 
                    // যদি কোনো সিভি আপলোড না থাকে
                    if(resume === '#' || resume === 'resumes/default.pdf') {
                        download.classList.add('disabled');
                        download.innerHTML = '<i class="bi bi-file-earmark-lock me-1"></i> No CV';
                    } else {
                        download.classList.remove('disabled');
                        download.innerHTML = '<i class="bi bi-download me-1"></i> Download CV';
                    }
                }

                // প্রোফাইল মোডালের ভেতরের কানেক্ট বাটনে ডাটা পাস করা
                var connectBtn = document.getElementById('connectStudentBtn');
                if (connectBtn) {
                    connectBtn.dataset.targetName = name;
                    connectBtn.dataset.targetEmail = email;
                }

                var bsModal = new bootstrap.Modal(profileModal);
                bsModal.show();
            }
        });

        // ২. কার্ডের ভেতরের ডাইরেক্ট Connect বাটন ফাংশনালিটি
        document.addEventListener('click', function (e) {
            if (e.target && e.target.classList.contains('btn-connect-card')) {
                var btn = e.target;
                var card = findCard(btn);
                if (!card) return;

                var name = card.dataset.name || '';
                var email = card.dataset.email || '';
                openContactModal(name, email);
            }
        });

        // ৩. প্রোফাইল মোডালের ভেতরের Message/Connect বাটন অ্যাকশন
        var connectStudentBtn = document.getElementById('connectStudentBtn');
        if (connectStudentBtn) {
            connectStudentBtn.addEventListener('click', function () {
                var name = connectStudentBtn.dataset.targetName || '';
                var email = connectStudentBtn.dataset.targetEmail || '';

                // প্রোফাইল মোডালটি আগে হাইড করা
                var profileModal = document.getElementById('profileModal');
                var bsProfile = bootstrap.Modal.getInstance(profileModal);
                if (bsProfile) bsProfile.hide();

                // কন্টাক্ট মোডালটি ওপেন করা
                setTimeout(function() {
                    openContactModal(name, email);
                }, 400); // স্মুথ অ্যানিমেশনের জন্য সামান্য ডিলে
            });
        }

        // কন্টাক্ট মোডাল পপুলেট ও ওপেন করার কমন ফাংশন
        function openContactModal(name, email) {
            var contactModal = document.getElementById('contactModal');
            if (!contactModal) return;

            document.getElementById('contactStudentName').textContent = name;
            contactModal.dataset.recipientEmail = email;

            var bsContact = new bootstrap.Modal(contactModal);
            bsContact.show();
        }

        // ৪. মেসেজ সাবমিট বাটন অ্যাকশন
        var sendMessageBtn = document.getElementById('sendMessageBtn');
        if (sendMessageBtn) {
            sendMessageBtn.addEventListener('click', function () {
                var contactModal = document.getElementById('contactModal');
                var recipientEmail = contactModal ? contactModal.dataset.recipientEmail : '';
                var fromEmail = document.getElementById('contactEmail').value || '';
                var subject = document.getElementById('contactSubject').value || '';
                var message = document.getElementById('contactMessage').value || '';

                if(!fromEmail || !subject || !message) {
                    alert('Please fill out all the message fields.');
                    return;
                }

                var bsContact = bootstrap.Modal.getInstance(contactModal);
                if (bsContact) bsContact.hide();

                // সফলতার নোটিফিকেশন
                alert('Success! Your networking message has been routed to: ' + recipientEmail + '\nSubject: ' + subject);

                // ফর্ম রিসেট করা
                document.getElementById('contactEmail').value = '';
                document.getElementById('contactSubject').value = '';
                document.getElementById('contactMessage').value = '';
            });
        }
    });
    </script>

    </asp:Content>
