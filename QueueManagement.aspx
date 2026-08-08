<%@ Page Title="Queue Management" Language="C#" MasterPageFile="~/Agent.Master" AutoEventWireup="true" CodeBehind="QueueManagement.aspx.cs" Inherits="Telkom.QueueManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .queue-controls {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .filter-controls {
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        .filter-group {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }

        .filter-label {
            font-size: 0.875rem;
            color: var(--telkom-dark-gray);
            font-weight: 500;
        }

        .filter-select {
            padding: 0.5rem;
            border: 1px solid var(--telkom-border);
            border-radius: 4px;
            min-width: 120px;
        }

        .action-controls {
            display: flex;
            gap: 0.75rem;
        }

        .btn {
            padding: 0.6rem 1.2rem;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.2s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.9rem;
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

        .btn-success {
            background: var(--telkom-success);
            color: white;
        }

        .btn-success:hover {
            background: #059669;
        }

        .queue-grid {
            display: grid;
            gap: 1rem;
        }

        .queue-item {
            background: white;
            border-radius: 8px;
            border: 1px solid var(--telkom-border);
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            transition: all 0.2s ease;
            overflow: hidden;
        }

        .queue-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .queue-item.high-priority {
            border-left: 4px solid var(--telkom-error);
            background: linear-gradient(135deg, #fef2f2 0%, white 100%);
        }

        .queue-item.assigned {
            border-left: 4px solid var(--telkom-success);
            background: linear-gradient(135deg, #f0f9ff 0%, white 100%);
        }

        .item-header {
            padding: 1.5rem 1.5rem 1rem 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
        }

        .customer-info {
            flex: 1;
        }

        .customer-name {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--telkom-text);
            margin-bottom: 0.25rem;
        }

        .customer-details {
            color: var(--telkom-dark-gray);
            font-size: 0.875rem;
            margin-bottom: 0.5rem;
        }

        .queue-metadata {
            display: flex;
            gap: 1rem;
            text-align: center;
        }

        .metadata-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 0.25rem;
        }

        .metadata-value {
            font-weight: 600;
            color: var(--telkom-text);
        }

        .metadata-label {
            font-size: 0.75rem;
            color: var(--telkom-dark-gray);
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .priority-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .priority-high {
            background: var(--telkom-error);
            color: white;
        }

        .priority-normal {
            background: var(--telkom-medium-gray);
            color: var(--telkom-dark-gray);
        }

        .item-body {
            padding: 0 1.5rem 1.5rem 1.5rem;
        }

        .issue-description {
            background: var(--telkom-light-gray);
            padding: 1rem;
            border-radius: 6px;
            margin-bottom: 1rem;
            border-left: 3px solid var(--telkom-primary);
        }

        .issue-title {
            font-weight: 600;
            color: var(--telkom-text);
            margin-bottom: 0.5rem;
        }

        .issue-text {
            color: var(--telkom-dark-gray);
            line-height: 1.5;
        }

        .diagnostics-preview {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
            gap: 0.75rem;
            margin-bottom: 1rem;
            padding: 1rem;
            background: var(--telkom-light-gray);
            border-radius: 6px;
        }

        .diagnostic-item {
            text-align: center;
        }

        .diagnostic-label {
            font-size: 0.75rem;
            color: var(--telkom-dark-gray);
            margin-bottom: 0.25rem;
        }

        .diagnostic-value {
            font-weight: 600;
            font-size: 0.875rem;
        }

        .diagnostic-ok {
            color: var(--telkom-success);
        }

        .diagnostic-warning {
            color: var(--telkom-warning);
        }

        .diagnostic-error {
            color: var(--telkom-error);
        }

        .item-actions {
            display: flex;
            gap: 0.5rem;
            justify-content: flex-end;
            flex-wrap: wrap;
        }

        .stats-bar {
            background: white;
            padding: 1.5rem;
            border-radius: 8px;
            margin-bottom: 2rem;
            border: 1px solid var(--telkom-border);
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 2rem;
            text-align: center;
        }

        .stat-item {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            color: var(--telkom-primary);
            margin-bottom: 0.25rem;
        }

        .stat-label {
            color: var(--telkom-dark-gray);
            font-size: 0.875rem;
        }

        .live-indicator {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--telkom-success);
            font-size: 0.875rem;
            font-weight: 500;
        }

        .live-dot {
            width: 8px;
            height: 8px;
            background: var(--telkom-success);
            border-radius: 50%;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.5; }
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }

        .modal-content {
            background-color: white;
            margin: 5% auto;
            padding: 2rem;
            border-radius: 12px;
            width: 80%;
            max-width: 600px;
            max-height: 80vh;
            overflow-y: auto;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--telkom-border);
        }

        .modal-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--telkom-text);
        }

        .close {
            color: var(--telkom-dark-gray);
            font-size: 2rem;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover {
            color: var(--telkom-error);
        }

        @media (max-width: 768px) {
            .queue-controls {
                flex-direction: column;
                align-items: stretch;
            }

            .filter-controls {
                justify-content: space-between;
            }

            .action-controls {
                justify-content: center;
            }

            .queue-metadata {
                flex-direction: column;
                gap: 0.5rem;
            }

            .item-actions {
                flex-direction: column;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-header">
        <h1 class="page-title">Live Queue Management</h1>
        <p class="page-subtitle">Monitor and manage customer support queue in real-time</p>
    </div>

    <!-- Live Statistics Bar -->
    <div class="stats-bar">
        <div class="stats-grid">
            <div class="stat-item">
                <div class="stat-number">
                    <asp:Literal ID="litTotalInQueue" runat="server" Text="23" />
                </div>
                <div class="stat-label">Total in Queue</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">
                    <asp:Literal ID="litHighPriority" runat="server" Text="5" />
                </div>
                <div class="stat-label">High Priority</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">
                    <asp:Literal ID="litAvgWaitTime" runat="server" Text="4.2" />
                </div>
                <div class="stat-label">Avg Wait (min)</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">
                    <asp:Literal ID="litAgentsActive" runat="server" Text="8" />
                </div>
                <div class="stat-label">Agents Online</div>
            </div>
        </div>
    </div>

    <!-- Queue Controls -->
    <div class="queue-controls">
        <div class="filter-controls">
            <div class="filter-group">
                <label class="filter-label">Priority</label>
                <asp:DropDownList ID="ddlPriorityFilter" runat="server" CssClass="filter-select" AutoPostBack="true" OnSelectedIndexChanged="ddlPriorityFilter_SelectedIndexChanged">
                    <asp:ListItem Value="" Text="All Priorities" Selected="true" />
                    <asp:ListItem Value="High" Text="High Priority" />
                    <asp:ListItem Value="Normal" Text="Normal Priority" />
                </asp:DropDownList>
            </div>
            
            <div class="filter-group">
                <label class="filter-label">Status</label>
                <asp:DropDownList ID="ddlStatusFilter" runat="server" CssClass="filter-select" AutoPostBack="true" OnSelectedIndexChanged="ddlStatusFilter_SelectedIndexChanged">
                    <asp:ListItem Value="" Text="All Statuses" Selected="true" />
                    <asp:ListItem Value="In Queue" Text="In Queue" />
                    <asp:ListItem Value="Assigned" Text="Assigned" />
                    <asp:ListItem Value="In Progress" Text="In Progress" />
                </asp:DropDownList>
            </div>
            
            <div class="filter-group">
                <label class="filter-label">Assigned To</label>
                <asp:DropDownList ID="ddlAgentFilter" runat="server" CssClass="filter-select" AutoPostBack="true" OnSelectedIndexChanged="ddlAgentFilter_SelectedIndexChanged">
                    <asp:ListItem Value="" Text="All Agents" Selected="true" />
                    <asp:ListItem Value="Me" Text="Assigned to Me" />
                    <asp:ListItem Value="Unassigned" Text="Unassigned" />
                </asp:DropDownList>
            </div>
        </div>

        <div class="action-controls">
            <div class="live-indicator">
                <div class="live-dot"></div>
                Live Updates
            </div>
            <asp:Button ID="btnRefreshQueue" runat="server" Text="Refresh" CssClass="btn btn-outline" OnClick="btnRefreshQueue_Click" />
            <asp:Button ID="btnBulkAssign" runat="server" Text="Bulk Assign" CssClass="btn btn-primary" OnClick="btnBulkAssign_Click" />
        </div>
    </div>

    <!-- Queue Grid -->
    <div class="queue-grid">
        <asp:Repeater ID="rptQueueItems" runat="server">
            <ItemTemplate>
                <div class="queue-item <%# GetItemCssClass(Eval("Priority").ToString(), Eval("Status").ToString()) %>" data-queue-id="<%# Eval("QueueId") %>">
                    <div class="item-header">
                        <div class="customer-info">
                            <h3 class="customer-name"><%# Eval("CustomerName") %></h3>
                            <div class="customer-details">
                                Account: <%# Eval("AccountNumber") %> | Location: <%# Eval("Location") %>
                            </div>
                            <div class="priority-badge priority-<%# Eval("Priority").ToString().ToLower() %>">
                                <%# Eval("Priority") %> Priority
                            </div>
                        </div>
                        
                        <div class="queue-metadata">
                            <div class="metadata-item">
                                <div class="metadata-value"><%# Eval("WaitTime") %></div>
                                <div class="metadata-label">Wait Time</div>
                            </div>
                            <div class="metadata-item">
                                <div class="metadata-value">#<%# Eval("QueuePosition") %></div>
                                <div class="metadata-label">Position</div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="item-body">
                        <div class="issue-description">
                            <div class="issue-title">Reported Issue</div>
                            <div class="issue-text"><%# Eval("IssueDescription") %></div>
                        </div>
                        
                        <div class="diagnostics-preview">
                            <div class="diagnostic-item">
                                <div class="diagnostic-label">Connection</div>
                                <div class="diagnostic-value diagnostic-<%# GetDiagnosticStatus(Eval("ConnectionStatus")) %>">
                                    <%# Eval("ConnectionStatus") %>
                                </div>
                            </div>
                            <div class="diagnostic-item">
                                <div class="diagnostic-label">Ping</div>
                                <div class="diagnostic-value diagnostic-<%# GetDiagnosticStatus(Eval("PingStatus")) %>">
                                    <%# Eval("PingStatus") %>
                                </div>
                            </div>
                            <div class="diagnostic-item">
                                <div class="diagnostic-label">DNS</div>
                                <div class="diagnostic-value diagnostic-<%# GetDiagnosticStatus(Eval("DNSStatus")) %>">
                                    <%# Eval("DNSStatus") %>
                                </div>
                            </div>
                            <div class="diagnostic-item">
                                <div class="diagnostic-label">Signal</div>
                                <div class="diagnostic-value diagnostic-<%# GetDiagnosticStatus(Eval("SignalStatus")) %>">
                                    <%# Eval("SignalStatus") %>
                                </div>
                            </div>
                        </div>
                        
                        <div class="item-actions">
                            <button class="btn btn-primary" onclick="assignToMe('<%# Eval("QueueId") %>', '<%# Eval("CustomerName") %>')">
                                Assign to Me
                            </button>
                            <button class="btn btn-outline" onclick="viewCustomerDetails('<%# Eval("QueueId") %>')">
                                View Details
                            </button>
                            <button class="btn btn-success" onclick="startRemoteSession('<%# Eval("QueueId") %>')">
                                Remote Session
                            </button>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <!-- Customer Details Modal -->
    <div id="customerModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title" id="modalTitle">Customer Details</h2>
                <span class="close" onclick="closeModal()">&times;</span>
            </div>
            <div id="modalBody">
                <!-- Dynamic content will be loaded here -->
            </div>
        </div>
    </div>

    <!-- Hidden fields for JavaScript -->
    <asp:HiddenField ID="hfCurrentAgent" runat="server" />

    <script type="text/javascript">
        var queueManager = {
            currentAgent: '<%= Session["Username"] %>',
            selectedItems: [],
            
            init: function() {
                console.log('Queue Manager initialized for agent:', this.currentAgent);
                this.startAutoRefresh();
            },
            
            startAutoRefresh: function() {
                setInterval(() => {
                    if (typeof __doPostBack === 'function') {
                        __doPostBack('<%= Page.ClientID %>', 'autoRefresh');
                    }
                }, 30000); // Refresh every 30 seconds
            }
        };

        function assignToMe(queueId, customerName) {
            if (confirm(`Assign ${customerName} to your queue?`)) {
                showLoading();
                
                // Simulate assignment process
                setTimeout(() => {
                    hideLoading();
                    showNotification(`${customerName} has been assigned to you. Customer will be notified.`, 'success');
                    
                    // Update the queue item visually
                    updateQueueItemStatus(queueId, 'Assigned to You');
                    
                    // Trigger server-side assignment
                    __doPostBack('<%= Page.ClientID %>', 'assign:' + queueId);
                }, 1000);
            }
        }

        function viewCustomerDetails(queueId) {
            showLoading();
            
            setTimeout(() => {
                hideLoading();
                
                // In a real implementation, this would fetch actual customer data
                var modalTitle = document.getElementById('modalTitle');
                var modalBody = document.getElementById('modalBody');
                
                modalTitle.textContent = 'Customer Details - Queue #' + queueId;
                modalBody.innerHTML = `
                    <div style="margin-bottom: 1rem;">
                        <strong>Loading customer information...</strong>
                    </div>
                `;
                
                document.getElementById('customerModal').style.display = 'block';
                
                // Simulate loading customer data
                setTimeout(() => {
                    modalBody.innerHTML = `
                        <div style="display: grid; gap: 1rem;">
                            <div style="background: var(--telkom-light-gray); padding: 1rem; border-radius: 6px;">
                                <h4 style="margin-bottom: 0.5rem;">Contact Information</h4>
                                <p><strong>Name:</strong> John Doe</p>
                                <p><strong>Email:</strong> john.doe@email.com</p>
                                <p><strong>Phone:</strong> +27 11 123 4567</p>
                                <p><strong>Account:</strong> TLK001234567</p>
                            </div>
                            <div style="background: var(--telkom-light-gray); padding: 1rem; border-radius: 6px;">
                                <h4 style="margin-bottom: 0.5rem;">Service Information</h4>
                                <p><strong>Package:</strong> Fiber 100Mbps</p>
                                <p><strong>Location:</strong> Johannesburg, Gauteng</p>
                                <p><strong>Last Payment:</strong> 2024-09-15</p>
                            </div>
                            <div style="background: var(--telkom-light-gray); padding: 1rem; border-radius: 6px;">
                                <h4 style="margin-bottom: 0.5rem;">Recent History</h4>
                                <p>• Speed test completed - 2024-09-10</p>
                                <p>• Router restart - 2024-09-08</p>
                                <p>• Configuration update - 2024-09-05</p>
                            </div>
                        </div>
                        <div style="text-align: right; margin-top: 1.5rem;">
                            <button class="btn btn-primary" onclick="assignToMe('${queueId}', 'John Doe'); closeModal();">
                                Assign & Start Session
                            </button>
                        </div>
                    `;
                }, 1000);
            }, 500);
        }

        function startRemoteSession(queueId) {
            if (confirm('Start remote diagnostic session with this customer?')) {
                showLoading();
                
                setTimeout(() => {
                    hideLoading();
                    showNotification('Remote session initiated. Customer will receive connection instructions.', 'success');
                    
                    // Update queue item status
                    updateQueueItemStatus(queueId, 'Remote Session Active');
                    
                    // In a real implementation, this would launch remote tools
                    // For now, we'll redirect to remote tools page
                    setTimeout(() => {
                        location.href = 'RemoteTools.aspx?session=' + queueId;
                    }, 2000);
                }, 1000);
            }
        }

        function updateQueueItemStatus(queueId, status) {
            var queueItem = document.querySelector(`[data-queue-id="${queueId}"]`);
            if (queueItem) {
                // Add visual indicator that item is now assigned
                queueItem.classList.add('assigned');
                
                // Update action buttons
                var buttons = queueItem.querySelectorAll('.btn-primary');
                if (buttons.length > 0) {
                    buttons[0].textContent = status;
                    buttons[0].disabled = true;
                    buttons[0].style.background = 'var(--telkom-success)';
                }
            }
        }

        function closeModal() {
            document.getElementById('customerModal').style.display = 'none';
        }

        function showLoading() {
            document.body.style.cursor = 'wait';
        }

        function hideLoading() {
            document.body.style.cursor = 'default';
        }

        function showNotification(message, type = 'success') {
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
            
            setTimeout(() => {
                notification.style.transform = 'translateX(0)';
            }, 100);
            
            setTimeout(() => {
                notification.style.transform = 'translateX(400px)';
                setTimeout(() => {
                    document.body.removeChild(notification);
                }, 300);
            }, 4000);
        }

        // Initialize when page loads
        document.addEventListener('DOMContentLoaded', function() {
            queueManager.init();
        });

        // Close modal when clicking outside
        window.onclick = function(event) {
            var modal = document.getElementById('customerModal');
            if (event.target == modal) {
                modal.style.display = 'none';
            }
        }
    </script>
</asp:Content>