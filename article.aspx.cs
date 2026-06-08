using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

public partial class article : Page
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
            // URL থেকে 'id' প্যারামিটার চেক করা (যেমন: article.aspx?id=se-interview)
            if (Request.QueryString["id"] != null && !string.IsNullOrEmpty(Request.QueryString["id"]))
            {
                string articleSlug = Request.QueryString["id"].ToString().Trim();
                LoadFullArticle(articleSlug);
            }
            else
            {
                // যদি URL-এ কোনো id না থাকে
                ShowError("Invalid Article Request. Please select a valid article from the blog list.");
            }
        }
    }

    private void LoadFullArticle(string slug)
    {
        using (SqlConnection conn = new SqlConnection(GetConnectionString()))
        {
            // শুধুমাত্র পাবলিশড (IsPublished = 1) আর্টিকেলই রিড করবে
            string query = "SELECT Title, Body, Category, PublishedAt FROM Articles WHERE Slug = @Slug AND IsPublished = 1";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@Slug", slug);

                try
                {
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // ডেটাবেস থেকে কন্টেন্ট তুলে literals-এ বাইন্ড করা
                            litTitle.Text = reader["Title"].ToString();
                            litCategory.Text = reader["Category"].ToString();
                            litBody.Text = reader["Body"].ToString(); // এটি ডাটাবেসের HTML ট্যাগ রান করবে (<p>, <h2> ইত্যাদি)

                            DateTime pubDate = Convert.ToDateTime(reader["PublishedAt"]);
                            litDate.Text = pubDate.ToString("MMMM dd, yyyy");

                            // প্যানেল ভিজিবিলিটি ঠিক করা
                            pnlArticle.Visible = true;
                            pnlError.Visible = false;

                            // ব্রাউজারের টাইটেল ডাইনামিকালি চেঞ্জ করা
                            Page.Title = litTitle.Text + " | KUET Career Club";
                        }
                        else
                        {
                            // যদি এই স্ল্যাগের কোনো ডেটা না পাওয়া যায়
                            ShowError("The article you are trying to read does not exist or has been archived.");
                        }
                    }
                }
                catch (Exception ex)
                {
                    ShowError("A database connection error occurred while loading the article. Details: " + ex.Message);
                }
            }
        }
    }

    private void ShowError(string message)
    {
        pnlArticle.Visible = false;
        pnlError.Visible = true;
        lblErrorMsg.Text = message;
    }
}
