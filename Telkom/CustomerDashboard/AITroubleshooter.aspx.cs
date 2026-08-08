using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Linq;

namespace Telkom.CustomerDashboard
{
    public partial class AITroubleshooter : System.Web.UI.Page
    {
        // Enhanced chatbot tracking - Fixed with missing properties
        private class ChatSession
        {
            public int QuestionCount { get; set; } = 0;
            public bool HasAskedSatisfaction { get; set; } = false;
            public bool IsWaitingForSatisfactionResponse { get; set; } = false;
            public List<string> TopicsDiscussed { get; set; } = new List<string>();
            public DateTime LastInteraction { get; set; } = DateTime.Now;
            // Added missing properties that were causing compilation errors
            public bool HasBooked { get; set; } = false;
            public string BookingReference { get; set; } = string.Empty;
        }

        // Department mappings - made readonly as suggested
        private readonly Dictionary<string, string> DepartmentMappings = new Dictionary<string, string>
        {
            {"Internet", "Technical Support"},
            {"WiFi", "Technical Support"},
            {"Mobile", "Mobile Services"},
            {"Billing", "Billing Department"},
            {"General", "Customer Service"}
        };

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
                pnlTroubleshooter.Visible = false;
                pnlTechnicianBooking.Visible = false;

                if (Session["ChatMessages"] == null)
                    Session["ChatMessages"] = new List<string>();

                if (Session["ChatSession"] == null)
                    Session["ChatSession"] = new ChatSession();

                // Initialize support tickets if not exists
                if (Session["SupportTickets"] == null)
                    Session["SupportTickets"] = new List<SupportTicket>();

