using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Telkom
{
    public partial class Agent : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check authentication and authorization
            if (!IsAgentAuthenticated())
            {
                Response.Redirect("~/LandingPage.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadAgentInfo();
                LoadQuickStats();
            }

            // Handle real-time refresh
            HandleRealTimeUpdates();
        }

        private bool IsAgentAuthenticated()
        {
            string userRole = Session["UserRole"]?.ToString();
            return !string.IsNullOrEmpty(userRole) &&
                   (userRole == "Agent" || userRole == "Technician");
        }

        private void LoadAgentInfo()
        {
            string username = Session["Username"]?.ToString();
            if (!string.IsNullOrEmpty(username))
            {
                // Set agent name and initials
                litAgentName.Text = GetAgentDisplayName(username);
                litAgentInitials.Text = GetAgentInitials(username);
            }
        }

        private void LoadQuickStats()
        {
            string username = Session["Username"]?.ToString();
            if (string.IsNullOrEmpty(username)) return;

            var stats = AgentStatistics.GetAgentStats(username);

            litMyQueue.Text = stats.AssignedToMe.ToString();
            litTotalQueue.Text = stats.TotalInQueue.ToString();
            litAvgResponse.Text = stats.AverageResponseTime.ToString("F1");
            litResolvedToday.Text = stats.ResolvedToday.ToString();
        }

        private void HandleRealTimeUpdates()
        {
            string eventArgument = Request["__EVENTARGUMENT"];

            if (eventArgument == "refreshStats")
            {
                LoadQuickStats();

                // Return updated stats as JSON for JavaScript
                var stats = AgentStatistics.GetAgentStats(Session["Username"]?.ToString());
                string json = $@"{{
                    'assignedToMe': {stats.AssignedToMe},
                    'totalInQueue': {stats.TotalInQueue},
                    'avgResponse': {stats.AverageResponseTime:F1},
                    'resolvedToday': {stats.ResolvedToday}
                }}";

                ScriptManager.RegisterStartupScript(this, GetType(), "updateStats",
                    $"updateQuickStats({json});", true);
            }
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            // Clear session and redirect to login
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/LandingPage.aspx");
        }

        private string GetAgentDisplayName(string username)
        {
            var agentNames = new Dictionary<string, string>
            {
                { "agent1", "Sarah Johnson" },
                { "tech1", "Michael Chen" },
                { "agent2", "David Wilson" },
                { "tech2", "Lisa Anderson" }
            };

            return agentNames.ContainsKey(username) ? agentNames[username] : "Agent User";
        }

        private string GetAgentInitials(string username)
        {
            string fullName = GetAgentDisplayName(username);
            var parts = fullName.Split(' ');

            if (parts.Length >= 2)
            {
                return $"{parts[0][0]}{parts[1][0]}";
            }
            else if (parts.Length == 1)
            {
                return parts[0].Substring(0, Math.Min(2, parts[0].Length));
            }

            return "AG";
        }

        // Public method to set page title from child pages
        public void SetPageInfo(string title, string subtitle = "")
        {
            // Child pages can call this to set their title
            Page.Title = $"{title} - TelkomX Agent Portal";
        }

        // Public method to highlight navigation item
        public void SetActiveNavigation(string navId)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "setActiveNav",
                $"document.getElementById('{navId}').classList.add('active');", true);
        }
    }

    // Supporting classes for agent statistics
    public static class AgentStatistics
    {
        private static readonly Dictionary<string, AgentStats> _agentStats =
            new Dictionary<string, AgentStats>();

        private static readonly Random _random = new Random();
        private static DateTime _lastUpdate = DateTime.MinValue;

        public static AgentStats GetAgentStats(string agentId)
        {
            if (string.IsNullOrEmpty(agentId)) return new AgentStats();

            // Update stats every 30 seconds
            if (DateTime.Now - _lastUpdate > TimeSpan.FromSeconds(30))
            {
                UpdateAllStats();
                _lastUpdate = DateTime.Now;
            }

            if (!_agentStats.ContainsKey(agentId))
            {
                _agentStats[agentId] = GenerateInitialStats(agentId);
            }

            return _agentStats[agentId];
        }

        private static void UpdateAllStats()
        {
            foreach (var kvp in _agentStats.ToList())
            {
                var stats = kvp.Value;

                // Simulate realistic changes
                var newAssignedToMe = stats.AssignedToMe + _random.Next(-1, 3); // -1 to +2
                newAssignedToMe = Math.Max(0, Math.Min(15, newAssignedToMe));

                var newTotalInQueue = stats.TotalInQueue + _random.Next(-2, 4); // -2 to +3
                newTotalInQueue = Math.Max(5, Math.Min(50, newTotalInQueue));

                var newAverageResponseTime = stats.AverageResponseTime + (_random.NextDouble() - 0.5) * 0.3;
                newAverageResponseTime = Math.Max(1.0, Math.Min(8.0, newAverageResponseTime));

                // Resolved today only increases
                var newResolvedToday = stats.ResolvedToday;
                if (_random.Next(0, 100) < 15) // 15% chance
                {
                    newResolvedToday++;
                }

                // Create new struct with updated values
                var updatedStats = new AgentStats
                {
                    AssignedToMe = newAssignedToMe,
                    TotalInQueue = newTotalInQueue,
                    AverageResponseTime = newAverageResponseTime,
                    ResolvedToday = newResolvedToday
                };

                _agentStats[kvp.Key] = updatedStats;
            }
        }

        private static AgentStats GenerateInitialStats(string agentId)
        {
            return new AgentStats
            {
                AssignedToMe = _random.Next(2, 8),
                TotalInQueue = _random.Next(15, 35),
                AverageResponseTime = 2.0 + _random.NextDouble() * 3.0,
                ResolvedToday = _random.Next(8, 20)
            };
        }

        public static void IncrementResolved(string agentId)
        {
            if (_agentStats.ContainsKey(agentId))
            {
                var stats = _agentStats[agentId];
                var updatedStats = new AgentStats
                {
                    AssignedToMe = stats.AssignedToMe,
                    TotalInQueue = stats.TotalInQueue,
                    AverageResponseTime = stats.AverageResponseTime,
                    ResolvedToday = stats.ResolvedToday + 1
                };
                _agentStats[agentId] = updatedStats;
            }
        }

        public static void UpdateAssignedCount(string agentId, int change)
        {
            if (_agentStats.ContainsKey(agentId))
            {
                var stats = _agentStats[agentId];
                var updatedStats = new AgentStats
                {
                    AssignedToMe = Math.Max(0, stats.AssignedToMe + change),
                    TotalInQueue = stats.TotalInQueue,
                    AverageResponseTime = stats.AverageResponseTime,
                    ResolvedToday = stats.ResolvedToday
                };
                _agentStats[agentId] = updatedStats;
            }
        }
    }

    public struct AgentStats
    {
        public int AssignedToMe { get; set; }
        public int TotalInQueue { get; set; }
        public double AverageResponseTime { get; set; }
        public int ResolvedToday { get; set; }
    }
}