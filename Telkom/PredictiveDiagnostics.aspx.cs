using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Telkom
{
    public partial class PredictiveDiagnostics : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if user is logged in and has the correct role (Agent)
            if (Session["Username"] == null || Session["UserRole"] == null || Session["UserRole"].ToString() != "Agent")
            {
                Response.Redirect("SignIn.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadNetworkNodes();
                resultsContainer.Style["display"] = "none";
            }
            else
            {
                // Handle postback events
                string eventTarget = Request["__EVENTTARGET"];
                string eventArgument = Request["__EVENTARGUMENT"];

                if (eventArgument != null && eventArgument.StartsWith("loadTool:"))
                {
                    string toolId = eventArgument.Substring(9);
                    LoadToolData(toolId);
                }
                else if (eventArgument != null && eventArgument.StartsWith("refreshStats"))
                {
                    LoadNetworkNodes();
                }
            }
        }

        protected void btnRunPrediction_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtCustomerId.Text.Trim()))
            {
                ShowMessage("Please enter a Customer ID or Phone Number", "error");
                return;
            }

            try
            {
                string customerId = txtCustomerId.Text.Trim();
                List<PredictionResult> predictions;

                // Route to appropriate analysis method based on current tool
                string currentTool = hfCurrentTool.Value;

                switch (currentTool)
                {
                    case "auto-diagnostics":
                        predictions = RunAutodiagnostics(customerId);
                        break;
                    case "bandwidth-analysis":
                        predictions = RunBandwidthAnalysis(customerId);
                        break;
                    default:
                        // Default network health prediction
                        predictions = GeneratePredictions(customerId);
                        break;
                }

                rptPredictionResults.DataSource = predictions;
                rptPredictionResults.DataBind();

                resultsContainer.Style["display"] = "block";

                ShowMessage($"Analysis completed for {customerId}. {predictions.Count} predictions generated.", "success");
            }
            catch (Exception ex)
            {
                ShowMessage($"Error running prediction: {ex.Message}", "error");
            }
        }

        private List<PredictionResult> GeneratePredictions(string customerId)
        {
            // Simulate AI-powered predictive analysis
            var random = new Random();
            var predictions = new List<PredictionResult>();

            // Network Health Prediction
            predictions.Add(new PredictionResult
            {
                PredictionType = "Network Performance Degradation",
                Confidence = random.Next(75, 95),
                RiskLevel = "Medium",
                EstimatedImpact = "15% Speed Reduction",
                TimeToIssue = "2-3 Days",
                AffectedServices = "Internet, WiFi",
                RecommendedActions = new List<string>
                {
                    "Schedule proactive router maintenance",
                    "Monitor bandwidth usage patterns",
                    "Prepare customer notification template",
                    "Queue technician for preventive check"
                }
            });

            // Equipment Health
            predictions.Add(new PredictionResult
            {
                PredictionType = "Router Hardware Failure Risk",
                Confidence = random.Next(60, 85),
                RiskLevel = "High",
                EstimatedImpact = "Complete Service Outage",
                TimeToIssue = "5-7 Days",
                AffectedServices = "All Services",
                RecommendedActions = new List<string>
                {
                    "Schedule router replacement within 48 hours",
                    "Prepare backup equipment",
                    "Contact customer for appointment scheduling",
                    "Update inventory management system"
                }
            });

            // Bandwidth Analysis
            if (ddlAnalysisType.SelectedValue == "full" || ddlAnalysisType.SelectedValue == "bandwidth")
            {
                predictions.Add(new PredictionResult
                {
                    PredictionType = "Bandwidth Optimization Opportunity",
                    Confidence = random.Next(80, 95),
                    RiskLevel = "Low",
                    EstimatedImpact = "25% Performance Improvement",
                    TimeToIssue = "Immediate",
                    AffectedServices = "Streaming, Gaming",
                    RecommendedActions = new List<string>
                    {
                        "Adjust QoS settings remotely",
                        "Recommend package upgrade to customer",
                        "Optimize WiFi channel configuration",
                        "Schedule usage pattern review"
                    }
                });
            }

            // Connection Stability
            if (ddlAnalysisType.SelectedValue == "full" || ddlAnalysisType.SelectedValue == "connectivity")
            {
                predictions.Add(new PredictionResult
                {
                    PredictionType = "Connection Stability Issues",
                    Confidence = random.Next(70, 90),
                    RiskLevel = "Medium",
                    EstimatedImpact = "Intermittent Disconnections",
                    TimeToIssue = "24-48 Hours",
                    AffectedServices = "Internet, VoIP",
                    RecommendedActions = new List<string>
                    {
                        "Check line signal quality remotely",
                        "Schedule cable inspection",
                        "Review environmental factors",
                        "Update router firmware if needed"
                    }
                });
            }

            return predictions;
        }

        private void LoadNetworkNodes()
        {
            // Simulate network topology data
            var nodes = new List<NetworkNode>
            {
                new NetworkNode
                {
                    NodeId = "CPT-CORE-01",
                    NodeName = "Cape Town Core",
                    NodeType = "Core Router",
                    Status = "Online",
                    Performance = 98,
                    AlertStatus = ""
                },
                new NetworkNode
                {
                    NodeId = "CPT-DIST-01",
                    NodeName = "Cape Town District 1",
                    NodeType = "Distribution",
                    Status = "Warning",
                    Performance = 85,
                    AlertStatus = "alert"
                },
                new NetworkNode
                {
                    NodeId = "CPT-ACCESS-01",
                    NodeName = "Access Point 1",
                    NodeType = "Access Point",
                    Status = "Online",
                    Performance = 92,
                    AlertStatus = ""
                },
                new NetworkNode
                {
                    NodeId = "CPT-ACCESS-02",
                    NodeName = "Access Point 2",
                    NodeType = "Access Point",
                    Status = "Offline",
                    Performance = 0,
                    AlertStatus = "alert"
                },
                new NetworkNode
                {
                    NodeId = "JHB-CORE-01",
                    NodeName = "Johannesburg Core",
                    NodeType = "Core Router",
                    Status = "Online",
                    Performance = 96,
                    AlertStatus = ""
                },
                new NetworkNode
                {
                    NodeId = "DBN-DIST-01",
                    NodeName = "Durban District",
                    NodeType = "Distribution",
                    Status = "Online",
                    Performance = 89,
                    AlertStatus = ""
                }
            };

            rptNetworkNodes.DataSource = nodes;
            rptNetworkNodes.DataBind();
        }

        private void LoadToolData(string toolId)
        {
            switch (toolId)
            {
                case "topology-monitor":
                    LoadNetworkNodes();
                    break;
                case "churn-prediction":
                    LoadChurnPredictions();
                    break;
                case "outage-prediction":
                    LoadOutagePredictions();
                    break;
                case "auto-diagnostics":
                    // For auto-diagnostics, we need a customer ID, so just prepare the form
                    resultsContainer.Style["display"] = "none";
                    break;
                case "bandwidth-analysis":
                    // Similar to auto-diagnostics, prepare form
                    resultsContainer.Style["display"] = "none";
                    break;
                default:
                    // Load default network health data
                    resultsContainer.Style["display"] = "none";
                    break;
            }
        }

        private void LoadChurnPredictions()
        {
            // Simulate customer churn prediction data
            var predictions = new List<PredictionResult>
            {
                new PredictionResult
                {
                    PredictionType = "Customer Churn Risk Analysis",
                    Confidence = 87,
                    RiskLevel = "High",
                    EstimatedImpact = "Revenue Loss: R2,500/month",
                    TimeToIssue = "14-21 Days",
                    AffectedServices = "All Services",
                    RecommendedActions = new List<string>
                    {
                        "Contact customer for retention offer",
                        "Review service quality metrics",
                        "Offer service upgrade incentives",
                        "Schedule satisfaction survey"
                    }
                }
            };

            rptPredictionResults.DataSource = predictions;
            rptPredictionResults.DataBind();
            resultsContainer.Style["display"] = "block";
        }

        private void LoadOutagePredictions()
        {
            // Simulate outage prediction data
            var predictions = new List<PredictionResult>
            {
                new PredictionResult
                {
                    PredictionType = "Regional Outage Prediction",
                    Confidence = 78,
                    RiskLevel = "Medium",
                    EstimatedImpact = "450 Customers Affected",
                    TimeToIssue = "3-5 Days",
                    AffectedServices = "Internet, Mobile Data",
                    RecommendedActions = new List<string>
                    {
                        "Pre-position technical team",
                        "Prepare customer communications",
                        "Stock replacement equipment",
                        "Coordinate with network operations center"
                    }
                }
            };

            rptPredictionResults.DataSource = predictions;
            rptPredictionResults.DataBind();
            resultsContainer.Style["display"] = "block";
        }

        protected string GetConfidenceClass(string confidence)
        {
            int confidenceValue = int.Parse(confidence);
            if (confidenceValue >= 85)
                return "confidence-high";
            else if (confidenceValue >= 70)
                return "confidence-medium";
            else
                return "confidence-low";
        }

        protected string GetStatusClass(string status)
        {
            switch (status.ToLower())
            {
                case "online":
                    return "status-online";
                case "warning":
                    return "status-warning";
                case "offline":
                    return "status-offline";
                default:
                    return "status-warning";
            }
        }

        private void ShowMessage(string message, string type)
        {
            // Register client script to show notification
            string script = $@"
                setTimeout(function() {{
                    showNotification('{message}', '{type}');
                }}, 100);
            ";

            ClientScript.RegisterStartupScript(this.GetType(), "ShowMessage", script, true);
        }

        // Data models
        public class PredictionResult
        {
            public string PredictionType { get; set; }
            public int Confidence { get; set; }
            public string RiskLevel { get; set; }
            public string EstimatedImpact { get; set; }
            public string TimeToIssue { get; set; }
            public string AffectedServices { get; set; }
            public List<string> RecommendedActions { get; set; } = new List<string>();
        }

        public class NetworkNode
        {
            public string NodeId { get; set; }
            public string NodeName { get; set; }
            public string NodeType { get; set; }
            public string Status { get; set; }
            public int Performance { get; set; }
            public string AlertStatus { get; set; }
        }

        public class ChurnPrediction
        {
            public string CustomerId { get; set; }
            public string CustomerName { get; set; }
            public int ChurnProbability { get; set; }
            public string RiskFactors { get; set; }
            public List<string> RetentionActions { get; set; } = new List<string>();
        }

        public class OutagePrediction
        {
            public string Region { get; set; }
            public int AffectedCustomers { get; set; }
            public string PredictedCause { get; set; }
            public DateTime EstimatedTime { get; set; }
            public string PreventiveActions { get; set; }
        }

        // Additional tool methods can be added here for other predictive tools
        private List<PredictionResult> RunBandwidthAnalysis(string customerId)
        {
            // Simulate bandwidth optimization analysis
            var predictions = new List<PredictionResult>
            {
                new PredictionResult
                {
                    PredictionType = "Bandwidth Optimization Analysis",
                    Confidence = 92,
                    RiskLevel = "Low",
                    EstimatedImpact = "30% Performance Boost Possible",
                    TimeToIssue = "Immediate",
                    AffectedServices = "Internet, Streaming",
                    RecommendedActions = new List<string>
                    {
                        "Optimize router QoS settings",
                        "Recommend higher bandwidth package",
                        "Check for interference sources",
                        "Update router firmware"
                    }
                }
            };

            return predictions;
        }

        private List<PredictionResult> RunAutodiagnostics(string customerId)
        {
            // Simulate automated diagnostic analysis
            var predictions = new List<PredictionResult>
            {
                new PredictionResult
                {
                    PredictionType = "Automated System Diagnostics",
                    Confidence = 95,
                    RiskLevel = "Medium",
                    EstimatedImpact = "Service Interruption Detected",
                    TimeToIssue = "Current",
                    AffectedServices = "WiFi Signal Strength",
                    RecommendedActions = new List<string>
                    {
                        "Router restart required - can be done remotely",
                        "Check cable connections at customer premises",
                        "WiFi channel optimization needed",
                        "Schedule technician visit if issues persist"
                    }
                }
            };

            return predictions;
        }
    }
}