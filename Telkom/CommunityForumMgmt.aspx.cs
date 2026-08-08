using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;

namespace Telkom
{
    public partial class CommunityForumMgmt : System.Web.UI.Page
    {
        // Shared static list to simulate database - this should be replaced with actual database operations
        private static readonly List<ForumPost> Posts = new List<ForumPost>();

        protected void Page_Load(object sender, EventArgs e)
        {
            this.UnobtrusiveValidationMode = System.Web.UI.UnobtrusiveValidationMode.None;

            if (!IsPostBack)
            {
                // Initialize sample data if empty
                if (Posts.Count == 0)
                {
                    InitializeSamplePosts();
                }

                LoadForumPosts();
            }
        }

        private void InitializeSamplePosts()
        {
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
            var sortedPosts = Posts.OrderByDescending(p => p.PostId).ToList();
            rptForumPosts.DataSource = sortedPosts;
            rptForumPosts.DataBind();

            // Update client-side statistics
            UpdateClientStats();
        }

        private void UpdateClientStats()
        {
            int total = Posts.Count;
            int open = Posts.Count(p => p.Status == "Open");
            int assigned = Posts.Count(p => p.Status == "Assigned");
            int resolved = Posts.Count(p => p.Status == "Resolved");

            string script = $@"
                document.getElementById('totalPosts').textContent = '{total}';
                document.getElementById('openPosts').textContent = '{open}';
                document.getElementById('inProgressPosts').textContent = '{assigned}';
                document.getElementById('resolvedPosts').textContent = '{resolved}';
            ";

            ScriptManager.RegisterStartupScript(this, GetType(), "updateStats", script, true);
        }

        protected void BtnRefresh_Click(object sender, EventArgs e)
        {
            // Check if this is a reopen request
            string eventArgument = Request["__EVENTARGUMENT"];
            if (!string.IsNullOrEmpty(eventArgument) && eventArgument.StartsWith("reopen_"))
            {
                int postId = Convert.ToInt32(eventArgument.Replace("reopen_", ""));
                ReopenPost(postId);
                return;
            }

            // Regular refresh
            LoadForumPosts();
            ShowNotification("Posts refreshed successfully!", "success");
        }

        protected void BtnReply_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int postId = Convert.ToInt32(btn.CommandArgument);

            // Find the reply textbox in the same container
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;
            TextBox txtReply = (TextBox)item.FindControl("txtReply");

            if (txtReply != null && !string.IsNullOrWhiteSpace(txtReply.Text))
            {
                var post = Posts.FirstOrDefault(p => p.PostId == postId);
                if (post != null)
                {
                    post.Solution = txtReply.Text.Trim();
                    post.TechnicianName = GetCurrentTechnicianName();

                    // Update status if it's currently Open
                    if (post.Status == "Open")
                    {
                        post.Status = "Assigned";
                    }

                    txtReply.Text = ""; // Clear the textbox
                    LoadForumPosts();
                    ShowNotification("Reply sent successfully!", "success");
                }
            }
            else
            {
                ShowNotification("Please enter a reply before sending.", "warning");
            }
        }

        protected void BtnResolvePost_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int postId = Convert.ToInt32(btn.CommandArgument);

