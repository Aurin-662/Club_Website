<%@ Page Title="KUET Career Club" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Home | KUET Career Club
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
  <div class="notice-marquee-container d-flex align-items-center">
    <div class="notice-badge d-flex align-items-center shadow-sm pulse">
      <i class="bi bi-megaphone-fill me-2"></i> Notice
    </div>
    <div class="flex-grow-1 py-2">
      <marquee behavior="scroll" direction="left" onmouseover="this.stop();" onmouseout="this.start();" class="marquee-text pt-1">
        <a href="#" class="me-5"><i class="bi bi-dot text-danger fs-5"></i> Registration for KUET National Career Fair 2026 is now officially open!</a>
        <a href="blogs.aspx" class="me-5"><i class="bi bi-dot text-danger fs-5"></i> Check out the new Software Engineering Interview Preparation Guide in our blog hub.</a>
        <a href="#jobs" class="me-5"><i class="bi bi-dot text-danger fs-5"></i> TechNova Solutions added 3 new internship slots for final-year CSE students.</a>
      </marquee>
    </div>
  </div>

  <section class="banner main-content py-5 bg-white border-bottom reveal-on-scroll hero-animated">
    <div class="container py-4">
      <div class="row align-items-center gy-4">
        <div class="col-lg-6">
          <div class="hero-copy">
            <h1 class="display-5 mb-3">Ready to Join the <span style="color: var(--bcc-primary);">KUET Network?</span></h1>
            <p class="text-muted fs-5 mb-4">Connect with 25,000+ KUETians, discover exclusive opportunities, and accelerate your engineering career with Bangladesh's most prestigious corporate-academic network.</p>
            <div class="d-flex gap-2">
              <a href="register.aspx" class="btn btn-primary-custom px-4 py-2 fw-semibold shadow-sm">Join KUET Network</a>
              <a href="login.aspx" class="btn btn-outline-custom px-4 py-2 fw-semibold">Sign In</a>
            </div>
          </div>
        </div>
        <div class="col-lg-6 text-center">
          <img src="images/network.jpg" alt="KUET Network" class="banner-img img-fluid rounded-3 shadow-sm float-on-scroll" style="max-height: 400px; object-fit: cover; width: 100%;">
        </div>
      </div>
    </div>
  </section>

  <section class="stats py-5 border-bottom bg-white">
    <div class="reveal-on-scroll">
    <div class="container">
      <div class="text-center mb-5">
        <h2 class="mb-2">Empowering Success Through Numbers That Matter</h2>
        <p class="text-muted mx-auto" style="max-width: 65ch;">Join thousands of KUET students, alumni, and industry partners building the future of industrial engineering excellence.</p>
      </div>
      <div class="row text-center g-4">
        <div class="col-6 col-md-3">
          <div class="p-3 border rounded-3 bg-light">
            <h3 class="display-6 mb-1" style="color: var(--bcc-primary);"><span class="stat-number" data-target="1200">1000+</span></h3>
            <p class="text-muted mb-0 fw-medium">Active Students</p>
          </div>
        </div>
        <div class="col-6 col-md-3">
          <div class="p-3 border rounded-3 bg-light">
            <h3 class="display-6 mb-1" style="color: var(--bcc-primary);"><span class="stat-number" data-target="540">500+</span></h3>
            <p class="text-muted mb-0 fw-medium">Global Alumni</p>
          </div>
        </div>
        <div class="col-6 col-md-3">
          <div class="p-3 border rounded-3 bg-light">
            <h3 class="display-6 mb-1" style="color: var(--bcc-primary);"><span class="stat-number" data-target="62">50+</span></h3>
            <p class="text-muted mb-0 fw-medium">Live Openings</p>
          </div>
        </div>
        <div class="col-6 col-md-3">
          <div class="p-3 border rounded-3 bg-light">
            <h3 class="display-6 mb-1" style="color: var(--bcc-primary);"><span class="stat-number" data-target="26">20+</span></h3>
            <p class="text-muted mb-0 fw-medium">Annual Events</p>
          </div>
        </div>
      </div>
    </div>
  </section>

