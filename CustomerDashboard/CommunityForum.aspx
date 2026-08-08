<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CommunityForum.aspx.cs" Inherits="Telkom.CustomerDashboard.CommunityForum"  %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Community Forum</title>
    <style>
        :root {
            --primary-color: #0052cc;
            --secondary-color: #00a651;
            --accent-color: #ff7900;
            --white: #ffffff;
            --light-gray: #f8fafc;
            --medium-gray: #e2e8f0;
            --dark-gray: #64748b;
            --text-color: #1e293b;
            --error-color: #ef4444;
            --warning-color: #f59e0b;
            --success-color: #10b981;
            --shadow: 0 2px 8px rgba(0,0,0,0.05);
            --shadow-hover: 0 4px 16px rgba(0,0,0,0.1);
            --border-radius: 12px;
            --transition: all 0.3s ease;
        }
        
        * { 
            margin: 0; 
            padding: 0; 
            box-sizing: border-box; 
        }
        
        body { 
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; 
            background: var(--light-gray); 
            line-height: 1.6; 
            color: var(--text-color);
        }

        .container { 
            max-width: 1200px; 
            margin: 0 auto; 
            padding: 2rem; 
        }
        
        .header-section { 
            background: var(--white); 
            padding: 2rem; 
            border-radius: var(--border-radius); 
            margin-bottom: 2rem; 
            box-shadow: var(--shadow);
            background-image: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            color: white;
            position: relative;
            overflow: hidden;
        }
        
        .header-section::before {
            content: '';
            position: absolute;
            top: -50px;
            right: -50px;
            width: 150px;
            height: 150px;
            border-radius: 50%;
            background: rgba(255,255,255,0.1);
        }
        
        .header-section::after {
            content: '';
            position: absolute;
            bottom: -30px;
            left: -30px;
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: rgba(255,255,255,0.1);
        }
        
        .page-title { 
            font-size: 2.5rem; 
            font-weight: 700; 
            margin-bottom: 0.5rem; 
            position: relative;
            z-index: 2;
        }
        
        .page-subtitle { 
            font-size: 1.1rem; 
            opacity: 0.9;
            position: relative;
            z-index: 2;
        }
        
        .live-indicator {
            display: inline-flex;
            align-items: center;
            background: rgba(255,255,255,0.2);
            padding: 0.5rem 1rem;
            border-radius: 20px;
            margin-top: 1rem;
            font-size: 0.9rem;
            position: relative;
            z-index: 2;
            backdrop-filter: blur(5px);
        }
        
        .live-dot {
            width: 10px;
            height: 10px;
            background: var(--accent-color);
            border-radius: 50%;
            margin-right: 0.5rem;
            animation: pulse 1.5s infinite;
        }
        
        @keyframes pulse {
            0% { opacity: 1; }
            50% { opacity: 0.5; }
            100% { opacity: 1; }
        }
        
        .actions-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }
        
        .stats-group {
            display: flex;
            gap: 1.5rem;
        }
        
        .stat-item {
            background: var(--white);
            padding: 1rem 1.5rem;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            text-align: center;
            min-width: 120px;
            transition: var(--transition);
        }
        
        .stat-item:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-hover);
        }
        
        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 0.25rem;
        }
        
        .stat-label {
            font-size: 0.9rem;
            color: var(--dark-gray);
        }
        
        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: var(--border-radius);
            border: none;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .btn-primary {
            background: var(--primary-color);
            color: white;
        }
        
        .btn-primary:hover {
            background: #0042a8;
            transform: translateY(-2px);
            box-shadow: var(--shadow-hover);
        }
        
        .btn-secondary {
            background: var(--secondary-color);
            color: white;
        }
        
        .btn-warning {
            background: var(--warning-color);
            color: white;
        }
        
        .btn-outline {
            background: transparent;
            border: 1px solid var(--medium-gray);
            color: var(--dark-gray);
        }
        
        .btn-outline:hover {
            background: var(--light-gray);
        }
        
        .filters {
            display: flex;
            gap: 0.5rem;
            margin-bottom: 2rem;
            flex-wrap: wrap;
        }
        
        .filter-btn {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            border: 1px solid var(--medium-gray);
            background: var(--white);
            cursor: pointer;
            transition: var(--transition);
            font-size: 0.9rem;
        }
        
        .filter-btn:hover, .filter-btn.active {
            background: var(--primary-color);
            color: white;
            border-color: var(--primary-color);
        }
        
        .posts-container {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }
        
        .post-card {
            background: var(--white);
            border-radius: var(--border-radius);
            padding: 1.5rem;
            box-shadow: var(--shadow);
            transition: var(--transition);
            border-left: 4px solid var(--medium-gray);
        }
        
        .post-card:hover {
            box-shadow: var(--shadow-hover);
            transform: translateY(-2px);
        }
        
        .post-card.open {
            border-left-color: var(--warning-color);
        }
        
        .post-card.assigned {
            border-left-color: var(--primary-color);
        }
        
        .post-card.resolved {
            border-left-color: var(--success-color);
        }
        
        .post-card.priority {
            border-left-color: var(--error-color);
        }
        
        .post-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 1rem;
            gap: 1rem;
        }
        
        .post-info {
            flex: 1;
        }
        
        .post-title {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: var(--text-color);
        }
        
        .post-meta {
            display: flex;
            gap: 0.5rem;
            font-size: 0.9rem;
            color: var(--dark-gray);
        }
        
        .badges {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }
        
        .badge {
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }
        
        .badge-primary {
            background: var(--primary-color);
            color: white;
        }
        
        .badge-secondary {
            background: var(--secondary-color);
            color: white;
        }
        
        .badge-warning {
            background: var(--warning-color);
            color: white;
        }
        
        .badge-error {
            background: var(--error-color);
            color: white;
        }
        
        .badge-success {
            background: var(--success-color);
            color: white;
        }
        
        .badge-light {
            background: var(--medium-gray);
            color: var(--dark-gray);
        }
        
        .tags {
            display: flex;
            gap: 0.5rem;
            margin-bottom: 1rem;
            flex-wrap: wrap;
        }
        
        .tag {
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
            background: var(--light-gray);
            color: var(--dark-gray);
        }
        
        .post-content {
            margin-bottom: 1.5rem;
        }
        
        .post-description {
            color: var(--text-color);
            line-height: 1.6;
        }
        
        .solution {
            background: #f0fdf4;
            border-radius: var(--border-radius);
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            border-left: 4px solid var(--success-color);
        }
        
        .solution-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
            flex-wrap: wrap;
            gap: 0.5rem;
        }
        
        .solution-badge {
            background: var(--success-color);
            color: white;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }
        
        .technician-info {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.9rem;
        }
        
        .tech-label {
            color: var(--dark-gray);
        }
        
        .solution-text {
            color: var(--text-color);
            line-height: 1.6;
        }
        
        .post-actions {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }
        
        .modal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 1000;
            backdrop-filter: blur(5px);
        }
        
        .modal-content {
            background: var(--white);
            border-radius: var(--border-radius);
            width: 90%;
            max-width: 600px;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            animation: modalFadeIn 0.3s ease;
        }
        
        @keyframes modalFadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
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
            font-weight: 600;
        }
        
        .close-btn {
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            color: var(--dark-gray);
        }
        
        .modal-body {
            padding: 1.5rem;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
        }
        
        .form-control {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--medium-gray);
            border-radius: var(--border-radius);
            font-family: inherit;
            font-size: 1rem;
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(0,82,204,0.1);
        }
        
        .textarea {
            resize: vertical;
            min-height: 120px;
        }
        
        .error-message {
            color: var(--error-color);
            font-size: 0.9rem;
            margin-top: 0.25rem;
        }
        
        .modal-actions {
            display: flex;
            justify-content: flex-end;
            gap: 0.5rem;
            margin-top: 1rem;
        }
        
        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }
            
            .header-section {
                padding: 1.5rem;
            }
            
            .page-title {
                font-size: 2rem;
            }
            
            .actions-bar {
                flex-direction: column;
                align-items: stretch;
            }
            
            .stats-group {
                justify-content: space-around;
            }
            
            .stat-item {
                flex: 1;
                min-width: auto;
            }
            
            .post-header {
                flex-direction: column;
            }
            
            .post-actions {
                flex-direction: column;
            }
            
            .post-actions .btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="header-section">
                <h1 class="page-title">Community Forum</h1>
                <p class="page-subtitle">Get help from experts and share solutions with the community</p>
                <div class="live-indicator">
                    <div class="live-dot"></div>
                    Live updates enabled
                </div>
            </div>

            <div class="actions-bar">
                <div class="stats-group">
                    <div class="stat-item">
                        <div class="stat-value" id="totalPosts">0</div>
                        <div class="stat-label">Total Posts</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-value" id="openIssues">0</div>
                        <div class="stat-label">Open Issues</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-value" id="resolvedToday">0</div>
                        <div class="stat-label">Resolved Today</div>
                    </div>
                </div>
                <asp:Button ID="btnNewPost" runat="server" Text="+ Post New Issue" CssClass="btn btn-primary" OnClientClick="showModal(); return false;" />
            </div>

            <div class="filters">
                <button type="button" class="filter-btn active" onclick="filterPosts('all')">All Posts</button>
                <button type="button" class="filter-btn" onclick="filterPosts('open')">Open Issues</button>
                <button type="button" class="filter-btn" onclick="filterPosts('assigned')">Assigned</button>
                <button type="button" class="filter-btn" onclick="filterPosts('resolved')">Resolved</button>
                <button type="button" class="filter-btn" onclick="filterPosts('priority')">High Priority</button>
            </div>

            <div class="posts-container">
                <asp:Repeater ID="rptForumPosts" runat="server">
                    <ItemTemplate>
                        <div class="post-card <%# GetStatusClass(Container.DataItem) %>" 
                             data-post-type="<%# GetSafeValue(Eval("PostType")) %>" 
                             data-priority="<%# GetSafeValue(Eval("Priority")) %>">
                            <div class="post-header">
                                <div class="post-info">
                                    <h3 class="post-title"><%# Server.HtmlEncode(GetSafeValue(Eval("Title"))) %></h3>
                                    <div class="post-meta">
                                        <span class="author"><%# Server.HtmlEncode(GetSafeValue(Eval("AuthorName"))) %></span>
                                        <span class="timestamp">• <%# GetSafeValue(Eval("TimeAgo")) %></span>
                                    </div>
                                </div>
                                <div class="badges">
                                    <%# GetPriorityBadge(Container.DataItem) %>
                                    <%# GetPostTypeBadge(Container.DataItem) %>
                                    <%# GetAssignmentBadge(Container.DataItem) %>
                                    <%# GetStatusBadge(Container.DataItem) %>
                                </div>
                            </div>
                            
                            <div class="tags"><%# GetTagsHtml(Container.DataItem) %></div>

                            <div class="post-content">
                                <p class="post-description"><%# Server.HtmlEncode(GetSafeValue(Eval("Description"))) %></p>
                            </div>

                            <asp:Panel ID="pnlSolution" runat="server" Visible='<%# HasSolution(Container.DataItem) %>' CssClass="solution">
                                <div class="solution-header">
                                    <span class="solution-badge">✓ Solution Verified</span>
                                    <div class="technician-info">
                                        <strong><%# Server.HtmlEncode(GetTechnicianName(Container.DataItem)) %></strong>
                                        <span class="tech-label">(Technical Expert)</span>
                                    </div>
                                </div>
                                <p class="solution-text"><%# Server.HtmlEncode(GetSafeValue(Eval("Solution"))) %></p>
                            </asp:Panel>

                            <div class="post-actions">
                                <asp:Button ID="btnViewPost" runat="server" Text="View Details" CssClass="btn btn-primary" OnClick="BtnViewPost_Click" CommandArgument='<%# GetSafeValue(Eval("PostId")) %>' />
                                <asp:Button ID="btnReopenPost" runat="server" Text="Reopen Issue" CssClass="btn btn-warning" Visible='<%# CanReopen(Container.DataItem) %>' OnClick="BtnReopenPost_Click" CommandArgument='<%# GetSafeValue(Eval("PostId")) %>' />
                                <asp:Button ID="btnResolvePost" runat="server" Text="Mark Resolved" CssClass="btn btn-secondary" Visible='<%# CanResolve(Container.DataItem) %>' OnClick="BtnResolvePost_Click" CommandArgument='<%# GetSafeValue(Eval("PostId")) %>' />
                                <asp:Button ID="btnAssignPost" runat="server" Text="Assign to Me" CssClass="btn btn-outline" Visible='<%# CanAssign(Container.DataItem) %>' OnClick="BtnAssignPost_Click" CommandArgument='<%# GetSafeValue(Eval("PostId")) %>' />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>

          <!-- New Post Modal -->
  <asp:Panel ID="pnlNewPostModal" runat="server" CssClass="modal" Style="display: none;">
      <div class="modal-content">
          <div class="modal-header">
              <h2 class="modal-title">Create New Post</h2>
              <button type="button" class="close-btn" onclick="closeModal();">×</button>
          </div>
          <div class="modal-body">
              <div class="form-group">
                  <label class="form-label">Title</label>
                  <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" MaxLength="200" />
                  <asp:RequiredFieldValidator ID="rfvTitle" runat="server" ControlToValidate="txtTitle" ErrorMessage="Title is required" CssClass="error-message" ValidationGroup="NewPost" Display="Dynamic" />
              </div>
              <div class="form-group">
                  <label class="form-label">Description</label>
                  <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control textarea" TextMode="MultiLine" Rows="6" MaxLength="2000" />
                  <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription" ErrorMessage="Description is required" CssClass="error-message" ValidationGroup="NewPost" Display="Dynamic" />
              </div>
              <div class="form-group">
                  <label class="form-label">Tags (comma separated)</label>
                  <asp:TextBox ID="txtTags" runat="server" CssClass="form-control" MaxLength="500" />
              </div>
              <div class="modal-actions">
                  <asp:Button ID="btnCancelPost" runat="server" Text="Cancel" CssClass="btn btn-outline" OnClientClick="closeModal(); return false;" CausesValidation="false" />
                  <asp:Button ID="btnSubmitPost" runat="server" Text="Submit Post" CssClass="btn btn-primary" OnClick="BtnSubmitPost_Click" ValidationGroup="NewPost" />
              </div>
          </div>
      </div>
  </asp:Panel>
        </form>

  <script type="text/javascript">
      function showModal() {
          document.getElementById('<%= pnlNewPostModal.ClientID %>').style.display = 'flex';
      }

      function closeModal() {
          document.getElementById('<%= pnlNewPostModal.ClientID %>').style.display = 'none';
      }

      function filterPosts(filterType) {
          document.querySelectorAll('.filter-btn').forEach(btn => btn.classList.remove('active'));
          event.target.classList.add('active');
          document.querySelectorAll('.post-card').forEach(post => {
              let show = false;
              switch (filterType) {
                  case 'all': show = true; break;
                  case 'open': show = post.classList.contains('open'); break;
                  case 'assigned': show = post.classList.contains('assigned'); break;
                  case 'resolved': show = post.classList.contains('resolved'); break;
                  case 'priority': show = post.classList.contains('priority') || post.getAttribute('data-priority') === 'High'; break;
              }
              post.style.display = show ? 'block' : 'none';
          });
      }

      function updateForumStats(total, open, resolved) {
          document.getElementById('totalPosts').textContent = total || 0;
          document.getElementById('openIssues').textContent = open || 0;
          document.getElementById('resolvedToday').textContent = resolved || 0;
      }

      window.addEventListener('load', function () {
          const posts = document.querySelectorAll('.post-card');
          updateForumStats(posts.length,
              document.querySelectorAll('.post-card.open').length,
              document.querySelectorAll('.post-card.resolved').length);
      });
  </script>
</body>
</html>