            var post = Posts.FirstOrDefault(p => p.PostId == postId);
            if (post != null)
            {
                post.Status = "Resolved";
                if (string.IsNullOrEmpty(post.TechnicianName))
                {
                    post.TechnicianName = GetCurrentTechnicianName();
                }

                // If no solution was provided, add a default one
                if (string.IsNullOrEmpty(post.Solution))
                {
                    post.Solution = "Issue has been resolved. Thank you for contacting Telkom support.";
                }

                LoadForumPosts();
                ShowNotification("Post marked as resolved successfully!", "success");
            }
        }

        protected void BtnAssignPost_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int postId = Convert.ToInt32(btn.CommandArgument);

            var post = Posts.FirstOrDefault(p => p.PostId == postId);
            if (post != null)
            {
                post.Status = "Assigned";
                post.TechnicianName = GetCurrentTechnicianName();

                LoadForumPosts();
                ShowNotification("Post assigned to you successfully!", "success");
            }
        }

        protected void BtnReopenPost_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int postId = Convert.ToInt32(btn.CommandArgument);

            var post = Posts.FirstOrDefault(p => p.PostId == postId);
            if (post != null && post.Status == "Resolved")
            {
                post.Status = "Open";
                post.Solution = null;
                post.TechnicianName = null;

                LoadForumPosts();
                ShowNotification("Post reopened successfully!", "success");
            }
        }

        private void ReopenPost(int postId)
        {
            var post = Posts.FirstOrDefault(p => p.PostId == postId);
            if (post != null && post.Status == "Resolved")
            {
                post.Status = "Open";
                post.Solution = null;
                post.TechnicianName = null;

                LoadForumPosts();
                ShowNotification("Post reopened successfully!", "success");
            }
        }

        private string GetCurrentTechnicianName()
        {
            // In a real application, this would get the current logged-in technician's name
            if (Session["TechnicianName"] != null)
                return Session["TechnicianName"].ToString();

            return "System Administrator";
        }

        private void ShowNotification(string message, string type)
        {
            string script = $"showNotification('{message.Replace("'", "\\'")}', '{type}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "showNotification", script, true);
        }

        // Helper methods for the Repeater binding
        protected bool CanReopen(object dataItem)
        {
            var post = (ForumPost)dataItem;
            return post.Status == "Resolved";
        }

        protected bool CanResolve(object dataItem)
        {
            var post = (ForumPost)dataItem;
            return post.Status == "Open" || post.Status == "Assigned";
        }

        protected bool CanAssign(object dataItem)
        {
            var post = (ForumPost)dataItem;
            return post.Status == "Open";
        }

        protected string GetStatusClass(object dataItem)
        {
            var post = (ForumPost)dataItem;
            switch (post.Status.ToLower())
            {
                case "open": return "open";
                case "assigned": return "in-progress";
                case "resolved": return "resolved";
                default: return "";
            }
        }

        protected bool HasSolution(object dataItem)
        {
            var post = (ForumPost)dataItem;
            return !string.IsNullOrEmpty(post.Solution);
        }

        protected string GetTechnicianName(object dataItem)
        {
            var post = (ForumPost)dataItem;
            return post.TechnicianName ?? "Unassigned";
        }

        protected string GetSafeValue(object value)
        {
            return value != null ? value.ToString() : "";
        }

        // Web method for AJAX calls (optional - for future enhancements)
        [WebMethod]
        public static string GetPostStats()
        {
            int total = Posts.Count;
            int open = Posts.Count(p => p.Status == "Open");
            int assigned = Posts.Count(p => p.Status == "Assigned");
            int resolved = Posts.Count(p => p.Status == "Resolved");

            return $"{{\"total\":{total},\"open\":{open},\"assigned\":{assigned},\"resolved\":{resolved}}}";
        }

        [WebMethod]
        public static bool UpdatePostPriority(int postId, string priority)
        {
            var post = Posts.FirstOrDefault(p => p.PostId == postId);
            if (post != null)
            {
                post.Priority = priority;
                return true;
            }
            return false;
        }

        [WebMethod]
        public static List<ForumPost> SearchPosts(string searchTerm)
        {
            if (string.IsNullOrWhiteSpace(searchTerm))
                return Posts.OrderByDescending(p => p.PostId).ToList();

            searchTerm = searchTerm.ToLower();
            return Posts.Where(p =>
                p.Title.ToLower().Contains(searchTerm) ||
                p.Description.ToLower().Contains(searchTerm) ||
                p.AuthorName.ToLower().Contains(searchTerm)
            ).OrderByDescending(p => p.PostId).ToList();
        }
    }

    // Forum Post model class
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