<section id="jobs" class="jobs main-content py-5 bg-light border-bottom">
  <div class="container">
    <div class="text-center mb-5">
      <h6 class="eyebrow">Job Board</h6>
      <h2>Latest Opportunities for KUET Talent</h2>
      <p class="text-muted mx-auto" style="max-width:70ch;">Explore the latest internships, part-time roles, and full-time positions posted by employers across technology, industry, and research. Filter listings by role type, department, or company to find opportunities that match your goals.</p>
      <p class="text-muted small mx-auto" style="max-width:70ch;">Are you an employer or alumni wanting to share an opportunity? Post jobs and internships to reach KUET students and graduates <a href="post-job.aspx">here</a>.</p>
    </div>

    <div class="row g-4">
      <asp:Repeater ID="rptJobs" runat="server">
        <ItemTemplate>
          <div class="col-md-6 col-lg-4">
            <article class="job-card p-4 h-100 d-flex flex-column" data-type='<%# Eval("JobType") %>' data-department='<%# Eval("CompanyName") %>'>
              <div class="d-flex align-items-start justify-content-between mb-3">
                <div>
                  <h5 class="mb-1"><%# Eval("JobTitle") %></h5>
                  <p class="mb-0 text-muted small fw-semibold"><%# Eval("CompanyName") %></p>
                </div>
                <span class="badge rounded px-2 py-1 bg-info-soft fw-bold"><%# Eval("JobType") %></span>
              </div>
              <p class="text-muted small mb-4 flex-grow-1"><%# Eval("Description") %></p>
              <div class="mt-auto"><small class="text-muted">Posted by <%# Eval("CompanyName") %> • <%# Eval("JobType") %></small></div>
            </article>
          </div>
        </ItemTemplate>
      </asp:Repeater>
      <div class="col-12 text-center mt-4">
        <a href="jobs.aspx" class="btn btn-primary-custom btn-lg">View All Jobs</a>
      </div>
      <asp:Panel ID="pnlNoJobs" runat="server" CssClass="text-center" Visible="false">
        <div class="col-12">
          <div class="p-4 bg-white border rounded-3">
            <h5 class="mb-2">No job listings available</h5>
            <p class="text-muted small mb-3">We don't have any active job or internship postings right now. Check the full job board for updates.</p>
            <a href="jobs.aspx" class="btn btn-outline-secondary btn-sm">Open Job Board</a>
          </div>
        </div>
      </asp:Panel>
    </div>
  </div>
