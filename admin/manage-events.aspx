<%@ Page Language="C#" AutoEventWireup="true" CodeFile="manage-events.aspx.cs" Inherits="admin_manage_events" MasterPageFile="~/admin/Admin.master" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
  <div class="container">
    <h3>Manage Events</h3>
    <asp:Literal ID="litManageStatus" runat="server"></asp:Literal>

    <div class="card p-3 mb-4">
      <h5 class="mb-2">Add / Edit Event</h5>
      <asp:HiddenField ID="hfEventID" runat="server" />
      <div class="row g-3">
        <div class="col-md-4">
          <label class="form-label">Title</label>
          <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-2">
          <label class="form-label">Date</label>
          <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" placeholder="e.g. June 30"></asp:TextBox>
        </div>
        <div class="col-md-3">
          <label class="form-label">Location</label>
          <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-3">
          <label class="form-label">Type</label>
          <asp:TextBox ID="txtType" runat="server" CssClass="form-control" placeholder="Workshop / Panel / Clinic"></asp:TextBox>
        </div>
        <div class="col-12">
          <label class="form-label">Description</label>
          <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col-md-3">
          <label class="form-label">Time</label>
          <asp:TextBox ID="txtTime" runat="server" CssClass="form-control" placeholder="10:00 AM - 1:00 PM"></asp:TextBox>
        </div>
        <div class="col-md-3">
          <label class="form-label">Badge Class</label>
          <asp:TextBox ID="txtBadge" runat="server" CssClass="form-control" placeholder="bg-primary-soft"></asp:TextBox>
        </div>
        <div class="col-12 d-flex gap-2">
          <asp:Button ID="btnSaveEvent" runat="server" Text="Save Event" CssClass="btn btn-primary" OnClick="btnSaveEvent_Click" />
          <asp:Button ID="btnReset" runat="server" Text="Clear" CssClass="btn btn-outline-secondary" OnClick="btnReset_Click" />
        </div>
      </div>
    </div>

    <h5>Existing Events</h5>
    <asp:Literal ID="litCount" runat="server"></asp:Literal>
    <asp:Repeater ID="rptManage" runat="server" OnItemCommand="rptManage_ItemCommand">
      <HeaderTemplate>
        <div class="list-group">
      </HeaderTemplate>
      <ItemTemplate>
        <div class="list-group-item d-flex justify-content-between align-items-start">
          <div>
            <div class="fw-bold"><%# Eval("EventTitle") %></div>
            <div class="small text-muted"><%# Eval("EventDate") %> | <%# Eval("EventLocation") %> • <%# Eval("EventTime") %></div>
            <div class="mt-2"><%# Eval("Description") %></div>
          </div>
          <div class="btn-group">
            <asp:Button runat="server" CssClass="btn btn-sm btn-outline-secondary" CommandName="edit" CommandArgument='<%# Eval("EventID") %>' Text="Edit" />
            <asp:Button runat="server" CssClass="btn btn-sm btn-danger" CommandName="delete" CommandArgument='<%# Eval("EventID") %>' Text="Delete" OnClientClick="return confirm('Delete this event?');" />
          </div>
        </div>
      </ItemTemplate>
      <FooterTemplate>
        </div>
      </FooterTemplate>
    </asp:Repeater>
  </div>
</asp:Content>