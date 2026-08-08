using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Telkom.CustomerDashboard
{
    public partial class CommunityForum : System.Web.UI.Page
    {
        // Shared static list with technician management page - this should be replaced with actual database operations
        private static readonly List<ForumPost> Posts = new List<ForumPost>();

        protected void Page_Load(object sender, EventArgs e)
        {
            this.UnobtrusiveValidationMode = System.Web.UI.UnobtrusiveValidationMode.None;

            if (!IsPostBack)
            {
                // Initialize sample data if empty (same data as technician side)
                if (Posts.Count == 0)
                {
                    InitializeSamplePosts();
                }

                LoadForumPosts();
            }
        }

        private void InitializeSamplePosts()
        {
            // This should match the data from CommunityForumMgmt to ensure consistency
            Posts.Add(new ForumPost
            {
                PostId = 1001,
                Title = "Internet connection keeps dropping every few minutes",
                Description = "Hi, I'm experiencing frequent internet disconnections. My connection drops every 10-15 minutes and I have to restart my router each time. This has been happening for the past 3 days. I work from home and this is really affecting my productivity. I've already tried the basic troubleshooting steps mentioned on your website. Please help!",
                AuthorName = "Sarah Johnson",
                Status = "Open",
                Priority = "High",
                PostType = "Issue",
                TimeAgo = "2 hours ago",
                Tags = "connectivity, router, work-from-home"
            });

            Posts.Add(new ForumPost
            {
                PostId = 1002,
                Title = "Slow upload speeds on fiber connection",
                Description = "I'm subscribed to the 100Mbps fiber package but my upload speeds are consistently below 10Mbps. Download speeds are fine at around 95Mbps. I've tested this multiple times throughout the day and the upload speed issue persists. Is there something wrong with my line?",
                AuthorName = "Mike Thompson",
                Status = "Assigned",
                Priority = "Medium",
                PostType = "Issue",
                Solution = "I've run diagnostics on your line and found a configuration issue with your upload bandwidth allocation. I'm escalating this to our fiber technical team to adjust your line profile. You should see improvements within 24-48 hours.",
                TechnicianName = "Alex Rodriguez",
                TimeAgo = "5 hours ago",
                Tags = "fiber, upload-speed, bandwidth"
            });

            Posts.Add(new ForumPost
            {
                PostId = 1003,
                Title = "Need help setting up port forwarding for gaming",
                Description = "I want to set up port forwarding for my PlayStation 5 to improve my online gaming experience. I have the Telkom HG8245H router but I'm not sure how to access the configuration page or which ports to forward. Can someone provide step-by-step instructions?",
                AuthorName = "David Wilson",
                Status = "Open",
                Priority = "Low",
                PostType = "Question",
                TimeAgo = "1 day ago",
                Tags = "gaming, port-forwarding, router-config"
            });

            Posts.Add(new ForumPost
            {
                PostId = 1004,
                Title = "Billing discrepancy - charged for services not requested",
                Description = "My latest bill shows additional charges for premium TV channels that I never subscribed to. The extra charges are R299 per month for the past 3 months. I only have basic internet service. Please review my account and reverse these incorrect charges.",
                AuthorName = "Lisa Chen",
                Status = "Resolved",
                Priority = "Medium",
                PostType = "Billing",
                Solution = "I've reviewed your account and confirmed these charges were applied in error due to a system glitch during a billing cycle update. I've reversed all incorrect charges totaling R897 and you should see the credit on your next bill. I've also added a note to prevent this from happening again.",
                TechnicianName = "Jennifer Davis",
                TimeAgo = "2 days ago",
                Tags = "billing, refund, account-error"
            });

            Posts.Add(new ForumPost
            {
                PostId = 1005,
                Title = "WiFi password reset request",
                Description = "I forgot my WiFi password and need to connect new devices. I tried the default password on the router label but it doesn't work. How can I reset or recover my WiFi password? I have access to the router physically.",
                AuthorName = "Robert Miller",
                Status = "Assigned",
                Priority = "Low",
                PostType = "Request",
                Solution = "You can reset your WiFi password by accessing your router's admin panel. Navigate to 192.168.1.1 in your browser, login with admin/admin, go to WLAN settings, and change the WPA Key. I'll send detailed instructions with screenshots to your registered email address.",
                TechnicianName = "Mark Stevens",
                TimeAgo = "6 hours ago",
                Tags = "wifi, password, router-access"
            });
        }

        private void LoadForumPosts()
        {
            // Sort posts by most recent first, but prioritize user's own posts
            string currentUser = GetCurrentUserName();
            var sortedPosts = Posts
                .OrderByDescending(p => p.AuthorName == currentUser ? 1 : 0) // User's posts first
                .ThenByDescending(p => p.PostId) // Then by newest
                .ToList();

            rptForumPosts.DataSource = sortedPosts;
            rptForumPosts.DataBind();
        }

        protected void BtnSubmitPost_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                int newId = Posts.Count > 0 ? Posts.Max(p => p.PostId) + 1 : 1;
                string currentUser = GetCurrentUserName();

                var newPost = new ForumPost
                {
                    PostId = newId,
                    Title = txtTitle.Text.Trim(),
                    Description = txtDescription.Text.Trim(),
                    AuthorName = currentUser,
                    Status = "Open",
                    Priority = ddlPriority.SelectedValue,
                    PostType = DeterminePostType(txtTitle.Text, txtDescription.Text),
                    TimeAgo = "Just now",
                    Tags = txtTags.Text.Trim()
                };

                Posts.Insert(0, newPost); // Add to beginning of list

                // Clear form
                txtTitle.Text = "";
                txtDescription.Text = "";
                txtTags.Text = "";
                ddlPriority.SelectedIndex = 1; // Reset to Medium

                LoadForumPosts();

                // Close modal and show success message
                string script = @"
                    closeNewPostModal();
                    setTimeout(function() {
                        alert('Your post has been submitted successfully! Our technical team will review it and respond soon.');
                    }, 500);
                ";
                ScriptManager.RegisterStartupScript(this, GetType(), "postSubmitted", script, true);
            }
        }

        private string DeterminePostType(string title, string description)
        {
            string combined = (title + " " + description).ToLower();

            if (combined.Contains("bill") || combined.Contains("charge") || combined.Contains("payment"))
                return "Billing";
            else if (combined.Contains("?") || combined.Contains("how to") || combined.Contains("help"))
                return "Question";
            else if (combined.Contains("request") || combined.Contains("need") || combined.Contains("want"))
                return "Request";
            else
                return "Issue";
        }

        private string GetCurrentUserName()
        {
            // In a real application, this would get the current logged-in user's name
            if (Session["CustomerName"] != null)
                return Session["CustomerName"].ToString();

            return "Current User"; // Placeholder
        }

        // Helper methods for the Repeater
        protected string TruncateText(string text, int maxLength)
        {
            if (string.IsNullOrEmpty(text) || text.Length <= maxLength)
                return text;

            return text.Substring(0, maxLength) + "...";
        }

        protected string GetStatusClass(object dataItem)
        {
            var post = (ForumPost)dataItem;
            switch (post.Status.ToLower())
            {
                case "open": return "open";
                case "assigned": return "assigned";
                case "resolved": return "resolved";
                default: return "open";
            }
        }

        protected string GetStatusText(object dataItem)
        {
            var post = (ForumPost)dataItem;
            switch (post.Status.ToLower())
            {
                case "open": return "Open";
                case "assigned": return "In Progress";
                case "resolved": return "Resolved";
                default: return "Open";
            }
        }

        protected string GetCategoryCount(string category)
        {
            // This would normally query the database for category counts
            switch (category.ToLower())
            {
                case "connectivity":
                    return Posts.Count(p => (p.Tags != null && p.Tags.Contains("connectivity")) ||
                                          (p.Tags != null && p.Tags.Contains("internet")) ||
                                          (p.Tags != null && p.Tags.Contains("router"))).ToString();
                case "billing":
                    return Posts.Count(p => p.PostType == "Billing" ||
                                          (p.Tags != null && p.Tags.Contains("billing"))).ToString();
                case "hardware":
                    return Posts.Count(p => (p.Tags != null && p.Tags.Contains("router")) ||
                                          (p.Tags != null && p.Tags.Contains("hardware"))).ToString();
                case "general":
                    return Posts.Count(p => p.PostType == "Question" ||
                                          p.PostType == "Request").ToString();
                default:
                    return "0";
            }
        }

        // Search functionality
        protected void FilterPosts(string searchTerm = "", string category = "")
        {
            var filteredPosts = Posts.AsQueryable();

            if (!string.IsNullOrEmpty(searchTerm))
            {
                searchTerm = searchTerm.ToLower();
                filteredPosts = filteredPosts.Where(p =>
                    p.Title.ToLower().Contains(searchTerm) ||
                    p.Description.ToLower().Contains(searchTerm) ||
                    p.AuthorName.ToLower().Contains(searchTerm) ||
                    (p.Tags != null && p.Tags.ToLower().Contains(searchTerm))
                );
            }

            if (!string.IsNullOrEmpty(category))
            {
                switch (category.ToLower())
                {
                    case "connectivity":
                        filteredPosts = filteredPosts.Where(p =>
                            (p.Tags != null && p.Tags.Contains("connectivity")) ||
                            (p.Tags != null && p.Tags.Contains("internet")) ||
                            (p.Tags != null && p.Tags.Contains("router")));
                        break;
                    case "billing":
                        filteredPosts = filteredPosts.Where(p =>
                            p.PostType == "Billing" ||
                            (p.Tags != null && p.Tags.Contains("billing")));
                        break;
                    case "hardware":
                        filteredPosts = filteredPosts.Where(p =>
                            (p.Tags != null && p.Tags.Contains("router")) ||
                            (p.Tags != null && p.Tags.Contains("hardware")));
                        break;
                    case "general":
                        filteredPosts = filteredPosts.Where(p =>
                            p.PostType == "Question" ||
                            p.PostType == "Request");
                        break;
                }
            }

            string currentUser = GetCurrentUserName();
            var sortedPosts = filteredPosts
                .OrderByDescending(p => p.AuthorName == currentUser ? 1 : 0)
                .ThenByDescending(p => p.PostId)
                .ToList();

            rptForumPosts.DataSource = sortedPosts;
            rptForumPosts.DataBind();
        }
    }

    // Forum Post model class (shared with technician management)
    public class ForumPost
    {
        public int PostId { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string AuthorName { get; set; }
        public string Status { get; set; } // Open, Assigned, Resolved
        public string Priority { get; set; } // High, Medium, Low
        public string PostType { get; set; } // Issue, Question, Request, Billing
        public string Solution { get; set; }
        public string TechnicianName { get; set; }
        public string TimeAgo { get; set; }
        public string Tags { get; set; }
        public DateTime CreatedDate { get; set; } = DateTime.Now;
        public DateTime LastUpdated { get; set; } = DateTime.Now;
    }
}