<%@ Page Title="Predictive Diagnostics" Language="C#" MasterPageFile="~/Agent.Master" AutoEventWireup="true" CodeBehind="PredictiveDiagnostics.aspx.cs" Inherits="Telkom.PredictiveDiagnostics" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .tools-container {
            display: grid;
            grid-template-columns: 300px 1fr;
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .tool-sidebar {
            background: white;
            border-radius: 8px;
            border: 1px solid var(--telkom-border);
            padding: 1.5rem;
            height: fit-content;
            position: sticky;
            top: 2rem;
        }

        .tool-category {
            margin-bottom: 2rem;
        }

        .category-title {
            font-size: 1rem;
            font-weight: 600;
            color: var(--telkom-text);
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid var(--telkom-border);
        }

        .tool-button {
            display: block;
            width: 100%;
            padding: 0.75rem 1rem;
            margin-bottom: 0.5rem;
            background: var(--telkom-light-gray);
            border: 1px solid var(--telkom-border);
            border-radius: 6px;
            color: var(--telkom-text);
            text-decoration: none;
            cursor: pointer;
            transition: all 0.2s ease;
            font-size: 0.875rem;
        }

        .tool-button:hover {
            background: var(--telkom-primary);
            color: white;
            transform: translateX(2px);
        }

        .tool-button.active {
            background: var(--telkom-primary);
            color: white;
            border-color: var(--telkom-primary);
        }

        .main-content {
            background: white;
            border-radius: 8px;
            border: 1px solid var(--telkom-border);
            overflow: hidden;
        }

        .content-header {
            padding: 2rem;
            background: linear-gradient(135deg, var(--telkom-primary) 0%, var(--telkom-secondary) 100%);
            color: white;
        }

        .content-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin: 0 0 0.5rem 0;
        }

        .content-subtitle {
            opacity: 0.9;
            font-size: 1rem;
        }

        .content-body {
            padding: 2rem;
        }

        .prediction-form {
            background: var(--telkom-light-gray);
            padding: 1.5rem;
            border-radius: 8px;
            margin-bottom: 2rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            font-weight: 600;
            color: var(--telkom-text);
            margin-bottom: 0.5rem;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--telkom-border);
            border-radius: 6px;
            font-size: 1rem;
            transition: border-color 0.2s;
        }

        .form-control:focus {
            border-color: var(--telkom-primary);
            outline: none;
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 500;
            transition: all 0.2s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-primary {
            background: var(--telkom-primary);
            color: white;
        }

        .btn-primary:hover {
            background: #5046e5;
            transform: translateY(-1px);
        }

        .btn-secondary {
            background: var(--telkom-medium-gray);
            color: var(--telkom-text);
        }

        .results-container {
            display: none;
            margin-top: 2rem;
        }

        .prediction-result {
            background: white;
            border: 1px solid var(--telkom-border);
            border-radius: 8px;
            padding: 1.5rem;
            margin-bottom: 1rem;
        }

        .result-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .result-title {
            font-weight: 600;
            color: var(--telkom-text);
        }

        .confidence-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 12px;
            font-size: 0.875rem;
            font-weight: 500;
        }

        .confidence-high {
            background: rgba(16, 185, 129, 0.1);
            color: var(--telkom-success);
        }

        .confidence-medium {
            background: rgba(245, 158, 11, 0.1);
            color: var(--telkom-warning);
        }

        .confidence-low {
            background: rgba(239, 68, 68, 0.1);
            color: var(--telkom-error);
        }

        .prediction-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .detail-item {
            background: var(--telkom-light-gray);
            padding: 1rem;
            border-radius: 6px;
        }

        .detail-label {
            font-size: 0.875rem;
            color: var(--telkom-dark-gray);
            margin-bottom: 0.25rem;
        }

        .detail-value {
            font-weight: 600;
            color: var(--telkom-text);
            font-size: 1.1rem;
        }

        .recommended-actions {
            background: rgba(99, 102, 241, 0.05);
            border: 1px solid rgba(99, 102, 241, 0.2);
            border-radius: 6px;
            padding: 1rem;
        }

        .actions-title {
            font-weight: 600;
            color: var(--telkom-primary);
            margin-bottom: 0.75rem;
        }

        .action-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .action-item {
            padding: 0.5rem 0;
            border-bottom: 1px solid rgba(99, 102, 241, 0.1);
            display: flex;
            align-items: flex-start;
            gap: 0.75rem;
        }

        .action-item:last-child {
            border-bottom: none;
        }

        .action-priority {
            background: var(--telkom-primary);
            color: white;
            border-radius: 50%;
            width: 24px;
            height: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.75rem;
            font-weight: 600;
            flex-shrink: 0;
        }

        .loading-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(255, 255, 255, 0.9);
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 8px;
            z-index: 10;
        }

        .loading-spinner {
            width: 50px;
            height: 50px;
            border: 4px solid var(--telkom-border);
            border-top: 4px solid var(--telkom-primary);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .network-topology {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 1rem;
            margin: 1rem 0;
        }

        .topology-node {
            background: var(--telkom-light-gray);
            border: 2px solid var(--telkom-border);
            border-radius: 8px;
            padding: 1rem;
            text-align: center;
            transition: all 0.2s ease;
            cursor: pointer;
        }

        .topology-node:hover {
            border-color: var(--telkom-primary);
            transform: translateY(-2px);
        }

        .topology-node.alert {
            border-color: var(--telkom-error);
            background: rgba(239, 68, 68, 0.1);
        }

        .node-status {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            display: inline-block;
            margin-right: 0.5rem;
        }

        .status-online {
            background: var(--telkom-success);
        }

        .status-warning {
            background: var(--telkom-warning);
        }

        .status-offline {
            background: var(--telkom-error);
        }

        @media (max-width: 1024px) {
            .tools-container {
                grid-template-columns: 1fr;
            }
            
            .tool-sidebar {
                position: static;
                order: 2;
            }
            
            .main-content {
                order: 1;
            }
            
            .prediction-details {
                grid-template-columns: 1fr;
            }
            
            .form-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-header">
        <h1 class="page-title">Predictive Diagnostics & AI Tools</h1>
        <p class="page-subtitle">Advanced AI-powered tools for predictive analysis and proactive support</p>
    </div>

    <div class="tools-container">
        <!-- Tool Sidebar -->
        <div class="tool-sidebar">
            <div class="tool-category">
                <h3 class="category-title">Network Analysis</h3>
                <button class="tool-button active" onclick="loadTool('network-health')">Network Health Predictor</button>
                <button class="tool-button" onclick="loadTool('outage-prediction')">Outage Prediction</button>
                <button class="tool-button" onclick="loadTool('bandwidth-analysis')">Bandwidth Analysis</button>
                <button class="tool-button" onclick="loadTool('topology-monitor')">Network Topology</button>
            </div>
            
            <div class="tool-category">
                <h3 class="category-title">Customer Insights</h3>
                <button class="tool-button" onclick="loadTool('churn-prediction')">Churn Risk Analysis</button>
                <button class="tool-button" onclick="loadTool('satisfaction-predictor')">Satisfaction Predictor</button>
                <button class="tool-button" onclick="loadTool('usage-patterns')">Usage Pattern Analysis</button>
            </div>
            
            <div class="tool-category">
                <h3 class="category-title">Issue Resolution</h3>
                <button class="tool-button" onclick="loadTool('auto-diagnostics')">Auto-Diagnostics</button>
                <button class="tool-button" onclick="loadTool('resolution-recommender')">Resolution Recommender</button>
                <button class="tool-button" onclick="loadTool('escalation-predictor')">Escalation Predictor</button>
            </div>
        </div>

        <!-- Main Content Area -->
        <div class="main-content">
            <asp:UpdatePanel ID="updatePanelTools" runat="server">
                <ContentTemplate>
                    <!-- Network Health Predictor (Default) -->
                    <div id="network-health" class="tool-content">
                        <div class="content-header">
                            <h2 class="content-title">Network Health Predictor</h2>
                            <p class="content-subtitle">Predict network issues before they impact customers</p>
                        </div>
                        <div class="content-body" style="position: relative;">
                            <div class="prediction-form">
                                <div class="form-row">
                                    <div class="form-group">
                                        <label class="form-label">Customer ID or Phone Number</label>
                                        <asp:TextBox ID="txtCustomerId" runat="server" CssClass="form-control" placeholder="Enter customer identifier"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label">Analysis Timeframe</label>
                                        <asp:DropDownList ID="ddlTimeframe" runat="server" CssClass="form-control">
                                            <asp:ListItem Value="24">Next 24 Hours</asp:ListItem>
                                            <asp:ListItem Value="72" Selected="True">Next 3 Days</asp:ListItem>
                                            <asp:ListItem Value="168">Next 7 Days</asp:ListItem>
                                            <asp:ListItem Value="720">Next 30 Days</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group">
                                        <label class="form-label">Analysis Type</label>
                                        <asp:DropDownList ID="ddlAnalysisType" runat="server" CssClass="form-control">
                                            <asp:ListItem Value="full">Full Network Analysis</asp:ListItem>
                                            <asp:ListItem Value="performance">Performance Only</asp:ListItem>
                                            <asp:ListItem Value="connectivity">Connectivity Issues</asp:ListItem>
                                            <asp:ListItem Value="bandwidth">Bandwidth Optimization</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label">Priority Level</label>
                                        <asp:DropDownList ID="ddlPriority" runat="server" CssClass="form-control">
                                            <asp:ListItem Value="standard">Standard</asp:ListItem>
                                            <asp:ListItem Value="high">High Priority</asp:ListItem>
                                            <asp:ListItem Value="critical">Critical</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div style="text-align: center; margin-top: 1rem;">
                                    <asp:Button ID="btnRunPrediction" runat="server" Text="Run Prediction Analysis" 
                                        CssClass="btn btn-primary" OnClick="btnRunPrediction_Click" />
                                    <button type="button" class="btn btn-secondary" onclick="clearResults()">Clear Results</button>
                                </div>
                            </div>

                            <!-- Results Container -->
                            <div id="resultsContainer" class="results-container" runat="server">
                                <asp:Repeater ID="rptPredictionResults" runat="server">
                                    <ItemTemplate>
                                        <div class="prediction-result">
                                            <div class="result-header">
                                                <h3 class="result-title"><%# Eval("PredictionType") %></h3>
                                                <span class="confidence-badge <%# GetConfidenceClass(Eval("Confidence").ToString()) %>">
                                                    <%# Eval("Confidence") %>% Confidence
                                                </span>
                                            </div>
                                            
                                            <div class="prediction-details">
                                                <div class="detail-item">
                                                    <div class="detail-label">Risk Level</div>
                                                    <div class="detail-value"><%# Eval("RiskLevel") %></div>
                                                </div>
                                                <div class="detail-item">
                                                    <div class="detail-label">Estimated Impact</div>
                                                    <div class="detail-value"><%# Eval("EstimatedImpact") %></div>
                                                </div>
                                                <div class="detail-item">
                                                    <div class="detail-label">Time to Issue</div>
                                                    <div class="detail-value"><%# Eval("TimeToIssue") %></div>
                                                </div>
                                                <div class="detail-item">
                                                    <div class="detail-label">Affected Services</div>
                                                    <div class="detail-value"><%# Eval("AffectedServices") %></div>
                                                </div>
                                            </div>

                                            <div class="recommended-actions">
                                                <h4 class="actions-title">Recommended Actions</h4>
                                                <ul class="action-list">
                                                    <asp:Repeater ID="rptActions" runat="server" DataSource='<%# Eval("RecommendedActions") %>'>
                                                        <ItemTemplate>
                                                            <li class="action-item">
                                                                <span class="action-priority"><%# Container.ItemIndex + 1 %></span>
                                                                <span><%# Container.DataItem %></span>
                                                            </li>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </ul>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>

                            <!-- Loading Overlay -->
                            <div id="loadingOverlay" class="loading-overlay" style="display: none;">
                                <div class="loading-spinner"></div>
                            </div>
                        </div>
                    </div>

                    <!-- Network Topology Monitor -->
                    <div id="topology-monitor" class="tool-content" style="display: none;">
                        <div class="content-header">
                            <h2 class="content-title">Network Topology Monitor</h2>
                            <p class="content-subtitle">Real-time network infrastructure monitoring</p>
                        </div>
                        <div class="content-body">
                            <div class="network-topology">
                                <asp:Repeater ID="rptNetworkNodes" runat="server">
                                    <ItemTemplate>
                                        <div class="topology-node <%# Eval("AlertStatus") %>" onclick="showNodeDetails('<%# Eval("NodeId") %>')">
                                            <div>
                                                <span class="node-status <%# GetStatusClass(Eval("Status").ToString()) %>"></span>
                                                <%# Eval("NodeName") %>
                                            </div>
                                            <div style="font-size: 0.875rem; color: var(--telkom-dark-gray); margin-top: 0.5rem;">
                                                <%# Eval("NodeType") %>
                                            </div>
                                            <div style="font-weight: 600; margin-top: 0.25rem;">
                                                <%# Eval("Performance") %>%
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                    </div>

                    <!-- Hidden field for current tool -->
                    <asp:HiddenField ID="hfCurrentTool" runat="server" Value="network-health" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>

    <script type="text/javascript">
        function loadTool(toolId) {
            // Update active button
            document.querySelectorAll('.tool-button').forEach(btn => btn.classList.remove('active'));
            event.target.classList.add('active');

            // Hide all tool content
            document.querySelectorAll('.tool-content').forEach(content => content.style.display = 'none');

            // Show selected tool
            var toolContent = document.getElementById(toolId);
            if (toolContent) {
                toolContent.style.display = 'block';
                document.getElementById('<%= hfCurrentTool.ClientID %>').value = toolId;
            }

            // Load specific tool data via postback
            __doPostBack('<%= Page.ClientID %>', 'loadTool:' + toolId);
        }

        function showLoading() {
            document.getElementById('loadingOverlay').style.display = 'flex';
            document.getElementById('resultsContainer').style.display = 'none';
        }

        function hideLoading() {
            document.getElementById('loadingOverlay').style.display = 'none';
        }

        function clearResults() {
            document.getElementById('resultsContainer').style.display = 'none';
            document.getElementById('<%= txtCustomerId.ClientID %>').value = '';
        }

        function showNodeDetails(nodeId) {
            alert('Node Details for ' + nodeId + '\n\nThis would show detailed network node information in a real implementation.');
        }

        // Override the default button click to show loading
        document.addEventListener('DOMContentLoaded', function() {
            var predictButton = document.getElementById('<%= btnRunPrediction.ClientID %>');
            if (predictButton) {
                predictButton.addEventListener('click', function() {
                    if (Page_ClientValidate()) {
                        showLoading();
                    }
                });
            }
        });
    </script>
</asp:Content>