using System;
using System.IO;
using System.Web.Script.Serialization;

public partial class post_job : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) lblPostMsg.Text = "";
    }

    protected void BtnSubmitJob_Click(object sender, EventArgs e)
    {
        var job = new System.Collections.Generic.Dictionary<string, object>();
        job.Add("JobTitle", txtJobTitle.Text ?? string.Empty);
        job.Add("CompanyName", txtCompany.Text ?? string.Empty);
        job.Add("ContactEmail", txtCompanyEmail.Text ?? string.Empty);
        job.Add("CompanyWebsite", txtCompanyWebsite.Text ?? string.Empty);
        job.Add("Department", txtDept.Text ?? string.Empty);
        job.Add("JobType", ddlType.SelectedValue ?? string.Empty);
        job.Add("Description", txtDesc.Text ?? string.Empty);
        job.Add("SubmittedAt", DateTime.UtcNow.ToString("o"));

        // basic server-side validation
        if (string.IsNullOrWhiteSpace(txtJobTitle.Text) || string.IsNullOrWhiteSpace(txtCompany.Text) || string.IsNullOrWhiteSpace(txtCompanyEmail.Text))
        {
            lblPostMsg.Text = "Please provide job title, company name and a contact email.";
            return;
        }

        try
        {
            try { System.IO.File.AppendAllText(Server.MapPath("~/App_Data/admin_actions.log"), DateTime.UtcNow.ToString("o") + " post-job submit: " + txtJobTitle.Text + " | " + txtCompany.Text + " | " + txtCompanyEmail.Text + "\n"); } catch { }
            // Try to insert into PendingJobs DB table if available
            if (TryInsertPendingToDb(job))
            {
                try { System.IO.File.AppendAllText(Server.MapPath("~/App_Data/admin_actions.log"), DateTime.UtcNow.ToString("o") + " post-job: inserted into DB\n"); } catch { }
                lblPostMsg.Text = "Job submitted for review. Admin will publish it after approval.";
                return;
            }

            // Fallback to file-based pending storage
            string dir = Server.MapPath("~/App_Data/pending_jobs");
            if (!Directory.Exists(dir)) Directory.CreateDirectory(dir);
            string filename = Path.Combine(dir, Guid.NewGuid().ToString() + ".json");
            var js = new JavaScriptSerializer();
            File.WriteAllText(filename, js.Serialize(job));
            lblPostMsg.Text = "Job submitted for review. Admin will publish it after approval.";
        }
        catch (Exception ex)
        {
            try
            {
                string p = Server.MapPath("~/App_Data/admin_errors.log");
                System.IO.File.AppendAllText(p, DateTime.UtcNow.ToString("o") + " post-job submit error: " + ex.ToString() + "\n");
            }
            catch { }
            lblPostMsg.Text = "Failed to submit: " + Server.HtmlEncode(ex.Message);
        }
    }

    private bool TryInsertPendingToDb(object jobObj)
    {
        try
        {
            var dict = jobObj as System.Collections.Generic.IDictionary<string, object>;
            string conn = null;
            var cs = System.Configuration.ConfigurationManager.ConnectionStrings["DbConnect"];
            if (cs != null) conn = cs.ConnectionString;
            if (string.IsNullOrEmpty(conn)) return false;
            using (var c = new System.Data.SqlClient.SqlConnection(conn))
            {
                c.Open();
                // ensure PendingJobs table exists (create if missing)
                using (var chk = new System.Data.SqlClient.SqlCommand("IF OBJECT_ID('dbo.PendingJobs','U') IS NULL BEGIN CREATE TABLE dbo.PendingJobs (PendingID INT IDENTITY(1,1) PRIMARY KEY, JobTitle NVARCHAR(500) NULL, CompanyName NVARCHAR(250) NULL, ContactEmail NVARCHAR(250) NULL, CompanyWebsite NVARCHAR(500) NULL, Department NVARCHAR(200) NULL, JobType NVARCHAR(100) NULL, Description NVARCHAR(MAX) NULL, SubmittedAt DATETIME NULL) END", c))
                {
                    chk.ExecuteNonQuery();
                }

                string q = "INSERT INTO PendingJobs (JobTitle, CompanyName, ContactEmail, CompanyWebsite, Department, JobType, Description, SubmittedAt) VALUES (@t,@c,@ce,@cw,@d,@type,@desc,@s)";
                using (var cmd = new System.Data.SqlClient.SqlCommand(q, c))
                {
                    cmd.Parameters.AddWithValue("@t", dict.ContainsKey("JobTitle") ? dict["JobTitle"] : "");
                    cmd.Parameters.AddWithValue("@c", dict.ContainsKey("CompanyName") ? dict["CompanyName"] : "");
                    cmd.Parameters.AddWithValue("@ce", dict.ContainsKey("ContactEmail") ? dict["ContactEmail"] : "");
                    cmd.Parameters.AddWithValue("@cw", dict.ContainsKey("CompanyWebsite") ? dict["CompanyWebsite"] : "");
                    cmd.Parameters.AddWithValue("@d", dict.ContainsKey("Department") ? dict["Department"] : "");
                    cmd.Parameters.AddWithValue("@type", dict.ContainsKey("JobType") ? dict["JobType"] : "");
                    cmd.Parameters.AddWithValue("@desc", dict.ContainsKey("Description") ? dict["Description"] : "");
                    // SubmittedAt may be stored as string; try to pass as DateTime if possible
                    object sVal = dict.ContainsKey("SubmittedAt") ? dict["SubmittedAt"] : DateTime.UtcNow.ToString("o");
                    DateTime parsed;
                    if (sVal is DateTime) cmd.Parameters.AddWithValue("@s", (DateTime)sVal);
                    else if (DateTime.TryParse(Convert.ToString(sVal), out parsed)) cmd.Parameters.AddWithValue("@s", parsed);
                    else cmd.Parameters.AddWithValue("@s", DateTime.UtcNow);
                    cmd.ExecuteNonQuery();
                    return true;
                }
            }
        }
        catch { return false; }
    }
}
