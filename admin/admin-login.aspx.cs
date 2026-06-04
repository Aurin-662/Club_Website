using System;
using System.Configuration;
using System.Web.UI;
using System.Data.SqlClient;
using System.Web.Security;

public partial class admin_login : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) litAdminMessage.Text = "";
    }

    protected void BtnAdminSignIn_Click(object sender, EventArgs e)
    {
        string user = txtAdminUser.Text != null ? txtAdminUser.Text.Trim() : string.Empty;
        string pass = txtAdminPass.Text != null ? txtAdminPass.Text.Trim() : string.Empty;

        string cfgUser = ConfigurationManager.AppSettings["AdminUser"] ?? "admin";
        string cfgPass = ConfigurationManager.AppSettings["AdminPass"] ?? "password";

        bool ok = false;

        // 1) Try DB-backed admin lookup (Admins table)
        try
        {
            string conn = null;
            var s1 = ConfigurationManager.ConnectionStrings["MyDbConnection"];
            if (s1 != null && !string.IsNullOrEmpty(s1.ConnectionString)) conn = s1.ConnectionString;
            if (string.IsNullOrEmpty(conn))
            {
                var s2 = ConfigurationManager.ConnectionStrings["DbConnect"];
                if (s2 != null) conn = s2.ConnectionString;
            }
            if (!string.IsNullOrEmpty(conn))
            {
                using (var con = new SqlConnection(conn))
                using (var cmd = new SqlCommand("SELECT PasswordHash, PasswordSalt FROM Admins WHERE UserName = @u", con))
                {
                    cmd.Parameters.AddWithValue("@u", user);
                    con.Open();
                    using (var rdr = cmd.ExecuteReader())
                    {
                        if (rdr.Read())
                        {
                            string dbHash = rdr["PasswordHash"] == DBNull.Value ? null : rdr["PasswordHash"].ToString();
                            string dbSalt = rdr["PasswordSalt"] == DBNull.Value ? null : rdr["PasswordSalt"].ToString();
                            if (!string.IsNullOrEmpty(dbHash) && !string.IsNullOrEmpty(dbSalt))
                            {
                                if (PasswordHelper.Verify(pass, dbSalt, dbHash)) ok = true;
                            }
                        }
                    }
                }
            }
        }
        catch
        {
            // ignore DB errors and fall back to AppSettings
        }

        // 2) Fallback: legacy plaintext admin in Web.config
        if (!ok)
        {
            if (user == cfgUser && pass == cfgPass) ok = true;
        }

        if (ok)
        {
            // set auth cookie so authentication survives app restarts and navigations
            FormsAuthentication.SetAuthCookie(user, false);
            Session["IsAdmin"] = true;
            Session["AdminUser"] = user;
            litAdminMessage.Text = "<div class=\"alert alert-success\">Admin login successful. Redirecting...</div>";
            // if returnUrl provided, navigate back there
            string returnUrl = Request.QueryString["returnUrl"];
            if (!string.IsNullOrEmpty(returnUrl))
            {
                try
                {
                    returnUrl = Server.UrlDecode(returnUrl);
                    // allow only local paths to avoid open redirect
                    if (returnUrl.StartsWith("/") && !returnUrl.Contains("//"))
                    {
                        Response.Redirect(returnUrl);
                        return;
                    }
                }
                catch { }
            }
            Response.Redirect("~/admin/queued-emails.aspx");
            return;
        }
        else
        {
            litAdminMessage.Text = "<div class=\"alert alert-danger\">Invalid admin credentials.</div>";
        }
    }
}
