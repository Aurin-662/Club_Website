using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

public partial class admin_manage_blogs : System.Web.UI.Page
{
    private string GetConnectionString()
    {
        var setting = ConfigurationManager.ConnectionStrings["MyDbConnection"];
        return (setting != null) ? setting.ConnectionString : @"Data Source=AURIN\SQLEXPRESS;Initial Catalog=KUET_Career_Club_DB;Integrated Security=True;";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        // ল্যাব সিকিউরিটি গাইডলাইন: চেক করা ইউজার অ্যাডমিন কিনা (সেশন সিকিউরিটি কন্ট্রোল)
        if (Session["IsAdmin"] == null || !(bool)Session["IsAdmin"])
        {
            // যদি অ্যাডমিন না হয় তবে অ্যাক্সেস ডিনাইড বা হোম পেজে পাঠিয়ে দিবে
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
            string query = "SELECT Id, Title, Category FROM Articles ORDER BY PublishedAt DESC";
            using (SqlDataAdapter sda = new SqlDataAdapter(query, conn))
            {
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvArticles.DataSource = dt;
                gvArticles.DataBind();
            }
        }
    }

    // ফরম থেকে নতুন ব্লগ তৈরি ইভেন্ট
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(txtTitle.Text) || string.IsNullOrEmpty(txtSlug.Text) || string.IsNullOrEmpty(txtBody.Text))
        {
            lblStatus.Text = "All required fields must be filled out!";
            lblStatus.ForeColor = System.Drawing.Color.Red;
            return;
        }

        using (SqlConnection conn = new SqlConnection(GetConnectionString()))
        {
            string query = "INSERT INTO Articles (Slug, Title, Summary, Body, Category, IsPublished) VALUES (@Slug, @Title, @Summary, @Body, @Category, 1)";
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@Slug", txtSlug.Text.Trim().ToLower().Replace(" ", "-")); // অটো সেফ স্ল্যাগ কনভার্টার
                cmd.Parameters.AddWithValue("@Title", txtTitle.Text.Trim());
                cmd.Parameters.AddWithValue("@Summary", txtSummary.Text.Trim());
                cmd.Parameters.AddWithValue("@Body", txtBody.Text.Trim());
                cmd.Parameters.AddWithValue("@Category", ddlCategory.SelectedValue);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    lblStatus.Text = "Article published successfully successfully!";
                    lblStatus.ForeColor = System.Drawing.Color.Green;

                    // ফরম ক্লিন করা
                    txtTitle.Text = txtSlug.Text = txtSummary.Text = txtBody.Text = "";
                    BindAdminGrid(); // গ্রিড ডাটা রিফ্রেশ
                }
                catch (Exception ex)
                {
                    lblStatus.Text = "Error: Slug already exists! Try a unique slug URL.";
                    lblStatus.ForeColor = System.Drawing.Color.Red;
                }
            }
        }
    }

    // ব্লগ ডিলিট করার ইভেন্ট হ্যান্ডলার
    protected void gvArticles_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int articleId = Convert.ToInt32(gvArticles.DataKeys[e.RowIndex].Value);

        using (SqlConnection conn = new SqlConnection(GetConnectionString()))
        {
            string query = "DELETE FROM Articles WHERE Id = @Id";
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@Id", articleId);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }
        BindAdminGrid(); // গ্রিড রিফ্রেশ
    }
}
