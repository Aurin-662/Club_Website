<%@ Page Language="C#" AutoEventWireup="true" CodeFile="contact.aspx.cs" Inherits="contact" MasterPageFile="~/Site.master" %>
<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">Contact Us | KUET Career Club</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <style> .contact-hero { background: linear-gradient(180deg,#fff 0%, #f8f9fa 100%); } </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">



    <main class="container py-5">
      <div class="bg-white rounded-4 shadow-sm p-5 mb-4 contact-hero">
        <div class="row align-items-center">
          <div class="col-lg-7">
            <h1 class="display-5 mb-3">Contact KUET Career Club</h1>
            <p class="lead text-muted">Questions about jobs, events, collaborations or support? Get in touch and we’ll respond within 3 business days.</p>
            <p class="mb-0"><strong>Email:</strong> <a href="mailto:support@kuetcareerclub.edu">support@kuetcareerclub.edu</a></p>
          </div>
          <div class="col-lg-5">
            <div class="p-4 rounded-4 bg-light">
              <h5 class="mb-3">Contact Hours</h5>
              <p class="mb-0 text-muted">Mon–Fri, 9:00–17:00</p>
            </div>
          </div>
        </div>
      </div>

      <div class="bg-white rounded-4 shadow-sm p-5 mb-5">
        <div class="row g-4">
          <div class="col-md-6">
            <label class="form-label">Your Name</label>
            <asp:TextBox ID="txtName" runat="server" ClientIDMode="Static" CssClass="form-control" placeholder="Full name"></asp:TextBox>
          </div>
          <div class="col-md-6">
            <label class="form-label">Email</label>
            <asp:TextBox ID="txtEmail" runat="server" ClientIDMode="Static" CssClass="form-control" TextMode="Email" placeholder="name@example.com"></asp:TextBox>
          </div>
          <div class="col-md-6">
            <label class="form-label">I am a</label>
            <asp:DropDownList ID="ddlRole" runat="server" ClientIDMode="Static" CssClass="form-select">
              <asp:ListItem Text="Choose role" Value="" Selected="True"></asp:ListItem>
              <asp:ListItem Text="Student" Value="Student"></asp:ListItem>
              <asp:ListItem Text="Alumni" Value="Alumni"></asp:ListItem>
              <asp:ListItem Text="Employer" Value="Employer"></asp:ListItem>
              <asp:ListItem Text="Partner" Value="Partner"></asp:ListItem>
            </asp:DropDownList>
          </div>
          <div class="col-md-6">
            <label class="form-label">Subject</label>
            <asp:TextBox ID="txtSubject" runat="server" ClientIDMode="Static" CssClass="form-control" placeholder="Subject"></asp:TextBox>
          </div>
          <div class="col-12">
            <label class="form-label">Message</label>
            <asp:TextBox ID="txtMessage" runat="server" ClientIDMode="Static" CssClass="form-control" TextMode="MultiLine" Rows="6" placeholder="Write your message..."></asp:TextBox>
          </div>
          <div class="col-12 text-end">
            <asp:Button ID="btnSendMessage" runat="server" ClientIDMode="Static" CssClass="btn text-white" style="background: #8B2D31;" Text="Send Message" UseSubmitBehavior="true" />
          </div>
        </div>
      </div>
    </main>

</asp:Content>
