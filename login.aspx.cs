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
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        // ২. Web.config থেকে ডাটাবেজ কানেকশন স্ট্রিং রিড করা
        string connString = ConfigurationManager.ConnectionStrings["MyDbConnection"].ConnectionString;

        // ৩. ADO.NET ও SqlDataReader ব্যবহার করে ডাটা ম্যাচ করা (স্যারের ল্যাব মেথড)
        using (SqlConnection con = new SqlConnection(connString))
        {
            string query = "SELECT * FROM Users WHERE Email = @Email AND Password = @Password";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Password", password); // ল্যাব ডেমো প্রজেক্টের জন্য ডিরেক্ট ভ্যালু চেক

                try
                {
                    con.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();

                    if (rdr.Read()) // ডাটাবেজে ইউজার খুঁজে পাওয়া গেলে (রিমেইনিং কুয়েরি রো সত্য হলে)
                    {
                        // ক) সেশন (Session) ডাটা সেট করা - যা অ্যাপ্লিকেশনের ভেতরে ইউজারকে ট্র্যাক করবে
                        Session["UserEmail"] = rdr["Email"].ToString();
                        Session["UserName"] = rdr["FullName"].ToString();
                        Session["StudentID"] = rdr["StudentID"].ToString();

                        // খ) কুকি (Cookies) হ্যান্ডেল করা - "Remember Me" চেকবক্সের ওপর ভিত্তি করে
                        if (chkRemember.Checked)
                        {
                            // কুকি তৈরি এবং এক্সপায়ারি ডেট ৭ দিন সেট করা (ল্যাব ম্যানুয়াল গাইডলাইন)
                            HttpCookie emailCookie = new HttpCookie("UserEmail", email);
                            emailCookie.Expires = DateTime.Now.AddDays(7);
                            Response.Cookies.Add(emailCookie);
                        }
                        else
                        {
                            // চেকবক্স টিক না দেওয়া থাকলে আগের কুকি ডিলিট করে দেওয়া
                            if (Request.Cookies["UserEmail"] != null)
                            {
                                Response.Cookies["UserEmail"].Expires = DateTime.Now.AddDays(-1);
                            }
                        }

                        // গ) সফলতার মেসেজ ও হোম পেজে রিডাইরেক্ট
                        lblMessage.Text = "Login successful — redirecting to home...";
                        lblMessage.ForeColor = System.Drawing.Color.Green;

                        Response.Redirect("home.aspx");
                    }
                    else
                    {
                        // ইউজার বা পাসওয়ার্ড ভুল হলে এরর মেসেজ
                        lblMessage.Text = "Invalid KUET Email or Password!";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Database Error: " + ex.Message;
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
        }
    }
}