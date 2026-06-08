<%@ Page Language="C#" AutoEventWireup="true" CodeFile="collaborate.aspx.cs" Inherits="collaborate" MasterPageFile="~/Site.master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Collaborate | KUET Career Club
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <style>
        .card-feature {
            background: #ffffff;
            border: 1px solid rgba(15, 23, 42, 0.06) !important;
            border-radius: 16px;
            transition: transform 0.3s cubic-bezier(0.2, 0.9, 0.2, 1), box-shadow 0.3s ease;
        }
        .card-feature:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.05) !important;
        }
        .btn-custom-collab {
            background: #8B2D31;
            color: #ffffff !important;
            font-weight: 600;
            border-radius: 8px;
            transition: background 0.2s ease, transform 0.1s ease;
            border: none;
        }
        .btn-custom-collab:hover {
            background: #722225;
            transform: translateY(-1px);
        }
        .btn-custom-collab:active {
            transform: translateY(0);
        }
        .form-label-custom {
            font-size: 0.85rem;
            font-weight: 600;
            color: #334155;
            margin-bottom: 6px;
        }
        .form-control, .form-select {
            border-radius: 8px;
            padding: 10px 14px;
            border: 1px solid #cbd5e1;
            font-size: 0.9rem;
            transition: border-color 0.15s ease, box-shadow 0.15s ease;
        }
        .form-control:focus, .form-select:focus {
            border-color: #004080;
            box-shadow: 0 0 0 3px rgba(0, 64, 128, 0.1);
        }
    </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <main class="container py-5">
        
        <div class="bg-white rounded-4 shadow-sm p-4 p-md-5 mb-5 border" style="border-color: rgba(0,0,0,0.03) !important;">
            <div class="row align-items-center gy-4">
                <div class="col-lg-7">
                    <h1 class="display-6 fw-bold text-dark mb-3">Collaborate with KUET Career Club</h1>
                    <p class="lead text-muted" style="font-size: 1.1rem; line-height: 1.6;">Bring industry, students, and alumni together through strategic partnerships, campus events, and talent pipelines designed for engineering excellence.</p>
                    <p class="mb-0 text-secondary small">Our collaboration platform helps corporate teams sponsor events, hire interns, host engineering workshops, and launch industrial capstone projects with KUET’s brightest minds.</p>
                </div>
                <div class="col-lg-5">
                    <div class="p-4 rounded-4 shadow-sm border border-warning-subtle" style="background: #fafbfc; border-left: 5px solid #ffcc00 !important;">
                        <h5 class="fw-bold text-dark mb-2"><i class="bi bi-briefcase text-warning me-2"></i>Start a Partnership</h5>
                        <p class="text-muted small mb-4">Submit your organization's collaboration interest and our corporate relations team will immediately reach out with the best match for your technical or recruitment goals.</p>
                        <a href="#inquiry-form-section" class="btn btn-custom-collab w-100 py-2.5 text-center shadow-sm">
                            <i class="bi bi-arrow-down-circle me-2"></i>Jump to Inquiry Form
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4 mb-5">
            <div class="col-md-4">
                <div class="card card-feature h-100 border-0 shadow-sm p-3">
                    <div class="card-body">
                        <div class="mb-3 text-primary"><i class="bi bi-building-gear fs-3"></i></div>
                        <h5 class="card-title fw-bold text-dark mb-2">Industry Partnerships</h5>
                        <p class="card-text text-muted small" style="line-height: 1.5;">Work alongside KUET engineering departments on strategic recruitment drives, joint research ventures, and co-branded career events tailored to engineering sub-disciplines.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card card-feature h-100 border-0 shadow-sm p-3">
                    <div class="card-body">
                        <div class="mb-3 text-warning"><i class="bi bi-calendar-event fs-3"></i></div>
                        <h5 class="card-title fw-bold text-dark mb-2">Campus Events</h5>
                        <p class="card-text text-muted small" style="line-height: 1.5;">Host interactive technical workshops, full-scale national hackathons, and corporate career fairs that instantly bridge your talent needs with motivated undergraduates.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card card-feature h-100 border-0 shadow-sm p-3">
                    <div class="card-body">
                        <div class="mb-3 text-success"><i class="bi bi-cpu fs-3"></i></div>
                        <h5 class="card-title fw-bold text-dark mb-2">Student Projects</h5>
                        <p class="card-text text-muted small" style="line-height: 1.5;">Sponsor real-world student challenges, industry-grade prototyping, and dynamic summer internship collaborations to strategically solve complex business problems.</p>
                    </div>
                </div>
            </div>
        </div>

        <section id="inquiry-form-section" class="bg-white rounded-4 shadow-sm p-4 p-md-5 border" style="border-color: rgba(0,0,0,0.03) !important;">
            <div class="row g-5">
                
                <div class="col-lg-6">
                    <h2 class="fw-bold text-dark mb-2"><i class="bi bi-pencil-square me-2 text-primary"></i>Partner Inquiry Form</h2>
                    <p class="text-muted small mb-4">Tell us about your organization's timeline and alignment, and our platform leads will structure a custom framework fitting your goals.</p>
                    
                    <asp:Label ID="lblStatus" runat="server" ClientIDMode="Static" CssClass="d-block mb-3 p-3 rounded-3 small fw-bold" Visible="false"></asp:Label>
                    
                    <div class="mb-3">
                        <label class="form-label form-label-custom">Organization / Company Name</label>
                        <asp:TextBox ID="txtOrgName" runat="server" ClientIDMode="Static" CssClass="form-control" placeholder="e.g., TechNova Solutions"></asp:TextBox>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label form-label-custom">Official Contact Email</label>
                        <asp:TextBox ID="txtOrgEmail" runat="server" ClientIDMode="Static" CssClass="form-control" TextMode="Email" placeholder="e.g., hr@company.com"></asp:TextBox>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label form-label-custom">Primary Collaboration Interest</label>
                        <asp:DropDownList ID="ddlCollabInterest" runat="server" ClientIDMode="Static" CssClass="form-select">
                            <asp:ListItem Text="Select collaboration framework" Value="" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="Recruitment & Flagship Internships" Value="Recruitment"></asp:ListItem>
                            <asp:ListItem Text="National Hackathon / Tech Workshop" Value="Workshop"></asp:ListItem>
                            <asp:ListItem Text="R&D / Industrial Research Project" Value="Research"></asp:ListItem>
                            <asp:ListItem Text="Corporate Event Sponsorship" Value="Sponsorship"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    
                    <div class="mb-4">
                        <label class="form-label form-label-custom">Detailed Proposal / Core Initiative Message</label>
                        <asp:TextBox ID="txtCollabMessage" runat="server" ClientIDMode="Static" CssClass="form-control" TextMode="MultiLine" Rows="4" placeholder="Briefly introduce your roadmap, expectations, or targeted engineering departments..."></asp:TextBox>
                    </div>
                    
                    <asp:Button ID="btnSendInquiry" runat="server" ClientIDMode="Static" CssClass="btn btn-custom-collab px-4 py-2.5 shadow-sm small" Text="Send Partnership Inquiry" UseSubmitBehavior="true" OnClick="btnSendInquiry_Click" />
                </div>
                
                <div class="col-lg-6">
                    <div class="p-4 p-md-5 rounded-4 h-100 d-flex flex-column justify-content-between" style="background: #f8fafc; border: 1px solid rgba(0,0,0,0.02);">
                        <div>
                            <h4 class="fw-bold text-dark mb-3"><i class="bi bi-question-circle-fill text-success me-2"></i>Why Partner With Us?</h4>
                            <p class="text-secondary small mb-4">KUET Career Club serves as the premier liaison channel providing frictionless corporate gateways directly to the university grounds.</p>
                            
                            <ul class="list-unstyled text-muted small mt-3">
                                <li class="d-flex align-items-start mb-3">
                                    <i class="bi bi-check-circle-fill text-success me-3 mt-0.5"></i>
                                    <span><strong>Verified Engineers:</strong> Immediate access to highly vetted tech and research talents across multi-disciplinary engineering tracks.</span>
                                </li>
                                <li class="d-flex align-items-start mb-3">
                                    <i class="bi bi-check-circle-fill text-success me-3 mt-0.5"></i>
                                    <span><strong>Tailored Frameworks:</strong> Co-develop specialized technical bootcamps, hackathons, and production-level sandbox challenges.</span>
                                </li>
                                <li class="d-flex align-items-start mb-3">
                                    <i class="bi bi-check-circle-fill text-success me-3 mt-0.5"></i>
                                    <span><strong>National Branding:</strong> Rapidly scale your corporate presence, mission visibility, and employment benefits among students nationwide.</span>
                                </li>
                            </ul>
                        </div>
                        
                        <div class="border-top pt-4 mt-4">
                            <p class="mb-1 text-dark fw-bold small"><i class="bi bi-envelope-at me-2 text-secondary"></i>Direct Corporate Helpline:</p>
                            <a href="mailto:collaborate@kuetcareerclub.edu" class="text-decoration-none fw-semibold" style="color: #004080; font-size: 0.95rem;">collaborate@kuetcareerclub.edu</a>
                        </div>
                    </div>
                </div>

            </div>
        </section>
    </main>
</asp:Content>