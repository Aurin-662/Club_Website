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
        var job = new {
            JobTitle = txtJobTitle.Text ?? string.Empty,
            CompanyName = txtCompany.Text ?? string.Empty,
            ContactEmail = txtCompanyEmail.Text ?? string.Empty,
            CompanyWebsite = txtCompanyWebsite.Text ?? string.Empty,
            Department = txtDept.Text ?? string.Empty,
            JobType = ddlType.SelectedValue ?? string.Empty,
            Description = txtDesc.Text ?? string.Empty,
            SubmittedAt = DateTime.UtcNow.ToString("o")
        };

        // basic server-side validation
        if (string.IsNullOrWhiteSpace(txtJobTitle.Text) || string.IsNullOrWhiteSpace(txtCompany.Text) || string.IsNullOrWhiteSpace(txtCompanyEmail.Text))
        {
            lblPostMsg.Text = "Please provide job title, company name and a contact email.";
            return;
        }

        try
        {
            // Try to insert into PendingJobs DB table if available
            if (TryInsertPendingToDb(job))
            {
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
            lblPostMsg.Text = "Failed to submit: " + ex.Message;
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
                // check table exists
                using (var chk = new System.Data.SqlClient.SqlCommand("SELECT OBJECT_ID('dbo.PendingJobs','U')", c))
                {
                    var obj = chk.ExecuteScalar();
                    if (obj == null || obj == DBNull.Value) return false;
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
                    cmd.Parameters.AddWithValue("@s", dict.ContainsKey("SubmittedAt") ? dict["SubmittedAt"] : DateTime.UtcNow.ToString("o"));
                    cmd.ExecuteNonQuery();
                    return true;
                }
            }
        }
        catch { return false; }
    }
}
