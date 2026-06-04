using System;
using System.Collections.Generic;
using System.IO;
using System.Data.SqlClient;
using System.Configuration;

public partial class admin_dashboard : System.Web.UI.Page
{
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
                    litJobsCount.Text = cmd.ExecuteScalar().ToString();
                }
                using (var cmd = conn.CreateCommand())
                {
                    cmd.CommandText = "SELECT COUNT(*) FROM JobApplications";
                    // fallback when table not exist
                    try { litQueuedCount.Text = (cmd.ExecuteScalar() ?? "0").ToString(); } catch { litQueuedCount.Text = "0"; }
                }
            }
        }
        catch { litJobsCount.Text = "0"; litQueuedCount.Text = "0"; }

        // pending jobs count from App_Data/pending_jobs
        try
        {
            string dir = Server.MapPath("~/App_Data/pending_jobs");
            int pending = Directory.Exists(dir) ? Directory.GetFiles(dir).Length : 0;
            litPendingCount.Text = pending.ToString();
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

        // queued emails recent
        try
        {
            string dir = Server.MapPath("~/App_Data/queued_emails");
            var files = new List<object>();
            if (Directory.Exists(dir))
            {
                foreach (var f in Directory.GetFiles(dir)) files.Add(new { Name = Path.GetFileName(f), Info = File.GetCreationTime(f).ToString() });
            }
            rptRecentQueued.DataSource = files;
            rptRecentQueued.DataBind();
            litQueuedCount.Text = files.Count.ToString();
        }
        catch { litQueuedCount.Text = "0"; }
    }
}
