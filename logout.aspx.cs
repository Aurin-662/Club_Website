using System;
using System.Web;
using System.Web.UI;

public partial class logout : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            // Clear session and cookies and redirect to login
            Session.Clear();
            Session.Abandon();

            if (Response.Cookies["UserEmail"] != null)
            {
                Response.Cookies["UserEmail"].Value = "";
                Response.Cookies["UserEmail"].Expires = DateTime.Now.AddDays(-1);
            }
            if (Response.Cookies[".ASPXAUTH"] != null)
            {
                Response.Cookies[".ASPXAUTH"].Value = "";
                Response.Cookies[".ASPXAUTH"].Expires = DateTime.Now.AddDays(-1);
            }
        }
        catch { }
        Response.Redirect("login.aspx", true);
    }
}