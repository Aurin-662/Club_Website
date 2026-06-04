using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Net.Mail;
using System.Text;

public partial class apply : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            int jobId;
            if (int.TryParse(Request.QueryString["job"], out jobId))
            {
                LoadJob(jobId);
                ViewState["JobId"] = jobId;
            }
            else
            {
                Response.Redirect("jobs.aspx");
            }
        }
    }

    private void LoadJob(int id)
    {
        var setting = ConfigurationManager.ConnectionStrings["DbConnect"];
        string conn = (setting != null && !string.IsNullOrEmpty(setting.ConnectionString))
            ? setting.ConnectionString
            : @"Data Source=.\SQLEXPRESS;Initial Catalog=KUET_Career_Club_DB;Integrated Security=True;";

        using (SqlConnection c = new SqlConnection(conn))
        {
            string q = "SELECT JobTitle, CompanyName, CompanyEmail FROM Jobs WHERE JobID = @id";
            using (SqlCommand cmd = new SqlCommand(q, c))
            {
                cmd.Parameters.AddWithValue("@id", id);
                c.Open();
                using (var r = cmd.ExecuteReader())
                {
                    if (r.Read())
                    {
                        lblJobTitle.InnerText = r["JobTitle"].ToString();
                        lblCompany.InnerText = "Company: " + r["CompanyName"].ToString();
                        // store company email in ViewState for later use when sending application
                        ViewState["CompanyEmail"] = r["CompanyEmail"] == DBNull.Value ? null : r["CompanyEmail"].ToString();
                    }
                    else
                    {
                        Response.Redirect("jobs.aspx");
                    }
                }
            }
        }
    }

    protected void btnApply_Click(object sender, EventArgs e)
    {
        int jobId = ViewState["JobId"] != null ? (int)ViewState["JobId"] : 0;
        if (jobId == 0)
        {
            Response.Redirect("jobs.aspx");
            return;
        }

        // Basic validation
        if (string.IsNullOrWhiteSpace(txtName.Text) || string.IsNullOrWhiteSpace(txtEmail.Text))
        {
            lblApplyMessage.Text = "Please provide your name and email.";
            lblApplyMessage.ForeColor = System.Drawing.Color.Blue;
            return;
        }

        string resumePath = null;
        if (fileResume.HasFile)
        {
            var ext = Path.GetExtension(fileResume.FileName).ToLower();
                if (ext != ".pdf" && ext != ".doc" && ext != ".docx")
                {
                    lblApplyMessage.Text = "Resume must be PDF or Word document.";
                    lblApplyMessage.ForeColor = System.Drawing.Color.Blue;
                    return;
                }

            string saveDir = Server.MapPath("~/uploads/resumes");
            if (!Directory.Exists(saveDir)) Directory.CreateDirectory(saveDir);
            string filename = Guid.NewGuid().ToString() + ext;
            resumePath = Path.Combine(saveDir, filename);
            fileResume.SaveAs(resumePath);
        }

        // Insert application record
        var setting = ConfigurationManager.ConnectionStrings["DbConnect"];
        string conn = (setting != null && !string.IsNullOrEmpty(setting.ConnectionString))
            ? setting.ConnectionString
            : @"Data Source=.\SQLEXPRESS;Initial Catalog=KUET_Career_Club_DB;Integrated Security=True;";

        using (SqlConnection c = new SqlConnection(conn))
        {
            string q = "INSERT INTO JobApplications (JobID, ApplicantName, ApplicantEmail, CoverLetter, ResumePath, CreatedAt) VALUES (@jid, @name, @email, @cover, @resume, GETDATE())";
            using (SqlCommand cmd = new SqlCommand(q, c))
            {
                cmd.Parameters.AddWithValue("@jid", jobId);
                cmd.Parameters.AddWithValue("@name", txtName.Text.Trim());
                cmd.Parameters.AddWithValue("@email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@cover", txtCover.Text.Trim());
                cmd.Parameters.AddWithValue("@resume", resumePath ?? (object)DBNull.Value);
                c.Open();
                cmd.ExecuteNonQuery();
            }
        }

        // Try to send application email to the company. If SMTP isn't configured or send fails, queue the email in App_Data.
        string companyEmail = ViewState["CompanyEmail"] as string;
        if (!string.IsNullOrEmpty(companyEmail))
        {
            try
            {
                var mail = new MailMessage();
                string fromAddress = ConfigurationManager.AppSettings["NoReplyEmail"] ?? "no-reply@kuetcareerclub.edu";
                mail.From = new MailAddress(fromAddress, "KUET Career Club");
                mail.To.Add(companyEmail);
                mail.Subject = "New application for job #" + jobId + " from " + txtName.Text.Trim();

                var sb = new StringBuilder();
                sb.AppendLine("Applicant Name: " + txtName.Text.Trim());
                sb.AppendLine("Applicant Email: " + txtEmail.Text.Trim());
                sb.AppendLine();
                sb.AppendLine("Cover Letter:");
                sb.AppendLine(txtCover.Text.Trim());
                sb.AppendLine();
                sb.AppendLine("-- This message was generated by KUET Career Club application portal --");

                mail.Body = sb.ToString();
                mail.IsBodyHtml = false;

                if (!string.IsNullOrEmpty(resumePath) && File.Exists(resumePath))
                {
                    mail.Attachments.Add(new Attachment(resumePath));
                }

                // Ensure pickup directory exists when SMTP is configured to use SpecifiedPickupDirectory
                try
                {
                    var smtpSection = (System.Net.Configuration.SmtpSection)ConfigurationManager.GetSection("system.net/mailSettings/smtp");
                    if (smtpSection != null && smtpSection.DeliveryMethod == System.Net.Mail.SmtpDeliveryMethod.SpecifiedPickupDirectory)
                    {
                        var pickup = smtpSection.SpecifiedPickupDirectory.PickupDirectoryLocation;
                        if (!string.IsNullOrEmpty(pickup))
                        {
                            try
                            {
                                // prefer resolving to the web application's App_Data directory when available
                                if (pickup.IndexOf("|DataDirectory|", StringComparison.OrdinalIgnoreCase) >= 0)
                                {
                                    try { pickup = pickup.Replace("|DataDirectory|", Server.MapPath("~/App_Data")); } catch { }
                                }
                                // if still not rooted, treat as relative to the app root
                                if (!Path.IsPathRooted(pickup))
                                {
                                    try { pickup = Server.MapPath(pickup); } catch { }
                                }
                            }
                            catch { }

                            if (!string.IsNullOrEmpty(pickup) && !Directory.Exists(pickup))
                            {
                                Directory.CreateDirectory(pickup);
                            }
                        }
                    }
                }
                catch { /* ignore config read/create errors and let send attempt continue */ }

                // Create SmtpClient and, if pickup directory is configured, set a normalized path programmatically
                try
                {
                    var smtp = new SmtpClient();
                    try
                    {
                        // For development, force an application-local pickup folder to avoid config token issues
                        var appData = Server.MapPath("~/App_Data");
                        var pickup = Path.Combine(appData ?? string.Empty, "mailpickup");
                        try { pickup = Path.GetFullPath(pickup); } catch { }
                        if (!string.IsNullOrEmpty(pickup) && !Directory.Exists(pickup)) Directory.CreateDirectory(pickup);
                        smtp.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.SpecifiedPickupDirectory;
                        smtp.PickupDirectoryLocation = pickup;
                    }
                    catch { }

                    smtp.Send(mail);
                    smtp.Dispose();
                }
                catch
                {
                    throw;
                }
            }
                catch (Exception ex)
            {
                // Queue email to DB for later processing, and record diagnostics about SMTP pickup path
                try
                {
                    string pickupInfo = null;
                    try
                    {
                        var smtpSection = (System.Net.Configuration.SmtpSection)ConfigurationManager.GetSection("system.net/mailSettings/smtp");
                        if (smtpSection != null && smtpSection.DeliveryMethod == System.Net.Mail.SmtpDeliveryMethod.SpecifiedPickupDirectory)
                        {
                            var pickup = smtpSection.SpecifiedPickupDirectory.PickupDirectoryLocation ?? string.Empty;
                            if (!string.IsNullOrEmpty(pickup) && pickup.IndexOf("|DataDirectory|", StringComparison.OrdinalIgnoreCase) >= 0)
                            {
                                try { pickup = pickup.Replace("|DataDirectory|", Server.MapPath("~/App_Data")); } catch { }
                            }
                            // if relative, resolve to app root
                            try { if (!Path.IsPathRooted(pickup)) pickup = Server.MapPath(pickup); } catch { }
                            pickupInfo = pickup;
                        }
                    }
                    catch { }

                    // Insert queued email into DB for later retry
                    string queuedConn = null;
                    var cs1 = ConfigurationManager.ConnectionStrings["DbConnect"];
                    if (cs1 != null) queuedConn = cs1.ConnectionString;
                    if (string.IsNullOrEmpty(queuedConn))
                    {
                        var cs2 = ConfigurationManager.ConnectionStrings["MyDbConnection"];
                        if (cs2 != null) queuedConn = cs2.ConnectionString;
                    }
                    if (!string.IsNullOrEmpty(queuedConn))
                    {
                        using (var c = new System.Data.SqlClient.SqlConnection(queuedConn))
                        using (var cmd = c.CreateCommand())
                        {
                            cmd.CommandText = "INSERT INTO QueuedEmails (JobID, CompanyEmail, ApplicantName, ApplicantEmail, Subject, CoverLetter, ResumePath, ErrorMessage, CreatedAt, RetryCount) VALUES (@jobid, @compemail, @aname, @aemail, @sub, @cover, @resume, @err, GETDATE(), 0)";
                            cmd.Parameters.AddWithValue("@jobid", jobId);
                            cmd.Parameters.AddWithValue("@compemail", companyEmail);
                            cmd.Parameters.AddWithValue("@aname", txtName.Text.Trim());
                            cmd.Parameters.AddWithValue("@aemail", txtEmail.Text.Trim());
                            string subject = "New application for job #" + jobId + " from " + txtName.Text.Trim();
                            cmd.Parameters.AddWithValue("@sub", subject);
                            cmd.Parameters.AddWithValue("@cover", string.IsNullOrEmpty(txtCover.Text) ? (object)DBNull.Value : txtCover.Text.Trim());
                            cmd.Parameters.AddWithValue("@resume", string.IsNullOrEmpty(resumePath) ? (object)DBNull.Value : resumePath);
                            string errText = ex.ToString();
                            if (!string.IsNullOrEmpty(pickupInfo)) errText = "ResolvedPickup: " + pickupInfo + "\r\n" + errText;
                            cmd.Parameters.AddWithValue("@err", errText);
                            c.Open();
                            cmd.ExecuteNonQuery();
                        }
                    }

                    // also write a short diagnostic entry to admin_errors.log
                    try
                    {
                        string logp = Server.MapPath("~/App_Data/admin_errors.log");
                        File.AppendAllText(logp, DateTime.UtcNow.ToString("o") + " Queued email error: " + (pickupInfo ?? "") + " - " + ex.Message + "\n");
                    }
                    catch { }
                }
                catch
                {
                    // suppress secondary errors
                }
            }
        }

        // Optionally send notification email or show success
        pnlForm.Visible = false;
        pnlSuccess.Visible = true;
    }
}
