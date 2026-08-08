<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Agent.Master" CodeBehind="PriorityBookingManagement.aspx.cs" Inherits="Telkom.PriorityBookingManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Telkom Brand Colors */
        :root {
            --telkom-magenta: #e20074;
            --telkom-blue: #0066cc;
            --telkom-green: #00b04f;
            --telkom-orange: #ff6600;
            --telkom-dark-blue: #003d7a;
            --telkom-light-gray: #f5f5f5;
            --telkom-dark-gray: #666666;
            --priority-gold: #ffd700;
            --priority-red: #dc3545;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f8f9fa;
            line-height: 1.6;
            padding: 20px;
        }

        .container {
            max-width: 1600px;
            margin: 0 auto;
        }

        /* Page Header */
        .page-header {
            background: linear-gradient(135deg, var(--priority-gold) 0%, var(--telkom-magenta) 100%);
            color: white;
            padding: 2rem;
            margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
            border-radius: 12px;
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="stars" x="0" y="0" width="20" height="20" patternUnits="userSpaceOnUse"><circle cx="5" cy="5" r="1" fill="rgba(255,255,255,0.2)"/><circle cx="15" cy="15" r="0.5" fill="rgba(255,255,255,0.1)"/></pattern></defs><rect width="100" height="100" fill="url(%23stars)"/></svg>');
            animation: twinkle 10s linear infinite;
            z-index: 0;
        }

        @keyframes twinkle {
            0% { transform: translate(0, 0) rotate(0deg); }
            100% { transform: translate(-20px, -20px) rotate(360deg); }
        }

        .header-content {
            position: relative;
            z-index: 1;
        }

        .page-title {
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            font-weight: 300;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .priority-crown {
            font-size: 2rem;
            color: var(--priority-gold);
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; transform: scale(1); }
            50% { opacity: 0.8; transform: scale(1.1); }
        }

        .page-subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        /* Stats Bar */
        .stats-bar {
            background: linear-gradient(135deg, white 0%, #f8f9fa 100%);
            padding: 2rem;
            margin: 0 0 2rem 0;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            border: 2px solid var(--priority-gold);
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 2rem;
        }

        .stat-item {
            text-align: center;
            padding: 1.5rem;
            border-radius: 12px;
            background: linear-gradient(135deg, #fff 0%, #f8f9fa 100%);
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
            transition: transform 0.3s ease;
        }

        .stat-item:hover {
            transform: translateY(-5px);
        }

        .stat-number {
            font-size: 2.8rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }

        .stat-priority {
            color: var(--priority-gold);
        }

        .stat-revenue {
            color: var(--telkom-green);
        }

        .stat-urgent {
            color: var(--priority-red);
        }

        .stat-assigned {
            color: var(--telkom-blue);
        }

        .stat-label {
            color: var(--telkom-dark-gray);
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 600;
        }

        /* Controls Section */
        .controls-section {
            background: white;
            margin: 0 0 2rem 0;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }

        .controls-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .controls-title {
            font-size: 1.5rem;
            color: var(--telkom-dark-blue);
            font-weight: 600;
        }

        .filter-controls {
            display: flex;
            gap: 1.5rem;
            flex-wrap: wrap;
        }

        .filter-group {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .filter-label {
            font-size: 0.85rem;
            font-weight: 600;
            color: var(--telkom-dark-blue);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .filter-select {
            padding: 0.8rem 1.2rem;
            border: 2px solid #e1e5e9;
            border-radius: 8px;
            font-size: 0.9rem;
            background: white;
            color: #333;
            min-width: 150px;
            transition: all 0.3s ease;
        }

        .filter-select:focus {
            outline: none;
            border-color: var(--priority-gold);
            box-shadow: 0 0 0 3px rgba(255, 215, 0, 0.2);
        }

        .action-controls {
            display: flex;
            align-items: center;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .live-indicator {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--telkom-green);
            font-weight: 600;
            font-size: 0.9rem;
            padding: 0.5rem 1rem;
            background: rgba(0, 176, 79, 0.1);
            border-radius: 20px;
        }

        .live-dot {
            width: 10px;
            height: 10px;
            background: var(--telkom-green);
            border-radius: 50%;
            animation: pulse 2s infinite;
        }

        /* Button Styles */
        .btn {
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 8px;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            position: relative;
            overflow: hidden;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            transition: width 0.6s ease, height 0.6s ease;
            transform: translate(-50%, -50%);
        }

        .btn:hover::before {
            width: 300px;
            height: 300px;
        }

        .btn-priority {
            background: linear-gradient(135deg, var(--priority-gold) 0%, #ffed4a 100%);
            color: var(--telkom-dark-blue);
        }

        .btn-priority:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(255, 215, 0, 0.4);
        }

        .btn-outline {
            background: transparent;
            color: var(--telkom-blue);
            border: 2px solid var(--telkom-blue);
        }

        .btn-outline:hover {
            background: var(--telkom-blue);
            color: white;
        }

        .btn-success {
            background: linear-gradient(135deg, var(--telkom-green) 0%, #10b981 100%);
            color: white;
        }

        .btn-danger {
            background: linear-gradient(135deg, var(--priority-red) 0%, #ef4444 100%);
            color: white;
        }

        /* Bookings Grid */
        .bookings-grid {
            margin: 0;
        }

        .booking-item {
            background: white;
            margin-bottom: 1.5rem;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            border-left: 6px solid var(--priority-gold);
            overflow: hidden;
            transition: all 0.3s ease;
            position: relative;
        }

        .booking-item::before {
            content: '👑';
            position: absolute;
            top: 1rem;
            right: 1rem;
            font-size: 1.5rem;
            opacity: 0.7;
            animation: pulse 2s infinite;
        }

        .booking-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 30px rgba(255, 215, 0, 0.3);
        }

        .booking-item.urgent {
            border-left-color: var(--priority-red);
            background: linear-gradient(135deg, #fff 0%, rgba(220, 53, 69, 0.05) 100%);
        }

        .booking-item.urgent::before {
            content: '🚨';
            color: var(--priority-red);
        }

        .booking-item.assigned {
            border-left-color: var(--telkom-green);
        }

        .booking-item.assigned::before {
            content: '✅';
            color: var(--telkom-green);
        }

        .booking-item.completed {
            border-left-color: var(--telkom-dark-gray);
            opacity: 0.8;
        }

        .booking-item.completed::before {
            content: '🏆';
            color: var(--telkom-dark-gray);
        }

        .booking-header {
            padding: 2rem;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-bottom: 1px solid #e1e5e9;
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            flex-wrap: wrap;
            gap: 2rem;
        }

        .customer-info h3 {
            font-size: 1.4rem;
            color: var(--telkom-dark-blue);
            margin-bottom: 0.5rem;
            font-weight: 600;
        }

        .customer-details {
            color: var(--telkom-dark-gray);
            font-size: 0.95rem;
            margin-bottom: 1rem;
            line-height: 1.6;
        }

        .priority-badge {
            display: inline-block;
            padding: 0.5rem 1rem;
            border-radius: 25px;
            font-size: 0.85rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            position: relative;
            overflow: hidden;
        }

        .priority-badge::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.5s ease;
        }

        .priority-badge:hover::before {
            left: 100%;
        }

        .priority-premium {
            background: linear-gradient(135deg, var(--priority-gold) 0%, #ffed4a 100%);
            color: var(--telkom-dark-blue);
            border: 2px solid var(--priority-gold);
        }

        .priority-urgent {
            background: linear-gradient(135deg, var(--priority-red) 0%, #ef4444 100%);
            color: white;
            border: 2px solid var(--priority-red);
        }

        .booking-metadata {
            display: flex;
            gap: 2rem;
            flex-wrap: wrap;
        }

        .metadata-item {
            text-align: center;
            padding: 1rem;
            background: rgba(255, 255, 255, 0.8);
            border-radius: 8px;
            min-width: 100px;
        }

        .metadata-value {
            font-size: 1.3rem;
            font-weight: bold;
            color: var(--telkom-blue);
            margin-bottom: 0.2rem;
        }

        .metadata-label {
            font-size: 0.8rem;
            color: var(--telkom-dark-gray);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .booking-body {
            padding: 2rem;
        }

        .assignment-status {
            display: inline-block;
            padding: 0.6rem 1.2rem;
            background: rgba(0, 176, 79, 0.1);
            color: var(--telkom-green);
            border-radius: 25px;
            font-size: 0.9rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
            border: 2px solid rgba(0, 176, 79, 0.3);
        }

        .service-description {
            margin-bottom: 2rem;
        }

        .service-title {
            font-weight: 600;
            color: var(--telkom-dark-blue);
            margin-bottom: 0.8rem;
            text-transform: uppercase;
            font-size: 0.9rem;
            letter-spacing: 0.5px;
        }

        .service-text {
            color: #555;
            line-height: 1.6;
            font-size: 1rem;
        }

        .service-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .detail-card {
            background: #f8f9fc;
            padding: 1.5rem;
            border-radius: 10px;
            border-left: 4px solid var(--telkom-blue);
        }

        .detail-title {
            font-weight: 600;
            color: var(--telkom-dark-blue);
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .detail-content {
            color: #555;
            font-size: 0.95rem;
        }

        .technician-pool {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            padding: 1.5rem;
            border-radius: 10px;
            margin-bottom: 2rem;
        }

        .pool-title {
            font-weight: 600;
            color: var(--telkom-dark-blue);
            margin-bottom: 1rem;
            font-size: 1rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .tech-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 1rem;
        }

        .tech-card {
            background: white;
            padding: 1rem;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .tech-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 16px rgba(0,0,0,0.15);
        }

        .tech-card.available {
            border-left: 4px solid var(--telkom-green);
        }

        .tech-card.busy {
            border-left: 4px solid var(--telkom-orange);
        }

        .tech-card.selected {
            border: 2px solid var(--priority-gold);
            background: rgba(255, 215, 0, 0.1);
        }

        .tech-name {
            font-weight: 600;
            color: var(--telkom-dark-blue);
            margin-bottom: 0.3rem;
        }

        .tech-status {
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.3rem;
        }

        .tech-available {
            color: var(--telkom-green);
        }

        .tech-busy {
            color: var(--telkom-orange);
        }

        .tech-rating {
            font-size: 0.85rem;
            color: var(--priority-gold);
        }

        .booking-actions {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            justify-content: center;
            padding-top: 1rem;
            border-top: 1px solid #e1e5e9;
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.6);
            animation: fadeIn 0.3s ease;
        }

        .modal-content {
            background-color: white;
            margin: 3% auto;
            padding: 0;
            border-radius: 12px;
            width: 95%;
            max-width: 700px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.4);
            animation: slideIn 0.3s ease;
            max-height: 90vh;
            overflow-y: auto;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideIn {
            from { transform: translateY(-50px) scale(0.9); opacity: 0; }
            to { transform: translateY(0) scale(1); opacity: 1; }
        }

        .modal-header {
            padding: 2rem;
            background: linear-gradient(135deg, var(--telkom-dark-blue) 0%, var(--telkom-blue) 100%);
            color: white;
            border-radius: 12px 12px 0 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-title {
            font-size: 1.5rem;
            font-weight: 400;
            margin: 0;
        }

        .close {
            color: white;
            font-size: 2.5rem;
            font-weight: bold;
            cursor: pointer;
            line-height: 1;
            transition: all 0.3s ease;
        }

        .close:hover {
            transform: rotate(90deg);
            opacity: 0.7;
        }

        .modal-body {
            padding: 2rem;
        }

        .form-group {
            margin-bottom: 2rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.8rem;
            font-weight: 600;
            color: var(--telkom-dark-blue);
            font-size: 1rem;
        }

        .form-control {
            width: 100%;
            padding: 1rem;
            border: 2px solid #e1e5e9;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--priority-gold);
            box-shadow: 0 0 0 3px rgba(255, 215, 0, 0.2);
        }

        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 1.2rem 2rem;
            border-radius: 8px;
            color: white;
            font-weight: 600;
            z-index: 2000;
            max-width: 400px;
            word-wrap: break-word;
            animation: slideInRight 0.4s ease;
            box-shadow: 0 8px 32px rgba(0,0,0,0.3);
        }

        .notification.success {
            background: linear-gradient(135deg, var(--telkom-green) 0%, #10b981 100%);
        }

        .notification.info {
            background: linear-gradient(135deg, var(--telkom-blue) 0%, #3b82f6 100%);
        }

        .notification.warning {
            background: linear-gradient(135deg, var(--telkom-orange) 0%, #f59e0b 100%);
        }

        .notification.priority {
            background: linear-gradient(135deg, var(--priority-gold) 0%, #ffed4a 100%);
            color: var(--telkom-dark-blue);
        }

        @keyframes slideInRight {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .page-header {
                padding: 1.5rem 1rem;
            }
            
            .page-title {
                font-size: 2rem;
            }
            
            .stats-bar, .controls-section, .bookings-grid {
                margin: 0 0 1rem 0;
            }
            
            .controls-header {
                flex-direction: column;
                align-items: stretch;
                gap: 1rem;
            }
            
            .filter-controls {
                justify-content: center;
            }
            
            .booking-header {
                flex-direction: column;
                gap: 1rem;
            }
            
            .booking-metadata {
                justify-content: center;
            }
            
            .booking-actions {
                justify-content: center;
            }
            
            .tech-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <div class="header-content">
                <h1 class="page-title">
                    <span class="priority-crown">👑</span>
                    Priority Technician Management
                </h1>
                <p class="page-subtitle">Manage premium service bookings and technician assignments</p>
            </div>
        </div>

        <!-- Live Statistics Bar -->
        <div class="stats-bar">
            <div class="stats-grid">
                <div class="stat-item">
                    <div class="stat-number stat-priority" id="totalPriorityBookings">0</div>
                    <div class="stat-label">Priority Bookings</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number stat-revenue" id="totalRevenue">R0</div>
                    <div class="stat-label">Today's Revenue</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number stat-urgent" id="urgentBookings">0</div>
                    <div class="stat-label">Urgent (< 2hrs)</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number stat-assigned" id="assignedBookings">0</div>
                    <div class="stat-label">Assigned</div>
                </div>
            </div>
        </div>

        <!-- Controls Section -->
        <div class="controls-section">
            <div class="controls-header">
                <h2 class="controls-title">Priority Service Queue</h2>
                
                <div class="filter-controls">
                    <div class="filter-group">
                        <label class="filter-label">Priority Level</label>
                        <select id="priorityFilter" class="filter-select" onchange="applyFilters()">
                            <option value="">All Priorities</option>
                            <option value="Premium">Premium (R650)</option>
                            <option value="Urgent">Urgent (< 2hrs)</option>
                        </select>
                    </div>
                    
                    <div class="filter-group">
                        <label class="filter-label">Status</label>
                        <select id="statusFilter" class="filter-select" onchange="applyFilters()">
                            <option value="">All Statuses</option>
                            <option value="New">New Booking</option>
                            <option value="Assigned">Assigned</option>
                            <option value="En Route">En Route</option>
                            <option value="In Progress">In Progress</option>
                            <option value="Completed">Completed</option>
                        </select>
                    </div>
                    
                    <div class="filter-group">
                        <label class="filter-label">Service Type</label>
                        <select id="serviceFilter" class="filter-select" onchange="applyFilters()">
                            <option value="">All Services</option>
                            <option value="Installation">Installation</option>
                            <option value="Repair">Repair</option>
                            <option value="Upgrade">Upgrade</option>
                            <option value="Diagnostics">Diagnostics</option>
                        </select>
                    </div>
                </div>

                <div class="action-controls">
                    <div class="live-indicator">
                        <div class="live-dot"></div>
                        Live Updates
                    </div>
                    <button class="btn btn-outline" onclick="refreshBookings()">
                        <i class="fas fa-sync-alt"></i> Refresh
                    </button>
                    <button class="btn btn-priority" onclick="showTechnicianPool()">
                        <i class="fas fa-users"></i> View Technician Pool
                    </button>
                </div>
            </div>
        </div>

        <!-- Bookings Grid -->
        <div class="bookings-grid" id="bookingsGrid">
            <!-- Booking items will be populated by JavaScript -->
        </div>

        <!-- Assignment Modal -->
        <div id="assignModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 class="modal-title" id="assignTitle">Assign Priority Technician</h2>
                    <span class="close" onclick="closeAssignModal()">&times;</span>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label>Customer Details:</label>
                        <div id="customerSummary" style="background: #f8f9fa; padding: 1rem; border-radius: 8px; margin-bottom: 1rem;">
                            <!-- Customer details will be populated here -->
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label>Available Technicians:</label>
                        <div id="technicianSelection" class="tech-grid">
                            <!-- Technician options will be populated here -->
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label>Assignment Priority:</label>
                        <select id="assignmentPriority" class="form-control">
                            <option value="Standard">Standard Priority</option>
                            <option value="High">High Priority</option>
                            <option value="Emergency">Emergency Priority</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label>Special Instructions:</label>
                        <textarea id="specialInstructions" class="form-control" rows="4" placeholder="Any special instructions for the technician..."></textarea>
                    </div>
                    
                    <div class="booking-actions">
                        <button class="btn btn-priority" onclick="confirmAssignment()">
                            <i class="fas fa-user-check"></i> Assign Technician
                        </button>
                        <button class="btn btn-outline" onclick="closeAssignModal()">
                            <i class="fas fa-times"></i> Cancel
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Technician Pool Modal -->
        <div id="techPoolModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 class="modal-title">Premium Technician Pool</h2>
                    <span class="close" onclick="closeTechPoolModal()">&times;</span>
                </div>
                <div class="modal-body">
                    <div class="technician-pool">
                        <div class="pool-title">Available Technicians</div>
                        <div class="tech-grid" id="fullTechGrid">
                            <!-- Full technician pool will be displayed here -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Global variables
        let priorityBookings = [];
        let technicianPool = [];
        let currentAssignmentId = null;
        let selectedTechnician = null;

        // Initialize with sample priority booking data
        function initializeData() {
            priorityBookings = [
                {
                    id: 'PB001',
                    bookingNumber: 'TECH25092001',
                    customerName: 'Dr. Sarah Mitchell',
                    accountNumber: 'TEL789456123',
                    location: 'Sandton, Johannesburg, GP',
                    address: '123 Rivonia Road, Sandton, 2196',
                    phone: '+27 11 555 0891',
                    email: 'sarah.mitchell@example.com',
                    priority: 'Premium',
                    status: 'New',
                    serviceType: 'Installation',
                    serviceDescription: 'Fiber installation for home office. Customer is a surgeon who needs reliable connectivity for telemedicine consultations.',
                    scheduledDate: '2025-09-20',
                    scheduledTime: '14:00-16:00',
                    paymentAmount: 'R650',
                    paymentStatus: 'Paid',
                    urgencyLevel: 'Standard',
                    assignedTech: null,
                    createdAt: new Date(Date.now() - 1800000), // 30 minutes ago
                    estimatedDuration: '2-3 hours',
                    specialRequirements: 'Medical professional - minimal downtime required'
                },
                {
                    id: 'PB002',
                    bookingNumber: 'TECH25092002',
                    customerName: 'TechCorp Solutions',
                    accountNumber: 'TEL456789321',
                    location: 'Cape Town CBD, WC',
                    address: '45 Adderley Street, Cape Town, 8001',
                    phone: '+27 21 555 0234',
                    email: 'support@techcorp.co.za',
                    priority: 'Urgent',
                    status: 'Assigned',
                    serviceType: 'Repair',
                    serviceDescription: 'Critical network outage affecting 50+ employees. Complete loss of internet connectivity since 08:00.',
                    scheduledDate: '2025-09-20',
                    scheduledTime: '12:00-14:00',
                    paymentAmount: 'R650',
                    paymentStatus: 'Paid',
                    urgencyLevel: 'Emergency',
                    assignedTech: 'Thabo Mthembu',
                    createdAt: new Date(Date.now() - 3600000), // 1 hour ago
                    estimatedDuration: '1-2 hours',
                    specialRequirements: 'Business critical - immediate response required'
                },
                {
                    id: 'PB003',
                    bookingNumber: 'TECH25092003',
                    customerName: 'Maria Santos',
                    accountNumber: 'TEL321654987',
                    location: 'Durban North, KZN',
                    address: '67 Umhlanga Ridge Boulevard, Durban, 4319',
                    phone: '+27 31 555 0567',
                    email: 'maria.santos@email.com',
                    priority: 'Premium',
                    status: 'En Route',
                    serviceType: 'Upgrade',
                    serviceDescription: 'Upgrade from 10Mbps to 100Mbps fiber. Customer works from home and needs faster speeds for video conferencing.',
                    scheduledDate: '2025-09-20',
                    scheduledTime: '10:00-12:00',
                    paymentAmount: 'R650',
                    paymentStatus: 'Paid',
                    urgencyLevel: 'High',
                    assignedTech: 'Nomsa Dlamini',
                    createdAt: new Date(Date.now() - 7200000), // 2 hours ago
                    estimatedDuration: '1-2 hours',
                    specialRequirements: 'Minimize service interruption during business hours'
                },
                {
                    id: 'PB004',
                    bookingNumber: 'TECH25092004',
                    customerName: 'James Thompson',
                    accountNumber: 'TEL654987123',
                    location: 'Centurion, GP',
                    address: '89 Lenchen Avenue, Centurion, 0157',
                    phone: '+27 12 555 0789',
                    email: 'james.thompson@gmail.com',
                    priority: 'Premium',
                    status: 'New',
                    serviceType: 'Diagnostics',
                    serviceDescription: 'Intermittent connection drops affecting smart home system. Customer reports issues with security cameras and IoT devices.',
                    scheduledDate: '2025-09-20',
                    scheduledTime: '16:00-18:00',
                    paymentAmount: 'R650',
                    paymentStatus: 'Paid',
                    urgencyLevel: 'Standard',
                    assignedTech: null,
                    createdAt: new Date(Date.now() - 900000), // 15 minutes ago
                    estimatedDuration: '2-3 hours',
                    specialRequirements: 'Smart home integration experience preferred'
                },
                {
                    id: 'PB005',
                    bookingNumber: 'TECH25092005',
                    customerName: 'Premium Estate Management',
                    accountNumber: 'TEL147258369',
                    location: 'Camps Bay, Cape Town, WC',
                    address: '12 Victoria Road, Camps Bay, 8005',
                    phone: '+27 21 555 0345',
                    email: 'tech@premiumestate.co.za',
                    priority: 'Urgent',
                    status: 'In Progress',
                    serviceType: 'Installation',
                    serviceDescription: 'Multi-unit fiber installation for luxury apartment complex. 8 units requiring simultaneous setup.',
                    scheduledDate: '2025-09-20',
                    scheduledTime: '08:00-16:00',
                    paymentAmount: 'R5,200',
                    paymentStatus: 'Paid',
                    urgencyLevel: 'High',
                    assignedTech: 'Sipho Ndlovu',
                    createdAt: new Date(Date.now() - 10800000), // 3 hours ago
                    estimatedDuration: '6-8 hours',
                    specialRequirements: 'Large project - requires senior technician and assistant'
                }
            ];

            technicianPool = [
                {
                    id: 'T001',
                    name: 'Thabo Mthembu',
                    status: 'Busy',
                    location: 'Cape Town CBD',
                    rating: 4.9,
                    specialties: ['Fiber Installation', 'Network Repair', 'Business Solutions'],
                    experience: '8 years',
                    currentAssignment: 'PB002',
                    availability: '14:00',
                    contactNumber: '+27 82 555 0101'
                },
                {
                    id: 'T002',
                    name: 'Nomsa Dlamini',
                    status: 'En Route',
                    location: 'Durban North',
                    rating: 4.8,
                    specialties: ['Fiber Upgrades', 'Residential Services', 'Smart Home'],
                    experience: '6 years',
                    currentAssignment: 'PB003',
                    availability: '12:00',
                    contactNumber: '+27 83 555 0102'
                },
                {
                    id: 'T003',
                    name: 'Sipho Ndlovu',
                    status: 'Busy',
                    location: 'Camps Bay',
                    rating: 5.0,
                    specialties: ['Large Installations', 'Commercial Projects', 'Network Design'],
                    experience: '10 years',
                    currentAssignment: 'PB005',
                    availability: '17:00',
                    contactNumber: '+27 84 555 0103'
                },
                {
                    id: 'T004',
                    name: 'Lerato Moloi',
                    status: 'Available',
                    location: 'Sandton',
                    rating: 4.7,
                    specialties: ['Medical Installations', 'Precision Work', 'Diagnostics'],
                    experience: '7 years',
                    currentAssignment: null,
                    availability: 'Now',
                    contactNumber: '+27 85 555 0104'
                },
                {
                    id: 'T005',
                    name: 'Tshepo Khumalo',
                    status: 'Available',
                    location: 'Centurion',
                    rating: 4.6,
                    specialties: ['Smart Home', 'IoT Integration', 'Diagnostics'],
                    experience: '5 years',
                    currentAssignment: null,
                    availability: 'Now',
                    contactNumber: '+27 86 555 0105'
                },
                {
                    id: 'T006',
                    name: 'Zanele Mbeki',
                    status: 'Available',
                    location: 'Port Elizabeth',
                    rating: 4.8,
                    specialties: ['Residential Installation', 'Repair', 'Customer Service'],
                    experience: '4 years',
                    currentAssignment: null,
                    availability: 'Now',
                    contactNumber: '+27 87 555 0106'
                },
                {
                    id: 'T007',
                    name: 'Ahmed Hassan',
                    status: 'Busy',
                    location: 'Johannesburg',
                    rating: 4.9,
                    specialties: ['Emergency Response', 'Business Critical', 'Network Security'],
                    experience: '9 years',
                    currentAssignment: 'Regular Service',
                    availability: '15:30',
                    contactNumber: '+27 88 555 0107'
                },
                {
                    id: 'T008',
                    name: 'Precious Nkomo',
                    status: 'Available',
                    location: 'Pretoria',
                    rating: 4.7,
                    specialties: ['Fiber Installation', 'Upgrade Services', 'Technical Support'],
                    experience: '6 years',
                    currentAssignment: null,
                    availability: 'Now',
                    contactNumber: '+27 89 555 0108'
                }
            ];

            renderBookings();
            updateStatistics();

            // Update bookings every 2 minutes for live updates
            setInterval(updateLiveData, 120000);
        }

        // Render priority bookings
        function renderBookings() {
            const bookingsGrid = document.getElementById('bookingsGrid');
            const filteredData = applyFiltersToData();

            bookingsGrid.innerHTML = filteredData.map(booking => `
                <div class="booking-item ${getBookingCssClass(booking)}" data-booking-id="${booking.id}">
                    <div class="booking-header">
                        <div class="customer-info">
                            <h3>${booking.customerName}</h3>
                            <div class="customer-details">
                                <strong>Booking:</strong> ${booking.bookingNumber}<br>
                                <strong>Location:</strong> ${booking.location}<br>
                                <strong>Phone:</strong> ${booking.phone}<br>
                                <strong>Service:</strong> ${booking.serviceType} | <strong>Amount:</strong> ${booking.paymentAmount}
                            </div>
                            <div class="priority-badge priority-${booking.priority.toLowerCase()}">
                                ${booking.priority} Service - ${booking.paymentAmount}
                            </div>
                        </div>
                        
                        <div class="booking-metadata">
                            <div class="metadata-item">
                                <div class="metadata-value">${booking.scheduledTime}</div>
                                <div class="metadata-label">Time Slot</div>
                            </div>
                            <div class="metadata-item">
                                <div class="metadata-value">${booking.estimatedDuration}</div>
                                <div class="metadata-label">Duration</div>
                            </div>
                            <div class="metadata-item">
                                <div class="metadata-value">${getTimeElapsed(booking.createdAt)}</div>
                                <div class="metadata-label">Age</div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="booking-body">
                        ${booking.assignedTech ? `<div class="assignment-status">🔧 Assigned to ${booking.assignedTech}</div>` : ''}
                        
                        <div class="service-description">
                            <div class="service-title">Service Request</div>
                            <div class="service-text">${booking.serviceDescription}</div>
                        </div>
                        
                        <div class="service-details">
                            <div class="detail-card">
                                <div class="detail-title">Customer Information</div>
                                <div class="detail-content">
                                    <strong>Account:</strong> ${booking.accountNumber}<br>
                                    <strong>Email:</strong> ${booking.email}<br>
                                    <strong>Address:</strong> ${booking.address}
                                </div>
                            </div>
                            
                            <div class="detail-card">
                                <div class="detail-title">Service Details</div>
                                <div class="detail-content">
                                    <strong>Type:</strong> ${booking.serviceType}<br>
                                    <strong>Priority:</strong> ${booking.urgencyLevel}<br>
                                    <strong>Payment:</strong> ${booking.paymentStatus}
                                </div>
                            </div>
                            
                            <div class="detail-card">
                                <div class="detail-title">Special Requirements</div>
                                <div class="detail-content">${booking.specialRequirements}</div>
                            </div>
                        </div>
                        
                        <div class="booking-actions">
                            ${booking.status === 'New' ?
                    `<button class="btn btn-priority" onclick="openAssignModal('${booking.id}')">
                                    <i class="fas fa-user-plus"></i> Assign Premium Technician
                                </button>` : ''
                }
                            ${booking.status === 'Assigned' || booking.status === 'En Route' || booking.status === 'In Progress' ?
                    `<button class="btn btn-outline" onclick="reassignTechnician('${booking.id}')">
                                    <i class="fas fa-sync-alt"></i> Reassign Technician
                                </button>` : ''
                }
                            <button class="btn btn-outline" onclick="viewBookingDetails('${booking.id}')">
                                <i class="fas fa-info-circle"></i> View Full Details
                            </button>
                            ${booking.assignedTech ?
                    `<button class="btn btn-success" onclick="contactTechnician('${booking.id}')">
                                    <i class="fas fa-phone"></i> Contact ${booking.assignedTech}
                                </button>` : ''
                }
                            ${booking.status !== 'Completed' ?
                    `<button class="btn btn-success" onclick="markCompleted('${booking.id}')">
                                    <i class="fas fa-check"></i> Mark Completed
                                </button>` : ''
                }
                        </div>
                    </div>
                </div>
            `).join('');
        }

        // Get CSS class for booking item
        function getBookingCssClass(booking) {
            let classes = '';
            if (booking.urgencyLevel === 'Emergency') classes += 'urgent ';
            if (booking.assignedTech) classes += 'assigned ';
            if (booking.status === 'Completed') classes += 'completed ';
            return classes.trim();
        }

        // Get time elapsed since booking creation
        function getTimeElapsed(createdAt) {
            const now = new Date();
            const elapsed = Math.floor((now - createdAt) / 60000); // minutes
            if (elapsed < 60) return elapsed + 'min';
            if (elapsed < 1440) return Math.floor(elapsed / 60) + 'h';
            return Math.floor(elapsed / 1440) + 'd';
        }

        // Apply filters to data
        function applyFiltersToData() {
            const priorityFilter = document.getElementById('priorityFilter').value;
            const statusFilter = document.getElementById('statusFilter').value;
            const serviceFilter = document.getElementById('serviceFilter').value;

            return priorityBookings.filter(booking => {
                if (priorityFilter && booking.priority !== priorityFilter) return false;
                if (statusFilter && booking.status !== statusFilter) return false;
                if (serviceFilter && booking.serviceType !== serviceFilter) return false;
                return true;
            });
        }

        // Apply filters and re-render
        function applyFilters() {
            renderBookings();
            updateStatistics();
        }

        // Update statistics
        function updateStatistics() {
            const filteredData = applyFiltersToData();
            const totalBookings = filteredData.filter(b => b.status !== 'Completed').length;
            const urgentBookings = filteredData.filter(b => b.urgencyLevel === 'Emergency' && b.status !== 'Completed').length;
            const assignedBookings = filteredData.filter(b => b.assignedTech && b.status !== 'Completed').length;

            // Calculate revenue
            const todayRevenue = filteredData.reduce((total, booking) => {
                const amount = parseInt(booking.paymentAmount.replace(/[^\d]/g, ''));
                return total + amount;
            }, 0);

            document.getElementById('totalPriorityBookings').textContent = totalBookings;
            document.getElementById('totalRevenue').textContent = 'R' + todayRevenue.toLocaleString();
            document.getElementById('urgentBookings').textContent = urgentBookings;
            document.getElementById('assignedBookings').textContent = assignedBookings;
        }

        // Open assignment modal
        function openAssignModal(bookingId) {
            const booking = priorityBookings.find(b => b.id === bookingId);
            if (!booking) return;

            currentAssignmentId = bookingId;
            selectedTechnician = null;

            document.getElementById('assignTitle').textContent = `Assign Premium Technician - ${booking.customerName}`;

            // Populate customer summary
            document.getElementById('customerSummary').innerHTML = `
                <strong>${booking.customerName}</strong> - ${booking.serviceType}<br>
                <strong>Location:</strong> ${booking.location}<br>
                <strong>Time:</strong> ${booking.scheduledTime} | <strong>Duration:</strong> ${booking.estimatedDuration}<br>
                <strong>Priority:</strong> ${booking.urgencyLevel} | <strong>Amount:</strong> ${booking.paymentAmount}
            `;

            // Populate available technicians
            populateTechnicianSelection();

            document.getElementById('assignModal').style.display = 'block';
        }

        // Populate technician selection
        function populateTechnicianSelection() {
            const techSelection = document.getElementById('technicianSelection');
            const availableTechs = technicianPool.filter(tech => tech.status === 'Available' ||
                (tech.status === 'Busy' && tech.availability && tech.availability !== 'N/A'));

            techSelection.innerHTML = availableTechs.map(tech => `
                <div class="tech-card ${tech.status.toLowerCase()}" onclick="selectTechnician('${tech.id}')">
                    <div class="tech-name">${tech.name}</div>
                    <div class="tech-status tech-${tech.status.toLowerCase()}">${tech.status}</div>
                    <div class="tech-rating">⭐ ${tech.rating} | ${tech.experience}</div>
                    <div style="font-size: 0.8rem; color: #666; margin-top: 0.5rem;">
                        <strong>Available:</strong> ${tech.availability}<br>
                        <strong>Location:</strong> ${tech.location}<br>
                        <strong>Specialties:</strong> ${tech.specialties.slice(0, 2).join(', ')}
                    </div>
                </div>
            `).join('');
        }

        // Select technician
        function selectTechnician(techId) {
            // Remove previous selection
            document.querySelectorAll('.tech-card').forEach(card => {
                card.classList.remove('selected');
            });

            // Add selection to clicked card
            event.currentTarget.classList.add('selected');
            selectedTechnician = techId;
        }

        // Confirm assignment
        function confirmAssignment() {
            if (!selectedTechnician) {
                showNotification('Please select a technician first', 'warning');
                return;
            }

            const booking = priorityBookings.find(b => b.id === currentAssignmentId);
            const technician = technicianPool.find(t => t.id === selectedTechnician);

            if (!booking || !technician) {
                showNotification('Error finding booking or technician', 'error');
                return;
            }

            // Update booking
            booking.assignedTech = technician.name;
            booking.status = 'Assigned';

            // Update technician
            technician.status = 'Busy';
            technician.currentAssignment = currentAssignmentId;
            technician.availability = 'Assigned';

            const priority = document.getElementById('assignmentPriority').value;
            const instructions = document.getElementById('specialInstructions').value;

            showNotification(
                `🏆 ${booking.customerName} successfully assigned to ${technician.name} with ${priority} priority`,
                'priority'
            );

            // Send notification to technician (simulation)
            setTimeout(() => {
                showNotification(
                    `📱 Assignment notification sent to ${technician.name} (${technician.contactNumber})`,
                    'info'
                );
            }, 2000);

            renderBookings();
            updateStatistics();
            closeAssignModal();
        }

        // Close assignment modal
        function closeAssignModal() {
            document.getElementById('assignModal').style.display = 'none';
            currentAssignmentId = null;
            selectedTechnician = null;
        }

        // Show technician pool
        function showTechnicianPool() {
            const fullTechGrid = document.getElementById('fullTechGrid');

            fullTechGrid.innerHTML = technicianPool.map(tech => `
                <div class="tech-card ${tech.status.toLowerCase()}">
                    <div class="tech-name">${tech.name}</div>
                    <div class="tech-status tech-${tech.status.toLowerCase()}">${tech.status}</div>
                    <div class="tech-rating">⭐ ${tech.rating} (${tech.experience})</div>
                    <div style="font-size: 0.85rem; color: #666; margin-top: 0.5rem;">
                        <strong>Location:</strong> ${tech.location}<br>
                        <strong>Available:</strong> ${tech.availability}<br>
                        <strong>Contact:</strong> ${tech.contactNumber}
                    </div>
                    <div style="font-size: 0.8rem; color: #888; margin-top: 0.5rem;">
                        <strong>Specialties:</strong><br>
                        ${tech.specialties.join(', ')}
                    </div>
                    ${tech.currentAssignment ?
                    `<div style="font-size: 0.8rem; color: var(--telkom-orange); margin-top: 0.5rem;">
                            <strong>Current:</strong> ${tech.currentAssignment}
                        </div>` : ''
                }
                </div>
            `).join('');

            document.getElementById('techPoolModal').style.display = 'block';
        }

        // Close technician pool modal
        function closeTechPoolModal() {
            document.getElementById('techPoolModal').style.display = 'none';
        }

        // Reassign technician
        function reassignTechnician(bookingId) {
            openAssignModal(bookingId); // Reuse the assignment modal
        }

        // View booking details
        function viewBookingDetails(bookingId) {
            const booking = priorityBookings.find(b => b.id === bookingId);
            if (!booking) return;

            const detailsWindow = window.open('', '_blank', 'width=800,height=600,scrollbars=yes');
            detailsWindow.document.write(`
                <html>
                <head>
                    <title>Priority Booking Details - ${booking.bookingNumber}</title>
                    <style>
                        body { font-family: Arial, sans-serif; padding: 20px; line-height: 1.6; }
                        .header { background: linear-gradient(135deg, #ffd700 0%, #e20074 100%); color: white; padding: 20px; border-radius: 8px; }
                        .section { margin: 20px 0; padding: 15px; background: #f8f9fa; border-radius: 8px; }
                        .label { font-weight: bold; color: #003d7a; }
                        .priority { background: #ffd700; color: #003d7a; padding: 5px 10px; border-radius: 15px; font-weight: bold; }
                    </style>
                </head>
                <body>
                    <div class="header">
                        <h1>👑 Priority Booking Details</h1>
                        <p>Booking Number: ${booking.bookingNumber}</p>
                    </div>
                    
                    <div class="section">
                        <h2>Customer Information</h2>
                        <p><span class="label">Name:</span> ${booking.customerName}</p>
                        <p><span class="label">Account:</span> ${booking.accountNumber}</p>
                        <p><span class="label">Phone:</span> ${booking.phone}</p>
                        <p><span class="label">Email:</span> ${booking.email}</p>
                        <p><span class="label">Address:</span> ${booking.address}</p>
                    </div>
                    
                    <div class="section">
                        <h2>Service Details</h2>
                        <p><span class="label">Service Type:</span> ${booking.serviceType}</p>
                        <p><span class="label">Priority:</span> <span class="priority">${booking.priority} - ${booking.paymentAmount}</span></p>
                        <p><span class="label">Status:</span> ${booking.status}</p>
                        <p><span class="label">Urgency:</span> ${booking.urgencyLevel}</p>
                        <p><span class="label">Scheduled:</span> ${booking.scheduledDate} ${booking.scheduledTime}</p>
                        <p><span class="label">Duration:</span> ${booking.estimatedDuration}</p>
                        <p><span class="label">Payment:</span> ${booking.paymentStatus}</p>
                    </div>
                    
                    <div class="section">
                        <h2>Service Description</h2>
                        <p>${booking.serviceDescription}</p>
                    </div>
                    
                    <div class="section">
                        <h2>Special Requirements</h2>
                        <p>${booking.specialRequirements}</p>
                    </div>
                    
                    ${booking.assignedTech ? `
                        <div class="section">
                            <h2>Assignment Details</h2>
                            <p><span class="label">Assigned Technician:</span> ${booking.assignedTech}</p>
                            <p><span class="label">Assignment Time:</span> ${new Date().toLocaleString()}</p>
                        </div>
                    ` : ''}
                </body>
                </html>
            `);
        }

        // Contact technician
        function contactTechnician(bookingId) {
            const booking = priorityBookings.find(b => b.id === bookingId);
            const technician = technicianPool.find(t => t.name === booking.assignedTech);

            if (!technician) return;

            const message = `Priority Service Update for ${booking.customerName}:

Customer: ${booking.customerName}
Location: ${booking.address}
Service: ${booking.serviceType}
Time: ${booking.scheduledTime}
Priority: ${booking.urgencyLevel}

Special Requirements: ${booking.specialRequirements}

Please confirm receipt and ETA.`;

            // Simulate sending message
            showNotification(`📱 Message sent to ${technician.name} at ${technician.contactNumber}`, 'info');

            // Open default messaging app (simulation)
            window.open(`sms:${technician.contactNumber}?body=${encodeURIComponent(message)}`, '_blank');
        }

        // Mark booking as completed
        function markCompleted(bookingId) {
            const booking = priorityBookings.find(b => b.id === bookingId);
            if (!booking) return;

            if (confirm(`Mark ${booking.customerName}'s premium service as completed?`)) {
                booking.status = 'Completed';

                // Free up technician
                const technician = technicianPool.find(t => t.name === booking.assignedTech);
                if (technician) {
                    technician.status = 'Available';
                    technician.currentAssignment = null;
                    technician.availability = 'Now';
                }

                showNotification(`✅ Premium service completed for ${booking.customerName}`, 'success');
                renderBookings();
                updateStatistics();
            }
        }

        // Refresh bookings
        function refreshBookings() {
            // Simulate live data updates
            updateLiveData();
            showNotification('Priority bookings refreshed', 'info');
        }

        // Update live data (simulated)
        function updateLiveData() {
            // Randomly update some booking statuses for demo
            priorityBookings.forEach(booking => {
                if (booking.status === 'Assigned' && Math.random() > 0.8) {
                    booking.status = 'En Route';
                }
                if (booking.status === 'En Route' && Math.random() > 0.7) {
                    booking.status = 'In Progress';
                }
            });

            renderBookings();
            updateStatistics();
        }

        // Show notification
        function showNotification(message, type = 'info') {
            // Remove existing notifications
            document.querySelectorAll('.notification').forEach(notif => notif.remove());

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

        // Close modal when clicking outside
        window.onclick = function (event) {
            const assignModal = document.getElementById('assignModal');
            const techPoolModal = document.getElementById('techPoolModal');

            if (event.target === assignModal) {
                closeAssignModal();
            }
            if (event.target === techPoolModal) {
                closeTechPoolModal();
            }
        };

        // Initialize the application
        document.addEventListener('DOMContentLoaded', function () {
            initializeData();

            // Simulate live updates every 90 seconds
            setInterval(() => {
                updateLiveData();
                showNotification('Live update: Priority bookings refreshed', 'info');
            }, 90000);

            // Welcome message
            setTimeout(() => {
                showNotification('Welcome to Priority Technician Management System', 'priority');
            }, 1000);
        });

        // Additional utility functions for enhanced functionality

        // Auto-assign best technician based on location and specialty
        function autoAssignBestTechnician(bookingId) {
            const booking = priorityBookings.find(b => b.id === bookingId);
            if (!booking) return;

            // Find available technicians
            const availableTechs = technicianPool.filter(tech => tech.status === 'Available');

            if (availableTechs.length === 0) {
                showNotification('No technicians currently available for auto-assignment', 'warning');
                return;
            }

            // Score technicians based on proximity and specialty match
            const scoredTechs = availableTechs.map(tech => {
                let score = 0;

                // Location proximity (simplified)
                if (tech.location.toLowerCase().includes(booking.location.toLowerCase()) ||
                    booking.location.toLowerCase().includes(tech.location.toLowerCase())) {
                    score += 50;
                }

                // Specialty match
                const serviceKeywords = booking.serviceType.toLowerCase();
                tech.specialties.forEach(specialty => {
                    if (specialty.toLowerCase().includes(serviceKeywords) ||
                        serviceKeywords.includes(specialty.toLowerCase())) {
                        score += 30;
                    }
                });

                // Rating bonus
                score += tech.rating * 10;

                // Experience bonus
                const years = parseInt(tech.experience);
                score += years * 2;

                return { ...tech, score };
            });

            // Sort by score and select best
            scoredTechs.sort((a, b) => b.score - a.score);
            const bestTech = scoredTechs[0];

            // Auto-assign
            booking.assignedTech = bestTech.name;
            booking.status = 'Assigned';
            bestTech.status = 'Busy';
            bestTech.currentAssignment = bookingId;
            bestTech.availability = 'Assigned';

            showNotification(
                `AI Auto-Assignment: ${booking.customerName} assigned to ${bestTech.name} (Score: ${bestTech.score})`,
                'success'
            );

            renderBookings();
            updateStatistics();
        }

        // Bulk operations for multiple bookings
        function bulkAssignAvailable() {
            const newBookings = priorityBookings.filter(b => b.status === 'New');
            const availableTechs = technicianPool.filter(t => t.status === 'Available');

            if (newBookings.length === 0) {
                showNotification('No new bookings available for bulk assignment', 'info');
                return;
            }

            if (availableTechs.length === 0) {
                showNotification('No available technicians for bulk assignment', 'warning');
                return;
            }

            let assignedCount = 0;
            const maxAssignments = Math.min(newBookings.length, availableTechs.length);

            for (let i = 0; i < maxAssignments; i++) {
                const booking = newBookings[i];
                const tech = availableTechs[i];

                booking.assignedTech = tech.name;
                booking.status = 'Assigned';
                tech.status = 'Busy';
                tech.currentAssignment = booking.id;
                tech.availability = 'Assigned';
                assignedCount++;
            }

            showNotification(`Bulk assignment completed: ${assignedCount} bookings assigned`, 'success');
            renderBookings();
            updateStatistics();
        }

        // Export booking data
        function exportBookingData() {
            const csvData = priorityBookings.map(booking => ({
                'Booking Number': booking.bookingNumber,
                'Customer Name': booking.customerName,
                'Service Type': booking.serviceType,
                'Priority': booking.priority,
                'Status': booking.status,
                'Amount': booking.paymentAmount,
                'Assigned Technician': booking.assignedTech || 'Unassigned',
                'Scheduled Date': booking.scheduledDate,
                'Scheduled Time': booking.scheduledTime,
                'Location': booking.location
            }));

            // Convert to CSV
            const headers = Object.keys(csvData[0]);
            const csvContent = [
                headers.join(','),
                ...csvData.map(row => headers.map(header => `"${row[header]}"`).join(','))
            ].join('\n');

            // Download CSV
            const blob = new Blob([csvContent], { type: 'text/csv' });
            const url = window.URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = `priority-bookings-${new Date().toISOString().split('T')[0]}.csv`;
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
            window.URL.revokeObjectURL(url);

            showNotification('Priority booking data exported successfully', 'success');
        }

        // Performance metrics calculation
        function calculatePerformanceMetrics() {
            const totalBookings = priorityBookings.length;
            const completedBookings = priorityBookings.filter(b => b.status === 'Completed').length;
            const completionRate = totalBookings > 0 ? (completedBookings / totalBookings * 100).toFixed(1) : 0;

            const assignedBookings = priorityBookings.filter(b => b.assignedTech).length;
            const assignmentRate = totalBookings > 0 ? (assignedBookings / totalBookings * 100).toFixed(1) : 0;

            const urgentBookings = priorityBookings.filter(b => b.urgencyLevel === 'Emergency').length;
            const urgentResolved = priorityBookings.filter(b => b.urgencyLevel === 'Emergency' && b.status === 'Completed').length;
            const urgentResolutionRate = urgentBookings > 0 ? (urgentResolved / urgentBookings * 100).toFixed(1) : 0;

            return {
                completionRate,
                assignmentRate,
                urgentResolutionRate,
                totalRevenue: priorityBookings.reduce((sum, b) => sum + parseInt(b.paymentAmount.replace(/[^\d]/g, '')), 0),
                averageResponseTime: '18 minutes', // Simulated
                customerSatisfaction: '96%' // Simulated
            };
        }

        // Add keyboard shortcuts
        document.addEventListener('keydown', function (event) {
            if (event.ctrlKey || event.metaKey) {
                switch (event.key) {
                    case 'r':
                        event.preventDefault();
                        refreshBookings();
                        break;
                    case 'a':
                        event.preventDefault();
                        if (document.getElementById('assignModal').style.display === 'none') {
                            const firstNewBooking = priorityBookings.find(b => b.status === 'New');
                            if (firstNewBooking) {
                                openAssignModal(firstNewBooking.id);
                            }
                        }
                        break;
                    case 't':
                        event.preventDefault();
                        showTechnicianPool();
                        break;
                }
            }
        });
    </script>
</asp:Content>