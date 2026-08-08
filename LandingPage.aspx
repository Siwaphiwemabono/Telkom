<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LandingPage.aspx.cs" Inherits="Telkom.LandingPage" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TelkomX Troubleshooter - Redefining Customer Support</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --telkom-blue: #0077CC;
            --telkom-green: #99FF33;
            --telkom-dark-blue: #003366;
            --telkom-white: #FFFFFF;
            --telkom-soft-white: #E6E6E6;
            --telkom-black: #0A0A0A;
            --telkom-dark-gray: #1F1F1F;
            --gradient-bg: linear-gradient(135deg, #004080 0%, #66CC00 100%);
            --glass-bg: rgba(255, 255, 255, 0.05);
            --glass-border: 1px solid rgba(255, 255, 255, 0.3);
            --glass-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
            --bg-color: #0D1117;
            --text-color: #E6E6E6;
            --card-bg: rgba(255, 255, 255, 0.03);
            --header-bg: transparent;
            --footer-bg: #001933;
            --footer-text: var(--telkom-white);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            transition: transform 0.3s, opacity 0.3s;
        }

        body {
            color: var(--text-color);
            background: var(--gradient-bg);
            line-height: 1.8;
            overflow-x: hidden;
            position: relative;
        }

        /* Floating Bubbles Animation */
        .bubble {
            position: absolute;
            border-radius: 50%;
            background: var(--glass-bg);
            backdrop-filter: blur(8px);
            animation: float 10s infinite ease-in-out;
            z-index: 1;
            opacity: 0.6;
        }

        @keyframes float {
            0%, 100% { transform: translateY(100vh) scale(0.9); }
            50% { transform: translateY(-50vh) scale(1.3); }
        }

        .container {
            width: 92%;
            max-width: 1440px;
            margin: 0 auto;
            padding: 0 32px;
            position: relative;
            z-index: 2;
        }

        /* Navigation Bar */
        header {
            background: var(--header-bg);
            backdrop-filter: blur(20px);
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            padding: 20px 0;
            border-bottom: var(--glass-border);
        }

        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 24px;
        }

        .logo {
            display: flex;
            align-items: center;
            cursor: pointer;
        }

        .logo h1 {
            font-size: 2rem;
            font-weight: 800;
            color: var(--telkom-white);
            margin-left: 16px;
            text-shadow: 0 3px 6px rgba(0, 0, 0, 0.3);
        }

        .nav-links {
            display: flex;
            list-style: none;
            gap: 32px;
            flex-grow: 1;
            justify-content: center;
        }

        .nav-links li a {
            text-decoration: none;
            color: var(--telkom-white);
            font-weight: 600;
            font-size: 1.1rem;
            position: relative;
            padding: 8px 0;
            transition: color 0.3s;
        }

        .nav-links li a::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: 0;
            left: 0;
            background: var(--telkom-green);
            transition: width 0.3s;
        }

        .nav-links li a:hover::after {
            width: 100%;
        }

        .nav-links li a:hover {
            color: var(--telkom-green);
        }

        .cta-button {
            background: var(--gradient-bg);
            color: var(--telkom-white);
            padding: 14px 36px;
            border: none;
            border-radius: 50px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: var(--glass-shadow);
        }

        .cta-button:hover {
            transform: scale(1.05);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.3);
        }

        /* Hero Section */
        .hero {
            color: var(--telkom-white);
            padding: 160px 0 120px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .hero-content {
            max-width: 1000px;
            margin: 0 auto;
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            padding: 56px;
            border-radius: 20px;
            box-shadow: var(--glass-shadow);
            opacity: 0.9;
        }

        .hero h2 {
            font-size: 4.2rem;
            font-weight: 900;
            margin-bottom: 24px;
            text-shadow: 0 3px 8px rgba(0, 0, 0, 0.4);
        }

        .hero-subtitle {
            font-size: 2rem;
            font-weight: 600;
            margin-bottom: 28px;
            opacity: 0.95;
        }

        .hero p {
            font-size: 1.3rem;
            margin-bottom: 40px;
            max-width: 800px;
            margin-left: auto;
            margin-right: auto;
        }

        .hero-buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
        }

        .secondary-button {
            background: transparent;
            color: var(--telkom-white);
            padding: 14px 32px;
            border: 2px solid var(--telkom-white);
            border-radius: 50px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .secondary-button:hover {
            background: rgba(255, 255, 255, 0.25);
            transform: scale(1.05);
        }

        /* Stats Section */
        .stats {
            padding: 100px 0;
            text-align: center;
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            margin: 32px 0;
            opacity: 0.9;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 40px;
            margin-top: 48px;
        }

        .stat-card {
            padding: 40px;
            border-radius: 16px;
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            box-shadow: var(--glass-shadow);
            transition: transform 0.4s, box-shadow 0.4s;
            opacity: 0.85;
        }

        .stat-card:hover {
            transform: scale(1.08);
            box-shadow: 0 16px 32px rgba(0, 0, 0, 0.4);
            opacity: 1;
        }

        .stat-number {
            font-size: 3rem;
            font-weight: 900;
            color: var(--telkom-green);
            margin-bottom: 16px;
            text-shadow: 0 3px 6px rgba(0, 0, 0, 0.3);
        }

        .stat-text {
            font-size: 1.2rem;
            color: var(--telkom-white);
        }

        /* Demo Video Section */
        .demo-video {
            padding: 100px 0;
            text-align: center;
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            margin: 32px 0;
            opacity: 0.9;
        }

        .video-container {
            max-width: 1000px;
            margin: 0 auto;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: var(--glass-shadow);
            position: relative;
        }

        .video-player {
            width: 100%;
            aspect-ratio: 16/9;
            border: none;
        }

        .video-info {
            position: absolute;
            bottom: 32px;
            left: 32px;
            text-align: left;
        }

        /* Features Section */
        .features {
            padding: 100px 0;
        }

        .section-title {
            text-align: center;
            margin-bottom: 80px;
        }

        .section-title h2 {
            font-size: 3rem;
            font-weight: 800;
            color: var(--telkom-white);
            margin-bottom: 20px;
            text-shadow: 0 3px 6px rgba(0, 0, 0, 0.3);
        }

        .section-title p {
            font-size: 1.3rem;
            max-width: 800px;
            margin: 0 auto;
            color: var(--telkom-white);
            opacity: 0.95;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(340px, 1fr));
            gap: 40px;
        }

        .feature-card {
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            border-radius: 16px;
            padding: 40px;
            box-shadow: var(--glass-shadow);
            text-align: center;
            opacity: 0;
            transform: translateY(40px);
            transition: all 0.6s ease-out;
            opacity: 0.85;
        }

        .feature-card.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 16px 32px rgba(0, 0, 0, 0.4);
            opacity: 1;
        }

        .feature-icon {
            font-size: 3rem;
            color: var(--telkom-green);
            margin-bottom: 24px;
            transition: transform 0.4s;
        }

        .feature-card:hover .feature-icon {
            transform: scale(1.15) rotate(8deg);
        }

        .feature-card h3 {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 20px;
            color: var(--telkom-white);
        }

        .feature-card p {
            color: var(--telkom-white);
            font-size: 1.1rem;
        }

        /* How It Works */
        .how-it-works {
            padding: 100px 0;
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            margin: 32px 0;
            opacity: 0.9;
        }

        .steps {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 32px;
            margin-top: 56px;
        }

        .step {
            flex: 1;
            min-width: 280px;
            text-align: center;
            padding: 32px;
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            border-radius: 16px;
            box-shadow: var(--glass-shadow);
            transition: transform 0.4s;
            opacity: 0.85;
        }

        .step:hover {
            transform: scale(1.06);
            opacity: 1;
        }

        .step-number {
            width: 64px;
            height: 64px;
            background: var(--gradient-bg);
            color: var(--telkom-white);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            font-weight: 700;
            margin: 0 auto 24px;
        }

        .step h3 {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 16px;
            color: var(--telkom-white);
        }

        .step p {
            color: var(--telkom-white);
            font-size: 1.1rem;
        }

        /* Benefits Section */
        .benefits {
            padding: 100px 0;
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            margin: 32px 0;
            opacity: 0.9;
        }

        .benefits-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(340px, 1fr));
            gap: 40px;
        }

        .benefit-card {
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            border-left: 5px solid var(--telkom-green);
            padding: 32px;
            border-radius: 16px;
            box-shadow: var(--glass-shadow);
            transition: transform 0.4s;
            opacity: 0.85;
        }

        .benefit-card:hover {
            transform: scale(1.06);
            opacity: 1;
        }

        .benefit-card h3 {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 16px;
            color: var(--telkom-white);
        }

        .benefit-card p {
            color: var(--telkom-white);
            font-size: 1.1rem;
        }

        /* Contact Section */
        .contact {
            padding: 100px 0;
            text-align: center;
        }

        .contact-content {
            max-width: 700px;
            margin: 0 auto;
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            padding: 56px;
            border-radius: 20px;
            box-shadow: var(--glass-shadow);
            opacity: 0.9;
        }

        .contact-content h2,
        .contact-content p {
            color: var(--telkom-soft-white);
        }

        .contact-form {
            display: flex;
            flex-direction: column;
            gap: 20px;
            margin-top: 32px;
        }

        .contact-form input,
        .contact-form textarea {
            padding: 14px;
            border: none;
            border-radius: 10px;
            background: var(--glass-bg);
            color: var(--telkom-soft-white);
            font-size: 1.1rem;
        }

        .contact-form textarea {
            resize: vertical;
            min-height: 120px;
        }

        .contact-form input::placeholder,
        .contact-form textarea::placeholder {
            color: var(--telkom-soft-white);
            opacity: 0.7;
        }

        .contact-buttons {
            display: flex;
            justify-content: space-between;
            gap: 20px;
            margin-top: 20px;
        }

        /* Slide-in Login Panel */
        .login-panel {
            position: fixed;
            top: 0;
            right: -450px;
            width: 400px;
            height: 100%;
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            box-shadow: var(--glass-shadow);
            z-index: 2000;
            padding: 40px;
            transition: right 0.5s ease-in-out;
            display: flex;
            flex-direction: column;
            justify-content: center;
            border-left: var(--glass-border);
        }

        .login-panel.open {
            right: 0;
        }

        .login-panel h2 {
            text-align: center;
            color: var(--telkom-white);
            font-size: 2.4rem;
            font-weight: 800;
            margin-bottom: 20px;
            text-shadow: 0 3px 6px rgba(0, 0, 0, 0.3);
        }

        .login-panel .instruction {
            text-align: center;
            color: var(--telkom-soft-white);
            font-size: 1rem;
            margin-bottom: 30px;
            opacity: 0.9;
            line-height: 1.5;
        }

        .login-panel input[type="text"],
        .login-panel input[type="password"] {
            width: 100%;
            padding: 16px;
            margin: 12px 0;
            border-radius: 12px;
            border: none;
            background: var(--glass-bg);
            color: var(--telkom-white);
            font-size: 1.1rem;
            box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.2);
            transition: box-shadow 0.3s;
        }

        .login-panel input:focus {
            outline: none;
            box-shadow: 0 0 8px rgba(153, 255, 51, 0.5);
        }

        .login-panel input::placeholder {
            color: var(--telkom-white);
            opacity: 0.7;
        }

        .login-panel button {
            width: 100%;
            padding: 16px;
            border: none;
            background: var(--gradient-bg);
            color: var(--telkom-white);
            border-radius: 12px;
            font-weight: 700;
            font-size: 1.2rem;
            cursor: pointer;
            text-transform: uppercase;
            letter-spacing: 1px;
            position: relative;
            overflow: hidden;
            box-shadow: var(--glass-shadow);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .login-panel button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.4s;
        }

        .login-panel button:hover::before {
            left: 100%;
        }

        .login-panel button:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.4);
        }

        .login-panel .error {
            color: #FF4D4D;
            margin-top: 12px;
            text-align: center;
            font-size: 1rem;
            font-weight: 500;
        }

        .login-panel .close-login {
            position: absolute;
            top: 20px;
            right: 20px;
            background: var(--glass-bg);
            border: var(--glass-border);
            color: var(--telkom-white);
            font-size: 1.2rem;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: transform 0.3s, background 0.3s;
        }

        .login-panel .close-login:hover {
            transform: rotate(90deg);
            background: rgba(255, 255, 255, 0.2);
        }

        /* Final CTA Section */
        .final-cta {
            background: var(--gradient-bg);
            color: var(--telkom-white);
            padding: 120px 0;
            text-align: center;
        }

        .final-cta h2 {
            font-size: 3rem;
            font-weight: 800;
            margin-bottom: 24px;
            text-shadow: 0 3px 8px rgba(0, 0, 0, 0.4);
        }

        .final-cta p {
            font-size: 1.8rem;
            max-width: 900px;
            margin: 0 auto 40px;
            font-weight: 500;
            opacity: 0.95;
        }

        /* Footer */
        footer {
            background: var(--footer-bg);
            color: var(--footer-text);
            padding: 80px 0 32px;
        }

        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 40px;
            margin-bottom: 56px;
        }

        .footer-column h3 {
            color: var(--telkom-green);
            font-size: 1.4rem;
            font-weight: 600;
            margin-bottom: 24px;
        }

        .footer-column ul {
            list-style: none;
        }

        .footer-column ul li {
            margin-bottom: 16px;
        }

        .footer-column a {
            color: var(--footer-text);
            text-decoration: none;
            font-size: 1rem;
            opacity: 0.85;
            transition: opacity 0.3s;
        }

        .footer-column a:hover {
            opacity: 1;
        }

        .newsletter-form {
            display: flex;
            margin-top: 20px;
        }

        .newsletter-input {
            flex: 1;
            padding: 14px;
            border: none;
            border-radius: 10px 0 0 10px;
            background: var(--glass-bg);
            color: var(--telkom-white);
            font-size: 1rem;
        }

        .newsletter-button {
            background: var(--gradient-bg);
            color: var(--telkom-white);
            border: none;
            padding: 14px 24px;
            border-radius: 0 10px 10px 0;
            cursor: pointer;
            font-weight: 600;
        }

        .copyright {
            text-align: center;
            padding-top: 32px;
            border-top: 1px solid rgba(255, 255, 255, 0.15);
            opacity: 0.8;
            font-size: 1rem;
        }

        /* Chatbot Widget */
        .chatbot-widget {
            position: fixed;
            bottom: 32px;
            right: 32px;
            z-index: 1000;
        }

        .chatbot-button {
            width: 72px;
            height: 72px;
            background: var(--gradient-bg);
            color: var(--telkom-white);
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            box-shadow: var(--glass-shadow);
            transition: transform 0.4s;
        }

        .chatbot-button:hover {
            transform: scale(1.15);
        }

        .chatbot-button i {
            font-size: 1.8rem;
        }

        .chatbot-container {
            position: absolute;
            bottom: 96px;
            right: 0;
            width: 400px;
            height: 520px;
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            box-shadow: var(--glass-shadow);
            display: none;
            flex-direction: column;
            overflow: hidden;
            opacity: 0.9;
        }

        .chatbot-header {
            background: var(--gradient-bg);
            color: var(--telkom-white);
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .chatbot-messages {
            flex: 1;
            padding: 20px;
            overflow-y: auto;
            background: transparent;
        }

        .message {
            margin-bottom: 20px;
            display: flex;
        }

        .bot-message {
            justify-content: flex-start;
        }

        .user-message {
            justify-content: flex-end;
        }

        .message-content {
            max-width: 75%;
            padding: 14px 20px;
            border-radius: 18px;
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            color: var(--telkom-white);
            font-size: 1rem;
            opacity: 0.9;
        }

        .chatbot-input {
            display: flex;
            padding: 16px;
            border-top: var(--glass-border);
        }

        .chatbot-input input {
            flex: 1;
            padding: 14px;
            border: none;
            border-radius: 18px;
            margin-right: 16px;
            background: var(--glass-bg);
            color: var(--telkom-white);
            font-size: 1rem;
        }

        .chatbot-input button {
            background: var(--gradient-bg);
            color: var(--telkom-white);
            border: none;
            border-radius: 50%;
            width: 48px;
            height: 48px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .nav-links {
                gap: 20px;
            }

            .hero h2 {
                font-size: 3.5rem;
            }

            .hero-subtitle {
                font-size: 1.6rem;
            }

            .hero-content {
                padding: 40px;
            }

            .login-panel {
                width: 350px;
            }
        }

        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }

            .hero h2 {
                font-size: 2.8rem;
            }

            .hero-subtitle {
                font-size: 1.4rem;
            }

            .hero-buttons {
                flex-direction: column;
                gap: 16px;
            }

            .steps {
                flex-direction: column;
            }

            .step {
                margin-bottom: 32px;
            }

            .contact-buttons {
                flex-direction: column;
            }

            .chatbot-container {
                width: 340px;
                right: -20px;
            }

            .login-panel {
                width: 100%;
                right: -100%;
            }

            .login-panel.open {
                right: 0;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .final-cta p {
                font-size: 1.4rem;
            }
        }
    </style>
