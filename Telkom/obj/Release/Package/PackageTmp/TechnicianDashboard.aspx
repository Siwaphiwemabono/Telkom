<%@ Page Title="Technician Dashboard" Language="C#" MasterPageFile="~/TechMaster.Master" AutoEventWireup="true" CodeBehind="TechnicianDashboard.aspx.cs" Inherits="Telkom.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="server">
    <style>
        :root {
            --telkom-blue: #0077CC;
            --telkom-green: #66CC00;
            --telkom-dark-blue: #003366;
            --telkom-white: #FFFFFF;
            --telkom-soft-white: #F5F7FB;
            --telkom-black: #0A0A0A;
            --telkom-dark-gray: #1F1F1F;
            --gradient-bg: linear-gradient(135deg, #004080 0%, #0077CC 100%);
            --glass-bg: rgba(255, 255, 255, 0.1);
            --glass-border: 1px solid rgba(255, 255, 255, 0.3);
            --glass-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
        }

        .dashboard-container {
            padding: 0;
            background-color: transparent;
            min-height: 100vh;
        }

        /* Welcome Header */
        .welcome-header {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            color: var(--telkom-dark-gray);
            padding: 25px;
            border-radius: 12px;
            margin-bottom: 30px;
            box-shadow: var(--glass-shadow);
            border: var(--glass-border);
            animation: fadeIn 0.8s ease forwards;
        }

        .welcome-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .welcome-text h1 {
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 10px;
            background: var(--gradient-bg);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .welcome-text p {
            font-size: 1.1rem;
            color: var(--telkom-dark-gray);
            opacity: 0.9;
        }

        .tech-info {
            text-align: right;
            background: var(--glass-bg);
            padding: 15px 20px;
            border-radius: 8px;
            backdrop-filter: blur(5px);
            border: var(--glass-border);
        }

        .tech-name {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 5px;
            color: var(--telkom-dark-blue);
        }

        .tech-id {
            opacity: 0.8;
            font-size: 0.9rem;
            color: var(--telkom-dark-gray);
        }

        /* Quick Stats */
        .quick-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            padding: 25px;
            border-radius: 12px;
            text-align: center;
            box-shadow: var(--glass-shadow);
            border: var(--glass-border);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            animation: slideUp 0.5s ease forwards;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--gradient-bg);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 28px rgba(0, 0, 0, 0.25);
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--telkom-blue);
            margin-bottom: 10px;
            display: block;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .stat-label {
            color: var(--telkom-dark-gray);
            font-weight: 500;
            font-size: 0.95rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Quick Actions */
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .action-card {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border-radius: 12px;
            padding: 25px;
            box-shadow: var(--glass-shadow);
            border: var(--glass-border);
            transition: all 0.3s ease;
            animation: slideUp 0.6s ease forwards;
        }

        .action-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
        }

        .action-header {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .action-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-size: 1.3rem;
            color: var(--telkom-white);
            background: var(--gradient-bg);
            box-shadow: 0 4px 12px rgba(0, 66, 128, 0.3);
        }

        .action-title {
            font-size: 1.3rem;
            font-weight: 600;
            color: var(--telkom-dark-blue);
            margin-bottom: 5px;
        }

        .action-description {
            color: var(--telkom-dark-gray);
            font-size: 0.95rem;
            margin-bottom: 20px;
            line-height: 1.5;
        }

        .action-btn {
            background: var(--gradient-bg);
            color: var(--telkom-white);
            border: none;
            padding: 12px 25px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.9rem;
            box-shadow: 0 4px 12px rgba(0, 66, 128, 0.3);
        }

        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(0, 66, 128, 0.4);
        }

        /* Recent Activity */
        .recent-activity {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border-radius: 12px;
            padding: 25px;
            box-shadow: var(--glass-shadow);
            border: var(--glass-border);
            animation: fadeIn 0.7s ease forwards;
        }

        .activity-header {
            border-bottom: 1px solid rgba(255, 255, 255, 0.3);
            padding-bottom: 15px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .activity-title {
            font-size: 1.4rem;
            font-weight: 600;
            color: var(--telkom-dark-blue);
        }

        .view-all {
            color: var(--telkom-blue);
            text-decoration: none;
            font-weight: 500;
            font-size: 0.9rem;
        }

        .view-all:hover {
            text-decoration: underline;
        }

        .activity-item {
            display: flex;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
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
            color: var(--telkom-dark-gray);
        }

        .activity-badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .badge-resolved { 
            background: rgba(102, 204, 0, 0.2); 
            color: #3d6600; 
        }
        .badge-new { 
            background: rgba(0, 119, 204, 0.2); 
            color: var(--telkom-dark-blue); 
        }
        .badge-forum { 
            background: rgba(255, 204, 0, 0.2); 
            color: #806600; 
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideUp {
            from { transform: translateY(20px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .welcome-content {
                flex-direction: column;
                text-align: center;
                gap: 20px;
            }
            
            .tech-info {
                text-align: center;
            }
            
            .quick-stats {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .quick-stats {
                grid-template-columns: 1fr;
            }
            
            .quick-actions {
                grid-template-columns: 1fr;
            }
            
            .welcome-text h1 {
                font-size: 1.8rem;
            }
            
            .stat-number {
                font-size: 2rem;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="dashboard-container">
        <!-- Welcome Header -->
        <div class="welcome-header">
            <div class="welcome-content">
                <div class="welcome-text">
                    <h1>Welcome Back, Technician</h1>
                    <p>Your support dashboard and workspace</p>
                </div>
                <div class="tech-info">
                    <div class="tech-name">Michael Thompson</div>
                    <div class="tech-id">Tech ID: TK-2024-001</div>
                </div>
            </div>
        </div>

        <!-- Quick Stats -->
        <div class="quick-stats">
            <div class="stat-card">
                <span class="stat-number" id="assignedCases">12</span>
                <div class="stat-label">Assigned Cases</div>
            </div>
            <div class="stat-card">
                <span class="stat-number" id="resolvedToday">8</span>
                <div class="stat-label">Resolved Today</div>
            </div>
            <div class="stat-card">
                <span class="stat-number" id="forumQuestions">5</span>
                <div class="stat-label">Forum Questions</div>
            </div>
            <div class="stat-card">
                <span class="stat-number" id="avgResponseTime">2.3h</span>
                <div class="stat-label">Avg Response Time</div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="quick-actions">
            <div class="action-card">
                <div class="action-header">
                    <div class="action-icon">⚡</div>
                    <div>
                        <div class="action-title">Escalated Queue</div>
                        <div class="action-description">View and manage cases assigned to you by supervisors</div>
                    </div>
                </div>
                <button class="action-btn" onclick="navigateToEscalated()">View Queue</button>
            </div>

            <div class="action-card">
                <div class="action-header">
                    <div class="action-icon">💬</div>
                    <div>
                        <div class="action-title">Community Forum</div>
                        <div class="action-description">Answer customer questions and provide technical support</div>
                    </div>
                </div>
                <button class="action-btn" onclick="navigateToForum()">Answer Questions</button>
            </div>
        </div>

        <!-- Recent Activity -->
        <div class="recent-activity">
            <div class="activity-header">
                <div class="activity-title">Recent Activity</div>
                <a href="#" class="view-all">View All</a>
            </div>
            <div id="activityList">
                <!-- Activity items will be loaded here -->
            </div>
        </div>
    </div>

    <script>
        // Sample activity data
        let recentActivity = [
            {
                time: '10:30',
                content: 'Resolved case TC-2024-1001 - Internet connectivity issue',
                type: 'resolved'
            },
            {
                time: '09:45',
                content: 'New case assigned TC-2024-1005 - Router configuration',
                type: 'new'
            },
            {
                time: '09:15',
                content: 'Answered forum question about WiFi setup',
                type: 'forum'
            },
            {
                time: '08:30',
                content: 'Resolved case TC-2024-0998 - Email configuration',
                type: 'resolved'
            },
            {
                time: '08:00',
                content: 'Started work session',
                type: 'new'
            }
        ];

        // Initialize dashboard
        document.addEventListener('DOMContentLoaded', function () {
            loadRecentActivity();
            updateStats();
            startRealTimeUpdates();

            // Add staggered animations
            document.querySelectorAll('.stat-card').forEach((card, index) => {
                card.style.animationDelay = `${index * 0.1}s`;
            });

            document.querySelectorAll('.action-card').forEach((card, index) => {
                card.style.animationDelay = `${index * 0.15 + 0.3}s`;
            });
        });

        function loadRecentActivity() {
            const activityList = document.getElementById('activityList');

            activityList.innerHTML = recentActivity.map(activity => `
                <div class="activity-item">
                    <div class="activity-time">${activity.time}</div>
                    <div class="activity-content">${activity.content}</div>
                    <span class="activity-badge badge-${activity.type}">${activity.type}</span>
                </div>
            `).join('');
        }

        function updateStats() {
            // Simulate real-time stat updates
            document.getElementById('assignedCases').textContent = Math.floor(Math.random() * 5) + 10;
            document.getElementById('resolvedToday').textContent = Math.floor(Math.random() * 3) + 6;
            document.getElementById('forumQuestions').textContent = Math.floor(Math.random() * 4) + 3;

            const avgTime = (Math.random() * 2 + 1.5).toFixed(1);
            document.getElementById('avgResponseTime').textContent = avgTime + 'h';
        }

        function startRealTimeUpdates() {
            // Update stats every 30 seconds
            setInterval(() => {
                updateStats();

                // Occasionally add new activity
                if (Math.random() > 0.7) {
                    const newActivities = [
                        'New case assigned TC-2024-' + Math.floor(Math.random() * 9999),
                        'Resolved case TC-2024-' + Math.floor(Math.random() * 9999),
                        'Answered forum question about technical issue',
                        'Updated case status to in progress'
                    ];

                    const newActivity = {
                        time: new Date().toLocaleTimeString('en-US', {
                            hour12: false,
                            hour: '2-digit',
                            minute: '2-digit'
                        }),
                        content: newActivities[Math.floor(Math.random() * newActivities.length)],
                        type: ['resolved', 'new', 'forum'][Math.floor(Math.random() * 3)]
                    };

                    recentActivity.unshift(newActivity);
                    recentActivity = recentActivity.slice(0, 5); // Keep only 5 items
                    loadRecentActivity();
                }
            }, 30000);
        }

        // Navigation functions
        function navigateToEscalated() {
            window.location.href = 'EscalatedQueue.aspx';
        }

        function navigateToForum() {
            window.location.href = 'CommunityForum.aspx';
        }
    </script>
</asp:Content>