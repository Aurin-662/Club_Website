using System;
using System.Web;
using System.Web.UI;
using System.Collections.Generic;

public partial class SiteMaster : MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // ল্যাব ম্যানুয়াল সিকিউরিটি গাইডলাইন: ব্রাউজারের ব্যাক-বাটন ক্যাশ প্রতিরোধ করা
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
        Response.Cache.SetNoStore();

        // সেশন ট্র্যাকিং চেক - evaluate on every request so event handlers remain wired on postback
        try
        {
            if (Session["UserName"] != null)
            {
                string userName = Session["UserName"].ToString();
                phAnonymous.Visible = false;
                phLoggedIn.Visible = true;
                lblUserName.Text = userName;

                phAnonymousMobile.Visible = false;
                phLoggedInMobile.Visible = true;
                lblUserNameMobile.Text = userName;
            }
            else
            {
                phAnonymous.Visible = true;
                phLoggedIn.Visible = false;
                phAnonymousMobile.Visible = true;
                phLoggedInMobile.Visible = false;
            }
        }
        catch { }

        // অ্যাক্টিভ নেভিগেশন ক্লাস হাইলাইটার রেন্ডারিং
        try
        {
            var path = Request.Path.ToLowerInvariant();

            Action<System.Web.UI.HtmlControls.HtmlAnchor, string> apply = (anchor, href) =>
            {
                if (anchor == null) return;
                // preserve any existing nav-* token (like nav-home, nav-job) so client-side selectors continue to work
                var existing = anchor.Attributes["class"] ?? string.Empty;
                var parts = new List<string>(existing.Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries));
                if (!parts.Contains("nav-link")) parts.Insert(0, "nav-link");
                if (!parts.Contains("fw-semibold")) parts.Add("fw-semibold");
                if (!string.IsNullOrEmpty(href) && path.EndsWith(href.ToLowerInvariant()))
                {
                    if (!parts.Contains("active")) parts.Add("active");
                }
                anchor.Attributes["class"] = string.Join(" ", parts);
            };

            apply(navHome, "home.aspx");
            apply(navJobs, "jobs.aspx");
            apply(navBlogs, "blogs.aspx");

            apply(navHomeMobile, "home.aspx");
            apply(navJobsMobile, "jobs.aspx");
            apply(navBlogsMobile, "blogs.aspx");

            // Ensure Home appears active when the request is at the site root or default page
            try
            {
                var appPath = (Request.ApplicationPath ?? "").ToLowerInvariant();
                if (path == "/" || string.IsNullOrEmpty(path) || path.EndsWith("/default.aspx") || path == appPath || path == appPath + "/")
                {
                    try { navHome.Attributes.Add("class", "nav-link active fw-semibold"); } catch { }
                    try { navHomeMobile.Attributes.Add("class", "nav-link active fw-semibold"); } catch { }
                }
            }
            catch { }

            // Keep top-level dropdown anchors static; highlight is handled client-side for dropdown items when needed.

            if (path.EndsWith("jobs.aspx") || path.Contains("/jobs"))
            {
                try { navJobs.Attributes.Add("class", "nav-link active fw-semibold"); } catch { }
                try { navJobsMobile.Attributes.Add("class", "nav-link active fw-semibold"); } catch { }
            }
            // No further server-side activation for dropdown toggles; client-side script will mark the correct link active when the page has a matching link
        }
        catch { }
    }

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        // ensure click handlers attached even if viewstate/scripts interfere
        try
        {
            if (btnLogout != null)
                btnLogout.Click += BtnLogout_Click;
        }
        catch { }
        try
        {
            if (btnLogoutMobile != null)
                btnLogoutMobile.Click += BtnLogout_Click;
        }
        catch { }
    }

    // লগআউট ইভেন্ট হ্যান্ডলার (ডেস্কটপ ও মোবাইল বাটন উভয়ের জন্যই এটি এক্সিকিউট হবে)
    protected void BtnLogout_Click(object sender, EventArgs e)
    {
        // ১. সার্ভার সাইড সেশন সম্পূর্ণ নিশ্চিহ্ন করা
        Session.Clear();
        Session.RemoveAll();
        Session.Abandon();

        // ২. ক্লায়েন্ট সাইড রিমেম্বার-মি কুকি ধ্বংস করা
        try
        {
            if (Response.Cookies["UserEmail"] != null)
            {
                Response.Cookies["UserEmail"].Value = "";
                Response.Cookies["UserEmail"].Expires = DateTime.Now.AddDays(-1);
            }
        }
        catch { }

        // expire common auth/session cookies if present
        try
        {
            if (Response.Cookies["ASP.NET_SessionId"] != null)
            {
                Response.Cookies["ASP.NET_SessionId"].Value = "";
                Response.Cookies["ASP.NET_SessionId"].Expires = DateTime.Now.AddDays(-1);
            }
        }
        catch { }
        try
        {
            if (Response.Cookies[".ASPXAUTH"] != null)
            {
                Response.Cookies[".ASPXAUTH"].Value = "";
                Response.Cookies[".ASPXAUTH"].Expires = DateTime.Now.AddDays(-1);
            }
        }
        catch { }
        // ৩. ক্লিন রিডাইরেক্টের জন্য রেসপন্স বাফার ক্লিয়ার করে রিডাইরেক্ট করা
        Response.BufferOutput = true;
        Response.Redirect("login.aspx", true);
    }
}
