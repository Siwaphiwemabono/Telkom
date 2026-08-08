<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/CustomerDashboard/Customer.Master" CodeBehind="TechnicianReceipt.aspx.cs" Inherits="Telkom.CustomerDashboard.TechnicianReceipt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .receipt-container {
            max-width: 800px;
            margin: 20px auto;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .receipt-header {
            background: linear-gradient(135deg, #004080 0%, #66CC00 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }

        .receipt-content {
            padding: 40px;
            font-family: 'Courier New', monospace;
            background: #f8f9fa;
            white-space: pre-line;
            line-height: 1.6;
            font-size: 14px;
        }

        .print-button {
            text-align: center;
            padding: 20px;
            background: white;
        }

        .btn-print {
            background: #004080;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            margin-right: 10px;
        }

        .btn-print:hover {
            background: #003366;
        }

        @media print {
            .print-button { display: none; }
            .receipt-container { box-shadow: none; }
        }
    </style>

    <div class="receipt-container">
        <div class="receipt-header">
            <h2>Technician Service Receipt</h2>
            <p>Thank you for choosing TelkomX Priority Service</p>
        </div>
        
        <div class="receipt-content">
            <asp:Label ID="lblReceipt" runat="server"></asp:Label>
        </div>
        
        <div class="print-button">
            <button type="button" class="btn-print" onclick="window.print()">Print Receipt</button>
            <button type="button" class="btn-print" onclick="window.close()">Close</button>
        </div>
    </div>
</asp:Content>