using System;
using System.Collections.Generic;
using System.IO;
using System.Net.Mail;
using System.Text;

public partial class admin_queued_emails : System.Web.UI.Page
{
    // maximum number of automatic/manual retry attempts before marking as failed
    private const int MAX_RETRIES = 5;
    protected void Page_Load(object sender, EventArgs e)
    {
        // Admin protection: redirect to admin login when the admin session flag is missing
        if (Session["IsAdmin"] == null || !(Session["IsAdmin"] is bool) || !(bool)Session["IsAdmin"]) 
        {
            // send user to admin login and include returnUrl so they come back after signing in
            string returnUrl = Server.UrlEncode(Request.RawUrl ?? "~/admin/queued-emails.aspx");
            Response.Redirect("~/admin/admin-login.aspx?returnUrl=" + returnUrl);
            return;
        }

        }

    protected void BtnCancelEdit_Click(object sender, EventArgs e)
    {
        ViewState["EditingQueueID"] = null;
        pnlEdit.Visible = false;
    }

    protected void BtnResendEdit_Click(object sender, EventArgs e)
    {
        var qidObj = ViewState["EditingQueueID"];
        if (qidObj == null) return;
        string qid = qidObj.ToString();
        string newEmail = txtEditEmail.Text.Trim();
        if (string.IsNullOrEmpty(newEmail))
        {
            litStatus.Text = "<div class=\"alert alert-danger\">Please provide a recipient email.</div>";
            return;
        }

        try
        {
            // update CompanyEmail in DB for this queued row
            string queuedConn = null;
            var csq = System.Configuration.ConfigurationManager.ConnectionStrings["DbConnect"];
            if (csq != null) queuedConn = csq.ConnectionString;
            if (string.IsNullOrEmpty(queuedConn))
            {
                var csq2 = System.Configuration.ConfigurationManager.ConnectionStrings["MyDbConnection"];
                if (csq2 != null) queuedConn = csq2.ConnectionString;
            }
            if (!string.IsNullOrEmpty(queuedConn))
            {
                using (var c = new System.Data.SqlClient.SqlConnection(queuedConn))
                using (var upd = new System.Data.SqlClient.SqlCommand("UPDATE QueuedEmails SET CompanyEmail=@e WHERE QueueID=@id", c))
                {
                    upd.Parameters.AddWithValue("@e", newEmail);
                    upd.Parameters.AddWithValue("@id", qid);
                    c.Open();
                    upd.ExecuteNonQuery();
                }
            }

            // hide edit panel and perform retry by invoking the ItemCommand path
            pnlEdit.Visible = false;
            ViewState["EditingQueueID"] = null;
            // simulate a retry command
            rptQueued_ItemCommand(null, new System.Web.UI.WebControls.RepeaterCommandEventArgs(null, null, new System.Web.UI.WebControls.CommandEventArgs("retry", "db:" + qid)));
        }
        catch (Exception ex)
        {
            litStatus.Text = "<div class=\"alert alert-danger\">Failed to update and resend: " + Server.HtmlEncode(ex.Message) + "</div>";
            LogQueuedEmailError("Edit resend failed: " + ex.ToString());
        }
        }

    protected void BtnAdminSignOut_Click(object sender, EventArgs e)
    {
        Session["IsAdmin"] = null;
        Response.Redirect("~/admin/admin-login.aspx");
    }

    protected void BtnRefresh_Click(object sender, EventArgs e)
    {
        LoadList();
    }

