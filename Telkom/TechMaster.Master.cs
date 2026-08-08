using System;
using System.Web.UI;

namespace Telkom
{
    public partial class TechMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Display current user's name in the sidebar
            if (Session["Username"] != null)
            {
                lblUsername.Text = Session["Username"].ToString();
            }
            else
            {
                lblUsername.Text = "Guest";
                // Optionally redirect to login if no user is logged in
                // Response.Redirect("SignIn.aspx");
            }
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            // Clear all session data
            Session.Clear();
            Session.Abandon();

            // Redirect to sign-in page
            Response.Redirect("LandingPage.aspx");
        }
    }
}