<%@ Page Language="C#" AutoEventWireup="true" CodeFile="students.aspx.cs" Inherits="students" MasterPageFile="~/Site.master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">Student Portal | KUET Career Club</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <meta name="viewport" content="width=device-width,initial-scale=1" />
</asp:Content>





<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- header/offcanvas provided by Site.master -->

    <section class="portal-hero py-5">
      <div class="container">
        <div class="row align-items-center gy-4">
          <div class="col-lg-7">
            <h1>Student Portal</h1>
            <p class="lead mb-4">Browse current KUET student profiles, connect with talent, and discover academic strengths and skills across departments.</p>
          </div>
          <div class="col-lg-5">
            <div class="portal-hero-card p-4">
              <h5>Looking for students?</h5>
              <p>Use search and filters to narrow down candidates by department, year, and skillsets.</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="portal-search-section py-5 bg-white">
      <div class="container">
        <div class="row g-3 align-items-end">
          <div class="col-md-5">
            <input id="studentSearch" type="search" class="form-control" placeholder="Search by name, ID or skill">
          </div>
          <div class="col-md-2">
            <select id="departmentFilter" class="form-select">
              <option value="all">All Departments</option>
              <option value="CSE">CSE</option>
              <option value="EEE">EEE</option>
              <option value="ME">ME</option>
              <option value="CE">CE</option>
              <option value="IPE">IPE</option>
            </select>
          </div>
          <div class="col-md-2">
            <select id="yearFilter" class="form-select">
              <option value="all">All Years</option>
              <option value="Level 2">Level 2</option>
              <option value="Level 3">Level 3</option>
              <option value="Level 4">Level 4</option>
              <option value="Final">Final</option>
            </select>
          </div>
          <div class="col-md-2">
            <select id="sortFilter" class="form-select">
              <option value="name">Sort by Name</option>
              <option value="department">Sort by Department</option>
              <option value="year">Sort by Year</option>
            </select>
          </div>
          <div class="col-md-1 d-grid">
            <button type="button" id="clearStudentFilters" class="btn btn-outline-custom btn-sm">Clear</button>
          </div>
        </div>
        <div class="row mt-3">
          <div class="col-12 d-flex justify-content-between align-items-center">
            <p class="text-muted small mb-0">Showing <strong id="resultCount">6</strong> students</p>
          </div>
        </div>
      </div>
    </section>

    <section class="portal-listing py-5">
      <div class="container">
        <div class="row g-4" id="studentGrid">
          <div class="col-md-6 col-lg-4 student-card" data-name="Riasad Sanvi" data-id="2310102ME20232027" data-department="ME" data-year="Level 2" data-skills="AutoCAD LaTeX SAP2000" data-bio="Enthusiastic about robotics, embedded systems, and design automation." data-experience="Robotics Club Member • CAD Designer Intern at Tech Solutions • Project Lead for Autonomous Vehicle Design" data-projects="Autonomous Vehicle Design, Structural Analysis using SAP2000" data-email="riasad.sanvi@kuet.ac.bd" data-phone="+880-XXX-XXXXXX" data-resume="resumes/riasad-sanvi.pdf">
            <div class="card p-4 h-100">
              <div class="d-flex justify-content-between align-items-start mb-3">
                <div>
                  <h5>Riasad Sanvi</h5>
                  <p class="text-muted small mb-0">2310102ME20232027 • Level 2</p>
                </div>
                <span class="badge bg-primary">ME</span>
              </div>
              <p class="text-muted mb-3">Enthusiastic about robotics, embedded systems, and design automation.</p>
              <div class="student-skills mb-3">
                <span>AutoCAD</span>
                <span>LaTeX</span>
                <span>SAP2000</span>
              </div>
              <div class="d-flex gap-2">
                <a href="#" class="btn btn-outline-custom btn-sm btn-view-profile flex-grow-1">View Profile</a>
                <button type="button" class="btn btn-primary-custom btn-sm btn-connect-card">Connect</button>
              </div>
            </div>
          </div>

          <div class="col-md-6 col-lg-4 student-card" data-name="Muhammad Sazid" data-id="2310103ME23" data-department="ME" data-year="Level 3" data-skills="CAD Matlab" data-bio="Focused on mechanical design, modeling, and sustainable systems." data-experience="Thermal Analysis Project • Manufacturing Systems Research • Design Competition Winner 2023" data-projects="Sustainable Energy Device Design, Thermal Management System" data-email="sazid.mech@kuet.ac.bd" data-phone="+880-XXX-XXXXXX" data-resume="resumes/muhammad-sazid.pdf">
            <div class="card p-4 h-100">
              <div class="d-flex justify-content-between align-items-start mb-3">
                <div>
                  <h5>Muhammad Sazid</h5>
                  <p class="text-muted small mb-0">2310103ME23 • Level 3</p>
                </div>
                <span class="badge bg-primary">ME</span>
              </div>
              <p class="text-muted mb-3">Focused on mechanical design, modeling, and sustainable systems.</p>
              <div class="student-skills mb-3">
                <span>CAD</span>
                <span>Matlab</span>
              </div>
              <div class="d-flex gap-2">
                <a href="#" class="btn btn-outline-custom btn-sm btn-view-profile flex-grow-1">View Profile</a>
                <button type="button" class="btn btn-primary-custom btn-sm btn-connect-card">Connect</button>
              </div>
            </div>
          </div>

          <div class="col-md-6 col-lg-4 student-card" data-name="Fahmid Yamin" data-id="2204008CE22" data-department="CE" data-year="Level 2" data-skills="Networking JavaScript" data-bio="Working toward expertise in web development and network systems." data-experience="Web Development Intern at WebCraft Solutions • Network Infrastructure Project • Frontend Developer at Campus Tech Club" data-projects="Campus Network Portal, E-Learning Platform" data-email="fahmid.yamin@kuet.ac.bd" data-phone="+880-XXX-XXXXXX" data-resume="resumes/fahmid-yamin.pdf">
            <div class="card p-4 h-100">
              <div class="d-flex justify-content-between align-items-start mb-3">
                <div>
                  <h5>Fahmid Yamin</h5>
                  <p class="text-muted small mb-0">2204008CE22 • Level 2</p>
                </div>
                <span class="badge bg-info">CE</span>
              </div>
              <p class="text-muted mb-3">Working toward expertise in web development and network systems.</p>
              <div class="student-skills mb-3">
                <span>Networking</span>
                <span>JavaScript</span>
              </div>
              <div class="d-flex gap-2">
                <a href="#" class="btn btn-outline-custom btn-sm btn-view-profile flex-grow-1">View Profile</a>
                <button type="button" class="btn btn-primary-custom btn-sm btn-connect-card">Connect</button>
              </div>
            </div>
          </div>

          <div class="col-md-6 col-lg-4 student-card" data-name="Samir Ahammad" data-id="2018002CSE20" data-department="CSE" data-year="Level 4" data-skills="React Node.js" data-bio="Experienced in full-stack engineering, product development, and leadership." data-experience="Full-Stack Developer at TechVision Inc. (2 years) • Team Lead at Campus Dev Community • Mentored 15+ junior developers" data-projects="E-Commerce Platform, Mobile App API, Cloud Migration Project" data-email="samir.ahammad@kuet.ac.bd" data-phone="+880-XXX-XXXXXX" data-resume="resumes/samir-ahammad.pdf">
            <div class="card p-4 h-100">
              <div class="d-flex justify-content-between align-items-start mb-3">
                <div>
                  <h5>Samir Ahammad</h5>
                  <p class="text-muted small mb-0">2018002CSE20 • Level 4</p>
                </div>
                <span class="badge bg-success">CSE</span>
              </div>
              <p class="text-muted mb-3">Experienced in full-stack engineering, product development, and leadership.</p>
              <div class="student-skills mb-3">
                <span>React</span>
                <span>Node.js</span>
              </div>
              <div class="d-flex gap-2">
                <a href="#" class="btn btn-outline-custom btn-sm btn-view-profile flex-grow-1">View Profile</a>
                <button type="button" class="btn btn-primary-custom btn-sm btn-connect-card">Connect</button>
              </div>
            </div>
          </div>

          <div class="col-md-6 col-lg-4 student-card" data-name="Ratul Hayat Sisir" data-id="2308007IPE23" data-department="IPE" data-year="Level 2" data-skills="SPSS Data Analysis" data-bio="Developing skills in analytics, research, and operations." data-experience="Operations Research Analyst Intern • Data Analytics Project at Manufacturing Firm • Research Assistant on Supply Chain Study" data-projects="Supply Chain Optimization Analysis, Production Planning Model" data-email="ratul.sisir@kuet.ac.bd" data-phone="+880-XXX-XXXXXX" data-resume="resumes/ratul-hayat-sisir.pdf">
            <div class="card p-4 h-100">
              <div class="d-flex justify-content-between align-items-start mb-3">
                <div>
                  <h5>Ratul Hayat Sisir</h5>
                  <p class="text-muted small mb-0">2308007IPE23 • Level 2</p>
                </div>
                <span class="badge bg-warning text-dark">IPE</span>
              </div>
              <p class="text-muted mb-3">Developing skills in analytics, research, and operations.</p>
              <div class="student-skills mb-3">
                <span>SPSS</span>
                <span>Data Analysis</span>
              </div>
              <div class="d-flex gap-2">
                <a href="#" class="btn btn-outline-custom btn-sm btn-view-profile flex-grow-1">View Profile</a>
                <button type="button" class="btn btn-primary-custom btn-sm btn-connect-card">Connect</button>
              </div>
            </div>
          </div>

          <div class="col-md-6 col-lg-4 student-card" data-name="Md. Al Nazmus Sakib" data-id="2004035CE202026" data-department="CE" data-year="Level 4" data-skills="Instrumentation PLC" data-bio="Instrumentation student with a focus on automation and control systems." data-experience="Automation Engineer at Industrial Solutions Ltd (1.5 years) • PLC Programming Specialist • Control System Design Project" data-projects="Industrial Process Automation, Safety System Implementation" data-email="sakib.nazmus@kuet.ac.bd" data-phone="+880-XXX-XXXXXX" data-resume="resumes/almad-nazmus-sakib.pdf">
            <div class="card p-4 h-100">
              <div class="d-flex justify-content-between align-items-start mb-3">
                <div>
                  <h5>Md. Al Nazmus Sakib</h5>
                  <p class="text-muted small mb-0">2004035CE202026 • Level 4</p>
                </div>
                <span class="badge bg-info">CE</span>
              </div>
              <p class="text-muted mb-3">Instrumentation student with a focus on automation and control systems.</p>
              <div class="student-skills mb-3">
                <span>Instrumentation</span>
                <span>PLC</span>
              </div>
              <div class="d-flex gap-2">
                <a href="#" class="btn btn-outline-custom btn-sm btn-view-profile flex-grow-1">View Profile</a>
                <button type="button" class="btn btn-primary-custom btn-sm btn-connect-card">Connect</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <div class="modal fade" id="profileModal" tabindex="-1" aria-labelledby="profileModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header bg-light">
            <div>
              <h5 class="modal-title" id="profileModalLabel"></h5>
              <p class="text-muted small mb-0 mt-1" id="profileId"></p>
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <div class="row mb-4">
              <div class="col-md-8">
                <h6 class="text-uppercase text-muted small fw-bold mb-2">About</h6>
                <p id="profileBio" class="mb-4"></p>
                <h6 class="text-uppercase text-muted small fw-bold mb-2">Experience & Achievements</h6>
                <p id="profileExperience" class="mb-4"></p>
                <h6 class="text-uppercase text-muted small fw-bold mb-2">Projects</h6>
                <p id="profileProjects"></p>
              </div>
              <div class="col-md-4">
                <div class="p-3 rounded bg-light">
                  <h6 class="text-uppercase text-muted small fw-bold mb-3">Skills</h6>
                  <div id="profileSkills" class="mb-4"></div>
                  <h6 class="text-uppercase text-muted small fw-bold mb-3">Contact</h6>
                  <p class="small mb-2"><strong>Email:</strong><br><span id="profileEmail"></span></p>
                  <p class="small"><strong>Phone:</strong><br><span id="profilePhone"></span></p>
                </div>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-outline-custom" data-bs-dismiss="modal">Close</button>
            <a href="#" id="downloadResume" class="btn btn-outline-custom" download><i class="bi bi-download me-2"></i>Download CV</a>
            <button type="button" class="btn btn-primary-custom" id="connectStudentBtn"><i class="bi bi-envelope me-2"></i>Send Message</button>
          </div>
        </div>
      </div>
    </div>

    <div class="modal fade" id="contactModal" tabindex="-1" aria-labelledby="contactModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="contactModalLabel">Send Message</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <p class="text-muted mb-3">Sending message to <strong id="contactStudentName"></strong></p>
            <div class="mb-3">
              <label for="contactEmail" class="form-label">Your Email</label>
              <input type="email" class="form-control" id="contactEmail" required>
            </div>
            <div class="mb-3">
              <label for="contactSubject" class="form-label">Subject</label>
              <input type="text" class="form-control" id="contactSubject" placeholder="e.g., Internship Opportunity" required>
            </div>
            <div class="mb-3">
              <label for="contactMessage" class="form-label">Message</label>
              <textarea class="form-control" id="contactMessage" rows="4" placeholder="Write your message..." required></textarea>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-outline-custom" data-bs-dismiss="modal">Cancel</button>
            <button type="button" class="btn btn-primary-custom" id="sendMessageBtn">Send Message</button>
          </div>
        </div>
      </div>
    </div>

  <script>
    document.addEventListener('DOMContentLoaded', function () {
      function findCard(el) { return el.closest('.student-card'); }

      document.querySelectorAll('.btn-view-profile').forEach(function (btn) {
        btn.addEventListener('click', function (e) {
          e.preventDefault();
          var card = findCard(btn);
          if (!card) return;
          var name = card.dataset.name || '';
          var id = card.dataset.id || '';
          var bio = card.dataset.bio || '';
          var experience = card.dataset.experience || '';
          var projects = card.dataset.projects || '';
          var skills = (card.dataset.skills || '').split(' ');
          var email = card.dataset.email || '';
          var phone = card.dataset.phone || '';
          var resume = card.dataset.resume || '#';

          var profileModal = document.getElementById('profileModal');
          if (!profileModal) return;

          document.getElementById('profileModalLabel').textContent = name;
          document.getElementById('profileId').textContent = id;
          document.getElementById('profileBio').textContent = bio;
          document.getElementById('profileExperience').textContent = experience;
          document.getElementById('profileProjects').textContent = projects;
          var skillsContainer = document.getElementById('profileSkills');
          skillsContainer.innerHTML = '';
          skills.filter(Boolean).forEach(function (s) {
            var span = document.createElement('span');
            span.className = 'badge bg-light text-dark me-1 mb-1';
            span.textContent = s;
            skillsContainer.appendChild(span);
          });
          document.getElementById('profileEmail').textContent = email;
          document.getElementById('profilePhone').textContent = phone;
          var download = document.getElementById('downloadResume');
          if (download) { download.href = resume; }

          var connectBtn = document.getElementById('connectStudentBtn');
          if (connectBtn) {
            connectBtn.dataset.targetName = name;
            connectBtn.dataset.targetEmail = email;
          }

          var bsModal = new bootstrap.Modal(profileModal);
          bsModal.show();
        });
      });

      document.querySelectorAll('.btn-connect-card').forEach(function (btn) {
        btn.addEventListener('click', function () {
          var card = findCard(btn);
          if (!card) return;
          var name = card.dataset.name || '';
          var email = card.dataset.email || '';
          var contactModal = document.getElementById('contactModal');
          if (!contactModal) return;
          document.getElementById('contactStudentName').textContent = name;
          contactModal.dataset.recipientEmail = email;
          var bsModal = new bootstrap.Modal(contactModal);
          bsModal.show();
        });
      });

      var connectStudentBtn = document.getElementById('connectStudentBtn');
      if (connectStudentBtn) {
        connectStudentBtn.addEventListener('click', function () {
          var name = connectStudentBtn.dataset.targetName || '';
          var email = connectStudentBtn.dataset.targetEmail || '';
          var profileModal = document.getElementById('profileModal');
          var bsProfile = bootstrap.Modal.getInstance(profileModal);
          if (bsProfile) bsProfile.hide();
          var contactModal = document.getElementById('contactModal');
          if (!contactModal) return;
          document.getElementById('contactStudentName').textContent = name;
          contactModal.dataset.recipientEmail = email;
          var bsContact = new bootstrap.Modal(contactModal);
          bsContact.show();
        });
      }

      var sendMessageBtn = document.getElementById('sendMessageBtn');
      if (sendMessageBtn) {
        sendMessageBtn.addEventListener('click', function () {
          var contactModal = document.getElementById('contactModal');
          var recipientEmail = contactModal && contactModal.dataset.recipientEmail ? contactModal.dataset.recipientEmail : '';
          var fromEmail = document.getElementById('contactEmail').value || '';
          var subject = document.getElementById('contactSubject').value || '';
          var message = document.getElementById('contactMessage').value || '';
          var bsContact = bootstrap.Modal.getInstance(contactModal);
          if (bsContact) bsContact.hide();
          alert('Message sent to ' + (recipientEmail || 'recipient') + '\nSubject: ' + subject);
          if (document.getElementById('contactEmail')) document.getElementById('contactEmail').value = '';
          if (document.getElementById('contactSubject')) document.getElementById('contactSubject').value = '';
          if (document.getElementById('contactMessage')) document.getElementById('contactMessage').value = '';
        });
      }
    });
  </script>
</asp:Content>
