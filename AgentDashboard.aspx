<%@ Page Title="Agent Dashboard" Language="C#" MasterPageFile="~/Agent.Master" AutoEventWireup="true" CodeBehind="AgentDashboard.aspx.cs" Inherits="Telkom.AgentDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .dashboard-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .card {
            background: white;
            border-radius: 8px;
            border: 1px solid var(--telkom-border);
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            overflow: hidden;
        }

        .card-header {
            padding: 1.5rem;
            border-bottom: 1px solid var(--telkom-border);
            display: flex;
            justify-content: between;
            align-items: center;
        }

        .card-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--telkom-text);
            margin: 0;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .card-body {
            padding: 1.5rem;
        }

        .priority-queue {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .queue-item {
            background: var(--telkom-light-gray);
            border-radius: 8px;
            padding: 1rem;
            border-left: 4px solid var(--telkom-primary);
            transition: transform 0.2s ease;
        }

        .queue-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .queue-item.high-priority {
            border-left-color: var(--telkom-error);
            background: linear-gradient(135deg, #fef2f2 0%, var(--telkom-light-gray) 100%);
        }

        .item-header {
            display: flex;
            justify-content: between;
            align-items: flex-start;
            margin-bottom: 0.75rem;
        }

        .customer-name {
            font-weight: 600;
            color: var(--telkom-text);
            margin: 0;
        }

        .wait-time {
            color: var(--telkom-dark-gray);
            font-size: 0.875rem;
        }

        .issue-summary {
            color: var(--telkom-dark-gray);
            font-size: 0.875rem;
            line-height: 1.4;
            margin-bottom: 0.75rem;
        }

        .action-buttons {
            display: flex;
            gap: 0.5rem;
            justify-content: flex-end;
        }

        .btn {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.875rem;
            font-weight: 500;
            transition: all 0.2s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
        }

        .btn-primary {
            background: var(--telkom-primary);
            color: white;
        }

        .btn-primary:hover {
            background: #5046e5;
            transform: translateY(-1px);
        }

        .btn-outline {
            background: transparent;
            color: var(--telkom-primary);
            border: 1px solid var(--telkom-primary);
        }

        .btn-outline:hover {
            background: var(--telkom-primary);
            color: white;
        }

        .performance-metrics {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
        }

        .metric-item {
            text-align: center;
            padding: 1rem;
            background: var(--telkom-light-gray);
            border-radius: 8px;
        }

        .metric-value {
            font-size: 2rem;
            font-weight: 700;
            color: var(--telkom-primary);
            display: block;
        }

        .metric-label {
            color: var(--telkom-dark-gray);
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }

        .activity-feed {
            max-height: 400px;
            overflow-y: auto;
        }

        .activity-item {
            display: flex;
            gap: 1rem;
            padding: 1rem 0;
            border-bottom: 1px solid var(--telkom-border);
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        .activity-time {
            font-size: 0.75rem;
            color: var(--telkom-dark-gray);
            min-width: 60px;
        }

        .activity-content {
            flex: 1;
        }

        .activity-title {
            font-weight: 600;
            color: var(--telkom-text);
            margin-bottom: 0.25rem;
        }

        .activity-description {
            color: var(--telkom-dark-gray);
            font-size: 0.875rem;
        }

        .tools-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-top: 2rem;
        }

        .tool-card {
            background: white;
            border-radius: 8px;
            border: 1px solid var(--telkom-border);
            padding: 1.5rem;
            text-align: center;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .tool-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            border-color: var(--telkom-primary);
        }

        .tool-icon {
            font-size: 2rem;
            margin-bottom: 0.75rem;
            display: block;
        }

        .tool-title {
            font-weight: 600;
            color: var(--telkom-text);
            margin-bottom: 0.5rem;
        }

        .tool-description {
            color: var(--telkom-dark-gray);
            font-size: 0.875rem;
        }

        .notification-item {
            padding: 0.75rem;
            background: var(--telkom-light-gray);
            border-radius: 6px;
            margin-bottom: 0.75rem;
            border-left: 3px solid var(--telkom-warning);
        }

        .notification-item:last-child {
            margin-bottom: 0;
        }

        .notification-title {
            font-weight: 600;
            color: var(--telkom-text);
            margin-bottom: 0.25rem;
        }

        .notification-text {
            color: var(--telkom-dark-gray);
            font-size: 0.875rem;
        }

        @media (max-width: 1024px) {
            .dashboard-grid {
                grid-template-columns: 1fr;
            }
            
            .performance-metrics {
                grid-template-columns: 1fr;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-header">
        <h1 class="page-title">Agent Dashboard</h1>
        <p class="page-subtitle">Manage your queue, track performance, and access support tools</p>
    </div>

    <!-- Main Dashboard Grid -->
    <div class="dashboard-grid">
        <!-- Priority Queue Section -->
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">
                    <span>🎯</span>
                    Your Priority Queue
                </h2>
                <asp:Button ID="btnRefreshQueue" runat="server" Text="Refresh" CssClass="btn btn-outline" OnClick="btnRefreshQueue_Click" />
            </div>
            <div class="card-body">
                <div class="priority-queue">
                    <asp:Repeater ID="rptPriorityQueue" runat="server">
                        <ItemTemplate>
                            <div class="queue-item <%# Eval("Priority").ToString() == "High" ? "high-priority" : "" %>">
                                <div class="item-header">
                                    <h3 class="customer-name"><%# Eval("CustomerName") %></h3>
                                    <span class="wait-time">Waiting: <%# Eval("WaitTime") %></span>
                                </div>
                                <div class="issue-summary"><%# Eval("IssueDescription") %></div>
                                <div class="action-buttons">
                                    <button class="btn btn-primary" onclick="assignToMe('<%# Eval("QueueId") %>', '<%# Eval("CustomerName") %>')">
                                        Assign to Me
                                    </button>
                                    <button class="btn btn-outline" onclick="viewDetails('<%# Eval("QueueId") %>')">
                                        View Details
                                    </button>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>

        <!-- Performance & Notifications -->
        <div>
            <!-- Performance Metrics -->
            <div class="card" style="margin-bottom: 1.5rem;">
                <div class="card-header">
                    <h2 class="card-title">
                        <span>📊</span>
                        Your Performance
                    </h2>
                </div>
                <div class="card-body">
                    <div class="performance-metrics">
                        <div class="metric-item">
                            <span class="metric-value">
                                <asp:Literal ID="litTodayResolved" runat="server" Text="12" />
                            </span>
                            <div class="metric-label">Resolved Today</div>
                        </div>
                        <div class="metric-item">
                            <span class="metric-value">
                                <asp:Literal ID="litAvgRating" runat="server" Text="4.8" />
                            </span>
                            <div class="metric-label">Avg Rating</div>
                        </div>
                        <div class="metric-item">
                            <span class="metric-value">
                                <asp:Literal ID="litFirstCallRes" runat="server" Text="89%" />
                            </span>
                            <div class="metric-label">First Call Resolution</div>
                        </div>
                        <div class="metric-item">
                            <span class="metric-value">
                                <asp:Literal ID="litAvgHandleTime" runat="server" Text="4.2m" />
                            </span>
                            <div class="metric-label">Avg Handle Time</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Recent Notifications -->
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">
                        <span>🔔</span>
                        Recent Notifications
                    </h2>
                </div>
                <div class="card-body">
                    <asp:Repeater ID="rptNotifications" runat="server">
                        <ItemTemplate>
                            <div class="notification-item">
                                <div class="notification-title"><%# Eval("Title") %></div>
                                <div class="notification-text"><%# Eval("Message") %></div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </div>

    <!-- Recent Activity -->
    <div class="card" style="margin-bottom: 2rem;">
        <div class="card-header">
            <h2 class="card-title">
                <span>📋</span>
                Recent Activity
            </h2>
        </div>
        <div class="card-body">
            <div class="activity-feed">
                <asp:Repeater ID="rptActivity" runat="server">
                    <ItemTemplate>
                        <div class="activity-item">
                            <div class="activity-time"><%# Eval("Time", "{0:HH:mm}") %></div>
                            <div class="activity-content">
                                <div class="activity-title"><%# Eval("Title") %></div>
                                <div class="activity-description"><%# Eval("Description") %></div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>

    <!-- Quick Tools -->
    <div class="tools-grid">
        <div class="tool-card" onclick="location.href='QueueManagement.aspx'">
            <span class="tool-icon">📋</span>
            <div class="tool-title">Live Queue</div>
            <div class="tool-description">View and manage the complete customer queue</div>
        </div>
        
        <div class="tool-card" onclick="location.href='PredictiveDiagnostics.aspx'">
            <span class="tool-icon">🔮</span>
            <div class="tool-title">Predictive Tools</div>
            <div class="tool-description">AI-powered diagnostics and predictions</div>
        </div>
        
        <div class="tool-card" onclick="location.href='CustomerManagement.aspx'">
            <span class="tool-icon">👥</span>
            <div class="tool-title">Customer Database</div>
            <div class="tool-description">Search and manage customer information</div>
        </div>
        
        <div class="tool-card" onclick="location.href='RemoteTools.aspx'">
            <span class="tool-icon">🔧</span>
            <div class="tool-title">Remote Tools</div>
            <div class="tool-description">Remote diagnostics and troubleshooting</div>
        </div>
        
        <div class="tool-card" onclick="location.href='KnowledgeBase.aspx'">
            <span class="tool-icon">📚</span>
            <div class="tool-title">Knowledge Base</div>
            <div class="tool-description">Technical documentation and solutions</div>
        </div>
        
        <div class="tool-card" onclick="location.href='Analytics.aspx'">
            <span class="tool-icon">📈</span>
            <div class="tool-title">Analytics</div>
            <div class="tool-description">Performance analytics and insights</div>
        </div>
    </div>

    <!-- Hidden fields for JavaScript -->
    <asp:HiddenField ID="hfAgentId" runat="server" />

    <script type="text/javascript">
        var agentData = {
            id: '<%= hfAgentId.Value %>',
            name: '<%= Session["Username"] %>'
        };

        function assignToMe(queueId, customerName) {
            if (confirm('Assign ' + customerName + ' to your queue?')) {
                showLoading();
                
                setTimeout(() => {
                    hideLoading();
                    showNotification(customerName + ' has been assigned to you. Customer will be notified.', 'success');
                    
                    // Update UI
                    updateQueueItem(queueId, 'Assigned to You');
                    
                    // Refresh stats
                    __doPostBack('<%= Page.ClientID %>', 'assignCustomer:' + queueId);
                }, 1000);
            }
        }

        function viewDetails(queueId) {
            showLoading();
            
            setTimeout(() => {
                hideLoading();
                // In a real implementation, this would open a detailed modal or redirect
                location.href = 'CustomerManagement.aspx?id=' + queueId;
            }, 500);
        }

        function updateQueueItem(queueId, status) {
            var queueItems = document.querySelectorAll('.queue-item');
            queueItems.forEach(function(item) {
                // Update the specific queue item's status
                var buttons = item.querySelectorAll('.btn-primary');
                if (buttons.length > 0) {
                    buttons[0].textContent = status;
                    buttons[0].disabled = true;
                    buttons[0].style.background = 'var(--telkom-success)';
                }
            });
        }

        function showLoading() {
            // Show loading indicator
            document.body.style.cursor = 'wait';
        }

        function hideLoading() {
            document.body.style.cursor = 'default';
        }

        function showNotification(message, type = 'success') {
            // Create notification element
            var notification = document.createElement('div');
            notification.style.cssText = `
                position: fixed;
                top: 20px;
                right: 20px;
                background: var(--telkom-success);
                color: white;
                padding: 1rem 1.5rem;
                border-radius: 8px;
                box-shadow: 0 4px 16px rgba(0,0,0,0.1);
                z-index: 1001;
                transform: translateX(400px);
                transition: transform 0.3s ease;
            `;
            
            if (type === 'error') {
                notification.style.background = 'var(--telkom-error)';
            } else if (type === 'warning') {
                notification.style.background = 'var(--telkom-warning)';
            }
            
            notification.textContent = message;
            document.body.appendChild(notification);
            
            // Show notification
            setTimeout(() => {
                notification.style.transform = 'translateX(0)';
            }, 100);
            
            // Hide notification after 4 seconds
            setTimeout(() => {
                notification.style.transform = 'translateX(400px)';
                setTimeout(() => {
                    document.body.removeChild(notification);
                }, 300);
            }, 4000);
        }

        // Auto-refresh dashboard every 60 seconds
        setInterval(function() {
            if (typeof __doPostBack === 'function') {
                __doPostBack('<%= Page.ClientID %>', 'refreshDashboard');
            }
        }, 60000);

        // Initialize dashboard
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Agent Dashboard loaded for:', agentData.name);
        });
    </script>
</asp:Content>