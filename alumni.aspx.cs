using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.Web.UI;

public partial class alumni : Page
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
            BindAlumniGrid();
        }
    }

    private void BindAlumniGrid()
    {
        using (SqlConnection conn = new SqlConnection(GetConnectionString()))
        {
            string query = "SELECT FullName, DesignationBio, Skills, FullStory FROM Alumni ORDER BY CreatedAt DESC";
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    rptAlumni.DataSource = dt;
                    rptAlumni.DataBind();
                }
            }
        }
    }

    // কমা/স্পেস আলাদা করে স্কিল ব্যাজ জেনারেশনের মেথড
    protected string RenderSkills(string skillsRaw)
    {
        if (string.IsNullOrEmpty(skillsRaw)) return "";
        string[] skills = skillsRaw.Split(new char[] { ',', ' ' }, StringSplitOptions.RemoveEmptyEntries);
        StringBuilder sb = new StringBuilder();
        foreach (var skill in skills)
        {
            sb.AppendFormat("<span>{0}</span>", Server.HtmlEncode(skill));
        }
        return sb.ToString();
    }
}