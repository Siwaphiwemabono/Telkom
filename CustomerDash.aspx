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
            --gradient-bg: linear-gradient(135deg, #004080 0%, #66CC00 100%);
            --glass-bg: rgba(255, 255, 255, 0.1);
            --glass-border: 1px solid rgba(255, 255, 255, 0.3);
            --glass-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
        }

        /* Alert Banner */
        .alert-banner {
            background: var(--gradient-bg);
            color: var(--telkom-white);
            padding: 15px 20px;
            border-radius: 12px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: var(--glass-shadow);
            backdrop-filter: blur(10px);
        }

        .alert-content {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .alert-content h3 {
            font-size: 1.4rem;
            font-weight: 600;
        }

        .alert-content p {
            font-size: 1rem;
            opacity: 0.9;
        }

        .alert-close {
            background: none;
            border: none;
            color: var(--telkom-white);
            cursor: pointer;
            font-size: 1.2rem;
            transition: transform 0.3s;
        }

        .alert-close:hover {
            transform: rotate(90deg);
        }

        /* Dashboard Cards */
        .dashboard-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .card {
            background: var(--telkom-white);
            border-radius: 12px;
            padding: 20px;
            box-shadow: var(--glass-shadow);
            transition: transform 0.3s, box-shadow 0.3s;
            text-decoration: none;
            color: inherit;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.2);
        }

        .card-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 15px;
        }

        .card-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            background: var(--telkom-blue);
            color: var(--telkom-white);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
        }

        .card-title {
            font-size: 1.4rem;
            font-weight: 600;
            color: var(--telkom-dark-gray);
        }

        .card-content {
            font-size: 1rem;
            color: var(--telkom-dark-gray);
            opacity: 0.9;
            margin-bottom: 15px;
        }

        .btn {
            padding: 10px 20px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s;
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

        /* Service Status */
        .service-status {
            background: var(--telkom-white);
            border-radius: 12px;
            padding: 20px;
            box-shadow: var(--glass-shadow);
            margin-bottom: 30px;
        }

        .status-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .status-title {
            font-size: 1.6rem;
            font-weight: 600;
            color: var(--telkom-dark-gray);
        }

        .status-items {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }

        .status-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 15px;
            border-radius: 8px;
            background: var(--telkom-soft-white);
        }

        .status-indicator {
            width: 12px;
            height: 12px;
            border-radius: 50%;
        }

        .status-online { background: var(--telkom-green); }
        .status-offline { background: #FF4D4D; }
        .status-warning { background: #FFC107; }

        .status-item h4 {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--telkom-dark-gray);
        }

        .status-item p {
            font-size: 0.9rem;
            color: var(--telkom-dark-gray);
            opacity: 0.9;
        }

        /* Activity Feed */
        .activity-feed {
            background: var(--telkom-white);
            border-radius: 12px;
            padding: 20px;
            box-shadow: var(--glass-shadow);
        }

        .activity-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .activity-title {
            font-size: 1.6rem;
            font-weight: 600;
            color: var(--telkom-dark-gray);
        }

        .activity-items {
            list-style: none;
            padding: 0;
        }

        .activity-item {
            padding: 15px 0;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            display: flex;
            gap: 12px;
            align-items: center;
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        .activity-icon {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: var(--telkom-soft-white);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--telkom-blue);
            font-size: 1.2rem;
        }

        .activity-content {
            flex: 1;
            font-size: 1rem;
            color: var(--telkom-dark-gray);
        }

        .activity-time {
            font-size: 0.9rem;
            color: var(--telkom-dark-gray);
            opacity: 0.7;
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

        @media (max-width: 576px) {
            .alert-banner {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }

            .card-title {
                font-size: 1.2rem;
            }

            .status-title, .activity-title {
                font-size: 1.4rem;
            }
        }
    </style>

    <!-- Alert Banner -->
    <div class="alert-banner" id="alertBanner" runat="server">
        <div class="alert-content">
            <i class="fas fa-tools fa-2x"></i>
            <div>
                <h3>Proactive Support Alert</h3>
                <p>We've detected a potential issue in your area and have pre-booked a support slot for you.</p>
            </div>
        </div>
        <button class="alert-close"><i class="fas fa-times"></i></button>
    </div>

    <!-- Dashboard Cards -->
    <div class="dashboard-cards">
        <a href="/CustomerDashboard/AITroubleshooter.aspx" style="text-decoration: none; color: inherit;">
            <div class="card">
                <div class="card-header">
                    <div class="card-icon"><i class="fas fa-robot"></i></div>
                    <h3 class="card-title">AI Troubleshooter</h3>
                </div>
                <p class="card-content">Get instant help for common issues like slow internet, WiFi setup, or billing questions.</p>
                <div class="btn btn-primary">Start Troubleshooting</div>
            </div>
        </a>
        <a href="/CustomerDashboard/MySupportQueue.aspx" style="text-decoration: none; color: inherit;">
            <div class="card">
                <div class="card-header">
                    <div class="card-icon"><i class="fas fa-calendar-check"></i></div>
                    <h3 class="card-title">My Support Queue</h3>
                </div>
                <p class="card-content">View your upcoming support calls or proactively booked slots. Skip the standard queue.</p>
                <div class="btn btn-primary">View My Bookings</div>
            </div>
        </a>
        <a href="/CustomerDashboard/CommunityForum.aspx" style="text-decoration: none; color: inherit;">
            <div class="card">
                <div class="card-header">
                    <div class="card-icon"><i class="fas fa-comments"></i></div>
                    <h3 class="card-title">Community Forum</h3>
                </div>
                <p class="card-content">See issues and solutions reported by customers in your area. Official solutions provided by Telkom.</p>
                <div class="btn btn-primary">Browse Local Issues</div>
            </div>
        </a>
    </div>

    <!-- Service Status -->
    <div class="service-status">
        <div class="status-header">
            <h3 class="status-title">Service Status</h3>
            <button class="btn btn-secondary">View Details</button>
        </div>
        <div class="status-items">
            <div class="status-item">
                <div class="status-indicator status-online"></div>
                <div>
                    <h4>Internet Service</h4>
                    <p>Connected · 95 Mbps</p>
                </div>
            </div>
            <div class="status-item">
                <div class="status-indicator status-online"></div>
                <div>
                    <h4>Mobile Service</h4>
                    <p>Active · 12.5 GB remaining</p>
                </div>
            </div>
            <div class="status-item">
                <div class="status-indicator status-warning"></div>
                <div>
                    <h4>Landline Service</h4>
                    <p>Experiencing intermittent issues</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Activity Feed -->
    <div class="activity-feed">
        <div class="activity-header">
            <h3 class="activity-title">Recent Activity</h3>
            <button class="btn btn-secondary">View All</button>
        </div>
        <ul class="activity-items" id="activityFeed" runat="server">
            <!-- Items dynamically added in code-behind -->
        </ul>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const alertClose = document.querySelector('.alert-close');
            alertClose.addEventListener('click', function () {
                document.getElementById('alertBanner').style.display = 'none';
            });
        });
    </script>
</asp:Content>