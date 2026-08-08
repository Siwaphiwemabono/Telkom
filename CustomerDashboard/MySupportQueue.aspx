<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MySupportQueue.aspx.cs" Inherits="Telkom.CustomerDashboard.MySupportQueue" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Support Queue</title>
         <style>
    :root {
        --telkom-primary: #6366f1;
        --telkom-secondary: #8b5cf6;
        --telkom-success: #10b981;
        --telkom-warning: #f59e0b;
        --telkom-error: #ef4444;
        --telkom-white: #ffffff;
        --telkom-light-gray: #f8fafc;
        --telkom-medium-gray: #e2e8f0;
        --telkom-dark-gray: #64748b;
        --telkom-text: #1e293b;
        --telkom-border: #e2e8f0;
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
        background: var(--telkom-light-gray);
        min-height: 100vh;
        color: var(--telkom-text);
    }

    .main-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
    }

    .header-section {
        margin-bottom: 30px;
    }

    .main-title {
        font-size: 2rem;
        color: var(--telkom-primary);
    }

    .subtitle {
        color: var(--telkom-dark-gray);
    }

    .live-indicator {
        display: flex;
        align-items: center;
        gap: 10px;
        margin-top: 10px;
        font-weight: bold;
        color: var(--telkom-success);
    }

    .live-dot {
        width: 10px;
        height: 10px;
        background: var(--telkom-success);
        border-radius: 50%;
        animation: pulse 1.5s infinite;
    }

    @keyframes pulse {
        0%, 100% { transform: scale(1); }
        50% { transform: scale(1.4); }
    }

    .view-toggle {
        display: flex;
        gap: 10px;
        margin-bottom: 20px;
    }

    .toggle-btn {
        padding: 10px 20px;
        border: none;
        background: var(--telkom-medium-gray);
        color: var(--telkom-text);
        cursor: pointer;
        border-radius: 5px;
    }

    .toggle-btn.active {
        background: var(--telkom-primary);
        color: var(--telkom-white);
    }

    .queue-status-container {
        display: flex;
        gap: 20px;
        margin-bottom: 30px;
    }

    .queue-status-card {
        background: var(--telkom-white);
        padding: 20px;
        border-radius: 10px;
        flex: 2;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }

    .status-icon {
        font-size: 2rem;
    }

    .queue-position {
        font-size: 2rem;
        font-weight: bold;
        margin: 10px 0;
    }

    .progress-bar {
        background: var(--telkom-light-gray);
        border-radius: 10px;
        overflow: hidden;
        height: 15px;
        margin: 10px 0;
    }

    .progress-fill {
        background: var(--telkom-primary);
        width: 50%;
        height: 100%;
        transition: width 0.5s;
    }

    .time-estimates {
        display: flex;
        gap: 20px;
        margin-top: 10px;
    }

    .time-estimate .time-value {
        font-weight: bold;
    }

    .priority-badge {
        margin-top: 10px;
        padding: 5px 10px;
        background: var(--telkom-warning);
        color: var(--telkom-white);
        border-radius: 5px;
        display: inline-block;
    }

    .stats-panel {
        background: var(--telkom-white);
        padding: 20px;
        border-radius: 10px;
        flex: 1;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }

    .stat-row {
        display: flex;
        justify-content: space-between;
        margin: 10px 0;
    }

    .stat-value.success {
        color: var(--telkom-success);
        font-weight: bold;
    }

    .system-updates, .queue-section {
        background: var(--telkom-white);
        padding: 20px;
        border-radius: 10px;
        margin-bottom: 30px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }

    .update-item {
        padding: 10px 0;
        border-bottom: 1px solid var(--telkom-medium-gray);
    }

    .queue-items {
        margin-top: 15px;
    }

    .queue-item {
        padding: 15px;
        border: 1px solid var(--telkom-border);
        border-radius: 8px;
        margin-bottom: 10px;
    }

    .queue-item.priority-item {
        border-left: 5px solid var(--telkom-warning);
    }

    .item-header {
        display: flex;
        justify-content: space-between;
        margin-bottom: 5px;
    }

    .status-badge {
        padding: 2px 8px;
        border-radius: 5px;
        background: var(--telkom-secondary);
        color: var(--telkom-white);
        font-size: 0.9rem;
    }

    .action-buttons {
        margin-top: 10px;
        display: flex;
        gap: 10px;
    }

    .btn {
        padding: 5px 10px;
        border-radius: 5px;
        border: none;
        cursor: pointer;
    }

    .btn-primary {
        background: var(--telkom-primary);
        color: var(--telkom-white);
    }

    .btn-secondary {
        background: var(--telkom-secondary);
        color: var(--telkom-white);
    }

    .btn-outline {
        background: transparent;
        border: 1px solid var(--telkom-primary);
        color: var(--telkom-primary);
    }

    .loading-overlay {
        display: none;
        position: fixed;
        top: 0; left: 0;
        width: 100%; height: 100%;
        background: rgba(0,0,0,0.5);
        z-index: 9999;
        justify-content: center;
        align-items: center;
    }

    .loading-overlay .spinner {
        width: 50px;
        height: 50px;
        border: 6px solid #f3f3f3;
        border-top: 6px solid var(--telkom-primary);
        border-radius: 50%;
        animation: spin 1s linear infinite;
    }

    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }

    .notification {
        position: fixed;
        bottom: 20px;
        right: 20px;
        background: var(--telkom-primary);
        color: var(--telkom-white);
        padding: 10px 20px;
        border-radius: 8px;
        display: none;
        z-index: 10000;
    }
