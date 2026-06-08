using System;

public partial class AdminMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // If the auth cookie is present but session was lost (app recycle), restore minimal admin session state
        try
        {
            if (Request.IsAuthenticated)
            {
                // ensure session flags for admin are present so pages checking Session["IsAdmin"] continue to work
                if (Session["AdminUser"] == null)
                {
                    try { Session["AdminUser"] = Page != null && Page.User != null && Page.User.Identity != null && !string.IsNullOrEmpty(Page.User.Identity.Name) ? Page.User.Identity.Name : "admin"; } catch { Session["AdminUser"] = "admin"; }
                    try { Session["IsAdmin"] = true; } catch { }
                }

                lblAdminUser.Text = Session["AdminUser"].ToString();
                phSignIn.Visible = false;
                btnAdminLogout.Visible = true;
                phUserSignIn.Visible = false;
                phUserSignOut.Visible = true;
            }
            else
            {
                lblAdminUser.Text = "";
                phSignIn.Visible = true;
                btnAdminLogout.Visible = false;
                phUserSignIn.Visible = true;
                phUserSignOut.Visible = false;
            }
        }
        catch
        {
            lblAdminUser.Text = "";
            phSignIn.Visible = true;
            btnAdminLogout.Visible = false;
            phUserSignIn.Visible = true;
            phUserSignOut.Visible = false;
        }

        // Server-side active navigation handling for admin links
        try
        {
            var path = Request.Path.ToLowerInvariant();
            if (path.Contains("companies.aspx") || path.Contains("/companies"))
            {
                try { lnkCompanies.Attributes.Add("class", "nav-link active"); } catch { }
                try { lnkCompaniesMobile.Attributes.Add("class", "nav-link active"); } catch { }
            }
        }
        catch { }
    }

    protected void BtnAdminLogout_Click(object sender, EventArgs e)
    {
        System.Web.Security.FormsAuthentication.SignOut();
        Session.Clear();
        Response.Redirect("~/admin/admin-login.aspx");
    }
}
