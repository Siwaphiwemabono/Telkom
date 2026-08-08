<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/CustomerDashboard/Customer.Master" CodeBehind="AITroubleshooter.aspx.cs" Inherits="Telkom.CustomerDashboard.AITroubleshooter" MaintainScrollPositionOnPostBack="true"%>

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
            --receipt-bg: #f8f9fa;
            --money-green: #28a745;
            --priority-orange: #ff6b35;
        }

        /* Enhanced Welcome Section */
        .welcome-section {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: var(--glass-shadow);
            animation: fadeIn 0.5s ease forwards;
        }

        .welcome-section h3 {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--telkom-dark-gray);
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .welcome-section .feature-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .feature-card {
            background: var(--telkom-white);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            border-left: 4px solid var(--telkom-blue);
        }

        .feature-card h4 {
            color: var(--telkom-blue);
            font-size: 1.2rem;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .feature-card p {
            color: var(--telkom-dark-gray);
            font-size: 0.95rem;
            line-height: 1.5;
        }

        /* Department Status Bar */
        .department-status {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 15px;
            margin-bottom: 30px;
        }

        .department-card {
            background: var(--telkom-white);
            border-radius: 8px;
            padding: 15px;
            box-shadow: var(--glass-shadow);
            border-left: 4px solid var(--telkom-blue);
            position: relative;
            overflow: hidden;
        }

        .department-card::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 40px;
            height: 40px;
            background: linear-gradient(45deg, transparent 50%, rgba(0,119,204,0.1) 50%);
        }

        .department-card h4 {
            font-size: 1rem;
            font-weight: 600;
            color: var(--telkom-dark-gray);
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .wait-time {
            font-size: 1.1rem;
            color: var(--telkom-blue);
            font-weight: 600;
            margin-bottom: 5px;
        }

        .queue-count {
            font-size: 0.85rem;
            color: var(--telkom-dark-gray);
            opacity: 0.7;
        }

        /* Enhanced Troubleshooter Panel */
        .troubleshooter-panel {
            background: var(--telkom-white);
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: var(--glass-shadow);
            animation: slideUp 0.5s ease forwards;
            border: 1px solid rgba(0,119,204,0.1);
        }

        .troubleshooter-header {
            display: flex;
            align-items: center;
            margin-bottom: 25px;
            gap: 15px;
            padding-bottom: 15px;
            border-bottom: 2px solid var(--telkom-soft-white);
        }

        .troubleshooter-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            background: var(--gradient-bg);
            color: var(--telkom-white);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.4rem;
            box-shadow: 0 4px 12px rgba(0,119,204,0.3);
        }

        .troubleshooter-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--telkom-dark-gray);
        }

        .troubleshooter-subtitle {
            font-size: 1rem;
            color: var(--telkom-dark-gray);
            opacity: 0.8;
            margin-top: 5px;
        }

        /* Enhanced Solution Display */
        .solution-label {
            display: block;
            padding: 25px;
            background: linear-gradient(135deg, #F8F9FF 0%, #E8F4FF 100%);
            border: 2px solid rgba(0, 119, 204, 0.2);
            border-radius: 12px;
            margin: 25px 0;
            font-size: 1rem;
            color: var(--telkom-dark-gray);
            line-height: 1.7;
            white-space: pre-line;
            box-shadow: 0 6px 20px rgba(0, 119, 204, 0.1);
            position: relative;
        }

        .solution-label::before {
            content: '🤖 AI DIAGNOSIS';
            position: absolute;
            top: -12px;
            left: 20px;
            background: var(--telkom-blue);
            color: white;
            padding: 5px 12px;
            border-radius: 6px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .solution-label:not(:empty) {
            animation: slideIn 0.6s ease forwards;
        }

        /* Top Priority Technician Booking Panel */
        .technician-booking-panel {
            background: var(--telkom-white);
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: var(--glass-shadow);
            border: 2px solid var(--priority-orange);
            animation: slideUp 0.5s ease forwards;
        }

        .technician-header {
            display: flex;
            align-items: center;
            margin-bottom: 25px;
            gap: 15px;
            padding-bottom: 15px;
            border-bottom: 2px solid #fff5f0;
        }

        .technician-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            background: linear-gradient(135deg, var(--priority-orange) 0%, #f7931e 100%);
            color: var(--telkom-white);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.4rem;
            box-shadow: 0 4px 12px rgba(255, 107, 53, 0.3);
        }

        .technician-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--telkom-dark-gray);
        }

        .technician-subtitle {
            font-size: 1rem;
            color: var(--priority-orange);
            font-weight: 600;
            margin-top: 5px;
        }

        /* Pricing Display */
        .pricing-container {
            background: var(--receipt-bg);
            border-radius: 10px;
            padding: 20px;
            margin: 20px 0;
            border: 1px solid #dee2e6;
        }

        .pricing-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #e9ecef;
        }

        .pricing-row:last-child {
            border-bottom: 2px solid var(--money-green);
            font-weight: 700;
            font-size: 1.2rem;
            color: var(--money-green);
        }

        .pricing-label {
            font-weight: 600;
            color: var(--telkom-dark-gray);
        }

        .pricing-amount {
            font-weight: 700;
            color: var(--money-green);
            font-size: 1.1rem;
        }

        .priority-indicator {
            background: linear-gradient(135deg, var(--priority-orange) 0%, #ff8c42 100%);
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            margin: 10px 0;
        }

        /* Form Enhancements */
        .form-group {
            margin-bottom: 20px;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .form-row-full {
            grid-column: 1 / -1;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--telkom-dark-gray);
            font-size: 0.95rem;
        }

        .required::after {
            content: ' *';
            color: #dc3545;
        }

        select, input[type="text"], input[type="date"], input[type="time"], input[type="email"], input[type="tel"], textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
            font-family: inherit;
        }

        select:focus, input[type="text"]:focus, input[type="date"]:focus, input[type="time"]:focus, 
        input[type="email"]:focus, input[type="tel"]:focus, textarea:focus {
            outline: none;
            border-color: var(--telkom-blue);
            box-shadow: 0 0 0 3px rgba(0, 119, 204, 0.2);
            transform: translateY(-1px);
        }

        textarea {
            resize: vertical;
            min-height: 80px;
        }

        /* Checkbox Enhancement */
        .priority-checkbox {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px;
            background: linear-gradient(135deg, #fff5f0 0%, #ffe8dc 100%);
            border-radius: 10px;
            border: 2px solid var(--priority-orange);
            margin: 20px 0;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .priority-checkbox:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(255, 107, 53, 0.2);
        }

        .priority-checkbox input[type="checkbox"] {
            width: 20px;
            height: 20px;
            accent-color: var(--priority-orange);
        }

        .priority-checkbox-content {
            flex: 1;
        }

        .priority-checkbox-title {
            font-size: 1.1rem;
            font-weight: 700;
            color: var(--priority-orange);
            margin-bottom: 5px;
        }

        .priority-checkbox-desc {
            font-size: 0.9rem;
            color: var(--telkom-dark-gray);
            opacity: 0.8;
        }

        /* Button Enhancements */
        .btn {
            padding: 14px 25px;
            border-radius: 10px;
            border: none;
            cursor: pointer;
            font-weight: 700;
            font-size: 1rem;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            position: relative;
            overflow: hidden;
            text-decoration: none;
            min-width: 140px;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }

        .btn:hover::before {
            left: 100%;
        }

        .btn-primary {
            background: var(--gradient-bg);
            color: var(--telkom-white);
            box-shadow: 0 6px 20px rgba(0, 119, 204, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0, 119, 204, 0.4);
        }

        .btn-technician {
            background: linear-gradient(135deg, var(--priority-orange) 0%, #f7931e 100%);
            color: var(--telkom-white);
            box-shadow: 0 6px 20px rgba(255, 107, 53, 0.3);
            font-size: 1.1rem;
            padding: 16px 30px;
        }

        .btn-technician:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(255, 107, 53, 0.4);
        }

        .btn-secondary {
            background: var(--glass-bg);
            color: var(--telkom-dark-gray);
            border: 2px solid rgba(0, 0, 0, 0.1);
        }

        .btn-secondary:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
        }

        .btn-escalate {
            background: linear-gradient(135deg, #FF6B35 0%, #F7931E 100%);
            color: var(--telkom-white);
            box-shadow: 0 6px 20px rgba(255, 107, 53, 0.3);
        }

        .btn-escalate:hover {
            background: linear-gradient(135deg, #FF5722 0%, #FF9800 100%);
            transform: translateY(-3px);
        }

        /* Loading and Success States */
        .btn-loading {
            pointer-events: none;
            opacity: 0.8;
            position: relative;
        }

        .btn-loading .btn-text {
            visibility: hidden;
            opacity: 0;
        }

        .btn-loading::after {
            content: "";
            position: absolute;
            width: 20px;
            height: 20px;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            margin: auto;
            border: 3px solid transparent;
            border-top-color: var(--telkom-white);
            border-radius: 50%;
            animation: button-loading-spinner 1s ease infinite;
        }

        @keyframes button-loading-spinner {
            from { transform: rotate(0turn); }
            to { transform: rotate(1turn); }
        }

        /* Success Animation */
        .success-checkmark {
            display: none;
            width: 100%;
            text-align: center;
            margin: 30px 0;
        }

        .checkmark {
            width: 100px;
            height: 100px;
            margin: 0 auto;
            border-radius: 50%;
            display: block;
            stroke-width: 3;
            stroke: var(--telkom-white);
            stroke-miterlimit: 10;
            box-shadow: 0 0 20px var(--telkom-green);
            animation: fill .4s ease-in-out .4s forwards, scale .3s ease-in-out .9s both;
        }

        .checkmark-circle {
            stroke-dasharray: 166;
            stroke-dashoffset: 166;
            stroke-width: 3;
            stroke-miterlimit: 10;
            stroke: var(--telkom-green);
            fill: none;
            animation: stroke .6s cubic-bezier(0.650, 0.000, 0.450, 1.000) forwards;
        }

        .checkmark-check {
            transform-origin: 50% 50%;
            stroke-dasharray: 48;
            stroke-dashoffset: 48;
            animation: stroke .3s cubic-bezier(0.650, 0.000, 0.450, 1.000) .8s forwards;
        }

        @keyframes stroke {
            100% { stroke-dashoffset: 0; }
        }

        @keyframes scale {
            0%, 100% { transform: none; }
            50% { transform: scale3d(1.1, 1.1, 1); }
        }

        @keyframes fill {
            100% { box-shadow: 0 0 0 30px transparent; }
        }

        /* Chatbot Enhancements */
  /* Enhanced Chatbot CSS for 3-Question Auto-Booking Feature */

 /* Chatbot Widget - Enhanced with booking status */
 .chatbot-widget {
     position: fixed;
     bottom: 20px;
     right: 20px;
     z-index: 9999;
 }

 .chatbot-button {
     width: 65px;
     height: 65px;
     background: var(--gradient-bg);
     color: var(--telkom-white);
     border-radius: 50%;
     display: flex;
     justify-content: center;
     align-items: center;
     cursor: pointer;
     box-shadow: 0 8px 25px rgba(0, 119, 204, 0.4);
     transition: all 0.3s ease;
     position: relative;
     border: none;
     font-size: 1.5rem;
 }

 /* Notification indicator for new features */
 .chatbot-button::before {
     content: '';
     position: absolute;
     top: -5px;
     right: -5px;
     width: 20px;
     height: 20px;
     background: #ff4444;
     border-radius: 50%;
     animation: pulse 2s infinite;
     display: var(--notification-display, block);
 }

 .chatbot-button:hover {
     transform: scale(1.1);
     box-shadow: 0 10px 30px rgba(0, 119, 204, 0.5);
 }

 /* Chatbot Container - Enhanced */
 .chatbot-container {
     position: absolute;
     bottom: 85px;
     right: 0;
     width: 380px;
     height: 500px;
     background: var(--telkom-white);
     border-radius: 15px;
     box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
     backdrop-filter: blur(10px);
     display: none;
     flex-direction: column;
     overflow: hidden;
     border: 2px solid rgba(0, 119, 204, 0.1);
     z-index: 10000;
 }

 .chatbot-header {
     background: var(--gradient-bg);
     color: var(--telkom-white);
     padding: 20px;
     display: flex;
     justify-content: space-between;
     align-items: center;
     flex-shrink: 0;
 }

 .chatbot-header h3 {
     font-size: 1.3rem;
     font-weight: 700;
     margin: 0;
 }

 .chatbot-header button {
     background: none;
     border: none;
     color: var(--telkom-white);
     cursor: pointer;
     font-size: 1.3rem;
     transition: transform 0.3s ease;
     padding: 5px;
     border-radius: 50%;
 }

 .chatbot-header button:hover {
     transform: rotate(90deg);
     background: rgba(255, 255, 255, 0.1);
 }

 /* Messages Area - Enhanced */
 .chatbot-messages {
     flex: 1;
     padding: 20px;
     overflow-y: auto;
     background: var(--telkom-soft-white);
     min-height: 0;
     max-height: calc(500px - 140px);
     scroll-behavior: smooth;
 }

 /* Custom scrollbar */
 .chatbot-messages::-webkit-scrollbar {
     width: 6px;
 }

 .chatbot-messages::-webkit-scrollbar-track {
     background: #f1f1f1;
     border-radius: 10px;
 }

 .chatbot-messages::-webkit-scrollbar-thumb {
     background: var(--telkom-blue);
     border-radius: 10px;
 }

 .chatbot-messages::-webkit-scrollbar-thumb:hover {
     background: var(--telkom-dark-blue);
 }

 .message {
     margin-bottom: 15px;
     display: flex;
     opacity: 0;
     animation: messageSlideIn 0.4s ease forwards;
 }

 @keyframes messageSlideIn {
     from {
         opacity: 0;
         transform: translateY(10px);
     }
     to {
         opacity: 1;
         transform: translateY(0);
     }
 }

 .bot-message {
     justify-content: flex-start;
 }

 .user-message {
     justify-content: flex-end;
 }

 .message-content {
     max-width: 80%;
     padding: 12px 16px;
     border-radius: 18px;
     font-size: 0.9rem;
     line-height: 1.6;
     position: relative;
     word-wrap: break-word;
     overflow-wrap: break-word;
 }

 .bot-message .message-content {
     background: var(--telkom-white);
     border: 1px solid rgba(0, 0, 0, 0.1);
     color: var(--telkom-dark-gray);
     box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
     border-bottom-left-radius: 6px;
 }

 .user-message .message-content {
     background: var(--telkom-blue);
     color: var(--telkom-white);
     box-shadow: 0 2px 8px rgba(0, 119, 204, 0.3);
     border-bottom-right-radius: 6px;
 }

 .message-time {
     font-size: 0.7rem;
     color: var(--telkom-dark-gray);
     opacity: 0.6;
     margin-top: 5px;
     text-align: center;
     font-style: italic;
 }

 /* Typing Indicator */
 .typing-indicator .message-content {
     background: #f0f0f0;
     border: 1px solid #e0e0e0;
     display: flex;
     align-items: center;
     padding: 15px;
     animation: typingPulse 2s infinite;
 }

 @keyframes typingPulse {
     0%, 100% { opacity: 1; }
     50% { opacity: 0.7; }
 }

 .typing-animation {
     display: inline-flex;
     align-items: center;
     margin-right: 10px;
 }

 .typing-animation span {
     width: 8px;
     height: 8px;
     border-radius: 50%;
     background: var(--telkom-blue);
     display: inline-block;
     margin: 0 2px;
     opacity: 0.4;
     animation: typingDots 1.4s infinite ease-in-out;
 }

 .typing-animation span:nth-child(1) { animation-delay: -0.32s; }
 .typing-animation span:nth-child(2) { animation-delay: -0.16s; }
 .typing-animation span:nth-child(3) { animation-delay: 0s; }

 @keyframes typingDots {
     0%, 80%, 100% { 
         transform: scale(0.8); 
         opacity: 0.4; 
     }
     40% { 
         transform: scale(1.2); 
         opacity: 1; 
     }
 }

 .typing-text {
     color: #666;
     font-style: italic;
     font-size: 0.85rem;
 }

 /* Enhanced Input Area */
 .chatbot-input {
     display: flex;
     padding: 15px;
     border-top: 1px solid rgba(0, 0, 0, 0.1);
     background: var(--telkom-white);
     flex-shrink: 0;
     align-items: center;
     gap: 10px;
     position: relative;
     z-index: 1;
     box-sizing: border-box;
 }

 .chatbot-input input {
     flex: 1;
     padding: 12px 15px;
     border: 1px solid rgba(0, 0, 0, 0.1);
     border-radius: 25px;
     font-size: 0.9rem;
     transition: all 0.3s ease;
     outline: none;
     background: var(--telkom-white);
     box-sizing: border-box;
     min-width: 0;
 }

 .chatbot-input input:focus {
     border-color: var(--telkom-blue);
     box-shadow: 0 0 0 2px rgba(0, 119, 204, 0.2);
     transform: translateY(-1px);
 }

 .chatbot-input input::placeholder {
     color: #999;
     opacity: 1;
 }

 .chatbot-input button {
     background: var(--telkom-blue);
     color: var(--telkom-white);
     border: none;
     border-radius: 50%;
     width: 45px;
     height: 45px;
     cursor: pointer;
     display: flex;
     align-items: center;
     justify-content: center;
     transition: all 0.3s ease;
     flex-shrink: 0;
     font-size: 16px;
 }

 .chatbot-input button:hover {
     background: var(--telkom-dark-blue);
     transform: scale(1.05);
 }

 .chatbot-input button:focus {
     outline: 2px solid rgba(0, 119, 204, 0.5);
     outline-offset: 2px;
 }

 /* Quick Response Buttons */
 .booking-options {
     margin-top: 15px;
     display: flex;
     gap: 8px;
     flex-wrap: wrap;
 }

 .quick-response-btn {
     background: linear-gradient(135deg, var(--telkom-blue) 0%, #0056b3 100%);
     color: white;
     border: none;
     padding: 8px 15px;
     border-radius: 20px;
     font-size: 0.85rem;
     font-weight: 600;
     cursor: pointer;
     transition: all 0.3s ease;
     display: inline-flex;
     align-items: center;
     gap: 5px;
     white-space: nowrap;
 }

 .quick-response-btn:hover {
     transform: translateY(-2px);
     box-shadow: 0 4px 12px rgba(0, 119, 204, 0.3);
 }

 .quick-response-btn:active {
     transform: translateY(0);
 }

 .escalate-btn {
     background: linear-gradient(135deg, #17a2b8 0%, #138496 100%);
 }

 .escalate-btn:hover {
     box-shadow: 0 4px 12px rgba(23, 162, 184, 0.3);
 }

 .decline-btn {
     background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%);
 }

 .decline-btn:hover {
     box-shadow: 0 4px 12px rgba(108, 117, 125, 0.3);
 }

 /* Escalation Message Styling */
 .message-content.escalation-message {
     background: linear-gradient(135deg, #fff5f0 0%, #ffe8dc 100%);
     border: 2px solid #ff6b35;
     border-radius: 12px;
     padding: 15px;
     position: relative;
 }

 .message-content.escalation-message::before {
     content: '🎯 ESCALATION OPTIONS';
     position: absolute;
     top: -12px;
     left: 15px;
     background: #ff6b35;
     color: white;
     padding: 4px 10px;
     border-radius: 12px;
     font-size: 0.7rem;
     font-weight: 700;
 }

 /* Success Animations */
 .booking-success-overlay {
     position: fixed;
     top: 0;
     left: 0;
     right: 0;
     bottom: 0;
     background: rgba(40, 167, 69, 0.9);
     display: flex;
     align-items: center;
     justify-content: center;
     z-index: 11000;
     backdrop-filter: blur(5px);
     animation: fadeIn 0.5s ease forwards;
 }

 .booking-success-content {
     background: white;
     padding: 40px;
     border-radius: 20px;
     text-align: center;
     box-shadow: 0 20px 60px rgba(0,0,0,0.3);
     animation: successBounce 0.6s ease forwards;
     max-width: 90%;
     max-height: 90%;
     overflow-y: auto;
 }

 @keyframes successBounce {
     0% {
         transform: scale(0.3) translateY(-50px);
         opacity: 0;
     }
     50% {
         transform: scale(1.05) translateY(0);
         opacity: 0.8;
     }
     100% {
         transform: scale(1) translateY(0);
         opacity: 1;
     }
 }

 .success-icon {
     width: 80px;
     height: 80px;
     margin: 0 auto 20px;
     background: #28a745;
     border-radius: 50%;
     display: flex;
     align-items: center;
     justify-content: center;
     color: white;
     font-size: 40px;
     animation: successIconPulse 1s ease infinite;
 }

 @keyframes successIconPulse {
     0%, 100% { transform: scale(1); }
     50% { transform: scale(1.1); }
 }

 /* Notifications */
 .notification {
     position: fixed;
     top: 20px;
     right: 20px;
     z-index: 11000;
     max-width: 400px;
     background: white;
     border-radius: 8px;
     padding: 15px;
     box-shadow: 0 4px 12px rgba(0,0,0,0.15);
     border-left: 4px solid #28a745;
 }

 .notification-success {
     background: #d4edda;
     color: #155724;
     border-color: #28a745;
 }

 .notification-info {
     background: #d1ecf1;
     color: #0c5460;
     border-color: #17a2b8;
 }

 .notification-content {
     display: flex;
     align-items: center;
     gap: 10px;
 }

 .notification-close {
     background: none;
     border: none;
     cursor: pointer;
     color: inherit;
     font-size: 0.8rem;
     padding: 5px;
     margin-left: auto;
     border-radius: 50%;
     transition: background-color 0.3s ease;
 }

 .notification-close:hover {
     background: rgba(0,0,0,0.1);
 }

 /* Animations */
 @keyframes fadeIn {
     from { opacity: 0; }
     to { opacity: 1; }
 }

 @keyframes slideIn {
     from { 
         opacity: 0; 
         transform: translateX(-10px); 
     }
     to { 
         opacity: 1; 
         transform: translateX(0); 
     }
 }

 @keyframes slideInRight {
     from { 
         transform: translateX(100%); 
         opacity: 0; 
     }
     to { 
         transform: translateX(0); 
         opacity: 1; 
     }
 }

 @keyframes slideOutRight {
     from { 
         transform: translateX(0); 
         opacity: 1; 
     }
     to { 
         transform: translateX(100%); 
         opacity: 0; 
     }
 }

 @keyframes slideUpChat {
     from {
         opacity: 0;
         transform: translateY(20px) scale(0.95);
     }
     to {
         opacity: 1;
         transform: translateY(0) scale(1);
     }
 }

 /* Pulse animation for notification indicator */
 @keyframes pulse {
     0% {
         box-shadow: 0 0 0 0 rgba(255, 68, 68, 0.7);
     }
     70% {
         box-shadow: 0 0 0 10px rgba(255, 68, 68, 0);
     }
     100% {
         box-shadow: 0 0 0 0 rgba(255, 68, 68, 0);
     }
 }

 /* Responsive Design */
 @media (max-width: 992px) {
     .chatbot-container {
         width: 350px;
         height: 450px;
         right: -10px;
     }
     
     .chatbot-messages {
         padding: 15px;
         max-height: calc(450px - 130px);
     }
     
     .chatbot-input {
         padding: 12px;
     }
     
     .chatbot-input input {
         padding: 10px 12px;
         font-size: 0.85rem;
     }
     
     .chatbot-input button {
         width: 40px;
         height: 40px;
         font-size: 14px;
     }
     
     .quick-response-btn {
         font-size: 0.8rem;
         padding: 6px 12px;
     }
 }

 @media (max-width: 576px) {
     .chatbot-container {
         width: 300px;
         height: 400px;
         right: 10px;
         bottom: 75px;
     }
     
     .chatbot-messages {
         padding: 12px;
         max-height: calc(400px - 120px);
     }
     
     .chatbot-input {
         padding: 10px;
     }
     
     .message-content {
         font-size: 0.85rem;
         padding: 10px 12px;
         max-width: 85%;
     }
     
     .booking-success-content {
         padding: 30px 20px;
         margin: 20px;
     }
     
     .notification {
         right: 10px;
         left: 10px;
         max-width: none;
     }
     
     .success-icon {
         width: 60px;
         height: 60px;
         font-size: 30px;
     }
 }

 /* High contrast and accessibility improvements */
 @media (prefers-reduced-motion: reduce) {
     .chatbot-button::before {
         animation: none;
     }
     
     .typing-animation span {
         animation: none;
         opacity: 0.6;
     }
     
     .success-icon {
         animation: none;
     }
     
     .message {
         animation: none;
         opacity: 1;
     }
 }

 @media (prefers-high-contrast: high) {
     .chatbot-button {
         border: 2px solid white;
     }
     
     .message-content {
         border: 2px solid black;
     }
     
     .quick-response-btn {
         border: 1px solid white;
     }
 }

 /* Focus management for accessibility */
 .chatbot-input input:focus,
 .chatbot-input button:focus,
 .quick-response-btn:focus {
     outline: 3px solid rgba(0, 119, 204, 0.5);
     outline-offset: 2px;
 }

 /* Enhanced visual feedback */
 .chatbot-container.show {
     animation: slideUpChat 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94) forwards;
 }

 .message.new-message {
     animation: messageSlideIn 0.4s ease forwards;
 }

 .escalation-highlight {
     background: linear-gradient(135deg, #fff8e1 0%, #ffecb3 100%);
     border: 2px solid #ffa726;
     box-shadow: 0 4px 12px rgba(255, 167, 38, 0.2);
 }

 /* Loading states */
 .chatbot-input button.loading {
     background: #6c757d;
     cursor: not-allowed;
 }

 .chatbot-input button.loading::after {
     content: '';
     width: 16px;
     height: 16px;
     border: 2px solid transparent;
     border-top: 2px solid white;
     border-radius: 50%;
     animation: spin 1s linear infinite;
 }

 @keyframes spin {
     0% { transform: rotate(0deg); }
     100% { transform: rotate(360deg); }
 }

 /* Smooth state transitions */
 .chatbot-button.booking-confirmed {
     background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
     transition: background 0.5s ease;
 }

 .chatbot-button.booking-confirmed::before {
     display: none;
 }

 /* Enhanced message styling for different types */
 .message-content.system-message {
     background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
     border: 1px solid #2196f3;
     color: #1565c0;
     font-style: italic;
 }

 .message-content.booking-confirmation {
     background: linear-gradient(135deg, #e8f5e8 0%, #c8e6c9 100%);
     border: 2px solid #4caf50;
     color: #2e7d32;
 }

 .message-content.error-message {
     background: linear-gradient(135deg, #ffebee 0%, #ffcdd2 100%);
     border: 2px solid #f44336;
     color: #c62828;
 }

 /* Enhanced scrollbar for better UX */
 .chatbot-messages::-webkit-scrollbar-corner {
     background: transparent;
 }

 /* Print styles */
 @media print {
     .chatbot-widget {
         display: none;
     }
 }

 /* Dark mode support (if needed) */
 @media (prefers-color-scheme: dark) {
     .chatbot-messages {
         background: #1a1a1a;
     }
     
     .bot-message .message-content {
         background: #2d2d2d;
         border: 1px solid #404040;
         color: #e0e0e0;
     }
     
     .typing-indicator .message-content {
         background: #333;
         border: 1px solid #555;
     }
 }

 /* Enhanced interaction feedback */
 .quick-response-btn:hover {
     transform: translateY(-2px) scale(1.02);
 }

 .quick-response-btn:active {
     transform: translateY(0) scale(0.98);
 }

 .chatbot-input button:active {
     transform: scale(0.95);
 }

 /* Improved visual hierarchy */
 .message-content strong {
     color: var(--telkom-blue);
     font-weight: 700;
 }

 .message-content em {
     color: var(--telkom-dark-blue);
     font-style: italic;
 }

 /* Enhanced confirmation styling */
 .booking-details-summary {
     background: #f8f9fa;
     border-radius: 8px;
     padding: 12px;
     margin: 10px 0;
     border-left: 4px solid #28a745;
     font-size: 0.85rem;
 }

 .booking-reference {
     font-family: 'Courier New', monospace;
     background: #e9ecef;
     padding: 2px 6px;
     border-radius: 4px;
     font-weight: bold;
     color: #495057;
 }
    </style>

    <!-- Welcome Section -->
    <div class="welcome-section">
        <h3>
            <i class="fas fa-robot"></i>
            TelkomX AI Troubleshooter & Priority Service
        </h3>
        <p>Choose your support path: Get instant AI solutions with comprehensive alternatives, escalate to specialists with priority placement, or book a guaranteed technician visit to your home.</p>
        
        <div class="feature-grid">
            <div class="feature-card">
                <h4><i class="fas fa-brain"></i> Enhanced AI Diagnostics</h4>
                <p>Multi-layered troubleshooting with primary solutions, alternatives, advanced fixes, and realistic expectations for every technical issue.</p>
            </div>
            <div class="feature-card">
                <h4><i class="fas fa-user-cog"></i> Smart Escalation</h4>
                <p>Auto-routing to Technical, Billing, or Mobile specialists with all diagnostic details included for faster resolution.</p>
            </div>
            <div class="feature-card">
                <h4><i class="fas fa-home"></i> Priority Technician Service</h4>
                <p>R600 base fee or R650 Top Priority (2-4 hour arrival). Complete receipt with booking details, customer info, and service guarantees.</p>
            </div>
            <div class="feature-card">
                <h4><i class="fas fa-comments"></i> Context-Aware Chatbot</h4>
                <p>Smart assistant understands queue times, pricing, technical solutions, and can guide you to the best support option.</p>
            </div>
        </div>
    </div>

    <!-- Department Status Bar -->
    <div class="department-status">
        <div class="department-card">
            <h4><i class="fas fa-wifi"></i> Technical Support</h4>
            <div class="wait-time">Current Wait: 15-45 min</div>
            <div class="queue-count">Internet, WiFi, Router, Connection issues</div>
        </div>
        <div class="department-card">
            <h4><i class="fas fa-credit-card"></i> Billing Department</h4>
            <div class="wait-time">Current Wait: 10-30 min</div>
            <div class="queue-count">Bills, Payments, Refunds, Account issues</div>
        </div>
        <div class="department-card">
            <h4><i class="fas fa-mobile-alt"></i> Mobile Services</h4>
            <div class="wait-time">Current Wait: 20-40 min</div>
            <div class="queue-count">Mobile Data, Calls, SMS, Coverage</div>
        </div>
    </div>

    <!-- Main Action Buttons -->
    <div class="button-group" style="margin-bottom: 30px;">
        <asp:Button ID="btnStartTroubleshooter" runat="server" Text="🤖 Start AI Troubleshooter" CssClass="btn btn-primary" OnClick="btnStartTroubleshooter_Click" OnClientClick="return showLoading(this, 'troubleshooter')" ClientIDMode="Static" />
        <asp:Button ID="btnShowTechnicianBooking" runat="server" Text="🏠 Book Priority Technician" CssClass="btn btn-technician" OnClick="btnShowTechnicianBooking_Click" OnClientClick="return showLoading(this, 'technician')" ClientIDMode="Static" />
    </div>

    <!-- AI Troubleshooter Panel -->
    <asp:Panel ID="pnlTroubleshooter" runat="server" CssClass="troubleshooter-panel" Visible="false">
        <div class="troubleshooter-header">
            <div class="troubleshooter-icon">
                <i class="fas fa-robot"></i>
            </div>
            <div>
                <h3 class="troubleshooter-title">AI Diagnostic Assistant</h3>
                <div class="troubleshooter-subtitle">Comprehensive multi-solution troubleshooting system</div>
            </div>
        </div>

        <div class="form-group">
            <asp:Label ID="lblQuestion" runat="server" Text="What technical issue can I help you solve today?" CssClass="required" Font-Bold="true"></asp:Label>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label for="ddlCategory" class="required">Issue Category</label>
                <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged" ClientIDMode="Static">
                    <asp:ListItem Text="Select Issue Category" Value="" />
                    <asp:ListItem Text="Internet & Connection" Value="Internet" />
                    <asp:ListItem Text="WiFi & Wireless" Value="WiFi" />
                    <asp:ListItem Text="Billing & Payments" Value="Billing" />
                    <asp:ListItem Text="Mobile Services" Value="Mobile" />
                </asp:DropDownList>
            </div>

            <div class="form-group">
                <label for="ddlSubCategory" class="required">Specific Issue</label>
                <asp:DropDownList ID="ddlSubCategory" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlSubCategory_SelectedIndexChanged" ClientIDMode="Static">
                    <asp:ListItem Text="Select Specific Issue" Value="" />
                </asp:DropDownList>
            </div>
        </div>

        <asp:Label ID="lblSolution" runat="server" CssClass="solution-label"></asp:Label>

        <div class="escalation-info" id="escalationInfo" style="display: none;">
            <div style="background: linear-gradient(135deg, #FFF8E1 0%, #FFE0B2 100%); border: 2px solid #FFB74D; border-radius: 10px; padding: 20px; margin: 20px 0;">
                <h4 style="color: #E65100; font-size: 1.2rem; margin-bottom: 15px; display: flex; align-items: center; gap: 10px;">
                    <i class="fas fa-headset"></i> Ready to Escalate to Human Expert?
                </h4>
                <p style="margin-bottom: 15px; line-height: 1.6;">If the comprehensive AI solutions above didn't resolve your issue, our specialists are ready to help:</p>
                <ul style="margin: 15px 0; padding-left: 25px; line-height: 1.6;">
                    <li><strong>Smart Routing:</strong> Automatically directed to the correct department</li>
                    <li><strong>Priority Queue:</strong> Skip general support with diagnostic context</li>
                    <li><strong>Full History:</strong> All troubleshooting steps included in your ticket</li>
                    <li><strong>Real-time Updates:</strong> Live queue position and wait time estimates</li>
                </ul>
            </div>
        </div>

        <div class="button-group">
            <asp:Button ID="btnClose" runat="server" Text="Close Troubleshooter" OnClick="btnClose_Click" CssClass="btn btn-secondary" ClientIDMode="Static" />
            <asp:Button ID="btnEscalate" runat="server" Text="🎫 Escalate to Human Expert" CssClass="btn btn-escalate" Visible="false" OnClick="btnEscalate_Click" OnClientClick="return showEscalationLoading(this)" ClientIDMode="Static" />
        </div>
    </asp:Panel>

    <!-- Top Priority Technician Booking Panel -->
    <asp:Panel ID="pnlTechnicianBooking" runat="server" CssClass="technician-booking-panel" Visible="false">
        <div class="technician-header">
            <div class="technician-icon">
                <i class="fas fa-tools"></i>
            </div>
            <div>
                <h3 class="technician-title">Priority Technician Service</h3>
                <div class="technician-subtitle">Professional home visit with guaranteed arrival times</div>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label for="txtTechCustomerName" class="required">Customer Name</label>
                <asp:TextBox ID="txtTechCustomerName" runat="server" Placeholder="Enter your full name" ClientIDMode="Static"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="txtTechBillingID">Billing Account ID</label>
                <asp:TextBox ID="txtTechBillingID" runat="server" Placeholder="Auto-generated" ReadOnly="true" ClientIDMode="Static"></asp:TextBox>
            </div>
        </div>

        <div class="form-group form-row-full">
            <label for="txtTechAddress" class="required">Service Address</label>
            <asp:TextBox ID="txtTechAddress" runat="server" Placeholder="Enter complete address where technician should visit" ClientIDMode="Static"></asp:TextBox>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label for="txtTechPhone" class="required">Contact Phone</label>
                <asp:TextBox ID="txtTechPhone" runat="server" TextMode="Phone" Placeholder="+27 XX XXX XXXX" ClientIDMode="Static"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="txtTechEmail">Email Address</label>
                <asp:TextBox ID="txtTechEmail" runat="server" TextMode="Email" Placeholder="your.email@example.com" ClientIDMode="Static"></asp:TextBox>
            </div>
        </div>

        <div class="form-group">
            <label for="ddlTechProblem" class="required">Problem Category</label>
            <asp:DropDownList ID="ddlTechProblem" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlTechProblem_SelectedIndexChanged" ClientIDMode="Static">
                <asp:ListItem Text="Select Problem Type" Value="" />
                <asp:ListItem Text="Internet Connection Setup/Repair" Value="Internet Setup" />
                <asp:ListItem Text="WiFi Network Configuration" Value="WiFi Setup" />
                <asp:ListItem Text="Router/Modem Installation" Value="Hardware Install" />
                <asp:ListItem Text="Cable/Fiber Installation" Value="Line Installation" />
                <asp:ListItem Text="Network Optimization" Value="Performance Tuning" />
                <asp:ListItem Text="Home Network Setup" Value="Home Network" />
                <asp:ListItem Text="Smart Home Integration" Value="Smart Home" />
                <asp:ListItem Text="Business Network Setup" Value="Business Setup" />
            </asp:DropDownList>
        </div>

        <div class="form-group">
            <label for="txtTechProblemDetails">Problem Description</label>
            <asp:TextBox ID="txtTechProblemDetails" runat="server" TextMode="MultiLine" Placeholder="Please describe the issue in detail - what's not working, what you've tried, any error messages..." ClientIDMode="Static"></asp:TextBox>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label for="txtTechDate" class="required">Preferred Date</label>
                <asp:TextBox ID="txtTechDate" runat="server" TextMode="Date" ClientIDMode="Static"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="txtTechTime" class="required">Preferred Time</label>
                <asp:TextBox ID="txtTechTime" runat="server" TextMode="Time" ClientIDMode="Static"></asp:TextBox>
            </div>
        </div>

        <!-- Top Priority Checkbox -->
        <div class="priority-checkbox">
            <asp:CheckBox ID="chkTopPriority" runat="server" AutoPostBack="true" OnCheckedChanged="chkTopPriority_CheckedChanged" ClientIDMode="Static" />
            <div class="priority-checkbox-content">
                <div class="priority-checkbox-title">⚡ Top Priority Service (+R50)</div>
                <div class="priority-checkbox-desc">Guaranteed 2-4 hour arrival window vs standard 24-48 hours</div>
            </div>
        </div>

        <!-- Pricing Display -->
        <div class="pricing-container">
            <div class="pricing-row">
                <span class="pricing-label">Base Technician Fee:</span>
                <asp:Label ID="lblBasePriceAmount" runat="server" Text="R600.00" CssClass="pricing-amount"></asp:Label>
            </div>
            <div class="pricing-row">
                <span class="pricing-label">Top Priority Fee:</span>
                <asp:Label ID="lblPriorityFeeAmount" runat="server" Text="R0.00" CssClass="pricing-amount"></asp:Label>
            </div>
            <div class="pricing-row">
                <span class="pricing-label">TOTAL AMOUNT:</span>
                <asp:Label ID="lblTotalPriceAmount" runat="server" Text="R600.00" CssClass="pricing-amount"></asp:Label>
            </div>
        </div>

        <div style="text-align: center; margin: 20px 0;">
            <div class="priority-indicator" id="arrivalTimeIndicator">
                <i class="fas fa-clock"></i>
                <span>Estimated Arrival: </span>
                <asp:Label ID="lblEstimatedArrival" runat="server" Text="Within 24-48 hours"></asp:Label>
            </div>
        </div>

        <asp:Label ID="lblTechBookingMessage" runat="server" ForeColor="Green" Font-Bold="true" style="display: block; text-align: center; margin: 15px 0;"></asp:Label>

        <div class="button-group" style="justify-content: center;">
            <asp:Button ID="btnBookTechnician" runat="server" Text="💳 Confirm & Book Technician" CssClass="btn btn-technician" OnClick="btnBookTechnician_Click" OnClientClick="return showBookingLoading(this)" ClientIDMode="Static" />
        </div>
    </asp:Panel>

    <!-- Success Animations -->
    <div id="troubleshooterSuccess" class="success-checkmark">
        <svg class="checkmark" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52">
            <circle class="checkmark-circle" cx="26" cy="26" r="25" fill="none"/>
            <path class="checkmark-check" fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8"/>
        </svg>
        <h3 style="color: var(--telkom-green); margin-top: 20px;">AI Assistant Activated!</h3>
        <p style="color: var(--telkom-dark-gray); margin-top: 10px;">Comprehensive diagnostic system ready</p>
    </div>

    <div id="technicianSuccess" class="success-checkmark">
        <svg class="checkmark" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52">
            <circle class="checkmark-circle" cx="26" cy="26" r="25" fill="none"/>
            <path class="checkmark-check" fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8"/>
        </svg>
        <h3 style="color: var(--telkom-green); margin-top: 20px;">Technician Booking Ready!</h3>
        <p style="color: var(--telkom-dark-gray); margin-top: 10px;">Priority service booking system activated</p>
    </div>

    <!-- Chatbot Widget -->
    <div class="chatbot-widget">
        <div class="chatbot-button" id="chatbotButton">
            <i class="fas fa-comments"></i>
        </div>
        <div class="chatbot-container" id="chatbotContainer">
            <div class="chatbot-header">
                <h3>TelkomX Assistant</h3>
                <button type="button" id="closeChatbot"><i class="fas fa-times"></i></button>
            </div>
            <asp:UpdatePanel ID="updChat" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                <ContentTemplate>
                    <div class="chatbot-messages" id="chatbotMessages">
                        <div class="message bot-message">
                            <div class="message-content">
                                Hello! I'm your TelkomX AI Assistant. I provide comprehensive troubleshooting, smart escalation, and priority technician booking. How can I help you today?
                            </div>
                        </div>
                        <%= GetChatHtml() %>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnChatSend" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
            <div class="chatbot-input">
                <asp:TextBox ID="txtChatMessage" runat="server" 
                             Placeholder="Ask about troubleshooting, pricing, queue times..." 
                             ClientIDMode="Static"
                             onkeypress="return handleChatEnter(event)"></asp:TextBox>
                <asp:Button ID="btnChatSend" runat="server" 
                            OnClick="btnChatSend_Click" 
                            Text= Send 
                            UseSubmitBehavior="false" 
                            ClientIDMode="Static" 
                            CausesValidation="false" />
            </div>
        </div>
    </div>

    <script type="text/javascript">
        // Handle enter key in chat input
        function handleChatEnter(event) {
            if (event.keyCode === 13) {
                event.preventDefault();
                var sendBtn = document.getElementById('btnChatSend');
                if (sendBtn) {
                    sendBtn.click();
                }
                return false;
            }
            return true;
        }

        // Initialize chatbot after page load
        function initializeChatbot() {
            // Your main chatbot JavaScript goes here
            console.log('Initializing chatbot...');
        }

        // Call initialize on page load and after updates
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(initializeChatbot);
    </script>

    <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', function () {
            // Chatbot state tracking
            let chatbotState = {
                questionCount: 0,
                awaitingEscalation: false,
                hasBooked: false,
                bookingReference: null
            };

            // Enhanced Chatbot Functionality
            const chatbotButton = document.getElementById('chatbotButton');
            const chatbotContainer = document.getElementById('chatbotContainer');
            const closeChatbot = document.getElementById('closeChatbot');
            const sendMessageButton = document.getElementById('btnChatSend');
            const chatbotInput = document.getElementById('txtChatMessage');
            const chatbotMessages = document.getElementById('chatbotMessages');

            console.log('Chatbot elements found:', {
                button: !!chatbotButton,
                container: !!chatbotContainer,
                input: !!chatbotInput,
                sendButton: !!sendMessageButton,
                messages: !!chatbotMessages
            });

            if (chatbotButton && chatbotContainer) {
                chatbotButton.addEventListener('click', function() {
                    console.log('Chatbot button clicked');
                    chatbotContainer.style.display = 'flex';
                    chatbotContainer.classList.add('show');
                    if (chatbotInput) chatbotInput.focus();

                    // Remove notification indicator
                    chatbotButton.style.setProperty('--notification-display', 'none');

                    // Initialize chat if first time opening
                    if (chatbotState.questionCount === 0 && !chatbotState.hasBooked) {
                        addWelcomeMessage();
                    }
                });
            }

            if (closeChatbot) {
                closeChatbot.addEventListener('click', function() {
                    chatbotContainer.style.display = 'none';
                    chatbotContainer.classList.remove('show');
                });
            }

            function addWelcomeMessage() {
                const timestamp = new Date().toLocaleTimeString('en-US', {
                    hour: '2-digit',
                    minute: '2-digit',
                    hour12: false
                });

                const welcomeMessage = `
                    <div class="message bot-message fade-in">
                        <div class="message-content">
                            Hello! I'm your TelkomX AI Assistant. I provide comprehensive troubleshooting and can escalate you to human specialists when needed.
                            <br><br>
                            <strong>How it works:</strong>
                            <br>• I'll provide technical solutions for your issues
                            <br>• After 3 questions, I'll offer to create a priority support ticket
                            <br>• This connects you directly to the right specialist with full context
                            <br>• Or use the buttons above for immediate options
                            <br><br>
                            What technical issue can I help you solve today?
                        </div>
                        <div class="message-time">${timestamp}</div>
                    </div>
                `;

                if (chatbotMessages && chatbotMessages.children.length <= 1) {
                    chatbotMessages.insertAdjacentHTML('beforeend', welcomeMessage);
                    scrollToBottom();
                }
            }

            // Enhanced message sending with proper ASP.NET integration
            if (chatbotInput && sendMessageButton) {
                // Counter for frontend display
                let frontendQuestionCount = 0;

                // Override the send button click to add client-side logic
                sendMessageButton.addEventListener('click', function(e) {
                    const messageText = chatbotInput.value.trim();
                    if (messageText === '') {
                        e.preventDefault();
                        return false;
                    }

                    console.log('Sending message:', messageText);

                    // Track questions on frontend for immediate UI feedback
                    if (!chatbotState.awaitingEscalation && !chatbotState.hasBooked) {
                        frontendQuestionCount++;
                        console.log('Question count:', frontendQuestionCount);

                        // Show typing indicator for escalation question
                        if (frontendQuestionCount === 3) {
                            setTimeout(() => {
                                showTypingIndicator("I'm preparing your escalation options...");
                            }, 1000);
                        }
                    }

                    // Add user message immediately for better UX
                    addUserMessage(messageText);
                    chatbotInput.value = '';

                    // Show typing indicator
                    showTypingIndicator();

                    // Let the postback happen normally
                    return true;
                });

                // Enhanced enter key handling
                chatbotInput.addEventListener('keypress', function(e) {
                    if (e.key === 'Enter' && !e.shiftKey) {
                        e.preventDefault();
                        if (chatbotInput.value.trim() !== '') {
                            sendMessageButton.click();
                        }
                    }
                });

                // Auto-scroll and message observer
                if (chatbotMessages) {
                    // Watch for new messages from server
                    const messageObserver = new MutationObserver((mutations) => {
                        mutations.forEach((mutation) => {
                            if (mutation.addedNodes.length > 0) {
                                console.log('New messages detected');
                                
                                // Remove typing indicator when new message arrives
                                removeTypingIndicator();

                                // Check for booking confirmation in new messages
                                mutation.addedNodes.forEach(node => {
                                    if (node.nodeType === Node.ELEMENT_NODE) {
                                        const messageContent = node.textContent || '';

                                        // Detect support ticket confirmation
                                        if (messageContent.includes('SUPPORT TICKET CREATED SUCCESSFULLY') ||
                                            messageContent.includes('Ticket Number:')) {
                                            handleBookingConfirmation(messageContent);
                                        }

                                        // Detect escalation question
                                        if (messageContent.includes('Would you like me to escalate you to a human specialist') ||
                                            messageContent.includes('Would you like me to book a technician visit')) {
                                            chatbotState.awaitingEscalation = true;
                                            enhanceEscalationMessage(node);
                                        }
                                    }
                                });

                                scrollToBottom();

                                // Add fade-in animation to new messages
                                mutation.addedNodes.forEach(node => {
                                    if (node.classList && !node.classList.contains('fade-in')) {
                                        node.classList.add('fade-in');
                                    }
                                });
                            }
                        });
                    });

                    messageObserver.observe(chatbotMessages, {
                        childList: true,
                        subtree: true
                    });

                    // Initial scroll
                    scrollToBottom();
                }
            }

            function addUserMessage(text) {
                const timestamp = new Date().toLocaleTimeString('en-US', {
                    hour: '2-digit',
                    minute: '2-digit',
                    hour12: false
                });

                const userMessage = `
                    <div class="message user-message slide-in">
                        <div class="message-content">${escapeHtml(text)}</div>
                        <div class="message-time">${timestamp}</div>
                    </div>
                `;

                if (chatbotMessages) {
                    chatbotMessages.insertAdjacentHTML('beforeend', userMessage);
                    scrollToBottom();
                }
            }

            function showTypingIndicator(customText = "TelkomX Assistant is typing...") {
                removeTypingIndicator(); // Remove any existing indicator

                const typingIndicator = `
                    <div class="message bot-message typing-indicator" id="typingIndicator">
                        <div class="message-content">
                            <div class="typing-animation">
                                <span></span>
                                <span></span>
                                <span></span>
                            </div>
                            <span class="typing-text">${escapeHtml(customText)}</span>
                        </div>
                    </div>
                `;

                if (chatbotMessages) {
                    chatbotMessages.insertAdjacentHTML('beforeend', typingIndicator);
                    scrollToBottom();
                }
            }

            function removeTypingIndicator() {
                const indicator = document.getElementById('typingIndicator');
                if (indicator) {
                    indicator.remove();
                }
            }

            function scrollToBottom() {
                if (chatbotMessages) {
                    chatbotMessages.scrollTop = chatbotMessages.scrollHeight;
                }
            }

            function enhanceEscalationMessage(messageElement) {
                console.log('Enhancing escalation message');
                
                // Add special styling to escalation message
                if (messageElement && messageElement.querySelector) {
                    const messageContent = messageElement.querySelector('.message-content');
                    if (messageContent) {
                        messageContent.style.background = 'linear-gradient(135deg, #fff5f0 0%, #ffe8dc 100%)';
                        messageContent.style.border = '2px solid #ff6b35';
                        messageContent.style.borderRadius = '12px';
                        messageContent.style.padding = '15px';

                        // Add escalation options buttons
                        const escalationOptions = document.createElement('div');
                        escalationOptions.className = 'escalation-options';
                        escalationOptions.innerHTML = `
                            <div style="margin-top: 15px; display: flex; gap: 10px; flex-wrap: wrap;">
                                <button onclick="sendQuickResponse('Yes, escalate to human specialist')" 
                                        class="quick-response-btn escalate-btn">
                                    🎫 Yes, Create Support Ticket
                                </button>
                                <button onclick="sendQuickResponse('No, continue with AI')" 
                                        class="quick-response-btn decline-btn">
                                    🤖 No, Continue with AI
                                </button>
                            </div>
                        `;
                        messageContent.appendChild(escalationOptions);
                    }
                }
            }

            function handleBookingConfirmation(messageContent) {
                console.log('Handling booking confirmation');
                
                chatbotState.hasBooked = true;
                chatbotState.awaitingEscalation = false;

                // Extract ticket reference if available
                const referenceMatch = messageContent.match(/Ticket Number:\s*([A-Z0-9]+)/);
                if (referenceMatch) {
                    chatbotState.bookingReference = referenceMatch[1];
                }

                // Show success animation
                showSupportTicketSuccessAnimation();

                // Update chatbot button to show escalation confirmed
                if (chatbotButton) {
                    chatbotButton.style.background = 'linear-gradient(135deg, #17a2b8 0%, #138496 100%)';
                    chatbotButton.innerHTML = '<i class="fas fa-headset"></i>';
                    chatbotButton.title = 'Support Ticket Created - Specialist Assigned';
                }

                // Show notification
                setTimeout(() => {
                    if (chatbotContainer.style.display === 'flex') {
                        showNotification('Support ticket created! You\'re in the priority queue.', 'success');
                    }
                }, 2000);
            }

            function showSupportTicketSuccessAnimation() {
                const successOverlay = document.createElement('div');
                successOverlay.innerHTML = `
                    <div class="booking-success-overlay" style="
                        position: fixed;
                        top: 0;
                        left: 0;
                        right: 0;
                        bottom: 0;
                        background: rgba(23, 162, 184, 0.9);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        z-index: 11000;
                        animation: fadeIn 0.5s ease forwards;
                    ">
                        <div style="
                            background: white;
                            padding: 40px;
                            border-radius: 20px;
                            text-align: center;
                            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
                            animation: slideUp 0.5s ease forwards;
                        ">
                            <div style="
                                width: 80px;
                                height: 80px;
                                margin: 0 auto 20px;
                                background: #17a2b8;
                                border-radius: 50%;
                                display: flex;
                                align-items: center;
                                justify-content: center;
                                color: white;
                                font-size: 40px;
                            ">
                                🎫
                            </div>
                            <h3 style="color: #17a2b8; margin-bottom: 10px;">Support Ticket Created!</h3>
                            <p style="color: #666; margin-bottom: 20px;">You're now in the high priority queue</p>
                            <div style="
                                background: #f8f9fa;
                                padding: 15px;
                                border-radius: 10px;
                                border-left: 4px solid #17a2b8;
                                text-align: left;
                                margin: 20px 0;
                                font-size: 14px;
                            ">
                                <strong>What Happens Next:</strong><br>
                                • Specialist reviews your chat history<br>
                                • Priority queue placement confirmed<br>
                                • You'll receive a call within estimated time<br>
                                • Track progress in 'My Support Queue'
                            </div>
                        </div>
                    </div>
                `;

                document.body.appendChild(successOverlay);

                // Auto remove after 4 seconds
                setTimeout(() => {
                    successOverlay.remove();
                }, 4000);

                // Create confetti effect with support colors
                createSupportTicketConfetti();
            }

            function createSupportTicketConfetti() {
                const colors = ['#17a2b8', '#138496', '#0056b3', '#007bff', '#6610f2'];
                for (let i = 0; i < 60; i++) {
                    const confetti = document.createElement('div');
                    confetti.style.cssText = `
                        position: fixed;
                        width: ${Math.random() * 8 + 4}px;
                        height: ${Math.random() * 8 + 4}px;
                        background: ${colors[Math.floor(Math.random() * colors.length)]};
                        left: ${Math.random() * 100}vw;
                        top: -20px;
                        border-radius: 50%;
                        pointer-events: none;
                        z-index: 12000;
                    `;
                    document.body.appendChild(confetti);

                    const animation = confetti.animate([
                        { transform: 'translateY(0) rotate(0deg)', opacity: 1 },
                        { transform: `translateY(${window.innerHeight + 100}px) rotate(${Math.random() * 720}deg)`, opacity: 0 }
                    ], {
                        duration: 1500 + Math.random() * 2000,
                        easing: 'cubic-bezier(0.25, 0.46, 0.45, 0.94)'
                    });
                    animation.onfinish = () => confetti.remove();
                }
            }

            function showBookingSuccessAnimation() {
                const successOverlay = document.createElement('div');
                successOverlay.innerHTML = `
                    <div class="booking-success-overlay" style="position: fixed; top: 0; left: 0; right: 0; bottom: 0; background: rgba(40, 167, 69, 0.9); display: flex; align-items: center; justify-content: center; z-index: 11000; animation: fadeIn 0.5s ease forwards;">
                        <div style="background: white; padding: 40px; border-radius: 20px; text-align: center; box-shadow: 0 20px 60px rgba(0,0,0,0.3); animation: slideUp 0.5s ease forwards;">
                            <div style="width: 80px; height: 80px; margin: 0 auto 20px; background: #28a745; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; font-size: 40px;">
                                <i class="fas fa-tools"></i>
                            </div>
                            <h3 style="color: #28a745; margin-bottom: 10px;">Technician Booked!</h3>
                            <p style="color: #666; margin-bottom: 20px;">Your priority service is confirmed</p>
                            <div style="background: #f8f9fa; padding: 15px; border-radius: 10px; border-left: 4px solid #28a745; text-align: left; margin: 20px 0; font-size: 14px;">
                                <strong>Next Steps:</strong><br>
                                • SMS confirmation sent<br>
                                • Technician will call 30 min before arrival<br>
                                • Payment due upon service completion
                            </div>
                        </div>
                    </div>
                `;

                document.body.appendChild(successOverlay);

                // Auto remove after 4 seconds
                setTimeout(() => {
                    successOverlay.remove();
                }, 4000);

                // Create confetti effect
                createBookingConfetti();
            }

            function createBookingConfetti() {
                const colors = ['#28a745', '#20c997', '#17a2b8', '#ffc107', '#fd7e14'];
                for (let i = 0; i < 60; i++) {
                    const confetti = document.createElement('div');
                    confetti.style.cssText = `
                        position: fixed;
                        width: ${Math.random() * 8 + 4}px;
                        height: ${Math.random() * 8 + 4}px;
                        background: ${colors[Math.floor(Math.random() * colors.length)]};
                        left: ${Math.random() * 100}vw;
                        top: -20px;
                        border-radius: 50%;
                        pointer-events: none;
                        z-index: 12000;
                    `;
                    document.body.appendChild(confetti);

                    const animation = confetti.animate([
                        { transform: 'translateY(0) rotate(0deg)', opacity: 1 },
                        { transform: `translateY(${window.innerHeight + 100}px) rotate(${Math.random() * 720}deg)`, opacity: 0 }
                    ], {
                        duration: 1500 + Math.random() * 2000,
                        easing: 'cubic-bezier(0.25, 0.46, 0.45, 0.94)'
                    });
                    animation.onfinish = () => confetti.remove();
                }
            }

            function showNotification(message, type = 'info') {
                const notification = document.createElement('div');
                notification.className = `notification notification-${type}`;
                notification.innerHTML = `
                    <div class="notification-content">
                        <i class="fas fa-${type === 'success' ? 'check-circle' : 'info-circle'}"></i>
                        <span>${escapeHtml(message)}</span>
                        <button onclick="this.parentElement.parentElement.remove()" class="notification-close">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                `;
                
                notification.style.cssText = `
                    position: fixed;
                    top: 20px;
                    right: 20px;
                    z-index: 11000;
                    max-width: 400px;
                    background: ${type === 'success' ? '#d4edda' : '#d1ecf1'};
                    color: ${type === 'success' ? '#155724' : '#0c5460'};
                    border: 1px solid ${type === 'success' ? '#c3e6cb' : '#bee5eb'};
                    border-radius: 8px;
                    padding: 15px;
                    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
                    animation: slideInRight 0.5s ease forwards;
                `;
                
                document.body.appendChild(notification);
                
                // Auto remove after 5 seconds
                setTimeout(() => {
                    if (notification.parentElement) {
                        notification.style.animation = 'slideOutRight 0.5s ease forwards';
                        setTimeout(() => notification.remove(), 500);
                    }
                }, 5000);
            }

            // Utility function to escape HTML
            function escapeHtml(text) {
                const div = document.createElement('div');
                div.textContent = text;
                return div.innerHTML;
            }

            // Quick response function for escalation buttons
            window.sendQuickResponse = function(response) {
                console.log('Quick response:', response);
                if (chatbotInput && sendMessageButton) {
                    chatbotInput.value = response;
                    sendMessageButton.click();
                }
            };

            // Keyboard navigation enhancements
            document.addEventListener('keydown', function (e) {
                // Escape key closes chatbot
                if (e.key === 'Escape' && chatbotContainer && chatbotContainer.style.display === 'flex') {
                    chatbotContainer.style.display = 'none';
                }

                // Alt + C opens chatbot
                if (e.altKey && e.key === 'c') {
                    e.preventDefault();
                    if (chatbotContainer) {
                        chatbotContainer.style.display = 'flex';
                        chatbotContainer.classList.add('show');
                        if (chatbotInput) chatbotInput.focus();
                    }
                }
            });

            // Enhanced Animation Functions
            function showLoading(button, type) {
                button.classList.add('btn-loading');
                if (!button.querySelector('.btn-text')) {
                    const text = button.innerHTML;
                    button.innerHTML = `<span class="btn-text">${text}</span>`;
                }
                setTimeout(function () {
                    button.classList.remove('btn-loading');
                    showSuccessAnimation(type);
                }, 1800);
                return true;
            }

            function showEscalationLoading(button) {
                button.classList.add('btn-loading');
                if (!button.querySelector('.btn-text')) {
                    const text = button.innerHTML;
                    button.innerHTML = `<span class="btn-text">${text}</span>`;
                }
                return true;
            }

            function showBookingLoading(button) {
                button.classList.add('btn-loading');
                if (!button.querySelector('.btn-text')) {
                    const text = button.innerHTML;
                    button.innerHTML = `<span class="btn-text">${text}</span>`;
                }
                return true;
            }

            function showSuccessAnimation(type) {
                const successElement = document.getElementById(type + 'Success');
                if (successElement) {
                    successElement.style.display = 'block';
                    createConfetti();
                    setTimeout(function () {
                        successElement.style.display = 'none';
                    }, 3500);
                }
            }

            function createConfetti() {
                const colors = ['var(--telkom-blue)', 'var(--telkom-green)', '#FFC107', '#FF6B35', '#9C27B0'];
                for (let i = 0; i < 80; i++) {
                    const confetti = document.createElement('div');
                    confetti.style.cssText = `
                        position: fixed;
                        width: ${Math.random() * 10 + 5}px;
                        height: ${Math.random() * 10 + 5}px;
                        background: ${colors[Math.floor(Math.random() * colors.length)]};
                        left: ${Math.random() * 100}vw;
                        top: -20px;
                        border-radius: 50%;
                        pointer-events: none;
                        z-index: 10000;
                    `;
                    document.body.appendChild(confetti);

                    const animation = confetti.animate([
                        { transform: 'translateY(0) rotate(0deg)', opacity: 1 },
                        { transform: `translateY(${window.innerHeight + 100}px) rotate(${Math.random() * 720}deg)`, opacity: 0 }
                    ], {
                        duration: 1500 + Math.random() * 2000,
                        easing: 'cubic-bezier(0.25, 0.46, 0.45, 0.94)'
                    });
                    animation.onfinish = () => confetti.remove();
                }
            }

            // Enhanced Escalation Info Display
            function showEscalationInfo() {
                const escalationInfo = document.getElementById('escalationInfo');
                const solutionLabel = document.querySelector('.solution-label');
                if (escalationInfo && solutionLabel && solutionLabel.textContent.trim() !== '') {
                    escalationInfo.style.display = 'block';
                    escalationInfo.classList.add('slide-in');
                }
            }

            // Monitor solution changes
            const observer = new MutationObserver(function (mutations) {
                mutations.forEach(function (mutation) {
                    if (mutation.type === 'childList' || mutation.type === 'characterData') {
                        showEscalationInfo();
                        // Auto-scroll to solution
                        setTimeout(() => {
                            const solutionLabel = document.querySelector('.solution-label');
                            if (solutionLabel && solutionLabel.textContent.trim() !== '') {
                                solutionLabel.scrollIntoView({ behavior: 'smooth', block: 'center' });
                            }
                        }, 500);
                    }
                });
            });

            const solutionLabel = document.querySelector('.solution-label');
            if (solutionLabel) {
                observer.observe(solutionLabel, { childList: true, subtree: true, characterData: true });
            }

            // Monitor for booking confirmations from main form
            const techBookingMessage = document.querySelector('[id$="lblTechBookingMessage"]');
            if (techBookingMessage) {
                const bookingObserver = new MutationObserver((mutations) => {
                    mutations.forEach((mutation) => {
                        if (mutation.type === 'childList' || mutation.type === 'characterData') {
                            const message = techBookingMessage.textContent;
                            if (message.includes('successfully') && message.includes('booked')) {
                                showBookingSuccessAnimation();
                            }
                        }
                    });
                });
                
                bookingObserver.observe(techBookingMessage, { 
                    childList: true, 
                    subtree: true, 
                    characterData: true 
                });
            }

            // Enhanced form interactions for main booking panel
            const priorityCheckbox = document.getElementById('chkTopPriority');
            if (priorityCheckbox) {
                const priorityContainer = priorityCheckbox.closest('.priority-checkbox');
                if (priorityContainer) {
                    priorityContainer.addEventListener('click', function (e) {
                        if (e.target !== priorityCheckbox) {
                            priorityCheckbox.click();
                        }
                    });
                }
            }

            // Enhanced Form Interactions
            const dropdowns = document.querySelectorAll('select');
            dropdowns.forEach(dropdown => {
                dropdown.addEventListener('change', function () {
                    if (this.value !== '') {
                        this.style.fontWeight = '700';
                        this.style.color = 'var(--telkom-blue)';
                        this.classList.add('fade-in');
                    }
                });

                dropdown.addEventListener('focus', function () {
                    this.style.backgroundColor = 'rgba(0, 119, 204, 0.05)';
                    this.style.transform = 'translateY(-1px)';
                });

                dropdown.addEventListener('blur', function () {
                    this.style.backgroundColor = '';
                    this.style.transform = '';
                });
            });

            // Enhanced input field interactions
            const inputs = document.querySelectorAll('input[type="text"], input[type="email"], input[type="tel"], textarea');
            inputs.forEach(input => {
                input.addEventListener('focus', function () {
                    this.style.backgroundColor = 'rgba(0, 119, 204, 0.05)';
                    this.style.transform = 'translateY(-1px)';
                });

                input.addEventListener('blur', function () {
                    this.style.backgroundColor = '';
                    this.style.transform = '';
                });

                input.addEventListener('input', function () {
                    if (this.value.trim() !== '') {
                        this.style.borderColor = 'var(--telkom-green)';
                        this.style.color = 'var(--telkom-dark-gray)';
                    } else {
                        this.style.borderColor = '';
                        this.style.color = '';
                    }
                });
            });

            // Dynamic department status updates
            function updateDepartmentStatus() {
                const waitTimes = document.querySelectorAll('.wait-time');
                const departments = [
                    { min: 15, max: 45, base: 'Current Wait: ' },
                    { min: 10, max: 30, base: 'Current Wait: ' },
                    { min: 20, max: 40, base: 'Current Wait: ' }
                ];

                waitTimes.forEach((element, index) => {
                    if (departments[index]) {
                        const dept = departments[index];
                        const variance = Math.floor(Math.random() * 10) - 5;
                        const min = Math.max(dept.min - 5, dept.min + variance);
                        const max = Math.max(min + 15, dept.max + variance);
                        element.textContent = `${dept.base}${min}-${max} min`;

                        // Add subtle animation
                        element.style.transition = 'all 0.5s ease';
                        element.style.transform = 'scale(1.05)';
                        setTimeout(() => {
                            element.style.transform = 'scale(1)';
                        }, 300);
                    }
                });
            }

            // Update department status every 3 minutes
            setInterval(updateDepartmentStatus, 180000);

            // Panel animations on load
            const troubleshooterPanel = document.getElementById('<%= pnlTroubleshooter.ClientID %>');
            if (troubleshooterPanel && troubleshooterPanel.offsetParent !== null) {
                troubleshooterPanel.classList.add('slide-up');
            }

            const technicianPanel = document.getElementById('<%= pnlTechnicianBooking.ClientID %>');
            if (technicianPanel && technicianPanel.offsetParent !== null) {
                technicianPanel.classList.add('slide-up');
            }

            // Form validation enhancement
            function enhanceFormValidation() {
                const requiredInputs = document.querySelectorAll('input[required], select[required]');
                requiredInputs.forEach(input => {
                    input.addEventListener('invalid', function (e) {
                        e.preventDefault();
                        this.style.borderColor = '#dc3545';
                        this.style.boxShadow = '0 0 0 3px rgba(220, 53, 69, 0.2)';

                        // Remove error styling after user starts typing
                        const removeError = () => {
                            this.style.borderColor = '';
                            this.style.boxShadow = '';
                            this.removeEventListener('input', removeError);
                            this.removeEventListener('change', removeError);
                        };
                        this.addEventListener('input', removeError);
                        this.addEventListener('change', removeError);
                    });
                });
            }

            enhanceFormValidation();

            // Welcome section enhancement
            const featureCards = document.querySelectorAll('.feature-card');
            featureCards.forEach((card, index) => {
                card.style.animationDelay = `${index * 0.1}s`;
                card.classList.add('fade-in');

                card.addEventListener('mouseenter', function () {
                    this.style.transform = 'translateY(-5px)';
                    this.style.boxShadow = '0 8px 25px rgba(0, 119, 204, 0.15)';
                });

                card.addEventListener('mouseleave', function () {
                    this.style.transform = 'translateY(0)';
                    this.style.boxShadow = '0 4px 12px rgba(0,0,0,0.1)';
                });
            });

            // Department cards hover effect
            const departmentCards = document.querySelectorAll('.department-card');
            departmentCards.forEach(card => {
                card.addEventListener('mouseenter', function () {
                    this.style.transform = 'translateY(-3px)';
                    this.style.boxShadow = '0 12px 30px rgba(0, 119, 204, 0.2)';
                });

                card.addEventListener('mouseleave', function () {
                    this.style.transform = 'translateY(0)';
                    this.style.boxShadow = 'var(--glass-shadow)';
                });
            });

            // Auto-hide success messages after delay
            const successMessages = document.querySelectorAll('[id$="Message"]');
            successMessages.forEach(message => {
                if (message.textContent.includes('✅')) {
                    setTimeout(() => {
                        message.style.transition = 'opacity 0.5s ease';
                        message.style.opacity = '0';
                    }, 5000);
                }
            });

            // Enhanced button interactions
            const buttons = document.querySelectorAll('.btn');
            buttons.forEach(button => {
                button.addEventListener('mouseenter', function () {
                    if (!this.classList.contains('btn-loading')) {
                        this.style.transform = 'translateY(-2px)';
                    }
                });

                button.addEventListener('mouseleave', function () {
                    if (!this.classList.contains('btn-loading')) {
                        this.style.transform = 'translateY(0)';
                    }
                });
            });

            // Accessibility improvements
            const focusableElements = document.querySelectorAll('button, input, select, textarea, [tabindex]:not([tabindex="-1"])');
            focusableElements.forEach(element => {
                element.addEventListener('focus', function () {
                    this.style.outline = '3px solid rgba(0, 119, 204, 0.5)';
                    this.style.outlineOffset = '2px';
                });

                element.addEventListener('blur', function () {
                    this.style.outline = '';
                    this.style.outlineOffset = '';
                });
            });

            // Initialize tooltips for form fields
            const formLabels = document.querySelectorAll('label');
            formLabels.forEach(label => {
                if (label.classList.contains('required')) {
                    label.title = 'This field is required';
                }
            });

            // Price calculation display enhancement
            const priceElements = document.querySelectorAll('.pricing-amount');
            priceElements.forEach(element => {
                const observer = new MutationObserver(() => {
                    element.style.transition = 'all 0.3s ease';
                    element.style.transform = 'scale(1.1)';
                    setTimeout(() => {
                        element.style.transform = 'scale(1)';
                    }, 300);
                });
                observer.observe(element, { childList: true, characterData: true, subtree: true });
            });

            // Make functions globally available
            window.showLoading = showLoading;
            window.showEscalationLoading = showEscalationLoading;
            window.showBookingLoading = showBookingLoading;

            console.log('TelkomX Enhanced Chatbot with 3-Question Auto-Booking initialized successfully');
        });
    </script>
</asp:Content>