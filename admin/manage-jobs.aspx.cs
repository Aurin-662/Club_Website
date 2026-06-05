using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;

public partial class admin_manage_jobs : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["IsAdmin"] == null || !(Session["IsAdmin"] is bool) || !(bool)Session["IsAdmin"]) 
        {
            Response.Redirect("~/admin/admin-login.aspx?returnUrl=" + Server.UrlEncode(Request.RawUrl ?? "~/admin/manage-jobs.aspx"));
            return;
        }

        if (!IsPostBack) LoadJobs();
    }

    // Initialize DB button removed; Jobs table should exist via migrations.

    private string GetConnectionString()
    {
        var setting = ConfigurationManager.ConnectionStrings["DbConnect"];
        if (setting != null && !string.IsNullOrEmpty(setting.ConnectionString))
            return setting.ConnectionString;
        return @"Data Source=.\SQLEXPRESS;Initial Catalog=KUET_Career_Club_DB;Integrated Security=True;";
    }

    private void LoadJobs()
    {
        try
        {
            using (var conn = new SqlConnection(GetConnectionString()))
            using (var cmd = new SqlCommand("SELECT JobID, JobTitle, CompanyName, Department, JobType, Description FROM Jobs ORDER BY JobID DESC", conn))
            {
                conn.Open();
                using (var da = new SqlDataAdapter(cmd))
                {
                    var dt = new DataTable();
                    da.Fill(dt);
                    rptManage.DataSource = dt;
                    rptManage.DataBind();
                }
            }
        }
        catch (Exception ex)
        {
            litManageStatus.Text = "<div class=\"alert alert-danger\">Failed to load jobs: " + Server.HtmlEncode(ex.Message) + "</div>";
        }
    }

    protected void rptManage_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "view")
        {
            int id;
            if (int.TryParse(Convert.ToString(e.CommandArgument), out id))
            {
                Response.Redirect("/jobdetails.aspx?id=" + id);
            }
        }
        else if (e.CommandName == "delete")
        {
            int id;
            if (int.TryParse(Convert.ToString(e.CommandArgument), out id))
            {
                try
                {
                    using (var conn = new SqlConnection(GetConnectionString()))
                    using (var cmd = new SqlCommand("DELETE FROM Jobs WHERE JobID = @id", conn))
                    {
                        cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;
                        conn.Open();
                        int affected = cmd.ExecuteNonQuery();
                        if (affected > 0) litManageStatus.Text = "<div class=\"alert alert-success\">Job removed.</div>";
                        else litManageStatus.Text = "<div class=\"alert alert-warning\">Job not found.</div>";
                    }
                }
                catch (Exception ex)
                {
                    litManageStatus.Text = "<div class=\"alert alert-danger\">Failed to delete: " + Server.HtmlEncode(ex.Message) + "</div>";
                }
                LoadJobs();
            }
        }
    }
}
