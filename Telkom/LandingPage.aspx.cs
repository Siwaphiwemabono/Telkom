using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telkom.Models;

namespace Telkom
{
    public partial class LandingPage : System.Web.UI.Page

    { 
        // Simple in-memory user store for demonstration
        private static readonly List<TelkomUser> Users = new List<TelkomUser>
        {
            new TelkomUser { Username = "tech1", Password = "pass123", Role = "Technician", FullName = "John Smith" },
            new TelkomUser { Username = "agent1", Password = "pass123", Role = "Agent", FullName = "Sarah Johnson" },
            new TelkomUser { Username = "customer1", Password = "pass123", Role = "Customer", FullName = "Mike Davis" }
        };

        protected void btnSignIn_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            var user = Users.FirstOrDefault(u => u.Username == username && u.Password == password);

            if (user != null)
            {
                // Save session data
                Session["Username"] = user.Username;
                Session["UserRole"] = user.Role;
                Session["FullName"] = user.FullName; // Added for CustomerDash compatibility

                // Redirect based on role
                switch (user.Role)
                {
                    case "Technician":
                        Response.Redirect("TechnicianDashboard.aspx");
                        break;
                    case "Agent":
                        Response.Redirect("AgentDashboard.aspx");
                        break;
                    case "Customer":
                        Response.Redirect("CustomerDash.aspx"); // Updated to match your actual file name
                        break;
                    default:
                        lblError.Text = "Unknown role.";
                        break;
                }
            }
            else
            {
                lblError.Text = "Invalid username or password.";
            }
        }
    }

}
