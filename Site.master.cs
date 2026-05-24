using System;
using System.Web.UI;

public partial class SiteMaster : MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            var path = Request.Path.ToLowerInvariant();
            // clear any pre-existing active classes
            Action<System.Web.UI.HtmlControls.HtmlAnchor, string> apply = (anchor, href) =>
            {
                if (anchor == null) return;
                anchor.Attributes.Remove("class");
                anchor.Attributes.Add("class", "nav-link fw-semibold");
                if (!string.IsNullOrEmpty(href) && path.EndsWith(href.ToLowerInvariant()))
                {
                    anchor.Attributes.Add("class", "nav-link active fw-semibold");
                }
            };

            apply(navHome, "home.aspx");
            apply(navJobs, "home.aspx");
            apply(navBlogs, "blogs.aspx");

            apply(navHomeMobile, "home.aspx");
            apply(navJobsMobile, "home.aspx");
            apply(navBlogsMobile, "blogs.aspx");

            // If the current request is the jobs page (jobs & internships), highlight Jobs nav
            if (path.EndsWith("jobs.aspx") || path.Contains("/jobs"))
            {
                try { navJobs.Attributes.Add("class", "nav-link active fw-semibold"); } catch { }
                try { navJobsMobile.Attributes.Add("class", "nav-link active fw-semibold"); } catch { }
            }
        }
        catch { }
    }
}
