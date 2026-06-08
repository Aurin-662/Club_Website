using System;
using System.IO;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Script.Serialization;

public partial class collaborate : System.Web.UI.Page
{
    private string GetConnectionString()
    {
        var setting = ConfigurationManager.ConnectionStrings["DbConnect"] ?? ConfigurationManager.ConnectionStrings["MyDbConnection"];
        if (setting != null && !string.IsNullOrEmpty(setting.ConnectionString)) return setting.ConnectionString;
        return @"Data Source=.\SQLEXPRESS;Initial Catalog=KUET_Career_Club_DB;Integrated Security=True;";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        // no special page load logic for public form
    }

    protected void btnSendInquiry_Click(object sender, EventArgs e)
    {
        var org = (Request.Form["txtOrgName"] ?? string.Empty).ToString().Trim();
        var email = (Request.Form["txtOrgEmail"] ?? string.Empty).ToString().Trim();
        var type = (Request.Form["ddlCollabInterest"] ?? string.Empty).ToString().Trim();
        var msg = (Request.Form["txtCollabMessage"] ?? string.Empty).ToString().Trim();

        lblStatus.Visible = true;

        if (string.IsNullOrEmpty(org) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(type))
        {
            lblStatus.Text = "Please provide organization name, contact email and collaboration type.";
            lblStatus.CssClass = "d-block mb-3 p-3 rounded-3 small fw-bold text-danger";
            return;
        }

        // Try insert into DB
        try
        {
            using (var conn = new SqlConnection(GetConnectionString()))
            using (var cmd = conn.CreateCommand())
            {
                cmd.CommandText = "INSERT INTO Collaborations (OrganizationName, ContactEmail, CollaborationType, MessageText, SubmittedAt, Status) VALUES (@org,@em,@type,@msg,GETDATE(),@status)";
                cmd.Parameters.AddWithValue("@org", org);
                cmd.Parameters.AddWithValue("@em", email);
                cmd.Parameters.AddWithValue("@type", type);
                cmd.Parameters.AddWithValue("@msg", msg);
                cmd.Parameters.AddWithValue("@status", "New");
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            lblStatus.Text = "Thank you — your inquiry has been submitted. We'll contact you soon.";
            lblStatus.CssClass = "d-block mb-3 p-3 rounded-3 small fw-bold text-success";
            // clear fields
            txtOrgName.Text = txtOrgEmail.Text = txtCollabMessage.Text = string.Empty;
            ddlCollabInterest.SelectedIndex = 0;
            return;
        }
        catch (Exception ex)
        {
            // fallback to file storage
            try
            {
                var payload = new
                {
                    OrganizationName = org,
                    ContactEmail = email,
                    CollaborationType = type,
                    MessageText = msg,
                    SubmittedAt = DateTime.UtcNow.ToString("o"),
                    Status = "New"
                };
                string dir = Server.MapPath("~/App_Data/collaborations");
                if (!Directory.Exists(dir)) Directory.CreateDirectory(dir);
                string file = Path.Combine(dir, Guid.NewGuid().ToString() + ".json");
                var js = new JavaScriptSerializer();
                File.WriteAllText(file, js.Serialize(payload));
                lblStatus.Text = "Thank you — your inquiry has been saved. We'll contact you soon.";
                lblStatus.CssClass = "d-block mb-3 p-3 rounded-3 small fw-bold text-success";
                txtOrgName.Text = txtOrgEmail.Text = txtCollabMessage.Text = string.Empty;
                ddlCollabInterest.SelectedIndex = 0;
                return;
            }
            catch
            {
                lblStatus.Text = "Unable to submit your inquiry at this time. Please try again later.";
                lblStatus.CssClass = "d-block mb-3 p-3 rounded-3 small fw-bold text-danger";
                return;
            }
        }
    }
}
