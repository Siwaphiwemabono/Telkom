<%@ Page Language="C#" AutoEventWireup="true"  CodeBehind="CustomerDash.aspx.cs" Inherits="Telkom.CustomerDashboard.CustomerDash" MasterPageFile="~/CustomerDashboard/Customer.Master" %>
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
            --telkom-light-gray: #E8E8E8;
            --telkom-medium-gray: #888888;
            --gradient-bg: linear-gradient(135deg, #004080 0%, #66CC00 100%);
            --glass-bg: rgba(255, 255, 255, 0.1);
            --glass-border: 1px solid rgba(255, 255, 255, 0.3);
            --glass-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
            --card-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            --card-radius: 16px;
        }

        /* Alert Banner */
        .alert-banner {
            background: var(--gradient-bg);
            color: var(--telkom-white);
            padding: 18px 24px;
            border-radius: var(--card-radius);
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: var(--card-shadow);
            animation: slideIn 0.5s ease;
        }

        .alert-content {
            display: flex;
            align-items: center;
            gap: 18px;
        }

        .alert-icon {
            font-size: 1.8rem;
        }

        .alert-text h3 {
            font-size: 1.3rem;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .alert-text p {
            font-size: 1rem;
            opacity: 0.9;
            margin: 0;
        }

        .alert-close {
            background: rgba(255, 255, 255, 0.2);
            border: none;
            color: var(--telkom-white);
            cursor: pointer;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1rem;
            transition: all 0.3s ease;
        }

        .alert-close:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: rotate(90deg);
        }

        /* Welcome Section */
        .welcome-section {
            background: var(--telkom-white);
            border-radius: var(--card-radius);
            padding: 28px;
            margin-bottom: 30px;
            box-shadow: var(--card-shadow);
            animation: fadeIn 0.6s ease;
        }

        .welcome-section h3 {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--telkom-dark-blue);
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .welcome-section h3 i {
            color: var(--telkom-blue);
        }

        .welcome-section p {
            font-size: 1.1rem;
            color: var(--telkom-dark-gray);
            line-height: 1.6;
            margin-bottom: 20px;
        }

        .feature-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .feature-list li {
            display: flex;
            align-items: flex-start;
            gap: 15px;
            margin-bottom: 15px;
            padding: 15px;
            background: var(--telkom-soft-white);
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .feature-list li:hover {
            transform: translateX(5px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        .feature-list li i {
            color: var(--telkom-green);
            font-size: 1.3rem;
            margin-top: 2px;
            flex-shrink: 0;
        }

        .feature-list li strong {
            color: var(--telkom-dark-blue);
        }

        /* Dashboard Cards */
        .dashboard-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 24px;
            margin-bottom: 30px;
        }

        .card {
            background: var(--telkom-white);
            border-radius: var(--card-radius);
            padding: 24px;
            box-shadow: var(--card-shadow);
            transition: all 0.3s ease;
            text-decoration: none;
            color: inherit;
            display: block;
            position: relative;
            overflow: hidden;
            border: 1px solid transparent;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.12);
            border-color: rgba(0, 119, 204, 0.1);
        }

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--gradient-bg);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .card:hover::before {
            opacity: 1;
        }

        .card-header {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 18px;
        }

        .card-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            background: var(--gradient-bg);
            color: var(--telkom-white);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            flex-shrink: 0;
        }

        .card-title {
            font-size: 1.4rem;
            font-weight: 700;
            color: var(--telkom-dark-blue);
            margin: 0;
        }

        .card-content {
            font-size: 1rem;
            color: var(--telkom-dark-gray);
            line-height: 1.6;
            margin-bottom: 20px;
        }

        .btn {
            padding: 12px 24px;
            border-radius: 10px;
            border: none;
            cursor: pointer;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-primary {
            background: var(--gradient-bg);
            color: var(--telkom-white);
            box-shadow: 0 4px 12px rgba(0, 119, 204, 0.25);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(0, 119, 204, 0.35);
        }

        /* Service Status */
        .service-status {
            background: var(--telkom-white);
            border-radius: var(--card-radius);
            padding: 28px;
            box-shadow: var(--card-shadow);
            margin-bottom: 30px;
            animation: fadeIn 0.6s ease 0.2s both;
        }

        .status-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--telkom-light-gray);
        }

        .status-title {
            font-size: 1.6rem;
            font-weight: 700;
            color: var(--telkom-dark-blue);
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .status-title i {
            color: var(--telkom-blue);
        }

        .status-items {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 18px;
        }

        .status-item {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 18px;
            border-radius: 12px;
            background: var(--telkom-soft-white);
            transition: all 0.3s ease;
        }

        .status-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.08);
        }

        .status-indicator {
            width: 14px;
            height: 14px;
            border-radius: 50%;
            flex-shrink: 0;
        }

        .status-online { 
            background: var(--telkom-green);
            box-shadow: 0 0 0 3px rgba(153, 255, 51, 0.3);
        }
        
        .status-offline { 
            background: #FF4D4D;
            box-shadow: 0 0 0 3px rgba(255, 77, 77, 0.3);
        }
        
        .status-warning { 
            background: #FFC107;
            box-shadow: 0 0 0 3px rgba(255, 193, 7, 0.3);
        }

        .status-info h4 {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--telkom-dark-gray);
            margin: 0 0 5px 0;
        }

        .status-info p {
            font-size: 0.95rem;
            color: var(--telkom-medium-gray);
            margin: 0;
        }

        /* Activity Feed */
        .activity-feed {
            background: var(--telkom-white);
            border-radius: var(--card-radius);
            padding: 28px;
            box-shadow: var(--card-shadow);
            animation: fadeIn 0.6s ease 0.4s both;
        }

        .activity-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--telkom-light-gray);
        }

        .activity-title {
            font-size: 1.6rem;
            font-weight: 700;
            color: var(--telkom-dark-blue);
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .activity-title i {
            color: var(--telkom-blue);
        }

        .activity-items {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .activity-item {
            padding: 18px 0;
            border-bottom: 1px solid var(--telkom-light-gray);
            display: flex;
            gap: 15px;
            align-items: flex-start;
            transition: all 0.3s ease;
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        .activity-item:hover {
            background: var(--telkom-soft-white);
            border-radius: 8px;
            padding-left: 15px;
            padding-right: 15px;
            margin: 0 -15px;
        }

        .activity-icon {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            background: var(--telkom-soft-white);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--telkom-blue);
            font-size: 1.2rem;
            flex-shrink: 0;
        }

        .activity-content {
            flex: 1;
        }

        .activity-text {
            font-size: 1rem;
            color: var(--telkom-dark-gray);
            line-height: 1.5;
            margin: 0 0 5px 0;
        }

        .activity-time {
            font-size: 0.9rem;
            color: var(--telkom-medium-gray);
        }

        /* Button Styles */
        .btn-secondary {
            background: transparent;
            color: var(--telkom-blue);
            border: 2px solid var(--telkom-blue);
            padding: 10px 20px;
        }

        .btn-secondary:hover {
            background: rgba(0, 119, 204, 0.05);
            transform: translateY(-2px);
        }

        /* Animation Keyframes */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideIn {
            from { transform: translateY(-10px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .dashboard-cards {
                grid-template-columns: 1fr;
            }
            
            .status-items {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .alert-banner {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
            
            .status-header, .activity-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
            
            .card-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 12px;
            }
            
            .card-title {
                font-size: 1.3rem;
            }
            
            .welcome-section h3 {
                font-size: 1.5rem;
            }
            
            .status-title, .activity-title {
                font-size: 1.4rem;
            }
        }

        @media (max-width: 576px) {
            .welcome-section, .service-status, .activity-feed {
                padding: 20px;
            }
            
            .card {
                padding: 20px;
            }
            
            .feature-list li {
                flex-direction: column;
                gap: 10px;
            }
        }
    </style>

    <!-- Alert Banner -->
    <div class="alert-banner" id="alertBanner" runat="server">
        <div class="alert-content">
            <div class="alert-icon">
                <i class="fas fa-tools"></i>
            </div>
            <div class="alert-text">
                <h3>Proactive Support Alert</h3>
                <p>We've detected a potential issue in your area and have pre-booked a support slot for you.</p>
            </div>
        </div>
        <button class="alert-close" id="alertClose"><i class="fas fa-times"></i></button>
    </div>

    <!-- Welcome Section -->
    <div class="welcome-section">
        <h3><i class="fas fa-home"></i> Welcome to Your TelkomX Dashboard</h3>
        <p>Your personalized hub for managing services, troubleshooting issues, and staying connected with the TelkomX community.</p>
        <ul class="feature-list">
            <li>
                <i class="fas fa-robot"></i>
                <div>Use the <strong>AI Troubleshooter</strong> to resolve common issues like connectivity or billing instantly.</div>
            </li>
            <li>
                <i class="fas fa-ticket-alt"></i>
                <div>Check your <strong>Support Queue</strong> for scheduled or proactive support slots.</div>
            </li>
            <li>
                <i class="fas fa-users"></i>
                <div>Explore the <strong>Community Forum</strong> to view and report local issues with verified technician responses.</div>
            </li>
        </ul>
    </div>

    <!-- Dashboard Cards -->
    <div class="dashboard-cards">
        <a href="/CustomerDashboard/AITroubleshooter.aspx" class="card">
            <div class="card-header">
                <div class="card-icon"><i class="fas fa-robot"></i></div>
                <h3 class="card-title">AI Troubleshooter</h3>
            </div>
            <p class="card-content">Get instant help for common issues like slow internet, WiFi setup, or billing questions.</p>
            <button class="btn btn-primary">Start Troubleshooting</button>
        </a>
        
        <a href="/CustomerDashboard/MySupportQueue.aspx" class="card">
            <div class="card-header">
                <div class="card-icon"><i class="fas fa-calendar-check"></i></div>
                <h3 class="card-title">My Support Queue</h3>
            </div>
            <p class="card-content">View your upcoming support calls or proactively booked slots. Skip the standard queue.</p>
            <button class="btn btn-primary">View My Bookings</button>
        </a>
        
        <a href="/CustomerDashboard/CommunityForum.aspx" class="card">
            <div class="card-header">
                <div class="card-icon"><i class="fas fa-comments"></i></div>
                <h3 class="card-title">Community Forum</h3>
            </div>
            <p class="card-content">See issues and solutions reported by customers in your area. Official solutions provided by Telkom.</p>
            <button class="btn btn-primary">Browse Local Issues</button>
        </a>
    </div>

    <!-- Service Status -->
    <div class="service-status">
        <div class="status-header">
            <h3 class="status-title"><i class="fas fa-signal"></i> Service Status</h3>
            <button class="btn btn-secondary">View Details</button>
        </div>
        <div class="status-items">
            <div class="status-item">
                <div class="status-indicator status-online"></div>
                <div class="status-info">
                    <h4>Internet Service</h4>
                    <p>Connected · 95 Mbps</p>
                </div>
            </div>
            <div class="status-item">
                <div class="status-indicator status-online"></div>
                <div class="status-info">
                    <h4>Mobile Service</h4>
                    <p>Active · 12.5 GB remaining</p>
                </div>
            </div>
            <div class="status-item">
                <div class="status-indicator status-warning"></div>
                <div class="status-info">
                    <h4>Landline Service</h4>
                    <p>Experiencing intermittent issues</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Activity Feed -->
    <div class="activity-feed">
        <div class="activity-header">
            <h3 class="activity-title"><i class="fas fa-history"></i> Recent Activity</h3>
            <button class="btn btn-secondary">View All</button>
        </div>
        <ul class="activity-items" id="activityFeed" runat="server">
            <li class="activity-item">
                <div class="activity-icon"><i class="fas fa-wifi"></i></div>
                <div class="activity-content">
                    <p class="activity-text">Internet service restored after scheduled maintenance</p>
                    <span class="activity-time">2 hours ago</span>
                </div>
            </li>
            <li class="activity-item">
                <div class="activity-icon"><i class="fas fa-tools"></i></div>
                <div class="activity-content">
                    <p class="activity-text">Proactive support slot booked for your area</p>
                    <span class="activity-time">Yesterday at 3:45 PM</span>
                </div>
            </li>
            <li class="activity-item">
                <div class="activity-icon"><i class="fas fa-bill"></i></div>
                <div class="activity-content">
                    <p class="activity-text">October bill paid successfully</p>
                    <span class="activity-time">October 15, 2023</span>
                </div>
            </li>
        </ul>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const alertClose = document.getElementById('alertClose');
            const alertBanner = document.getElementById('alertBanner');

            if (alertClose && alertBanner) {
                alertClose.addEventListener('click', function () {
                    alertBanner.style.display = 'none';
                });
            }

            // Add hover effects to cards
            const cards = document.querySelectorAll('.card');
            cards.forEach(card => {
                card.addEventListener('mouseenter', function () {
                    this.style.transform = 'translateY(-5px)';
                    this.style.boxShadow = '0 12px 24px rgba(0, 0, 0, 0.12)';
                });

                card.addEventListener('mouseleave', function () {
                    this.style.transform = 'translateY(0)';
                    this.style.boxShadow = 'var(--card-shadow)';
                });
            });
        });
    </script>
</asp:Content>