using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Telkom.CustomerDashboard
{
    public partial class MySupportQueue : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if user is logged in and has the correct role
            if (Session["Username"] == null || Session["UserRole"] == null || Session["UserRole"].ToString() != "Customer")
            {
                Response.Redirect("LandingPage.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadRealTimeQueue();

                // Auto-refresh every 30 seconds for real-time updates
                Response.AddHeader("refresh", "30");
            }
        }

        private void LoadRealTimeQueue()
        {
            List<SupportTicket> userTickets = GetUserTickets();

            // Calculate real-time queue positions
            UpdateQueuePositions(userTickets);

            // Convert to DataTable for GridView
            DataTable dt = CreateQueueDataTable(userTickets);

            gvSupportQueue.DataSource = dt;
            gvSupportQueue.DataBind();
        }

        private List<SupportTicket> GetUserTickets()
        {
            List<SupportTicket> allTickets = new List<SupportTicket>();
            string currentUsername = Session["Username"]?.ToString();

            // Get tickets from session (created via troubleshooter)
            if (Session["SupportTickets"] != null)
            {
                List<SupportTicket> sessionTickets = Session["SupportTickets"] as List<SupportTicket>;
                allTickets.AddRange(sessionTickets.Where(t => t.Username == currentUsername));
            }

            // Add some sample tickets for demonstration (simulate existing queue)
            if (allTickets.Count == 0)
            {
                allTickets.AddRange(GetSampleTickets(currentUsername));
            }

            return allTickets.OrderBy(t => t.CreatedDate).ToList();
        }

        private List<SupportTicket> GetSampleTickets(string username)
        {
            return new List<SupportTicket>
            {
                new SupportTicket
                {
                    TicketID = "TECH24092001234",
                    CustomerName = Session["FullName"]?.ToString() ?? "Customer",
                    Username = username,
                    Category = "Internet",
                    IssueType = "Slow Internet Speed",
                    Department = "Technical Support",
                    Status = "In Progress",
                    CreatedDate = DateTime.Now.AddHours(-2),
                    Priority = "High",
                    ExpectedWaitTime = 15,
                    QueuePosition = 0, // In progress = no queue position
                    AssignedAgent = "John Smith",
                    Description = "Customer experiencing slow internet speeds during peak hours"
                },
                new SupportTicket
                {
                    TicketID = "BILL24092001567",
                    CustomerName = Session["FullName"]?.ToString() ?? "Customer",
                    Username = username,
                    Category = "Billing",
                    IssueType = "Incorrect Charges",
                    Department = "Billing Department",
                    Status = "Pending Review",
                    CreatedDate = DateTime.Now.AddDays(-1),
                    Priority = "Medium",
                    ExpectedWaitTime = 25,
                    QueuePosition = 7,
                    Description = "Billing dispute regarding additional charges on monthly bill"
                }
            };
        }

        private void UpdateQueuePositions(List<SupportTicket> tickets)
        {
            Random rand = new Random();
            DateTime now = DateTime.Now;

            foreach (var ticket in tickets)
            {
                // Skip cancelled tickets
                if (ticket.Status == "Cancelled")
                    continue;

                // Simulate real-time queue movement
                switch (ticket.Status)
                {
                    case "In Queue":
                        // New tickets start with higher queue numbers
                        if (ticket.QueuePosition == 0)
                        {
                            ticket.QueuePosition = rand.Next(5, 20);
                            ticket.ExpectedWaitTime = ticket.QueuePosition * GetDepartmentMultiplier(ticket.Department);
                        }
                        else
                        {
                            // Queue position improves over time
                            int timePassed = (int)(now - ticket.CreatedDate).TotalMinutes;
                            int positionImprovement = timePassed / 5; // Move up 1 position every 5 minutes
                            ticket.QueuePosition = Math.Max(1, ticket.QueuePosition - positionImprovement);
                            ticket.ExpectedWaitTime = ticket.QueuePosition * GetDepartmentMultiplier(ticket.Department);

                            // Auto-assign agent when reaching position 1
                            if (ticket.QueuePosition <= 1)
                            {
                                ticket.Status = "In Progress";
                                ticket.AssignedAgent = GetRandomAgent(ticket.Department);
                                ticket.ExpectedWaitTime = rand.Next(10, 30);
                                ticket.QueuePosition = 0; // No queue position when in progress
                            }
                        }
                        break;

                    case "In Progress":
                        // Simulate progress towards resolution
                        int progressTime = (int)(now - ticket.CreatedDate).TotalMinutes;
                        if (progressTime > 60 && rand.NextDouble() < 0.3) // 30% chance to complete after 1 hour
                        {
                            ticket.Status = "Resolved";
                            ticket.ExpectedWaitTime = 0;
                            ticket.QueuePosition = 0;
                        }
                        else
                        {
                            ticket.ExpectedWaitTime = Math.Max(5, ticket.ExpectedWaitTime - 1);
                        }
                        break;

                    case "Pending Review":
                        // Billing and complex issues may need review
                        ticket.ExpectedWaitTime = Math.Max(10, ticket.ExpectedWaitTime - 1);
                        if (rand.NextDouble() < 0.1) // 10% chance to move to in progress
                        {
                            ticket.Status = "In Progress";
                            ticket.AssignedAgent = GetRandomAgent(ticket.Department);
                            ticket.QueuePosition = 0;
                        }
                        break;

                    case "Scheduled":
                        // For future appointments
                        if (ticket.ScheduledDate.HasValue && ticket.ScheduledDate.Value.Date == DateTime.Today)
                        {
                            ticket.Status = "Today - " + ticket.ScheduledTime;
                        }
                        break;
                }

                // Update priority based on wait time (escalation system)
                if (ticket.Status != "Resolved" && ticket.Status != "Completed" && ticket.Status != "Cancelled")
                {
                    int totalWaitTime = (int)(now - ticket.CreatedDate).TotalMinutes;
                    if (totalWaitTime > 120 && ticket.Priority == "Normal")
                    {
                        ticket.Priority = "Medium";
                    }
                    else if (totalWaitTime > 180 && ticket.Priority == "Medium")
                    {
                        ticket.Priority = "High";
                    }
                    else if (totalWaitTime > 240 && ticket.Priority == "High")
                    {
                        ticket.Priority = "Critical";
                    }
                }
            }
        }

        private int GetDepartmentMultiplier(string department)
        {
            switch (department)
            {
                case "Technical Support": return 3; // 3 minutes per position
                case "Billing Department": return 2; // 2 minutes per position  
                case "Mobile Services": return 4; // 4 minutes per position
                default: return 5; // 5 minutes per position
            }
        }

        private string GetRandomAgent(string department)
        {
            Random rand = new Random();
            switch (department)
            {
                case "Technical Support":
                    string[] techAgents = { "John Smith", "Sarah Wilson", "Mike Johnson", "Lisa Chen", "David Brown" };
                    return techAgents[rand.Next(techAgents.Length)];
                case "Billing Department":
                    string[] billingAgents = { "Mary Davis", "Robert Taylor", "Jennifer Lee", "Kevin Miller", "Amanda White" };
                    return billingAgents[rand.Next(billingAgents.Length)];
                case "Mobile Services":
                    string[] mobileAgents = { "Chris Garcia", "Rachel Martinez", "Steve Anderson", "Nicole Thomas", "James Wilson" };
                    return mobileAgents[rand.Next(mobileAgents.Length)];
                default:
                    string[] generalAgents = { "Alex Johnson", "Emma Davis", "Ryan Brown", "Sophia Lee", "Tyler Martinez" };
                    return generalAgents[rand.Next(generalAgents.Length)];
            }
        }

        private DataTable CreateQueueDataTable(List<SupportTicket> tickets)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("TicketID", typeof(string));
            dt.Columns.Add("CreatedDate", typeof(DateTime));
            dt.Columns.Add("Category", typeof(string));
            dt.Columns.Add("IssueType", typeof(string));
            dt.Columns.Add("Department", typeof(string));
            dt.Columns.Add("Priority", typeof(string));
            dt.Columns.Add("Status", typeof(string));
            dt.Columns.Add("QueuePosition", typeof(int));
            dt.Columns.Add("EstimatedWait", typeof(string));
            dt.Columns.Add("AssignedAgent", typeof(string));

            foreach (var ticket in tickets)
            {
                // Skip cancelled tickets from display
                if (ticket.Status == "Cancelled")
                    continue;

                DataRow dr = dt.NewRow();
                dr["TicketID"] = ticket.TicketID;
                dr["CreatedDate"] = ticket.CreatedDate;
                dr["Category"] = ticket.Category;
                dr["IssueType"] = ticket.IssueType;
                dr["Department"] = ticket.Department;
                dr["Priority"] = ticket.Priority;
                dr["Status"] = GetStatusDisplay(ticket);
                dr["QueuePosition"] = ticket.QueuePosition;
                dr["EstimatedWait"] = GetWaitTimeDisplay(ticket);
                dr["AssignedAgent"] = ticket.AssignedAgent ?? "Unassigned";
                dt.Rows.Add(dr);
            }

            return dt;
        }

        private string GetStatusDisplay(SupportTicket ticket)
        {
            switch (ticket.Status)
            {
                case "In Queue":
                    return $"In Queue (Position #{ticket.QueuePosition})";
                case "In Progress":
                    return "Being Handled";
                case "Resolved":
                    return "Resolved ✓";
                case "Pending Review":
                    return "Under Review";
                case "Scheduled":
                    if (ticket.ScheduledDate.HasValue)
                    {
                        if (ticket.ScheduledDate.Value.Date == DateTime.Today)
                            return $"Today at {ticket.ScheduledTime}";
                        else
                            return $"Scheduled {ticket.ScheduledDate.Value:MMM dd} at {ticket.ScheduledTime}";
                    }
                    return "Scheduled";
                default:
                    if (ticket.Status.StartsWith("Today -"))
                        return ticket.Status;
                    return ticket.Status;
            }
        }

        private string GetWaitTimeDisplay(SupportTicket ticket)
        {
            if (ticket.Status == "Resolved" || ticket.Status == "Cancelled")
                return "Completed";

            if (ticket.ExpectedWaitTime <= 0)
                return "Any moment now";

            if (ticket.ExpectedWaitTime < 60)
                return $"{ticket.ExpectedWaitTime} minutes";
            else
            {
                int hours = ticket.ExpectedWaitTime / 60;
                int minutes = ticket.ExpectedWaitTime % 60;
                return minutes > 0 ? $"{hours}h {minutes}m" : $"{hours}h";
            }
        }

        protected void gvSupportQueue_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Color coding based on priority
                string priority = DataBinder.Eval(e.Row.DataItem, "Priority").ToString();
                switch (priority)
                {
                    case "Critical":
                        e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#FFE5E5");
                        e.Row.ForeColor = System.Drawing.ColorTranslator.FromHtml("#D32F2F");
                        break;
                    case "High":
                        e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#FFF3E0");
                        e.Row.ForeColor = System.Drawing.ColorTranslator.FromHtml("#F57C00");
                        break;
                    case "Medium":
                        e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#E8F5E8");
                        e.Row.ForeColor = System.Drawing.ColorTranslator.FromHtml("#388E3C");
                        break;
                    case "Normal":
                        // Default styling
                        break;
                }

                // Bold text for active tickets
                string status = DataBinder.Eval(e.Row.DataItem, "Status").ToString();
                if (status.Contains("In Queue") || status.Contains("Being Handled"))
                {
                    e.Row.Font.Bold = true;
                }

                // Add pulsing effect for critical tickets
                if (priority == "Critical")
                {
                    e.Row.CssClass += " critical-ticket";
                }
            }
        }

        protected void btnRefreshQueue_Click(object sender, EventArgs e)
        {
            LoadRealTimeQueue();

            // Add client-side notification
            ClientScript.RegisterStartupScript(this.GetType(), "refreshComplete",
                "document.getElementById('refreshIndicator').classList.add('show'); " +
                "setTimeout(() => document.getElementById('refreshIndicator').classList.remove('show'), 2000);", true);
        }

        protected void btnCancelTicket_Click(object sender, EventArgs e)
        {
            Button btn = sender as Button;
            if (btn != null)
            {
                string ticketID = btn.CommandArgument;
                CancelTicket(ticketID);
                LoadRealTimeQueue();

                // Show confirmation message
                ClientScript.RegisterStartupScript(this.GetType(), "ticketCancelled",
                    $"alert('Ticket {ticketID} has been cancelled successfully.');", true);
            }
        }

        private void CancelTicket(string ticketID)
        {
            if (Session["SupportTickets"] != null)
            {
                List<SupportTicket> tickets = Session["SupportTickets"] as List<SupportTicket>;
                var ticketToCancel = tickets.FirstOrDefault(t => t.TicketID == ticketID);
                if (ticketToCancel != null)
                {
                    ticketToCancel.Status = "Cancelled";
                    // Log cancellation
                    System.Diagnostics.Debug.WriteLine($"Ticket {ticketID} cancelled by user {Session["Username"]}");
                }
                Session["SupportTickets"] = tickets;
            }
        }

        // Helper method for GridView template fields
        protected string GetStatusClass(string status)
        {
            if (string.IsNullOrEmpty(status)) return "queue";

            status = status.ToLower();
            if (status.Contains("queue")) return "queue";
            if (status.Contains("being") || status.Contains("progress") || status.Contains("handled")) return "progress";
            if (status.Contains("resolved") || status.Contains("completed")) return "resolved";
            if (status.Contains("scheduled") || status.Contains("today")) return "scheduled";
            if (status.Contains("review") || status.Contains("pending")) return "queue";
            return "queue";
        }

        // Method to simulate system-wide queue updates (called by timer if implemented)
        public void SimulateSystemQueueUpdates()
        {
            // This method can be called by a timer to simulate other customers' queue movements
            // affecting the overall queue positions - useful for more realistic demonstration

            if (Session["LastSystemUpdate"] == null ||
                DateTime.Now.Subtract((DateTime)Session["LastSystemUpdate"]).TotalMinutes > 5)
            {
                // Simulate system-wide queue movements every 5 minutes
                Random rand = new Random();

                if (Session["SupportTickets"] != null)
                {
                    List<SupportTicket> tickets = Session["SupportTickets"] as List<SupportTicket>;
                    foreach (var ticket in tickets.Where(t => t.Status == "In Queue"))
                    {
                        // Small chance to improve queue position due to other customers being served
                        if (rand.NextDouble() < 0.4 && ticket.QueuePosition > 1)
                        {
                            ticket.QueuePosition = Math.Max(1, ticket.QueuePosition - 1);
                            ticket.ExpectedWaitTime = ticket.QueuePosition * GetDepartmentMultiplier(ticket.Department);
                        }
                    }
                    Session["SupportTickets"] = tickets;
                }

                Session["LastSystemUpdate"] = DateTime.Now;
            }
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            // Simulate system updates before rendering
            SimulateSystemQueueUpdates();

            // Add JavaScript for additional client-side enhancements
            string script = @"
                // Add visual effects for priority tickets
                document.addEventListener('DOMContentLoaded', function() {
                    const criticalRows = document.querySelectorAll('tr[style*=""#FFE5E5""]');
                    criticalRows.forEach(row => {
                        row.style.animation = 'pulse 2s infinite';
                        row.style.border = '1px solid #D32F2F';
                    });
                    
                    // Update timestamp
                    const timeElement = document.getElementById('lastUpdateTime');
                    if (timeElement) {
                        timeElement.textContent = new Date().toLocaleTimeString();
                    }
                });
            ";

            ClientScript.RegisterStartupScript(this.GetType(), "pageEnhancements", script, true);
        }
    }

   
}