</style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        
        <div class="main-container">
            <!-- Header -->
            <div class="header-section">
                <h1 class="main-title">Support Queue</h1>
                <p class="subtitle">Real-time queue management and predictive support</p>
                <div class="live-indicator">
                    <div class="live-dot"></div>
                    Live updates active
                </div>
            </div>

            <!-- Toggle for Agent/Admin -->
            <asp:Panel ID="pnlViewToggle" runat="server" Visible="false">
                <div class="view-toggle">
                    <asp:Button ID="btnCustomerView" runat="server" Text="Customer Queue" CssClass="toggle-btn active" OnClick="btnCustomerView_Click" />
                    <asp:Button ID="btnAgentView" runat="server" Text="Predictive Diagnostics" CssClass="toggle-btn" OnClick="btnAgentView_Click" />
                </div>
            </asp:Panel>

            <!-- UpdatePanel for automatic refresh -->
            <asp:UpdatePanel ID="UpdatePanelQueue" runat="server">
                <ContentTemplate>
                    <!-- Stats Panel -->
                    <div class="stats-panel">
                        <div class="stat-row">
                            <span>Agents Online:</span>
                            <asp:Literal ID="litAgentsOnline" runat="server"></asp:Literal>
                        </div>
                        <div class="stat-row">
                            <span>Average Wait Time:</span>
                            <asp:Literal ID="litAvgWaitTime" runat="server"></asp:Literal>
                        </div>
                        <div class="stat-row">
                            <span>Total in Queue:</span>
                            <asp:Literal ID="litTotalInQueue" runat="server"></asp:Literal>
                        </div>
                        <div class="stat-row">
                            <span>Resolved Today:</span>
                            <asp:Literal ID="litResolvedToday" runat="server"></asp:Literal>
                        </div>
                    </div>

                    <!-- Customer Queue -->
                    <asp:Panel ID="pnlCustomerQueueStatus" runat="server" Visible="true">
                        <div class="queue-status-container">
                            <div class="queue-status-card">
                                <div class="stat-row">
                                    <span>Queue Position:</span>
                                    <asp:Literal ID="litQueuePosition" runat="server"></asp:Literal>
                                </div>
                                <div class="stat-row">
                                    <span>People Ahead:</span>
                                    <asp:Literal ID="litPeopleAhead" runat="server"></asp:Literal>
                                </div>
                                <div class="stat-row">
                                    <span>Estimated Wait:</span>
                                    <asp:Literal ID="litEstimatedWait" runat="server"></asp:Literal>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>

                    <!-- System Updates -->
                    <div class="system-updates">
                        <h2 class="section-title">AI System Updates</h2>
                        <asp:Repeater ID="rptSystemUpdates" runat="server">
                            <ItemTemplate>
                                <div class="update-item">
                                    <span class="update-type"><%# Eval("UpdateType") %></span>
                                    <span class="update-message"><%# Eval("Message") %></span>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <!-- Customer View -->
                    <asp:Panel ID="pnlCustomerView" runat="server" Visible="true">
                        <div class="queue-section">
                            <h2 class="section-title">Queue Status</h2>
                            <div class="queue-items">
                                <asp:Repeater ID="rptCustomerQueue" runat="server">
                                    <ItemTemplate>
                                        <div class="queue-item customer-item">
                                            <div class="item-header">
                                                <h3 class="customer-name"><%# Eval("CustomerName") %></h3>
                                                <span class="status-badge"><%# Eval("Status") %></span>
                                            </div>
                                            <p class="issue-description"><%# Eval("IssueDescription") %></p>
                                            <div class="action-buttons">
                                                <button class="btn btn-primary" onclick="viewDetails('<%# Eval("CustomerName") %>')">View Details</button>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                    </asp:Panel>

                    <!-- Agent View -->
                    <asp:Panel ID="pnlAgentView" runat="server" Visible="false">
                        <div class="queue-section">
                            <h2 class="section-title">Predictive Diagnostics</h2>
                            <div class="queue-items">
                                <asp:Repeater ID="rptAgentQueue" runat="server">
                                    <ItemTemplate>
                                        <div class="queue-item agent-item <%# Eval("Priority").ToString() == "High" ? "priority-item" : "" %>">
                                            <div class="item-header">
                                                <h3 class="customer-name"><%# Eval("CustomerName") %> — <%# Eval("IssueTitle") %></h3>
                                                <span class="status-badge"><%# Eval("Status") %></span>
                                            </div>
                                            <div class="diagnostics-info">
                                                <p><strong>Ping to gateway:</strong> <%# Eval("PingStatus") %></p>
                                                <p><strong>DNS Resolution:</strong> <%# Eval("DNSStatus") %></p>
                                                <p><strong>Signal Strength:</strong> <%# Eval("SignalStatus") %></p>
                                                <p><strong>Confidence:</strong> <%# Eval("Confidence") %></p>
                                                <p><strong>Predicted Time:</strong> <%# Eval("PredictedTime") %></p>
                                                <p><strong>Resolution Attempts:</strong> <%# Eval("Attempts") %></p>
                                            </div>
                                            <div class="action-buttons">
                                                <button class="btn btn-primary" onclick="assignToSelf('<%# Eval("CustomerName") %>')">Assign to Me</button>
                                                <button class="btn btn-secondary" onclick="runDiagnostics('<%# Eval("CustomerName") %>')">Run Diagnostics</button>
                                                <button class="btn btn-outline" onclick="viewHistory('<%# Eval("CustomerName") %>')">View History</button>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                    </asp:Panel>

                    <!-- Timer -->
                    <asp:Timer ID="TimerQueue" runat="server" Interval="10000" OnTick="TimerQueue_Tick" />
                </ContentTemplate>
            </asp:UpdatePanel>

        </div>

        <!-- Loading Overlay -->
        <div class="loading-overlay" id="loadingOverlay">
            <div class="spinner"></div>
        </div>

        <!-- Notification -->
        <div class="notification" id="notification"></div>

        <!-- Hidden Fields -->
        <asp:HiddenField ID="hfQueuePosition" runat="server" Value="3" />
        <asp:HiddenField ID="hfIsAgent" runat="server" Value="false" />
        <asp:HiddenField ID="hfUserId" runat="server" />
    </form>
</body>
</html>
