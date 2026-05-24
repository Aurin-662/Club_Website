using System;
using System.Web.UI;

public partial class login : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void BtnSignIn_Click(object sender, EventArgs e)
    {
        string email = txtLoginEmail.Text.Trim();
        string password = txtLoginPassword.Text.Trim();

        // 1. Validate against empty fields
        if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
        {
            lblMessage.CssClass = "mt-3 text-center text-danger d-inline-block";
            lblMessage.Text = "Please enter your email and password.";
            return;
        }

        // 2. Add authentication logic here 
        // Example: if (MyAuthService.Login(email, password)) { ... }

        // Mocking validation and redirection:
        lblMessage.CssClass = "mt-3 text-center text-success d-inline-block";
        lblMessage.Text = "Login successful — redirecting to home...";
        
        // Redirect execution to the destination page
        Response.Redirect("home.aspx");
    }
}