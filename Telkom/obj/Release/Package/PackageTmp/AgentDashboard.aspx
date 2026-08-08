<%@ Page Title="Agent Dashboard" Language="C#" MasterPageFile="~/Agent.Master" AutoEventWireup="true" CodeBehind="AgentDashboard.aspx.cs" Inherits="Telkom.AgentDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Dashboard specific styles with glassmorphism */
        .welcome-header {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            padding: 2rem;
            border-radius: 12px;
            margin-bottom: 2rem;
            box-shadow: var(--glass-shadow);
            border: var(--glass-border);
        }

        .welcome-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1.5rem;
        }

        .welcome-text h1 {
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            background: var(--gradient-bg);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .welcome-text p {
            color: var(--telkom-dark-gray);
            font-size: 1.1rem;
            opacity: 0.9;
        }

        .agent-info {
            text-align: right;
            background: var(--glass-bg);
            backdrop-filter: blur(5px);
            padding: 1rem 1.5rem;
            border-radius: 12px;
            border: var(--glass-border);
        }

        .agent-name {
            font-size: 1.3rem;
            font-weight: 600;
            color: var(--telkom-text);
            margin-bottom: 0.25rem;
        }

        .agent-id {
            color: var(--telkom-dark-gray);
            font-size: 0.9rem;
            font-weight: 500;
        }

        .dashboard-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2.5rem;
        }

        .dashboard-stat-card {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            padding: 1.75rem;
            border-radius: 12px;
            border: var(--glass-border);
            text-align: center;
            box-shadow: var(--glass-shadow);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .dashboard-stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--gradient-bg);
        }

        .dashboard-stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 28px rgba(0, 0, 0, 0.25);
            background: rgba(255, 255, 255, 0.15);
        }

        .stat-number {
            font-size: 2.4rem;
            font-weight: 700;
            color: var(--telkom-green);
            margin-bottom: 0.5rem;
            text-shadow: 0 2px 4px rgba(102, 204, 0, 0.2);
        }

        .stat-label {
            color: var(--telkom-dark-gray);
            font-size: 0.95rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2.5rem;
        }

        .action-card {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border-radius: 12px;
            padding: 1.75rem;
            box-shadow: var(--glass-shadow);
            border: var(--glass-border);
            transition: all 0.3s ease;
        }

        .action-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 28px rgba(0, 0, 0, 0.25);
            background: rgba(255, 255, 255, 0.15);
        }

        .action-header {
            display: flex;
            align-items: center;
            margin-bottom: 1.25rem;
        }

        .action-icon {
            width: 50px;
            height: 50px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-size: 1.5rem;
            color: var(--telkom-white);
            background: var(--gradient-bg);
            box-shadow: 0 4px 15px rgba(0, 119, 204, 0.3);
        }

        .action-title {
            font-size: 1.3rem;
            font-weight: 600;
            color: var(--telkom-text);
            margin-bottom: 0.5rem;
        }

        .action-description {
            color: var(--telkom-dark-gray);
            font-size: 0.95rem;
            margin-bottom: 1.5rem;
            line-height: 1.5;
        }

        .action-btn {
            background: var(--gradient-bg);
            color: var(--telkom-white);
            border: none;
            padding: 0.85rem 1.75rem;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.9rem;
            box-shadow: 0 4px 15px rgba(0, 119, 204, 0.3);
        }

        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 119, 204, 0.4);
        }

        .recent-activity {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border-radius: 12px;
            padding: 2rem;
            box-shadow: var(--glass-shadow);
            border: var(--glass-border);
        }

        .activity-header {
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            padding-bottom: 1rem;
            margin-bottom: 1.5rem;
        }

        .activity-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--telkom-text);
            background: var(--gradient-bg);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .activity-item {
            display: flex;
            align-items: center;
            padding: 1rem 0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        .activity-time {
            width: 80px;
            color: var(--telkom-dark-gray);
            font-size: 0.9rem;
            font-weight: 500;
        }

        .activity-content {
            flex-grow: 1;
            color: var(--telkom-text);
            font-size: 0.95rem;
        }

        .activity-badge {
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .badge-resolved { 
            background: rgba(40, 167, 69, 0.2); 
            color: #28a745; 
            border: 1px solid rgba(40, 167, 69, 0.3);
        }
        
        .badge-assigned { 
            background: rgba(0, 123, 255, 0.2); 
            color: #007bff; 
            border: 1px solid rgba(0, 123, 255, 0.3);
        }
        
        .badge-call { 
            background: rgba(255, 193, 7, 0.2); 
            color: #ffc107; 
            border: 1px solid rgba(255, 193, 7, 0.3);
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .welcome-content {
                flex-direction: column;
                text-align: center;
                gap: 1.5rem;
            }
            
            .agent-info {
                text-align: center;
            }
            
            .dashboard-stats {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .quick-actions {
                grid-template-columns: 1fr;
            }
            
            .action-header {
                flex-direction: column;
                text-align: center;
                gap: 1rem;
            }
            
            .action-icon {
                margin-right: 0;
            }
        }

        @media (max-width: 480px) {
            .dashboard-stats {
                grid-template-columns: 1fr;
            }
            
            .welcome-text h1 {
                font-size: 1.8rem;
            }
            
            .stat-number {
                font-size: 2rem;
            }
            
            .activity-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.5rem;
            }
            
            .activity-time {
                width: 100%;
            }
        }

        /* Animation for cards */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .dashboard-stat-card, .action-card, .recent-activity {
            animation: fadeInUp 0.5s ease-out forwards;
        }

        .dashboard-stat-card:nth-child(2) { animation-delay: 0.1s; }
        .dashboard-stat-card:nth-child(3) { animation-delay: 0.2s; }
        .dashboard-stat-card:nth-child(4) { animation-delay: 0.3s; }
        .action-card:nth-child(2) { animation-delay: 0.4s; }
        .action-card:nth-child(3) { animation-delay: 0.5s; }
        .recent-activity { animation-delay: 0.6s; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Welcome Header -->
    <div class="welcome-header">
        <div class="welcome-content">
            <div class="welcome-text">
                <h1>Agent Dashboard</h1>
                <p>Your support workspace overview</p>
            </div>
            <div class="agent-info">
                <div class="agent-name">
                    <asp:Literal ID="litAgentName" runat="server" Text="Sarah Johnson" />
                </div>
                <div class="agent-id">Agent ID: AG-2024-003</div>
            </div>
        </div>
    </div>

    <!-- Dashboard Stats -->
    <div class="dashboard-stats">
        <div class="dashboard-stat-card">
            <span class="stat-number" id="customersInQueue">
                <asp:Literal ID="litCustomersInQueue" runat="server" Text="23" />
            </span>
            <div class="stat-label">Customers in Queue</div>
        </div>
        <div class="dashboard-stat-card">
            <span class="stat-number" id="resolvedToday">
                <asp:Literal ID="litResolvedToday" runat="server" Text="15" />
            </span>
            <div class="stat-label">Resolved Today</div>
        </div>
        <div class="dashboard-stat-card">
            <span class="stat-number" id="avgWaitTime">
                <asp:Literal ID="litAvgWaitTime" runat="server" Text="8.5m" />
            </span>
            <div class="stat-label">Avg Wait Time</div>
        </div>
        <div class="dashboard-stat-card">
            <span class="stat-number" id="satisfactionRate">
                <asp:Literal ID="litSatisfactionRate" runat="server" Text="96%" />
            </span>
            <div class="stat-label">Satisfaction Rate</div>
        </div>
    </div>

    <!-- Quick Actions -->
    <div class="quick-actions">
        <div class="action-card">
            <div class="action-header">
                <div class="action-icon">📋</div>
                <div>
                    <div class="action-title">Queue Management</div>
                    <div class="action-description">View customers waiting for assistance and assign technicians</div>
                </div>
            </div>
            <button class="action-btn" onclick="navigateToQueue()">Manage Queue</button>
        </div>

        <div class="action-card">
            <div class="action-header">
                <div class="action-icon">🔮</div>
                <div>
                    <div class="action-title">Predictive Diagnostics</div>
                    <div class="action-description">AI-powered diagnostics and issue predictions</div>
                </div>
            </div>
            <button class="action-btn" onclick="navigateToPredictive()">Open Tools</button>
        </div>

        <div class="action-card">
            <div class="action-header">
                <div class="action-icon">👥</div>
                <div>
                    <div class="action-title">Customer Management</div>
                    <div class="action-description">Search and manage customer information</div>
                </div>
            </div>
            <button class="action-btn" onclick="navigateToCustomers()">View Customers</button>
        </div>
    </div>

    <!-- Recent Activity -->
    <div class="recent-activity">
        <div class="activity-header">
            <div class="activity-title">Recent Activity</div>
        </div>
        <div id="activityList">
            <asp:Repeater ID="rptActivity" runat="server">
                <ItemTemplate>
                    <div class="activity-item">
                        <div class="activity-time"><%# Eval("Time", "{0:HH:mm}") %></div>
                        <div class="activity-content"><%# Eval("Description") %></div>
                        <span class="activity-badge badge-<%# Eval("Type") %>"><%# Eval("Type") %></span>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

    <script>
        // Initialize dashboard
        document.addEventListener('DOMContentLoaded', function () {
            updateStats();
            startRealTimeUpdates();

            // Add animation classes to elements
            document.querySelectorAll('.dashboard-stat-card, .action-card, .recent-activity').forEach((el, index) => {
                el.style.animationDelay = `${index * 0.1}s`;
            });
        });

        function updateStats() {
            // Simulate real-time stat updates
            var queueCount = Math.floor(Math.random() * 10) + 15;
            var resolvedCount = Math.floor(Math.random() * 5) + 12;
            var waitTime = (Math.random() * 5 + 5).toFixed(1);
            var satisfaction = (Math.random() * 5 + 94).toFixed(0);

            document.getElementById('customersInQueue').textContent = queueCount;
            document.getElementById('resolvedToday').textContent = resolvedCount;
            document.getElementById('avgWaitTime').textContent = waitTime + 'm';
            document.getElementById('satisfactionRate').textContent = satisfaction + '%';
        }

        function startRealTimeUpdates() {
            // Update stats every 30 seconds
            setInterval(() => {
                updateStats();
            }, 30000);
        }

        // Navigation functions
        function navigateToQueue() {
            window.location.href = 'QueueManagement.aspx';
        }

        function navigateToPredictive() {
            window.location.href = 'PredictiveDiagnostics.aspx';
        }

        function navigateToCustomers() {
            window.location.href = 'CustomerManagement.aspx';
        }
    </script>
</asp:Content>