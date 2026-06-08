<%@ Page Title="Manage Alumni | Admin" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="manage-alumni.aspx.cs" Inherits="admin_manage_alumni" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
<div class="container py-5">
    <div class="row">
        <div class="col-lg-5 mb-4">
            <div class="card p-4 border-0 shadow-sm rounded-3 bg-white">
                <h4 class="fw-bold text-dark mb-3"><i class="bi bi-patch-check-fill text-warning me-2"></i>Add Alumni Success</h4>
                <asp:Label ID="lblStatus" runat="server" CssClass="fw-bold d-block mb-3"></asp:Label>

                <div class="mb-2">
                    <label class="form-label small fw-semibold">Alumni Full Name</label>
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="e.g., Sabbir Ahmed"></asp:TextBox>
                </div>
                <div class="mb-2">
                    <label class="form-label small fw-semibold">Designation & Short Bio</label>
                    <asp:TextBox ID="txtBio" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" placeholder="Undergrad @ ME, active in automotive..."></asp:TextBox>
                </div>
                <div class="mb-2">
                    <label class="form-label small fw-semibold">Skills (Comma/Space Separated)</label>
                    <asp:TextBox ID="txtSkills" runat="server" CssClass="form-control" placeholder="e.g., MATLAB, Process Design, Python"></asp:TextBox>
                </div>
                <div class="mb-3">
                    <label class="form-label small fw-semibold">Full Success Journey / Extended Story</label>
                    <asp:TextBox ID="txtFullStory" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" placeholder="Write full journey details here..."></asp:TextBox>
                </div>
                <asp:Button ID="btnSubmit" runat="server" Text="Publish Alumni Profile" OnClick="btnSubmit_Click" CssClass="btn btn-warning w-100 fw-bold text-dark" />
            </div>
        </div>

        <div class="col-lg-7">
            <div class="card p-4 border-0 shadow-sm rounded-3 bg-white">
                <h4 class="fw-bold text-dark mb-4"><i class="bi bi-shield-check text-primary me-2"></i>Alumni Records</h4>
                <asp:GridView ID="gvAlumni" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" CssClass="table table-hover align-middle border text-center small" OnRowDeleting="gvAlumni_RowDeleting">
                    <Columns>
                        <asp:BoundField DataField="FullName" HeaderText="Alumni Name" ItemStyle-CssClass="text-start fw-bold" />
                        <asp:BoundField DataField="Skills" HeaderText="Skills" ItemStyle-CssClass="text-muted" />
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CssClass="btn btn-danger btn-sm text-white px-2 py-1" OnClientClick="return confirm('Delete this success story permanently?');"><i class="bi bi-trash"></i></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</div>
</asp:Content>
