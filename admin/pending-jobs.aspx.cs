using System;
using System.Collections.Generic;

using System.IO;
using System.Web.UI;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Script.Serialization;

public partial class admin_pending_jobs : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["IsAdmin"] == null || !(Session["IsAdmin"] is bool) || !(bool)Session["IsAdmin"]) 
        {
            Response.Redirect("~/admin/admin-login.aspx?returnUrl=" + Server.UrlEncode(Request.RawUrl ?? "~/admin/pending-jobs.aspx"));
            return;
        }

        if (!IsPostBack) LoadPending();
    }

    // Initialize DB button removed; table creation handled when inserting pending jobs or via migrations.

    private string GetConnectionString()
    {
        var setting = ConfigurationManager.ConnectionStrings["DbConnect"];
        if (setting != null && !string.IsNullOrEmpty(setting.ConnectionString))
            return setting.ConnectionString;
        return @"Data Source=.\SQLEXPRESS;Initial Catalog=KUET_Career_Club_DB;Integrated Security=True;";
    }

    private void LoadPending()
    {
        var items = new List<object>();
        // try DB-backed PendingJobs first
        try
        {
            var setting = ConfigurationManager.ConnectionStrings["DbConnect"];
            if (setting != null && !string.IsNullOrEmpty(setting.ConnectionString))
            {
                using (var conn = new SqlConnection(setting.ConnectionString))
                {
                    conn.Open();
                    using (var cmd = new SqlCommand("SELECT PendingID, JobTitle, CompanyName, Department, JobType, Description, ContactEmail, CompanyWebsite FROM PendingJobs ORDER BY SubmittedAt DESC", conn))
                    using (var rdr = cmd.ExecuteReader())
                    {
                        while (rdr.Read())
                        {
                            items.Add(new {
                                JobTitle = rdr["JobTitle"] == DBNull.Value ? "" : rdr["JobTitle"].ToString(),
                                CompanyName = rdr["CompanyName"] == DBNull.Value ? "" : rdr["CompanyName"].ToString(),
                                Department = rdr["Department"] == DBNull.Value ? "" : rdr["Department"].ToString(),
                                JobType = rdr["JobType"] == DBNull.Value ? "" : rdr["JobType"].ToString(),
                                Description = rdr["Description"] == DBNull.Value ? "" : rdr["Description"].ToString(),
                                ContactEmail = rdr["ContactEmail"] == DBNull.Value ? "" : rdr["ContactEmail"].ToString(),
                                CompanyWebsite = rdr["CompanyWebsite"] == DBNull.Value ? "" : rdr["CompanyWebsite"].ToString(),
                                Path = "db:" + rdr["PendingID"].ToString()
                            });
                        }
                    }
                }
                rptPending.DataSource = items;
                rptPending.DataBind();
                return;
            }
        }
        catch (Exception ex) { LogAdminError("LoadPending DB read: " + ex.ToString()); }

        // fallback to file-based pending jobs
        string dir = Server.MapPath("~/App_Data/pending_jobs");
        if (Directory.Exists(dir))
        {
            foreach (var f in Directory.GetFiles(dir))
            {
                try
                {
                    var json = File.ReadAllText(f);
                    var js = new JavaScriptSerializer();
                    var obj = js.DeserializeObject(json) as Dictionary<string, object>;
                    string title = obj != null && obj.ContainsKey("JobTitle") && obj["JobTitle"] != null ? obj["JobTitle"].ToString() : Path.GetFileName(f);
                    items.Add(new {
                        JobTitle = title,
                        CompanyName = obj != null && obj.ContainsKey("CompanyName") && obj["CompanyName"] != null ? obj["CompanyName"].ToString() : "",
                        Department = obj != null && obj.ContainsKey("Department") && obj["Department"] != null ? obj["Department"].ToString() : "",
                        JobType = obj != null && obj.ContainsKey("JobType") && obj["JobType"] != null ? obj["JobType"].ToString() : "",
                        Description = obj != null && obj.ContainsKey("Description") && obj["Description"] != null ? obj["Description"].ToString() : "",
                        ContactEmail = obj != null && obj.ContainsKey("ContactEmail") && obj["ContactEmail"] != null ? obj["ContactEmail"].ToString() : "",
                        CompanyWebsite = obj != null && obj.ContainsKey("CompanyWebsite") && obj["CompanyWebsite"] != null ? obj["CompanyWebsite"].ToString() : "",
                        Path = f
                    });
                }
                catch (Exception ex) { LogAdminError("LoadPending file read: " + ex.ToString()); }
            }
        }
        rptPending.DataSource = items;
        rptPending.DataBind();
    }

    protected void rptPending_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
    {
        string path = e.CommandArgument as string;
        if (e.CommandName == "view")
        {
            if (path != null && path.StartsWith("db:"))
            {
                string id = path.Substring(3);
                try
                {
                    var setting = ConfigurationManager.ConnectionStrings["DbConnect"];
                    if (setting != null && !string.IsNullOrEmpty(setting.ConnectionString))
                    {
                        using (var conn = new SqlConnection(setting.ConnectionString))
                        using (var cmd = new SqlCommand("SELECT JobTitle, CompanyName, Department, JobType, Description, ContactEmail, CompanyWebsite FROM PendingJobs WHERE PendingID = @id", conn))
                        {
                            cmd.Parameters.AddWithValue("@id", id);
                            conn.Open();
                            using (var rdr = cmd.ExecuteReader())
                            {
                                if (rdr.Read())
                                {
                                    var sb = new System.Text.StringBuilder();
                                    sb.AppendLine("<strong>" + Server.HtmlEncode(Convert.ToString(rdr["JobTitle"])) + "</strong><br />");
                                    sb.AppendLine(Server.HtmlEncode(Convert.ToString(rdr["CompanyName"])) + "<br />");
                                    sb.AppendLine(Server.HtmlEncode(Convert.ToString(rdr["Department"])) + " • " + Server.HtmlEncode(Convert.ToString(rdr["JobType"])) + "<br /><br />");
                                    sb.AppendLine(Server.HtmlEncode(Convert.ToString(rdr["Description"])).Replace("\n", "<br />"));
                                    litPendingStatus.Text = "<div class=\"alert alert-info\">" + sb.ToString() + "</div>";
                                }
                            }
                        }
                    }
                }
                catch (Exception ex) { litPendingStatus.Text = "<div class=\"alert alert-danger\">Error reading DB record.</div>"; LogAdminError("View pending db: " + ex.ToString()); }
            }
            else if (File.Exists(path))
            {
                litPendingStatus.Text = "<div class=\"alert alert-info\">" + Server.HtmlEncode(File.ReadAllText(path)).Replace("\n", "<br />") + "</div>";
            }
        }
        else if (e.CommandName == "approve")
        {
            if (path != null && path.StartsWith("db:"))
            {
                string id = path.Substring(3);
                try
                {
                    // move from PendingJobs to Jobs and delete pending row
                    using (var conn = new SqlConnection(GetConnectionString()))
                    {
                        conn.Open();
                        using (var sel = new SqlCommand("SELECT JobTitle, CompanyName, Department, JobType, Description, ContactEmail, CompanyWebsite FROM PendingJobs WHERE PendingID = @id", conn))
                        {
                            sel.Parameters.AddWithValue("@id", id);
                            using (var rdr = sel.ExecuteReader())
                            {
                                if (!rdr.Read()) throw new Exception("Pending record not found");
                                string t = Convert.ToString(rdr["JobTitle"]);
                                string c = Convert.ToString(rdr["CompanyName"]);
                                string d = Convert.ToString(rdr["Department"]);
                                string type = Convert.ToString(rdr["JobType"]);
                                string desc = Convert.ToString(rdr["Description"]);
                                string contact = Convert.ToString(rdr["ContactEmail"]);
                                string website = Convert.ToString(rdr["CompanyWebsite"]);
                                rdr.Close();
                                using (var ins = new SqlCommand("INSERT INTO Jobs (JobTitle, CompanyName, Department, JobType, Description, CompanyEmail, CompanyWebsite) VALUES (@t,@c,@d,@type,@desc,@ce,@cw)", conn))
                                {
                                    ins.Parameters.AddWithValue("@t", t);
                                    ins.Parameters.AddWithValue("@c", c);
                                    ins.Parameters.AddWithValue("@d", d);
                                    ins.Parameters.AddWithValue("@type", type);
                                    ins.Parameters.AddWithValue("@desc", desc);
                                    ins.Parameters.AddWithValue("@ce", string.IsNullOrEmpty(contact) ? (object)DBNull.Value : contact);
                                    ins.Parameters.AddWithValue("@cw", string.IsNullOrEmpty(website) ? (object)DBNull.Value : website);
                                    ins.ExecuteNonQuery();
                                }
                                using (var del = new SqlCommand("DELETE FROM PendingJobs WHERE PendingID = @id", conn)) { del.Parameters.AddWithValue("@id", id); del.ExecuteNonQuery(); }
                            }
                        }
                    }
                    litPendingStatus.Text = "<div class=\"alert alert-success\">Job approved and published from DB.</div>";
                    LoadPending();
                }
                catch (Exception ex) { litPendingStatus.Text = "<div class=\"alert alert-danger\">Failed to approve: " + Server.HtmlEncode(ex.Message) + "</div>"; LogAdminError("Approve DB failed: " + ex.ToString()); }
            }
            else if (File.Exists(path))
            {
                try
                {
                    var json = File.ReadAllText(path);
                    var js = new JavaScriptSerializer();
                    var obj = js.DeserializeObject(json) as Dictionary<string, object>;
                    // Insert into Jobs table (simple columns)
                    using (var conn = new SqlConnection(GetConnectionString()))
                    {
                        conn.Open();
                        using (var cmd = conn.CreateCommand())
                        {
                            cmd.CommandText = "INSERT INTO Jobs (JobTitle, CompanyName, Department, JobType, Description) VALUES (@t,@c,@d,@type,@desc)";
                            cmd.Parameters.AddWithValue("@t", obj.ContainsKey("JobTitle") ? obj["JobTitle"] : "");
                            cmd.Parameters.AddWithValue("@c", obj.ContainsKey("CompanyName") ? obj["CompanyName"] : "");
                            cmd.Parameters.AddWithValue("@d", obj.ContainsKey("Department") ? obj["Department"] : "");
                            cmd.Parameters.AddWithValue("@type", obj.ContainsKey("JobType") ? obj["JobType"] : "");
                            cmd.Parameters.AddWithValue("@desc", obj.ContainsKey("Description") ? obj["Description"] : "");
                            cmd.ExecuteNonQuery();
                        }
                    }
                    File.Delete(path);
                    litPendingStatus.Text = "<div class=\"alert alert-success\">Job approved and published.</div>";
                    LoadPending();
                }
                catch (Exception ex)
                {
                    litPendingStatus.Text = "<div class=\"alert alert-danger\">Failed to approve: " + Server.HtmlEncode(ex.Message) + "</div>";
                    LogAdminError("Approve failed: " + ex.ToString());
                }
            }
        }
        else if (e.CommandName == "decline")
        {
            if (path != null && path.StartsWith("db:"))
            {
                string id = path.Substring(3);
                try
                {
                    using (var conn = new SqlConnection(GetConnectionString()))
                    {
                        conn.Open();
                        // move to RejectedJobs if exists, otherwise delete
                        bool moved = false;
                        try
                        {
                            using (var ins = new SqlCommand("IF OBJECT_ID('dbo.RejectedJobs','U') IS NOT NULL BEGIN INSERT INTO RejectedJobs (JobTitle, CompanyName, Department, JobType, Description, ContactEmail, CompanyWebsite, RejectedAt) SELECT JobTitle, CompanyName, Department, JobType, Description, ContactEmail, CompanyWebsite, GETDATE() FROM PendingJobs WHERE PendingID = @id; END", conn))
                            { ins.Parameters.AddWithValue("@id", id); ins.ExecuteNonQuery(); moved = true; }
                        }
                        catch { }
                        using (var del = new SqlCommand("DELETE FROM PendingJobs WHERE PendingID = @id", conn)) { del.Parameters.AddWithValue("@id", id); del.ExecuteNonQuery(); }
                    }
                    litPendingStatus.Text = "<div class=\"alert alert-warning\">Job declined and removed from pending (DB).</div>";
                    LoadPending();
                }
                catch (Exception ex)
                {
                    litPendingStatus.Text = "<div class=\"alert alert-danger\">Failed to decline: " + Server.HtmlEncode(ex.Message) + "</div>";
                    LogAdminError("Decline DB failed: " + ex.ToString());
                }
            }
            else if (File.Exists(path))
            {
                try
                {
                    string rejDir = Server.MapPath("~/App_Data/rejected_jobs");
                    if (!Directory.Exists(rejDir)) Directory.CreateDirectory(rejDir);
                    string dest = Path.Combine(rejDir, Path.GetFileName(path));
                    File.Move(path, dest);
                    litPendingStatus.Text = "<div class=\"alert alert-warning\">Job declined and moved to rejected.</div>";
                    LoadPending();
                }
                catch (Exception ex)
                {
                    litPendingStatus.Text = "<div class=\"alert alert-danger\">Failed to decline: " + Server.HtmlEncode(ex.Message) + "</div>";
                    LogAdminError("Decline failed: " + ex.ToString());
                }
            }
        }
    }

    private void LogAdminError(string msg)
    {
        try
        {
            string p = Server.MapPath("~/App_Data/admin_errors.log");
            File.AppendAllText(p, DateTime.UtcNow.ToString("o") + " " + msg + "\n");
        }
        catch { }
    }
}
