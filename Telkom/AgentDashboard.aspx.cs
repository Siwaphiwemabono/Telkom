using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;

namespace Telkom
{
    public partial class AgentDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if user is authenticated as Agent
            if (!IsAgentAuthenticated())
            {
                Response.Redirect("~/SignIn.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadDashboardData();
            }
        }

        private bool IsAgentAuthenticated()
        {
            string userRole = Session["UserRole"]?.ToString();
            return !string.IsNullOrEmpty(userRole) && userRole == "Agent";
        }

        private void LoadDashboardData()
        {
            string agentId = Session["Username"]?.ToString();

            // Load agent info
            litAgentName.Text = Session["FullName"]?.ToString() ?? "Agent";

            // Load statistics (replace with actual database calls)
            LoadQueueStats();
            LoadRecentActivity(agentId);
        }

        private void LoadQueueStats()
        {
            // Simulate real stats - replace with actual database queries
            var random = new Random();

            litCustomersInQueue.Text = (15 + random.Next(15)).ToString();
            litResolvedToday.Text = (8 + random.Next(12)).ToString();
            litAvgWaitTime.Text = (5 + random.Next(10)).ToString("F1") + "m";
            litSatisfactionRate.Text = (94 + random.Next(6)).ToString() + "%";
        }

        private void LoadRecentActivity(string agentId)
        {
            // Generate sample activity data - replace with database queries
            var activities = new List<dynamic>
            {
                new { Time = DateTime.Now.AddMinutes(-15), Description = "Resolved WiFi issue for customer #12845", Type = "resolved" },
                new { Time = DateTime.Now.AddMinutes(-32), Description = "Assigned technician to router problem", Type = "assigned" },
                new { Time = DateTime.Now.AddMinutes(-45), Description = "Completed customer call - billing inquiry", Type = "call" },
                new { Time = DateTime.Now.AddHours(-1), Description = "Resolved internet connectivity issue", Type = "resolved" },
                new { Time = DateTime.Now.AddHours(-2), Description = "Customer escalation handled successfully", Type = "resolved" }
            };

            rptActivity.DataSource = activities;
            rptActivity.DataBind();
        }
    }

    // Helper classes for data management
    public static class QueueStatistics
    {
        public static int GetCustomersInQueue()
        {
            // Replace with actual database query
            return new Random().Next(10, 30);
        }

        public static int GetResolvedToday(string agentId)
        {
            // Replace with actual database query
            return new Random().Next(5, 20);
        }

        public static double GetAverageWaitTime()
        {
            // Replace with actual database query
            return new Random().NextDouble() * 10 + 5; // 5-15 minutes
        }

        public static int GetSatisfactionRate(string agentId)
        {
            // Replace with actual database query
            return new Random().Next(90, 100);
        }
    }
}