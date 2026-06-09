using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class home : Page
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
            LoadJobs();
            LoadEvents(); // ইভেন্ট লোড করার মেথড কল
        }
    }

    private void LoadJobs()
    {
        try
        {
            using (SqlConnection con = new SqlConnection(GetConnectionString()))
            {
                string query = "SELECT JobID, JobTitle, CompanyName, JobType, Description FROM Jobs ORDER BY CreatedAt DESC";
                using (SqlCommand cmd = new SqlCommand(query, con))
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    rptJobs.DataSource = dt;
                    rptJobs.DataBind();
                    if (pnlNoJobs != null) pnlNoJobs.Visible = (dt.Rows.Count == 0);
                }
            }
        }
        catch { /* Error safety */ }
    }

    // ১. ডাটাবেস থেকে ডাইনামিকালি ইভেন্ট লোড করা
    private void LoadEvents()
    {
        try
        {
            using (SqlConnection con = new SqlConnection(GetConnectionString()))
            {
                string query = "SELECT EventID, EventTitle, EventDate, EventLocation, EventType, Description, EventTime, BadgeClass FROM Events ORDER BY CreatedAt ASC";
                using (SqlCommand cmd = new SqlCommand(query, con))
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    rptEvents.DataSource = dt;
                    rptEvents.DataBind();
                }
            }
        }
        catch (Exception ex)
        {
            lblEventMsg.Visible = true;
            lblEventMsg.Text = "Error loading events: " + ex.Message;
            lblEventMsg.CssClass = "alert alert-danger";
        }
    }

    // ২. বাটনে ক্লিক করলে রেজিস্ট্রেশন একশন হ্যান্ডেল করা
    // রিমিটারের জন্য অবজেক্ট সিগনেচার:
    protected void rptEvents_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "RegisterEvent")
        {
            // কাস্টম সিকিউরিটি চেক: ইউজার লগইন অবস্থায় আছে কিনা
            if (Session["StudentID"] == null)
            {
                lblEventMsg.Visible = true;
                lblEventMsg.Text = "Please sign in to your student account to register for events.";
                lblEventMsg.CssClass = "alert alert-warning fw-bold small d-block mb-3";

                // keep page scrolled to events section after refresh
                ClientScript.RegisterStartupScript(this.GetType(), "hash", "location.hash = '#upcoming-events';", true);
                return;
            }

            int eventId = Convert.ToInt32(e.CommandArgument);
            int studentId = Convert.ToInt32(Session["StudentID"]); // সেশন থেকে স্টুডেন্ট আইডি রিড করা

            try
            {
                using (SqlConnection con = new SqlConnection(GetConnectionString()))
                {
                    // ডুপ্লিকেট রেজিস্ট্রেশন চেক ও ইনসার্ট অপারেশন একত্রে
                    string query = @"IF NOT EXISTS (SELECT 1 FROM EventRegistrations WHERE EventID = @EventID AND StudentID = @StudentID)
                                     BEGIN
                                         INSERT INTO EventRegistrations (EventID, StudentID) VALUES (@EventID, @StudentID)
                                         SELECT 1 AS Result
                                     END
                                     ELSE
                                     BEGIN
                                         SELECT 0 AS Result
                                     END";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@EventID", eventId);
                        cmd.Parameters.AddWithValue("@StudentID", studentId);
                        con.Open();
                        int result = Convert.ToInt32(cmd.ExecuteScalar());

                        lblEventMsg.Visible = true;
                        if (result == 1)
                        {
                            lblEventMsg.Text = "Registration successful. Your seat has been reserved.";
                            lblEventMsg.CssClass = "alert alert-success fw-bold small d-block mb-3";
                        }
                        else
                        {
                            lblEventMsg.Text = "You are already registered for this career event.";
                            lblEventMsg.CssClass = "alert alert-info fw-bold small d-block mb-3";
                        }
                    }
                }
            // refresh update panel if present
            try { var up = this.FindControl("upEvents") as System.Web.UI.UpdatePanel; if (up != null) up.Update(); } catch {}
            }
            catch (Exception ex)
            {
                lblEventMsg.Visible = true;
                lblEventMsg.Text = "🚨 Error processing request: " + ex.Message;
                lblEventMsg.CssClass = "alert alert-danger";
            }

            // বাটনে ক্লিকের পর যেন পেজটি লাফ দিয়ে ওপরে চলে না যায়, বরং ইভেন্ট সেকশনেই স্ক্রোলড থাকে
            ClientScript.RegisterStartupScript(this.GetType(), "hash", "location.hash = '#upcoming-events';", true);
        }
    }

    protected void BtnRegister_Command(object sender, CommandEventArgs e)
    {
        try
        {
            int eventId = 0;
            if (!int.TryParse(Convert.ToString(e.CommandArgument), out eventId)) return;

            // Debug message when not logged in
            if (Session["StudentID"] == null)
            {
                lblEventMsg.Visible = true;
                lblEventMsg.Text = "Please sign in to your student account to register for events.";
                lblEventMsg.CssClass = "alert alert-warning fw-bold small d-block mb-3";
                System.Diagnostics.Debug.WriteLine("BtnRegister_Command: registration attempted without login. EventID=" + eventId);
                ClientScript.RegisterStartupScript(this.GetType(), "hash", "location.hash = '#upcoming-events';", true);
                return;
            }

            int studentId = Convert.ToInt32(Session["StudentID"]);
            using (SqlConnection con = new SqlConnection(GetConnectionString()))
            {
                string query = @"IF NOT EXISTS (SELECT 1 FROM EventRegistrations WHERE EventID = @EventID AND StudentID = @StudentID)
                                     BEGIN
                                         INSERT INTO EventRegistrations (EventID, StudentID) VALUES (@EventID, @StudentID)
                                         SELECT 1 AS Result
                                     END
                                     ELSE
                                     BEGIN
                                         SELECT 0 AS Result
                                     END";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@EventID", eventId);
                    cmd.Parameters.AddWithValue("@StudentID", studentId);
                    con.Open();
                    int result = Convert.ToInt32(cmd.ExecuteScalar());
                    lblEventMsg.Visible = true;
                    if (result == 1)
                    {
                        lblEventMsg.Text = "Registration successful. Your seat has been reserved.";
                        lblEventMsg.CssClass = "alert alert-success fw-bold small d-block mb-3";
                    }
                    else
                    {
                        lblEventMsg.Text = "You are already registered for this career event.";
                        lblEventMsg.CssClass = "alert alert-info fw-bold small d-block mb-3";
                    }
                }
            }
            System.Diagnostics.Debug.WriteLine("BtnRegister_Command: registration processed. EventID=" + eventId + " StudentID=" + studentId);
        }
        catch (Exception ex)
        {
            lblEventMsg.Visible = true;
            lblEventMsg.Text = "🚨 Error processing request: " + ex.Message;
            lblEventMsg.CssClass = "alert alert-danger";
            System.Diagnostics.Debug.WriteLine("BtnRegister_Command error: " + ex);
        }
        ClientScript.RegisterStartupScript(this.GetType(), "hash", "location.hash = '#upcoming-events';", true);
    }
}