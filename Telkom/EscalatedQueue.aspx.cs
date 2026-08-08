using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Script.Services;

namespace Telkom
{
    public partial class EscalatedQueue : System.Web.UI.Page
    {
        // Mark the class as serializable
        [Serializable]
        public class EscalatedCase
        {
            public string CaseId { get; set; }
            public string CustomerName { get; set; }
            public string IssueType { get; set; }
            public string Priority { get; set; }
            public string Status { get; set; }
            public string Description { get; set; }
            public string AssignedTechnician { get; set; }
            public DateTime EscalatedDate { get; set; }
            public DateTime SlaDeadline { get; set; }
            public string Notes { get; set; }
            public string OriginalQueue { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Initialize page on first load
                InitializePage();
            }
        }

        private void InitializePage()
        {
            // Set technician name
            lblTechnicianName.Text = GetCurrentTechnician();

            // Update statistics using client-side script
            ScriptManager.RegisterStartupScript(this, GetType(), "InitStats",
                "updateStatistics(2, 2, 4, '2.3h');", true);
        }

        private string GetCurrentTechnician()
        {
            // In a real application, this would come from session or authentication
            if (Session["CurrentTechnician"] != null)
            {
                return Session["CurrentTechnician"].ToString();
            }

            // Default value for demo purposes
            return "Thato Mthembu";
        }

