<%@ Page Language="C#" AutoEventWireup="true" CodeFile="refund.aspx.cs" Inherits="refund" MasterPageFile="~/Site.master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">Return &amp; Refund Policy | KUET Career Club</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

  <main class="container py-5">
    <div class="bg-white rounded-4 shadow-sm p-5 mb-5">
      <div class="row align-items-center gy-4">
        <div class="col-lg-7">
          <h1 class="display-5 mb-3">Return &amp; Refund Policy</h1>
          <p class="lead text-muted">KUET Career Club is a platform for career connections and services. This policy explains how refunds are handled for paid services and event registrations.</p>
          <p class="mb-0">If you have questions about a payment or registration, please contact support.</p>
        </div>
        <div class="col-lg-5">
          <div class="p-4 rounded-4 bg-light">
            <h5 class="mb-3">Policy overview</h5>
            <p class="text-muted mb-0">Refunds are provided when a service or event is cancelled or when the requested support meets eligibility requirements.</p>
          </div>
        </div>
      </div>
    </div>

    <section class="bg-white rounded-4 shadow-sm p-5 mb-4">
      <h2>Eligibility</h2>
      <p class="text-muted">Refunds may be available for paid KUET Career Club workshops, event registrations, or premium services if the event is cancelled or if you request a refund within the allowed time frame.</p>
      <ul class="list-unstyled text-muted">
        <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i>Event cancellations by KUET Career Club</li>
        <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i>Requests received before the refund deadline</li>
        <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i>Issues that prevent participation and are verified by support</li>
      </ul>
    </section>

    <section class="bg-white rounded-4 shadow-sm p-5 mb-4">
      <h2>Request Process</h2>
      <p class="text-muted">Submit your refund request through the Feedback page or by emailing our support team.</p>
      <p class="mb-0"><strong>Email:</strong> <a href="mailto:support@kuetcareerclub.edu">support@kuetcareerclub.edu</a></p>
    </section>

    <section class="bg-white rounded-4 shadow-sm p-5 mb-4">
      <h2>Processing Time</h2>
      <p class="text-muted">Refund requests are reviewed within 7 business days. Approved refunds are typically processed back to the original payment method within 14 business days.</p>
    </section>

    <section class="bg-white rounded-4 shadow-sm p-5">
      <h2>Contact Support</h2>
      <p class="text-muted mb-0">If you need help with a refund request, reach out to our support team and include your registration details.</p>
    </section>

  </main>


</asp:Content>
