<%@ Page Title="Technician Dashboard" Language="C#" MasterPageFile="~/TechMaster.Master" AutoEventWireup="true" CodeBehind="TechnicianDashboard.aspx.cs" Inherits="Telkom.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="server">
    <style>
        .badge { 
            padding: 5px 10px; 
            border-radius: 5px; 
            color: white; 
            font-weight: bold; 
            display: inline-block;
            font-size: 12px;
        }
        .badge-danger { background-color: #dc3545; }
        .badge-warning { background-color: #ffc107; color: #212529; }
        .badge-success { background-color: #28a745; }
        .badge-secondary { background-color: #6c757d; }
        
        .post-item {
            padding: 10px 0;
            border-bottom: 1px solid #eee;
        }
        
        .post-item:last-child {
            border-bottom: none;
        }
        
        .btn-resolve {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 5px 15px;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 5px;
        }
        
        .btn-resolve:hover {
            background-color: #0056b3;
        }
        
        .resolved-status {
            color: #28a745;
            font-weight: bold;
        }
        
        .analytics { 
            display: flex; 
            gap: 20px; 
            margin-top: 20px; 
            flex-wrap: wrap;
        }
        
        .analytics .dashboard-card { 
            flex: 1; 
            text-align: center; 
            min-width: 120px;
        }
        
        .analytics h4 {
            margin-bottom: 10px;
            color: #1e293b;
        }
        
        .analytics h2 {
            margin: 0;
            color: #0052cc;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Technician Dashboard</h2>
    
    <!-- Escalated Cases -->
    <div class="dashboard-card">
        <div class="card-header">Escalated Cases (High Priority)</div>
        <asp:Repeater ID="rptEscalatedCases" runat="server">
            <ItemTemplate>
                <div class="post-item">
                    <strong><%# Eval("Title") %></strong> 
                    <span class='<%# GetPriorityClass(Eval("Priority") == null ? "" : Eval("Priority").ToString()) %>'>
                        <%# Eval("Priority") %>
                    </span>
                    <br />
                    <small>Posted by <%# Eval("AuthorName") %> - <%# Eval("TimeAgo") %></small>
                    <br />
                    <span><%# Eval("Description") %></span>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
    
    <!-- Forum Posts -->
    <div class="dashboard-card">
        <div class="card-header">Community Forum</div>
        <asp:Repeater ID="rptForumPosts" runat="server">
            <ItemTemplate>
                <div class="post-item">
                    <strong><%# Eval("Title") %></strong> 
                    <span class='<%# GetPriorityClass(Eval("Priority") == null ? "" : Eval("Priority").ToString()) %>'>
                        <%# Eval("Priority") %>
                    </span>
                    <br />
                    <small>Posted by <%# Eval("AuthorName") %> - <%# Eval("TimeAgo") %></small>
                    <br />
                    <%# Eval("Description") %>
                    <br />
                    <asp:Button ID="BtnResolvePost" runat="server" Text="Resolve" CssClass="btn btn-primary" 
                        CommandArgument='<%# Eval("PostId") %>' OnClick="BtnResolvePost_Click" 
                        Visible='<%# Eval("Status").ToString() != "Resolved" %>' />
                    <asp:Label ID="lblResolved" runat="server" Text="✓ Resolved" CssClass="resolved-status"
                        Visible='<%# Eval("Status").ToString() == "Resolved" %>' />
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
    
    <!-- Predictive Alerts -->
    <div class="dashboard-card">
        <div class="card-header">Predictive Alerts</div>
        <asp:Repeater ID="rptPredictiveAlerts" runat="server">
            <ItemTemplate>
                <div class="post-item">
                    <strong><%# Eval("CustomerName") %></strong> 
                    <span class='<%# GetRiskBadgeClass(Eval("RiskLevel") == null ? "" : Eval("RiskLevel").ToString()) %>'>
                        <%# Eval("RiskLevel") %> Risk
                    </span>
                    <br />
                    <small>Customer ID: <%# Eval("CustomerId") %></small>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
    
    <!-- Analytics -->
    <div class="analytics">
        <div class="dashboard-card">
            <h4>Total Forum Posts</h4>
            <h2><asp:Label ID="lblTotalPosts" runat="server"></asp:Label></h2>
        </div>
        <div class="dashboard-card">
            <h4>Open Issues</h4>
            <h2><asp:Label ID="lblOpenIssues" runat="server"></asp:Label></h2>
        </div>
        <div class="dashboard-card">
            <h4>Resolved Today</h4>
            <h2><asp:Label ID="lblAnalyticsResolvedToday" runat="server"></asp:Label></h2>
        </div>
        <div class="dashboard-card">
            <h4>Avg Queue Time</h4>
            <h2><asp:Label ID="lblAvgQueueTime" runat="server"></asp:Label></h2>
        </div>
        <div class="dashboard-card">
            <h4>Customer Satisfaction</h4>
            <h2><asp:Label ID="lblCSAT" runat="server"></asp:Label></h2>
        </div>
    </div>
</asp:Content>