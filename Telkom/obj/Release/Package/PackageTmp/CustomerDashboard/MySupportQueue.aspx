<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/CustomerDashboard/Customer.Master" CodeBehind="MySupportQueue.aspx.cs" Inherits="Telkom.CustomerDashboard.MySupportQueue" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        :root {
            --telkom-blue: #0077CC;
            --telkom-green: #99FF33;
            --telkom-dark-blue: #003366;
            --telkom-white: #FFFFFF;
            --telkom-soft-white: #F5F7FB;
            --telkom-black: #0A0A0A;
            --telkom-dark-gray: #1F1F1F;
            --gradient-bg: linear-gradient(135deg, #004080 0%, #66CC00 100%);
            --glass-bg: rgba(255, 255, 255, 0.1);
            --glass-border: 1px solid rgba(255, 255, 255, 0.3);
            --glass-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
            --priority-critical: #D32F2F;
            --priority-high: #F57C00;
            --priority-medium: #388E3C;
            --priority-normal: #1976D2;
        }

        /* Welcome Section */
        .welcome-section {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: var(--glass-shadow);
            animation: fadeIn 0.5s ease forwards;
        }

        .welcome-section h3 {
            font-size: 1.6rem;
            font-weight: 700;
            color: var(--telkom-dark-gray);
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .welcome-section p {
            font-size: 1.1rem;
            color: var(--telkom-dark-gray);
            opacity: 0.9;
            margin-bottom: 20px;
        }

        .welcome-section ul {
            list-style: none;
            padding: 0;
        }

        .welcome-section li {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 1rem;
            color: var(--telkom-dark-gray);
            margin-bottom: 10px;
        }

        .welcome-section i {
            color: var(--telkom-green);
        }

        /* Real-time Status Indicators */
        .status-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: var(--telkom-white);
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
            box-shadow: var(--glass-shadow);
        }

        .status-item {
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 500;
        }

        .status-dot {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            animation: pulse 2s infinite;
        }

        .status-dot.active { background: var(--telkom-green); }
        .status-dot.pending { background: #FFC107; }
        .status-dot.high { background: var(--priority-high); }
        .status-dot.critical { background: var(--priority-critical); }

        @keyframes pulse {
            0% { opacity: 1; }
            50% { opacity: 0.5; }
            100% { opacity: 1; }
        }

        /* Illustration */
        .illustration {
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
        }

        .illustration svg {
            width: 150px;
            height: 150px;
            transition: transform 0.3s ease;
        }

        .illustration svg:hover {
            transform: scale(1.05);
        }

        /* Queue Table */
        .queue-panel {
            background: var(--telkom-white);
            border-radius: 12px;
            padding: 25px;
            box-shadow: var(--glass-shadow);
            animation: slideUp 0.5s ease forwards;
            overflow-x: auto;
            position: relative;
        }

        .queue-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .queue-title {
            font-size: 1.4rem;
            font-weight: 600;
            color: var(--telkom-dark-gray);
        }

        .last-updated {
            font-size: 0.9rem;
            color: var(--telkom-dark-gray);
            opacity: 0.7;
        }

        .queue-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 1rem;
            color: var(--telkom-dark-gray);
        }

        .queue-table th,
        .queue-table td {
            padding: 15px 12px;
            text-align: left;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            vertical-align: middle;
        }

        .queue-table th {
            background: var(--gradient-bg);
            color: var(--telkom-white);
            font-weight: 600;
            position: sticky;
            top: 0;
            z-index: 10;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
        }

        .queue-table tr:last-child td {
            border-bottom: none;
        }

        .queue-table tr:nth-child(even) {
            background: var(--telkom-soft-white);
        }

        .queue-table tr:hover {
            background: rgba(0, 119, 204, 0.1);
            transition: background 0.3s ease;
            transform: scale(1.01);
        }

        /* Priority Badges */
        .priority-badge {
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .priority-critical {
            background: #FFE5E5;
            color: var(--priority-critical);
            border: 1px solid var(--priority-critical);
        }

        .priority-high {
            background: #FFF3E0;
            color: var(--priority-high);
            border: 1px solid var(--priority-high);
        }

        .priority-medium {
            background: #E8F5E8;
            color: var(--priority-medium);
            border: 1px solid var(--priority-medium);
        }

        .priority-normal {
            background: #E3F2FD;
            color: var(--priority-normal);
            border: 1px solid var(--priority-normal);
        }

        /* Status Badges */
        .status-badge {
            padding: 6px 12px;
            border-radius: 16px;
            font-size: 0.8rem;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .status-queue {
            background: #FFF3E0;
            color: #E65100;
        }

        .status-progress {
            background: #E3F2FD;
            color: #1976D2;
        }

        .status-resolved {
            background: #E8F5E8;
            color: #2E7D32;
        }

        .status-scheduled {
            background: #F3E5F5;
            color: #7B1FA2;
        }

        /* Queue Position Indicator */
        .queue-position {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 30px;
            height: 30px;
            background: var(--telkom-blue);
            color: var(--telkom-white);
            border-radius: 50%;
            font-weight: 600;
            font-size: 0.9rem;
        }

        .empty-message {
            text-align: center;
            padding: 60px 30px;
            color: var(--telkom-dark-gray);
            opacity: 0.7;
        }

        .empty-message i {
            font-size: 4rem;
            color: var(--telkom-blue);
            margin-bottom: 20px;
            opacity: 0.5;
        }

        .empty-message h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: var(--telkom-dark-gray);
        }

        .empty-message p {
            font-size: 1.1rem;
            margin-bottom: 20px;
        }

        /* Button Styles */
        .btn {
            padding: 12px 20px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            position: relative;
            overflow: hidden;
            text-decoration: none;
        }

        .btn-primary {
            background: var(--gradient-bg);
            color: var(--telkom-white);
            box-shadow: var(--glass-shadow);
        }

        .btn-primary:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
        }

        .btn-secondary {
            background: var(--glass-bg);
            color: var(--telkom-dark-gray);
            border: var(--glass-border);
        }

        .btn-secondary:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: scale(1.05);
        }

        .btn-small {
            padding: 8px 12px;
            font-size: 0.85rem;
        }

        .btn-refresh {
            background: var(--telkom-green);
            color: var(--telkom-white);
        }

        .btn-refresh:hover {
            background: #7ACC00;
        }

        /* Action Buttons */
        .actions-cell {
            display: flex;
            gap: 8px;
            align-items: center;
        }

        /* Loading Animation */
        .loading-overlay {
            display: none;
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: var(--glass-bg);
            backdrop-filter: blur(5px);
            z-index: 100;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            border-radius: 12px;
        }

        .loading-spinner {
            width: 40px;
            height: 40px;
            border: 4px solid var(--telkom-white);
            border-top: 4px solid var(--telkom-blue);
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin-bottom: 15px;
        }

        .loading-text {
            color: var(--telkom-dark-gray);
            font-weight: 500;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .fade-in {
            animation: fadeIn 0.5s ease forwards;
        }

        .slide-up {
            animation: slideUp 0.5s ease forwards;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideUp {
            from { transform: translateY(20px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        /* Auto-refresh indicator */
        .refresh-indicator {
            position: fixed;
            top: 20px;
            right: 20px;
            background: var(--telkom-blue);
            color: var(--telkom-white);
            padding: 8px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            opacity: 0;
            transition: opacity 0.3s ease;
            z-index: 1000;
        }

        .refresh-indicator.show {
            opacity: 1;
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .queue-panel {
                padding: 20px;
            }
            
            .status-bar {
                flex-direction: column;
                gap: 10px;
                align-items: flex-start;
            }
        }

        @media (max-width: 768px) {
            .queue-table {
                font-size: 0.9rem;
            }
            
            .queue-table th,
            .queue-table td {
                padding: 10px 8px;
            }
            
            .btn {
                padding: 8px 12px;
                font-size: 0.85rem;
            }
        }

        @media (max-width: 576px) {
            .welcome-section h3 {
                font-size: 1.4rem;
            }

            .illustration svg {
                width: 120px;
                height: 120px;
            }

            .queue-table th,
            .queue-table td {
                padding: 8px 6px;
                font-size: 0.8rem;
            }

            .priority-badge,
            .status-badge {
                font-size: 0.7rem;
                padding: 3px 6px;
            }
        }
    </style>

    <!-- Auto-refresh indicator -->
    <div class="refresh-indicator" id="refreshIndicator">
        <i class="fas fa-sync-alt"></i> Auto-refreshing queue...
    </div>

    <!-- Welcome Section -->
    <div class="welcome-section">
        <h3>
            <i class="fas fa-clipboard-list"></i>
            My Support Queue - Real-Time
        </h3>
        <p>Track your support tickets in real-time with live queue positions, estimated wait times, and department routing.</p>
        <ul>
            <li><i class="fas fa-ticket-alt"></i> View real-time queue positions and estimated wait times</li>
            <li><i class="fas fa-users"></i> See which department and agent is handling your case</li>
            <li><i class="fas fa-clock"></i> Priority tickets are automatically escalated based on wait time</li>
            <li><i class="fas fa-sync-alt"></i> Page auto-refreshes every 30 seconds for live updates</li>
        </ul>
    </div>

    <!-- Status Bar -->
    <div class="status-bar">
        <div class="status-item">
            <div class="status-dot active"></div>
            <span>System Status: Online</span>
        </div>
        <div class="status-item">
            <div class="status-dot pending"></div>
            <span>Queue Updates: Live</span>
        </div>
        <div class="status-item">
            <i class="fas fa-clock"></i>
            <span>Last Updated: <span id="lastUpdateTime"><%= DateTime.Now.ToString("HH:mm:ss") %></span></span>
        </div>
    </div>

    <!-- Illustration -->
    <div class="illustration">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 200">
            <rect x="30" y="40" width="140" height="120" rx="10" fill="none" stroke="var(--telkom-blue)" stroke-width="8"/>
            <path d="M50 60 H150 M50 80 H130 M50 100 H140 M50 120 H120" fill="none" stroke="var(--telkom-green)" stroke-width="4"/>
            <circle cx="160" cy="70" r="8" fill="var(--telkom-green)"/>
            <circle cx="160" cy="90" r="8" fill="#FFC107"/>
            <circle cx="160" cy="110" r="8" fill="var(--priority-high)"/>
            <path d="M40 170 Q100 150 160 170" fill="none" stroke="var(--telkom-blue)" stroke-width="6"/>
        </svg>
    </div>

    <!-- Support Queue Panel -->
    <div class="queue-panel">
        <div class="loading-overlay" id="loadingOverlay">
            <div class="loading-spinner"></div>
            <div class="loading-text">Updating queue positions...</div>
        </div>
        
        <div class="queue-header">
            <h3 class="queue-title">Active Support Tickets</h3>
            <asp:Button ID="btnRefreshQueue" runat="server" Text="Refresh Now" CssClass="btn btn-refresh btn-small" OnClick="btnRefreshQueue_Click" ClientIDMode="Static" />
        </div>

        <asp:GridView ID="gvSupportQueue" runat="server" AutoGenerateColumns="False" 
                      CssClass="queue-table" GridLines="None" 
                      OnRowDataBound="gvSupportQueue_RowDataBound">
            <Columns>
                <asp:TemplateField HeaderText="Ticket #">
                    <ItemTemplate>
                        <strong><%# Eval("TicketID") %></strong><br />
                        <small style="opacity: 0.7;"><%# ((DateTime)Eval("CreatedDate")).ToString("MMM dd, HH:mm") %></small>
                    </ItemTemplate>
                </asp:TemplateField>
                
                <asp:TemplateField HeaderText="Issue Details">
                    <ItemTemplate>
                        <strong><%# Eval("IssueType") %></strong><br />
                        <small style="color: var(--telkom-blue);"><%# Eval("Category") %></small>
                    </ItemTemplate>
                </asp:TemplateField>
                
                <asp:TemplateField HeaderText="Department">
                    <ItemTemplate>
                        <%# Eval("Department") %><br />
                        <small style="opacity: 0.7;">Agent: <%# Eval("AssignedAgent") %></small>
                    </ItemTemplate>
                </asp:TemplateField>
                
                <asp:TemplateField HeaderText="Priority">
                    <ItemTemplate>
                        <span class='priority-badge priority-<%# Eval("Priority").ToString().ToLower() %>'>
                            <%# Eval("Priority") %>
                        </span>
                    </ItemTemplate>
                </asp:TemplateField>
                
                <asp:TemplateField HeaderText="Status & Position">
                    <ItemTemplate>
                        <div style="display: flex; align-items: center; gap: 8px;">
                            <%# Convert.ToInt32(Eval("QueuePosition")) > 0 ? $"<div class='queue-position'>{Eval("QueuePosition")}</div>" : "" %>
                            <div>
                                <div class='status-badge status-<%# GetStatusClass(Eval("Status").ToString()) %>'>
                                    <%# Eval("Status") %>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
                
                <asp:TemplateField HeaderText="Wait Time">
                    <ItemTemplate>
                        <strong><%# Eval("EstimatedWait") %></strong>
                    </ItemTemplate>
                </asp:TemplateField>
                
                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <div class="actions-cell">
                            <asp:Button ID="btnCancelTicket" runat="server" 
                                       Text="Cancel" 
                                       CssClass="btn btn-secondary btn-small"
                                       CommandArgument='<%# Eval("TicketID") %>'
                                       OnClick="btnCancelTicket_Click"
                                       OnClientClick="return confirm('Are you sure you want to cancel this ticket?')"
                                       Visible='<%# !Eval("Status").ToString().Contains("Resolved") %>' />
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            
            <EmptyDataTemplate>
                <div class="empty-message">
                    <i class="fas fa-clipboard-check"></i>
                    <h3>No Support Tickets</h3>
                    <p>You don't have any active support tickets at the moment.</p>
                    <asp:Button ID="btnBackToTroubleshooter" runat="server" 
                               Text="Start AI Troubleshooter" 
                               CssClass="btn btn-primary" 
                               PostBackUrl="~/CustomerDashboard/AITroubleshooter.aspx" />
                </div>
            </EmptyDataTemplate>
        </asp:GridView>
        
        <div style="margin-top: 20px; display: flex; gap: 15px; align-items: center;">
            <asp:Button ID="btnBackToTroubleshooter" runat="server" 
                       Text="Back to AI Troubleshooter" 
                       CssClass="btn btn-primary" 
                       PostBackUrl="~/CustomerDashboard/AITroubleshooter.aspx" 
                       ClientIDMode="Static" />
            <div style="flex: 1;"></div>
            <small style="color: var(--telkom-dark-gray); opacity: 0.7;">
                <i class="fas fa-sync-alt"></i> Queue updates every 30 seconds
            </small>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            let refreshTimer;
            let countdown = 30;

            // Show loading animation briefly on page load
            const loadingOverlay = document.getElementById('loadingOverlay');
            if (loadingOverlay) {
                loadingOverlay.style.display = 'flex';
                setTimeout(() => {
                    loadingOverlay.style.display = 'none';
                }, 1000);
            }

            // Update last updated time
            function updateLastUpdateTime() {
                const timeElement = document.getElementById('lastUpdateTime');
                if (timeElement) {
                    const now = new Date();
                    timeElement.textContent = now.toLocaleTimeString();
                }
            }

            // Show refresh indicator
            function showRefreshIndicator() {
                const indicator = document.getElementById('refreshIndicator');
                if (indicator) {
                    indicator.classList.add('show');
                    setTimeout(() => {
                        indicator.classList.remove('show');
                    }, 2000);
                }
            }

            // Simulate real-time queue updates
            function simulateQueueUpdates() {
                const positions = document.querySelectorAll('.queue-position');
                positions.forEach(position => {
                    const currentPos = parseInt(position.textContent);
                    if (currentPos > 1 && Math.random() < 0.3) { // 30% chance to move up
                        position.textContent = currentPos - 1;
                        position.style.animation = 'pulse 1s ease';
                    }
                });
            }

            // Update wait times
            function updateWaitTimes() {
                const waitElements = document.querySelectorAll('td:nth-child(6) strong');
                waitElements.forEach(element => {
                    const waitText = element.textContent;
                    if (waitText.includes('minutes') && !waitText.includes('Any moment')) {
                        const minutes = parseInt(waitText);
                        if (minutes > 1) {
                            const newMinutes = Math.max(1, minutes - 1);
                            element.textContent = newMinutes + ' minutes';
                        } else if (minutes === 1) {
                            element.textContent = 'Any moment now';
                            element.style.color = 'var(--telkom-green)';
                        }
                    }
                });
            }

            // Manual refresh button
            const refreshButton = document.getElementById('btnRefreshQueue');
            if (refreshButton) {
                refreshButton.addEventListener('click', function () {
                    showRefreshIndicator();
                    updateLastUpdateTime();
                });
            }

            // Simulate periodic updates (for demo purposes)
            setInterval(() => {
                simulateQueueUpdates();
                updateWaitTimes();
                showRefreshIndicator();
            }, 30000); // Every 30 seconds

            // Add hover effects to table rows
            const rows = document.querySelectorAll('.queue-table tr');
            rows.forEach(row => {
                if (!row.querySelector('th')) { // Skip header row
                    row.addEventListener('mouseenter', () => {
                        row.style.transform = 'scale(1.01)';
                        row.style.boxShadow = '0 4px 8px rgba(0,0,0,0.1)';
                    });

                    row.addEventListener('mouseleave', () => {
                        row.style.transform = 'scale(1)';
                        row.style.boxShadow = 'none';
                    });
                }
            });

            updateLastUpdateTime();
        });

        // Helper function for status class (used in GridView)
        function GetStatusClass(status) {
            if (status.includes('Queue')) return 'queue';
            if (status.includes('Being') || status.includes('Progress')) return 'progress';
            if (status.includes('Resolved') || status.includes('Completed')) return 'resolved';
            if (status.includes('Scheduled') || status.includes('Today')) return 'scheduled';
            return 'queue';
        }
    </script>
</asp:Content>