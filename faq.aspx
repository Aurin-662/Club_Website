<%@ Page Language="C#" AutoEventWireup="true" CodeFile="faq.aspx.cs" Inherits="faq" MasterPageFile="~/Site.master" %>
<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">FAQs | KUET Career Club</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css" />
  <link rel="stylesheet" href="style.css" />
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <main class="container py-5">
      <div class="bg-white rounded-4 shadow-sm p-5 mb-5">
        <div class="row align-items-center gy-4">
          <div class="col-lg-7">
            <h1 class="display-5 mb-3">Frequently Asked Questions</h1>
            <p class="lead text-muted">Your guide to using KUET Career Club, from account setup to internship application tips.</p>
            <p class="mb-0">If you need more help, visit our support page for direct assistance.</p>
          </div>
          <div class="col-lg-5">
            <div class="p-4 rounded-4 bg-light">
              <h5 class="mb-3">Can’t find what you need?</h5>
              <p class="text-muted">Send us a message and one of our career advisors will help you quickly.</p>
              <a href="feedback.aspx" class="btn text-white" style="background: #8B2D31;">Contact Support</a>
            </div>
          </div>
        </div>
      </div>

      <div class="accordion" id="faqAccordion">
        <div class="accordion-item">
          <h2 class="accordion-header" id="headingOne">
            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
              How do I register for KUET Career Club?
            </button>
          </h2>
          <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#faqAccordion">
            <div class="accordion-body text-muted">
              Visit the Register page, fill in your profile details, and verify your KUET credentials. Once approved, you can access jobs, events, and networking features.
            </div>
          </div>
        </div>
        <div class="accordion-item">
          <h2 class="accordion-header" id="headingTwo">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
              What kind of jobs are posted here?
            </button>
          </h2>
          <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#faqAccordion">
            <div class="accordion-body text-muted">
              We list internships, part-time opportunities, and full-time roles from trusted employers looking for engineering and tech talent from KUET.
            </div>
          </div>
        </div>
        <div class="accordion-item">
          <h2 class="accordion-header" id="headingThree">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
              How do I update my profile or resume?
            </button>
          </h2>
          <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#faqAccordion">
            <div class="accordion-body text-muted">
              Once logged in, go to your student or alumni portal page and use the profile editor to upload a new CV, add skills, and update your academic details.
            </div>
          </div>
        </div>
        <div class="accordion-item">
          <h2 class="accordion-header" id="headingFour">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
              Who can post jobs and sponsorships?
            </button>
          </h2>
          <div id="collapseFour" class="accordion-collapse collapse" aria-labelledby="headingFour" data-bs-parent="#faqAccordion">
            <div class="accordion-body text-muted">
              Companies can post jobs through the Companies page after registering and receiving approval. Alumni and partner organizations may also sponsor events through the Collaborate page.
            </div>
          </div>
        </div>
        <div class="accordion-item">
          <h2 class="accordion-header" id="headingFive">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFive" aria-expanded="false" aria-controls="collapseFive">
              Where can I find support if I have an issue?
            </button>
          </h2>
          <div id="collapseFive" class="accordion-collapse collapse" aria-labelledby="headingFive" data-bs-parent="#faqAccordion">
            <div class="accordion-body text-muted">
              Use our Feedback page to submit a support request, or review the Help Center articles and policies for immediate answers.
            </div>
          </div>
        </div>
      </div>

    </main>


</asp:Content>
