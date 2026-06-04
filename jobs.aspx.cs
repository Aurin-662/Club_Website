using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class jobs : Page
{
    // Web.config থেকে কানেকশন স্ট্রিং রিড করার হেল্পার
    private string GetConnectionString()
    {
        var setting = ConfigurationManager.ConnectionStrings["DbConnect"];
        if (setting != null && !string.IsNullOrEmpty(setting.ConnectionString))
            return setting.ConnectionString;
        return @"Data Source=.\SQLEXPRESS;Initial Catalog=KUET_Career_Club_DB;Integrated Security=True;";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        // Jobs listing is public. Only actions that require authentication will redirect at the action page.
        if (!IsPostBack)
        {
            // প্রথমবার পেজ লোড হলে সমস্ত ডেটা লোড হবে
            BindJobGrid();
        }
    }

    // ডেটাবেস থেকে ডেটা তুলে এনে গ্রিডে বাইন্ড করার মেথড
    private void BindJobGrid(string searchKeyword = "", string dept = "all", string type = "all")
    {
        // বেস কুয়েরি তৈরি
        string query = "SELECT JobID, JobTitle, CompanyName, Department, JobType, Description FROM Jobs WHERE 1=1";

        // কন্ডিশনাল কুয়েরি ফিল্টারিং
        if (!string.IsNullOrEmpty(searchKeyword))
        {
            query += " AND (JobTitle LIKE @Search OR CompanyName LIKE @Search OR Description LIKE @Search)";
        }
        if (dept != "all")
        {
            query += " AND Department = @Dept";
        }
        if (type != "all")
        {
            query += " AND JobType = @Type";
        }

        // ক্রমানুসারে নতুন সার্কুলার সবার আগে দেখানোর জন্য ORDER BY
        query += " ORDER BY JobID DESC";

        using (SqlConnection conn = new SqlConnection(GetConnectionString()))
        {
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                // প্যারামিটারাইজড কুয়েরি (SQL Injection থেকে বাঁচার জন্য আবশ্যক)
                if (!string.IsNullOrEmpty(searchKeyword))
                {
                    cmd.Parameters.AddWithValue("@Search", "%" + searchKeyword.Trim() + "%");
                }
                if (dept != "all")
                {
                    cmd.Parameters.AddWithValue("@Dept", dept);
                }
                if (type != "all")
                {
                    cmd.Parameters.AddWithValue("@Type", type);
                }

                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    rptJobs.DataSource = dt;
                    rptJobs.DataBind();
                }
            }
        }
    }

    // সার্চ বা ড্রপডাউন চেঞ্জ হলে এই মেথডটি রান হবে (Server-Side Filter)
    protected void FilterJobsServer(object sender, EventArgs e)
    {
        BindJobGrid(jobSearch.Text, jobCategory.SelectedValue, jobType.SelectedValue);
    }

    // ফিল্টার রিসেট বাটন ক্লিকের লজিক
    protected void btnClearFilters_Click(object sender, EventArgs e)
    {
        jobSearch.Text = "";
        jobCategory.SelectedValue = "all";
        jobType.SelectedValue = "all";

        // পুনরায় সব ডেটা লোড করা
        BindJobGrid();
    }

    // জব টাইপ অনুযায়ী ডায়নামিক বুটস্ট্র্যাপ কালার ব্যাজ রিটার্ন করার জন্য হেল্পার মেথড
    protected string GetBadgeClass(string jobType)
    {
        switch (jobType.ToLower().Trim())
        {
            case "full-time":
                return "badge bg-success"; // Green
            case "internship":
                return "badge bg-info text-dark"; // Light Blue
            case "part-time":
                return "badge bg-warning text-dark"; // Yellow
            default:
                return "badge bg-secondary"; // Gray
        }
    }
}