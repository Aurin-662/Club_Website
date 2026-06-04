using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Net.Mail;
using System.IO;

public partial class forgot_password : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) lblMessage.Text = string.Empty;
    }

    protected void BtnSend_Click(object sender, EventArgs e)
    {
        string email = txtEmail.Text.Trim();
        if (string.IsNullOrEmpty(email))
        {
            lblMessage.Text = "Please enter your email.";
            lblMessage.ForeColor = System.Drawing.Color.Blue;
            return;
        }

        string connString = ConfigurationManager.ConnectionStrings["MyDbConnection"].ConnectionString;
        string token = Guid.NewGuid().ToString("N");
        DateTime expires = DateTime.UtcNow.AddHours(2);

        using (SqlConnection con = new SqlConnection(connString))
        {
            con.Open();
            EnsureTokenTable(con);

            // Only create token if email exists
            string q = "SELECT UserID FROM Users WHERE Email = @Email";
            using (var cmd = new SqlCommand(q, con))
            {
                cmd.Parameters.AddWithValue("@Email", email);
                var obj = cmd.ExecuteScalar();
                if (obj == null)
                {
                    // don't reveal existence — just say email sent
                    lblMessage.Text = "If an account exists for this email, a reset link has been sent.";
                    lblMessage.ForeColor = System.Drawing.Color.Blue;
                    return;
                }

                int userId = Convert.ToInt32(obj);
                string ins = "INSERT INTO PasswordResetTokens (UserID, Token, ExpiresAt) VALUES (@uid, @t, @e)";
                using (var insCmd = new SqlCommand(ins, con))
                {
                    insCmd.Parameters.AddWithValue("@uid", userId);
                    insCmd.Parameters.AddWithValue("@t", token);
                    insCmd.Parameters.AddWithValue("@e", expires);
                    insCmd.ExecuteNonQuery();
                }

                // build reset URL
                string resetUrl = Request.Url.GetLeftPart(UriPartial.Authority) + ResolveUrl("~/reset-password.aspx?token=") + Server.UrlEncode(token);

                // send email
                try
                {
                    var mail = new MailMessage();
                    string fromAddress = ConfigurationManager.AppSettings["NoReplyEmail"] ?? "no-reply@kuetcareerclub.edu";
                    mail.From = new MailAddress(fromAddress, "KUET Career Club");
                    mail.To.Add(email);
                    mail.Subject = "Password reset for KUET Career Club";
                    mail.IsBodyHtml = true;
                    mail.Body = "<p>Click the link below to reset your password (expires in 2 hours):</p><p><a href=\"" + resetUrl + "\">Reset Password</a></p>";

                    using (var smtp = new SmtpClient()) smtp.Send(mail);
                }
                catch (Exception ex)
                {
                    try
                    {
                        string queueDir = Server.MapPath("~/App_Data/queued_emails");
                        if (!Directory.Exists(queueDir)) Directory.CreateDirectory(queueDir);
                        string f = Path.Combine(queueDir, Guid.NewGuid().ToString() + ".txt");
                        File.WriteAllText(f, "To: " + email + "\nSubject: Password reset\n\nLink: " + resetUrl + "\n\nError: " + ex.ToString());
                    }
                    catch { }
                }

                lblMessage.Text = "If an account exists for this email, a reset link has been sent.";
                lblMessage.ForeColor = System.Drawing.Color.Blue;
            }
        }
    }

    private void EnsureTokenTable(SqlConnection con)
    {
        string create = @"
IF OBJECT_ID('dbo.PasswordResetTokens', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.PasswordResetTokens (
        TokenID INT IDENTITY(1,1) PRIMARY KEY,
        UserID INT NOT NULL,
        Token NVARCHAR(200) NOT NULL,
        ExpiresAt DATETIME NOT NULL,
        CreatedAt DATETIME NOT NULL DEFAULT(GETDATE())
    );
END";
        using (var cmd = new SqlCommand(create, con)) cmd.ExecuteNonQuery();
    }
}
