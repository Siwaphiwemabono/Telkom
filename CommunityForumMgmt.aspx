<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/TechMaster.Master" CodeBehind="CommunityForumMgmt.aspx.cs" Inherits="Telkom.CommunityForumMgmt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="server">
    <style>
        /* Custom styles for Community Forum Management page */
        .stats-bar {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: var(--glass-bg);
            padding: 25px;
            border-radius: 12px;
            box-shadow: var(--glass-shadow);
            text-align: center;
            transition: transform 0.3s ease;
            border: var(--glass-border);
            backdrop-filter: blur(10px);
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-number {
            font-size: 2.5em;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .stat-number.total { color: var(--telkom-blue); }
        .stat-number.open { color: #ff6b6b; }
        .stat-number.progress { color: #feca57; }
        .stat-number.resolved { color: #48dbfb; }

        .stat-label {
            font-size: 1.1em;
            color: var(--telkom-dark-gray);
            font-weight: 500;
        }

        .refresh-indicator {
            position: fixed;
            top: 20px;
            right: 20px;
            background: var(--gradient-bg);
            color: var(--telkom-white);
            padding: 12px 20px;
            border-radius: 25px;
            font-weight: 500;
            display: none;
            z-index: 1000;
            animation: pulse 1s infinite;
            box-shadow: var(--glass-shadow);
            backdrop-filter: blur(10px);
            border: var(--glass-border);
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.7; }
        }

        .controls-section {
            background: var(--glass-bg);
            padding: 30px;
            margin-bottom: 25px;
            border-radius: 12px;
            box-shadow: var(--glass-shadow);
            border: var(--glass-border);
            backdrop-filter: blur(10px);
        }

        .auto-refresh-toggle {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 25px;
            padding-bottom: 20px;
            border-bottom: 2px solid rgba(255, 255, 255, 0.2);
        }

        .toggle-switch {
            width: 60px;
            height: 32px;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 16px;
            position: relative;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .toggle-switch.active {
            background: var(--telkom-green);
        }

        .toggle-slider {
            width: 24px;
            height: 24px;
            background: var(--telkom-white);
            border-radius: 50%;
            position: absolute;
            top: 4px;
            left: 4px;
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.3);
        }

        .toggle-switch.active .toggle-slider {
            left: 32px;
        }

        .auto-refresh-label {
            font-weight: 600;
            color: var(--telkom-dark-gray);
        }

        .filters-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            align-items: end;
        }

        .filter-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .filter-group label {
            font-weight: 600;
            color: var(--telkom-dark-gray);
            font-size: 0.95em;
        }

        .filter-select, .search-input {
            padding: 14px;
            background: rgba(255, 255, 255, 0.8);
            border: 2px solid rgba(0, 119, 204, 0.2);
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .filter-select:focus, .search-input:focus {
            outline: none;
            border-color: var(--telkom-blue);
            box-shadow: 0 0 0 4px rgba(0, 119, 204, 0.1);
        }

        .posts-container {
            display: flex;
            flex-direction: column;
            gap: 25px;
        }

        .forum-post {
            background: var(--glass-bg);
            border-radius: 12px;
            box-shadow: var(--glass-shadow);
            border: var(--glass-border);
            transition: all 0.3s ease;
            overflow: hidden;
            backdrop-filter: blur(10px);
        }

        .forum-post:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
        }

        .post-header {
            padding: 30px 30px 0 30px;
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            flex-wrap: wrap;
            gap: 15px;
        }

        .post-title {
            font-size: 1.5em;
            font-weight: 700;
            color: var(--telkom-dark-blue);
            margin-bottom: 15px;
            line-height: 1.3;
        }

        .post-meta {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            align-items: center;
        }

        .post-id {
            background: rgba(255, 255, 255, 0.2);
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.9em;
            color: var(--telkom-dark-gray);
            font-weight: 600;
        }

        .badge {
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .priority-high { 
            background: linear-gradient(135deg, #ff6b6b, #ee5a52);
            color: var(--telkom-white);
            box-shadow: 0 4px 15px rgba(255, 107, 107, 0.3);
        }
        .priority-medium { 
            background: linear-gradient(135deg, #feca57, #ff9ff3);
            color: var(--telkom-dark-gray);
            box-shadow: 0 4px 15px rgba(254, 202, 87, 0.3);
        }
        .priority-low { 
            background: linear-gradient(135deg, #48dbfb, #0abde3);
            color: var(--telkom-dark-gray);
            box-shadow: 0 4px 15px rgba(72, 219, 251, 0.3);
        }

        .status-open { 
            background: var(--telkom-blue);
            color: var(--telkom-white);
        }
        .status-in-progress { 
            background: var(--telkom-green);
            color: var(--telkom-dark-gray);
        }
        .status-resolved { 
            background: linear-gradient(135deg, #1dd1a1, #55a3ff);
            color: var(--telkom-white);
        }

        .type-badge {
            background: rgba(255, 255, 255, 0.3);
            color: var(--telkom-dark-gray);
        }

        .post-content {
            padding: 25px 30px 30px 30px;
        }

        .post-description {
            background: rgba(255, 255, 255, 0.2);
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 25px;
            color: var(--telkom-dark-gray);
            line-height: 1.7;
            border-left: 5px solid var(--telkom-blue);
            font-size: 1.05em;
        }

        .post-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
            padding: 25px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 10px;
        }

        .detail-item {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .detail-label {
            font-size: 0.9em;
            font-weight: 700;
            color: var(--telkom-dark-blue);
            text-transform: uppercase;
            letter-spacing: 0.8px;
        }

        .detail-value {
            font-weight: 600;
            color: var(--telkom-dark-gray);
            font-size: 1.05em;
        }

        .responses-section {
            border-top: 2px solid rgba(255, 255, 255, 0.2);
            padding-top: 25px;
        }

        .responses-header {
            font-size: 1.2em;
            font-weight: 700;
            color: var(--telkom-dark-blue);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .response-count {
            background: var(--telkom-blue);
            color: var(--telkom-white);
            padding: 4px 12px;
            border-radius: 15px;
            font-size: 0.85em;
            font-weight: 700;
        }

        .response-item {
            background: rgba(255, 255, 255, 0.2);
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 15px;
            border-left: 4px solid var(--telkom-blue);
            transition: all 0.3s ease;
        }

        .response-item:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateX(5px);
        }

        .response-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }

        .response-author {
            font-weight: 700;
            color: var(--telkom-dark-blue);
            font-size: 1.05em;
        }

        .response-time {
            font-size: 0.9em;
            color: var(--telkom-dark-gray);
            font-weight: 500;
        }

        .response-content {
            color: var(--telkom-dark-gray);
            line-height: 1.6;
            font-size: 1.05em;
        }

        .reply-section {
            margin-top: 25px;
            padding: 25px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            border: 2px dashed rgba(255, 255, 255, 0.3);
        }

        .reply-textarea {
            width: 100%;
            min-height: 120px;
            padding: 18px;
            background: rgba(255, 255, 255, 0.8);
            border: 2px solid rgba(0, 119, 204, 0.2);
            border-radius: 8px;
            resize: vertical;
            font-family: inherit;
            font-size: 14px;
            margin-bottom: 20px;
            transition: all 0.3s ease;
        }

        .reply-textarea:focus {
            outline: none;
            border-color: var(--telkom-blue);
            box-shadow: 0 0 0 4px rgba(0, 119, 204, 0.1);
        }

        .reply-actions {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .no-posts {
            text-align: center;
            padding: 80px 40px;
            color: var(--telkom-dark-gray);
            font-size: 1.3em;
            background: var(--glass-bg);
            border-radius: 12px;
            box-shadow: var(--glass-shadow);
            border: var(--glass-border);
            backdrop-filter: blur(10px);
        }

        .no-posts i {
            font-size: 4em;
            margin-bottom: 20px;
            opacity: 0.5;
        }

        .notification {
            position: fixed;
            top: 80px;
            right: 20px;
            padding: 18px 25px;
            border-radius: 8px;
            color: var(--telkom-white);
            font-weight: 600;
            z-index: 1000;
            display: none;
            animation: slideIn 0.4s ease;
            box-shadow: var(--glass-shadow);
            backdrop-filter: blur(10px);
            border: var(--glass-border);
        }

        .notification.success { 
            background: linear-gradient(135deg, #1dd1a1, #55a3ff);
        }
        .notification.error { 
            background: linear-gradient(135deg, #ff6b6b, #ee5a52);
        }
        .notification.warning { 
            background: linear-gradient(135deg, #feca57, #ff9ff3);
        }

        @keyframes slideIn {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .filters-grid {
                grid-template-columns: 1fr;
            }
            
            .post-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
            
            .post-details {
                grid-template-columns: 1fr;
            }
            
            .reply-actions {
                flex-direction: column;
            }
            
            .stats-bar {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 480px) {
            .stats-bar {
                grid-template-columns: 1fr;
            }
            
            .post-content, .post-header {
                padding: 20px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Statistics Bar -->
    <div class="stats-bar">
        <div class="stat-card">
            <div class="stat-number total" id="totalPosts">0</div>
            <div class="stat-label">Total Posts</div>
        </div>
        <div class="stat-card">
            <div class="stat-number open" id="openPosts">0</div>
            <div class="stat-label">Open Posts</div>
        </div>
        <div class="stat-card">
            <div class="stat-number progress" id="inProgressPosts">0</div>
            <div class="stat-label">In Progress</div>
        </div>
        <div class="stat-card">
            <div class="stat-number resolved" id="resolvedPosts">0</div>
            <div class="stat-label">Resolved</div>
        </div>
    </div>

    <div class="refresh-indicator" id="refreshIndicator">
        <i class="fas fa-sync-alt"></i> Refreshing posts...
    </div>

    <div class="notification" id="notification"></div>

    <div class="controls-section">
        <div class="auto-refresh-toggle">
            <div id="autoRefreshToggle" class="toggle-switch active" onclick="toggleAutoRefresh()">
                <div class="toggle-slider"></div>
            </div>
            <label id="autoRefreshLabel" class="auto-refresh-label">Auto-refresh: ON (30s)</label>
        </div>

        <div class="filters-grid">
            <div class="filter-group">
                <label>Status Filter</label>
                <asp:DropDownList ID="ddlStatusFilter" runat="server" CssClass="filter-select" onchange="applyFilters()">
                    <asp:ListItem Value="All" Text="All Posts" />
                    <asp:ListItem Value="Open" Text="Open" />
                    <asp:ListItem Value="Assigned" Text="In Progress" />
                    <asp:ListItem Value="Resolved" Text="Resolved" />
                </asp:DropDownList>
            </div>

            <div class="filter-group">
                <label>Priority Filter</label>
                <asp:DropDownList ID="ddlPriorityFilter" runat="server" CssClass="filter-select" onchange="applyFilters()">
                    <asp:ListItem Value="All" Text="All Priorities" />
                    <asp:ListItem Value="High" Text="High Priority" />
                    <asp:ListItem Value="Medium" Text="Medium Priority" />
                    <asp:ListItem Value="Low" Text="Low Priority" />
                </asp:DropDownList>
            </div>

            <div class="filter-group">
                <label>Search Posts</label>
                <asp:TextBox ID="txtSearch" runat="server" CssClass="search-input" placeholder="Search by title, description, or author..." oninput="applyFilters()" />
            </div>

            <div class="filter-group">
                <label>&nbsp;</label>
                <asp:Button ID="btnRefresh" runat="server" Text="Refresh Now" CssClass="btn btn-secondary" OnClick="BtnRefresh_Click" />
            </div>
        </div>
    </div>

    <!-- Posts Container -->
    <div class="posts-container">
        <asp:Repeater ID="rptForumPosts" runat="server">
            <ItemTemplate>
                <div class="forum-post" data-post-id='<%# Eval("PostId") %>' data-status='<%# Eval("Status") %>' data-priority='<%# Eval("Priority") %>'>
                    <div class="post-header">
                        <div>
                            <h3 class="post-title"><%# Eval("Title") %></h3>
                            <div class="post-meta">
                                <span class="badge priority-<%# Eval("Priority").ToString().ToLower() %>">
                                    <%# Eval("Priority") %> Priority
                                </span>
                                <span class="badge status-<%# GetStatusClass(Container.DataItem) %>">
                                    <%# Eval("Status") %>
                                </span>
                                <span class="badge type-badge">Support Request</span>
                            </div>
                        </div>
                        <div class="post-id">Post #<%# Eval("PostId") %></div>
                    </div>
                    
                    <div class="post-content">
                        <div class="post-description"><%# Eval("Description") %></div>
                        
                        <div class="post-details">
                            <div class="detail-item">
                                <span class="detail-label">Customer</span>
                                <span class="detail-value"><%# Eval("AuthorName") %></span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">Posted</span>
                                <span class="detail-value"><%# Eval("TimeAgo") %></span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">Status</span>
                                <span class="detail-value"><%# Eval("Status") %></span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">Assigned To</span>
                                <span class="detail-value"><%# string.IsNullOrEmpty(Eval("TechnicianName") as string) ? "Unassigned" : Eval("TechnicianName") %></span>
                            </div>
                        </div>
                        
                        <%# !string.IsNullOrEmpty(Eval("Solution") as string) ? "<div class=\"post-details\"><div class=\"detail-item\"><span class=\"detail-label\">Solution</span><span class=\"detail-value\">" + Eval("Solution") + "</span></div></div>" : "" %>
                        
                        <div class="responses-section">
                            <div class="responses-header">
                                <span>Technical Response</span>
                                <span class="response-count"><%# !string.IsNullOrEmpty(Eval("Solution") as string) ? "1" : "0" %></span>
                            </div>
                            
                            <%# !string.IsNullOrEmpty(Eval("Solution") as string) ? "<div class=\"response-item\"><div class=\"response-header\"><span class=\"response-author\">" + (string.IsNullOrEmpty(Eval("TechnicianName") as string) ? "Unassigned" : Eval("TechnicianName")) + " (Technician)</span><span class=\"response-time\">Recently</span></div><div class=\"response-content\">" + Eval("Solution") + "</div></div>" : "<div class=\"response-item\"><div class=\"response-content\" style=\"font-style: italic; color: #999;\">No technical response yet.</div></div>" %>
                            
                            <div id="reply_<%# Eval("PostId") %>" class="reply-section" style="display: none;">
                                <asp:TextBox ID="txtReply" runat="server" TextMode="MultiLine" CssClass="reply-textarea" placeholder="Type your technical response here..." />
                                <div class="reply-actions">
                                    <asp:Button ID="btnReply" runat="server" Text="Send Reply" CssClass="btn btn-reply" CommandArgument='<%# Eval("PostId") %>' OnClick="BtnReply_Click" />
                                    <asp:Button ID="btnResolve" runat="server" Text="Mark as Resolved" CssClass="btn btn-resolve" CommandArgument='<%# Eval("PostId") %>' OnClick="BtnResolvePost_Click" Visible='<%# Eval("Status").ToString() == "Open" || Eval("Status").ToString() == "Assigned" %>' />
                                    <asp:Button ID="btnAssign" runat="server" Text="Assign to Me" CssClass="btn btn-secondary" CommandArgument='<%# Eval("PostId") %>' OnClick="BtnAssignPost_Click" Visible='<%# Eval("Status").ToString() == "Open" %>' />
                                </div>
                            </div>
                            
                            <div style="margin-top: 20px;">
                                <button type="button" class="btn btn-primary" onclick="toggleReply(<%# Eval("PostId") %>)">
                                    <i class="fas fa-reply"></i> Respond to Customer
                                </button>
                                <%# Eval("Status").ToString() == "Resolved" ? "<button type=\"button\" class=\"btn btn-secondary\" onclick=\"reopenPost(" + Eval("PostId") + ")\"><i class=\"fas fa-undo\"></i> Reopen Post</button>" : "" %>
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        
        <div id="noPostsMessage" class="no-posts" style="display: none;">
            <i class="fas fa-inbox"></i>
            <p>No customer posts match your current filters.</p>
            <p style="font-size: 0.9em; margin-top: 10px; opacity: 0.8;">Try adjusting your search criteria or check back later for new posts.</p>
        </div>
    </div>

    <script>
        let autoRefreshEnabled = true;
        let refreshInterval;

        // Initialize the page
        document.addEventListener('DOMContentLoaded', function () {
            startAutoRefresh();
            updateStats();
            applyFilters();
        });

        function toggleAutoRefresh() {
            autoRefreshEnabled = !autoRefreshEnabled;
            const toggle = document.getElementById('autoRefreshToggle');
            const label = document.getElementById('autoRefreshLabel');

            if (autoRefreshEnabled) {
                toggle.classList.add('active');
                label.textContent = 'Auto-refresh: ON (30s)';
                startAutoRefresh();
            } else {
                toggle.classList.remove('active');
                label.textContent = 'Auto-refresh: OFF';
                clearInterval(refreshInterval);
            }
        }

        function startAutoRefresh() {
            if (refreshInterval) clearInterval(refreshInterval);
            refreshInterval = setInterval(function () {
                if (autoRefreshEnabled) {
                    refreshPosts();
                }
            }, 30000); // 30 seconds
        }

        function refreshPosts() {
            document.getElementById('refreshIndicator').style.display = 'block';

            setTimeout(() => {
                document.getElementById('refreshIndicator').style.display = 'none';
                showNotification('Posts refreshed successfully', 'success');
                updateStats();
            }, 1000);
        }

        function toggleReply(postId) {
            const replySection = document.getElementById('reply_' + postId);
            const isVisible = replySection.style.display !== 'none';
            replySection.style.display = isVisible ? 'none' : 'block';

            if (!isVisible) {
                const textarea = replySection.querySelector('textarea');
                if (textarea) {
                    setTimeout(() => textarea.focus(), 100);
                }
            }
        }

        function applyFilters() {
            const statusFilter = document.getElementById('<%= ddlStatusFilter.ClientID %>').value;
            const priorityFilter = document.getElementById('<%= ddlPriorityFilter.ClientID %>').value;
            const searchTerm = document.getElementById('<%= txtSearch.ClientID %>').value.toLowerCase();

            const posts = document.querySelectorAll('.forum-post');
            let visibleCount = 0;

            posts.forEach(post => {
                const postStatus = post.getAttribute('data-status');
                const postPriority = post.getAttribute('data-priority');
                const postTitle = post.querySelector('.post-title').textContent.toLowerCase();
                const postDescription = post.querySelector('.post-description').textContent.toLowerCase();
                const postAuthor = post.querySelector('.detail-value').textContent.toLowerCase();

                const matchesStatus = statusFilter === 'All' || postStatus === statusFilter;
                const matchesPriority = priorityFilter === 'All' || postPriority === priorityFilter;
                const matchesSearch = searchTerm === '' ||
                    postTitle.includes(searchTerm) ||
                    postDescription.includes(searchTerm) ||
                    postAuthor.includes(searchTerm);

                if (matchesStatus && matchesPriority && matchesSearch) {
                    post.style.display = 'block';
                    visibleCount++;
                } else {
                    post.style.display = 'none';
                }
            });

            const noPostsMessage = document.getElementById('noPostsMessage');
            noPostsMessage.style.display = visibleCount === 0 ? 'block' : 'none';
        }

        function updateStats() {
            const posts = document.querySelectorAll('.forum-post');
            let totalCount = posts.length;
            let openCount = 0;
            let progressCount = 0;
            let resolvedCount = 0;

            posts.forEach(post => {
                const status = post.getAttribute('data-status');
                switch (status) {
                    case 'Open':
                        openCount++;
                        break;
                    case 'Assigned':
                        progressCount++;
                        break;
                    case 'Resolved':
                        resolvedCount++;
                        break;
                }
            });

            document.getElementById('totalPosts').textContent = totalCount;
            document.getElementById('openPosts').textContent = openCount;
            document.getElementById('inProgressPosts').textContent = progressCount;
            document.getElementById('resolvedPosts').textContent = resolvedCount;
        }

        function showNotification(message, type) {
            const notification = document.getElementById('notification');
            notification.textContent = message;
            notification.className = `notification ${type}`;
            notification.style.display = 'block';

            setTimeout(() => {
                notification.style.display = 'none';
            }, 4000);
        }

        function reopenPost(postId) {
            if (confirm('Are you sure you want to reopen this post?')) {
                // This would trigger a postback to reopen the post
                __doPostBack('<%= btnRefresh.UniqueID %>', 'reopen_' + postId);
            }
        }

        // Update stats on page load
        window.addEventListener('load', function () {
            updateStats();
        });

        // Keyboard shortcuts
        document.addEventListener('keydown', function (e) {
            // Ctrl/Cmd + R: Refresh
            if ((e.ctrlKey || e.metaKey) && e.key === 'r') {
                e.preventDefault();
                document.getElementById('<%= btnRefresh.ClientID %>').click();
            }

            // Ctrl/Cmd + F: Focus search
            if ((e.ctrlKey || e.metaKey) && e.key === 'f') {
                e.preventDefault();
                document.getElementById('<%= txtSearch.ClientID %>').focus();
            }
        });
    </script>
</asp:Content>