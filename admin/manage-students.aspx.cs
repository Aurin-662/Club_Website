using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

public partial class admin_manage_students : System.Web.UI.Page
{
    private string GetConnectionString()
    {
        var setting = ConfigurationManager.ConnectionStrings["MyDbConnection"];
        return (setting != null) ? setting.ConnectionString : @"Data Source=AURIN\SQLEXPRESS;Initial Catalog=KUET_Career_Club_DB;Integrated Security=True;";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        // সেশন সিকিউরিটি ভেরিফিকেশন (অ্যাডমিন প্রোটেকশন চেক)
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
            string query = "SELECT Id, RollID, FullName, Department FROM Students ORDER BY CreatedAt DESC";
            using (SqlDataAdapter sda = new SqlDataAdapter(query, conn))
            {
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvStudents.DataSource = dt;
                gvStudents.DataBind();
            }
        }
    }

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(txtRollID.Text) || string.IsNullOrEmpty(txtFullName.Text) || string.IsNullOrEmpty(txtEmail.Text))
        {
            lblStatus.Text = "Please fill in all identity required fields.";
            lblStatus.ForeColor = System.Drawing.Color.Red;
            return;
        }

        using (SqlConnection conn = new SqlConnection(GetConnectionString()))
        {
            string query = @"INSERT INTO Students (RollID, FullName, Department, StudyLevel, Skills, Bio, Email, Phone) 
                             VALUES (@RollID, @FullName, @Dept, @Level, @Skills, @Bio, @Email, @Phone)";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@RollID", txtRollID.Text.Trim().ToUpper());
                cmd.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
                cmd.Parameters.AddWithValue("@Dept", ddlDept.SelectedValue);
                cmd.Parameters.AddWithValue("@Level", ddlLevel.SelectedValue);
                cmd.Parameters.AddWithValue("@Skills", txtSkills.Text.Trim());
                cmd.Parameters.AddWithValue("@Bio", txtBio.Text.Trim());
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@Phone", txtPhone.Text.Trim());

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    lblStatus.Text = "Student profile created successfully!";
                    lblStatus.ForeColor = System.Drawing.Color.Green;

                    // ফর্ম ক্লিয়ারেন্স
                    txtRollID.Text = txtFullName.Text = txtSkills.Text = txtBio.Text = txtEmail.Text = txtPhone.Text = "";
                    BindAdminGrid();
                }
                catch (Exception)
                {
                    lblStatus.Text = "Error: Roll ID must be unique. This student record already exists.";
                    lblStatus.ForeColor = System.Drawing.Color.Red;
                }
            }
        }
    }

    protected void gvStudents_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int studentID = Convert.ToInt32(gvStudents.DataKeys[e.RowIndex].Value);

        using (SqlConnection conn = new SqlConnection(GetConnectionString()))
        {
            string query = "DELETE FROM Students WHERE Id = @Id";
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@Id", studentID);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }
        BindAdminGrid();
    }
}
