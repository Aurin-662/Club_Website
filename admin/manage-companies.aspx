<%@ Page Title="Manage Companies | Admin" Language="C#" MasterPageFile="~/admin/Admin.master" AutoEventWireup="true" CodeFile="manage-companies.aspx.cs" Inherits="admin_manage_companies" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
<div class="container py-5">
    <div class="row">
        <div class="col-lg-5 mb-4">
            <div class="card p-4 border-0 shadow-sm rounded-3 bg-white">
                <h4 class="fw-bold text-dark mb-3"><i class="bi bi-building-add text-warning me-2"></i>Add Industry Partner</h4>
                <asp:Label ID="lblStatus" runat="server" CssClass="fw-bold d-block mb-3"></asp:Label>

                <div class="mb-2">
                    <label class="form-label small fw-semibold">Company Name</label>
                    <asp:TextBox ID="txtCompanyName" runat="server" CssClass="form-control" placeholder="e.g., TechNova Solutions"></asp:TextBox>
                </div>
                <div class="mb-2">
                    <label class="form-label small fw-semibold">Short Card Description</label>
                    <asp:TextBox ID="txtShortDesc" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" placeholder="A leading software house hiring interns..."></asp:TextBox>
                </div>
                <div class="mb-2">
                    <label class="form-label small fw-semibold">Focus Areas</label>
                    <asp:TextBox ID="txtFocusArea" runat="server" CssClass="form-control" placeholder="e.g., Software, Automation, AI"></asp:TextBox>
                </div>
                <div class="mb-2">
                    <label class="form-label small fw-semibold">Website URL</label>
                    <asp:TextBox ID="txtWebsiteUrl" runat="server" CssClass="form-control" placeholder="https://example.com"></asp:TextBox>
                </div>
                <div class="mb-3">
                    <label class="form-label small fw-semibold">Full Profile Details</label>
                    <asp:TextBox ID="txtFullProfile" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" placeholder="Write comprehensive company introduction here..."></asp:TextBox>
                </div>
                <asp:Button ID="btnSubmit" runat="server" Text="Publish Company Profile" OnClick="btnSubmit_Click" CssClass="btn btn-primary w-100 fw-bold" />
            </div>
        </div>

        <div class="col-lg-7">
            <div class="card p-4 border-0 shadow-sm rounded-3 bg-white">
                <h4 class="fw-bold text-dark mb-4"><i class="bi bi-buildings text-primary me-2"></i>Partner Records</h4>
                <asp:GridView ID="gvCompanies" runat="server" AutoGenerateColumns="False" DataKeyNames="CompanyID" CssClass="table table-hover align-middle border text-center small" OnRowDeleting="gvCompanies_RowDeleting">
                    <Columns>
                        <asp:BoundField DataField="CompanyName" HeaderText="Company Name" ItemStyle-CssClass="text-start fw-bold" />
                        <asp:BoundField DataField="FocusArea" HeaderText="Focus Area" ItemStyle-CssClass="text-muted" />
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CssClass="btn btn-danger btn-sm text-white px-2 py-1" OnClientClick="return confirm('Delete this company profile permanently?');"><i class="bi bi-trash"></i></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</div>
</asp:Content>
