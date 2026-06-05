using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class jobdetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // allow anonymous users to view job details; require signin only when applying
            int id;
            if (int.TryParse(Request.QueryString["id"], out id))
            {
                LoadJob(id);
            }
            else
            {
                pnlNotFound.Visible = true;
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
            string q = "SELECT JobTitle, CompanyName, Department, JobType, Description FROM Jobs WHERE JobID = @id";
            using (SqlCommand cmd = new SqlCommand(q, c))
            {
                cmd.Parameters.AddWithValue("@id", id);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    if (dt.Rows.Count == 0)
                    {
                        pnlNotFound.Visible = true;
                        return;
                    }

                    var row = dt.Rows[0];
                    lblJobTitle.InnerText = row["JobTitle"].ToString();
                    lblCompany.Text = row["CompanyName"].ToString();
                    lblDept.Text = row["Department"].ToString();
                    lblType.Text = row["JobType"].ToString();
                    lblDescription.InnerText = row["Description"].ToString();

                    // If user is not signed in, point Apply button to login with returnUrl back to this job details
                    if (Session["UserName"] == null)
                    {
                        var returnUrl = Server.UrlEncode("/jobdetails.aspx?id=" + id + "#apply");
                        applyLink.HRef = ResolveUrl("~/login.aspx?returnUrl=" + returnUrl);
                    }
                    else
                    {
                        applyLink.HRef = "apply.aspx?job=" + id;
                    }

                    pnlDetails.Visible = true;
                }
            }
        }
    }
}