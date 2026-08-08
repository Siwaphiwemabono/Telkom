<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Agent.Master" CodeBehind="TechnicianScheduling.aspx.cs" Inherits="Telkom.TechnicianScheduling" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Telkom Brand Colors */
        :root {
            --telkom-primary: #0066cc;
            --telkom-secondary: #e20074;
            --telkom-success: #00b04f;
            --telkom-warning: #ff6600;
            --telkom-error: #dc3545;
            --telkom-white: #ffffff;
            --telkom-light-gray: #f8f9fa;
            --telkom-medium-gray: #e9ecef;
            --telkom-dark-gray: #6c757d;
            --telkom-text: #333333;
            --telkom-border: #dee2e6;
            --agent-blue: #0066cc;
            --agent-dark: #004d99;
            --schedule-green: #00b04f;
            --schedule-orange: #ff6600;
            --schedule-purple: #6f42c1;
            --glass-bg: rgba(255, 255, 255, 0.15);
            --glass-border: 1px solid rgba(255, 255, 255, 0.2);
            --glass-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e9f2 100%);
            color: var(--telkom-text);
            line-height: 1.6;
            padding: 20px;
        }

        .container {
            max-width: 1600px;
            margin: 0 auto;
        }

        /* Page Header */
        .page-header {
            background: linear-gradient(135deg, var(--agent-blue) 0%, var(--schedule-purple) 100%);
            color: white;
            padding: 2rem;
            margin-bottom: 2rem;
            border-radius: 12px;
            position: relative;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grid" x="0" y="0" width="20" height="20" patternUnits="userSpaceOnUse"><circle cx="2" cy="2" r="1" fill="rgba(255,255,255,0.1)"/><circle cx="12" cy="12" r="0.5" fill="rgba(255,255,255,0.05)"/></pattern></defs><rect width="100" height="100" fill="url(%23grid)"/></svg>');
            animation: subtleMove 20s linear infinite;
            z-index: 0;
        }

        @keyframes subtleMove {
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
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .page-title i {
            font-size: 2.2rem;
        }

        .page-subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        /* Controls Bar */
        .controls-bar {
            background: var(--telkom-white);
            padding: 1.5rem;
            margin: 0 0 2rem 0;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .view-controls {
            display: flex;
            gap: 0.5rem;
            align-items: center;
        }

        .btn {
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 8px;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        .btn:active {
            transform: translateY(0);
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--agent-blue) 0%, var(--agent-dark) 100%);
            color: white;
        }

        .btn-outline {
            background: transparent;
            color: var(--agent-blue);
            border: 2px solid var(--agent-blue);
        }

        .btn-outline:hover {
            background: var(--agent-blue);
            color: white;
        }

        .btn-outline.active {
            background: var(--agent-blue);
            color: white;
        }

        .date-navigation {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .date-nav-btn {
            background: var(--telkom-light-gray);
            border: 1px solid var(--telkom-border);
            border-radius: 6px;
            padding: 0.6rem;
            cursor: pointer;
            color: var(--telkom-text);
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .date-nav-btn:hover {
            background: var(--telkom-medium-gray);
        }

        .current-date {
            font-weight: 600;
            min-width: 180px;
            text-align: center;
            font-size: 1.1rem;
            color: var(--telkom-text);
        }

        .filters {
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        .filter-select {
            padding: 0.8rem;
            border: 2px solid var(--telkom-border);
            border-radius: 8px;
            font-size: 0.9rem;
            background: white;
            min-width: 150px;
            transition: all 0.3s ease;
        }

        .filter-select:focus {
            outline: none;
            border-color: var(--agent-blue);
            box-shadow: 0 0 0 3px rgba(0, 102, 204, 0.2);
        }

        /* Schedule Container */
        .schedule-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            margin-bottom: 2rem;
        }

        .schedule-view {
            display: none;
        }

        .schedule-view.active {
            display: block;
        }

        /* Calendar View */
        .calendar-header {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            background: var(--telkom-light-gray);
            border-bottom: 1px solid var(--telkom-border);
        }

        .calendar-day-header {
            padding: 1.2rem;
            text-align: center;
            font-weight: 600;
            color: var(--telkom-text);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.9rem;
        }

        .calendar-grid {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            min-height: 600px;
        }

        .calendar-day {
            border-right: 1px solid var(--telkom-border);
            border-bottom: 1px solid var(--telkom-border);
            min-height: 120px;
            position: relative;
            background: white;
            transition: background-color 0.2s;
        }

        .calendar-day:hover {
            background: var(--telkom-light-gray);
        }

        .calendar-day:nth-child(7n) {
            border-right: none;
        }

        .day-number {
            position: absolute;
            top: 0.8rem;
            left: 0.8rem;
            font-weight: 600;
            color: var(--telkom-dark-gray);
            font-size: 1.1rem;
        }

        .day-number.today {
            background: var(--agent-blue);
            color: white;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .appointments {
            margin-top: 2.5rem;
            padding: 0.5rem;
            height: calc(100% - 2.5rem);
            overflow-y: auto;
        }

        .appointment {
            background: var(--schedule-green);
            color: white;
            padding: 0.5rem;
            margin-bottom: 0.5rem;
            border-radius: 6px;
            font-size: 0.85rem;
            cursor: pointer;
            transition: all 0.2s ease;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
        }

        .appointment:hover {
            opacity: 0.9;
            transform: translateY(-1px);
        }

        .appointment.priority {
            background: var(--schedule-orange);
        }

        .appointment.maintenance {
            background: var(--schedule-purple);
        }

        /* Timeline View */
        .timeline-view {
            padding: 1.5rem;
        }

        .timeline-header {
            display: grid;
            grid-template-columns: 150px repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 1rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid var(--telkom-border);
        }

        .timeline-label {
            font-weight: 600;
            color: var(--telkom-text);
            font-size: 1rem;
        }

        .timeline-technician {
            text-align: center;
            padding: 1rem;
            background: var(--telkom-light-gray);
            border-radius: 8px;
            font-weight: 600;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
        }

        .timeline-row {
            display: grid;
            grid-template-columns: 150px repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 0.5rem;
            align-items: center;
        }

        .timeline-time {
            font-size: 0.9rem;
            color: var(--telkom-dark-gray);
            text-align: right;
            padding-right: 1rem;
            font-weight: 500;
        }

        .timeline-slot {
            min-height: 50px;
            border: 1px solid var(--telkom-border);
            border-radius: 8px;
            display: flex;
            align-items: center;
            padding: 0.8rem;
            position: relative;
            cursor: pointer;
            transition: all 0.2s ease;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
        }

        .timeline-slot:hover {
            background: var(--telkom-light-gray);
            transform: translateY(-1px);
        }

        .timeline-slot.occupied {
            background: var(--schedule-green);
            color: white;
        }

        .timeline-slot.priority {
            background: var(--schedule-orange);
            color: white;
        }

        .timeline-slot.maintenance {
            background: var(--schedule-purple);
            color: white;
        }

        .timeline-appointment {
            font-size: 0.85rem;
            font-weight: 500;
        }

        /* List View */
        .list-view {
            padding: 1.5rem;
        }

        .technician-list {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .technician-card {
            border: 1px solid var(--telkom-border);
            border-radius: 12px;
            padding: 1.5rem;
            background: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
        }

        .technician-card:hover {
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transform: translateY(-2px);
        }

        .technician-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .technician-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .technician-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--agent-blue) 0%, var(--agent-dark) 100%);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 1.2rem;
            box-shadow: 0 4px 10px rgba(0, 102, 204, 0.3);
        }

        .technician-details h3 {
            margin-bottom: 0.25rem;
            color: var(--telkom-text);
            font-size: 1.3rem;
        }

        .technician-meta {
            font-size: 0.9rem;
            color: var(--telkom-dark-gray);
        }

        .technician-stats {
            display: flex;
            gap: 2rem;
        }

        .stat-item {
            text-align: center;
        }

        .stat-value {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--agent-blue);
        }

        .stat-label {
            font-size: 0.85rem;
            color: var(--telkom-dark-gray);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .schedule-timeline {
            display: flex;
            gap: 0.5rem;
            margin-top: 1rem;
            overflow-x: auto;
            padding: 0.5rem 0;
        }

        .schedule-block {
            flex: 0 0 auto;
            min-width: 90px;
            height: 35px;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.8rem;
            font-weight: 500;
            color: white;
            cursor: pointer;
            transition: all 0.2s ease;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
        }

        .schedule-block:hover {
            transform: translateY(-2px);
        }

        .schedule-block.available {
            background: var(--telkom-medium-gray);
            color: var(--telkom-dark-gray);
        }

        .schedule-block.scheduled {
            background: var(--schedule-green);
        }

        .schedule-block.priority {
            background: var(--schedule-orange);
        }

        .schedule-block.break {
            background: var(--telkom-dark-gray);
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
            background-color: rgba(0,0,0,0.5);
            backdrop-filter: blur(5px);
            animation: fadeIn 0.3s ease;
        }

        .modal-content {
            background-color: white;
            margin: 5% auto;
            padding: 0;
            border-radius: 12px;
            width: 90%;
            max-width: 600px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
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
            padding: 1.5rem;
            background: linear-gradient(135deg, var(--agent-blue) 0%, var(--agent-dark) 100%);
            color: white;
            border-radius: 12px 12px 0 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-title {
            font-size: 1.5rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .close {
            color: white;
            font-size: 2rem;
            font-weight: bold;
            cursor: pointer;
            line-height: 1;
            transition: all 0.3s ease;
        }

        .close:hover {
            transform: rotate(90deg);
            opacity: 0.8;
        }

        .modal-body {
            padding: 2rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: var(--telkom-text);
            font-size: 1rem;
        }

        .form-control {
            width: 100%;
            padding: 0.9rem;
            border: 2px solid var(--telkom-border);
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--agent-blue);
            box-shadow: 0 0 0 3px rgba(0, 102, 204, 0.2);
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
        }

        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 1rem 1.5rem;
            border-radius: 8px;
            color: white;
            font-weight: 600;
            z-index: 2000;
            max-width: 350px;
            word-wrap: break-word;
            animation: slideInRight 0.4s ease;
            box-shadow: 0 8px 32px rgba(0,0,0,0.3);
            backdrop-filter: blur(10px);
            border: var(--glass-border);
        }

        .notification.success {
            background: rgba(0, 176, 79, 0.2);
            border-color: rgba(0, 176, 79, 0.3);
        }

        .notification.info {
            background: rgba(0, 102, 204, 0.2);
            border-color: rgba(0, 102, 204, 0.3);
        }

        .notification.warning {
            background: rgba(255, 102, 0, 0.2);
            border-color: rgba(255, 102, 0, 0.3);
        }

        .notification.error {
            background: rgba(220, 53, 69, 0.2);
            border-color: rgba(220, 53, 69, 0.3);
        }

        @keyframes slideInRight {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .controls-bar {
                flex-direction: column;
                align-items: stretch;
            }
            
            .view-controls, .filters {
                justify-content: center;
            }
            
            .form-row {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .page-title {
                font-size: 2rem;
            }
            
            .calendar-grid {
                grid-template-columns: 1fr;
            }
            
            .timeline-header, .timeline-row {
                grid-template-columns: 1fr;
            }
            
            .technician-header {
                flex-direction: column;
                align-items: stretch;
            }
            
            .technician-stats {
                justify-content: space-around;
            }
            
            .schedule-timeline {
                flex-wrap: wrap;
            }
            
            .schedule-block {
                min-width: 70px;
            }
        }

        /* Loading Animation */
        .loading {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(255,255,255,.3);
            border-radius: 50%;
            border-top-color: #fff;
            animation: spin 1s ease-in-out infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <div class="header-content">
                <h1 class="page-title"><i class="fas fa-calendar-alt"></i> Technician Scheduling</h1>
                <p class="page-subtitle">Manage technician schedules, appointments, and availability</p>
            </div>
        </div>

        <!-- Controls Bar -->
        <div class="controls-bar">
            <div class="view-controls">
                <button class="btn btn-outline active" onclick="switchView('calendar')">
                    <i class="fas fa-calendar"></i> Calendar View
                </button>
                <button class="btn btn-outline" onclick="switchView('timeline')">
                    <i class="fas fa-clock"></i> Timeline View
                </button>
                <button class="btn btn-outline" onclick="switchView('list')">
                    <i class="fas fa-users"></i> Technician List
                </button>
            </div>

            <div class="date-navigation">
                <button class="date-nav-btn" onclick="changeWeek(-1)">
                    <i class="fas fa-chevron-left"></i>
                </button>
                <div class="current-date" id="currentDateRange">Sep 16 - Sep 22, 2025</div>
                <button class="date-nav-btn" onclick="changeWeek(1)">
                    <i class="fas fa-chevron-right"></i>
                </button>
                <button class="btn btn-outline" onclick="goToToday()">
                    <i class="fas fa-calendar-day"></i> Today
                </button>
            </div>

            <div class="filters">
                <select class="filter-select" id="regionFilter" onchange="applyFilters()">
                    <option value="">All Regions</option>
                    <option value="johannesburg">Johannesburg</option>
                    <option value="cape-town">Cape Town</option>
                    <option value="durban">Durban</option>
                    <option value="pretoria">Pretoria</option>
                    <option value="port-elizabeth">Port Elizabeth</option>
                </select>
                
                <select class="filter-select" id="serviceFilter" onchange="applyFilters()">
                    <option value="">All Services</option>
                    <option value="installation">Installation</option>
                    <option value="repair">Repair</option>
                    <option value="maintenance">Maintenance</option>
                    <option value="upgrade">Upgrade</option>
                </select>

                <button class="btn btn-primary" onclick="openScheduleModal()">
                    <i class="fas fa-plus-circle"></i> Schedule Appointment
                </button>
            </div>
        </div>

        <!-- Schedule Container -->
        <div class="schedule-container">
            <!-- Calendar View -->
            <div class="schedule-view active" id="calendarView">
                <div class="calendar-header">
                    <div class="calendar-day-header">Monday</div>
                    <div class="calendar-day-header">Tuesday</div>
                    <div class="calendar-day-header">Wednesday</div>
                    <div class="calendar-day-header">Thursday</div>
                    <div class="calendar-day-header">Friday</div>
                    <div class="calendar-day-header">Saturday</div>
                    <div class="calendar-day-header">Sunday</div>
                </div>
                <div class="calendar-grid" id="calendarGrid">
                    <!-- Calendar days will be populated by JavaScript -->
                </div>
            </div>

            <!-- Timeline View -->
            <div class="schedule-view" id="timelineView">
                <div class="timeline-view">
                    <div class="timeline-header">
                        <div class="timeline-label">Time</div>
                        <div class="timeline-technician">Thabo Mthembu<br><small>Johannesburg</small></div>
                        <div class="timeline-technician">Nomsa Dlamini<br><small>Cape Town</small></div>
                        <div class="timeline-technician">Sipho Ndlovu<br><small>Durban</small></div>
                        <div class="timeline-technician">Lerato Moloi<br><small>Pretoria</small></div>
                    </div>
                    <div id="timelineSlots">
                        <!-- Timeline slots will be populated by JavaScript -->
                    </div>
                </div>
            </div>

            <!-- List View -->
            <div class="schedule-view" id="listView">
                <div class="list-view">
                    <div class="technician-list" id="technicianList">
                        <!-- Technician cards will be populated by JavaScript -->
                    </div>
                </div>
            </div>
        </div>

        <!-- Schedule Modal -->
        <div id="scheduleModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 class="modal-title"><i class="fas fa-calendar-plus"></i> Schedule Appointment</h2>
                    <span class="close" onclick="closeScheduleModal()">&times;</span>
                </div>
                <div class="modal-body">
                    <form id="scheduleForm">
                        <div class="form-group">
                            <label>Customer Name</label>
                            <input type="text" class="form-control" id="customerName" required>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label>Service Type</label>
                                <select class="form-control" id="serviceType" required>
                                    <option value="">Select Service</option>
                                    <option value="installation">Fiber Installation</option>
                                    <option value="repair">Connection Repair</option>
                                    <option value="maintenance">Preventive Maintenance</option>
                                    <option value="upgrade">Service Upgrade</option>
                                    <option value="diagnostics">Network Diagnostics</option>
                                </select>
                            </div>
                            
                            <div class="form-group">
                                <label>Priority</label>
                                <select class="form-control" id="priority">
                                    <option value="standard">Standard</option>
                                    <option value="high">High Priority</option>
                                    <option value="emergency">Emergency</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label>Date</label>
                                <input type="date" class="form-control" id="appointmentDate" required>
                            </div>
                            
                            <div class="form-group">
                                <label>Time</label>
                                <select class="form-control" id="appointmentTime" required>
                                    <option value="">Select Time</option>
                                    <option value="08:00">08:00 - 10:00</option>
                                    <option value="10:00">10:00 - 12:00</option>
                                    <option value="12:00">12:00 - 14:00</option>
                                    <option value="14:00">14:00 - 16:00</option>
                                    <option value="16:00">16:00 - 18:00</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label>Technician</label>
                            <select class="form-control" id="assignedTechnician" required>
                                <option value="">Auto-assign best available</option>
                                <option value="thabo">Thabo Mthembu - Johannesburg</option>
                                <option value="nomsa">Nomsa Dlamini - Cape Town</option>
                                <option value="sipho">Sipho Ndlovu - Durban</option>
                                <option value="lerato">Lerato Moloi - Pretoria</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label>Location</label>
                            <input type="text" class="form-control" id="location" placeholder="Customer address" required>
                        </div>
                        
                        <div class="form-group">
                            <label>Notes</label>
                            <textarea class="form-control" id="notes" rows="3" placeholder="Special requirements or notes..."></textarea>
                        </div>
                        
                        <div style="text-align: right; margin-top: 2rem;">
                            <button type="button" class="btn btn-outline" onclick="closeScheduleModal()">
                                <i class="fas fa-times"></i> Cancel
                            </button>
                            <button type="submit" class="btn btn-primary" style="margin-left: 1rem;">
                                <i class="fas fa-calendar-check"></i> Schedule Appointment
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Global variables
        let currentView = 'calendar';
        let currentWeekStart = new Date();
        let techniciansData = [];
        let appointmentsData = [];

        // Initialize the page
        document.addEventListener('DOMContentLoaded', function () {
            initializeData();
            setCurrentWeek();
            renderCurrentView();

            // Set minimum date to today
            document.getElementById('appointmentDate').min = new Date().toISOString().split('T')[0];
        });

        // Initialize sample data
        function initializeData() {
            techniciansData = [
                {
                    id: 'thabo',
                    name: 'Thabo Mthembu',
                    region: 'johannesburg',
                    specialties: ['Fiber Installation', 'Business Services'],
                    rating: 4.9,
                    totalJobs: 156,
                    completedToday: 3,
                    schedule: generateWeekSchedule('thabo')
                },
                {
                    id: 'nomsa',
                    name: 'Nomsa Dlamini',
                    region: 'cape-town',
                    specialties: ['Residential Repair', 'Upgrades'],
                    rating: 4.7,
                    totalJobs: 134,
                    completedToday: 2,
                    schedule: generateWeekSchedule('nomsa')
                },
                {
                    id: 'sipho',
                    name: 'Sipho Ndlovu',
                    region: 'durban',
                    specialties: ['Network Diagnostics', 'Maintenance'],
                    rating: 4.8,
                    totalJobs: 142,
                    completedToday: 4,
                    schedule: generateWeekSchedule('sipho')
                },
                {
                    id: 'lerato',
                    name: 'Lerato Moloi',
                    region: 'pretoria',
                    specialties: ['Premium Installation', 'Smart Home'],
                    rating: 4.6,
                    totalJobs: 98,
                    completedToday: 2,
                    schedule: generateWeekSchedule('lerato')
                }
            ];

            appointmentsData = generateAppointments();
        }

        // Generate realistic weekly schedule for technician
        function generateWeekSchedule(techId) {
            const schedule = {};
            const days = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'];
            const timeSlots = ['08:00', '10:00', '12:00', '14:00', '16:00'];

            days.forEach(day => {
                schedule[day] = {};
                timeSlots.forEach(time => {
                    const rand = Math.random();
                    if (rand < 0.6) { // 60% chance of being scheduled
                        if (rand < 0.1) {
                            schedule[day][time] = { type: 'priority', customer: generateCustomerName() };
                        } else if (rand < 0.15) {
                            schedule[day][time] = { type: 'break', customer: 'Lunch Break' };
                        } else {
                            schedule[day][time] = { type: 'scheduled', customer: generateCustomerName() };
                        }
                    } else {
                        schedule[day][time] = { type: 'available', customer: null };
                    }
                });
            });

            return schedule;
        }

        // Generate random customer names
        function generateCustomerName() {
            const firstNames = ['John', 'Sarah', 'Michael', 'Lisa', 'David', 'Emma', 'James', 'Anna'];
            const lastNames = ['Smith', 'Johnson', 'Williams', 'Brown', 'Davis', 'Miller', 'Wilson', 'Moore'];
            return firstNames[Math.floor(Math.random() * firstNames.length)] + ' ' +
                lastNames[Math.floor(Math.random() * lastNames.length)];
        }

        // Generate appointments for calendar view
        function generateAppointments() {
            const appointments = [];
            const today = new Date();

            for (let i = 0; i < 7; i++) {
                const date = new Date(today);
                date.setDate(today.getDate() + i - 3);

                const dayAppointments = Math.floor(Math.random() * 4) + 1;
                for (let j = 0; j < dayAppointments; j++) {
                    appointments.push({
                        id: `apt_${i}_${j}`,
                        date: date.toDateString(),
                        time: ['09:00', '11:00', '14:00', '16:00'][j % 4],
                        customer: generateCustomerName(),
                        technician: techniciansData[Math.floor(Math.random() * techniciansData.length)].name,
                        type: Math.random() < 0.2 ? 'priority' : Math.random() < 0.1 ? 'maintenance' : 'standard',
                        service: ['Installation', 'Repair', 'Maintenance', 'Upgrade'][Math.floor(Math.random() * 4)]
                    });
                }
            }

            return appointments;
        }

        // Set current week display
        function setCurrentWeek() {
            const start = new Date(currentWeekStart);
            const end = new Date(start);
            end.setDate(start.getDate() + 6);

            const options = { month: 'short', day: 'numeric' };
            const startStr = start.toLocaleDateString('en-US', options);
            const endStr = end.toLocaleDateString('en-US', options);
            const year = start.getFullYear();

            document.getElementById('currentDateRange').textContent = `${startStr} - ${endStr}, ${year}`;
        }

        // Switch between different views
        function switchView(viewName) {
            // Update active button
            document.querySelectorAll('.view-controls .btn').forEach(btn => {
                btn.classList.remove('active');
            });
            event.target.classList.add('active');

            // Show selected view
            document.querySelectorAll('.schedule-view').forEach(view => {
                view.classList.remove('active');
            });
            document.getElementById(viewName + 'View').classList.add('active');

            currentView = viewName;
            renderCurrentView();
        }

        // Render the currently active view
        function renderCurrentView() {
            switch (currentView) {
                case 'calendar':
                    renderCalendarView();
                    break;
                case 'timeline':
                    renderTimelineView();
                    break;
                case 'list':
                    renderListView();
                    break;
            }
        }

        // Render calendar view
        function renderCalendarView() {
            const calendarGrid = document.getElementById('calendarGrid');
            const today = new Date();
            const startOfWeek = new Date(currentWeekStart);

            let calendarHtml = '';

            for (let i = 0; i < 7; i++) {
                const currentDay = new Date(startOfWeek);
                currentDay.setDate(startOfWeek.getDate() + i);

                const isToday = currentDay.toDateString() === today.toDateString();
                const dayAppointments = appointmentsData.filter(apt => apt.date === currentDay.toDateString());

                calendarHtml += `
                    <div class="calendar-day">
                        <div class="day-number ${isToday ? 'today' : ''}">${currentDay.getDate()}</div>
                        <div class="appointments">
                            ${dayAppointments.map(apt => `
                                <div class="appointment ${apt.type}" onclick="viewAppointment('${apt.id}')" title="${apt.customer} - ${apt.service}">
                                    ${apt.time} ${apt.customer}
                                </div>
                            `).join('')}
                        </div>
                    </div>
                `;
            }

            calendarGrid.innerHTML = calendarHtml;
        }

        // Render timeline view
        function renderTimelineView() {
            const timelineSlots = document.getElementById('timelineSlots');
            const timeSlots = ['08:00', '10:00', '12:00', '14:00', '16:00'];
            const techs = techniciansData.slice(0, 4); // Show first 4 technicians

            let timelineHtml = '';

            timeSlots.forEach(time => {
                timelineHtml += `
                    <div class="timeline-row">
                        <div class="timeline-time">${time} - ${getEndTime(time)}</div>
                        ${techs.map(tech => {
                    const daySchedule = tech.schedule.monday; // Show Monday for demo
                    const slot = daySchedule[time];
                    return `
                                <div class="timeline-slot ${slot.type}" onclick="editTimeSlot('${tech.id}', '${time}')">
                                    ${slot.customer ? `<div class="timeline-appointment">${slot.customer}</div>` : ''}
                                </div>
                            `;
                }).join('')}
                    </div>
                `;
            });

            timelineSlots.innerHTML = timelineHtml;
        }

        // Render list view
        function renderListView() {
            const technicianList = document.getElementById('technicianList');

            const listHtml = techniciansData.map(tech => {
                const todaySchedule = tech.schedule.monday; // Show Monday for demo
                const scheduleBlocks = Object.entries(todaySchedule).map(([time, slot]) => {
                    return `
                        <div class="schedule-block ${slot.type}" title="${slot.customer || 'Available'} at ${time}">
                            ${time.substring(0, 5)}
                        </div>
                    `;
                }).join('');

                return `
                    <div class="technician-card">
                        <div class="technician-header">
                            <div class="technician-info">
                                <div class="technician-avatar">${tech.name.split(' ').map(n => n[0]).join('')}</div>
                                <div class="technician-details">
                                    <h3>${tech.name}</h3>
                                    <div class="technician-meta">
                                        ${tech.region.replace('-', ' ').replace(/\b\w/g, l => l.toUpperCase())} • 
                                        ${tech.specialties.join(', ')} • 
                                        ⭐ ${tech.rating}/5.0
                                    </div>
                                </div>
                            </div>
                            
                            <div class="technician-stats">
                                <div class="stat-item">
                                    <div class="stat-value">${tech.completedToday}</div>
                                    <div class="stat-label">Today</div>
                                </div>
                                <div class="stat-item">
                                    <div class="stat-value">${tech.totalJobs}</div>
                                    <div class="stat-label">Total Jobs</div>
                                </div>
                                <div class="stat-item">
                                    <div class="stat-value">${Math.floor(Math.random() * 3) + 3}</div>
                                    <div class="stat-label">Available</div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="schedule-timeline">
                            ${scheduleBlocks}
                        </div>
                    </div>
                `;
            }).join('');

            technicianList.innerHTML = listHtml;
        }

        // Helper function to get end time
        function getEndTime(startTime) {
            const [hours, minutes] = startTime.split(':').map(Number);
            const endHour = hours + 2;
            return `${endHour.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}`;
        }

        // Change week navigation
        function changeWeek(direction) {
            currentWeekStart.setDate(currentWeekStart.getDate() + (direction * 7));
            setCurrentWeek();
            renderCurrentView();
            showNotification(`Showing week of ${currentWeekStart.toLocaleDateString()}`, 'info');
        }

        // Go to current week
        function goToToday() {
            currentWeekStart = new Date();
            // Set to Monday of current week
            const dayOfWeek = currentWeekStart.getDay();
            const daysToSubtract = dayOfWeek === 0 ? 6 : dayOfWeek - 1;
            currentWeekStart.setDate(currentWeekStart.getDate() - daysToSubtract);

            setCurrentWeek();
            renderCurrentView();
            showNotification('Showing current week', 'success');
        }

        // Apply filters
        function applyFilters() {
            const regionFilter = document.getElementById('regionFilter').value;
            const serviceFilter = document.getElementById('serviceFilter').value;

            // Filter technicians data
            let filteredTechnicians = techniciansData;

            if (regionFilter) {
                filteredTechnicians = filteredTechnicians.filter(tech => tech.region === regionFilter);
            }

            // Apply filters and re-render
            renderCurrentView();

            if (regionFilter || serviceFilter) {
                showNotification('Filters applied successfully', 'info');
            }
        }

        // Open schedule modal
        function openScheduleModal() {
            document.getElementById('scheduleModal').style.display = 'block';
        }

        // Close schedule modal
        function closeScheduleModal() {
            document.getElementById('scheduleModal').style.display = 'none';
            document.getElementById('scheduleForm').reset();
        }

        // Handle form submission
        document.getElementById('scheduleForm').addEventListener('submit', function (e) {
            e.preventDefault();

            const formData = {
                customer: document.getElementById('customerName').value,
                service: document.getElementById('serviceType').value,
                priority: document.getElementById('priority').value,
                date: document.getElementById('appointmentDate').value,
                time: document.getElementById('appointmentTime').value,
                technician: document.getElementById('assignedTechnician').value,
                location: document.getElementById('location').value,
                notes: document.getElementById('notes').value
            };

            // Simulate scheduling process
            scheduleAppointment(formData);
        });

        // Schedule new appointment
        function scheduleAppointment(data) {
            // Add to appointments data
            const newAppointment = {
                id: `apt_${Date.now()}`,
                date: new Date(data.date).toDateString(),
                time: data.time,
                customer: data.customer,
                technician: data.technician === '' ? 'Auto-assigned' : getTechnicianName(data.technician),
                type: data.priority === 'standard' ? 'standard' : 'priority',
                service: data.service,
                location: data.location,
                notes: data.notes
            };

            appointmentsData.push(newAppointment);

            // Update technician schedule if specific technician selected
            if (data.technician && data.technician !== '') {
                updateTechnicianSchedule(data.technician, data.date, data.time, data.customer);
            }

            closeScheduleModal();
            renderCurrentView();

            showNotification(`Appointment scheduled successfully for ${data.customer}`, 'success');

            // Simulate sending notification to technician
            setTimeout(() => {
                showNotification(`Notification sent to ${newAppointment.technician}`, 'info');
            }, 2000);
        }

        // Get technician name by ID
        function getTechnicianName(techId) {
            const tech = techniciansData.find(t => t.id === techId);
            return tech ? tech.name : 'Unknown';
        }

        // Update technician schedule
        function updateTechnicianSchedule(techId, date, time, customer) {
            const tech = techniciansData.find(t => t.id === techId);
            if (tech) {
                const dayName = new Date(date).toLocaleDateString('en-US', { weekday: 'long' }).toLowerCase();
                if (tech.schedule[dayName] && tech.schedule[dayName][time]) {
                    tech.schedule[dayName][time] = {
                        type: 'scheduled',
                        customer: customer
                    };
                }
            }
        }

        // View appointment details
        function viewAppointment(appointmentId) {
            const appointment = appointmentsData.find(apt => apt.id === appointmentId);
            if (appointment) {
                alert(`Appointment Details:
Customer: ${appointment.customer}
Service: ${appointment.service}
Time: ${appointment.time}
Technician: ${appointment.technician}
Type: ${appointment.type.charAt(0).toUpperCase() + appointment.type.slice(1)}`);
            }
        }

        // Edit time slot
        function editTimeSlot(techId, time) {
            const tech = techniciansData.find(t => t.id === techId);
            if (tech) {
                const slot = tech.schedule.monday[time];
                if (slot.type === 'available') {
                    if (confirm(`Schedule appointment for ${tech.name} at ${time}?`)) {
                        openScheduleModal();
                        document.getElementById('assignedTechnician').value = techId;
                        document.getElementById('appointmentTime').value = time;
                    }
                } else {
                    alert(`${tech.name} - ${time}
Status: ${slot.type.charAt(0).toUpperCase() + slot.type.slice(1)}
${slot.customer ? 'Customer: ' + slot.customer : ''}`);
                }
            }
        }

        // Show notification
        function showNotification(message, type = 'info') {
            // Remove existing notifications
            document.querySelectorAll('.notification').forEach(notif => notif.remove());

            const notification = document.createElement('div');
            notification.className = `notification ${type}`;
            notification.textContent = message;

            document.body.appendChild(notification);

            // Auto remove after 4 seconds
            setTimeout(() => {
                if (notification && notification.parentNode) {
                    notification.remove();
                }
            }, 4000);
        }

        // Close modal when clicking outside
        window.onclick = function (event) {
            const modal = document.getElementById('scheduleModal');
            if (event.target === modal) {
                closeScheduleModal();
            }
        };

        // Keyboard shortcuts
        document.addEventListener('keydown', function (event) {
            if (event.ctrlKey || event.metaKey) {
                switch (event.key) {
                    case '1':
                        event.preventDefault();
                        switchView('calendar');
                        break;
                    case '2':
                        event.preventDefault();
                        switchView('timeline');
                        break;
                    case '3':
                        event.preventDefault();
                        switchView('list');
                        break;
                    case 'n':
                        event.preventDefault();
                        openScheduleModal();
                        break;
                }
            }

            if (event.key === 'Escape') {
                closeScheduleModal();
            }
        });

        // Auto-refresh every 5 minutes
        setInterval(function () {
            if (currentView !== 'modal') {
                renderCurrentView();
                showNotification('Schedule refreshed', 'info');
            }
        }, 300000);

        // Initialize tooltips and help text
        function initializeHelp() {
            const helpTexts = {
                'calendar': 'Click on appointments to view details. Empty spaces indicate available time slots.',
                'timeline': 'Green = Scheduled, Orange = Priority, Purple = Maintenance, Gray = Break, Light = Available',
                'list': 'View individual technician schedules and statistics. Click time blocks for details.'
            };

            // Add help tooltip to view buttons
            document.querySelectorAll('.view-controls .btn').forEach((btn, index) => {
                const views = ['calendar', 'timeline', 'list'];
                btn.title = helpTexts[views[index]];
            });
        }

        // Call initialization functions
        setTimeout(initializeHelp, 1000);
    </script>
</asp:Content>