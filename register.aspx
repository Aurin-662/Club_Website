<%@ Page Language="C#" AutoEventWireup="true" CodeFile="register.aspx.cs" Inherits="register" MasterPageFile="~/Site.master" %>
<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">Register | KUET Career Club</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <section class="registration-form-area py-5">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="registration-card shadow-sm">
                        <div class="card-header-bcc">
                            <h4>Member Registration</h4>
                            <p>Fill up the form below to join the KUET Career Club network.</p>
                        </div>

                        <div id="registerForm" class="p-4 p-md-5">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">Full Name</label>
                                    <asp:TextBox ID="txtFullName" runat="server" ClientIDMode="Static" CssClass="form-control" placeholder="Enter your full name"></asp:TextBox>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Student ID</label>
                                    <asp:TextBox ID="txtStudentId" runat="server" ClientIDMode="Static" CssClass="form-control" placeholder="Example: 2007001"></asp:TextBox>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">Department</label>
                                    <asp:DropDownList ID="ddlDepartment" runat="server" ClientIDMode="Static" CssClass="form-select">
                                        <asp:ListItem Text="Select Department" Value="" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="CSE" Value="CSE"></asp:ListItem>
                                        <asp:ListItem Text="EEE" Value="EEE"></asp:ListItem>
                                        <asp:ListItem Text="ME" Value="ME"></asp:ListItem>
                                        <asp:ListItem Text="CE" Value="CE"></asp:ListItem>
                                        <asp:ListItem Text="IPE" Value="IPE"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Batch</label>
                                    <asp:TextBox ID="txtBatch" runat="server" ClientIDMode="Static" CssClass="form-control" TextMode="Number" placeholder="Example: 20"></asp:TextBox>
                                </div>

                                <div class="col-md-12">
                                    <label class="form-label">KUET Email Address</label>
                                    <asp:TextBox ID="txtEmail" runat="server" ClientIDMode="Static" CssClass="form-control" TextMode="Email" placeholder="name@stud.kuet.ac.bd"></asp:TextBox>
                                </div>

                                <div class="col-md-12">
                                    <label class="form-label">Profile Picture (Passport Size)</label>
                                    <asp:FileUpload ID="fileProfile" runat="server" ClientIDMode="Static" CssClass="form-control" />
                                    <small class="text-muted">Max size: 2MB (.jpg or .png)</small>
                                </div>

                                <div class="col-md-12 mt-4">
                                    <div class="form-check">
                                        <asp:CheckBox ID="chkTerms" runat="server" ClientIDMode="Static" CssClass="form-check-input" />
                                        <label class="form-check-label" for="chkTerms">
                                            I agree to the club's <a href="#">constitution</a> and <a href="#">code of conduct</a>.
                                        </label>
                                    </div>
                                </div>

                                <div class="col-md-12 text-center mt-4">
                                    <asp:Button ID="btnCreateAccount" runat="server" ClientIDMode="Static" CssClass="btn btn-primary-bcc" Text="Create Account" UseSubmitBehavior="false" OnClientClick="registerClientSubmit(); return false;" />
                                </div>
                                <div class="col-12 text-center auth-form-footer mt-3">
                                    Already a member? <a href="login.aspx">Sign In</a>
                                </div>
                            </div>
                        </div>
                        <div id="registerMessage" class="mt-3 text-center"></div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <script>
        function registerClientSubmit() {
            const message = document.getElementById('registerMessage');
            message.textContent = 'Registration submitted successfully. Please check your KUET email for confirmation.';
            message.className = 'mt-3 text-center text-success';

            // Form input reset logic
            document.querySelectorAll('#registerForm input, #registerForm select, #registerForm textarea').forEach(function (el) {
                if (el.type === 'checkbox' || el.type === 'radio') el.checked = false; else el.value = '';
            });
        }
    </script>

</asp:Content>
