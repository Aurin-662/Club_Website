using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class admin_manage_collaborations : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["IsAdmin"] == null || !(Session["IsAdmin"] is bool) || !(bool)Session["IsAdmin"]) { Response.Redirect("~/admin/admin-login.aspx?returnUrl=" + Server.UrlEncode(Request.RawUrl ?? "~/admin/manage-collaborations.aspx")); return; }
        if (!IsPostBack) BindGrid();
    }

    private string GetConnectionString()
    {
        var s = ConfigurationManager.ConnectionStrings["DbConnect"];
        if (s != null && !string.IsNullOrEmpty(s.ConnectionString)) return s.ConnectionString;
        return @"Data Source=.\SQLEXPRESS;Initial Catalog=KUET_Career_Club_DB;Integrated Security=True;";
    }

    private void BindGrid()
    {
        try
        {
            using (var conn = new SqlConnection(GetConnectionString()))
            using (var cmd = new SqlCommand("SELECT InquiryID, OrganizationName, ContactEmail, CollaborationType, MessageText, Status, SubmittedAt FROM Collaborations ORDER BY SubmittedAt DESC", conn))
            {
                conn.Open();
                var dt = new DataTable();
                using (var da = new SqlDataAdapter(cmd)) da.Fill(dt);
                gvCollaborations.DataSource = dt;
                gvCollaborations.DataBind();
            }
        }
        catch (Exception ex) { litMsg.Text = "<div class=\"alert alert-danger\">Failed to load: " + Server.HtmlEncode(ex.Message) + "</div>"; }
    }

    protected void gvCollaborations_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        int id = 0;
        if (!int.TryParse(Convert.ToString(e.CommandArgument), out id)) return;
        if (e.CommandName == "view")
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                using (var cmd = new SqlCommand("SELECT MessageText, OrganizationName, ContactEmail, CollaborationType, Status, SubmittedAt FROM Collaborations WHERE InquiryID = @id", conn))
                {
                    cmd.Parameters.AddWithValue("@id", id);
                    conn.Open();
                    using (var rdr = cmd.ExecuteReader())
                    {
                        if (rdr.Read())
                        {
                            var sb = new System.Text.StringBuilder();
                            sb.AppendLine("<strong>" + Server.HtmlEncode(Convert.ToString(rdr["OrganizationName"])) + "</strong><br />");
                            sb.AppendLine(Server.HtmlEncode(Convert.ToString(rdr["ContactEmail"])) + "<br />");
                            sb.AppendLine(Server.HtmlEncode(Convert.ToString(rdr["CollaborationType"])) + " • " + Server.HtmlEncode(Convert.ToString(rdr["Status"])) + "<br /><br />");
                            sb.AppendLine(Server.HtmlEncode(Convert.ToString(rdr["MessageText"])).Replace("\n","<br />"));
                            litMsg.Text = "<div class=\"alert alert-info\">" + sb.ToString() + "</div>";
                        }
                    }
                }
            }
            catch (Exception ex) { litMsg.Text = "<div class=\"alert alert-danger\">Error: " + Server.HtmlEncode(ex.Message) + "</div>"; }
        }
        else if (e.CommandName == "mark")
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                using (var cmd = new SqlCommand("UPDATE Collaborations SET Status = 'Contacted' WHERE InquiryID = @id", conn))
                {
                    cmd.Parameters.AddWithValue("@id", id);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                litMsg.Text = "<div class=\"alert alert-success\">Inquiry marked as Contacted.</div>";
                BindGrid();
            }
            catch (Exception ex) { litMsg.Text = "<div class=\"alert alert-danger\">Failed to update: " + Server.HtmlEncode(ex.Message) + "</div>"; }
        }
    }
}
