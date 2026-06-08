using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.Web.UI;

public partial class students : Page
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
            BindStudentGrid();
        }
    }

    private void BindStudentGrid()
    {
        using (SqlConnection conn = new SqlConnection(GetConnectionString()))
        {
            // ডায়নামিক কন্ডিশনাল এসকিউএল জেনারেশন
            string query = "SELECT RollID, FullName, Department, StudyLevel, Skills, Bio, Experience, Projects, Email, Phone, ResumePath FROM Students WHERE 1=1";

            if (ddlDepartment.SelectedValue != "all")
                query += " AND Department = @Dept";

            if (ddlYear.SelectedValue != "all")
                query += " AND StudyLevel = @Year";

            if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
                query += " AND (FullName LIKE @Search OR RollID LIKE @Search OR Skills LIKE @Search)";

            // সর্টিং কন্ট্রোল সেফ ইনজেকশন প্রোটেকশন
            string sortBy = "FullName";
            if (ddlSort.SelectedValue == "Department" || ddlSort.SelectedValue == "StudyLevel")
                sortBy = ddlSort.SelectedValue;

            query += " ORDER BY " + sortBy + " ASC";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                if (ddlDepartment.SelectedValue != "all") cmd.Parameters.AddWithValue("@Dept", ddlDepartment.SelectedValue);
                if (ddlYear.SelectedValue != "all") cmd.Parameters.AddWithValue("@Year", ddlYear.SelectedValue);
                if (!string.IsNullOrEmpty(txtSearch.Text.Trim())) cmd.Parameters.AddWithValue("@Search", "%" + txtSearch.Text.Trim() + "%");

                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    rptStudents.DataSource = dt;
                    rptStudents.DataBind();

                    litCount.Text = dt.Rows.Count.ToString();
                }
            }
        }
    }

    // ফ্রন্টএন্ডে স্কিল স্ট্রিং ভেঙে ব্যাজ তৈরি করার সার্ভার হেল্পার মেথড
    protected string RenderSkills(string skillsRaw)
    {
        if (string.IsNullOrEmpty(skillsRaw)) return "";
        string[] skills = skillsRaw.Split(new char[] { ' ', ',' }, StringSplitOptions.RemoveEmptyEntries);
        StringBuilder sb = new StringBuilder();
        foreach (var skill in skills)
        {
            sb.AppendFormat("<span>{0}</span>", Server.HtmlEncode(skill));
        }
        return sb.ToString();
    }

    protected void Filter_Changed(object sender, EventArgs e)
    {
        BindStudentGrid();
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        txtSearch.Text = "";
        ddlDepartment.SelectedValue = "all";
        ddlYear.SelectedValue = "all";
        ddlSort.SelectedValue = "FullName";
        BindStudentGrid();
    }
}