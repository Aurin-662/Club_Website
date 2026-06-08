<%@ Page Title="Blog Article" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="article.aspx.cs" Inherits="article" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <style>
        .article-container {
            max-width: 800px;
            margin: 0 auto;
            background: #ffffff;
            border-radius: 16px;
        }
        .article-meta {
            font-size: 0.9rem;
            color: #718096;
        }
        .article-body {
            font-size: 1.1rem;
            line-height: 1.8;
            color: #2d3748;
        }
        .article-body h2, .article-body h3 {
            color: #1a202c;
            font-weight: 700;
            margin-top: 1.5rem;
            margin-bottom: 1rem;
        }
        .article-body p {
            margin-bottom: 1.2rem;
        }
        .badge-category {
            background: #eef6ff;
            color: #004080;
            font-weight: 600;
            padding: 6px 14px;
            border-radius: 20px;
            text-transform: uppercase;
            font-size: 0.8rem;
        }
    </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5">

        <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="alert alert-danger text-center my-4 rounded-3">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>
            <asp:Label ID="lblErrorMsg" runat="server" Text="Article not found or has been removed."></asp:Label>
            <br />
            <a href="blogs.aspx" class="btn btn-outline-danger btn-sm mt-3 fw-bold">Back to Knowledge Hub</a>
        </asp:Panel>

        <asp:Panel ID="pnlArticle" runat="server" CssClass="article-container p-4 p-md-5 border shadow-sm">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <a href="blogs.aspx" class="text-decoration-none text-muted fw-semibold small">
                    <i class="bi bi-arrow-left me-1"></i> Back to Blogs
                </a>
                <span class="badge-category">
                    <asp:Literal ID="litCategory" runat="server"></asp:Literal>
                </span>
            </div>

            <h1 class="display-5 fw-bold text-dark mb-3">
                <asp:Literal ID="litTitle" runat="server"></asp:Literal>
            </h1>

            <div class="article-meta d-flex align-items-center gap-3 pb-4 mb-4 border-bottom">
                <span><i class="bi bi-calendar3 me-1"></i> <asp:Literal ID="litDate" runat="server"></asp:Literal></span>
                <span><i class="bi bi-person-circle me-1"></i> KUET Career Club Core</span>
            </div>

            <div class="article-body">
                <asp:Literal ID="litBody" runat="server"></asp:Literal>
            </div>

        </asp:Panel>
    </div>
</asp:Content>
