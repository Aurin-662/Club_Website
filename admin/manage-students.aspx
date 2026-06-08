<%@ Page Title="Manage Students | Admin" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="manage-students.aspx.cs" Inherits="admin_manage_students" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
<div class="container py-5">
    <div class="row">
        <div class="col-lg-5">
            <div class="card p-4 border-0 shadow-sm rounded-3 bg-white">
                <h4 class="fw-bold text-dark mb-3"><i class="bi bi-person-plus-fill text-primary me-2"></i>Add Student Profile</h4>
                <asp:Label ID="lblStatus" runat="server" CssClass="fw-bold d-block mb-3"></asp:Label>

                <div class="row g-2">
                    <div class="col-md-6 mb-2">
                        <label class="form-label small fw-semibold">Roll ID / Unique ID</label>
                        <asp:TextBox ID="txtRollID" runat="server" CssClass="form-control" placeholder="e.g., 2004035CE"></asp:TextBox>
                    </div>
                    <div class="col-md-6 mb-2">
                        <label class="form-label small fw-semibold">Full Name</label>
                        <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Name"></asp:TextBox>
                    </div>
                </div>
                <div class="row g-2">
                    <div class="col-md-6 mb-2">
                        <label class="form-label small fw-semibold">Department</label>
                        <asp:DropDownList ID="ddlDept" runat="server" CssClass="form-select">
                            <asp:ListItem>CSE</asp:ListItem>
                            <asp:ListItem>EEE</asp:ListItem>
                            <asp:ListItem>ME</asp:ListItem>
                            <asp:ListItem>CE</asp:ListItem>
                            <asp:ListItem>IPE</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-6 mb-2">
                        <label class="form-label small fw-semibold">Level/Year</label>
                        <asp:DropDownList ID="ddlLevel" runat="server" CssClass="form-select">
                            <asp:ListItem>Level 2</asp:ListItem>
                            <asp:ListItem>Level 3</asp:ListItem>
                            <asp:ListItem>Level 4</asp:ListItem>
                            <asp:ListItem>Final</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="mb-2">
                    <label class="form-label small fw-semibold">Skills (Space Separated)</label>
                    <asp:TextBox ID="txtSkills" runat="server" CssClass="form-control" placeholder="e.g., React NodeJS SQL JavaScript"></asp:TextBox>
                </div>
                <div class="mb-2">
                    <label class="form-label small fw-semibold">Short Bio</label>
                    <asp:TextBox ID="txtBio" runat="server" CssClass="form-control" placeholder="Enthusiastic about..."></asp:TextBox>
                </div>
                <div class="row g-2">
                    <div class="col-md-6 mb-2">
                        <label class="form-label small fw-semibold">Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="name@kuet.ac.bd"></asp:TextBox>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label small fw-semibold">Phone</label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="+88017XXXXXXXX"></asp:TextBox>
                    </div>
                </div>
                <asp:Button ID="btnRegister" runat="server" Text="Register Student Profile" OnClick="btnRegister_Click" CssClass="btn btn-primary w-100 fw-bold" />
            </div>
        </div>

        <div class="col-lg-7">
            <div class="card p-4 border-0 shadow-sm rounded-3 bg-white">
                <h4 class="fw-bold text-dark mb-4"><i class="bi bi-people-fill text-success me-2"></i>Registered Portal Directory</h4>
                <asp:GridView ID="gvStudents" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" CssClass="table table-hover align-middle border text-center small" OnRowDeleting="gvStudents_RowDeleting">
                    <Columns>
                        <asp:BoundField DataField="RollID" HeaderText="Roll ID" />
                        <asp:BoundField DataField="FullName" HeaderText="Name" ItemStyle-CssClass="text-start fw-bold" />
                        <asp:BoundField DataField="Department" HeaderText="Dept" />
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CssClass="btn btn-danger btn-sm text-white px-2 py-1" OnClientClick="return confirm('Delete this profile permanently?');"><i class="bi bi-trash"></i></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</div>
</asp:Content>