</section>

  <section id="events" class="events main-content py-5 bg-white border-bottom reveal-on-scroll">
    <div class="container">
      <div class="text-center mb-5">
        <h6 class="eyebrow">Explore Our Platform</h6>
        <h2 class="mt-2">Everything You Need to Succeed</h2>
        <p class="text-muted mx-auto" style="max-width: 60ch;">Whether you're a student, alumnus, or corporate employer — our platform links the global network directly.</p>
      </div>

      <div class="row g-4">
        <div class="col-md-6 col-lg-3">
          <div class="card-feature h-100 d-flex flex-column">
            <h5 class="mb-3" style="font-size:1.15rem;"><i class="bi bi-people-fill me-2 text-danger"></i>Student Arena</h5>
            <p class="text-muted small mb-3 flex-grow-1">Connect with peers, access strategic mentorship channels, technical workshops, and early-stage internship slots.</p>
            <ul class="text-muted small ps-3 mb-4">
              <li>Career Guidance</li>
              <li>Study Circles</li>
              <li>1-on-1 Mentorship</li>
              <li>Skills Bootcamps</li>
            </ul>
            <a class="btn btn-outline-secondary btn-sm w-100 fw-semibold mt-auto" href="students.aspx">Enter Community</a>
          </div>
        </div>
        <div class="col-md-6 col-lg-3">
          <div class="card-feature h-100 d-flex flex-column">
            <h5 class="mb-3" style="font-size:1.15rem;"><i class="bi bi-globe2 me-2 text-success"></i>Alumni Sphere</h5>
            <p class="text-muted small mb-3 flex-grow-1">Maintain close alignment with the campus ecosystem and engage with global KUET circles active in tech clusters worldwide.</p>
            <ul class="text-muted small ps-3 mb-4">
              <li>Global Network Maps</li>
              <li>Reunion Modules</li>
              <li>Research Mentorship</li>
              <li>Job Dispersal Profiles</li>
            </ul>
            <a class="btn btn-outline-secondary btn-sm w-100 fw-semibold mt-auto" href="alumni.aspx">Alumni Directory</a>
          </div>
        </div>
        <div class="col-md-6 col-lg-3">
          <div class="card-feature h-100 d-flex flex-column">
            <h5 class="mb-3" style="font-size:1.15rem;"><i class="bi bi-briefcase-fill me-2 text-warning"></i>Collaboration</h5>
            <p class="text-muted small mb-3 flex-grow-1">Partner cleanly on R&D initiatives, complex senior projects, specialized elective syllabi, and structural project incubators.</p>
            <ul class="text-muted small ps-3 mb-4">
              <li>R&D Sponsorships</li>
              <li>Project Partnerships</li>
              <li>Curriculum Inputs</li>
              <li>Incubation Hubs</li>
            </ul>
            <a class="btn btn-outline-secondary btn-sm w-100 fw-semibold mt-auto" href="companies.aspx">Partner Paths</a>
          </div>
        </div>
        <div class="col-md-6 col-lg-3">
          <div class="card-feature h-100 d-flex flex-column">
            <h5 class="mb-3" style="font-size:1.15rem;"><i class="bi bi-award-fill me-2 text-info"></i>Career Tools</h5>
            <p class="text-muted small mb-3 flex-grow-1">Examine targeted corporate positions, specialized job criteria, mock interview labs, and automated resume building toolkits.</p>
            <ul class="text-muted small ps-3 mb-4">
              <li>Live Job Feeds</li>
              <li>Internship Databases</li>
              <li>Counseling Interfaces</li>
              <li>ATS Optimization</li>
            </ul>
            <a class="btn btn-outline-secondary btn-sm w-100 fw-semibold mt-auto" href="jobs.aspx">Launch Tools</a>
          </div>
        </div>
      </div>
    </div>
  </section>

  <section id="upcoming-events" class="events main-content py-5 bg-white border-bottom reveal-on-scroll">
    <div class="container">
      <div class="text-center mb-5">
        <h6 class="eyebrow">Upcoming Events</h6>
        <h2 class="mt-2">Register for KUET Career Sessions</h2>
        <p class="text-muted mx-auto" style="max-width: 64ch;">Attend our curated workshops, employer panels, and resume clinics to sharpen your career readiness.</p>
      </div>
      <div class="row g-4">
        <div class="col-md-4">
          <article class="event-card p-4 h-100 d-flex flex-column">
            <div class="d-flex align-items-start justify-content-between mb-3">
              <div>
                <h5 class="mb-1">Career Launch Bootcamp</h5>
                <p class="mb-0 text-muted small fw-semibold">June 30 | Main Auditorium</p>
              </div>
              <span class="badge rounded px-2 py-1 bg-primary-soft fw-bold" style="font-size:0.75rem;">Workshop</span>
            </div>
            <p class="text-muted small mb-4 flex-grow-1">Practical sessions on resume writing, interview prep, and networking with KUET industry partners.</p>
            <ul class="list-unstyled text-muted small mb-4 border-top pt-3">
              <li class="mb-1"><i class="bi bi-clock me-2"></i>10:00 AM &ndash; 1:00 PM</li>
              <li class="mb-1"><i class="bi bi-geo-alt me-2"></i>KUET Main Campus</li>
            </ul>
            <button type="button" class="btn btn-outline-secondary w-100 btn-sm fw-semibold mt-auto event-register-btn" data-event="bootcamp">Register</button>
          </article>
        </div>
        <div class="col-md-4">
          <article class="event-card p-4 h-100 d-flex flex-column">
            <div class="d-flex align-items-start justify-content-between mb-3">
              <div>
                <h5 class="mb-1">Employer Panel</h5>
                <p class="mb-0 text-muted small fw-semibold">July 5 | Innovation Hub</p>
              </div>
              <span class="badge rounded px-2 py-1 bg-success-soft fw-bold" style="font-size:0.75rem;">Panel</span>
            </div>
            <p class="text-muted small mb-4 flex-grow-1">Hear from hiring managers about current roles and career pathways for KUET graduates.</p>
            <ul class="list-unstyled text-muted small mb-4 border-top pt-3">
              <li class="mb-1"><i class="bi bi-clock me-2"></i>2:00 PM &ndash; 5:00 PM</li>
              <li class="mb-1"><i class="bi bi-geo-alt me-2"></i>Innovation Hub</li>
            </ul>
            <button type="button" class="btn btn-outline-secondary w-100 btn-sm fw-semibold mt-auto event-register-btn" data-event="panel">Register</button>
          </article>
        </div>
        <div class="col-md-4">
          <article class="event-card p-4 h-100 d-flex flex-column">
            <div class="d-flex align-items-start justify-content-between mb-3">
              <div>
                <h5 class="mb-1">Resume & Interview Clinic</h5>
                <p class="mb-0 text-muted small fw-semibold">July 10 | Career Lab</p>
              </div>
              <span class="badge rounded px-2 py-1 bg-orange-soft fw-bold" style="font-size:0.75rem;">Clinic</span>
            </div>
            <p class="text-muted small mb-4 flex-grow-1">One-on-one feedback sessions for CVs, cover letters, and mock interviews.</p>
            <ul class="list-unstyled text-muted small mb-4 border-top pt-3">
              <li class="mb-1"><i class="bi bi-clock me-2"></i>11:00 AM &ndash; 2:00 PM</li>
              <li class="mb-1"><i class="bi bi-geo-alt me-2"></i>Career Lab</li>
            </ul>
            <button type="button" class="btn btn-outline-secondary w-100 btn-sm fw-semibold mt-auto event-register-btn" data-event="clinic">Register</button>
          </article>
        </div>
      </div>
    </div>
  </section>

  <section id="counseling" class="counseling-section py-5 bg-white border-bottom reveal-on-scroll">
    <div class="container">
      <div class="text-center mb-4">
        <h6 class="eyebrow">Career Counselling</h6>
        <h2 class="mt-2">Personalised guidance to launch your career</h2>
        <p class="text-muted mx-auto" style="max-width:68ch;">One-on-one counselling, mock interviews, CV reviews, and career planning workshops led by industry mentors and senior alumni.</p>
      </div>
      <div class="row g-4">
        <div class="col-md-4">
          <div class="resource-card p-4 h-100">
            <h5 class="mb-2">CV Review & Optimization</h5>
            <p class="text-muted small">Make your CV stand out and pass Applicant Tracking Systems with targeted improvements.</p>
            <a href="blogs.aspx" class="btn btn-resource-outline mt-3">Learn More</a>
          </div>
        </div>
        <div class="col-md-4">
          <div class="resource-card p-4 h-100">
            <h5 class="mb-2">Mock Interviews</h5>
            <p class="text-muted small">Practice with real interviewers, get feedback, and build confidence for technical and HR rounds.</p>
            <button type="button" class="btn btn-resource-outline mt-3" data-bs-toggle="modal" data-bs-target="#bookModal">Book a Session</button>
          </div>
        </div>
        <div class="col-md-4">
          <div class="resource-card p-4 h-100">
            <h5 class="mb-2">Career Path Planning</h5>
            <p class="text-muted small">Map short- and long-term goals for industry roles or higher study with mentor-led planning.</p>
            <button type="button" class="btn btn-resource-outline mt-3" data-bs-toggle="modal" data-bs-target="#planModal">Start Planning</button>
          </div>
        </div>
      </div>
    </div>
  </section>

  <section id="collaborate" class="collaboration py-5 bg-white reveal-on-scroll">
    <div class="container">
      <div class="text-center mb-5">
        <h6 class="eyebrow">Partner With Us</h6>
        <h2 class="mt-2">Strategic Ways to Collaborate</h2>
        <p class="text-muted mx-auto" style="max-width: 60ch;">We systematically bridge the space between rigorous academic engineering coursework and actual global market operations.</p>
      </div>

      <div class="row g-4">
        <div class="col-md-4">
          <div class="collab-card h-100 d-flex flex-column">
            <i class="bi bi-building fs-2 mb-2 text-primary"></i>
            <h5 class="mb-2">Corporate Drives</h5>
            <p class="text-muted small flex-grow-1">Run formal recruitment seminars, target-oriented campus placement pools, and structured tech round tables inside KUET facilities.</p>
            <a href="#contact" class="text-decoration-none fw-semibold mt-3 small" style="color: var(--bcc-primary);">Learn More <i class="bi bi-arrow-right ms-2"></i></a>
          </div>
        </div>

        <div class="col-md-4">
          <div class="collab-card active-card h-100 d-flex flex-column">
            <i class="bi bi-people-fill fs-2 mb-2 text-danger"></i>
            <h5 class="mb-2">Alumni Mentorship</h5>
            <p class="text-muted small flex-grow-1">Guide upcoming cohorts of engineers by breaking down your industry path, tech stack transitions, and market insights.</p>
            <a href="register.aspx" class="text-decoration-none fw-semibold mt-3 small" style="color: var(--bcc-primary);">Become a Mentor <i class="bi bi-arrow-right ms-2"></i></a>
          </div>
        </div>

        <div class="col-md-4">
          <div class="collab-card h-100 d-flex flex-column">
            <i class="bi bi-lightbulb-fill fs-2 mb-2 text-warning"></i>
            <h5 class="mb-2">Innovation Units</h5>
            <p class="text-muted small flex-grow-1">Sponsor precise engineering research setups or assist the budding development framework of student tech prototypes.</p>
            <a href="#contact" class="text-decoration-none fw-semibold mt-3 small" style="color: var(--bcc-primary);">Partner Today <i class="bi bi-arrow-right ms-2"></i></a>
          </div>
        </div>
      </div>
    </div>
  </section>

  <section class="journey-cta py-5 text-white reveal-on-scroll">
    <div class="container text-center">
      <h2 class="mb-3">Ready to Start Your Journey?</h2>
      <p class="mb-4 text-white-50">Join KUET Career Club today &mdash; connect with mentors, access exclusive jobs, and build your future.</p>
      <a href="register.aspx" class="btn btn-primary-custom btn-bcc-cta btn-bcc-cta-lg me-2">Get Started</a>
      <a href="blogs.aspx" class="btn btn-outline-custom">Explore Resources</a>
    </div>
  </section>

  <div class="modal fade" id="bookModal" tabindex="-1" aria-labelledby="bookModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="bookModalLabel">Book Mock Interview</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <form id="bookForm">
          <div class="modal-body">
            <div class="mb-3">
              <label class="form-label">Full name</label>
              <input name="name" type="text" class="form-control" required>
            </div>
            <div class="mb-3">
              <label class="form-label">Email</label>
              <input name="email" type="email" class="form-control" required>
            </div>
            <div class="mb-3">
              <label class="form-label">Preferred date</label>
              <input name="date" type="date" class="form-control">
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
            <button type="submit" class="btn btn-primary">Request Booking</button>
          </div>
        </form>
      </div>
    </div>
  </div>

  <div class="modal fade" id="planModal" tabindex="-1" aria-labelledby="planModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="planModalLabel">Career Planning Request</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <form id="planForm">
          <div class="modal-body">
            <div class="mb-3">
              <label class="form-label">Full name</label>
              <input name="name" type="text" class="form-control" required>
            </div>
            <div class="mb-3">
              <label class="form-label">Email</label>
              <input name="email" type="email" class="form-control" required>
            </div>
            <div class="mb-3">
              <label class="form-label">Goal / notes</label>
              <textarea name="notes" class="form-control" rows="3"></textarea>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
            <button type="submit" class="btn btn-primary">Request Plan</button>
          </div>
        </form>
      </div>
    </div>
  </div>

  <script>
    document.addEventListener('DOMContentLoaded', function () {
      // Job filter controls removed to avoid console errors when search inputs are not present.

      var bookForm = document.getElementById('bookForm');
      var planForm = document.getElementById('planForm');

      function showInlineAlert(message, type) {
        var alert = document.createElement('div');
        alert.className = 'alert alert-' + (type || 'success') + ' mt-3';
        alert.textContent = message;
        var container = document.querySelector('.container');
        if (container) container.insertBefore(alert, container.firstChild);
        setTimeout(function () { alert.remove(); }, 4500);
      }

      if (bookForm) {
        bookForm.addEventListener('submit', function (e) {
          e.preventDefault();
          var name = bookForm.querySelector('[name="name"]').value || 'Applicant';
          var modalEl = document.getElementById('bookModal');
          var modal = bootstrap.Modal.getInstance(modalEl);
          if (modal) modal.hide();
          showInlineAlert('Thank you, ' + name + '. Your mock interview booking request has been received. We will contact you shortly.');
          bookForm.reset();
        });
      }

      if (planForm) {
        planForm.addEventListener('submit', function (e) {
          e.preventDefault();
          var name = planForm.querySelector('[name="name"]').value || 'Applicant';
          var modalEl = document.getElementById('planModal');
          var modal = bootstrap.Modal.getInstance(modalEl);
          if (modal) modal.hide();
          showInlineAlert('Thanks, ' + name + '. A career planning advisor will reach out to you shortly.');
          planForm.reset();
        });
      }

      var jobDetailButtons = document.querySelectorAll('.job-card a.btn-outline-secondary');
      var jobModalEl = document.getElementById('jobModal');
      var jobModal = jobModalEl ? new bootstrap.Modal(jobModalEl) : null;

      jobDetailButtons.forEach(function(btn){
        btn.addEventListener('click', function(e){
          e.preventDefault();
          var card = btn.closest('.job-card');
          if (!card || !jobModal) return;
          var title = card.querySelector('h5').textContent.trim();
          var company = card.querySelector('.text-muted') ? card.querySelector('.text-muted').textContent.trim() : '';
          var desc = card.querySelector('p') ? card.querySelector('p').textContent.trim() : '';
          var list = Array.from(card.querySelectorAll('ul li')).map(function(li){ return li.innerHTML; }).join('');
          document.getElementById('jobModalTitle').textContent = title;
          document.getElementById('jobModalCompany').textContent = company;
          document.getElementById('jobModalBody').textContent = desc;
          document.getElementById('jobModalList').innerHTML = list;
          // attempt to set Apply link in modal to point to apply.aspx?job={id}
          try {
            var rawHref = btn.getAttribute('href') || '';
            var jobId = null;
            try { jobId = (new URL(rawHref, location.origin)).searchParams.get('job'); } catch(e) { jobId = null; }
            var applyBtn = document.querySelector('#jobModal .modal-footer a.btn-primary');
            if (applyBtn) {
              if (jobId) applyBtn.setAttribute('href', 'apply.aspx?job=' + encodeURIComponent(jobId)); else applyBtn.setAttribute('href', 'register.aspx');
            }
          } catch(e) {}
          jobModal.show();
        });
      });

      var bookBtns = document.querySelectorAll('.resource-card a');
      var bookingModalEl = document.getElementById('bookingModal');
      var bookingModal = bookingModalEl ? new bootstrap.Modal(bookingModalEl) : null;

      bookBtns.forEach(function(btn){
        btn.addEventListener('click', function(e){
          var text = (btn.textContent || '').toLowerCase();
          if (btn.getAttribute('href') === '#') {
            e.preventDefault();
          }
          if (!bookingModal) {
            window.location.href = 'register.aspx';
            return;
          }
          var subject = 'Booking: ' + (btn.closest('.resource-card') ? btn.closest('.resource-card').querySelector('h5').textContent : 'Session');
          document.getElementById('bookingTopic').value = subject;
          bookingModal.show();
        });
      });

      var bookingForm = document.getElementById('bookingForm');
      if (bookingForm) {
        bookingForm.addEventListener('submit', function(e){
          e.preventDefault();
          var name = bookingForm.querySelector('[name="name"]').value || 'Participant';
          alert('Thanks, ' + name + '! Your request has been received. We will contact you via email.');
          if (bookingModal) bookingModal.hide();
          bookingForm.reset();
        });
      }

      var eventData = {
        bootcamp: {
          title: 'Career Launch Bootcamp',
          date: 'June 30',
          time: '10:00 AM – 1:00 PM',
          location: 'KUET Main Auditorium',
          description: 'Join this practical workshop on resume building, interview preparation, and career networking with KUET partners.'
        },
        panel: {
          title: 'Employer Panel',
          date: 'July 5',
          time: '2:00 PM – 5:00 PM',
          location: 'Innovation Hub',
          description: 'Hear from leading employers about current openings, hiring criteria, and pathways for KUET graduates.'
        },
        clinic: {
          title: 'Resume & Interview Clinic',
          date: 'July 10',
          time: '11:00 AM – 2:00 PM',
          location: 'Career Lab',
          description: 'Book a one-on-one session for CV feedback, mock interviews, and tailored career guidance.'
        }
      };

      var eventRegisterBtns = document.querySelectorAll('.event-register-btn');
      var eventModalEl = document.getElementById('eventModal');
      var eventModal = eventModalEl ? new bootstrap.Modal(eventModalEl) : null;
      var eventForm = document.getElementById('eventForm');

      eventRegisterBtns.forEach(function(btn) {
        btn.addEventListener('click', function() {
          var eventKey = btn.dataset.event;
          var detail = eventData[eventKey];
          if (!detail || !eventModal) return;
          document.getElementById('eventModalLabel').textContent = detail.title;
          document.getElementById('selectedEvent').value = detail.title + ' — ' + detail.date;
          document.getElementById('eventModalInfo').innerHTML = '<strong>' + detail.date + ' • ' + detail.time + ' • ' + detail.location + '</strong><br>' + detail.description;
          if (eventModal) eventModal.show();
        });
      });

      if (eventForm) {
        eventForm.addEventListener('submit', function(e) {
          e.preventDefault();
          var name = eventForm.querySelector('[name="name"]').value || 'Participant';
          var eventName = eventForm.querySelector('[name="event"]').value;
          if (eventModal) eventModal.hide();
          showInlineAlert('Thanks, ' + name + '! You are registered for "' + eventName + '". We will contact you with event details shortly.');
          eventForm.reset();
        });
      }

    // Count-up animation for stat numbers and reveal-on-scroll
    function animateCount(el, target) {
      var start = 0;
      var duration = 1400;
      var startTime = null;

      function step(timestamp) {
        if (!startTime) startTime = timestamp;
        var progress = Math.min((timestamp - startTime) / duration, 1);
        var value = Math.floor(progress * (target - start) + start);
        el.textContent = value + (target >= 100 ? '+' : '');
        if (progress < 1) window.requestAnimationFrame(step);
      }
      window.requestAnimationFrame(step);
    }

    var statEls = document.querySelectorAll('.stat-number');
    var statsAnimated = false;
    function checkStats() {
      if (statsAnimated) return;
      var rect = document.querySelector('.stats').getBoundingClientRect();
      if (rect.top < window.innerHeight - 100) {
        statEls.forEach(function(el){
          var t = parseInt(el.dataset.target || el.textContent.replace(/\D/g,''),10) || 0;
          animateCount(el, t);
        });
        statsAnimated = true;
      }
    }

    function revealOnScroll() {
      document.querySelectorAll('.reveal-on-scroll').forEach(function(el){
        var rect = el.getBoundingClientRect();
        if (rect.top < window.innerHeight - 80) el.classList.add('is-visible');
      });
    }

    window.addEventListener('scroll', function(){ revealOnScroll(); checkStats(); });
    window.addEventListener('load', function(){ revealOnScroll(); checkStats(); });
    });
  </script>

  <div class="modal fade" id="jobModal" tabindex="-1" aria-labelledby="jobModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="jobModalTitle">Job Title</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <p class="text-muted mb-1" id="jobModalCompany"></p>
          <p id="jobModalBody"></p>
          <ul id="jobModalList" class="small text-muted"></ul>
        </div>
        <div class="modal-footer">
          <a href="register.aspx" class="btn btn-primary">Apply / Sign In</a>
          <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>

  <div class="modal fade" id="eventModal" tabindex="-1" aria-labelledby="eventModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="eventModalLabel">Event Registration</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <form id="eventForm">
          <div class="modal-body">
            <div class="mb-3">
              <label class="form-label">Event</label>
              <input id="selectedEvent" name="event" type="text" class="form-control" readonly>
            </div>
            <div id="eventModalInfo" class="mb-3 text-muted small"></div>
            <div class="mb-3">
              <label class="form-label">Your Name</label>
              <input name="name" type="text" class="form-control" required>
            </div>
            <div class="mb-3">
              <label class="form-label">Email</label>
              <input name="email" type="email" class="form-control" required>
            </div>
            <div class="mb-3">
              <label class="form-label">Message</label>
              <textarea name="message" class="form-control" rows="3" placeholder="Any special requirements or questions?"></textarea>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
            <button type="submit" class="btn btn-primary">Confirm Registration</button>
          </div>
        </form>
      </div>
    </div>
  </div>

  <div class="modal fade" id="bookingModal" tabindex="-1" aria-labelledby="bookingModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-md modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="bookingModalLabel">Book a Counselling Session</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <form id="bookingForm">
            <div class="mb-3">
              <label class="form-label">Your name</label>
              <input name="name" type="text" class="form-control" required>
            </div>
            <div class="mb-3">
              <label class="form-label">Email</label>
              <input name="email" type="email" class="form-control" required>
            </div>
            <div class="mb-3">
              <label class="form-label">Topic</label>
              <input id="bookingTopic" name="topic" type="text" class="form-control" readonly>
            </div>
            <div class="mb-3">
              <label class="form-label">Preferred date/time</label>
              <input name="datetime" type="datetime-local" class="form-control">
            </div>
            <div class="d-flex justify-content-end">
              <button type="submit" class="btn btn-primary">Request Session</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</asp:Content>
