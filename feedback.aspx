<%@ Page Language="C#" AutoEventWireup="true" CodeFile="feedback.aspx.cs" Inherits="feedback" MasterPageFile="~/Site.master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">Feedback | KUET Career Club</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

  <main class="container py-5">
    <div class="bg-white rounded-4 shadow-sm p-5 mb-5">
      <div class="row align-items-center gy-4">
        <div class="col-lg-7">
          <h1 class="display-5 mb-3">Send Your Feedback</h1>
          <p class="lead text-muted">Share your ideas, ask for support, or let us know how KUET Career Club can improve.</p>
          <p class="mb-0">We review all messages personally and respond to every request as quickly as possible.</p>
        </div>
        <div class="col-lg-5">
          <div class="p-4 rounded-4 bg-light">
            <h5 class="mb-3">Your input matters</h5>
            <p class="text-muted">Your feedback helps us build better student, alumni, and employer experiences.</p>
            <p class="mb-0"><strong>Email:</strong> <a href="mailto:support@kuetcareerclub.edu">support@kuetcareerclub.edu</a></p>
          </div>
        </div>
      </div>
    </div>

    <div class="bg-white rounded-4 shadow-sm p-5">
      <div class="row g-4">
        <div class="col-md-6">
          <label class="form-label">Your Name</label>
          <asp:TextBox ID="txtFeedbackName" runat="server" ClientIDMode="Static" CssClass="form-control" placeholder="Enter your name"></asp:TextBox>
        </div>
        <div class="col-md-6">
          <label class="form-label">Email Address</label>
          <asp:TextBox ID="txtFeedbackEmail" runat="server" ClientIDMode="Static" CssClass="form-control" TextMode="Email" placeholder="name@example.com"></asp:TextBox>
        </div>
        <div class="col-md-6">
          <label class="form-label">I am a</label>
          <asp:DropDownList ID="ddlFeedbackRole" runat="server" ClientIDMode="Static" CssClass="form-select">
            <asp:ListItem Text="Choose role" Value="" Selected="True"></asp:ListItem>
            <asp:ListItem Text="Student" Value="Student"></asp:ListItem>
            <asp:ListItem Text="Alumni" Value="Alumni"></asp:ListItem>
            <asp:ListItem Text="Employer" Value="Employer"></asp:ListItem>
            <asp:ListItem Text="Partner" Value="Partner"></asp:ListItem>
          </asp:DropDownList>
        </div>
        <div class="col-md-6">
          <label class="form-label">Subject</label>
          <asp:TextBox ID="txtFeedbackSubject" runat="server" ClientIDMode="Static" CssClass="form-control" placeholder="e.g., Account Issue, Event Feedback"></asp:TextBox>
        </div>
        <div class="col-12">
          <label class="form-label">Message</label>
          <asp:TextBox ID="txtFeedbackMessage" runat="server" ClientIDMode="Static" CssClass="form-control" TextMode="MultiLine" Rows="5" placeholder="Write your message here..."></asp:TextBox>
        </div>
        <div class="col-12 text-end">
          <asp:Button ID="btnSubmitFeedback" runat="server" ClientIDMode="Static" CssClass="btn text-white" style="background: #8B2D31;" Text="Submit Feedback" UseSubmitBehavior="true" />
        </div>
      </div>
    </div>
  </main>


</asp:Content>