    private void LoadList()
    {
        var items = new List<object>();
        try
        {
            string conn = null;
            var cs = System.Configuration.ConfigurationManager.ConnectionStrings["DbConnect"];
            if (cs != null) conn = cs.ConnectionString;
            if (!string.IsNullOrEmpty(conn))
            {
                using (var c = new System.Data.SqlClient.SqlConnection(conn))
                using (var cmd = new System.Data.SqlClient.SqlCommand("SELECT q.QueueID, q.CompanyEmail, q.Subject, q.CreatedAt, q.RetryCount, q.ErrorMessage, j.JobTitle FROM QueuedEmails q LEFT JOIN Jobs j ON q.JobID = j.JobID ORDER BY q.CreatedAt DESC", c))
                {
                    c.Open();
                    using (var rdr = cmd.ExecuteReader())
                    {
                        while (rdr.Read())
                        {
                            string company = Convert.ToString(rdr["CompanyEmail"]);
                            string jobTitle = rdr["JobTitle"] == DBNull.Value ? "(no job)" : Convert.ToString(rdr["JobTitle"]);
                            string created = Convert.ToDateTime(rdr["CreatedAt"]).ToString();
                            int attempts = rdr["RetryCount"] == DBNull.Value ? 0 : Convert.ToInt32(rdr["RetryCount"]);
                            items.Add(new { Name = "db:" + rdr["QueueID"].ToString(), Path = "db:" + rdr["QueueID"].ToString(), Info = company + " • " + jobTitle + " • " + created + " • Attempts: " + attempts.ToString() });
                        }
                    }
                }
            }
        }
        catch (Exception ex) { LogQueuedEmailError("LoadList DB error: " + ex.ToString()); }
        rptQueued.DataSource = items;
        rptQueued.DataBind();
    }

