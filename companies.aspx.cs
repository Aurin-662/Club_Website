using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

public partial class companies : Page
{
    private string GetConnectionString()
    {
        var setting = ConfigurationManager.ConnectionStrings["MyDbConnection"];
        return (setting != null) ? setting.ConnectionString : @"Data Source=AURIN\SQLEXPRESS;Initial Catalog=KUET_Career_Club_DB;Integrated Security=True;";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindCompaniesGrid();
        }
    }

    private void BindCompaniesGrid()
    {
        using (SqlConnection conn = new SqlConnection(GetConnectionString()))
        {
            string query = "SELECT CompanyName, ShortDescription, FocusArea, FullProfile, WebsiteUrl FROM Companies ORDER BY CreatedAt DESC";
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    rptCompanies.DataSource = dt;
                    rptCompanies.DataBind();
                }
            }
        }
    }
}