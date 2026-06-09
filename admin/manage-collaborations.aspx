<%@ Page Language="C#" AutoEventWireup="true" CodeFile="manage-collaborations.aspx.cs" Inherits="admin_manage_collaborations" MasterPageFile="~/admin/Admin.master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">Manage Collaborations - Admin</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
  <section class="py-5">
    <div class="container">
      <div class="row">
        <div class="col-lg-10 mx-auto">
          <h3>Collaboration Inquiries</h3>
          <p class="text-muted">View and manage collaboration inquiries submitted by organizations.</p>

          <asp:Literal ID="litMsg" runat="server" />

          <asp:GridView ID="gvCollaborations" runat="server" CssClass="table" AutoGenerateColumns="false" OnRowCommand="gvCollaborations_RowCommand">
            <Columns>
              <asp:BoundField DataField="InquiryID" HeaderText="#" />
              <asp:BoundField DataField="OrganizationName" HeaderText="Organization" />
              <asp:BoundField DataField="ContactEmail" HeaderText="Email" />
              <asp:BoundField DataField="CollaborationType" HeaderText="Type" />
              <asp:BoundField DataField="SubmittedAt" HeaderText="Submitted" DataFormatString="{0:g}" />
              <asp:BoundField DataField="Status" HeaderText="Status" />
              <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                  <asp:Button runat="server" CommandName="view" CommandArgument='<%# Eval("InquiryID") %>' CssClass="btn btn-sm btn-outline-secondary me-2" Text="View" />
                  <asp:Button runat="server" CommandName="mark" CommandArgument='<%# Eval("InquiryID") %>' CssClass="btn btn-sm btn-success" Text="Mark Contacted" />
                </ItemTemplate>
              </asp:TemplateField>
            </Columns>
          </asp:GridView>
        </div>
      </div>
    </div>
  </section>
</asp:Content>
