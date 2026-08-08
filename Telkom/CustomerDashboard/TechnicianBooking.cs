using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Telkom.CustomerDashboard
{
    public class TechnicianBooking
    {
        public string BookingNumber { get; set; }
        public string CustomerName { get; set; }
        public string Username { get; set; }
        public string Address { get; set; }
        public string BillingID { get; set; }
        public string Phone { get; set; }
        public string Email { get; set; }
        public string ProblemCategory { get; set; }
        public string ProblemDescription { get; set; }
        public DateTime ScheduledDate { get; set; }
        public string ScheduledTime { get; set; }
        public bool IsTopPriority { get; set; }
        public decimal BasePrice { get; set; }
        public decimal PriorityFee { get; set; }
        public decimal TotalPrice { get; set; }
        public string Status { get; set; }
        public DateTime CreatedDate { get; set; }
        public string EstimatedArrival { get; set; }
    }
}