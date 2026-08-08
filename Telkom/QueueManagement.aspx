<%@ Page Title="Queue Management" Language="C#" MasterPageFile="~/Agent.Master" AutoEventWireup="true" CodeBehind="QueueManagement.aspx.cs" Inherits="Telkom.QueueManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        :root {
            --telkom-blue: #0077CC;
            --telkom-dark-blue: #0055A5;
            --telkom-green: #66CC00;
            --telkom-magenta: #E20074;
            --telkom-orange: #FF6600;
            --telkom-dark-gray: #6C757D;
            --telkom-text: #333333;
            --telkom-white: #FFFFFF;
            
            --glass-bg: rgba(255, 255, 255, 0.15);
            --glass-border: 1px solid rgba(255, 255, 255, 0.2);
            --glass-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            --gradient-bg: linear-gradient(135deg, var(--telkom-blue) 0%, var(--telkom-magenta) 100%);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            color: var(--telkom-text);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
        }

        /* Queue Management specific styles with glassmorphism */
        .page-header {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            color: var(--telkom-text);
            padding: 2rem;
            margin-bottom: 2rem;
            border-radius: 12px;
            box-shadow: var(--glass-shadow);
            border: var(--glass-border);
        }

        .page-title {
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            background: var(--gradient-bg);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .page-subtitle {
            color: var(--telkom-dark-gray);
            font-size: 1.1rem;
            opacity: 0.9;
        }

        .stats-bar {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            padding: 2rem;
            margin: 0 0 2rem 0;
            border-radius: 12px;
            box-shadow: var(--glass-shadow);
            border: var(--glass-border);
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 1.5rem;
        }

        .stat-item {
            text-align: center;
            padding: 1.5rem;
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(5px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: all 0.3s ease;
        }

        .stat-item:hover {
            background: rgba(255, 255, 255, 0.15);
            transform: translateY(-3px);
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--telkom-green);
            margin-bottom: 0.5rem;
            text-shadow: 0 2px 4px rgba(102, 204, 0, 0.2);
        }

        .stat-label {
            color: var(--telkom-dark-gray);
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 500;
        }

        .queue-controls {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            margin: 0 0 2rem 0;
            padding: 1.5rem;
            border-radius: 12px;
            box-shadow: var(--glass-shadow);
            border: var(--glass-border);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .filter-controls {
            display: flex;
            gap: 1.5rem;
            flex-wrap: wrap;
        }

        .filter-group {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .filter-label {
            font-size: 0.85rem;
            font-weight: 600;
            color: var(--telkom-dark-blue);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .filter-select {
            padding: 0.8rem 1rem;
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 8px;
            font-size: 0.9rem;
            background: rgba(255, 255, 255, 0.1);
            color: var(--telkom-text);
            min-width: 140px;
            backdrop-filter: blur(5px);
            transition: all 0.3s ease;
        }

        .filter-select:focus {
            outline: none;
            border-color: var(--telkom-blue);
            box-shadow: 0 0 0 3px rgba(0, 119, 204, 0.2);
        }

        .action-controls {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .live-indicator {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--telkom-green);
            font-weight: 600;
            font-size: 0.9rem;
            padding: 0.6rem 1rem;
            background: rgba(102, 204, 0, 0.1);
            border-radius: 20px;
            border: 1px solid rgba(102, 204, 0, 0.2);
        }

        .live-dot {
            width: 8px;
            height: 8px;
            background: var(--telkom-green);
            border-radius: 50%;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { opacity: 1; }
            50% { opacity: 0.5; }
            100% { opacity: 1; }
        }

        /* Button Styles - Enhanced Design */
        .btn {
            padding: 0.85rem 1.75rem;
            border: none;
            border-radius: 8px;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
        }

        .btn:after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.1);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .btn:hover:after {
            opacity: 1;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }

        .btn:active {
            transform: translateY(0);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--telkom-blue) 0%, #0055a5 100%);
            color: white;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #0055a5 0%, #004080 100%);
        }

        .btn-outline {
            background: transparent;
            color: var(--telkom-blue);
            border: 2px solid var(--telkom-blue);
        }

        .btn-outline:hover {
            background: var(--telkom-blue);
            color: white;
        }

        .btn-success {
            background: linear-gradient(135deg, var(--telkom-green) 0%, #4D9900 100%);
            color: white;
        }

        .btn-success:hover {
            background: linear-gradient(135deg, #4D9900 0%, #3d7a00 100%);
        }

        .btn-orange {
            background: linear-gradient(135deg, #ff8c00 0%, #e67e00 100%);
            color: white;
        }

        .btn-orange:hover {
            background: linear-gradient(135deg, #e67e00 0%, #cc6d00 100%);
        }

        .btn-warning {
            background: linear-gradient(135deg, #ff9500 0%, #f57c00 100%);
            color: white;
        }

        .btn-warning:hover {
            background: linear-gradient(135deg, #f57c00 0%, #ef6c00 100%);
        }

        .btn-danger {
            background: linear-gradient(135deg, #ff3b30 0%, #d32f2f 100%);
            color: white;
        }

        .btn-danger:hover {
            background: linear-gradient(135deg, #d32f2f 0%, #c62828 100%);
        }

        .btn-secondary {
            background: rgba(108, 117, 125, 0.2);
            color: var(--telkom-dark-gray);
            border: 1px solid rgba(108, 117, 125, 0.3);
        }

        .btn-secondary:hover {
            background: rgba(108, 117, 125, 0.3);
            color: var(--telkom-text);
        }

        .btn-sm {
            padding: 0.6rem 1.2rem;
            font-size: 0.8rem;
        }

        .btn-lg {
            padding: 1rem 2rem;
            font-size: 1rem;
        }

        .btn-icon {
            font-size: 1.1rem;
        }

        .queue-grid {
            margin: 0;
        }

        .queue-item {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            margin-bottom: 1.5rem;
            border-radius: 12px;
            box-shadow: var(--glass-shadow);
            border: var(--glass-border);
            overflow: hidden;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            border-left: 4px solid var(--telkom-blue);
        }

        .queue-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
            background: rgba(255, 255, 255, 0.15);
        }

        .queue-item.high-priority {
            border-left-color: var(--telkom-magenta);
        }

        .queue-item.assigned {
            border-left-color: var(--telkom-green);
        }

        .queue-item.resolved {
            border-left-color: var(--telkom-dark-gray);
            opacity: 0.7;
        }

        .queue-item.in-call {
            border-left-color: var(--telkom-orange);
            box-shadow: 0 4px 20px rgba(255, 102, 0, 0.3);
        }

        .item-header {
            padding: 1.5rem;
            background: rgba(255, 255, 255, 0.1);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
        }

        .customer-info h3 {
            font-size: 1.3rem;
            color: var(--telkom-dark-blue);
            margin-bottom: 0.5rem;
        }

        .customer-details {
            color: var(--telkom-dark-gray);
            font-size: 0.9rem;
            margin-bottom: 0.8rem;
        }

        .priority-badge {
            display: inline-block;
            padding: 0.4rem 0.9rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            backdrop-filter: blur(5px);
        }

        .priority-high {
            background: rgba(226, 0, 116, 0.15);
            color: var(--telkom-magenta);
            border: 1px solid rgba(226, 0, 116, 0.3);
        }

        .priority-normal {
            background: rgba(0, 102, 204, 0.15);
            color: var(--telkom-blue);
            border: 1px solid rgba(0, 102, 204, 0.3);
        }

        .queue-metadata {
            display: flex;
            gap: 2rem;
            align-items: center;
        }

        .metadata-item {
            text-align: center;
        }

        .metadata-value {
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--telkom-blue);
        }

        .metadata-label {
            font-size: 0.8rem;
            color: var(--telkom-dark-gray);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .item-body {
            padding: 1.5rem;
        }

        .assignment-status {
            display: inline-block;
            padding: 0.6rem 1.2rem;
            background: rgba(0, 176, 79, 0.15);
            color: var(--telkom-green);
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            margin-bottom: 1rem;
            border: 1px solid rgba(0, 176, 79, 0.3);
        }

        .call-status {
            display: inline-block;
            padding: 0.6rem 1.2rem;
            background: rgba(255, 102, 0, 0.15);
            color: var(--telkom-orange);
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            margin-bottom: 1rem;
            animation: pulse 1s infinite;
            border: 1px solid rgba(255, 102, 0, 0.3);
        }

        .issue-description {
            margin-bottom: 1.5rem;
        }

        .issue-title {
            font-weight: 600;
            color: var(--telkom-dark-blue);
            margin-bottom: 0.5rem;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
        }

        .issue-text {
            color: var(--telkom-text);
            line-height: 1.5;
        }

        .diagnostics-preview {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(100px, 1fr));
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .diagnostic-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 1rem;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 8px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: all 0.3s ease;
        }

        .diagnostic-item:hover {
            background: rgba(255, 255, 255, 0.15);
            transform: translateY(-3px);
        }

        .diagnostic-label {
            font-size: 0.8rem;
            color: var(--telkom-dark-gray);
            margin-bottom: 0.5rem;
            text-transform: uppercase;
        }

        .diagnostic-value {
            font-weight: 600;
            font-size: 0.9rem;
            padding: 0.4rem 0.8rem;
            border-radius: 6px;
            backdrop-filter: blur(5px);
        }

        .diagnostic-good {
            background: rgba(0, 176, 79, 0.15);
            color: var(--telkom-green);
            border: 1px solid rgba(0, 176, 79, 0.3);
        }

        .diagnostic-warning {
            background: rgba(255, 102, 0, 0.15);
            color: var(--telkom-orange);
            border: 1px solid rgba(255, 102, 0, 0.3);
        }

        .diagnostic-error {
            background: rgba(226, 0, 116, 0.15);
            color: var(--telkom-magenta);
            border: 1px solid rgba(226, 0, 116, 0.3);
        }

        .item-actions {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,1,2,0.1);/**/
            backdrop-filter: blur(17px);
            animation: fadeIn 0.3s ease;
        }

        .modal-content {
            background: var(--glass-bg);
            backdrop-filter: blur(15px);
            margin: 5% auto;
            padding: 0;
            border-radius: 16px;
            width: 90%;
            max-width: 600px;
            box-shadow: var(--glass-shadow);
            border: var(--glass-border);
            animation: slideIn 0.3s ease;
            overflow: hidden;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideIn {
            from { transform: translateY(-50px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        .modal-header {
            padding: 1.5rem;
            background: linear-gradient(135deg, var(--telkom-blue) 0%, #0055a5 100%);
            color: var(--telkom-white);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-title {
            font-size: 1.3rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .modal-title i {
            font-size: 1.2em;
        }

        .close {
            color: var(--telkom-white);
            font-size: 2rem;
            font-weight: bold;
            cursor: pointer;
            line-height: 1;
            opacity: 0.8;
            transition: opacity 0.3s ease;
        }

        .close:hover {
            opacity: 1;
        }

        .modal-body {
            padding: 2rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: var(--telkom-dark-blue);
        }

        .form-control {
            width: 100%;
            padding: 0.9rem;
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 8px;
            font-size: 1rem;
            background: rgba(255, 255, 255, 0.1);
            color: var(--telkom-text);
            backdrop-filter: blur(5px);
            transition: all 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--telkom-blue);
            box-shadow: 0 0 0 3px rgba(0, 119, 204, 0.2);
            background: rgba(255, 255, 255, 0.15);
        }

        /* Enhanced Call Interface Styles */
        .call-interface {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .call-header {
            text-align: center;
            padding-bottom: 1.5rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .customer-name {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--telkom-dark-blue);
            margin-bottom: 0.5rem;
        }

        .call-status-container {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 1rem;
            margin-bottom: 0.5rem;
        }

        .call-status-text {
            font-size: 1rem;
            color: var(--telkom-dark-gray);
            font-weight: 500;
        }

        .call-timer {
            font-family: monospace;
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--telkom-blue);
            background: rgba(0, 102, 204, 0.1);
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
        }

        .recording-indicator {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            background: rgba(226, 0, 116, 0.2);
            color: var(--telkom-magenta);
            padding: 0.6rem 1rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            margin: 0 auto;
            max-width: max-content;
            border: 1px solid rgba(226, 0, 116, 0.3);
            display: none;
        }

        .recording-indicator.active {
            display: flex;
            animation: pulse 1s infinite;
        }

        .recording-indicator i {
            font-size: 0.7rem;
        }

        .issue-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(5px);
            border-radius: 12px;
            padding: 1.25rem;
            box-shadow: var(--glass-shadow);
            border: var(--glass-border);
        }

        .issue-card h4 {
            color: var(--telkom-dark-blue);
            margin-bottom: 0.75rem;
            font-size: 1rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .issue-card h4 i {
            font-size: 1.1em;
        }

        .issue-details {
            color: var(--telkom-text);
            line-height: 1.5;
            margin-bottom: 0.75rem;
        }

        .priority-indicator {
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .priority-high {
            background: rgba(226, 0, 116, 0.15);
            color: var(--telkom-magenta);
            border: 1px solid rgba(226, 0, 116, 0.3);
        }

        .priority-normal {
            background: rgba(0, 102, 204, 0.15);
            color: var(--telkom-blue);
            border: 1px solid rgba(0, 102, 204, 0.3);
        }

        .call-controls-section {
            display: flex;
            flex-direction: column;
            gap: 1.25rem;
        }

        .call-buttons {
            display: flex;
            justify-content: center;
            gap: 1.5rem;
        }

        .call-btn {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            border: none;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            transition: all 0.2s ease;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
            backdrop-filter: blur(5px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            position: relative;
        }

        .call-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        }

        .call-btn:active {
            transform: translateY(0);
        }

        .call-btn.mute {
            background: rgba(74, 108, 247, 0.2);
            color: var(--telkom-blue);
        }

        .call-btn.mute.active {
            background: rgba(108, 117, 125, 0.3);
            color: var(--telkom-dark-gray);
        }

        .call-btn.record {
            background: rgba(102, 204, 0, 0.2);
            color: var(--telkom-green);
        }

        .call-btn.record.recording {
            background: rgba(226, 0, 116, 0.3);
            color: var(--telkom-magenta);
            animation: pulse 1s infinite;
        }

        .call-btn.end {
            background: rgba(220, 53, 69, 0.3);
            color: #dc3545;
            width: 70px;
            height: 70px;
            font-size: 1.7rem;
        }

        .call-btn-label {
            position: absolute;
            bottom: -20px;
            left: 50%;
            transform: translateX(-50%);
            font-size: 0.7rem;
            color: var(--telkom-dark-gray);
            white-space: nowrap;
        }

        .action-buttons {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
        }

        .action-buttons .btn {
            padding: 0.9rem;
            font-size: 0.9rem;
            justify-content: center;
        }

        .notes-section {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(5px);
            border-radius: 12px;
            padding: 1.25rem;
            box-shadow: var(--glass-shadow);
            border: var(--glass-border);
        }

        .notes-section h4 {
            color: var(--telkom-dark-blue);
            margin-bottom: 0.75rem;
            font-size: 1rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .notes-section h4 i {
            font-size: 1.1em;
        }

        .notes-section textarea {
            width: 100%;
            height: 80px;
            padding: 0.8rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.1);
            color: var(--telkom-text);
            resize: vertical;
            font-size: 0.9rem;
            backdrop-filter: blur(5px);
            transition: all 0.3s ease;
        }

        .notes-section textarea:focus {
            outline: none;
            border-color: var(--telkom-blue);
            background: rgba(255, 255, 255, 0.15);
            box-shadow: 0 0 0 3px rgba(0, 119, 204, 0.1);
        }

        /* Notification */
        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 1rem 1.5rem;
            border-radius: 8px;
            color: var(--telkom-white);
            font-weight: 600;
            z-index: 2000;
            max-width: 300px;
            word-wrap: break-word;
            animation: slideInRight 0.3s ease;
            backdrop-filter: blur(10px);
            box-shadow: var(--glass-shadow);
            border: var(--glass-border);
        }

        .notification.success {
            background: rgba(0, 176, 79, 0.2);
            border-color: rgba(0, 176, 79, 0.3);
        }

        .notification.info {
            background: rgba(0, 102, 204, 0.2);
            border-color: rgba(0, 102, 204, 0.3);
        }

        .notification.warning {
            background: rgba(255, 102, 0, 0.2);
            border-color: rgba(255, 102, 0, 0.3);
        }

        .notification.error {
            background: rgba(226, 0, 116, 0.2);
            border-color: rgba(226, 0, 116, 0.3);
        }

        @keyframes slideInRight {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        @keyframes slideOutRight {
            from { transform: translateX(0); opacity: 1; }
            to { transform: translateX(100%); opacity: 0; }
        }

        .customer-issue-display {
            background: rgba(255,255,255,0.1);
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1rem;
            text-align: left;
            backdrop-filter: blur(5px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .page-header {
                padding: 1.5rem;
            }
            
            .stats-bar, .queue-controls, .queue-grid {
                margin: 0 0 1rem 0;
            }
            
            .queue-controls {
                flex-direction: column;
                align-items: stretch;
            }
            
            .filter-controls {
                justify-content: center;
            }
            
            .item-header {
                flex-direction: column;
                gap: 1rem;
            }
            
            .queue-metadata {
                justify-content: center;
            }
            
            .item-actions {
                justify-content: center;
            }
            
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .item-actions {
                flex-direction: column;
            }
            
            .item-actions .btn {
                width: 100%;
            }
            
            .call-buttons {
                gap: 1rem;
            }
            
            .call-btn {
                width: 55px;
                height: 55px;
                font-size: 1.4rem;
            }
            
            .call-btn.end {
                width: 60px;
                height: 60px;
                font-size: 1.5rem;
            }
            
            .action-buttons {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 480px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .page-title {
                font-size: 1.8rem;
            }
            
            .filter-controls {
                flex-direction: column;
                gap: 1rem;
            }
            
            .filter-group {
                width: 100%;
            }
            
            .filter-select {
                width: 100%;
            }
            
            .action-controls {
                flex-direction: column;
                width: 100%;
            }
            
            .queue-metadata {
                flex-direction: column;
                gap: 1rem;
            }
            
            .diagnostics-preview {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .call-buttons {
                gap: 0.75rem;
            }
            
            .call-btn {
                width: 50px;
                height: 50px;
                font-size: 1.3rem;
            }
            
            .call-btn.end {
                width: 55px;
                height: 55px;
                font-size: 1.4rem;
            }
            
            .call-btn-label {
                font-size: 0.65rem;
                bottom: -18px;
            }
        }

        /* Animation for queue items */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .queue-item {
            animation: fadeInUp 0.5s ease-out forwards;
        }

        .queue-item:nth-child(1) { animation-delay: 0.1s; }
        .queue-item:nth-child(2) { animation-delay: 0.2s; }
        .queue-item:nth-child(3) { animation-delay: 0.3s; }
        .queue-item:nth-child(4) { animation-delay: 0.4s; }
        .queue-item:nth-child(5) { animation-delay: 0.5s; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <h1 class="page-title">Live Queue Management</h1>
            <p class="page-subtitle">Monitor and manage customer support queue in real-time</p>
        </div>

        <!-- Live Statistics Bar -->
        <div class="stats-bar">
            <div class="stats-grid">
                <div class="stat-item">
                    <div class="stat-number" id="totalInQueue">0</div>
                    <div class="stat-label">Total in Queue</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number" id="highPriority">0</div>
                    <div class="stat-label">High Priority</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number" id="avgWaitTime">0</div>
                    <div class="stat-label">Avg Wait (min)</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number" id="agentsActive">8</div>
                    <div class="stat-label">Agents Online</div>
                </div>
            </div>
        </div>

        <!-- Queue Controls -->
        <div class="queue-controls">
            <div class="filter-controls">
                <div class="filter-group">
                    <label class="filter-label">Priority</label>
                    <select id="priorityFilter" class="filter-select" onchange="applyFilters()">
                        <option value="">All Priorities</option>
                        <option value="High">High Priority</option>
                        <option value="Normal">Normal Priority</option>
                    </select>
                </div>
                
                <div class="filter-group">
                    <label class="filter-label">Status</label>
                    <select id="statusFilter" class="filter-select" onchange="applyFilters()">
                        <option value="">All Statuses</option>
                        <option value="In Queue">In Queue</option>
                        <option value="Assigned">Assigned</option>
                        <option value="In Progress">In Progress</option>
                        <option value="In Call">In Call</option>
                        <option value="Resolved">Resolved</option>
                    </select>
                </div>
                
                <div class="filter-group">
                    <label class="filter-label">Assigned To</label>
                    <select id="agentFilter" class="filter-select" onchange="applyFilters()">
                        <option value="">All Agents</option>
                        <option value="Me">Assigned to Me</option>
                        <option value="Unassigned">Unassigned</option>
                    </select>
                </div>
            </div>

            <div class="action-controls">
                <div class="live-indicator">
                    <div class="live-dot"></div>
                    Live Updates
                </div>
                <button class="btn btn-outline" onclick="refreshQueue()">
                    <i class="fas fa-sync-alt btn-icon"></i> Refresh
                </button>
                <button class="btn btn-primary" onclick="bulkAssign()">
                    <i class="fas fa-users btn-icon"></i> Bulk Assign
                </button>
            </div>
        </div>

        <!-- Queue Grid -->
        <div class="queue-grid" id="queueGrid">
            <!-- Queue items will be populated by JavaScript -->
        </div>

        <!-- Assign Modal -->
        <div id="assignModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 class="modal-title"><i class="fas fa-user-plus"></i> Assign to Technician</h2>
                    <span class="close" onclick="closeAssignModal()">&times;</span>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label>Select Technician:</label>
                        <select id="assignTechSelect" class="form-control">
                            <option value="">Choose a technician...</option>
                            <option value="Thato Mthembu">Thato Mthembu</option>
                            <option value="Sipho Ndlovu">Sipho Ndlovu</option>
                            <option value="Lerato Moloi">Lerato Moloi</option>
                            <option value="Nomsa Dlamini">Nomsa Dlamini</option>
                            <option value="Tshepo Khumalo">Tshepo Khumalo</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Assignment Notes:</label>
                        <textarea id="assignmentNotes" class="form-control" rows="3" placeholder="Optional notes for the technician..."></textarea>
                    </div>
                    <button class="btn btn-primary btn-lg" onclick="confirmAssignment()">
                        <i class="fas fa-user-check btn-icon"></i> Assign Technician
                    </button>
                </div>
            </div>
        </div>

        <!-- Enhanced Call Modal -->
        <div id="callModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 class="modal-title"><i class="fas fa-phone"></i> Customer Call</h2>
                    <span class="close" onclick="endCall()">&times;</span>
                </div>
                <div class="modal-body">
                    <div class="call-interface">
                        <div class="call-header">
                            <div class="customer-name" id="callCustomerName">Customer Name</div>
                            <div class="call-status-container">
                                <div class="call-status-text" id="callStatus">Connected</div>
                                <div class="call-timer" id="callTimer">00:00</div>
                            </div>
                            <div class="recording-indicator" id="recordingIndicator">
                                <i class="fas fa-circle"></i> Recording
                            </div>
                        </div>
                        
                        <div class="issue-card">
                            <h4><i class="fas fa-clipboard-list"></i> Issue Summary</h4>
                            <div class="issue-details" id="customerIssueDisplay">
                                <!-- Customer issue will be displayed here -->
                            </div>
                            <div class="priority-indicator priority-normal" id="callPriorityIndicator">
                                <i class="fas fa-flag"></i> Normal Priority
                            </div>
                        </div>
                        
                        <div class="call-controls-section">
                            <div class="call-buttons">
                                <button type="button" class="call-btn mute" onclick="toggleMute()" id="muteBtn">
                                    <i class="fas fa-microphone"></i>
                                    <span class="call-btn-label">Mute</span>
                                </button>
                                <button type="button" class="call-btn record" onclick="toggleRecording()" id="recordBtn">
                                    <i class="fas fa-record-vinyl"></i>
                                    <span class="call-btn-label">Record</span>
                                </button>
                                <button type="button" class="call-btn end" onclick="endCall()">
                                    <i class="fas fa-phone"></i>
                                    <span class="call-btn-label">End Call</span>
                                </button>
                            </div>
                            
                            <div class="action-buttons">
                                <button class="btn btn-success" onclick="resolveFromCall()">
                                    <i class="fas fa-check-circle btn-icon"></i> Resolve Issue
                                </button>
                                <button class="btn btn-orange" onclick="escalateFromCall()">
                                    <i class="fas fa-level-up-alt btn-icon"></i> Escalate
                                </button>
                            </div>
                        </div>
                        
                        <div class="notes-section">
                            <h4><i class="fas fa-sticky-note"></i> Call Notes</h4>
                            <textarea id="callNotes" placeholder="Enter notes about this call..."></textarea>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Customer Details Modal -->
        <div id="customerModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 class="modal-title"><i class="fas fa-user"></i> Customer Details</h2>
                    <span class="close" onclick="closeCustomerModal()">&times;</span>
                </div>
                <div class="modal-body" id="modalBody">
                    <!-- Dynamic content will be loaded here -->
                </div>
            </div>
        </div>
    </div>

    <script>
        // Global variables
        let queueData = [];
        let currentAssignmentId = null;
        let currentCallId = null;
        let callTimer = null;
        let callStartTime = null;
        let isRecording = false;
        let isMuted = false;
        let currentAgent = "Current Agent";

        // Initialize with sample data
        function initializeData() {
            queueData = [
                {
                    id: 'Q001',
                    customerName: 'Sibongile Mthembu',
                    accountNumber: 'TEL123456789',
                    location: 'Durban, KZN',
                    priority: 'High',
                    status: 'In Queue',
                    waitTime: '12 min',
                    queuePosition: 1,
                    assignedTo: null,
                    issueDescription: 'Complete internet outage since yesterday morning. Unable to work from home.',
                    connectionStatus: 'Down',
                    pingStatus: 'Failed',
                    dnsStatus: 'Error',
                    signalStatus: 'No Signal',
                    joinTime: new Date(Date.now() - 720000) // 12 minutes ago
                },
                {
                    id: 'Q002',
                    customerName: 'Ahmed Hassan',
                    accountNumber: 'TEL987654321',
                    location: 'Cape Town, WC',
                    priority: 'Normal',
                    status: 'Assigned',
                    waitTime: '8 min',
                    queuePosition: 2,
                    assignedTo: 'Thato Mthembu',
                    issueDescription: 'Slow internet speeds, particularly during peak hours. Running at 20% of contracted speed.',
                    connectionStatus: 'Good',
                    pingStatus: 'Warning',
                    dnsStatus: 'Good',
                    signalStatus: 'Warning',
                    joinTime: new Date(Date.now() - 480000) // 8 minutes ago
                },
                {
                    id: 'Q003',
                    customerName: 'Mary Johnson',
                    accountNumber: 'TEL456789123',
                    location: 'Johannesburg, GP',
                    priority: 'High',
                    status: 'In Queue',
                    waitTime: '15 min',
                    queuePosition: 3,
                    assignedTo: null,
                    issueDescription: 'Intermittent disconnections every 10-15 minutes. Affecting video conferences.',
                    connectionStatus: 'Warning',
                    pingStatus: 'Warning',
                    dnsStatus: 'Good',
                    signalStatus: 'Good',
                    joinTime: new Date(Date.now() - 900000) // 15 minutes ago
                },
                {
                    id: 'Q004',
                    customerName: 'Pieter van der Merwe',
                    accountNumber: 'TEL789123456',
                    location: 'Pretoria, GP',
                    priority: 'Normal',
                    status: 'In Queue',
                    waitTime: '5 min',
                    queuePosition: 4,
                    assignedTo: null,
                    issueDescription: 'Cannot access email servers. Other internet functions work fine.',
                    connectionStatus: 'Good',
                    pingStatus: 'Good',
                    dnsStatus: 'Warning',
                    signalStatus: 'Good',
                    joinTime: new Date(Date.now() - 300000) // 5 minutes ago
                },
                {
                    id: 'Q005',
                    customerName: 'Nomsa Dlamini',
                    accountNumber: 'TEL321654987',
                    location: 'Port Elizabeth, EC',
                    priority: 'Normal',
                    status: 'In Progress',
                    waitTime: '3 min',
                    queuePosition: 5,
                    assignedTo: 'Lerato Moloi',
                    issueDescription: 'Router keeps rebooting automatically every few hours.',
                    connectionStatus: 'Warning',
                    pingStatus: 'Good',
                    dnsStatus: 'Good',
                    signalStatus: 'Warning',
                    joinTime: new Date(Date.now() - 180000) // 3 minutes ago
                }
            ];
            renderQueue();
            updateStatistics();
            // Update wait times every minute
            setInterval(updateWaitTimes, 60000);
        }

        // Render the queue
        function renderQueue() {
            const queueGrid = document.getElementById('queueGrid');
            const filteredData = applyFiltersToData();

            queueGrid.innerHTML = filteredData.map(item => `
                <div class="queue-item ${getItemCssClass(item)}" data-queue-id="${item.id}">
                    <div class="item-header">
                        <div class="customer-info">
                            <h3 class="customer-name">${item.customerName}</h3>
                            <div class="customer-details">
                                Account: ${item.accountNumber} | Location: ${item.location}
                            </div>
                            <div class="priority-badge priority-${item.priority.toLowerCase()}">
                                ${item.priority} Priority
                            </div>
                        </div>
                        
                        <div class="queue-metadata">
                            <div class="metadata-item">
                                <div class="metadata-value">${item.waitTime}</div>
                                <div class="metadata-label">Wait Time</div>
                            </div>
                            <div class="metadata-item">
                                <div class="metadata-value">#${item.queuePosition}</div>
                                <div class="metadata-label">Position</div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="item-body">
                        ${item.assignedTo ? `<div class="assignment-status">Assigned to ${item.assignedTo}</div>` : ''}
                        ${item.status === 'In Call' ? `<div class="call-status">🔴 Currently on call</div>` : ''}
                        
                        <div class="issue-description">
                            <div class="issue-title">Reported Issue</div>
                            <div class="issue-text">${item.issueDescription}</div>
                        </div>
                        
                        <div class="diagnostics-preview">
                            <div class="diagnostic-item">
                                <div class="diagnostic-label">Connection</div>
                                <div class="diagnostic-value diagnostic-${getDiagnosticStatus(item.connectionStatus)}">
                                    ${item.connectionStatus}
                                </div>
                            </div>
                            <div class="diagnostic-item">
                                <div class="diagnostic-label">Ping</div>
                                <div class="diagnostic-value diagnostic-${getDiagnosticStatus(item.pingStatus)}">
                                    ${item.pingStatus}
                                </div>
                            </div>
                            <div class="diagnostic-item">
                                <div class="diagnostic-label">DNS</div>
                                <div class="diagnostic-value diagnostic-${getDiagnosticStatus(item.dnsStatus)}">
                                    ${item.dnsStatus}
                                </div>
                            </div>
                            <div class="diagnostic-item">
                                <div class="diagnostic-label">Signal</div>
                                <div class="diagnostic-value diagnostic-${getDiagnosticStatus(item.signalStatus)}">
                                    ${item.signalStatus}
                                </div>
                            </div>
                        </div>
                        
                        <div class="item-actions">
                            <button type="button" class="btn btn-primary" onclick="openAssignModal('${item.id}', '${item.customerName}')">
                                <i class="fas fa-user-plus btn-icon"></i> ${item.assignedTo ? 'Reassign' : 'Assign'}
                            </button>
                            <button type="button" class="btn btn-outline" onclick="viewCustomerDetails('${item.id}')">
                                <i class="fas fa-info-circle btn-icon"></i> View Details
                            </button>
                            ${item.status !== 'In Call' && item.status !== 'Resolved' ?
                    `<button type="button" class="btn btn-success" onclick="startCall('${item.id}')">
                                <i class="fas fa-phone btn-icon"></i> Create Session
                            </button>` :
                    item.status === 'In Call' ?
                        `<button type="button" class="btn btn-orange" onclick="joinCall('${item.id}')">
                                <i class="fas fa-phone-alt btn-icon"></i> Join Call
                            </button>` : ''
                }
                            ${item.status !== 'Resolved' ?
                    `<button type="button" class="btn btn-success" onclick="resolveIssue('${item.id}')">
                                <i class="fas fa-check btn-icon"></i> Resolve
                            </button>` :
                    `<button type="button" class="btn btn-secondary" disabled>
                                <i class="fas fa-check-double btn-icon"></i> Resolved
                            </button>`
                }
                        </div>
                    </div>
                </div>
            `).join('');
        }

        // Get CSS class for queue item
        function getItemCssClass(item) {
            let classes = '';
            if (item.priority === 'High') classes += 'high-priority ';
            if (item.assignedTo) classes += 'assigned ';
            if (item.status === 'Resolved') classes += 'resolved ';
            if (item.status === 'In Call') classes += 'in-call ';
            return classes.trim();
        }

        // Get diagnostic status CSS class
        function getDiagnosticStatus(status) {
            switch (status.toLowerCase()) {
                case 'good':
                case 'ok':
                case 'normal':
                    return 'good';
                case 'warning':
                case 'slow':
                case 'degraded':
                    return 'warning';
                case 'error':
                case 'failed':
                case 'down':
                case 'critical':
                case 'no signal':
                    return 'error';
                default:
                    return 'warning';
            }
        }

        // Apply filters to data
        function applyFiltersToData() {
            const priorityFilter = document.getElementById('priorityFilter').value;
            const statusFilter = document.getElementById('statusFilter').value;
            const agentFilter = document.getElementById('agentFilter').value;

            return queueData.filter(item => {
                if (priorityFilter && item.priority !== priorityFilter) return false;
                if (statusFilter && item.status !== statusFilter) return false;
                if (agentFilter === 'Me' && item.assignedTo !== currentAgent) return false;
                if (agentFilter === 'Unassigned' && item.assignedTo) return false;
                return true;
            });
        }

        // Apply filters and re-render
        function applyFilters() {
            renderQueue();
            updateStatistics();
        }

        // Update statistics
        function updateStatistics() {
            const filteredData = applyFiltersToData();
            const totalInQueue = filteredData.filter(item => item.status !== 'Resolved').length;
            const highPriority = filteredData.filter(item => item.priority === 'High' && item.status !== 'Resolved').length;

            // Calculate average wait time
            const waitTimes = filteredData
                .filter(item => item.status !== 'Resolved')
                .map(item => parseInt(item.waitTime.replace(' min', '')));
            const avgWaitTime = waitTimes.length > 0 ?
                Math.round(waitTimes.reduce((a, b) => a + b, 0) / waitTimes.length) : 0;

            document.getElementById('totalInQueue').textContent = totalInQueue;
            document.getElementById('highPriority').textContent = highPriority;
            document.getElementById('avgWaitTime').textContent = avgWaitTime;
        }

        // Update wait times
        function updateWaitTimes() {
            const now = new Date();
            queueData.forEach(item => {
                if (item.status !== 'Resolved') {
                    const waitMinutes = Math.floor((now - item.joinTime) / 60000);
                    item.waitTime = waitMinutes + ' min';
                }
            });
            renderQueue();
            updateStatistics();
        }

        // Open assignment modal
        function openAssignModal(queueId, customerName) {
            currentAssignmentId = queueId;
            document.getElementById('assignModal').querySelector('.modal-title').innerHTML = `<i class="fas fa-user-plus"></i> Assign ${customerName} to Technician`;
            document.getElementById('assignTechSelect').value = '';
            document.getElementById('assignmentNotes').value = '';
            document.getElementById('assignModal').style.display = 'block';
        }

        // Close assignment modal
        function closeAssignModal() {
            document.getElementById('assignModal').style.display = 'none';
            currentAssignmentId = null;
        }

        // Confirm assignment
        function confirmAssignment() {
            const technician = document.getElementById('assignTechSelect').value;
            const notes = document.getElementById('assignmentNotes').value;

            if (!technician) {
                showNotification('Please select a technician', 'warning');
                return;
            }

            const item = queueData.find(q => q.id === currentAssignmentId);
            if (item) {
                const wasAssigned = item.assignedTo ? 'reassigned' : 'assigned';
                item.assignedTo = technician;
                item.status = 'Assigned';

                showNotification(`Successfully ${wasAssigned} to ${technician}`, 'success');
                renderQueue();
                updateStatistics();
                closeAssignModal();
            }
        }

        // View customer details
        function viewCustomerDetails(queueId) {
            const item = queueData.find(q => q.id === queueId);
            if (!item) return;

            document.getElementById('customerModal').querySelector('.modal-title').innerHTML = `<i class="fas fa-user"></i> Customer Details - ${item.customerName}`;
            document.getElementById('modalBody').innerHTML = `
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem;">
                    <div>
                        <h4 style="color: var(--telkom-dark-blue); margin-bottom: 1rem;">Account Information</h4>
                        <p><strong>Queue ID:</strong> ${item.id}</p>
                        <p><strong>Customer:</strong> ${item.customerName}</p>
                        <p><strong>Account:</strong> ${item.accountNumber}</p>
                        <p><strong>Location:</strong> ${item.location}</p>
                        <p><strong>Priority:</strong> ${item.priority}</p>
                        <p><strong>Status:</strong> ${item.status}</p>
                        ${item.assignedTo ? `<p><strong>Assigned to:</strong> ${item.assignedTo}</p>` : ''}
                    </div>
                    <div>
                        <h4 style="color: var(--telkom-dark-blue); margin-bottom: 1rem;">Technical Status</h4>
                        <p><strong>Connection:</strong> ${item.connectionStatus}</p>
                        <p><strong>Ping:</strong> ${item.pingStatus}</p>
                        <p><strong>DNS:</strong> ${item.dnsStatus}</p>
                        <p><strong>Signal:</strong> ${item.signalStatus}</p>
                        <p><strong>Wait Time:</strong> ${item.waitTime}</p>
                        <p><strong>Queue Position:</strong> #${item.queuePosition}</p>
                    </div>
                </div>
                <div style="margin-top: 2rem;">
                    <h4 style="color: var(--telkom-dark-blue); margin-bottom: 1rem;">Issue Description</h4>
                    <p>${item.issueDescription}</p>
                </div>
                <div style="margin-top: 2rem; text-align: center;">
                    ${item.status !== 'In Call' && item.status !== 'Resolved' ?
                    `<button type="button" class="btn btn-primary" onclick="startCallFromDetails('${item.id}')">Start Call</button>` : ''
                }
                    <button type="button" class="btn btn-outline" onclick="closeCustomerModal()">Close</button>
                </div>
            `;
            document.getElementById('customerModal').style.display = 'block';
        }

        // Close customer modal
        function closeCustomerModal() {
            document.getElementById('customerModal').style.display = 'none';
        }

        // Start call from details
        function startCallFromDetails(queueId) {
            closeCustomerModal();
            startCall(queueId);
        }

        // Start call
        function startCall(queueId) {
            const item = queueData.find(q => q.id === queueId);
            if (!item) return;

            currentCallId = queueId;
            item.status = 'In Call';

            // Update call interface with enhanced elements
            document.getElementById('callCustomerName').textContent = item.customerName;
            document.getElementById('callStatus').textContent = `Connected`;

            // Update priority indicator
            const priorityIndicator = document.getElementById('callPriorityIndicator');
            priorityIndicator.innerHTML = `<i class="fas fa-flag"></i> ${item.priority} Priority`;
            priorityIndicator.className = `priority-indicator priority-${item.priority.toLowerCase()}`;

            // Display customer issue
            document.getElementById('customerIssueDisplay').innerHTML = `
                <p><strong>Reported Issue:</strong> ${item.issueDescription}</p>
                <p><strong>Diagnostics:</strong> Connection: ${item.connectionStatus}, Ping: ${item.pingStatus}, DNS: ${item.dnsStatus}, Signal: ${item.signalStatus}</p>
            `;

            // Start call timer
            callStartTime = new Date();
            startCallTimer();

            // Clear previous notes
            document.getElementById('callNotes').value = '';

            // Reset recording indicator
            document.getElementById('recordingIndicator').classList.remove('active');

            // Show call modal
            document.getElementById('callModal').style.display = 'block';

            // Update queue display
            renderQueue();
            updateStatistics();

            showNotification(`Call started with ${item.customerName}`, 'success');
        }

        // Join existing call
        function joinCall(queueId) {
            startCall(queueId); // For demo purposes, same as start call
            showNotification('Joined existing call', 'info');
        }

        // Start call timer
        function startCallTimer() {
            const timerElement = document.getElementById('callTimer');
            callTimer = setInterval(() => {
                if (!callStartTime) return;

                const now = new Date();
                const elapsed = Math.floor((now - callStartTime) / 1000);
                const minutes = Math.floor(elapsed / 60);
                const seconds = elapsed % 60;

                timerElement.textContent =
                    (minutes < 10 ? '0' : '') + minutes + ':' + (seconds < 10 ? '0' : '') + seconds;
            }, 1000);
        }

        // Toggle mute
        function toggleMute() {
            isMuted = !isMuted;
            const muteBtn = document.getElementById('muteBtn');

            if (isMuted) {
                muteBtn.classList.add('active');
                muteBtn.querySelector('i').className = 'fas fa-microphone-slash';
                showNotification('Microphone muted', 'info');
            } else {
                muteBtn.classList.remove('active');
                muteBtn.querySelector('i').className = 'fas fa-microphone';
                showNotification('Microphone unmuted', 'info');
            }
        }

        // Toggle recording
        function toggleRecording() {
            isRecording = !isRecording;
            const recordBtn = document.getElementById('recordBtn');
            const recordingIndicator = document.getElementById('recordingIndicator');

            if (isRecording) {
                recordBtn.classList.add('recording');
                recordBtn.querySelector('i').className = 'fas fa-pause';
                recordingIndicator.classList.add('active');
                showNotification('Call recording started', 'success');
            } else {
                recordBtn.classList.remove('recording');
                recordBtn.querySelector('i').className = 'fas fa-record-vinyl';
                recordingIndicator.classList.remove('active');
                showNotification('Call recording stopped', 'info');
            }
        }

        // End call
        function endCall() {
            if (!currentCallId) return;

            // Stop timer
            if (callTimer) {
                clearInterval(callTimer);
                callTimer = null;
            }

            const item = queueData.find(q => q.id === currentCallId);
            if (item) {
                // If not resolved during call, set back to assigned or in queue
                if (item.status === 'In Call') {
                    item.status = item.assignedTo ? 'Assigned' : 'In Queue';
                }
            }

            // Reset call state
            callStartTime = null;
            isRecording = false;
            isMuted = false;
            currentCallId = null;

            // Reset UI elements
            const recordBtn = document.getElementById('recordBtn');
            const muteBtn = document.getElementById('muteBtn');
            const recordingIndicator = document.getElementById('recordingIndicator');

            recordBtn.classList.remove('recording');
            recordBtn.querySelector('i').className = 'fas fa-record-vinyl';
            muteBtn.classList.remove('active');
            muteBtn.querySelector('i').className = 'fas fa-microphone';
            recordingIndicator.classList.remove('active');

            // Close modal
            document.getElementById('callModal').style.display = 'none';

            // Update queue display
            renderQueue();
            updateStatistics();

            showNotification('Call ended', 'info');
        }

        // Resolve from call
        function resolveFromCall() {
            if (!currentCallId) return;

            const item = queueData.find(q => q.id === currentCallId);
            if (!item) return;

            if (confirm(`Resolve issue for ${item.customerName}?`)) {
                item.status = 'Resolved';
                const notes = document.getElementById('callNotes').value;

                showNotification(`Issue resolved for ${item.customerName}`, 'success');

                // End call after short delay
                setTimeout(() => {
                    endCall();
                }, 1500);
            }
        }

        // Escalate from call
        function escalateFromCall() {
            if (!currentCallId) return;

            const item = queueData.find(q => q.id === currentCallId);
            if (!item) return;

            // Simple escalation - assign to a senior tech
            const seniorTechs = ['Sipho Ndlovu', 'Lerato Moloi'];
            const assignedTech = seniorTechs[Math.floor(Math.random() * seniorTechs.length)];

            item.assignedTo = assignedTech;
            item.status = 'Assigned';
            item.priority = 'High'; // Escalated issues become high priority

            const notes = document.getElementById('callNotes').value;

            showNotification(`Issue escalated to ${assignedTech}`, 'warning');

            // End call after short delay
            setTimeout(() => {
                endCall();
            }, 1500);
        }

        // Resolve issue (from main queue)
        function resolveIssue(queueId) {
            const item = queueData.find(q => q.id === queueId);
            if (!item) return;

            if (confirm(`Resolve issue for ${item.customerName}?`)) {
                item.status = 'Resolved';
                showNotification(`Issue resolved for ${item.customerName}`, 'success');
                renderQueue();
                updateStatistics();
            }
        }

        // Refresh queue
        function refreshQueue() {
            // Simulate some changes for demo
            const unresolved = queueData.filter(item => item.status !== 'Resolved');
            if (unresolved.length > 0 && Math.random() > 0.7) {
                // Randomly change a diagnostic status
                const randomItem = unresolved[Math.floor(Math.random() * unresolved.length)];
                const diagnostics = ['connectionStatus', 'pingStatus', 'dnsStatus', 'signalStatus'];
                const randomDiagnostic = diagnostics[Math.floor(Math.random() * diagnostics.length)];
                const statuses = ['Good', 'Warning', 'Error'];
                randomItem[randomDiagnostic] = statuses[Math.floor(Math.random() * statuses.length)];
            }

            renderQueue();
            updateStatistics();
            showNotification('Queue refreshed', 'info');
        }

        // Bulk assign
        function bulkAssign() {
            const unassignedItems = queueData.filter(item => !item.assignedTo && item.status !== 'Resolved');
            if (unassignedItems.length === 0) {
                showNotification('No unassigned items to bulk assign', 'info');
                return;
            }

            const technicians = ['Thato Mthembu', 'Sipho Ndlovu', 'Lerato Moloi', 'Nomsa Dlamini', 'Tshepo Khumalo'];
            let assignedCount = 0;

            unassignedItems.forEach(item => {
                const randomTech = technicians[Math.floor(Math.random() * technicians.length)];
                item.assignedTo = randomTech;
                item.status = 'Assigned';
                assignedCount++;
            });

            showNotification(`Bulk assigned ${assignedCount} items to technicians`, 'success');
            renderQueue();
            updateStatistics();
        }

        // Show notification
        function showNotification(message, type = 'info') {
            // Remove existing notifications
            const existingNotifications = document.querySelectorAll('.notification');
            existingNotifications.forEach(notif => notif.remove());

            // Create notification element
            const notification = document.createElement('div');
            notification.className = `notification ${type}`;
            notification.textContent = message;

            document.body.appendChild(notification);

            // Remove after 4 seconds
            setTimeout(() => {
                if (notification && notification.parentNode) {
                    notification.style.animation = 'slideOutRight 0.3s ease';
                    setTimeout(() => {
                        if (notification && notification.parentNode) {
                            notification.remove();
                        }
                    }, 300);
                }
            }, 4000);
        }

        // Close modal when clicking outside
        window.onclick = function (event) {
            const assignModal = document.getElementById('assignModal');
            const callModal = document.getElementById('callModal');
            const customerModal = document.getElementById('customerModal');

            if (event.target === assignModal) {
                closeAssignModal();
            }
            if (event.target === callModal) {
                endCall();
            }
            if (event.target === customerModal) {
                closeCustomerModal();
            }
        };

        // Initialize the application
        document.addEventListener('DOMContentLoaded', function () {
            initializeData();

            // Simulate live updates every 30 seconds
            setInterval(() => {
                if (currentCallId) return; // Don't update during calls

                // Randomly update some queue positions or statuses
                if (Math.random() > 0.8) {
                    updateWaitTimes();
                    showNotification('Live update: Queue data refreshed', 'info');
                }
            }, 30000);
        });
    </script>
</asp:Content>