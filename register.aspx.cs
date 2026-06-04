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
            lblMessage.ForeColor = System.Drawing.Color.Blue;
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
                    lblMessage.ForeColor = System.Drawing.Color.Blue;
                    return;
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Image upload failed: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Blue;
                return;
            }
        }

        // Web.config থেকে ডাটাবেজ কানেকশন স্ট্রিং নিয়ে আসা
        string connString = ConfigurationManager.ConnectionStrings["MyDbConnection"].ConnectionString;

        // ADO.NET ব্যবহার করে ডাটাবেজে ইনসার্ট করা (hashed password if supported)
        using (SqlConnection con = new SqlConnection(connString))
        {
            // we'll attempt to insert PasswordHash and PasswordSalt if the columns exist, otherwise fall back to Password
            string hash, salt;
            PasswordHelper.CreateHash(txtPassword.Text.Trim(), out hash, out salt);

            // Attempt insert with PasswordHash/PasswordSalt columns
            string insertWithHash = "INSERT INTO Users (FullName, StudentID, Department, Batch, Email, PasswordHash, PasswordSalt, ProfilePicture) " +
                                    "VALUES (@FullName, @StudentID, @Department, @Batch, @Email, @PasswordHash, @PasswordSalt, @ProfilePicture)";

            using (SqlCommand cmd = new SqlCommand(insertWithHash, con))
            {
                cmd.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
                cmd.Parameters.AddWithValue("@StudentID", txtStudentId.Text.Trim());
                cmd.Parameters.AddWithValue("@Department", ddlDepartment.SelectedValue);
                cmd.Parameters.AddWithValue("@Batch", Convert.ToInt32(txtBatch.Text.Trim()));
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@PasswordHash", hash);
                cmd.Parameters.AddWithValue("@PasswordSalt", salt);
                cmd.Parameters.AddWithValue("@ProfilePicture", string.IsNullOrEmpty(imagePath) ? (object)DBNull.Value : imagePath);

                try
                {
                    con.Open();
                    int rowsAffected = 0;
                    try
                    {
                        rowsAffected = cmd.ExecuteNonQuery();
                    }
                    catch (SqlException ex)
                    {
                        // If columns don't exist (older schema), fall back to legacy insert
                        if (ex.Message.Contains("Invalid column name") || ex.Message.Contains("Could not find column"))
                        {
                            con.Close();
                            string fallback = "INSERT INTO Users (FullName, StudentID, Department, Batch, Email, Password, ProfilePicture) " +
                                              "VALUES (@FullName, @StudentID, @Department, @Batch, @Email, @Password, @ProfilePicture)";
                            using (var fb = new SqlCommand(fallback, con))
                            {
                                fb.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
                                fb.Parameters.AddWithValue("@StudentID", txtStudentId.Text.Trim());
                                fb.Parameters.AddWithValue("@Department", ddlDepartment.SelectedValue);
                                fb.Parameters.AddWithValue("@Batch", Convert.ToInt32(txtBatch.Text.Trim()));
                                fb.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                                fb.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());
                                fb.Parameters.AddWithValue("@ProfilePicture", string.IsNullOrEmpty(imagePath) ? (object)DBNull.Value : imagePath);
                                con.Open();
                                rowsAffected = fb.ExecuteNonQuery();
                            }
                        }
                        else
                        {
                            throw;
                        }
                    }

                    if (rowsAffected > 0)
                    {
                        lblMessage.Text = "Registration Successful! Redirecting to login page...";
                        lblMessage.ForeColor = System.Drawing.Color.Green;

                        // clear form
                        txtFullName.Text = "";
                        txtStudentId.Text = "";
                        txtBatch.Text = "";
                        txtEmail.Text = "";
                        ddlDepartment.SelectedIndex = 0;
                        chkTerms.Checked = false;

                        Response.AppendHeader("Refresh", "3;url=login.aspx");
                    }
                    else
                    {
                        lblMessage.Text = "Registration failed. Please try again.";
                        lblMessage.ForeColor = System.Drawing.Color.Blue;
                    }
                }
                catch (SqlException ex)
                {
                    if (ex.Message.Contains("UNIQUE KEY") || ex.Message.Contains("Violation of UNIQUE KEY"))
                    {
                        lblMessage.Text = "This Email Address is already registered!";
                    }
                    else
                    {
                        lblMessage.Text = "An error occurred while creating your account. Please try again later.";
                    }
                    lblMessage.ForeColor = System.Drawing.Color.Blue;
                }
                catch (Exception)
                {
                    lblMessage.Text = "An unexpected error occurred. Please try again later.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
        }
    }
}