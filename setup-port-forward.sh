#!/bin/bash

# Port Forwarding Setup Script for SNS Automation Website

echo "🌐 Port Forwarding Setup for SNS Automation"
echo "============================================"
echo ""

# Get network info
PUBLIC_IP=$(curl -s ifconfig.me)
LOCAL_IP=$(ifconfig | grep -E "inet " | grep -v 127.0.0.1 | awk '{print $2}' | head -1)
GATEWAY=$(route -n get default 2>/dev/null | grep gateway | awk '{print $2}' || ip route 2>/dev/null | grep default | awk '{print $3}' | head -1)

echo "📍 Network Information:"
echo "   Public IP: $PUBLIC_IP"
echo "   Local IP:  $LOCAL_IP"
echo "   Gateway:   $GATEWAY"
echo ""

# Start server if not running
if ! lsof -ti:8000 > /dev/null 2>&1; then
    echo "📡 Starting local server on port 8000..."
    cd "$(dirname "$0")"
    python3 -m http.server 8000 > /tmp/sns-server.log 2>&1 &
    sleep 2
    echo "✅ Server started"
else
    echo "✅ Server already running on port 8000"
fi

echo ""
echo "═══════════════════════════════════════════════════════"
echo "🔧 ROUTER PORT FORWARDING SETUP"
echo "═══════════════════════════════════════════════════════"
echo ""
echo "1. Open your router admin panel:"
echo "   http://$GATEWAY"
echo "   (Or try: http://192.168.1.1 or http://192.168.0.1)"
echo ""
echo "2. Login with your router admin credentials"
echo ""
echo "3. Find 'Port Forwarding' or 'Virtual Server' section"
echo ""
echo "4. Add a new port forwarding rule:"
echo "   ┌─────────────────────────────────────────┐"
echo "   │ External Port:  8080                    │"
echo "   │ Internal IP:    $LOCAL_IP              │"
echo "   │ Internal Port:  8000                    │"
echo "   │ Protocol:       TCP                     │"
echo "   │ Name:           SNS Automation          │"
echo "   └─────────────────────────────────────────┘"
echo ""
echo "5. Save the settings"
echo ""
echo "═══════════════════════════════════════════════════════"
echo "🌍 AFTER SETUP - ACCESS YOUR WEBSITE:"
echo "═══════════════════════════════════════════════════════"
echo ""
echo "   Public URL: http://$PUBLIC_IP:8080"
echo ""
echo "   Local URL:  http://$LOCAL_IP:8000"
echo ""
echo "═══════════════════════════════════════════════════════"
echo ""
echo "⚠️  SECURITY NOTE:"
echo "   - Your server will be accessible from the internet"
echo "   - Make sure your firewall is configured"
echo "   - Consider using HTTPS for production"
echo ""
echo "Press Ctrl+C to stop the server when done"
echo ""

# Keep server running
wait

