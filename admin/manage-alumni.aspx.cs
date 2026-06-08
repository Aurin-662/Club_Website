using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

public partial class admin_manage_alumni : System.Web.UI.Page
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
            string query = "SELECT Id, FullName, Skills FROM Alumni ORDER BY CreatedAt DESC";
            using (SqlDataAdapter sda = new SqlDataAdapter(query, conn))
            {
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvAlumni.DataSource = dt;
                gvAlumni.DataBind();
            }
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(txtFullName.Text) || string.IsNullOrEmpty(txtBio.Text) || string.IsNullOrEmpty(txtSkills.Text))
        {
            lblStatus.Text = "Please fill in Name, Bio, and Skills fields.";
            lblStatus.ForeColor = System.Drawing.Color.Red;
            return;
        }

        using (SqlConnection conn = new SqlConnection(GetConnectionString()))
        {
            string query = "INSERT INTO Alumni (FullName, DesignationBio, Skills, FullStory) VALUES (@Name, @Bio, @Skills, @Story)";
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@Name", txtFullName.Text.Trim());
                cmd.Parameters.AddWithValue("@Bio", txtBio.Text.Trim());
                cmd.Parameters.AddWithValue("@Skills", txtSkills.Text.Trim());
                cmd.Parameters.AddWithValue("@Story", txtFullStory.Text.Trim());

                conn.Open();
                cmd.ExecuteNonQuery();

                lblStatus.Text = "Alumni success story published successfully!";
                lblStatus.ForeColor = System.Drawing.Color.Green;

                txtFullName.Text = txtBio.Text = txtSkills.Text = txtFullStory.Text = "";
                BindAdminGrid();
            }
        }
    }

    protected void gvAlumni_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int alumniId = Convert.ToInt32(gvAlumni.DataKeys[e.RowIndex].Value);

        using (SqlConnection conn = new SqlConnection(GetConnectionString()))
        {
            string query = "DELETE FROM Alumni WHERE Id = @Id";
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@Id", alumniId);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }
        BindAdminGrid();
    }
}
