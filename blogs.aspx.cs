using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

public partial class blogs : System.Web.UI.Page
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
            // ????? ???? ??????? ???? ??????? ????????? ?????? ????? ??? (?cat=Interview Prep)
            if (Request.QueryString["cat"] != null)
            {
                BindArticles(Request.QueryString["cat"].ToString(), "");
            }
            else
            {
                BindArticles("All", "");
            }
        }
    }

    // ??????? ???? ????????? ???? ???? ??? ??? ??????? ???????? ???
    private void BindArticles(string category, string searchKeyword)
    {
        using (SqlConnection conn = new SqlConnection(GetConnectionString()))
        {
            // ??? ?????? (????????? IsPublished = 1 ?????? ???????? ???????? ??????)
            string query = "SELECT Slug, Title, Summary, Category, PublishedAt FROM Articles WHERE IsPublished = 1";

            if (category != "All" && !string.IsNullOrEmpty(category))
            {
                query += " AND Category = @Category";
            }
            if (!string.IsNullOrEmpty(searchKeyword))
            {
                query += " AND (Title LIKE @Search OR Summary LIKE @Search)";
            }
            query += " ORDER BY PublishedAt DESC";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                if (category != "All" && !string.IsNullOrEmpty(category))
                    cmd.Parameters.AddWithValue("@Category", category);
                if (!string.IsNullOrEmpty(searchKeyword))
                    cmd.Parameters.AddWithValue("@Search", "%" + searchKeyword + "%");

                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    rptArticles.DataSource = dt;
                    rptArticles.DataBind();

                    // ??? ???? ???????? ????? ?? ????? ???
                    pnlNoArticles.Visible = (dt.Rows.Count == 0);
                }
            }
        }
    }

    // ????????? ???? ????????? ??????
    protected void FilterCategory_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        string selectedCategory = btn.CommandArgument;
        txtSearch.Text = ""; // ????????? ????? ???? ????? ??? ????? ???

        // ????????? ????????? ????? ????? ???? ????????? ??? (BCC ??????)
        ResetButtonStyles();
        btn.CssClass = "btn btn-dark blog-category-btn";

        BindArticles(selectedCategory, "");
    }

    // ???? ????? ?????? ???? ????? ??????
    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        BindArticles("All", txtSearch.Text.Trim());
    }

    private void ResetButtonStyles()
    {
        btnAll.CssClass = "btn btn-outline-secondary blog-category-btn";
        btnSE.CssClass = "btn btn-outline-secondary blog-category-btn";
        btnIP.CssClass = "btn btn-outline-secondary blog-category-btn";
        btnHE.CssClass = "btn btn-outline-secondary blog-category-btn";
    }
}