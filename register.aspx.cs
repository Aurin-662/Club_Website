using System;
using System.IO;
using System.Web.UI;
using System.Data.SqlClient;
using System.Configuration;

public partial class register : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // প্রথমবার পেজ লোড হওয়ার সময় কোনো মেসেজ থাকবে না
        if (!IsPostBack)
        {
            lblMessage.Text = "";
        }
    }

    protected void btnCreateAccount_Click(object sender, EventArgs e)
    {
        // প্রাথমিক ভ্যালিডেশন: শর্তাবলীতে টিক দেওয়া হয়েছে কিনা পরীক্ষা করা
        if (!chkTerms.Checked)
        {
            lblMessage.Text = "Please agree to the constitution and code of conduct.";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        // প্রোফাইল পিকচার হ্যান্ডেল করার লজিক
        string imagePath = "";
        if (fileProfile.HasFile)
        {
            try
            {
                string extension = Path.GetExtension(fileProfile.FileName).ToLower();
                if (extension == ".jpg" || extension == ".png" || extension == ".jpeg")
                {
                    // ফাইলের একটি ইউনিক নাম তৈরি করা যাতে এক নামের ছবি ওভাররাইট না হয়
                    string fileName = txtStudentId.Text.Trim() + "_" + Path.GetFileName(fileProfile.FileName);

                    // প্রজেক্টে 'Uploads' নামে ফোল্ডার না থাকলে তা তৈরি করবে
                    string folderPath = Server.MapPath("~/Uploads/");
                    if (!Directory.Exists(folderPath))
                    {
                        Directory.CreateDirectory(folderPath);
                    }

                    // ছবি সেভ করা
                    fileProfile.SaveAs(folderPath + fileName);
                    imagePath = "Uploads/" + fileName;
                }
                else
                {
                    lblMessage.Text = "Only .jpg, .jpeg or .png images are allowed.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    return;
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Image upload failed: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }
        }

        // Web.config থেকে ডাটাবেজ কানেকশন স্ট্রিং নিয়ে আসা
        string connString = ConfigurationManager.ConnectionStrings["MyDbConnection"].ConnectionString;

        // ADO.NET ব্যবহার করে ডাটাবেজে ইনসার্ট করা (স্যারের ল্যাব মেথড)
        using (SqlConnection con = new SqlConnection(connString))
        {
            string query = "INSERT INTO Users (FullName, StudentID, Department, Batch, Email, Password, ProfilePicture) " +
                           "VALUES (@FullName, @StudentID, @Department, @Batch, @Email, @Password, @ProfilePicture)";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                // SQL Injection সুরক্ষার জন্য প্যারামিটার ব্যবহার (স্যারের ২য় স্ক্রিনশটের নিয়ম)
                cmd.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
                cmd.Parameters.AddWithValue("@StudentID", txtStudentId.Text.Trim());
                cmd.Parameters.AddWithValue("@Department", ddlDepartment.SelectedValue);
                cmd.Parameters.AddWithValue("@Batch", Convert.ToInt32(txtBatch.Text.Trim()));
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim()); // ল্যাব ডেমোর জন্য প্লেইন টেক্সট
                cmd.Parameters.AddWithValue("@ProfilePicture", string.IsNullOrEmpty(imagePath) ? (object)DBNull.Value : imagePath);

                try
                {
                    con.Open();
                    int rowsAffected = cmd.ExecuteNonQuery(); // কুয়েরি এক্সিকিউট করা

                    if (rowsAffected > 0)
                    {
                        lblMessage.Text = "Registration Successful! Redirecting to login page...";
                        lblMessage.ForeColor = System.Drawing.Color.Green;

                        // ফর্ম ক্লিয়ার করা
                        txtFullName.Text = "";
                        txtStudentId.Text = "";
                        txtBatch.Text = "";
                        txtEmail.Text = "";
                        ddlDepartment.SelectedIndex = 0;
                        chkTerms.Checked = false;

                        // ৩ সেকেন্ড পর লগইন পেজে অটোমেটিক রিডাইরেক্ট হবে
                        Response.AppendHeader("Refresh", "3;url=login.aspx");
                    }
                    else
                    {
                        lblMessage.Text = "Registration failed. Please try again.";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }
                }
                catch (Exception ex)
                {
                    // ইমেইল ডুপ্লিকেট হলে বা অন্য কোনো ডাটাবেজ এরর আসলে তা হ্যান্ডেল করবে
                    if (ex.Message.Contains("UNIQUE KEY"))
                    {
                        lblMessage.Text = "This Email Address is already registered!";
                    }
                    else
                    {
                        lblMessage.Text = "Database Error: " + ex.Message;
                    }
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
        }
    }
}