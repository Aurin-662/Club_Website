using System;
using System.Web;
using System.Web.UI;
using System.Data.SqlClient;
using System.Configuration;

public partial class login : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblMessage.Text = "";

            // পেজ লোড হওয়ার সময় যদি অলরেডি কুকি (Cookie) সেভ থাকে, তা অটোমেটিক ইনপুটে বসাবে
            if (Request.Cookies["UserEmail"] != null)
            {
                txtLoginEmail.Text = Request.Cookies["UserEmail"].Value;
                chkRemember.Checked = true;
            }
        }
    }

    protected void BtnSignIn_Click(object sender, EventArgs e)
    {
        string email = txtLoginEmail.Text.Trim();
        string password = txtLoginPassword.Text.Trim();

        // ১. ইনপুট ফিল্ড ফাঁকা কিনা ভ্যালিডেশন
        if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
        {
            lblMessage.Text = "Please enter your email and password.";
            lblMessage.ForeColor = System.Drawing.Color.Blue;
            return;
        }

        // ২. Web.config থেকে ডাটাবেজ কানেকশন স্ট্রিং রিড করা
        string connString = ConfigurationManager.ConnectionStrings["MyDbConnection"].ConnectionString;

        // ৩. ADO.NET: retrieve user by email and verify password (supports migrated hashed passwords)
        using (SqlConnection con = new SqlConnection(connString))
        {
            string query = "SELECT UserID, FullName, StudentID, Email, Password, PasswordHash, PasswordSalt FROM Users WHERE Email = @Email";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Email", email);

                try
                {
                    con.Open();
                    using (SqlDataReader rdr = cmd.ExecuteReader())
                    {
                        if (!rdr.Read())
                        {
                        lblMessage.Text = "Invalid KUET Email or Password!";
                        lblMessage.ForeColor = System.Drawing.Color.Blue;
                            return;
                        }

                        string dbPasswordPlain = rdr["Password"] == DBNull.Value ? null : rdr["Password"].ToString();
                        string dbHash = rdr["PasswordHash"] == DBNull.Value ? null : rdr["PasswordHash"].ToString();
                        string dbSalt = rdr["PasswordSalt"] == DBNull.Value ? null : rdr["PasswordSalt"].ToString();

                        bool verified = false;

                        // If hash+salt exist, verify against them
                        if (!string.IsNullOrEmpty(dbHash) && !string.IsNullOrEmpty(dbSalt))
                        {
                            verified = PasswordHelper.Verify(password, dbSalt, dbHash);
                        }
                        else if (!string.IsNullOrEmpty(dbPasswordPlain))
                        {
                            // legacy plaintext password — verify directly and migrate to hash
                            if (dbPasswordPlain == password)
                            {
                                verified = true;
                                try
                                {
                                    // create hash and try to save back to DB
                                    string newHash, newSalt;
                                    PasswordHelper.CreateHash(password, out newHash, out newSalt);
                                    rdr.Close();
                                    using (var upd = new SqlCommand("UPDATE Users SET PasswordHash = @h, PasswordSalt = @s WHERE Email = @Email", con))
                                    {
                                        upd.Parameters.AddWithValue("@h", newHash);
                                        upd.Parameters.AddWithValue("@s", newSalt);
                                        upd.Parameters.AddWithValue("@Email", email);
                                        upd.ExecuteNonQuery();
                                    }
                                    // Note: do not delete old Password column here; keep until migration complete
                                }
                                catch
                                {
                                    // ignore migration failures — login should still proceed
                                }
                            }
                        }

                        if (!verified)
                        {
                            lblMessage.Text = "Invalid KUET Email or Password!";
                            lblMessage.ForeColor = System.Drawing.Color.Red;
                            return;
                        }

                        // authentication succeeded — set session and optional cookie
                        Session["UserEmail"] = rdr["Email"].ToString();
                        Session["UserName"] = rdr["FullName"].ToString();
                        Session["StudentID"] = rdr["StudentID"].ToString();

                        if (chkRemember.Checked)
                        {
                            HttpCookie emailCookie = new HttpCookie("UserEmail", email);
                            emailCookie.Expires = DateTime.Now.AddDays(7);
                            Response.Cookies.Add(emailCookie);
                        }
                        else
                        {
                            if (Request.Cookies["UserEmail"] != null)
                            {
                                Response.Cookies["UserEmail"].Expires = DateTime.Now.AddDays(-1);
                            }
                        }

                        lblMessage.Text = "Login successful — redirecting to home...";
                        lblMessage.ForeColor = System.Drawing.Color.Green;
                        Response.Redirect("home.aspx");
                    }
                }
                catch (Exception)
                {
                    // avoid leaking exception details to the user; log server-side instead
                    lblMessage.Text = "An error occurred while processing your request. Please try again later.";
                    lblMessage.ForeColor = System.Drawing.Color.Blue;
                }
            }
        }
    }
}