                string fullName = Session["FullName"] != null ? Session["FullName"].ToString() : "User";
                // Removed unused variable assignment
                // string firstName = fullName.Split(' ')[0];
            }
        }

        // ================== Enhanced Chatbot Implementation ==================
        protected void btnChatSend_Click(object sender, EventArgs e)
        {
            string userMessage = txtChatMessage.Text.Trim();
            if (!string.IsNullOrEmpty(userMessage))
            {
                ChatSession chatSession = Session["ChatSession"] as ChatSession ?? new ChatSession();
                List<string> chatMessages = Session["ChatMessages"] as List<string>;
                string timestamp = DateTime.Now.ToString("HH:mm");

                // Add user message
                chatMessages.Add($"USER|{timestamp}: {userMessage}");

                string botResponse;

                // Check if waiting for escalation response
                if (chatSession.IsWaitingForSatisfactionResponse)
                {
                    botResponse = HandleEscalationResponse(userMessage, chatSession);
                }
                else
                {
                    // Increment question count for new questions
                    chatSession.QuestionCount++;
                    chatSession.LastInteraction = DateTime.Now;

                    // Get enhanced bot response
                    botResponse = GetEnhancedBotResponse(userMessage, chatSession);

                    // After 3 questions, ask for escalation
                    if (chatSession.QuestionCount >= 3 && !chatSession.HasAskedSatisfaction)
                    {
                        botResponse += "\n\n---\n\nI've provided technical solutions for your queries. Would you like me to book a technician visit to your location for hands-on assistance? (R600 - Standard service with 24-48 hour arrival window)";
                        chatSession.HasAskedSatisfaction = true;
                        chatSession.IsWaitingForSatisfactionResponse = true;
                    }
                }

                // Add bot response
                chatMessages.Add($"BOT|{timestamp}: {botResponse}");

                // Update session
                Session["ChatMessages"] = chatMessages;
                Session["ChatSession"] = chatSession;
                txtChatMessage.Text = string.Empty;
            }
        }

        private string HandleEscalationResponse(string userMessage, ChatSession chatSession)
        {
            string message = userMessage.ToLower();
            chatSession.IsWaitingForSatisfactionResponse = false;

            if (message.Contains("yes") || message.Contains("escalate") || message.Contains("human") ||
                message.Contains("support") || message.Contains("ticket") || message.Contains("sure") ||
                message.Contains("okay") || message.Contains("ok"))
            {
                // Create support ticket like the troubleshooter does
                return CreateChatbotSupportTicket(chatSession);
            }
            else if (message.Contains("no") || message.Contains("not now") || message.Contains("maybe later") ||
                     message.Contains("don't need") || message.Contains("not necessary"))
            {
                return "No problem! I'm here whenever you need technical support. You can always:\n\n" +
                       "• Ask me more troubleshooting questions\n" +
                       "• Use the 'Book Priority Technician' button above for home visits\n" +
                       "• Call our support line at 0800 TELKOM (835566)\n\n" +
                       "Is there anything else I can help you with today?";
            }
            else
            {
                // User didn't give clear yes/no, ask again
                chatSession.IsWaitingForSatisfactionResponse = true;
                return "I need a clear response to help you properly. Would you like me to escalate you to a human specialist?\n\n" +
                       "• Type 'Yes' to create a priority support ticket\n" +
                       "• Type 'No' if you want to continue with AI assistance\n\n" +
                       "The support ticket will include all our conversation details and place you in the appropriate specialist queue.";
            }
        }

        private string CreateChatbotSupportTicket(ChatSession chatSession)
        {
            try
            {
                // Determine department based on topics discussed
                string department = DetermineBestDepartment(chatSession.TopicsDiscussed);
                string queueNumber = GenerateQueueNumber(department);
                string customerName = Session["FullName"]?.ToString() ?? "Customer";
                string username = Session["Username"]?.ToString() ?? "User";

                // Create comprehensive support ticket (same as troubleshooter escalation)
                SupportTicket ticket = new SupportTicket
                {
                    TicketID = queueNumber,
                    CustomerName = customerName,
                    Username = username,
                    Category = GetPrimaryCategory(chatSession.TopicsDiscussed),
                    IssueType = "Chatbot Escalation - Multiple Issues",
                    Department = department,
                    Status = "High Priority Queue",
                    CreatedDate = DateTime.Now,
                    ExpectedWaitTime = CalculateWaitTime(department) - 10, // Priority reduction for chatbot escalation
                    Priority = "High",
                    Description = GenerateTicketDescription(chatSession),
                    Notes = "Customer interacted with AI chat assistant for " + chatSession.QuestionCount + " questions. " +
                           "Comprehensive solutions provided but customer requested human specialist assistance. " +
                           "Full chat history and troubleshooting context included.",
                    IsEscalated = true,
                    AttemptsCount = chatSession.QuestionCount
                };

                // Add to support tickets session
                List<SupportTicket> tickets = Session["SupportTickets"] as List<SupportTicket> ?? new List<SupportTicket>();
                tickets.Add(ticket);
                Session["SupportTickets"] = tickets;

                // Mark chatbot session as escalated
                chatSession.HasBooked = true;
                chatSession.BookingReference = queueNumber;

                // Generate confirmation response
                return GenerateSupportTicketConfirmation(ticket);
            }
            catch (Exception)
            {
                return "I apologize, but there was an issue creating your support ticket. Please use the 'Start AI Troubleshooter' button above and click 'Escalate to Human Expert', or call our support line at 0800 TELKOM (835566) for immediate assistance.";
            }
        }

        private string GenerateSupportTicketConfirmation(SupportTicket ticket)
        {
            return $"✅ **SUPPORT TICKET CREATED SUCCESSFULLY**\n\n" +
                   $"**TICKET DETAILS:**\n" +
                   $"• Ticket Number: {ticket.TicketID}\n" +
                   $"• Department: {ticket.Department}\n" +
                   $"• Priority Level: {ticket.Priority}\n" +
                   $"• Queue Status: {ticket.Status}\n" +
                   $"• Expected Wait Time: {ticket.ExpectedWaitTime} minutes\n\n" +
                   $"**CUSTOMER INFORMATION:**\n" +
                   $"• Name: {ticket.CustomerName}\n" +
                   $"• Username: {ticket.Username}\n" +
                   $"• Issue Category: {ticket.Category}\n" +
                   $"• Created: {ticket.CreatedDate:dd MMM yyyy HH:mm}\n\n" +
                   $"**WHAT HAPPENS NEXT:**\n" +
                   $"1. You're placed in the high priority queue\n" +
                   $"2. A specialist will review your complete chat history\n" +
                   $"3. All troubleshooting attempts are included in your ticket\n" +
                   $"4. You'll receive a call within {ticket.ExpectedWaitTime} minutes\n" +
                   $"5. Live queue updates available in 'My Support Queue'\n\n" +
                   $"**SPECIALIST BENEFITS:**\n" +
                   $"• Skip general support queue\n" +
                   $"• Full conversation context provided\n" +
                   $"• Priority routing to correct department\n" +
                   $"• Faster resolution with background knowledge\n\n" +
                   $"Your ticket is confirmed! You can track progress in 'My Support Queue' or I can provide updates here.";
        }

        private string GenerateQueueNumber(string department)
        {
            string prefix;
            switch (department)
            {
                case "Technical Support": prefix = "TECH"; break;
                case "Billing Department": prefix = "BILL"; break;
                case "Mobile Services": prefix = "MOB"; break;
                default: prefix = "CS"; break;
            }

            Random rand = new Random();
            int number = rand.Next(1000, 9999);
            return $"{prefix}{DateTime.Now:yyMMdd}{number}";
        }

        private void TrackDiscussedTopic(string message, ChatSession chatSession)
        {
            if (message.Contains("internet") || message.Contains("connection"))
                AddTopic(chatSession.TopicsDiscussed, "Internet");
            if (message.Contains("wifi") || message.Contains("wireless"))
                AddTopic(chatSession.TopicsDiscussed, "WiFi");
            if (message.Contains("mobile") || message.Contains("data") || message.Contains("cellular"))
                AddTopic(chatSession.TopicsDiscussed, "Mobile");
            if (message.Contains("bill") || message.Contains("payment") || message.Contains("charge"))
                AddTopic(chatSession.TopicsDiscussed, "Billing");
            if (message.Contains("router") || message.Contains("modem") || message.Contains("hardware"))
                AddTopic(chatSession.TopicsDiscussed, "Hardware");
        }

        private void AddTopic(List<string> topics, string topic)
        {
            if (!topics.Contains(topic))
                topics.Add(topic);
        }

        private string DetermineBestDepartment(List<string> topics)
        {
            if (topics.Contains("Billing")) return "Billing Department";
            if (topics.Contains("Mobile")) return "Mobile Services";
            if (topics.Contains("Internet") || topics.Contains("WiFi") || topics.Contains("Hardware"))
                return "Technical Support";
            return "Customer Service";
        }

        private string GetPrimaryCategory(List<string> topics)
        {
            if (topics.Count == 0) return "General";
            return topics[0];
        }

        private string GenerateTicketDescription(ChatSession chatSession)
        {
            string topics = string.Join(", ", chatSession.TopicsDiscussed);
            return $"Customer escalated after {chatSession.QuestionCount} AI troubleshooting interactions. " +
                   $"Topics discussed: {topics}. " +
                   $"Comprehensive solutions provided but issue persists. " +
                   $"Customer requires personalized specialist assistance. " +
                   $"Chat session duration: {DateTime.Now.Subtract(chatSession.LastInteraction).TotalMinutes} minutes.";
        }

        private int CalculateWaitTime(string department)
        {
            Random rand = new Random();
            switch (department)
            {
                case "Technical Support": return rand.Next(15, 45);
                case "Billing Department": return rand.Next(10, 30);
                case "Mobile Services": return rand.Next(20, 40);
                default: return rand.Next(25, 50);
            }
        }

        private string GetEnhancedBotResponse(string message, ChatSession chatSession)
        {
            message = message.ToLower();
            string response = "";

            // Track topics for intelligent routing
            TrackDiscussedTopic(message, chatSession);

            // If user has already booked, provide booking-related responses
            if (chatSession.HasBooked && !string.IsNullOrEmpty(chatSession.BookingReference))
            {
                if (message.Contains("status") || message.Contains("booking") || message.Contains("technician"))
                {
                    return $"Your technician booking {chatSession.BookingReference} is confirmed. The technician will arrive within 24-48 hours. You'll receive an SMS confirmation and a call 30 minutes before arrival.\n\n" +
                           "Is there anything else I can help you with while we wait for your technician visit?";
                }
            }

            // Internet connectivity issues
            if (message.Contains("internet") && (message.Contains("slow") || message.Contains("speed")))
            {
                response = "🔧 **SLOW INTERNET COMPREHENSIVE SOLUTION**\n\n" +
                          "**IMMEDIATE DIAGNOSTICS:**\n" +
                          "1. Speed test at fast.com or speedtest.net - compare to your package\n" +
                          "2. Router restart: Unplug 30 seconds, reconnect, wait 3 minutes\n" +
                          "3. Ethernet test: Connect cable directly to router\n\n" +
                          "**OPTIMIZATION STEPS:**\n" +
                          "• Change DNS to 8.8.8.8 and 8.8.4.4\n" +
                          "• Check for background downloads/updates\n" +
                          "• Run malware scan - cryptominers slow connections\n" +
                          "• Clear browser cache and cookies\n\n" +
                          "**EXPECTED SPEEDS:**\n" +
                          "• Fiber: 85-95% of advertised speed\n" +
                          "• ADSL: 60-80% depending on line quality\n" +
                          "• Peak hours (7-10pm): 20-30% reduction normal\n\n" +
                          "Try these steps and let me know which ones helped!";
            }
            else if (message.Contains("internet") && (message.Contains("down") || message.Contains("not working") || message.Contains("no connection")))
            {
                response = "🚨 **NO INTERNET CONNECTION - EMERGENCY PROTOCOL**\n\n" +
                          "**CRITICAL CHECKS:**\n" +
                          "1. Power lights: Router should show solid power + internet lights\n" +
                          "2. Cable check: Ensure ethernet and power cables secure\n" +
                          "3. Other devices: Test phone, laptop, tablet on same network\n\n" +
                          "**RESTART SEQUENCE:**\n" +
                          "1. Unplug router for 30 seconds\n" +
                          "2. Plug back in, wait 2 minutes for full boot\n" +
                          "3. Test connection on multiple devices\n\n" +
                          "**BYPASS TEST:**\n" +
                          "• Connect laptop directly to router with ethernet cable\n" +
                          "• If this works, WiFi issue; if not, internet service issue\n\n" +
                          "Red lights on router = service fault, needs technician visit.";
            }
            // WiFi specific issues
            else if (message.Contains("wifi") && (message.Contains("disconnect") || message.Contains("dropping") || message.Contains("keeps cutting")))
            {
                response = "📶 **WIFI DISCONNECTION FIX PROTOCOL**\n\n" +
                          "**DEVICE POWER MANAGEMENT:**\n" +
                          "1. Settings → WiFi → Advanced → Keep WiFi on during sleep\n" +
                          "2. Disable USB power management in Device Manager\n" +
                          "3. Network adapter → Uncheck 'allow computer to turn off'\n\n" +
                          "**NETWORK STABILITY:**\n" +
                          "• Static IP: Router settings → DHCP → Reserve IP for your device\n" +
                          "• Change WiFi channel to 1, 6, or 11 for 2.4GHz\n" +
                          "• Switch to 5GHz band if available\n\n" +
                          "**DRIVER SOLUTIONS:**\n" +
                          "• Update network drivers through Device Manager\n" +
                          "• If issues started recently, rollback driver\n\n" +
                          "Which device type are you using? (iPhone/Android/Windows/Mac)";
            }
            // Mobile and data issues
            else if (message.Contains("mobile") || message.Contains("data") || message.Contains("cellular"))
            {
                response = "📱 **MOBILE DATA COMPREHENSIVE TROUBLESHOOTING**\n\n" +
                          "**IMMEDIATE CHECKS:**\n" +
                          "1. Data balance: Dial *136# to check remaining data\n" +
                          "2. Airplane mode: Turn on for 30 seconds, then off\n" +
                          "3. Network selection: Settings → Mobile → Manual → TelkomX\n\n" +
                          "**APN CONFIGURATION:**\n" +
                          "Settings → Mobile Networks → Access Point Names\n" +
                          "• Name: TelkomX Internet\n" +
                          "• APN: internet\n" +
                          "• Username: (leave blank)\n" +
                          "• Password: (leave blank)\n\n" +
                          "Are you experiencing slow speeds or no data connection at all?";
            }
            // Default response for other queries
            else
            {
                response = "🤖 **I'M HERE TO SOLVE YOUR TECHNICAL CHALLENGES**\n\n" +
                          "I specialize in comprehensive troubleshooting. I can help with:\n\n" +
                          "**📡 CONNECTION ISSUES:** \"My internet is slow\" or \"WiFi keeps disconnecting\"\n" +
                          "**📱 MOBILE PROBLEMS:** \"Mobile data not working\" or \"Call quality poor\"\n" +
                          "**🔧 HARDWARE ISSUES:** \"Router lights flashing\" or \"No signal\"\n" +
                          "**💳 BILLING QUERIES:** \"High bill\" or \"Payment problems\"\n\n" +
                          "What specific technical issue can I help you solve right now?";
            }

            return response;
        }

        // ================== Existing methods for other functionality ==================

        protected void btnStartTroubleshooter_Click(object sender, EventArgs e)
        {
            pnlTroubleshooter.Visible = true;
            lblQuestion.Text = "Please select the issue category:";
            lblSolution.Text = "";
            btnEscalate.Visible = false;
        }

        protected void btnShowTechnicianBooking_Click(object sender, EventArgs e)
        {
            pnlTechnicianBooking.Visible = true;
            LoadCustomerDetails();
        }

        protected void btnClose_Click(object sender, EventArgs e)
        {
            pnlTroubleshooter.Visible = false;
        }

        private void LoadCustomerDetails()
        {
            txtTechAddress.Text = "123 Main Street, Port Elizabeth, Eastern Cape, 6001";
            txtTechBillingID.Text = "BILL" + Session["Username"]?.ToString()?.GetHashCode().ToString().Substring(0, 6);
            txtTechPhone.Text = "+27 41 555 0123";
            txtTechEmail.Text = Session["Username"]?.ToString() + "@example.com";
        }

        // ================== Additional Methods for Complete Implementation ==================

        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlSubCategory.Items.Clear();
            ddlSubCategory.Items.Add(new ListItem("Select Specific Issue", ""));
            lblSolution.Text = "";
            btnEscalate.Visible = false;

            if (ddlCategory.SelectedValue != "")
            {
                switch (ddlCategory.SelectedValue)
                {
                    case "Internet":
                        ddlSubCategory.Items.Add(new ListItem("Slow Internet Speed", "Slow Internet"));
                        ddlSubCategory.Items.Add(new ListItem("No Internet Connection", "No Internet"));
                        ddlSubCategory.Items.Add(new ListItem("Intermittent Connection", "Intermittent Connection"));
                        ddlSubCategory.Items.Add(new ListItem("Router/Modem Issues", "Router Issues"));
                        break;
                    case "WiFi":
                        ddlSubCategory.Items.Add(new ListItem("WiFi Setup Problems", "WiFi Setup Issue"));
                        ddlSubCategory.Items.Add(new ListItem("WiFi Password Issues", "WiFi Password Problem"));
                        ddlSubCategory.Items.Add(new ListItem("Weak WiFi Signal", "WiFi Signal Weak"));
                        ddlSubCategory.Items.Add(new ListItem("WiFi Keeps Disconnecting", "WiFi Disconnecting"));
                        break;
                    case "Billing":
                        ddlSubCategory.Items.Add(new ListItem("Incorrect Charges", "Incorrect Bill"));
                        ddlSubCategory.Items.Add(new ListItem("Payment Problems", "Payment Issues"));
                        ddlSubCategory.Items.Add(new ListItem("Bill Enquiry", "Bill Enquiry"));
                        ddlSubCategory.Items.Add(new ListItem("Refund Request", "Refund Request"));
                        break;
                    case "Mobile":
                        ddlSubCategory.Items.Add(new ListItem("Mobile Data Not Working", "Mobile Data Issue"));
                        ddlSubCategory.Items.Add(new ListItem("Call Quality Issues", "Call Issues"));
                        ddlSubCategory.Items.Add(new ListItem("SMS/MMS Problems", "SMS Problems"));
                        ddlSubCategory.Items.Add(new ListItem("Network Coverage", "Coverage Issues"));
                        break;
                }
            }
        }

        protected void ddlSubCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblSolution.Text = "";
            btnEscalate.Visible = false;

            if (ddlSubCategory.SelectedValue != "")
            {
                string solution = GetComprehensiveAISolution(ddlSubCategory.SelectedValue);
                lblSolution.Text = solution;
                btnEscalate.Visible = true;
            }
        }

        private string GetComprehensiveAISolution(string issueType)
        {
            switch (issueType)
            {
                case "Slow Internet":
                    return @"AI COMPREHENSIVE SOLUTION for Slow Internet:

PRIMARY DIAGNOSTIC STEPS:
1. Speed Test: Visit speedtest.net - Expected: 80% of your package speed
2. Router Restart: Unplug 30 seconds, plug back in, wait 2 minutes
3. Ethernet Test: Connect directly via cable to bypass WiFi issues
4. Background Check: Close streaming, downloads, updates, cloud sync

ALTERNATIVE SOLUTIONS:
• DNS Change: Switch to 8.8.8.8 or 1.1.1.1 for faster resolution
• QoS Settings: Access router admin (192.168.1.1) → QoS → Prioritize your device
• Channel Optimization: Change WiFi channel (1, 6, 11 for 2.4GHz | 36, 40, 44 for 5GHz)
• MTU Adjustment: Try MTU 1472 or 1500 in network adapter settings

REALISTIC EXPECTATIONS:
• Fiber: 90-95% of advertised speed
• ADSL: 60-80% depending on line distance
• Peak hours (7-10pm): Expect 20-30% slower speeds";

                case "No Internet":
                    return @"AI COMPREHENSIVE SOLUTION for No Internet Connection:

IMMEDIATE CHECKS:
1. Device Test: Try different device - phone, laptop, tablet
2. Cable Inspection: Power, ethernet, coax/fiber - look for damage
3. Light Status: Power (solid), Internet (green), WiFi (solid) - red = problem
4. Service Outage: Check TelkomX website/app for area outages

SYSTEMATIC RESTART SEQUENCE:
1. Modem OFF → Wait 30 seconds → Modem ON → Wait 2 minutes
2. Router OFF → Wait 30 seconds → Router ON → Wait 3 minutes
3. Device restart → Test connection

If no lights on modem or all steps fail, likely infrastructure fault - escalate immediately.";

                case "WiFi Disconnecting":
                    return @"AI COMPREHENSIVE SOLUTION for WiFi Keeps Disconnecting:

POWER MANAGEMENT FIXES:
1. Device Power Saving: Settings → WiFi → Advanced → Keep WiFi on during sleep
2. Network Adapter: Device Manager → Network → Properties → Power → Uncheck power saving
3. Router Power Supply: Check adapter provides correct voltage

NETWORK STABILITY:
• Static IP Assignment: Router → DHCP → Reserve IP for your device
• DNS Servers: Change to 8.8.8.8 and 1.1.1.1 for stable connections
• Channel Width: Change from Auto to 20MHz for stability over speed

If disconnections happen every few minutes consistently, likely router hardware failure.";

                case "Mobile Data Issue":
                    return @"AI COMPREHENSIVE SOLUTION for Mobile Data Issues:

IMMEDIATE DIAGNOSTICS:
1. Data Balance Check: Dial *136# - may be depleted/throttled
2. Airplane Mode Reset: Turn on 30 seconds, turn off, wait 2 minutes
3. Network Selection: Settings → Mobile → Network → Manual → Select TelkomX

APN CONFIGURATION:
• Settings → Mobile → Access Point Names
• TelkomX APN: internet
• Username: blank, Password: blank

REALISTIC SPEEDS:
• 4G LTE: 5-50 Mbps depending on location/congestion
• 3G: 0.5-5 Mbps
• Indoor: 30-50% slower than outdoor";

                default:
                    return "AI SOLUTION: Please escalate to appropriate support team for personalized assistance.";
            }
        }

        protected void btnEscalate_Click(object sender, EventArgs e)
        {
            if (ddlCategory.SelectedValue == "" || ddlSubCategory.SelectedValue == "")
            {
                lblSolution.Text = "Please select both category and specific issue before escalating.";
                return;
            }

            string category = ddlCategory.SelectedValue;
            string issue = ddlSubCategory.SelectedValue;
            string department = DepartmentMappings.ContainsKey(category) ? DepartmentMappings[category] : "Customer Service";
            string queueNumber = GenerateQueueNumber(department);

            SupportTicket ticket = new SupportTicket
            {
                TicketID = queueNumber,
                CustomerName = Session["FullName"]?.ToString() ?? "Customer",
                Username = Session["Username"]?.ToString(),
                Category = category,
                IssueType = issue,
                Department = department,
                Status = "In Queue",
                CreatedDate = DateTime.Now,
                ExpectedWaitTime = CalculateWaitTime(department),
                Priority = GetPriority(issue),
                Description = $"Escalated from AI Troubleshooter - {issue}. AI Solution attempted but issue persists."
            };

            List<SupportTicket> tickets = Session["SupportTickets"] as List<SupportTicket> ?? new List<SupportTicket>();
            tickets.Add(ticket);
            Session["SupportTickets"] = tickets;

            lblSolution.Text = $"Issue escalated successfully!\n\n" +
                              $"Ticket Number: {queueNumber}\n" +
                              $"Department: {department}\n" +
                              $"Expected Wait Time: {ticket.ExpectedWaitTime} minutes\n\n" +
                              $"You will be redirected to track your ticket...";

            Response.AddHeader("REFRESH", "3;URL=MySupportQueue.aspx");
        }

        protected void chkTopPriority_CheckedChanged(object sender, EventArgs e)
        {
            UpdatePricingDisplay();
        }

        protected void ddlTechProblem_SelectedIndexChanged(object sender, EventArgs e)
        {
            UpdatePricingDisplay();
        }

        private void UpdatePricingDisplay()
        {
            decimal basePrice = 600.00m;
            decimal priorityFee = chkTopPriority.Checked ? 50.00m : 0.00m;
            decimal totalPrice = basePrice + priorityFee;

            lblBasePriceAmount.Text = "R" + basePrice.ToString("F2");
            lblPriorityFeeAmount.Text = chkTopPriority.Checked ? "R" + priorityFee.ToString("F2") : "R0.00";
            lblTotalPriceAmount.Text = "R" + totalPrice.ToString("F2");

            if (chkTopPriority.Checked)
            {
                lblEstimatedArrival.Text = "Within 2-4 hours";
                lblEstimatedArrival.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                lblEstimatedArrival.Text = "Within 24-48 hours";
                lblEstimatedArrival.ForeColor = System.Drawing.Color.Blue;
            }
        }

        protected void btnBookTechnician_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtTechCustomerName.Text.Trim()) ||
                string.IsNullOrEmpty(txtTechAddress.Text.Trim()) ||
                string.IsNullOrEmpty(txtTechPhone.Text.Trim()) ||
                ddlTechProblem.SelectedValue == "" ||
                string.IsNullOrEmpty(txtTechDate.Text) ||
                string.IsNullOrEmpty(txtTechTime.Text))
            {
                lblTechBookingMessage.ForeColor = System.Drawing.Color.Red;
                lblTechBookingMessage.Text = "Please fill in all required fields before booking.";
                return;
            }

            string bookingNumber = GenerateTechnicianBookingNumber();
            decimal basePrice = 600.00m;
            decimal priorityFee = chkTopPriority.Checked ? 50.00m : 0.00m;
            decimal totalPrice = basePrice + priorityFee;

            // Create receipt content
            string receipt = GenerateReceiptContent(
                bookingNumber,
                txtTechCustomerName.Text.Trim(),
                txtTechBillingID.Text.Trim(),
                txtTechAddress.Text.Trim(),
                txtTechPhone.Text.Trim(),
                txtTechEmail.Text.Trim(),
                ddlTechProblem.SelectedItem.Text,
                txtTechProblemDetails.Text.Trim(),
                txtTechDate.Text,
                txtTechTime.Text,
                chkTopPriority.Checked,
                basePrice,
                priorityFee,
                totalPrice
            );

            // Store receipt in session
            Session["LastTechnicianReceipt"] = receipt;

            lblTechBookingMessage.ForeColor = System.Drawing.Color.Green;
            lblTechBookingMessage.Text = "Technician booked successfully! Generating receipt...";

            Response.AddHeader("REFRESH", "2;URL=TechnicianReceipt.aspx");
        }

        private string GenerateReceiptContent(string bookingNumber, string customerName, string billingId,
            string address, string phone, string email, string problemType, string problemDetails,
            string date, string time, bool isPriority, decimal basePrice, decimal priorityFee, decimal totalPrice)
        {
            string priorityStatus = isPriority ? "TOP PRIORITY (2-4 hour arrival)" : "STANDARD (24-48 hour arrival)";
            string priorityFeeText = isPriority ? $"R{priorityFee:F2}" : "R0.00";

            return $@"
╔══════════════════════════════════════════════════════════════╗
║                   TELKOMX TECHNICIAN SERVICE                ║
║                     SERVICE RECEIPT                         ║
╚══════════════════════════════════════════════════════════════╝

Booking Reference: {bookingNumber}
Booking Date: {DateTime.Now:dd MMM yyyy HH:mm}
Service Type: {priorityStatus}

CUSTOMER INFORMATION:
────────────────────
Name: {customerName}
Billing ID: {billingId}
Address: {address}
Phone: {phone}
Email: {email}

SERVICE DETAILS:
────────────────
Problem Type: {problemType}
Problem Description: {problemDetails}
Scheduled Date: {date}
Scheduled Time: {time}

PAYMENT DETAILS:
────────────────
Base Technician Fee: R{basePrice:F2}
Priority Service Fee: {priorityFeeText}
────────────────────────────────────────
TOTAL AMOUNT DUE: R{totalPrice:F2}

Payment will be collected upon service completion.
Technician will call 30 minutes before arrival.

TERMS & CONDITIONS:
───────────────────
• Service fee covers diagnosis and basic setup
• Additional parts/materials billed separately
• 24-hour cancellation notice required
• Standard 30-day warranty on workmanship

Contact Support: 0800 TELKOM (835566)
Online Support: support.telkomx.co.za

Thank you for choosing TelkomX Priority Service!
";
        }


        private string GenerateTechnicianBookingNumber()
        {
            Random rand = new Random();
            int number = rand.Next(10000, 99999);
            return $"TECH{DateTime.Now:yyMMdd}{number}";
        }

        private string GetPriority(string issueType)
        {
            if (issueType.Contains("No Internet") || issueType.Contains("No Connection") ||
                issueType.Contains("Data Issue") || issueType.Contains("Call Issues"))
                return "High";

            if (issueType.Contains("Bill") || issueType.Contains("Payment") || issueType.Contains("Password"))
                return "Medium";

            return "Normal";
        }

        public string GetChatHtml()
        {
            List<string> chatMessages = Session["ChatMessages"] as List<string>;
            if (chatMessages == null) return "";

            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            foreach (string msg in chatMessages)
            {
                string[] parts = msg.Split('|');
                if (parts.Length >= 2)
                {
                    string role = parts[0];
                    string content = parts[1];
                    if (role == "USER")
                        sb.Append($"<div class='message user-message'><div class='message-content'>{content.Substring(content.IndexOf(':') + 1).Trim()}</div><div class='message-time'>{content.Substring(0, content.IndexOf(':'))}</div></div>");
                    else
                        sb.Append($"<div class='message bot-message'><div class='message-content'>{content.Substring(content.IndexOf(':') + 1).Trim()}</div><div class='message-time'>{content.Substring(0, content.IndexOf(':'))}</div></div>");
                }
            }
            return sb.ToString();
        }
    }

   
   
}