using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

public partial class admin_manage_companies : System.Web.UI.Page
{
    private string GetConnectionString()
    {
        var setting = ConfigurationManager.ConnectionStrings["MyDbConnection"];
        return (setting != null) ? setting.ConnectionString : @"Data Source=AURIN\SQLEXPRESS;Initial Catalog=KUET_Career_Club_DB;Integrated Security=True;";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        // অ্যাডমিন সিকিউরিটি ভেরিফিকেশন চেক
        if (Session["IsAdmin"] == null || !(bool)Session["IsAdmin"])
        {
            Response.Redirect("~/home.aspx");
        }

        if (!IsPostBack)
        {
            BindAdminGrid();
        }
    }

    private void BindAdminGrid()
    {
        using (SqlConnection conn = new SqlConnection(GetConnectionString()))
        {
            string query = "SELECT CompanyID, CompanyName, FocusArea FROM Companies ORDER BY CreatedAt DESC";
            using (SqlDataAdapter sda = new SqlDataAdapter(query, conn))
            {
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvCompanies.DataSource = dt;
                gvCompanies.DataBind();
            }
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(txtCompanyName.Text) || string.IsNullOrEmpty(txtShortDesc.Text) || string.IsNullOrEmpty(txtFocusArea.Text))
        {
            lblStatus.Text = "Please fill in Company Name, Short Description, and Focus Area.";
            lblStatus.ForeColor = System.Drawing.Color.Red;
            return;
        }

        using (SqlConnection conn = new SqlConnection(GetConnectionString()))
        {
            string query = "INSERT INTO Companies (CompanyName, ShortDescription, FocusArea, FullProfile, WebsiteUrl) VALUES (@Name, @ShortDesc, @Focus, @FullProfile, @Url)";
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@Name", txtCompanyName.Text.Trim());
                cmd.Parameters.AddWithValue("@ShortDesc", txtShortDesc.Text.Trim());
                cmd.Parameters.AddWithValue("@Focus", txtFocusArea.Text.Trim());
                cmd.Parameters.AddWithValue("@FullProfile", txtFullProfile.Text.Trim());
                cmd.Parameters.AddWithValue("@Url", txtWebsiteUrl.Text.Trim());

                conn.Open();
                cmd.ExecuteNonQuery();

                lblStatus.Text = "Company profile added successfully!";
                lblStatus.ForeColor = System.Drawing.Color.Green;

                txtCompanyName.Text = txtShortDesc.Text = txtFocusArea.Text = txtFullProfile.Text = txtWebsiteUrl.Text = "";
                BindAdminGrid();
            }
        }
    }

    protected void gvCompanies_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int companyId = Convert.ToInt32(gvCompanies.DataKeys[e.RowIndex].Value);

        using (SqlConnection conn = new SqlConnection(GetConnectionString()))
        {
            string query = "DELETE FROM Companies WHERE CompanyID = @Id";
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@Id", companyId);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }
        BindAdminGrid();
    }
}
