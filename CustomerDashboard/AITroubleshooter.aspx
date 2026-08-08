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
    }

    /* Welcome Section */
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
        font-size: 1.6rem;
        font-weight: 700;
        color: var(--telkom-dark-gray);
        margin-bottom: 15px;
    }

    .welcome-section p {
        font-size: 1.1rem;
        color: var(--telkom-dark-gray);
        opacity: 0.9;
        margin-bottom: 20px;
    }

    .welcome-section ul {
        list-style: none;
        padding: 0;
    }

    .welcome-section li {
        display: flex;
        align-items: center;
        gap: 10px;
        font-size: 1rem;
        color: var(--telkom-dark-gray);
        margin-bottom: 10px;
    }

    .welcome-section i {
        color: var(--telkom-green);
    }

    /* Illustration */
    .illustration {
        display: flex;
        justify-content: center;
        margin-bottom: 30px;
    }

    .illustration svg {
        width: 150px;
        height: 150px;
        transition: transform 0.3s ease;
    }

    .illustration svg:hover {
        transform: scale(1.05);
    }

    /* Troubleshooter Panel */
    .troubleshooter-panel {
        background: var(--telkom-white);
        border-radius: 12px;
        padding: 25px;
        margin-bottom: 25px;
        box-shadow: var(--glass-shadow);
        animation: slideUp 0.5s ease forwards;
    }

    .troubleshooter-header {
        display: flex;
        align-items: center;
        margin-bottom: 20px;
        gap: 15px;
    }

    .troubleshooter-icon {
        width: 40px;
        height: 40px;
        border-radius: 10px;
        background: var(--telkom-blue);
        color: var(--telkom-white);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.2rem;
    }

    .troubleshooter-title {
        font-size: 1.6rem;
        font-weight: 600;
        color: var(--telkom-dark-gray);
    }

    .form-group {
        margin-bottom: 20px;
    }

    label {
        display: block;
        margin-bottom: 8px;
        font-weight: 500;
        color: var(--telkom-dark-gray);
    }

    select, input[type="text"], input[type="date"], input[type="time"] {
        width: 100%;
        padding: 12px 15px;
        border: 1px solid rgba(0, 0, 0, 0.1);
        border-radius: 8px;
        font-size: 1rem;
        transition: all 0.3s ease;
    }

    select:focus, input[type="text"]:focus, input[type="date"]:focus, input[type="time"]:focus {
        outline: none;
        border-color: var(--telkom-blue);
        box-shadow: 0 0 0 3px rgba(0, 119, 204, 0.2);
    }

    .solution-label {
        display: block;
        padding: 15px;
        background: var(--telkom-soft-white);
        border-left: 4px solid var(--telkom-blue);
        border-radius: 8px;
        margin: 20px 0;
        font-size: 1rem;
        color: var(--telkom-dark-gray);
        line-height: 1.6;
    }

    /* Buttons */
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
        position: relative;
        overflow: hidden;
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
        background: var(--glass-bg);
        color: var(--telkom-dark-gray);
        border: var(--glass-border);
    }

    .btn-secondary:hover {
        background: rgba(255, 255, 255, 0.2);
        transform: scale(1.05);
    }

    /* Button loading animation */
    .btn-loading {
        pointer-events: none;
        opacity: 0.8;
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

    /* Chatbot Widget */
    .chatbot-widget {
        position: fixed;
        bottom: 20px;
        right: 20px;
        z-index: 1000;
    }

    .chatbot-button {
        width: 60px;
        height: 60px;
        background: var(--gradient-bg);
        color: var(--telkom-white);
        border-radius: 50%;
        display: flex;
        justify-content: center;
        align-items: center;
        cursor: pointer;
        box-shadow: var(--glass-shadow);
        transition: transform 0.3s ease;
    }

    .chatbot-button:hover {
        transform: scale(1.1);
    }

    .chatbot-container {
        position: absolute;
        bottom: 80px;
        right: 0;
        width: 350px;
        height: 450px;
        background: var(--telkom-white);
        border-radius: 12px;
        box-shadow: var(--glass-shadow);
        display: none;
        flex-direction: column;
        overflow: hidden;
        animation: slideUp 0.5s ease forwards;
    }

    .chatbot-header {
        background: var(--gradient-bg);
        color: var(--telkom-white);
        padding: 15px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .chatbot-messages {
        flex: 1;
        padding: 15px;
        overflow-y: auto;
        background: var(--telkom-soft-white);
    }

    .message {
        margin-bottom: 15px;
        display: flex;
    }

    .bot-message .message-content {
        background: var(--telkom-white);
        border: 1px solid rgba(0, 0, 0, 0.1);
        color: var(--telkom-dark-gray);
        border-radius: 18px;
        padding: 10px 15px;
    }

    .user-message .message-content {
        background: var(--telkom-blue);
        color: var(--telkom-white);
        border-radius: 18px;
        padding: 10px 15px;
    }

    /* Chat Input */
    .chatbot-input {
        display: flex;
        padding: 10px;
        border-top: 1px solid rgba(0, 0, 0, 0.1);
        background: var(--telkom-white);
    }

    .chatbot-input input {
        flex: 1;
        padding: 10px;
        border: 1px solid rgba(0, 0, 0, 0.1);
        border-radius: 20px;
        margin-right: 10px;
        font-size: 0.9rem;
    }

    .chat-send-btn {
        background: var(--telkom-blue);
        border: none;
        color: white;
        border-radius: 50%;
        width: 40px;
        height: 40px;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .chat-send-btn::before {
        font-family: "Font Awesome 5 Free";
        font-weight: 900;
        content: "\f1d8"; /* Paper plane icon */
        font-size: 16px;
    }

    .chat-send-btn:hover {
        background: var(--telkom-dark-blue);
    }

    @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
    }

    @keyframes slideUp {
        from { transform: translateY(20px); opacity: 0; }
        to { transform: translateY(0); opacity: 1; }
    }
</style>


    <!-- Welcome Section -->
    <div class="welcome-section">
        <h3>AI Troubleshooter Hub</h3>
        <p>Resolve common issues quickly with our AI-powered troubleshooter.</p>
        <ul>
            <li><i class="fas fa-robot"></i> Select an issue category and specific problem to get step-by-step solutions.</li>
            <li><i class="fas fa-comments"></i> Use the chatbot for quick answers or to clarify issues.</li>
        </ul>
    </div>

    <!-- Illustration -->
    <div class="illustration">
        <!-- unchanged SVG -->
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 200">
            <circle cx="100" cy="100" r="80" fill="none" stroke="var(--telkom-blue)" stroke-width="8"/>
            <path d="M80 70 L100 90 L120 70" fill="none" stroke="var(--telkom-green)" stroke-width="6"/>
            <circle cx="90" cy="110" r="10" fill="var(--telkom-green)"/>
            <circle cx="110" cy="110" r="10" fill="var(--telkom-green)"/>
            <rect x="85" y="130" width="30" height="10" rx="5" fill="var(--telkom-blue)"/>
            <path d="M60 50 L70 40 M140 50 L130 40" fill="none" stroke="var(--telkom-blue)" stroke-width="5"/>
        </svg>
    </div>

    <!-- AI Troubleshooter Panel -->
    <asp:Panel ID="pnlTroubleshooter" runat="server" CssClass="troubleshooter-panel" Visible="false">
        <!-- unchanged contents -->
        <div class="troubleshooter-header">
            <div class="troubleshooter-icon">
                <i class="fas fa-robot"></i>
            </div>
            <h3 class="troubleshooter-title">AI Troubleshooter</h3>
        </div>

        <div class="form-group">
            <asp:Label ID="lblQuestion" runat="server" Text="What issue are you experiencing today?" Font-Bold="true"></asp:Label>
        </div>

        <div class="form-group">
            <label for="ddlCategory">Issue Category</label>
            <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">
                <asp:ListItem Text="Select Issue Category" Value="" />
                <asp:ListItem Text="Internet" Value="Internet" />
                <asp:ListItem Text="WiFi" Value="WiFi" />
                <asp:ListItem Text="Billing" Value="Billing" />
                <asp:ListItem Text="Mobile" Value="Mobile" />
            </asp:DropDownList>
        </div>

        <div class="form-group">
            <label for="ddlSubCategory">Specific Issue</label>
            <asp:DropDownList ID="ddlSubCategory" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlSubCategory_SelectedIndexChanged">
                <asp:ListItem Text="Select Specific Issue" Value="" />
            </asp:DropDownList>
        </div>

        <asp:Label ID="lblSolution" runat="server" CssClass="solution-label"></asp:Label>

        <div style="display: flex; gap: 10px;">
            <asp:Button ID="btnClose" runat="server" Text="Close" OnClick="btnClose_Click" CssClass="btn btn-secondary" />
            <asp:Button ID="btnEscalate" runat="server" Text="Escalate to Agent" CssClass="btn btn-primary" Visible="false" OnClick="btnEscalate_Click" />
        </div>
    </asp:Panel>

    <asp:Button ID="btnStartTroubleshooter" runat="server" Text="Start Troubleshooting" CssClass="btn btn-primary" OnClick="btnStartTroubleshooter_Click" OnClientClick="return showLoading(this, 'troubleshooter')" ClientIDMode="Static" />

    <!-- Chatbot Widget -->
    <div class="chatbot-widget">
        <div class="chatbot-button" id="chatbotButton">
            <i class="fas fa-comments"></i>
        </div>
        <div class="chatbot-container" id="chatbotContainer">
            <div class="chatbot-header">
                <h3>TelkomX Support</h3>
                <button type="button" id="closeChatbot"><i class="fas fa-times"></i></button>
            </div>
            <asp:UpdatePanel ID="updChat" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="chatbot-messages" id="chatbotMessages">
                        <div class="message bot-message">
                            <div class="message-content">
                                Hello! I'm TelkomX Assistant. How can I help you today?
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
                <asp:TextBox ID="txtChatMessage" runat="server" Placeholder="Type your message..." ClientIDMode="Static"></asp:TextBox>

                <!-- ✅ FIXED BUTTON -->
                <asp:Button ID="btnChatSend" runat="server" OnClick="btnChatSend_Click"
                    Text="Send" UseSubmitBehavior="false" CssClass="chat-send-btn" ClientIDMode="Static" />
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            function showLoading(button, type) {
                button.classList.add('btn-loading');
                if (!button.querySelector('.btn-text')) {
                    const text = button.textContent;
                    button.innerHTML = `<span class="btn-text">${text}</span>`;
                }
                setTimeout(function () {
                    button.classList.remove('btn-loading');
                    showSuccessAnimation(type);
                }, 1200);
                return false;
            }

            function showSuccessAnimation(type) {
                if (type === 'troubleshooter') {
                    var successDiv = document.getElementById('troubleshooterSuccess');
                    successDiv.style.display = 'flex';
                    setTimeout(function () { successDiv.style.display = 'none'; }, 2500);
                    document.getElementById('<%= pnlTroubleshooter.ClientID %>').style.display = 'block';
                }
            }

            var chatbotButton = document.getElementById('chatbotButton');
            var chatbotContainer = document.getElementById('chatbotContainer');
            var closeChatbot = document.getElementById('closeChatbot');

            chatbotButton.addEventListener('click', function () {
                chatbotContainer.style.display = 'flex';
            });

            closeChatbot.addEventListener('click', function () {
                chatbotContainer.style.display = 'none';
            });
        });
    </script>
</asp:Content>
