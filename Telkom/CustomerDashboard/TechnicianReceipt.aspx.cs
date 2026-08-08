using System;
using System.Web.UI;

namespace Telkom.CustomerDashboard
{
    public partial class TechnicianReceipt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if user is logged in
            if (Session["Username"] == null)
            {
                Response.Redirect("LandingPage.aspx");
                return;
            }

            if (!IsPostBack)
            {
                // Get the receipt from session
                string receipt = Session["LastTechnicianReceipt"] as string;

                if (!string.IsNullOrEmpty(receipt))
                {
                    lblReceipt.Text = receipt.Replace("\n", "<br>").Replace("╔", "═").Replace("╗", "═")
                                            .Replace("║", "│").Replace("╚", "═").Replace("╝", "═");
                }
                else
                {
                    // No receipt found, redirect back
                    lblReceipt.Text = "No receipt found. Please book a technician service first.";
                    Response.AddHeader("REFRESH", "3;URL=AITroubleshooter.aspx");
                }
            }
        }
    }
}