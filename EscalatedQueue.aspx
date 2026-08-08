<%@ Page Title="Escalated Cases" Language="C#" MasterPageFile="~/TechMaster.Master" AutoEventWireup="true" CodeBehind="EscalatedQueue.aspx.cs" Inherits="Telkom.EscalatedQueue" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="server">
    <style>
        .escalation-filters {
            background: white;
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .filter-row {
            display: flex;
            gap: 15px;
            align-items: center;
            flex-wrap: wrap;
            margin-bottom: 10px;
        }
        
        .filter-group {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }
        
        .filter-group label {
            font-weight: bold;
            color: #374151;
            font-size: 12px;
        }
        
        .escalation-grid {
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        
        .case-row {
            border-bottom: 1px solid #e5e7eb;
        }
        
        .case-row:hover {
            background-color: #f9fafb;
        }
        
        .priority-badge {
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: bold;
            text-align: center;
        }
        
        .priority-critical {
            background-color: #fee2e2;
            color: #dc2626;
        }
        
        .priority-high {
            background-color: #fef3c7;
            color: #d97706;
        }
        
        .priority-medium {
            background-color: #dbeafe;
            color: #2563eb;
        }
        
        .status-badge {
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: bold;
        }
        
        .status-escalated {
            background-color: #fecaca;
            color: #991b1b;
        }
        
        .status-investigating {
            background-color: #fed7aa;
            color: #ea580c;
        }
        
        .status-pending {
            background-color: #fef3c7;
            color: #a16207;
        }
        
        .action-buttons {
            display: flex;
            gap: 5px;
        }
        
        .btn-small {
            padding: 4px 8px;
            font-size: 12px;
            border-radius: 4px;
        }
        
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            display: none;
        }
        
        .modal-content {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            border-radius: 8px;
            padding: 20px;
            width: 90%;
            max-width: 600px;
            max-height: 80vh;
            overflow-y: auto;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }
        
        .alert {
            margin-bottom: 15px;
            padding: 12px 20px;
            border: 1px solid;
            border-radius: 4px;
            font-weight: bold;
        }
        
        .alert-success {
            background-color: #d4edda;
            border-color: #c3e6cb;
            color: #155724;
        }
        
        .alert-danger {
            background-color: #f8d7da;
            border-color: #f5c6cb;
            color: #721c24;
        }
        
        .alert .close {
            float: right;
            background: none;
            border: none;
            font-size: 18px;
            cursor: pointer;
            padding: 0;
            margin-left: 15px;
            color: inherit;
            opacity: 0.7;
        }
        
        .alert .close:hover {
            opacity: 1;
        }
        
        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            border-bottom: 1px solid #e5e7eb;
            padding-bottom: 10px;
        }
        
        .close-btn {
            background: none;
            border: none;
            font-size: 24px;
            cursor: pointer;
            color: #6b7280;
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #374151;
        }
        
        .form-control {
            width: 100%;
            padding: 8px;
            border: 1px solid #d1d5db;
            border-radius: 4px;
            font-size: 14px;
        }
        
        textarea.form-control {
            height: 100px;
            resize: vertical;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="dashboard-card">
        <div class="card-header">
            <h3 style="margin: 0; color: #1e293b;">Escalated Cases Management</h3>
            <p style="margin: 5px 0 0 0; color: #64748b;">Manage high-priority technical cases requiring immediate attention</p>
        </div>
    </div>

    <!-- Filters Section -->
    <div class="escalation-filters">
        <div class="filter-row">
            <div class="filter-group">
                <label>Priority Level:</label>
                <asp:DropDownList ID="ddlPriority" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ApplyFilters">
                    <asp:ListItem Value="" Text="All Priorities"></asp:ListItem>
                    <asp:ListItem Value="Critical" Text="Critical"></asp:ListItem>
                    <asp:ListItem Value="High" Text="High"></asp:ListItem>
                    <asp:ListItem Value="Medium" Text="Medium"></asp:ListItem>
                </asp:DropDownList>
            </div>
            
            <div class="filter-group">
                <label>Status:</label>
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ApplyFilters">
                    <asp:ListItem Value="" Text="All Statuses"></asp:ListItem>
                    <asp:ListItem Value="Escalated" Text="Newly Escalated"></asp:ListItem>
                    <asp:ListItem Value="Investigating" Text="Under Investigation"></asp:ListItem>
                    <asp:ListItem Value="Pending" Text="Pending Customer"></asp:ListItem>
                </asp:DropDownList>
            </div>
            
            <div class="filter-group">
                <label>Assigned Technician:</label>
                <asp:DropDownList ID="ddlTechnician" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ApplyFilters">
                    <asp:ListItem Value="" Text="All Technicians"></asp:ListItem>
                </asp:DropDownList>
            </div>
            
            <div class="filter-group">
                <label>Search Case:</label>
                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Case ID or Customer Name"></asp:TextBox>
            </div>
            
            <div class="filter-group">
                <label>&nbsp;</label>
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary btn-small" OnClick="btnSearch_Click" />
                <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-secondary btn-small" OnClick="btnClear_Click" />
            </div>
        </div>
    </div>

    <!-- Stats Cards -->
    <div style="display: flex; gap: 15px; margin-bottom: 20px;">
        <div class="dashboard-card" style="flex: 1;">
            <div class="card-header">Critical Cases</div>
            <asp:Label ID="lblCriticalCount" runat="server" Text="0" CssClass="alert-high" style="font-size: 24px;"></asp:Label>
        </div>
        <div class="dashboard-card" style="flex: 1;">
            <div class="card-header">High Priority</div>
            <asp:Label ID="lblHighCount" runat="server" Text="0" CssClass="alert-medium" style="font-size: 24px;"></asp:Label>
        </div>
        <div class="dashboard-card" style="flex: 1;">
            <div class="card-header">Total Escalated</div>
            <asp:Label ID="lblTotalCount" runat="server" Text="0" style="font-size: 24px; color: #0052cc;"></asp:Label>
        </div>
        <div class="dashboard-card" style="flex: 1;">
            <div class="card-header">Avg Resolution Time</div>
            <asp:Label ID="lblAvgTime" runat="server" Text="0h" style="font-size: 24px; color: #00a651;"></asp:Label>
        </div>
    </div>

    <!-- Cases Grid -->
    <div class="escalation-grid">
        <asp:UpdatePanel ID="upCases" runat="server">
            <ContentTemplate>
                <asp:GridView ID="gvEscalatedCases" runat="server" 
                    AutoGenerateColumns="false" 
                    CssClass="table"
                    HeaderStyle-BackColor="#f1f5f9"
                    RowStyle-CssClass="case-row"
                    OnRowCommand="gvEscalatedCases_RowCommand"
                    OnRowDataBound="gvEscalatedCases_RowDataBound"
                    DataKeyNames="CaseId">
                    
                    <Columns>
                        <asp:BoundField DataField="CaseId" HeaderText="Case ID" />
                        
                        <asp:TemplateField HeaderText="Priority">
                            <ItemTemplate>
                                <span class='priority-badge priority-<%# Eval("Priority").ToString().ToLower() %>'>
                                    <%# Eval("Priority") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:BoundField DataField="CustomerName" HeaderText="Customer" />
                        <asp:BoundField DataField="IssueType" HeaderText="Issue Type" />
                        <asp:BoundField DataField="Description" HeaderText="Description" />
                        
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <span class='status-badge status-<%# Eval("Status").ToString().ToLower().Replace(" ", "") %>'>
                                    <%# Eval("Status") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:BoundField DataField="AssignedTechnician" HeaderText="Assigned To" />
                        <asp:BoundField DataField="EscalatedDate" HeaderText="Escalated" DataFormatString="{0:MM/dd/yyyy HH:mm}" />
                        <asp:BoundField DataField="SLADeadline" HeaderText="SLA Deadline" DataFormatString="{0:MM/dd/yyyy HH:mm}" />
                        
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <div class="action-buttons">
                                    <asp:Button ID="btnView" runat="server" 
                                        Text="View" 
                                        CssClass="btn btn-primary btn-small" 
                                        CommandName="ViewCase" 
                                        CommandArgument='<%# Eval("CaseId") %>' />
                                    
                                    <asp:Button ID="btnAssign" runat="server" 
                                        Text="Assign" 
                                        CssClass="btn btn-secondary btn-small" 
                                        CommandName="AssignCase" 
                                        CommandArgument='<%# Eval("CaseId") %>' />
                                    
                                    <asp:Button ID="btnUpdate" runat="server" 
                                        Text="Update" 
                                        CssClass="btn btn-primary btn-small" 
                                        CommandName="UpdateCase" 
                                        CommandArgument='<%# Eval("CaseId") %>' />
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    
                    <EmptyDataTemplate>
                        <div style="text-align: center; padding: 20px; color: #6b7280;">
                            No escalated cases found matching your criteria.
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="ddlPriority" EventName="SelectedIndexChanged" />
                <asp:AsyncPostBackTrigger ControlID="ddlStatus" EventName="SelectedIndexChanged" />
                <asp:AsyncPostBackTrigger ControlID="ddlTechnician" EventName="SelectedIndexChanged" />
                <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnClear" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
    </div>

    <!-- Case Details Modal -->
    <div id="caseModal" class="modal-overlay">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Case Details</h3>
                <button type="button" class="close-btn" onclick="closeModal()">&times;</button>
            </div>
            <div id="modalBody">
                <asp:UpdatePanel ID="upModal" runat="server">
                    <ContentTemplate>
                        <div class="form-group">
                            <label>Case ID:</label>
                            <asp:Label ID="lblModalCaseId" runat="server" CssClass="form-control" style="background-color: #f9fafb;"></asp:Label>
                        </div>
                        
                        <div class="form-group">
                            <label>Customer:</label>
                            <asp:Label ID="lblModalCustomer" runat="server" CssClass="form-control" style="background-color: #f9fafb;"></asp:Label>
                        </div>
                        
                        <div class="form-group">
                            <label>Priority:</label>
                            <asp:DropDownList ID="ddlModalPriority" runat="server" CssClass="form-control">
                                <asp:ListItem Value="Critical" Text="Critical"></asp:ListItem>
                                <asp:ListItem Value="High" Text="High"></asp:ListItem>
                                <asp:ListItem Value="Medium" Text="Medium"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        
                        <div class="form-group">
                            <label>Status:</label>
                            <asp:DropDownList ID="ddlModalStatus" runat="server" CssClass="form-control">
                                <asp:ListItem Value="Escalated" Text="Newly Escalated"></asp:ListItem>
                                <asp:ListItem Value="Investigating" Text="Under Investigation"></asp:ListItem>
                                <asp:ListItem Value="Pending" Text="Pending Customer"></asp:ListItem>
                                <asp:ListItem Value="Resolved" Text="Resolved"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        
                        <div class="form-group">
                            <label>Assigned Technician:</label>
                            <asp:DropDownList ID="ddlModalTechnician" runat="server" CssClass="form-control">
                            </asp:DropDownList>
                        </div>
                        
                        <div class="form-group">
                            <label>Issue Description:</label>
                            <asp:TextBox ID="txtModalDescription" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                        </div>
                        
                        <div class="form-group">
                            <label>Resolution Notes:</label>
                            <asp:TextBox ID="txtModalNotes" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                        </div>
                        
                        <div class="form-group">
                            <asp:Button ID="btnSaveCase" runat="server" Text="Save Changes" CssClass="btn btn-primary" OnClick="btnSaveCase_Click" />
                            <asp:Button ID="btnCloseModal" runat="server" Text="Close" CssClass="btn btn-secondary" OnClientClick="closeModal(); return false;" />
                        </div>
                        
                        <asp:HiddenField ID="hfModalCaseId" runat="server" />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>

    <script>
        function showModal() {
            document.getElementById('caseModal').style.display = 'block';
        }
        
        function closeModal() {
            document.getElementById('caseModal').style.display = 'none';
        }
        
        // Close modal when clicking outside
        window.onclick = function(event) {
            var modal = document.getElementById('caseModal');
            if (event.target == modal) {
                closeModal();
            }
        }
    </script>
</asp:Content>