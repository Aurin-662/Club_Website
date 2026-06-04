using System;
using System.Configuration;
using System.Data.SqlClient;

public partial class reset_password : System.Web.UI.Page
{
    private int _userId = 0;
    private string _token = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            _token = Request.QueryString["token"];
            if (string.IsNullOrEmpty(_token))
            {
                lblMessage.Text = "Invalid or missing token.";
                lblMessage.ForeColor = System.Drawing.Color.Blue;
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["MyDbConnection"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connString))
            {
                con.Open();
                string q = "SELECT UserID, ExpiresAt FROM PasswordResetTokens WHERE Token = @t";
                using (var cmd = new SqlCommand(q, con))
                {
                    cmd.Parameters.AddWithValue("@t", _token);
                    using (var rdr = cmd.ExecuteReader())
                    {
                        if (!rdr.Read())
                        {
                            lblMessage.Text = "Invalid or expired token.";
                            lblMessage.ForeColor = System.Drawing.Color.Blue;
                            return;
                        }
                        DateTime expires = Convert.ToDateTime(rdr["ExpiresAt"]);
                        if (expires < DateTime.UtcNow)
                        {
                            lblMessage.Text = "Token has expired.";
                            lblMessage.ForeColor = System.Drawing.Color.Blue;
                            return;
                        }
                        _userId = Convert.ToInt32(rdr["UserID"]);
                    }
                }
            }

            ViewState["ResetUserId"] = _userId;
            ViewState["ResetToken"] = _token;
            pnlForm.Visible = true;
        }
    }

    protected void BtnReset_Click(object sender, EventArgs e)
    {
        string p1 = txtPassword.Text.Trim();
        string p2 = txtPassword2.Text.Trim();
        if (string.IsNullOrEmpty(p1) || p1 != p2)
        {
            lblMessage.Text = "Passwords do not match or empty.";
            lblMessage.ForeColor = System.Drawing.Color.Blue;
            return;
        }

        int userId = ViewState["ResetUserId"] != null ? (int)ViewState["ResetUserId"] : 0;
        string token = ViewState["ResetToken"] as string;
        if (userId == 0 || string.IsNullOrEmpty(token))
        {
            lblMessage.Text = "Invalid request.";
            lblMessage.ForeColor = System.Drawing.Color.Blue;
            return;
        }

        string connString = ConfigurationManager.ConnectionStrings["MyDbConnection"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connString))
        {
            con.Open();
            // generate new hash and save
            string newHash, newSalt;
            PasswordHelper.CreateHash(p1, out newHash, out newSalt);
            string upd = "UPDATE Users SET PasswordHash = @h, PasswordSalt = @s WHERE UserID = @uid";
            using (var cmd = new SqlCommand(upd, con))
            {
                cmd.Parameters.AddWithValue("@h", newHash);
                cmd.Parameters.AddWithValue("@s", newSalt);
                cmd.Parameters.AddWithValue("@uid", userId);
                cmd.ExecuteNonQuery();
            }

            // remove token
            using (var cmd = new SqlCommand("DELETE FROM PasswordResetTokens WHERE Token = @t", con))
            {
                cmd.Parameters.AddWithValue("@t", token);
                cmd.ExecuteNonQuery();
            }
        }

        lblMessage.Text = "Password has been reset. You may now login.";
        lblMessage.ForeColor = System.Drawing.Color.Blue;
        pnlForm.Visible = false;
    }
}