        // WebMethod to get case data - using simple types that are serializable
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = false)]
        public static object GetCaseData(string priorityFilter, string statusFilter, string searchTerm)
        {
            try
            {
                // In a real application, this would query a database
                // For demo purposes, we'll return simplified data
                var cases = new List<object>
                {
                    new {
                        CaseId = "ESC001",
                        CustomerName = "Sibongile Mthembu",
                        IssueType = "Network Connectivity",
                        Priority = "High",
                        Status = "Escalated",
                        Description = "Complete internet outage affecting business operations.",
                        EscalatedDate = DateTime.Now.AddHours(-2).ToString("yyyy-MM-dd HH:mm"),
                        SlaDeadline = DateTime.Now.AddHours(6).ToString("yyyy-MM-dd HH:mm"),
                        Notes = "",
                        ContactNumber = "+27 11 555 0123",
                        AccountNumber = "TEL789456123",
                        Location = "Sandton, Johannesburg"
                    },
                    new {
                        CaseId = "ESC002",
                        CustomerName = "Ahmed Hassan",
                        IssueType = "Speed Issues",
                        Priority = "Medium",
                        Status = "Investigating",
                        Description = "Persistent slow internet speeds during peak hours.",
                        EscalatedDate = DateTime.Now.AddHours(-4).ToString("yyyy-MM-dd HH:mm"),
                        SlaDeadline = DateTime.Now.AddHours(12).ToString("yyyy-MM-dd HH:mm"),
                        Notes = "Checked line quality - signal levels within normal range.",
                        ContactNumber = "+27 21 555 0456",
                        AccountNumber = "TEL456789321",
                        Location = "Cape Town CBD"
                    },
                    new {
                        CaseId = "ESC003",
                        CustomerName = "Mary Johnson",
                        IssueType = "Intermittent Connectivity",
                        Priority = "High",
                        Status = "Pending",
                        Description = "Random disconnections every 10-15 minutes affecting critical video conferences.",
                        EscalatedDate = DateTime.Now.AddHours(-6).ToString("yyyy-MM-dd HH:mm"),
                        SlaDeadline = DateTime.Now.AddHours(2).ToString("yyyy-MM-dd HH:mm"),
                        Notes = "Router replacement scheduled. Waiting for customer availability window.",
                        ContactNumber = "+27 31 555 0789",
                        AccountNumber = "TEL321654987",
                        Location = "Durban North"
                    },
                    new {
                        CaseId = "ESC004",
                        CustomerName = "David Wilson",
                        IssueType = "Email Configuration",
                        Priority = "Medium",
                        Status = "Resolved",
                        Description = "Complex email server configuration issues. Multiple email accounts not syncing properly with various clients.",
                        EscalatedDate = DateTime.Now.AddHours(-8).ToString("yyyy-MM-dd HH:mm"),
                        SlaDeadline = DateTime.Now.AddHours(-1).ToString("yyyy-MM-dd HH:mm"),
                        Notes = "Configured IMAP/SMTP settings for all email clients. Verified functionality across desktop and mobile devices. Issue resolved.",
                        ContactNumber = "+27 12 555 0321",
                        AccountNumber = "TEL987123654",
                        Location = "Pretoria"
                    }
                };

                // Apply filters
                var filteredCases = cases.AsEnumerable();

                if (!string.IsNullOrEmpty(priorityFilter))
                {
                    filteredCases = filteredCases.Where(c =>
                        ((dynamic)c).Priority == priorityFilter);
                }

                if (!string.IsNullOrEmpty(statusFilter))
                {
                    filteredCases = filteredCases.Where(c =>
                        ((dynamic)c).Status == statusFilter);
                }

                if (!string.IsNullOrEmpty(searchTerm))
                {
                    filteredCases = filteredCases.Where(c =>
                        ((dynamic)c).CaseId.Contains(searchTerm) ||
                        ((dynamic)c).CustomerName.Contains(searchTerm));
                }

                return new { success = true, data = filteredCases.ToList() };
            }
            catch (Exception ex)
            {
                return new { success = false, error = ex.Message };
            }
        }

        // WebMethod to update case status
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = false)]
        public static object UpdateCaseStatus(string caseId, string newStatus, string notes)
        {
            try
            {
                // In a real application, this would update the database
                System.Threading.Thread.Sleep(300); // Simulate processing

                return new
                {
                    success = true,
                    message = $"Case {caseId} status updated to {newStatus}"
                };
            }
            catch (Exception ex)
            {
                return new { success = false, error = ex.Message };
            }
        }

        // WebMethod to save case details
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = false)]
        public static object SaveCaseDetails(string caseId, string priority, string status, string notes)
        {
            try
            {
                // In a real application, this would update the database
                System.Threading.Thread.Sleep(500); // Simulate processing

                return new
                {
                    success = true,
                    message = $"Case {caseId} details saved successfully"
                };
            }
            catch (Exception ex)
            {
                return new { success = false, error = ex.Message };
            }
        }

        // Export functionality
        protected void btnExportCSV_Click(object sender, EventArgs e)
        {
            // For export, we'll generate simple data
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=EscalatedCases.csv");
            Response.Charset = "";
            Response.ContentType = "application/text";

            var sb = new System.Text.StringBuilder();
            sb.AppendLine("CaseID,CustomerName,IssueType,Priority,Status,EscalatedDate,SLADeadline,ContactNumber,AccountNumber,Location");

            // Sample data for export
            sb.AppendLine("ESC001,Sibongile Mthembu,Network Connectivity,High,Escalated," +
                DateTime.Now.AddHours(-2).ToString("yyyy-MM-dd HH:mm") + "," +
                DateTime.Now.AddHours(6).ToString("yyyy-MM-dd HH:mm") + "," +
                "+27 11 555 0123,TEL789456123,Sandton, Johannesburg");

            sb.AppendLine("ESC002,Ahmed Hassan,Speed Issues,Medium,Investigating," +
                DateTime.Now.AddHours(-4).ToString("yyyy-MM-dd HH:mm") + "," +
                DateTime.Now.AddHours(12).ToString("yyyy-MM-dd HH:mm") + "," +
                "+27 21 555 0456,TEL456789321,Cape Town CBD");

            sb.AppendLine("ESC003,Mary Johnson,Intermittent Connectivity,High,Pending," +
                DateTime.Now.AddHours(-6).ToString("yyyy-MM-dd HH:mm") + "," +
                DateTime.Now.AddHours(2).ToString("yyyy-MM-dd HH:mm") + "," +
                "+27 31 555 0789,TEL321654987,Durban North");

            sb.AppendLine("ESC004,David Wilson,Email Configuration,Medium,Resolved," +
                DateTime.Now.AddHours(-8).ToString("yyyy-MM-dd HH:mm") + "," +
                DateTime.Now.AddHours(-1).ToString("yyyy-MM-dd HH:mm") + "," +
                "+27 12 555 0321,TEL987123654,Pretoria");

            Response.Output.Write(sb.ToString());
            Response.Flush();
            Response.End();
        }
    }
}