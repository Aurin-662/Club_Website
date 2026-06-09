using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class admin_manage_events : System.Web.UI.Page
{
    private string GetConnectionString()
    {
        var setting = ConfigurationManager.ConnectionStrings["DbConnect"];
        if (setting != null && !string.IsNullOrEmpty(setting.ConnectionString)) return setting.ConnectionString;
        return @"Data Source=.\SQLEXPRESS;Initial Catalog=KUET_Career_Club_DB;Integrated Security=True;";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["IsAdmin"] == null || !(Session["IsAdmin"] is bool) || !(bool)Session["IsAdmin"])
        {
            Response.Redirect("~/admin/admin-login.aspx?returnUrl=" + Server.UrlEncode(Request.RawUrl ?? "~/admin/manage-events.aspx"));
            return;
        }

        if (!IsPostBack) LoadEvents();
    }

    private void LoadEvents()
    {
        try
        {
            using (var conn = new SqlConnection(GetConnectionString()))
            using (var cmd = new SqlCommand("SELECT EventID, EventTitle, EventDate, EventLocation, EventType, Description, EventTime, BadgeClass FROM Events ORDER BY EventDate", conn))
            {
                conn.Open();
                using (var da = new SqlDataAdapter(cmd))
                {
                    var dt = new DataTable();
                    da.Fill(dt);
                    rptManage.DataSource = dt;
                    rptManage.DataBind();
                    litCount.Text = dt.Rows.Count.ToString();
                }
            }
        }
        catch (Exception ex)
        {
            litManageStatus.Text = "<div class=\"alert alert-danger\">Failed to load events: " + Server.HtmlEncode(ex.Message) + "</div>";
        }
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        hfEventID.Value = "";
        txtTitle.Text = txtDate.Text = txtLocation.Text = txtType.Text = txtTime.Text = txtBadge.Text = txtDescription.Text = string.Empty;
    }

    protected void btnSaveEvent_Click(object sender, EventArgs e)
    {
        try
        {
            int id = 0;
            int.TryParse(hfEventID.Value, out id);
            using (var conn = new SqlConnection(GetConnectionString()))
            using (var cmd = new SqlCommand())
            {
                cmd.Connection = conn;
                if (id == 0)
                {
                    cmd.CommandText = "INSERT INTO Events (EventTitle, EventDate, EventLocation, EventType, Description, EventTime, BadgeClass) VALUES (@t,@d,@l,@ty,@desc,@time,@badge)";
                }
                else
                {
                    cmd.CommandText = "UPDATE Events SET EventTitle=@t, EventDate=@d, EventLocation=@l, EventType=@ty, Description=@desc, EventTime=@time, BadgeClass=@badge WHERE EventID=@id";
                    cmd.Parameters.AddWithValue("@id", id);
                }
                cmd.Parameters.AddWithValue("@t", txtTitle.Text);
                cmd.Parameters.AddWithValue("@d", txtDate.Text);
                cmd.Parameters.AddWithValue("@l", txtLocation.Text);
                cmd.Parameters.AddWithValue("@ty", txtType.Text);
                cmd.Parameters.AddWithValue("@desc", txtDescription.Text);
                cmd.Parameters.AddWithValue("@time", txtTime.Text);
                cmd.Parameters.AddWithValue("@badge", txtBadge.Text);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            litManageStatus.Text = "<div class=\"alert alert-success\">Event saved.</div>";
            btnReset_Click(null, null);
            LoadEvents();
        }
        catch (Exception ex)
        {
            litManageStatus.Text = "<div class=\"alert alert-danger\">Save failed: " + Server.HtmlEncode(ex.Message) + "</div>";
        }
    }

    protected void rptManage_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "edit")
        {
            int id;
            if (int.TryParse(Convert.ToString(e.CommandArgument), out id))
            {
                try
                {
                    using (var conn = new SqlConnection(GetConnectionString()))
                    using (var cmd = new SqlCommand("SELECT TOP 1 * FROM Events WHERE EventID=@id", conn))
                    {
                        cmd.Parameters.AddWithValue("@id", id);
                        conn.Open();
                        using (var rdr = cmd.ExecuteReader())
                        {
                            if (rdr.Read())
                            {
                                hfEventID.Value = rdr["EventID"].ToString();
                                txtTitle.Text = Convert.ToString(rdr["EventTitle"]);
                                txtDate.Text = Convert.ToString(rdr["EventDate"]);
                                txtLocation.Text = Convert.ToString(rdr["EventLocation"]);
                                txtType.Text = Convert.ToString(rdr["EventType"]);
                                txtDescription.Text = Convert.ToString(rdr["Description"]);
                                txtTime.Text = Convert.ToString(rdr["EventTime"]);
                                txtBadge.Text = Convert.ToString(rdr["BadgeClass"]);
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    litManageStatus.Text = "<div class=\"alert alert-danger\">Load failed: " + Server.HtmlEncode(ex.Message) + "</div>";
                }
            }
        }
        else if (e.CommandName == "delete")
        {
            int id;
            if (int.TryParse(Convert.ToString(e.CommandArgument), out id))
            {
                try
                {
                    using (var conn = new SqlConnection(GetConnectionString()))
                    using (var cmd = new SqlCommand("DELETE FROM Events WHERE EventID=@id", conn))
                    {
                        cmd.Parameters.AddWithValue("@id", id);
                        conn.Open();
                        int aff = cmd.ExecuteNonQuery();
                        if (aff > 0) litManageStatus.Text = "<div class=\"alert alert-success\">Event deleted.</div>"; else litManageStatus.Text = "<div class=\"alert alert-warning\">Event not found.</div>";
                    }
                }
                catch (Exception ex)
                {
                    litManageStatus.Text = "<div class=\"alert alert-danger\">Delete failed: " + Server.HtmlEncode(ex.Message) + "</div>";
                }
                LoadEvents();
            }
        }
    }
}
