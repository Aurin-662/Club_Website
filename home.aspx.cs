using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

public partial class home : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadJobs();
        }
    }

    private void LoadJobs()
    {
        string connString = ConfigurationManager.ConnectionStrings["MyDbConnection"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connString))
        {
            string query = "SELECT JobID, JobTitle, CompanyName, JobType, Description FROM Jobs ORDER BY CreatedAt DESC";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    rptJobs.DataSource = dt;
                    rptJobs.DataBind();
                    // show empty placeholder if no items
                    try
                    {
                        pnlNoJobs.Visible = (dt == null || dt.Rows.Count == 0);
                    }
                    catch
                    {
                        // if the panel not present for some reason, ignore
                    }
                }
            }
        }
    }
}
