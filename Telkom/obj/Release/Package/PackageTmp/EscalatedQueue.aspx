<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/TechMaster.Master" CodeBehind="EscalatedQueue.aspx.cs" Inherits="Telkom.EscalatedQueue" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="server">
    <style>
        /* Modern CSS Variables */
        :root {
            --primary-blue: #0077CC;
            --primary-dark-blue: #003366;
            --primary-green: #66CC00;
            --white: #FFFFFF;
            --light-bg: #F5F7FB;
            --dark-text: #1F1F1F;
            --medium-gray: #E2E8F0;
            --border-radius: 12px;
            --shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            --shadow-hover: 0 8px 24px rgba(0, 0, 0, 0.15);
        }

        /* Page Header Styles */
        .page-header {
            background: var(--white);
            padding: 1.5rem;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            margin-bottom: 1.5rem;
        }

        .page-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--primary-dark-blue);
            margin-bottom: 0.5rem;
        }

        .page-subtitle {
            color: #64748B;
            margin-bottom: 1.5rem;
        }

        .technician-info {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: var(--light-bg);
            padding: 1rem;
            border-radius: var(--border-radius);
        }

        /* Statistics Bar */
        .stats-bar {
            background: var(--white);
            padding: 1.5rem;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            margin-bottom: 1.5rem;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }

        .stat-item {
            text-align: center;
            padding: 1rem;
            border-radius: var(--border-radius);
            background: var(--light-bg);
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .high-priority { color: #EF4444; }
        .medium-priority { color: #F59E0B; }
        .total-cases { color: var(--primary-blue); }
        .avg-time { color: var(--primary-green); }

        .stat-label {
            font-size: 0.9rem;
            color: #64748B;
        }

        /* Filters Section */
        .filters-section {
            background: var(--white);
            padding: 1.5rem;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            margin-bottom: 1.5rem;
        }

        .filter-controls {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1rem;
        }

        .filter-group {
            display: flex;
            flex-direction: column;
        }

        .filter-label {
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: var(--dark-text);
        }

        .filter-select, .filter-input {
            padding: 0.75rem;
            border: 1px solid var(--medium-gray);
            border-radius: 8px;
            font-size: 1rem;
        }

        /* Buttons */
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            gap: 0.5rem;
        }

        .btn-primary {
            background: var(--primary-blue);
            color: var(--white);
        }

        .btn-primary:hover {
            background: #0066B3;
            transform: translateY(-2px);
        }

        .btn-secondary {
            background: var(--medium-gray);
            color: var(--dark-text);
        }

        .btn-secondary:hover {
            background: #D1D5DB;
        }

        .btn-success {
            background: var(--primary-green);
            color: var(--dark-text);
        }

        .btn-warning {
            background: #F59E0B;
            color: var(--white);
        }

        .btn-small {
            padding: 0.5rem 1rem;
            font-size: 0.9rem;
        }

        /* Cases Grid */
        .cases-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 1rem;
        }

        .case-item {
            background: var(--white);
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            padding: 1.5rem;
            transition: all 0.3s ease;
            border-left: 4px solid var(--primary-blue);
        }

        .case-item:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-hover);
        }

        .high-priority { border-left-color: #EF4444; }
        .medium-priority { border-left-color: #F59E0B; }

        .case-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 1rem;
        }

        .case-info h3 {
            font-size: 1.2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            color: var(--primary-dark-blue);
        }

        .customer-details {
            color: #64748B;
            margin-bottom: 0.75rem;
            font-size: 0.9rem;
        }

        .case-metadata {
            display: flex;
            gap: 1rem;
        }

        .metadata-item {
            text-align: center;
        }

        .metadata-value {
            font-weight: 700;
            font-size: 1.1rem;
        }

        .metadata-label {
            font-size: 0.8rem;
            color: #64748B;
        }

        /* Badges */
        .priority-badge, .status-badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            margin-right: 0.5rem;
        }

        .priority-high { background: #FEE2E2; color: #EF4444; }
        .priority-medium { background: #FEF3C7; color: #D97706; }
        .status-escalated { background: #FEE2E2; color: #EF4444; }
        .status-investigating { background: #DBEAFE; color: #1D4ED8; }
        .status-pending { background: #FEF3C7; color: #D97706; }
        .status-resolved { background: #D1FAE5; color: #059669; }

        /* Case Body */
        .case-body {
            margin-top: 1rem;
        }

        .sla-warning {
            padding: 0.75rem;
            border-radius: 8px;
            margin-bottom: 1rem;
            font-weight: 600;
        }

        .sla-critical {
            background: #FEE2E2;
            color: #EF4444;
            border: 1px solid #FECACA;
        }

        .issue-description {
            margin-bottom: 1rem;
        }

        .issue-title {
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: var(--dark-text);
        }

        .issue-text {
            color: #64748B;
            line-height: 1.6;
        }

        .case-actions {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
            margin-top: 1rem;
        }

        /* Modal */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            animation: fadeIn 0.3s ease;
        }

        .modal-content {
            background-color: var(--white);
            margin: 5% auto;
            padding: 0;
            border-radius: var(--border-radius);
            width: 90%;
            max-width: 700px;
            box-shadow: var(--shadow-hover);
            animation: slideIn 0.3s ease;
        }

        .modal-header {
            padding: 1.5rem;
            border-bottom: 1px solid var(--medium-gray);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-dark-blue);
        }

        .close {
            color: #64748B;
            font-size: 1.5rem;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover {
            color: var(--dark-text);
        }

        .modal-body {
            padding: 1.5rem;
            max-height: 70vh;
            overflow-y: auto;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: var(--dark-text);
        }

        .form-control {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--medium-gray);
            border-radius: 8px;
            font-size: 1rem;
        }

        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }

        /* Loading */
        .loading {
            text-align: center;
            padding: 3rem;
            color: var(--primary-blue);
        }

        /* Notifications */
        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 1rem 1.5rem;
            border-radius: 8px;
            color: var(--white);
            font-weight: 600;
            box-shadow: var(--shadow-hover);
            z-index: 2000;
            animation: slideInRight 0.3s ease;
        }

        .notification.info { background: var(--primary-blue); }
        .notification.success { background: var(--primary-green); color: var(--dark-text); }
        .notification.warning { background: #F59E0B; }
        .notification.error { background: #EF4444; }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideIn {
            from { transform: translateY(-50px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        @keyframes slideInRight {
            from { transform: translateX(100px); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        @keyframes slideOutRight {
            from { transform: translateX(0); opacity: 1; }
            to { transform: translateX(100px); opacity: 0; }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .technician-info {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }
            
            .case-header {
                flex-direction: column;
                gap: 1rem;
            }
            
            .case-metadata {
                align-self: stretch;
                justify-content: space-around;
            }
            
            .filter-controls {
                grid-template-columns: 1fr;
            }
            
            .case-actions {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Page Header -->
    <div class="page-header">
        <h1 class="page-title">Escalated Cases Dashboard</h1>
        <p class="page-subtitle">Manage high-priority cases assigned to you</p>
        <div class="technician-info">
            <div style="display: flex; align-items: center; gap: 0.5rem;">
                <span style="font-size: 1.5rem;">👤</span>
                <div>
                    <div style="font-weight: 600; font-size: 1.1rem;">
                        <asp:Label ID="lblTechnicianName" runat="server" Text="Technician"></asp:Label>
                    </div>
                    <div style="opacity: 0.8; font-size: 0.9rem;">Senior Technical Support</div>
                </div>
            </div>
            <div style="margin-left: auto; display: flex; align-items: center; gap: 1rem;">
                <div style="text-align: center;">
                    <div style="font-weight: 600;" id="activeSessionsCount">2</div>
                    <div style="font-size: 0.8rem; opacity: 0.8;">Active Sessions</div>
                </div>
                <div style="text-align: center;">
                    <div style="font-weight: 600;" id="resolvedTodayCount">7</div>
                    <div style="font-size: 0.8rem; opacity: 0.8;">Resolved Today</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Statistics Bar -->
    <div class="stats-bar">
        <div class="stats-grid">
            <div class="stat-item">
                <div class="stat-number high-priority" id="highPriorityCases">0</div>
                <div class="stat-label">High Priority</div>
            </div>
            <div class="stat-item">
                <div class="stat-number medium-priority" id="mediumPriorityCases">0</div>
                <div class="stat-label">Medium Priority</div>
            </div>
            <div class="stat-item">
                <div class="stat-number total-cases" id="totalEscalatedCases">0</div>
                <div class="stat-label">Total Assigned</div>
            </div>
            <div class="stat-item">
                <div class="stat-number avg-time" id="avgResolutionTime">0h</div>
                <div class="stat-label">Avg Resolution</div>
            </div>
        </div>
    </div>

    <!-- Filters Section -->
    <div class="filters-section">
        <div class="filter-controls">
            <div class="filter-group">
                <label class="filter-label">Priority Level</label>
                <select id="priorityFilter" class="filter-select" onchange="applyFilters()">
                    <option value="">All Priorities</option>
                    <option value="High">High Priority</option>
                    <option value="Medium">Medium Priority</option>
                </select>
            </div>
            
            <div class="filter-group">
                <label class="filter-label">Status</label>
                <select id="statusFilter" class="filter-select" onchange="applyFilters()">
                    <option value="">All Statuses</option>
                    <option value="Escalated">Newly Escalated</option>
                    <option value="Investigating">Under Investigation</option>
                    <option value="Pending">Pending Customer</option>
                    <option value="Resolved">Resolved</option>
                </select>
            </div>
            
            <div class="filter-group">
                <label class="filter-label">Search Case</label>
                <input type="text" id="searchInput" class="filter-input" placeholder="Case ID or Customer Name">
            </div>
            
            <div class="filter-group">
                <label class="filter-label">&nbsp;</label>
                <div style="display: flex; gap: 0.5rem;">
                    <button class="btn btn-primary btn-small" onclick="searchCases()">
                        <i class="fas fa-search"></i> Search
                    </button>
                    <button class="btn btn-secondary btn-small" onclick="clearFilters()">
                        <i class="fas fa-times"></i> Clear
                    </button>
                    <asp:Button ID="btnExportCSV" runat="server" Text="Export CSV" 
                        CssClass="btn btn-primary btn-small" OnClick="btnExportCSV_Click" />
                </div>
            </div>
        </div>
    </div>

    <!-- Cases Grid -->
    <div class="cases-grid" id="casesGrid">
        <!-- Cases will be populated by JavaScript -->
    </div>

    <!-- Case Details Modal -->
    <div id="caseModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title" id="modalTitle">Case Details</h2>
                <span class="close" onclick="closeCaseModal()">&times;</span>
            </div>
            <div class="modal-body" id="modalBodyContent">
                <!-- Modal content will be populated by JavaScript -->
            </div>
        </div>
    </div>

    <script>
        // Global variables
        let escalatedCases = [];
        let currentTechnician = "<%= lblTechnicianName.Text %>";
        let currentCaseId = null;

        // Initialize the application
        document.addEventListener('DOMContentLoaded', function () {
            loadCases();
            updateTechnicianStats();
        });

        // Load cases using WebMethod
        function loadCases() {
            showLoading(true);

            // Try to call WebMethod to get case data
            try {
                // This would be your actual AJAX call to the server
                // For now, we'll use sample data
                setTimeout(function () {
                    showLoading(false);
                    initializeWithSampleData();
                }, 1000);
            } catch (e) {
                showLoading(false);
                showNotification("Error loading cases, using sample data", "warning");
                initializeWithSampleData();
            }
        }

        // Fallback to sample data if server call fails
        function initializeWithSampleData() {
            escalatedCases = [
                {
                    CaseId: 'ESC001',
                    CustomerName: 'Sibongile Mthembu',
                    IssueType: 'Network Connectivity',
                    Priority: 'High',
                    Status: 'Escalated',
                    Description: 'Complete internet outage affecting business operations. Multiple failed attempts by Level 1 support. Customer runs online retail business - urgent resolution required.',
                    EscalatedDate: new Date(Date.now() - 2 * 60 * 60 * 1000),
                    SlaDeadline: new Date(Date.now() + 6 * 60 * 60 * 1000),
                    Notes: '',
                    ContactNumber: '+27 11 555 0123',
                    AccountNumber: 'TEL789456123',
                    Location: 'Sandton, Johannesburg'
                },
                {
                    CaseId: 'ESC002',
                    CustomerName: 'Ahmed Hassan',
                    IssueType: 'Speed Issues',
                    Priority: 'Medium',
                    Status: 'Investigating',
                    Description: 'Persistent slow internet speeds during peak hours. Speed tests showing 20% of contracted bandwidth. Affecting remote work capabilities.',
                    EscalatedDate: new Date(Date.now() - 4 * 60 * 60 * 1000),
                    SlaDeadline: new Date(Date.now() + 12 * 60 * 60 * 1000),
                    Notes: 'Checked line quality - signal levels within normal range. Suspect network congestion.',
                    ContactNumber: '+27 21 555 0456',
                    AccountNumber: 'TEL456789321',
                    Location: 'Cape Town CBD'
                },
                {
                    CaseId: 'ESC003',
                    CustomerName: 'Maria Santos',
                    IssueType: 'Intermittent Connection',
                    Priority: 'High',
                    Status: 'Escalated',
                    Description: 'Frequent disconnections every 15-20 minutes. Affecting video conferencing and VoIP calls. Business critical issue.',
                    EscalatedDate: new Date(Date.now() - 1 * 60 * 60 * 1000),
                    SlaDeadline: new Date(Date.now() + 7 * 60 * 60 * 1000),
                    Notes: '',
                    ContactNumber: '+27 31 555 0789',
                    AccountNumber: 'TEL321654987',
                    Location: 'Durban North'
                },
                {
                    CaseId: 'ESC004',
                    CustomerName: 'TechCorp Solutions',
                    IssueType: 'Billing Dispute',
                    Priority: 'Medium',
                    Status: 'Pending',
                    Description: 'Customer disputing last month\'s invoice. Claims overcharges for premium support services not rendered.',
                    EscalatedDate: new Date(Date.now() - 8 * 60 * 60 * 1000),
                    SlaDeadline: new Date(Date.now() + 16 * 60 * 60 * 1000),
                    Notes: 'Awaiting accounting department response. Customer provided supporting documents.',
                    ContactNumber: '+27 12 555 0321',
                    AccountNumber: 'TEL987123654',
                    Location: 'Pretoria'
                },
                {
                    CaseId: 'ESC005',
                    CustomerName: 'James Thompson',
                    IssueType: 'Hardware Failure',
                    Priority: 'High',
                    Status: 'Investigating',
                    Description: 'Router keeps rebooting automatically. Already replaced once under warranty. Suspect firmware issue or power supply problem.',
                    EscalatedDate: new Date(Date.now() - 3 * 60 * 60 * 1000),
                    SlaDeadline: new Date(Date.now() + 5 * 60 * 60 * 1000),
                    Notes: 'Remote diagnostics show irregular power readings. Arranging technician visit.',
                    ContactNumber: '+27 82 555 0111',
                    AccountNumber: 'TEL654987321',
                    Location: 'Port Elizabeth'
                },
                {
                    CaseId: 'ESC006',
                    CustomerName: 'Premium Estate Management',
                    IssueType: 'Multi-Unit Installation',
                    Priority: 'Medium',
                    Status: 'Resolved',
                    Description: 'Fiber installation for new apartment complex. 12 units requiring simultaneous setup and configuration.',
                    EscalatedDate: new Date(Date.now() - 24 * 60 * 60 * 1000),
                    SlaDeadline: new Date(Date.now() - 8 * 60 * 60 * 1000),
                    Notes: 'Completed installation ahead of schedule. All units tested and operational. Customer satisfied.',
                    ContactNumber: '+27 83 555 0999',
                    AccountNumber: 'TEL147258369',
                    Location: 'Camps Bay, Cape Town'
                },
                {
                    CaseId: 'ESC007',
                    CustomerName: 'Nomsa Dlamini',
                    IssueType: 'Email Configuration',
                    Priority: 'Medium',
                    Status: 'Pending',
                    Description: 'Unable to configure email on multiple devices. POP/IMAP settings not working. SSL certificate issues.',
                    EscalatedDate: new Date(Date.now() - 6 * 60 * 60 * 1000),
                    SlaDeadline: new Date(Date.now() + 10 * 60 * 60 * 1000),
                    Notes: 'Customer needs step-by-step guidance. Awaiting response with error screenshots.',
                    ContactNumber: '+27 76 555 0333',
                    AccountNumber: 'TEL369258147',
                    Location: 'Soweto, Johannesburg'
                },
                {
                    CaseId: 'ESC008',
                    CustomerName: 'Dr. Sarah Mitchell',
                    IssueType: 'Medical Practice Connectivity',
                    Priority: 'High',
                    Status: 'Investigating',
                    Description: 'Critical network issue affecting patient management system. Intermittent connectivity disrupting medical records access.',
                    EscalatedDate: new Date(Date.now() - 2 * 60 * 60 * 1000),
                    SlaDeadline: new Date(Date.now() + 4 * 60 * 60 * 1000),
                    Notes: 'Working with IT department. Suspect firewall configuration issue.',
                    ContactNumber: '+27 84 555 0666',
                    AccountNumber: 'TEL258369147',
                    Location: 'Rosebank, Johannesburg'
                }
            ];

            renderCases();
            updateStatistics();
            updateTechnicianStats();
        }

        // Render cases
        function renderCases() {
            const casesGrid = document.getElementById('casesGrid');
            const filteredCases = applyFiltersToData();

            casesGrid.innerHTML = filteredCases.map((caseItem, index) => {
                const timeElapsed = getTimeElapsed(caseItem.EscalatedDate);
                const slaStatus = getSLAStatus(caseItem.SlaDeadline);
                const slaTimeRemaining = getSLATimeRemaining(caseItem.SlaDeadline);

                return `
                    <div class="case-item ${getCaseCssClass(caseItem)}" data-case-id="${caseItem.CaseId}" style="animation-delay: ${index * 0.1}s">
                        <div class="case-header">
                            <div class="case-info">
                                <h3>${caseItem.CaseId} - ${caseItem.CustomerName}</h3>
                                <div class="customer-details">
                                    ${caseItem.IssueType} | Escalated: ${timeElapsed} ago | Location: ${caseItem.Location}
                                </div>
                                <div>
                                    <span class="priority-badge priority-${caseItem.Priority.toLowerCase()}">${caseItem.Priority} Priority</span>
                                    <span class="status-badge status-${caseItem.Status.toLowerCase().replace(' ', '')}">${caseItem.Status}</span>
                                </div>
                            </div>
                            
                            <div class="case-metadata">
                                <div class="metadata-item">
                                    <div class="metadata-value">${slaTimeRemaining}</div>
                                    <div class="metadata-label">SLA Time</div>
                                </div>
                                <div class="metadata-item">
                                    <div class="metadata-value">${timeElapsed}</div>
                                    <div class="metadata-label">Age</div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="case-body">
                            ${slaStatus.warning ? `<div class="sla-warning ${slaStatus.critical ? 'sla-critical' : ''}">${slaStatus.message}</div>` : ''}
                            
                            <div class="issue-description">
                                <div class="issue-title">Issue Description</div>
                                <div class="issue-text">${caseItem.Description}</div>
                            </div>
                            
                            <div class="customer-details" style="margin-bottom: 1rem;">
                                <strong>Account:</strong> ${caseItem.AccountNumber} | 
                                <strong>Contact:</strong> ${caseItem.ContactNumber}
                            </div>
                            
                            ${caseItem.Notes ? `
                                <div class="issue-description">
                                    <div class="issue-title">Technical Notes</div>
                                    <div class="issue-text">${caseItem.Notes}</div>
                                </div>
                            ` : ''}
                            
                            <div class="case-actions">
                                <button class="btn btn-primary btn-small" onclick="viewCaseDetails('${caseItem.CaseId}')">
                                    <i class="fas fa-eye"></i> View Details
                                </button>
                                ${caseItem.Status !== 'Resolved' ? `
                                    <button class="btn btn-warning btn-small" onclick="updateCaseStatus('${caseItem.CaseId}', 'Investigating')">
                                        <i class="fas fa-search"></i> Start Investigation
                                    </button>
                                    <button class="btn btn-secondary btn-small" onclick="updateCaseStatus('${caseItem.CaseId}', 'Pending')">
                                        <i class="fas fa-clock"></i> Mark Pending
                                    </button>
                                    <button class="btn btn-success btn-small" onclick="updateCaseStatus('${caseItem.CaseId}', 'Resolved')">
                                        <i class="fas fa-check"></i> Resolve Case
                                    </button>
                                ` : `
                                    <button class="btn btn-success btn-small" disabled>
                                        <i class="fas fa-check"></i> Resolved
                                    </button>
                                `}
                            </div>
                        </div>
                    </div>
                `;
            }).join('');
        }

        // Get case CSS class
        function getCaseCssClass(caseItem) {
            let classes = [];
            classes.push(caseItem.Priority.toLowerCase() + '-priority');
            classes.push(caseItem.Status.toLowerCase().replace(' ', ''));
            return classes.join(' ');
        }

        // Get time elapsed since escalation
        function getTimeElapsed(escalatedDate) {
            const now = new Date();
            const diffMs = now - new Date(escalatedDate);
            const diffHours = Math.floor(diffMs / (1000 * 60 * 60));
            const diffMinutes = Math.floor((diffMs % (1000 * 60 * 60)) / (1000 * 60));

            if (diffHours > 0) {
                return `${diffHours}h ${diffMinutes}m`;
            } else {
                return `${diffMinutes}m`;
            }
        }

        // Get SLA status
        function getSLAStatus(slaDeadline) {
            const now = new Date();
            const diffMs = new Date(slaDeadline) - now;
            const diffHours = diffMs / (1000 * 60 * 60);

            if (diffMs < 0) {
                return {
                    warning: true,
                    critical: true,
                    message: '⚠️ SLA BREACH: Deadline has passed'
                };
            } else if (diffHours <= 2) {
                return {
                    warning: true,
                    critical: true,
                    message: '🚨 CRITICAL: SLA deadline in less than 2 hours'
                };
            } else if (diffHours <= 4) {
                return {
                    warning: true,
                    critical: false,
                    message: '⚠️ WARNING: SLA deadline approaching in ' + Math.floor(diffHours) + ' hours'
                };
            } else {
                return {
                    warning: false,
                    critical: false,
                    message: ''
                };
            }
        }

        // Get SLA time remaining
        function getSLATimeRemaining(slaDeadline) {
            const now = new Date();
            const diffMs = new Date(slaDeadline) - now;

            if (diffMs < 0) {
                const overdue = Math.abs(diffMs);
                const overdueHours = Math.floor(overdue / (1000 * 60 * 60));
                return `-${overdueHours}h`;
            }

            const diffHours = Math.floor(diffMs / (1000 * 60 * 60));
            const diffMinutes = Math.floor((diffMs % (1000 * 60 * 60)) / (1000 * 60));

            if (diffHours > 0) {
                return `${diffHours}h ${diffMinutes}m`;
            } else {
                return `${diffMinutes}m`;
            }
        }

        // Apply filters to data
        function applyFiltersToData() {
            const priorityFilter = document.getElementById('priorityFilter').value;
            const statusFilter = document.getElementById('statusFilter').value;
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();

            return escalatedCases.filter(caseItem => {
                if (priorityFilter && caseItem.Priority !== priorityFilter) return false;
                if (statusFilter && caseItem.Status !== statusFilter) return false;
                if (searchTerm &&
                    !caseItem.CaseId.toLowerCase().includes(searchTerm) &&
                    !caseItem.CustomerName.toLowerCase().includes(searchTerm)) return false;
                return true;
            });
        }

        // Apply filters and re-render
        function applyFilters() {
            renderCases();
            updateStatistics();
        }

        // Search cases
        function searchCases() {
            applyFilters();
            const searchTerm = document.getElementById('searchInput').value;
            if (searchTerm) {
                showNotification(`Searching for: "${searchTerm}"`, 'info');
            }
        }

        // Clear filters
        function clearFilters() {
            document.getElementById('priorityFilter').value = '';
            document.getElementById('statusFilter').value = '';
            document.getElementById('searchInput').value = '';
            applyFilters();
            showNotification('Filters cleared', 'info');
        }

        // Update statistics
        function updateStatistics() {
            const filteredCases = applyFiltersToData();
            const activeCases = filteredCases.filter(c => c.Status !== 'Resolved');

            const highPriority = activeCases.filter(c => c.Priority === 'High').length;
            const mediumPriority = activeCases.filter(c => c.Priority === 'Medium').length;
            const totalActive = activeCases.length;

            // Calculate average resolution time for resolved cases
            const resolvedCases = escalatedCases.filter(c => c.Status === 'Resolved');
            let avgTime = '0h';

            if (resolvedCases.length > 0) {
                // Simplified calculation for demo
                avgTime = '2.3h';
            }

            document.getElementById('highPriorityCases').textContent = highPriority;
            document.getElementById('mediumPriorityCases').textContent = mediumPriority;
            document.getElementById('totalEscalatedCases').textContent = totalActive;
            document.getElementById('avgResolutionTime').textContent = avgTime;
        }

        // Update case status
        function updateCaseStatus(caseId, newStatus) {
            const caseItem = escalatedCases.find(c => c.CaseId === caseId);
            if (!caseItem) return;

            // In a real application, this would call a server method
            caseItem.Status = newStatus;

            // If resolving, add a timestamp note
            if (newStatus === 'Resolved') {
                const now = new Date();
                caseItem.Notes = (caseItem.Notes || '') + `\nResolved on ${now.toLocaleString()} by ${currentTechnician}`;
            }

            renderCases();
            updateStatistics();
            showNotification(`Case ${caseId} status updated to ${newStatus}`, "success");
        }

        // View case details
        function viewCaseDetails(caseId) {
            const caseItem = escalatedCases.find(c => c.CaseId === caseId);
            if (!caseItem) return;

            currentCaseId = caseId;

            // Create detailed HTML for modal
            const modalContent = `
                <div class="form-group">
                    <label>Case ID:</label>
                    <input type="text" class="form-control" value="${caseItem.CaseId}" readonly>
                </div>
                
                <div class="form-group">
                    <label>Customer Name:</label>
                    <input type="text" class="form-control" value="${caseItem.CustomerName}" readonly>
                </div>
                
                <div class="form-group">
                    <label>Account Number:</label>
                    <input type="text" class="form-control" value="${caseItem.AccountNumber}" readonly>
                </div>
                
                <div class="form-group">
                    <label>Contact Number:</label>
                    <input type="text" class="form-control" value="${caseItem.ContactNumber}" readonly>
                </div>
                
                <div class="form-group">
                    <label>Location:</label>
                    <input type="text" class="form-control" value="${caseItem.Location}" readonly>
                </div>
                
                <div class="form-group">
                    <label>Issue Type:</label>
                    <input type="text" class="form-control" value="${caseItem.IssueType}" readonly>
                </div>
                
                <div class="form-group">
                    <label>Priority Level:</label>
                    <select id="modalPriority" class="form-control">
                        <option value="High" ${caseItem.Priority === 'High' ? 'selected' : ''}>High Priority</option>
                        <option value="Medium" ${caseItem.Priority === 'Medium' ? 'selected' : ''}>Medium Priority</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label>Current Status:</label>
                    <select id="modalStatus" class="form-control">
                        <option value="Escalated" ${caseItem.Status === 'Escalated' ? 'selected' : ''}>Newly Escalated</option>
                        <option value="Investigating" ${caseItem.Status === 'Investigating' ? 'selected' : ''}>Under Investigation</option>
                        <option value="Pending" ${caseItem.Status === 'Pending' ? 'selected' : ''}>Pending Customer Response</option>
                        <option value="Resolved" ${caseItem.Status === 'Resolved' ? 'selected' : ''}>Resolved</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label>Issue Description:</label>
                    <textarea class="form-control" readonly>${caseItem.Description}</textarea>
                </div>
                
                <div class="form-group">
                    <label>Technical Notes:</label>
                    <textarea id="modalNotes" class="form-control" placeholder="Add your technical notes and resolution steps...">${caseItem.Notes || ''}</textarea>
                </div>
                
                <div class="form-group">
                    <button class="btn btn-primary" onclick="saveCase()">
                        <i class="fas fa-save"></i> Save Changes
                    </button>
                    <button class="btn btn-secondary" onclick="closeCaseModal()">
                        <i class="fas fa-times"></i> Close
                    </button>
                </div>
            `;

            // Update modal content
            document.getElementById('modalTitle').textContent = `Case Details - ${caseItem.CaseId}`;
            document.getElementById('modalBodyContent').innerHTML = modalContent;

            // Show modal
            document.getElementById('caseModal').style.display = 'block';
        }

        // Close case modal
        function closeCaseModal() {
            document.getElementById('caseModal').style.display = 'none';
            currentCaseId = null;
        }

        // Save case details
        function saveCase() {
            if (!currentCaseId) return;

            const priority = document.getElementById('modalPriority').value;
            const status = document.getElementById('modalStatus').value;
            const notes = document.getElementById('modalNotes').value;

            // Update local data
            const caseItem = escalatedCases.find(c => c.CaseId === currentCaseId);
            if (caseItem) {
                caseItem.Priority = priority;
                caseItem.Status = status;
                caseItem.Notes = notes;
            }

            renderCases();
            updateStatistics();
            closeCaseModal();
            showNotification(`Case ${currentCaseId} details saved`, "success");
        }

        // Show notification
        function showNotification(message, type = 'info') {
            // Remove existing notifications
            const existingNotifications = document.querySelectorAll('.notification');
            existingNotifications.forEach(notif => notif.remove());

            // Create notification element
            const notification = document.createElement('div');
            notification.className = `notification ${type}`;
            notification.textContent = message;

            document.body.appendChild(notification);

            // Remove after 4 seconds
            setTimeout(() => {
                if (notification && notification.parentNode) {
                    notification.style.animation = 'slideOutRight 0.3s ease';
                    setTimeout(() => {
                        if (notification && notification.parentNode) {
                            notification.remove();
                        }
                    }, 300);
                }
            }, 4000);
        }

        // Show/hide loading indicator
        function showLoading(show) {
            if (show) {
                document.getElementById('casesGrid').innerHTML =
                    '<div class="loading" style="text-align: center; padding: 40px;">' +
                    '<i class="fas fa-spinner fa-spin" style="font-size: 2rem; color: var(--primary-blue);"></i>' +
                    '<p>Loading cases...</p></div>';
            }
        }

        // Update technician stats
        function updateTechnicianStats() {
            const activeCases = escalatedCases.filter(c => c.Status !== 'Resolved').length;
            const resolvedToday = escalatedCases.filter(c => c.Status === 'Resolved').length;

            document.getElementById('activeSessionsCount').textContent = activeCases;
            document.getElementById('resolvedTodayCount').textContent = resolvedToday;
        }

        // Close modal when clicking outside
        window.onclick = function (event) {
            const modal = document.getElementById('caseModal');
            if (event.target === modal) {
                closeCaseModal();
            }
        };
    </script>
</asp:Content>