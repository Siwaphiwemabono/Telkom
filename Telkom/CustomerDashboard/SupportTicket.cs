using System;
using System.Collections.Generic;

namespace Telkom.CustomerDashboard
{
    public class SupportTicket
    {
        public string TicketID { get; set; }
        public string CustomerName { get; set; }
        public string Username { get; set; }
        public string Category { get; set; }
        public string IssueType { get; set; }
        public string Department { get; set; }
        public string Status { get; set; }
        public DateTime CreatedDate { get; set; }
        public DateTime? ScheduledDate { get; set; }
        public string ScheduledTime { get; set; }
        public int ExpectedWaitTime { get; set; }
        public string Priority { get; set; }
        public string Description { get; set; }
        public string AssignedAgent { get; set; }
        public int QueuePosition { get; set; }

        // Additional properties for enhanced functionality
        public DateTime? LastUpdated { get; set; }
        public string Notes { get; set; }
        public bool IsEscalated { get; set; }
        public int AttemptsCount { get; set; }
    }
    // Enhanced chatbot tracking
    public class ChatSession
    {
        public int QuestionCount { get; set; } = 0;
        public bool HasAskedSatisfaction { get; set; } = false;
        public bool IsWaitingForSatisfactionResponse { get; set; } = false;
        public List<string> TopicsDiscussed { get; set; } = new List<string>();
        public DateTime LastInteraction { get; set; } = DateTime.Now;

        // Add these missing properties that are causing the compilation errors:
        public bool HasBooked { get; set; } = false;
        public string BookingReference { get; set; } = string.Empty;
    }

  
}