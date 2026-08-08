<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/CustomerDashboard/Customer.Master" CodeBehind="CommunityForum.aspx.cs" Inherits="Telkom.CustomerDashboard.CommunityForum" %>

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

        /* Forum Section */
        .forum-section {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: var(--glass-shadow);
            animation: fadeIn 0.5s ease forwards;
        }

        .forum-section h3 {
            color: var(--telkom-white);
            font-size: 2rem;
            margin-bottom: 10px;
        }

        .forum-section p {
            color: rgba(255, 255, 255, 0.9);
            font-size: 1.1rem;
        }

        /* Forum Controls */
        .forum-controls {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            flex-wrap: wrap;
            gap: 15px;
        }

        .search-box {
            display: flex;
            align-items: center;
            background: var(--telkom-white);
            border-radius: 8px;
            padding: 8px 15px;
            box-shadow: var(--glass-shadow);
        }

        .search-box input {
            border: none;
            outline: none;
            padding: 8px;
            width: 250px;
            background: transparent;
        }

        .btn {
            padding: 12px 20px;
            border-radius: 8px;
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
            box-shadow: var(--glass-shadow);
        }

        .btn-primary:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
        }

        .btn-secondary {
            background: var(--telkom-dark-gray);
            color: var(--telkom-white);
        }

        /* Forum Content */
        .forum-content {
            display: grid;
            grid-template-columns: 1fr 300px;
            gap: 25px;
        }

        @media (max-width: 992px) {
            .forum-content {
                grid-template-columns: 1fr;
            }
        }

        /* Thread List */
        .thread-list {
            background: var(--telkom-white);
            border-radius: 12px;
            padding: 20px;
            box-shadow: var(--glass-shadow);
        }

        .thread-item {
            padding: 20px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            position: relative;
        }

        .thread-item:last-child {
            border-bottom: none;
        }

        .thread-item:hover {
            background: var(--telkom-soft-white);
            transform: translateX(5px);
        }

        .thread-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--telkom-dark-blue);
            margin-bottom: 10px;
            display: block;
            text-decoration: none;
            cursor: pointer;
        }

        .thread-title:hover {
            color: var(--telkom-blue);
        }

        .thread-meta {
            display: flex;
            gap: 15px;
            font-size: 0.9rem;
            color: var(--telkom-dark-gray);
            margin-bottom: 10px;
            flex-wrap: wrap;
        }

        .thread-excerpt {
            color: var(--telkom-dark-gray);
            margin-bottom: 15px;
            line-height: 1.5;
        }

        .thread-stats {
            display: flex;
            gap: 15px;
            font-size: 0.9rem;
            justify-content: space-between;
            align-items: center;
        }

        .thread-stat {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .status-badge {
            padding: 4px 12px;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-open {
            background: #ff6b6b;
            color: white;
        }

        .status-assigned {
            background: #feca57;
            color: white;
        }

        .status-resolved {
            background: #1dd1a1;
            color: white;
        }

        .priority-badge {
            padding: 4px 8px;
            border-radius: 10px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .priority-high {
            background: #ff4757;
            color: white;
        }

        .priority-medium {
            background: #ffa502;
            color: white;
        }

        .priority-low {
            background: #2ed573;
            color: white;
        }

        /* Thread Details */
        .thread-details {
            display: none;
            background: #f8f9fa;
            padding: 20px;
            margin-top: 15px;
            border-radius: 8px;
            border-left: 4px solid var(--telkom-blue);
        }

        .thread-details.show {
            display: block;
            animation: slideDown 0.3s ease;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                max-height: 0;
            }
            to {
                opacity: 1;
                max-height: 500px;
            }
        }

        .response-section {
            margin-top: 20px;
            padding: 15px;
            background: #e9ecef;
            border-radius: 6px;
        }

        .response-header {
            font-weight: 600;
            color: var(--telkom-dark-blue);
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .response-content {
            color: var(--telkom-dark-gray);
            line-height: 1.5;
        }

        .no-response {
            font-style: italic;
            color: #999;
        }

        /* Forum Sidebar */
        .forum-sidebar {
            background: var(--telkom-white);
            border-radius: 12px;
            padding: 20px;
            box-shadow: var(--glass-shadow);
            height: fit-content;
        }

        .sidebar-section {
            margin-bottom: 25px;
        }

        .sidebar-section:last-child {
            margin-bottom: 0;
        }

        .sidebar-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--telkom-dark-blue);
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--telkom-green);
        }

        .category-list, .popular-threads {
            list-style: none;
            padding: 0;
        }

        .category-item, .popular-thread {
            padding: 10px 0;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        }

        .category-item:last-child, .popular-thread:last-child {
            border-bottom: none;
        }

        .category-link, .popular-thread-link {
            display: flex;
            justify-content: space-between;
            text-decoration: none;
            color: var(--telkom-dark-gray);
            transition: color 0.3s ease;
        }

        .category-link:hover, .popular-thread-link:hover {
            color: var(--telkom-blue);
        }

        .category-count {
            background: var(--telkom-green);
            color: var(--telkom-dark-gray);
            padding: 2px 8px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        /* New Post Modal */
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
            background-color: var(--telkom-white);
            margin: 5% auto;
            padding: 30px;
            border-radius: 12px;
            width: 90%;
            max-width: 600px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
            animation: slideIn 0.3s ease;
        }

        @keyframes slideIn {
            from {
                transform: translateY(-50px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f1f3f4;
        }

        .modal-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--telkom-dark-blue);
        }

        .close {
            color: #aaa;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
            transition: color 0.3s ease;
        }

        .close:hover {
            color: #000;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--telkom-dark-blue);
        }

        .form-control {
            width: 100%;
            padding: 12px;
            border: 2px solid #e1e8ed;
            border-radius: 6px;
            font-size: 14px;
            transition: border-color 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--telkom-blue);
        }

        .form-control.textarea {
            min-height: 120px;
            resize: vertical;
        }

        /* Pagination */
        .forum-pagination {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 30px;
        }

        .page-link {
            padding: 8px 15px;
            border-radius: 5px;
            background: var(--telkom-soft-white);
            color: var(--telkom-dark-gray);
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .page-link:hover, .page-link.active {
            background: var(--telkom-blue);
            color: var(--telkom-white);
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .forum-controls {
                flex-direction: column;
                align-items: stretch;
            }
            
            .search-box {
                width: 100%;
            }
            
            .search-box input {
                width: 100%;
            }

            .thread-meta {
                flex-direction: column;
                gap: 8px;
            }

            .thread-stats {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
        }
    </style>

    <!-- Forum Header Section -->
    <div class="forum-section">
        <h3>Community Forum</h3>
        <p>Connect with other Telkom customers, get help from our technical team, and share solutions.</p>
    </div>

    <!-- Forum Controls -->
    <div class="forum-controls">
        <div class="search-box">
            <i class="fas fa-search"></i>
            <asp:TextBox ID="txtSearch" runat="server" placeholder="Search discussions..." CssClass="search-input" />
        </div>
        <asp:Button ID="btnNewPost" runat="server" Text="Start New Discussion" CssClass="btn btn-primary" OnClientClick="openNewPostModal(); return false;" />
    </div>

    <!-- Forum Content -->
    <div class="forum-content">
        <!-- Main Thread List -->
        <div class="thread-list">
            <asp:Repeater ID="rptForumPosts" runat="server">
                <ItemTemplate>
                    <div class="thread-item" data-post-id='<%# Eval("PostId") %>'>
                        <div class="thread-title" onclick="toggleThreadDetails(<%# Eval("PostId") %>)">
                            <%# Eval("Title") %>
                        </div>
                        <div class="thread-meta">
                            <span class="thread-author"><i class="fas fa-user"></i> <%# Eval("AuthorName") %></span>
                            <span class="thread-date"><i class="fas fa-clock"></i> <%# Eval("TimeAgo") %></span>
                            <span class="priority-badge priority-<%# Eval("Priority").ToString().ToLower() %>">
                                <%# Eval("Priority") %> Priority
                            </span>
                        </div>
                        <p class="thread-excerpt"><%# TruncateText(Eval("Description").ToString(), 150) %></p>
                        <div class="thread-stats">
                            <div>
                                <span class="thread-stat">
                                    <i class="fas fa-tag"></i> <%# Eval("PostType") ?? "Support" %>
                                </span>
                            </div>
                            <span class="status-badge status-<%# GetStatusClass(Container.DataItem) %>">
                                <%# GetStatusText(Container.DataItem) %>
                            </span>
                        </div>
                        
                        <!-- Thread Details (Hidden by default) -->
                        <div id="details_<%# Eval("PostId") %>" class="thread-details">
                            <div style="margin-bottom: 15px;">
                                <strong>Full Description:</strong><br />
                                <%# Eval("Description") %>
                            </div>
                            
                            <%# !string.IsNullOrEmpty(Eval("Tags")?.ToString()) ? "<div style=\"margin-bottom: 15px;\"><strong>Tags:</strong> " + Eval("Tags") + "</div>" : "" %>
                            
                            <div class="response-section">
                                <div class="response-header">
                                    <i class="fas fa-headset"></i>
                                    Technical Support Response
                                    <%# !string.IsNullOrEmpty(Eval("TechnicianName")?.ToString()) ? " - " + Eval("TechnicianName") : "" %>
                                </div>
                                <div class="response-content <%# string.IsNullOrEmpty(Eval("Solution")?.ToString()) ? "no-response" : "" %>">
                                    <%# !string.IsNullOrEmpty(Eval("Solution")?.ToString()) ? Eval("Solution").ToString() : "Our technical team is reviewing your post. You will receive a response soon." %>
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            
            <!-- No Posts Message -->
            <div id="noPostsMessage" style="display: none; text-align: center; padding: 40px; color: #999;">
                <i class="fas fa-inbox" style="font-size: 3em; margin-bottom: 20px; opacity: 0.5;"></i>
                <p style="font-size: 1.2em;">No posts match your search criteria.</p>
            </div>
            
            <!-- Pagination would go here -->
            <div class="forum-pagination">
                <a href="#" class="page-link"><i class="fas fa-chevron-left"></i></a>
                <a href="#" class="page-link active">1</a>
                <a href="#" class="page-link">2</a>
                <a href="#" class="page-link">3</a>
                <a href="#" class="page-link"><i class="fas fa-chevron-right"></i></a>
            </div>
        </div>

        <!-- Forum Sidebar -->
        <div class="forum-sidebar">
            <div class="sidebar-section">
                <h4 class="sidebar-title">Post Categories</h4>
                <ul class="category-list">
                    <li class="category-item">
                        <a href="#" class="category-link" onclick="filterByCategory('connectivity')">
                            <span>Internet Connectivity</span>
                            <span class="category-count"><%# GetCategoryCount("connectivity") %></span>
                        </a>
                    </li>
                    <li class="category-item">
                        <a href="#" class="category-link" onclick="filterByCategory('billing')">
                            <span>Billing Questions</span>
                            <span class="category-count"><%# GetCategoryCount("billing") %></span>
                        </a>
                    </li>
                    <li class="category-item">
                        <a href="#" class="category-link" onclick="filterByCategory('hardware')">
                            <span>Hardware Issues</span>
                            <span class="category-count"><%# GetCategoryCount("hardware") %></span>
                        </a>
                    </li>
                    <li class="category-item">
                        <a href="#" class="category-link" onclick="filterByCategory('general')">
                            <span>General Support</span>
                            <span class="category-count"><%# GetCategoryCount("general") %></span>
                        </a>
                    </li>
                </ul>
            </div>
            
            <div class="sidebar-section">
                <h4 class="sidebar-title">Quick Tips</h4>
                <ul class="popular-threads">
                    <li class="popular-thread">
                        <a href="#" class="popular-thread-link">
                            <span>How to restart your router</span>
                            <i class="fas fa-lightbulb"></i>
                        </a>
                    </li>
                    <li class="popular-thread">
                        <a href="#" class="popular-thread-link">
                            <span>Understanding your bill</span>
                            <i class="fas fa-lightbulb"></i>
                        </a>
                    </li>
                    <li class="popular-thread">
                        <a href="#" class="popular-thread-link">
                            <span>WiFi troubleshooting guide</span>
                            <i class="fas fa-lightbulb"></i>
                        </a>
                    </li>
                </ul>
            </div>
            
            <div class="sidebar-section">
                <h4 class="sidebar-title">Forum Guidelines</h4>
                <ol style="padding-left: 20px; font-size: 0.9rem; color: var(--telkom-dark-gray);">
                    <li>Be respectful and courteous</li>
                    <li>Provide clear problem descriptions</li>
                    <li>Search before posting duplicates</li>
                    <li>No personal information sharing</li>
                    <li>Stay on topic</li>
                </ol>
            </div>
        </div>
    </div>

    <!-- New Post Modal -->
    <div id="newPostModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Start New Discussion</h3>
                <span class="close" onclick="closeNewPostModal()">&times;</span>
            </div>
            <div class="form-group">
                <label for="txtTitle">Post Title</label>
                <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" placeholder="Briefly describe your issue or question..." />
                <asp:RequiredFieldValidator ID="rfvTitle" runat="server" ControlToValidate="txtTitle" ErrorMessage="Title is required" CssClass="text-danger" ValidationGroup="NewPost" />
            </div>
            <div class="form-group">
                <label for="txtDescription">Detailed Description</label>
                <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" CssClass="form-control textarea" placeholder="Provide as much detail as possible about your issue..." />
                <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription" ErrorMessage="Description is required" CssClass="text-danger" ValidationGroup="NewPost" />
            </div>
            <div class="form-group">
                <label for="ddlPriority">Priority Level</label>
                <asp:DropDownList ID="ddlPriority" runat="server" CssClass="form-control">
                    <asp:ListItem Value="Low" Text="Low - General question or minor issue" />
                    <asp:ListItem Value="Medium" Text="Medium - Service affecting issue" Selected="True" />
                    <asp:ListItem Value="High" Text="High - Critical issue affecting work/business" />
                </asp:DropDownList>
            </div>
            <div class="form-group">
                <label for="txtTags">Tags (optional)</label>
                <asp:TextBox ID="txtTags" runat="server" CssClass="form-control" placeholder="e.g. wifi, billing, router, slow-speed" />
            </div>
            <div style="text-align: right;">
                <button type="button" class="btn btn-secondary" onclick="closeNewPostModal()" style="margin-right: 10px;">Cancel</button>
                <asp:Button ID="btnSubmitPost" runat="server" Text="Submit Post" CssClass="btn btn-primary" OnClick="BtnSubmitPost_Click" ValidationGroup="NewPost" />
            </div>
        </div>
    </div>

    <script>
        // Search functionality
        document.addEventListener('DOMContentLoaded', function () {
            const searchInput = document.querySelector('#<%= txtSearch.ClientID %>');
            if (searchInput) {
                searchInput.addEventListener('input', function () {
                    filterPosts();
                });
            }
        });

        function filterPosts() {
            const searchTerm = document.querySelector('#<%= txtSearch.ClientID %>').value.toLowerCase();
            const posts = document.querySelectorAll('.thread-item');
            let visibleCount = 0;

            posts.forEach(post => {
                const title = post.querySelector('.thread-title').textContent.toLowerCase();
                const excerpt = post.querySelector('.thread-excerpt').textContent.toLowerCase();
                const author = post.querySelector('.thread-author').textContent.toLowerCase();

                if (title.includes(searchTerm) || excerpt.includes(searchTerm) || author.includes(searchTerm)) {
                    post.style.display = 'block';
                    visibleCount++;
                } else {
                    post.style.display = 'none';
                }
            });

            const noPostsMessage = document.getElementById('noPostsMessage');
            if (noPostsMessage) {
                noPostsMessage.style.display = visibleCount === 0 ? 'block' : 'none';
            }
        }

        function toggleThreadDetails(postId) {
            const details = document.getElementById('details_' + postId);
            if (details) {
                if (details.classList.contains('show')) {
                    details.classList.remove('show');
                    setTimeout(() => {
                        details.style.display = 'none';
                    }, 300);
                } else {
                    details.style.display = 'block';
                    setTimeout(() => {
                        details.classList.add('show');
                    }, 10);
                }
            }
        }

        function openNewPostModal() {
            document.getElementById('newPostModal').style.display = 'block';
            document.body.style.overflow = 'hidden';
        }

        function closeNewPostModal() {
            document.getElementById('newPostModal').style.display = 'none';
            document.body.style.overflow = 'auto';
        }

        function filterByCategory(category) {
            // This would filter posts by category
            // Implementation depends on how categories are stored
            console.log('Filtering by category:', category);
        }

        // Close modal when clicking outside
        window.addEventListener('click', function (event) {
            const modal = document.getElementById('newPostModal');
            if (event.target === modal) {
                closeNewPostModal();
            }
        });

        // Auto-refresh posts every 60 seconds to show status updates
        setInterval(function () {
            // In a real application, this would make an AJAX call to refresh post statuses
            console.log('Checking for post updates...');
        }, 60000);
    </script>
</asp:Content>