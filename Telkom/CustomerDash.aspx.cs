using System;
using System.Collections.Generic;
using System.Web.UI;

namespace Telkom.CustomerDashboard
{
    public partial class CustomerDash : System.Web.UI.Page
    {

        public class Notification
        {
            public string Title { get; set; }
            public string Message { get; set; }
            public DateTime Time { get; set; }
        }

        public class ForumPost
        {
            public string Title { get; set; }
            public string Message { get; set; }
            public DateTime Time { get; set; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null || Session["UserRole"] == null || Session["UserRole"].ToString() != "Customer")
            {
                Response.Redirect("LandingPage.aspx");
                return;
            }

            if (!IsPostBack)
            {
                // Get full name from session
                string fullName = Session["FullName"] != null ? Session["FullName"].ToString() : "User";

                //// Set first name
                //string firstName = fullName.Split(' ')[0];
                //lblUserName.Text = firstName;

                //// Set initials
                //lblUserInitials.Text = GetInitials(fullName);

                // Load notifications and forum updates
                LoadNotifications();
                LoadCommunityForum();
            }
        }

        private string GetInitials(string fullName)
        {
            string[] parts = fullName.Split(' ');
            string initials = "";
            foreach (string part in parts)
            {
                if (!string.IsNullOrEmpty(part))
                    initials += part[0];
            }
            return initials.ToUpper();
        }

        private void LoadNotifications()
        {
            // Simulated real-time alerts
            List<Notification> notifications = new List<Notification>()
            {
                new Notification
                {
                    Title = "Network Outage",
                    Message = "Your area is experiencing a network outage. Our team is on it!",
                    Time = DateTime.Now.AddMinutes(-45)
                },
                new Notification
                {
                    Title = "Billing Reminder",
                    Message = "Your invoice #1023 is due in 3 days.",
                    Time = DateTime.Now.AddHours(-2)
                },
                new Notification
                {
                    Title = "Support Slot Confirmed",
                    Message = "Your Ghost Queue slot is booked for tomorrow at 2:00 PM.",
                    Time = DateTime.Now.AddHours(-4)
                }
            };

            // Bind to activity feed
            activityFeed.InnerHtml = "";
            foreach (var notif in notifications)
            {
                activityFeed.InnerHtml += $@"
                    <li class='activity-item'>
                        <div class='activity-icon'>
                            <i class='fas fa-bell'></i>
                        </div>
                        <div class='activity-content'>
                            <h4>{notif.Title}</h4>
                            <p>{notif.Message}</p>
                            <span class='activity-time'>{notif.Time:MMMM dd, hh:mm tt}</span>
                        </div>
                    </li>";
            }

            // Update badge count
           // notificationBadge.InnerText = notifications.Count.ToString();

            // Show or hide alert banner based on notifications
            alertBanner.Style["display"] = notifications.Count > 0 ? "flex" : "none";
        }

        private void LoadCommunityForum()
        {
            // Simulated community forum updates (no database)
            List<ForumPost> posts = new List<ForumPost>()
            {
                new ForumPost
                {
                    Title = "WiFi issues in Pretoria",
                    Message = "Anyone else experiencing slow WiFi? Telkom technician responded.",
                    Time = DateTime.Now.AddHours(-5)
                },
                new ForumPost
                {
                    Title = "Billing Question",
                    Message = "How do I check my usage limit? Official response inside.",
                    Time = DateTime.Now.AddDays(-1)
                }
            };

            // Add forum posts as additional activity items
            foreach (var post in posts)
            {
                activityFeed.InnerHtml += $@"
                    <li class='activity-item'>
                        <div class='activity-icon'>
                            <i class='fas fa-users'></i>
                        </div>
                        <div class='activity-content'>
                            <h4>{post.Title}</h4>
                            <p>{post.Message}</p>
                            <span class='activity-time'>{post.Time:MMMM dd, hh:mm tt}</span>
                        </div>
                    </li>";
            }
        }

        // Optional: Add logout functionality
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("LandingPage.aspx");
        }

    }
}