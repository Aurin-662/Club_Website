<%@ Page Title="Manage Blogs | Admin" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="manage-blogs.aspx.cs" Inherits="admin_manage_blogs" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
<div class="container py-5">
    <div class="row">
        <div class="col-lg-5">
            <div class="card p-4 border shadow-sm rounded-3">
                <h4 class="fw-bold text-dark mb-4"><i class="bi bi-plus-circle-fill text-success me-2"></i>Create New Post</h4>

                <asp:Label ID="lblStatus" runat="server" CssClass="fw-bold d-block mb-3"></asp:Label>

                <div class="mb-3">
                    <label class="form-label small fw-bold">Article Title</label>
                    <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" placeholder="e.g., Guide to Google STEP Internship"></asp:TextBox>
                </div>
                <div class="mb-3">
                    <label class="form-label small fw-bold">URL Slug (Unique)</label>
                    <asp:TextBox ID="txtSlug" runat="server" CssClass="form-control" placeholder="e.g., google-step-guide"></asp:TextBox>
                </div>
                <div class="mb-3">
                    <label class="form-label small fw-bold">Category</label>
                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select">
                        <asp:ListItem>Software Engineering</asp:ListItem>
                        <asp:ListItem>Interview Prep</asp:ListItem>
                        <asp:ListItem>Higher Education</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="mb-3">
                    <label class="form-label small fw-bold">Summary Card Text</label>
                    <asp:TextBox ID="txtSummary" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control" placeholder="Short description for the home preview card..."></asp:TextBox>
                </div>
                <div class="mb-3">
                    <label class="form-label small fw-bold">Body Content (HTML/Text)</label>
                    <asp:TextBox ID="txtBody" runat="server" TextMode="MultiLine" Rows="6" CssClass="form-control" placeholder="Detailed body content goes here..."></asp:TextBox>
                </div>
                <asp:Button ID="btnSave" runat="server" Text="Publish Post" CssClass="btn btn-success w-100 fw-bold py-2" OnClick="btnSave_Click" />
            </div>
        </div>

        <div class="col-lg-7">
            <div class="card p-4 border shadow-sm rounded-3 bg-white">
                <h4 class="fw-bold text-dark mb-4"><i class="bi bi-layers-half text-primary me-2"></i>Live Articles Grid</h4>

                <asp:GridView ID="gvArticles" runat="server" AutoGenerateColumns="False" CssClass="table table-hover border text-center" DataKeyNames="Id" OnRowDeleting="gvArticles_RowDeleting">
                    <Columns>
                        <asp:BoundField DataField="Title" HeaderText="Article Title" ItemStyle-CssClass="text-start" />
                        <asp:BoundField DataField="Category" HeaderText="Category" />
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" CssClass="btn btn-danger btn-sm rounded-2" OnClientClick="return confirm('Are you sure you want to delete this article?');"><i class="bi bi-trash3"></i> Delete</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</div>
</asp:Content>
