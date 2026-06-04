using System;

public partial class AdminMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.IsAuthenticated && Session["AdminUser"] != null)
        {
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

    protected void BtnAdminLogout_Click(object sender, EventArgs e)
    {
        System.Web.Security.FormsAuthentication.SignOut();
        Session.Clear();
        Response.Redirect("~/admin/admin-login.aspx");
    }
}
