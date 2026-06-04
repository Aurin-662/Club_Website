using System;
using System.Configuration;
using System.Data.SqlClient;

public partial class admin_create : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["IsAdmin"] == null || !(Session["IsAdmin"] is bool) || !(bool)Session["IsAdmin"]) {
            Response.Redirect("admin-login.aspx");
            return;
        }
        if (!IsPostBack) litStatus.Text = "";
    }

    protected void BtnCreate_Click(object sender, EventArgs e)
    {
        string user = txtUserName.Text.Trim();
        string email = txtEmail.Text.Trim();
        string p1 = txtPassword.Text.Trim();
        string p2 = txtPassword2.Text.Trim();

        if (string.IsNullOrEmpty(user) || string.IsNullOrEmpty(p1) || p1 != p2)
        {
            litStatus.Text = "<div class=\"alert alert-danger\">Invalid input or passwords do not match.</div>";
            return;
        }

        string hash, salt;
        PasswordHelper.CreateHash(p1, out hash, out salt);

        string conn = null;
        var s1 = ConfigurationManager.ConnectionStrings["MyDbConnection"];
        if (s1 != null && !string.IsNullOrEmpty(s1.ConnectionString)) conn = s1.ConnectionString;
        if (string.IsNullOrEmpty(conn))
        {
            var s2 = ConfigurationManager.ConnectionStrings["DbConnect"];
            if (s2 != null) conn = s2.ConnectionString;
        }
        try
        {
            using (var con = new SqlConnection(conn))
            using (var cmd = new SqlCommand("INSERT INTO Admins (UserName, PasswordHash, PasswordSalt, Email) VALUES (@u,@h,@s,@e)", con))
            {
                cmd.Parameters.AddWithValue("@u", user);
                cmd.Parameters.AddWithValue("@h", hash);
                cmd.Parameters.AddWithValue("@s", salt);
                cmd.Parameters.AddWithValue("@e", string.IsNullOrEmpty(email) ? (object)DBNull.Value : email);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            litStatus.Text = "<div class=\"alert alert-success\">Admin created successfully.</div>";
        }
        catch (SqlException ex)
        {
            if (ex.Message.Contains("UNIQUE") || ex.Message.Contains("unique"))
                litStatus.Text = "<div class=\"alert alert-warning\">Username already exists.</div>";
            else
                litStatus.Text = "<div class=\"alert alert-danger\">Error: " + Server.HtmlEncode(ex.Message) + "</div>";
        }
    }
}