    protected void rptQueued_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
    {
        string path = e.CommandArgument as string;
        if (path == null || !path.StartsWith("db:")) return;
        string id = path.Substring(3);

        if (e.CommandName == "view")
        {
            try
            {
                string conn = null;
                var cs2 = System.Configuration.ConfigurationManager.ConnectionStrings["DbConnect"];
                if (cs2 != null) conn = cs2.ConnectionString;
                if (!string.IsNullOrEmpty(conn))
                {
                    using (var c = new System.Data.SqlClient.SqlConnection(conn))
                    using (var cmd = new System.Data.SqlClient.SqlCommand("SELECT q.CompanyEmail, q.Subject, q.CoverLetter, q.ResumePath, q.ApplicantName, q.ApplicantEmail, q.ErrorMessage, q.CreatedAt, q.JobID, j.JobTitle, q.RetryCount FROM QueuedEmails q LEFT JOIN Jobs j ON q.JobID = j.JobID WHERE q.QueueID = @id", c))
                    {
                        cmd.Parameters.AddWithValue("@id", id);
                        c.Open();
                        using (var rdr = cmd.ExecuteReader())
                        {
                            if (rdr.Read())
                            {
                                var sb = new StringBuilder();
                                sb.AppendLine("To (company): " + Server.HtmlEncode(Convert.ToString(rdr["CompanyEmail"])) + "\n");
                                sb.AppendLine("Job: " + Server.HtmlEncode(Convert.ToString(rdr["JobTitle"])) + "\n");
                                sb.AppendLine("Subject: " + Server.HtmlEncode(Convert.ToString(rdr["Subject"])) + "\n\n");
                                sb.AppendLine("Applicant: " + Server.HtmlEncode(Convert.ToString(rdr["ApplicantName"])) + " <" + Server.HtmlEncode(Convert.ToString(rdr["ApplicantEmail"])) + ">\n\n");
                                sb.AppendLine(Server.HtmlEncode(Convert.ToString(rdr["CoverLetter"])));
                                if (rdr["ResumePath"] != DBNull.Value)
                                {
                                    string rp = Convert.ToString(rdr["ResumePath"]);
                                    string link = GetVirtualUrlFromPath(rp);
                                    if (!string.IsNullOrEmpty(link)) sb.AppendLine("\nResume: " + link);
                                    else sb.AppendLine("\nResume path: " + Server.HtmlEncode(rp));
                                }
                                if (rdr["ErrorMessage"] != DBNull.Value)
                                {
                                    var err = Convert.ToString(rdr["ErrorMessage"]);
                                    sb.AppendLine("\nError: " + Server.HtmlEncode(err));
                                    if (err.IndexOf("Pickup", StringComparison.OrdinalIgnoreCase) >= 0 || err.IndexOf("mailroot", StringComparison.OrdinalIgnoreCase) >= 0)
                                    {
                                        sb.AppendLine("\nRemediation: SMTP is configured to use an IIS pickup folder that doesn't exist or is not writable. Either configure a valid pickup directory in web.config or use real SMTP server settings. You can also set the pickup folder to ~/App_Data/mailpickup and ensure the folder exists and is writable by the app pool.");
                                    }
                                }
                                sb.AppendLine("\nCreated: " + Server.HtmlEncode(Convert.ToString(rdr["CreatedAt"])));
                                sb.AppendLine("\nAttempts: " + Server.HtmlEncode(Convert.ToString(rdr["RetryCount"])));
                                litContent.Text = "<pre class=\"small\">" + sb.ToString() + "</pre>";
                                try { txtEditEmail.Text = Convert.ToString(rdr["CompanyEmail"]); pnlEdit.Visible = true; ViewState["EditingQueueID"] = id; } catch { }
                            }
                        }
                    }
                }
            }
            catch (Exception ex) { litStatus.Text = "<div class=\"alert alert-danger\">Error reading queued email.</div>"; LogQueuedEmailError("View queued db: " + ex.ToString()); }
        }
        else if (e.CommandName == "retry")
        {
            try
            {
                string conn = null;
                var cs3 = System.Configuration.ConfigurationManager.ConnectionStrings["DbConnect"];
                if (cs3 != null) conn = cs3.ConnectionString;
                if (!string.IsNullOrEmpty(conn))
                {
                    using (var c = new System.Data.SqlClient.SqlConnection(conn))
                    using (var cmd = new System.Data.SqlClient.SqlCommand("SELECT JobID, CompanyEmail, ApplicantName, ApplicantEmail, Subject, CoverLetter, ResumePath, RetryCount FROM QueuedEmails WHERE QueueID = @id", c))
                    {
                        cmd.Parameters.AddWithValue("@id", id);
                        c.Open();
                        using (var rdr = cmd.ExecuteReader())
                        {
                            if (!rdr.Read()) throw new Exception("Queued email not found");
                            string to = Convert.ToString(rdr["CompanyEmail"]);
                            string subject = Convert.ToString(rdr["Subject"]);
                            string cover = rdr["CoverLetter"] == DBNull.Value ? null : Convert.ToString(rdr["CoverLetter"]);
                            string applicant = rdr["ApplicantName"] == DBNull.Value ? null : Convert.ToString(rdr["ApplicantName"]);
                            string applicantEmail = rdr["ApplicantEmail"] == DBNull.Value ? null : Convert.ToString(rdr["ApplicantEmail"]);
                            string resume = rdr["ResumePath"] == DBNull.Value ? null : Convert.ToString(rdr["ResumePath"]);
                            int attempts = rdr["RetryCount"] == DBNull.Value ? 0 : Convert.ToInt32(rdr["RetryCount"]);

                            if (attempts >= MAX_RETRIES)
                            {
                                throw new Exception("Maximum retry attempts reached for this queued email. Manual intervention required.");
                            }
                            var mail = new MailMessage();
                            mail.To.Add(to);
                            mail.Subject = subject ?? "Application";
                            var bodySb = new StringBuilder();
                            if (!string.IsNullOrEmpty(applicant)) bodySb.AppendLine("Applicant: " + applicant + " <" + applicantEmail + ">\n");
                            if (!string.IsNullOrEmpty(cover)) bodySb.AppendLine(cover + "\n");
                            mail.Body = bodySb.ToString();
                            mail.From = new MailAddress(System.Configuration.ConfigurationManager.AppSettings["NoReplyEmail"] ?? "no-reply@kuetcareerclub.edu");
                            if (!string.IsNullOrEmpty(resume) && File.Exists(resume)) mail.Attachments.Add(new Attachment(resume));
                                // Ensure pickup directory exists and set SmtpClient pickup location explicitly
                                try
                                {
                                    var smtp = new SmtpClient();
                                    try
                                    {
                                            // Force an application-local pickup folder for development
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
                    }

                    // if send succeeded, delete queued row
                    using (var c2 = new System.Data.SqlClient.SqlConnection(conn))
                    using (var del = new System.Data.SqlClient.SqlCommand("DELETE FROM QueuedEmails WHERE QueueID = @id", c2))
                    {
                        del.Parameters.AddWithValue("@id", id);
                        c2.Open();
                        del.ExecuteNonQuery();
                    }

                    litStatus.Text = "<div class=\"alert alert-success\">Email sent and removed from queue.</div>";
                    litContent.Text = string.Empty;
                    LoadList();
                }
            }
            catch (Exception ex)
            {
                litStatus.Text = "<div class=\"alert alert-danger\">Failed to send: " + Server.HtmlEncode(ex.Message) + "</div>";
                LogQueuedEmailError("Retry send failed: " + ex.ToString());
                try
                {
                    // increment RetryCount and save last error (re-resolve connection string in this scope)
                    string queuedConn = null;
                    var csq = System.Configuration.ConfigurationManager.ConnectionStrings["DbConnect"];
                    if (csq != null) queuedConn = csq.ConnectionString;
                    if (string.IsNullOrEmpty(queuedConn))
                    {
                        var csq2 = System.Configuration.ConfigurationManager.ConnectionStrings["MyDbConnection"];
                        if (csq2 != null) queuedConn = csq2.ConnectionString;
                    }
                    if (!string.IsNullOrEmpty(queuedConn))
                    {
                        using (var c3 = new System.Data.SqlClient.SqlConnection(queuedConn))
                        using (var upd = new System.Data.SqlClient.SqlCommand("UPDATE QueuedEmails SET RetryCount = ISNULL(RetryCount,0) + 1, ErrorMessage = @err WHERE QueueID = @id", c3))
                        {
                            upd.Parameters.AddWithValue("@err", ex.ToString());
                            upd.Parameters.AddWithValue("@id", id);
                            c3.Open();
                            upd.ExecuteNonQuery();
                        }
                    }
                }
                catch { }
            }
        }
        else if (e.CommandName == "delete")
        {
            try
            {
                string queuedConn = null;
                var csq = System.Configuration.ConfigurationManager.ConnectionStrings["DbConnect"];
                if (csq != null) queuedConn = csq.ConnectionString;
                if (string.IsNullOrEmpty(queuedConn))
                {
                    var csq2 = System.Configuration.ConfigurationManager.ConnectionStrings["MyDbConnection"];
                    if (csq2 != null) queuedConn = csq2.ConnectionString;
                }
                if (!string.IsNullOrEmpty(queuedConn))
                {
                    using (var cdel = new System.Data.SqlClient.SqlConnection(queuedConn))
                    using (var dcmd = new System.Data.SqlClient.SqlCommand("DELETE FROM QueuedEmails WHERE QueueID = @id", cdel))
                    {
                        dcmd.Parameters.AddWithValue("@id", id);
                        cdel.Open();
                        dcmd.ExecuteNonQuery();
                    }
                }
                LoadList();
                litContent.Text = string.Empty;
                litStatus.Text = "<div class=\"alert alert-success\">Queued email removed.</div>";
            }
            catch (Exception ex)
            {
                litStatus.Text = "<div class=\"alert alert-danger\">Failed to delete queued email.</div>";
                LogQueuedEmailError("Delete queued failed: " + ex.ToString());
            }
        }
    }

    private void LogQueuedEmailError(string msg)
    {
        try
        {
            string p = Server.MapPath("~/App_Data/admin_errors.log");
            File.AppendAllText(p, DateTime.UtcNow.ToString("o") + " " + msg + "\n");
        }
        catch { }
    }

    // If resume file path is under the web root uploads folder, return a virtual URL to download it.
    private string GetVirtualUrlFromPath(string path)
    {
        try
        {
            if (string.IsNullOrEmpty(path)) return null;
            string uploadsRoot = Server.MapPath("~/uploads");
                if (!string.IsNullOrEmpty(uploadsRoot) && path.StartsWith(uploadsRoot, StringComparison.OrdinalIgnoreCase))
            {
                string relative = path.Substring(uploadsRoot.Length).Replace('\\', '/').TrimStart('/');
                return Request.ApplicationPath.TrimEnd('/') + "/uploads/" + relative;
            }
        }
        catch { }
        return null;
    }
}
