using System;
using System.Collections.Generic;
using System.IO;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.HtmlControls;

public partial class admin_dashboard : System.Web.UI.Page
{
    // helper used from markup to safely read dataitem fields (handles Dictionary / anonymous / DataRowView)
    public string GetField(object item, string key)
    {
        try
        {
            if (item == null) return string.Empty;
            // DataRowView
            var drv = item as System.Data.DataRowView;
            if (drv != null) { return drv.Row.Table.Columns.Contains(key) ? Convert.ToString(drv.Row[key]) : string.Empty; }
            // IDictionary<string,object>
            var dict = item as System.Collections.IDictionary;
            if (dict != null)
            {
                if (dict.Contains(key)) return Convert.ToString(dict[key]);
                // try case-insensitive
                foreach (var k in dict.Keys) { if (Convert.ToString(k).Equals(key, StringComparison.OrdinalIgnoreCase)) return Convert.ToString(dict[k]); }
                return string.Empty;
            }
            // anonymous objects via reflection
            var pi = item.GetType().GetProperty(key);
            if (pi != null) return Convert.ToString(pi.GetValue(item));
            return Convert.ToString(item);
        }
        catch { return string.Empty; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["IsAdmin"] == null || !(Session["IsAdmin"] is bool) || !(bool)Session["IsAdmin"]) 
        {
            string returnUrl = Server.UrlEncode(Request.RawUrl ?? "~/admin/dashboard.aspx");
            Response.Redirect("~/admin/admin-login.aspx?returnUrl=" + returnUrl);
            return;
        }

        if (!IsPostBack) LoadDashboard();
    }

    private string GetConnectionString()
    {
        var setting = ConfigurationManager.ConnectionStrings["DbConnect"];
        if (setting != null && !string.IsNullOrEmpty(setting.ConnectionString))
            return setting.ConnectionString;
        return @"Data Source=.\SQLEXPRESS;Initial Catalog=KUET_Career_Club_DB;Integrated Security=True;";
    }

    private void LoadDashboard()
    {
        // counts
        try
        {
            using (var conn = new SqlConnection(GetConnectionString()))
            {
                conn.Open();
                using (var cmd = conn.CreateCommand())
                {
                    cmd.CommandText = "SELECT COUNT(*) FROM Jobs";
                    try { litJobsCount.Text = (cmd.ExecuteScalar() ?? 0).ToString(); } catch { litJobsCount.Text = "0"; }
                }
            }
        }
        catch { litJobsCount.Text = "0"; }

        // pending jobs: prefer DB-backed PendingJobs when available, fall back to App_Data files
        try
        {
            var items = new List<object>();
            int pendingCount = 0;
            var setting = ConfigurationManager.ConnectionStrings["DbConnect"];
            if (setting != null && !string.IsNullOrEmpty(setting.ConnectionString))
            {
                try
                {
                    using (var conn = new SqlConnection(setting.ConnectionString))
                    {
                        conn.Open();
                        using (var c = new SqlCommand("SELECT COUNT(*) FROM PendingJobs", conn))
                        {
                            try { pendingCount = Convert.ToInt32(c.ExecuteScalar() ?? 0); } catch { pendingCount = 0; }
                        }

                        using (var recent = new SqlCommand("SELECT TOP 5 PendingID, JobTitle, CompanyName FROM PendingJobs ORDER BY SubmittedAt DESC", conn))
                        using (var rdr = recent.ExecuteReader())
                        {
                            while (rdr.Read())
                            {
                                items.Add(new { JobTitle = rdr["JobTitle"] == DBNull.Value ? "" : rdr["JobTitle"].ToString(), CompanyName = rdr["CompanyName"] == DBNull.Value ? "" : rdr["CompanyName"].ToString(), Path = "pending-jobs.aspx" });
                            }
                        }
                    }
                }
                catch { /* ignore db pending failure and fall back to file-based below */ }
            }

            // fallback / file-based pending jobs
            try
            {
                string dir = Server.MapPath("~/App_Data/pending_jobs");
                if (Directory.Exists(dir))
                {
                    foreach (var f in Directory.GetFiles(dir))
                    {
                        try
                        {
                            string json = File.ReadAllText(f);
                            dynamic parsed = new System.Web.Script.Serialization.JavaScriptSerializer().DeserializeObject(json);
                            var dict = parsed as System.Collections.Generic.Dictionary<string, object>;
                            var title = dict != null && dict.ContainsKey("JobTitle") && dict["JobTitle"] != null ? dict["JobTitle"].ToString() : Path.GetFileName(f);
                            items.Add(new { JobTitle = title, CompanyName = dict != null && dict.ContainsKey("CompanyName") ? dict["CompanyName"] : "", Path = f });
                        }
                        catch { }
                    }
                    // if pendingCount was zero from DB, reflect file count
                    if (pendingCount == 0) pendingCount = Directory.GetFiles(dir).Length;
                }
            }
            catch { }

            litPendingCount.Text = pendingCount.ToString();
            rptRecentPending.DataSource = items;
            rptRecentPending.DataBind();
        }
        catch { litPendingCount.Text = "0"; }

        // error log preview
        try
        {
            string p = Server.MapPath("~/App_Data/admin_errors.log");
            if (File.Exists(p))
            {
                var all = File.ReadAllText(p);
                if (all.Length > 8000) all = all.Substring(all.Length - 8000);
                litErrorLog.Text = Server.HtmlEncode(all);
                litErrorsCount.Text = File.ReadAllLines(p).Length.ToString();
            }
            else { litErrorLog.Text = "No recent errors."; litErrorsCount.Text = "0"; }
        }
        catch { litErrorLog.Text = "Unable to read errors."; litErrorsCount.Text = "0"; }

        // list recent pending submissions
        try
        {
            string dir = Server.MapPath("~/App_Data/pending_jobs");
            var items = new List<object>();
            if (Directory.Exists(dir))
            {
                foreach (var f in Directory.GetFiles(dir))
                {
                    try
                    {
                        string json = File.ReadAllText(f);
                        dynamic parsed = new System.Web.Script.Serialization.JavaScriptSerializer().DeserializeObject(json);
                        var dict = parsed as System.Collections.Generic.Dictionary<string, object>;
                        items.Add(new { JobTitle = dict.ContainsKey("JobTitle") ? dict["JobTitle"] : Path.GetFileName(f), CompanyName = dict.ContainsKey("CompanyName") ? dict["CompanyName"] : "", Path = f });
                    }
                    catch { }
                }
            }
            rptRecentPending.DataSource = items;
            rptRecentPending.DataBind();
        }
        catch { }

        // queued emails recent (file-based queue)
        try
        {
            string dir = Server.MapPath("~/App_Data/queued_emails");
            var files = new List<object>();
            int qcount = 0;
            if (Directory.Exists(dir))
            {
                foreach (var f in Directory.GetFiles(dir)) files.Add(new { Name = Path.GetFileName(f), Info = File.GetCreationTime(f).ToString(), Path = f });
                qcount = files.Count;
            }
            rptRecentQueued.DataSource = files;
            rptRecentQueued.DataBind();
            litQueuedCount.Text = qcount.ToString();
        }
        catch { litQueuedCount.Text = "0"; }
    }
}
