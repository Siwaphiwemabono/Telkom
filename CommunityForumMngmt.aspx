<%@ Page Title="Community Forum Management" Language="C#" MasterPageFile="~/TechMaster.Master" AutoEventWireup="true" CodeBehind="CommunityForumMngmt.aspx.cs" Inherits="Telkom.CommunityForumMgmt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="server">
    <style>
        .forum-filters {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }
        
        .filter-group {
            display: flex;
            flex-direction: column;
        }
        
        .filter-group label {
            font-weight: bold;
            margin-bottom: 5px;
            color: #1e293b;
        }
        
        .filter-select {
            padding: 8px;
            border: 1px solid #cbd5e1;
            border-radius: 4px;
            background-color: white;
        }
        
        .search-box {
            flex: 1;
            min-width: 250px;
        }
        
        .search-input {
            width: 100%;
            padding: 8px 12px;
            border: 1px solid #cbd5e1;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .forum-post {
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            margin-bottom: 20px;
            overflow: hidden;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        
        .post-header {
            background: #f8fafc;
            padding: 15px 20px;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .post-title {
            font-size: 18px;
            font-weight: bold;
            color: #1e293b;
            margin: 0;
        }
        
        .post-meta {
            display: flex;
            gap: 15px;
            align-items: center;
            flex-wrap: wrap;
        }
        
        .priority-badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            text-transform: uppercase;
        }
        
        .priority-high { background: #fef2f2; color: #dc2626; border: 1px solid #fecaca; }
        .priority-medium { background: #fffbeb; color: #d97706; border: 1px solid #fed7aa; }
        .priority-low { background: #f0fdf4; color: #16a34a; border: 1px solid #bbf7d0; }
        
        .status-badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }
        
        .status-open { background: #dbeafe; color: #1d4ed8; }
        .status-in-progress { background: #fef3c7; color: #d97706; }
        .status-resolved { background: #dcfce7; color: #16a34a; }
        
        .post-content {
            padding: 20px;
        }
        
        .post-description {
            margin-bottom: 15px;
            line-height: 1.6;
            color: #374151;
        }
        
        .post-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-bottom: 20px;
            padding: 15px;
            background: #f8fafc;
            border-radius: 6px;
        }
        
        .detail-item {
            display: flex;
            flex-direction: column;
        }
        
        .detail-label {
            font-weight: bold;
            color: #64748b;
            font-size: 12px;
            text-transform: uppercase;
            margin-bottom: 4px;
        }
        
        .detail-value {
            color: #1e293b;
        }
        
        .responses-section {
            border-top: 1px solid #e2e8f0;
            padding: 20px;
            background: #fafafa;
        }
        
        .response-item {
            background: white;
            padding: 15px;
            border-radius: 6px;
            margin-bottom: 10px;
            border-left: 4px solid #0052cc;
        }
        
        .response-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 8px;
        }
        
        .response-author {
            font-weight: bold;
            color: #0052cc;
        }
        
        .response-time {
            font-size: 12px;
            color: #64748b;
        }
        
        .response-content {
            line-height: 1.6;
            color: #374151;
        }
        
        .reply-section {
            margin-top: 15px;
            padding: 15px;
            background: white;
            border-radius: 6px;
            border: 1px solid #e2e8f0;
        }
        
        .reply-textarea {
            width: 100%;
            min-height: 100px;
            padding: 12px;
            border: 1px solid #cbd5e1;
            border-radius: 4px;
            resize: vertical;
            font-family: inherit;
            margin-bottom: 10px;
        }
        
        .reply-actions {
            display: flex;
            gap: 10px;
            align-items: center;
        }
        
        .btn-reply {
            background: #0052cc;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }
        
        .btn-reply:hover {
            background: #003d99;
        }
        
        .btn-resolve {
            background: #16a34a;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }
        
        .btn-resolve:hover {
            background: #15803d;
        }
        
        .btn-escalate {
            background: #dc2626;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }
        
        .btn-escalate:hover {
            background: #b91c1c;
        }
        
        .no-posts {
            text-align: center;
            padding: 40px;
            color: #64748b;
        }
        
        .refresh-indicator {
            position: fixed;
            top: 80px;
            right: 20px;
            background: #0052cc;
            color: white;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 14px;
            z-index: 1000;
            display: none;
        }
        
        .auto-refresh-toggle {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 20px;
        }
        
        .toggle-switch {
            position: relative;
            width: 50px;
            height: 24px;
            background: #cbd5e1;
            border-radius: 12px;
            cursor: pointer;
            transition: background 0.3s;
        }
        
        .toggle-switch.active {
            background: #0052cc;
        }
        
        .toggle-slider {
            position: absolute;
            top: 2px;
            left: 2px;
            width: 20px;
            height: 20px;
            background: white;
            border-radius: 50%;
            transition: transform 0.3s;
        }
        
        .toggle-switch.active .toggle-slider {
            transform: translateX(26px);
        }
    </style>
    
    <script type="text/javascript">
        var autoRefreshEnabled = true;
        var refreshInterval;
        
        function toggleAutoRefresh() {
            autoRefreshEnabled = !autoRefreshEnabled;
            var toggle = document.getElementById('autoRefreshToggle');
            var label = document.getElementById('autoRefreshLabel');
            
            if (autoRefreshEnabled) {
                toggle.className = 'toggle-switch active';
                label.innerText = 'Auto-refresh: ON (30s)';
                startAutoRefresh();
            } else {
                toggle.className = 'toggle-switch';
                label.innerText = 'Auto-refresh: OFF';
                clearInterval(refreshInterval);
            }
        }
        
        function startAutoRefresh() {
            if (refreshInterval) clearInterval(refreshInterval);
            refreshInterval = setInterval(function() {
                if (autoRefreshEnabled) {
                    document.getElementById('refreshIndicator').style.display = 'block';
                    __doPostBack('<%= UpdatePanel1.ClientID %>', '');
                    setTimeout(function() {
                        document.getElementById('refreshIndicator').style.display = 'none';
                    }, 1000);
                }
            }, 30000); // Refresh every 30 seconds
        }
        
        function expandReply(postId) {
            var replySection = document.getElementById('reply_' + postId);
            if (replySection.style.display === 'none' || replySection.style.display === '') {
                replySection.style.display = 'block';
            } else {
                replySection.style.display = 'none';
            }
        }
        
        window.onload = function() {
            startAutoRefresh();
        };
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="refresh-indicator" id="refreshIndicator">Refreshing posts...</div>
    
    <h2>Community Forum Management</h2>
    
    <!-- Auto-refresh toggle -->
    <div class="auto-refresh-toggle">
        <div id="autoRefreshToggle" class="toggle-switch active" onclick="toggleAutoRefresh()">
            <div class="toggle-slider"></div>
        </div>
        <label id="autoRefreshLabel">Auto-refresh: ON (30s)</label>
    </div>
    
    <!-- Filters -->
    <div class="dashboard-card">
        <div class="card-header">Filters & Search</div>
        <div class="forum-filters">
            <div class="filter-group">
                <label>Status</label>
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="filter-select" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed">
                    <asp:ListItem Value="All" Text="All Posts" Selected="True" />
                    <asp:ListItem Value="Open" Text="Open" />
                    <asp:ListItem Value="In Progress" Text="In Progress" />
                    <asp:ListItem Value="Resolved" Text="Resolved" />
                </asp:DropDownList>
            </div>
            
            <div class="filter-group">
                <label>Priority</label>
                <asp:DropDownList ID="ddlPriority" runat="server" CssClass="filter-select" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed">
                    <asp:ListItem Value="All" Text="All Priorities" Selected="True" />
                    <asp:ListItem Value="High" Text="High Priority" />
                    <asp:ListItem Value="Medium" Text="Medium Priority" />
                    <asp:ListItem Value="Low" Text="Low Priority" />
                </asp:DropDownList>
            </div>
            
            <div class="filter-group">
                <label>Post Type</label>
                <asp:DropDownList ID="ddlType" runat="server" CssClass="filter-select" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed">
                    <asp:ListItem Value="All" Text="All Types" Selected="True" />
                    <asp:ListItem Value="Issue" Text="Issues" />
                    <asp:ListItem Value="Question" Text="Questions" />
                    <asp:ListItem Value="Request" Text="Requests" />
                </asp:DropDownList>
            </div>
            
            <div class="search-box">
                <label>Search</label>
                <asp:TextBox ID="txtSearch" runat="server" CssClass="search-input" placeholder="Search posts..." AutoPostBack="true" OnTextChanged="Filter_Changed" />
            </div>
            
            <div class="filter-group">
                <label>&nbsp;</label>
                <asp:Button ID="btnRefresh" runat="server" Text="Refresh Now" CssClass="btn btn-secondary" OnClick="btnRefresh_Click" />
            </div>
        </div>
    </div>
    
    <!-- Forum Posts with UpdatePanel for real-time updates -->
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
        <ContentTemplate>
            <asp:Repeater ID="rptForumPosts" runat="server" OnItemCommand="rptForumPosts_ItemCommand">
                <ItemTemplate>
                    <div class="forum-post">
                        <div class="post-header">
                            <div>
                                <h3 class="post-title"><%# Eval("Title") %></h3>
                                <div class="post-meta">
                                    <span class='priority-badge priority-<%# Eval("Priority").ToString().ToLower() %>'>
                                        <%# Eval("Priority") %> Priority
                                    </span>
                                    <span class='status-badge status-<%# Eval("Status").ToString().ToLower().Replace(" ", "-") %>'>
                                        <%# Eval("Status") %>
                                    </span>
                                    <span><%# Eval("PostType") %></span>
                                </div>
                            </div>
                            <div class="post-meta">
                                <small>Post #<%# Eval("PostId") %></small>
                            </div>
                        </div>
                        
                        <div class="post-content">
                            <div class="post-description">
                                <%# Eval("Description") %>
                            </div>
                            
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
                                    <span class="detail-label">Last Updated</span>
                                    <span class="detail-value"><%# Eval("LastUpdated") %></span>
                                </div>
                                <div class="detail-item">
                                    <span class="detail-label">Assigned To</span>
                                    <span class="detail-value"><%# string.IsNullOrEmpty(Eval("TechnicianName")?.ToString()) ? "Unassigned" : Eval("TechnicianName") %></span>
                                </div>
                            </div>
                            
                            <!-- Responses Section -->
                            <div class="responses-section">
                                <h4>Responses (<%# Eval("ResponseCount") %>)</h4>
                                
                                <asp:Repeater ID="rptResponses" runat="server" DataSource='<%# Eval("Responses") %>'>
                                    <ItemTemplate>
                                        <div class="response-item">
                                            <div class="response-header">
                                                <span class="response-author"><%# Eval("AuthorName") %> (<%# Eval("AuthorRole") %>)</span>
                                                <span class="response-time"><%# Eval("TimeAgo") %></span>
                                            </div>
                                            <div class="response-content">
                                                <%# Eval("Content") %>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                                
                                <!-- Reply Section -->
                                <div id='reply_<%# Eval("PostId") %>' class="reply-section" style="display: none;">
                                    <asp:TextBox ID="txtReply" runat="server" TextMode="MultiLine" CssClass="reply-textarea" 
                                        placeholder="Type your response here..." />
                                    <div class="reply-actions">
                                        <asp:Button ID="btnSendReply" runat="server" Text="Send Reply" CssClass="btn-reply"
                                            CommandName="SendReply" CommandArgument='<%# Eval("PostId") %>' />
                                        <asp:Button ID="btnMarkResolved" runat="server" Text="Mark as Resolved" CssClass="btn-resolve"
                                            CommandName="MarkResolved" CommandArgument='<%# Eval("PostId") %>'
                                            Visible='<%# Eval("Status").ToString() != "Resolved" %>' />
                                        <asp:Button ID="btnEscalate" runat="server" Text="Escalate" CssClass="btn-escalate"
                                            CommandName="Escalate" CommandArgument='<%# Eval("PostId") %>'
                                            Visible='<%# Eval("Priority").ToString() != "High" %>' />
                                    </div>
                                </div>
                                
                                <div style="margin-top: 10px;">
                                    <button type="button" class="btn btn-primary" onclick='expandReply(<%# Eval("PostId") %>)'>
                                        Reply to this post
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            
            <asp:Label ID="lblNoPostsMessage" runat="server" CssClass="no-posts" Text="No posts match your current filters." Visible="false" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>