</head>
<body>
    <!-- Floating Bubbles -->
    <div class="bubble" style="width: 28px; height: 28px; left: 8%; animation-delay: 0s;"></div>
    <div class="bubble" style="width: 36px; height: 36px; left: 22%; animation-delay: 2s;"></div>
    <div class="bubble" style="width: 20px; height: 20px; left: 40%; animation-delay: 4s;"></div>
    <div class="bubble" style="width: 32px; height: 32px; left: 60%; animation-delay: 6s;"></div>
    <div class="bubble" style="width: 24px; height: 24px; left: 80%; animation-delay: 8s;"></div>

    <!-- Header & Navigation -->
    <header id="home">
        <div class="container">
            <nav>
                <a href="LandingPage.aspx" class="logo">
                    <h1>Telkom<span style="color: var(--telkom-green);">X</span></h1>
                </a>
                <ul class="nav-links">
                    <li><a href="#features">Features</a></li>
                    <li><a href="#demo">Demo</a></li>
                    <li><a href="#benefits">Benefits</a></li>
                    <li><a href="#contact">Contact</a></li>
                </ul>
                <button class="cta-button" id="openLogin">Sign In</button>
            </nav>
        </div>
    </header>

    <!-- Hero Section -->
    <section class="hero">
        <div class="container">
            <div class="hero-content">
                <h2>Redefining Customer Support with AI Innovation</h2>
                <div class="hero-subtitle">Empowering Seamless Experiences Across South Africa</div>
                <p>TelkomX Troubleshooter harnesses advanced AI and predictive analytics to deliver instant, personalized support, revolutionizing customer satisfaction and operational efficiency.</p>
                <div class="hero-buttons">
                    <button class="cta-button" id="heroCta">Try It Now</button>
                    <button class="secondary-button" id="demoButton">Watch Demo</button>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="stats">
        <div class="container">
            <div class="section-title">
                <h2>Proven Impact</h2>
                <p>Measurable results that transform customer support</p>
            </div>
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-number">80%</div>
                    <div class="stat-text">Reduction in Wait Times</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">40%</div>
                    <div class="stat-text">Decrease in Operational Costs</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">25%</div>
                    <div class="stat-text">Increase in Customer Retention</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">95%</div>
                    <div class="stat-text">Customer Satisfaction Rate</div>
                </div>
            </div>
        </div>
    </section>

    <!-- Demo Video Section -->
    <section class="demo-video" id="demo">
        <div class="container">
            <div class="section-title">
                <h2>Discover TelkomX in Action</h2>
                <p>Watch how our AI-powered solutions solve real-world challenges</p>
            </div>
            <div class="video-container">
                <iframe class="video-player" src="https://www.youtube.com/embed/dQw4w9WgXcQ" title="TelkomX Demo Video" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                <div class="video-info">
                    <h3 style="margin-bottom: 16px; color: var(--telkom-white);">TelkomX Demo</h3>
                    <p style="color: var(--telkom-white);">AI Chatbot • Predictive Support • Community Insights</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features" id="features">
        <div class="container">
            <div class="section-title">
                <h2>Powerful Features</h2>
                <p>Advanced tools to elevate your customer support experience</p>
            </div>
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-robot"></i>
                    </div>
                    <h3>AI Chatbot Troubleshooter</h3>
                    <p>Guides customers through real-time, step-by-step solutions, seamlessly escalating complex issues with full diagnostics.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-ghost"></i>
                    </div>
                    <h3>Ghost Queue Predictive Support</h3>
                    <p>Anticipates issues and schedules support slots proactively, eliminating wait times for customers.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <h3>Community Forum</h3>
                    <p>Facilitates location-based issue reporting with verified technician responses, streamlining solutions.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <h3>Secure Data Handling</h3>
                    <p>Protects customer data with end-to-end encryption and compliance with global standards.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- How It Works -->
    <section class="how-it-works" id="how-it-works">
        <div class="container">
            <div class="section-title">
                <h2>How TelkomX Works</h2>
                <p>A seamless process for rapid issue resolution</p>
            </div>
            <div class="steps">
                <div class="step">
                    <div class="step-number">1</div>
                    <h3>Issue Detection</h3>
                    <p>AI-powered analytics identify issues from network data or customer reports instantly.</p>
                </div>
                <div class="step">
                    <div class="step-number">2</div>
                    <h3>AI Troubleshooting</h3>
                    <p>Interactive chatbot provides step-by-step guidance for quick resolutions.</p>
                </div>
                <div class="step">
                    <div class="step-number">3</div>
                    <h3>Smart Escalation</h3>
                    <p>Unresolved issues are escalated to agents with comprehensive diagnostics.</p>
                </div>
                <div class="step">
                    <div class="step-number">4</div>
                    <h3>Proactive Resolution</h3>
                    <p>Pre-booked support slots address predicted issues before they impact customers.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Benefits Section -->
    <section class="benefits" id="benefits">
        <div class="container">
            <div class="section-title">
                <h2>Why TelkomX?</h2>
                <p>Unmatched efficiency and customer satisfaction</p>
            </div>
            <div class="benefits-grid">
                <div class="benefit-card">
                    <h3>Zero Wait Time</h3>
                    <p>Eliminate delays with predictive scheduling and AI-driven solutions.</p>
                </div>
                <div class="benefit-card">
                    <h3>Proactive Support</h3>
                    <p>Resolve issues before they affect customers, boosting loyalty.</p>
                </div>
                <div class="benefit-card">
                    <h3>Cost Efficiency</h3>
                    <p>Automate routine resolutions to reduce call center expenses.</p>
                </div>
                <div class="benefit-card">
                    <h3>Community Insights</h3>
                    <p>Leverage location-based reports for faster, targeted solutions.</p>
                </div>
                <div class="benefit-card">
                    <h3>Higher Retention</h3>
                    <p>Reliable support enhances customer satisfaction and loyalty.</p>
                </div>
                <div class="benefit-card">
                    <h3>Enterprise Solutions</h3>
                    <p>Premium "Proactive Care" tier for advanced business support.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section class="contact" id="contact">
        <div class="container">
            <div class="section-title">
                <h2>Connect with Us</h2>
                <p>Ready to transform your customer support? Reach out today!</p>
            </div>
            <div class="contact-content">
                <div class="contact-form">
                    <input type="text" placeholder="Your Name" required>
                    <input type="email" placeholder="Your Email" required>
                    <textarea placeholder="Your Message" required></textarea>
                    <div class="contact-buttons">
                        <button class="cta-button" id="requestDemo">Submit Request</button>
                        <button class="secondary-button" onclick="document.getElementById('home').scrollIntoView({behavior: 'smooth'})">Back to Top</button>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Final CTA Section -->
    <section class="final-cta">
        <div class="container">
            <h2>Lead the Future with TelkomX</h2>
            <p>Experience customer support redefined. Join the revolution now!</p>
            <button class="cta-button" id="finalCta">Get Started Now</button>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="footer-content">
                <div class="footer-column">
                    <h3>TelkomX</h3>
                    <ul>
                        <li><a href="#">About Us</a></li>
                        <li><a href="#">Our Mission</a></li>
                        <li><a href="#">Careers</a></li>
                        <li><a href="#">Newsroom</a></li>
                    </ul>
                </div>
                <div class="footer-column">
                    <h3>Solutions</h3>
                    <ul>
                        <li><a href="#">AI Troubleshooter</a></li>
                        <li><a href="#">Ghost Queue</a></li>
                        <li><a href="#">Community Forum</a></li>
                        <li><a href="#">Enterprise Plans</a></li>
                    </ul>
                </div>
                <div class="footer-column">
                    <h3>Resources</h3>
                    <ul>
                        <li><a href="#">Help Center</a></li>
                        <li><a href="#">API Docs</a></li>
                        <li><a href="#">Blog</a></li>
                        <li><a href="#">Case Studies</a></li>
                    </ul>
                </div>
                <div class="footer-column">
                    <h3>Contact</h3>
                    <ul>
                        <li><a href="#">Support</a></li>
                        <li><a href="#">Sales</a></li>
                        <li><a href="#">Partnerships</a></li>
                        <li><a href="#">Feedback</a></li>
                    </ul>
                    <div class="newsletter-form">
                        <input type="email" class="newsletter-input" placeholder="Your email" id="newsletterEmail">
                        <button class="newsletter-button" id="newsletterButton">Join</button>
                    </div>
                </div>
            </div>
            <div class="copyright">
                <p>&copy; 2025 TelkomX Troubleshooter. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <!-- Chatbot Widget -->
    <div class="chatbot-widget">
        <div class="chatbot-button" id="chatbotButton">
            <i class="fas fa-comment"></i>
        </div>
        <div class="chatbot-container" id="chatbotContainer">
            <div class="chatbot-header">
                <span>TelkomX Assistant</span>
                <button class="chatbot-close" id="chatbotClose"><i class="fas fa-times"></i></button>
            </div>
            <div class="chatbot-messages" id="chatbotMessages">
                <div class="message bot-message">
                    <div class="message-content">Welcome to TelkomX! How can I assist you today?</div>
                </div>
            </div>
            <div class="chatbot-input">
                <input type="text" placeholder="Type your message..." id="chatbotInput">
                <button id="chatbotSend"><i class="fas fa-paper-plane"></i></button>
            </div>
        </div>
    </div>

    <!-- Slide-in Login Panel -->
    <div class="login-panel" id="loginPanel">
        <button class="close-login" id="closeLogin"><i class="fas fa-times"></i></button>
        <form id="form1" runat="server">
            <h2>TelkomX Sign In</h2>
            <p class="instruction">Enter your credentials to access your personalized dashboard.</p>
            <asp:TextBox ID="txtUsername" runat="server" Placeholder="Username"></asp:TextBox>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Placeholder="Password"></asp:TextBox>
            <asp:Button ID="btnSignIn" runat="server" Cssclass="cta-button" Text="Sign In" OnClick="btnSignIn_Click" />
            <asp:Label ID="lblError" runat="server" CssClass="error"></asp:Label>
        </form>
    </div>

    <script>
        // Smooth Scroll for Navigation
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                document.querySelector(this.getAttribute('href')).scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            });
        });

        // Analytics Simulation
        const trackButtonClick = (buttonId) => {
            console.log(`Button clicked: ${buttonId}`);
        };

        document.getElementById('openLogin').addEventListener('click', () => {
            trackButtonClick('open-login');
            document.getElementById('loginPanel').classList.add('open');
        });

        document.getElementById('heroCta').addEventListener('click', () => trackButtonClick('hero-cta'));
        document.getElementById('finalCta').addEventListener('click', () => trackButtonClick('final-cta'));
        document.getElementById('requestDemo').addEventListener('click', () => {
            trackButtonClick('request-demo');
            alert('Request submitted! Our team will contact you soon.');
        });
        document.getElementById('demoButton').addEventListener('click', () => {
            trackButtonClick('watch-demo');
            document.getElementById('demo').scrollIntoView({ behavior: 'smooth' });
        });

        // Login Panel Functionality
        const loginPanel = document.getElementById('loginPanel');
        const closeLogin = document.getElementById('closeLogin');
        closeLogin.addEventListener('click', () => {
            loginPanel.classList.remove('open');
        });

        // Animate Features on Scroll
        const featureCards = document.querySelectorAll('.feature-card');
        const checkVisibility = () => {
            featureCards.forEach((card, index) => {
                const rect = card.getBoundingClientRect();
                if (rect.top < window.innerHeight - 150) {
                    setTimeout(() => {
                        card.classList.add('visible');
                    }, index * 300);
                }
            });
        };

        window.addEventListener('scroll', checkVisibility);
        window.addEventListener('load', checkVisibility);

        // Newsletter Signup
        const newsletterButton = document.getElementById('newsletterButton');
        const newsletterEmail = document.getElementById('newsletterEmail');

        newsletterButton.addEventListener('click', () => {
            const email = newsletterEmail.value.trim();
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            if (email && emailRegex.test(email)) {
                alert('Thank you for subscribing to our newsletter!');
                newsletterEmail.value = '';
            } else {
                alert('Please enter a valid email address.');
            }
        });

        // Chatbot Functionality
        const chatbotButton = document.getElementById('chatbotButton');
        const chatbotContainer = document.getElementById('chatbotContainer');
        const chatbotClose = document.getElementById('chatbotClose');
        const chatbotSend = document.getElementById('chatbotSend');
        const chatbotInput = document.getElementById('chatbotInput');
        const chatbotMessages = document.getElementById('chatbotMessages');

        chatbotButton.addEventListener('click', () => {
            chatbotContainer.style.display = chatbotContainer.style.display === 'flex' ? 'none' : 'flex';
        });

        chatbotClose.addEventListener('click', () => {
            chatbotContainer.style.display = 'none';
        });

        chatbotSend.addEventListener('click', () => {
            const message = chatbotInput.value.trim();
            if (message) {
                const userMessage = document.createElement('div');
                userMessage.className = 'message user-message';
                userMessage.innerHTML = `<div class="message-content">${message}</div>`;
                chatbotMessages.appendChild(userMessage);

                setTimeout(() => {
                    const botMessage = document.createElement('div');
                    botMessage.className = 'message bot-message';
                    let response = 'Thanks for your message! How else can I assist you?';
                    if (message.toLowerCase().includes('demo')) {
                        response = 'Interested in our demo? Scroll to the Demo section to watch our video or contact us for a live demo!';
                    } else if (message.toLowerCase().includes('support')) {
                        response = 'Our AI Troubleshooter handles common issues instantly, or visit the Contact section to reach our support team.';
                    } else if (message.toLowerCase().includes('pricing')) {
                        response = 'For pricing details, please contact our sales team via the Contact section!';
                    }
                    botMessage.innerHTML = `<div class="message-content">${response}</div>`;
                    chatbotMessages.appendChild(botMessage);
                    chatbotMessages.scrollTop = chatbotMessages.scrollHeight;
                }, 1000);

                chatbotInput.value = '';
                chatbotMessages.scrollTop = chatbotMessages.scrollHeight;
            }
        });

        chatbotInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                chatbotSend.click();
            }
        });
    </script>
</body>
</html>