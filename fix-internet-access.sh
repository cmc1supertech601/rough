#!/bin/bash

# Fix Internet Access - Quick Solution

echo "🔧 Fixing Internet Access for SNS Automation"
echo "============================================="
echo ""

PUBLIC_IP=$(curl -s ifconfig.me)
LOCAL_IP=$(ifconfig | grep -E "inet " | grep -v 127.0.0.1 | awk '{print $2}' | head -1)

echo "📍 Your IPs:"
echo "   Public: $PUBLIC_IP"
echo "   Local:  $LOCAL_IP"
echo ""

echo "═══════════════════════════════════════════════════════"
echo "⚠️  ISSUE FOUND: Port Forwarding Not Configured"
echo "═══════════════════════════════════════════════════════"
echo ""
echo "Your router is blocking external access to port 8080."
echo ""

echo "🔧 SOLUTION 1: Configure Router (Recommended)"
echo "─────────────────────────────────────────────"
echo ""
echo "1. Open router admin: http://192.168.2.1"
echo "   (Or try: http://192.168.1.1)"
echo ""
echo "2. Find 'Port Forwarding' or 'Virtual Server'"
echo ""
echo "3. Add this rule:"
echo "   ┌─────────────────────────────────────┐"
echo "   │ Service Name: SNS Automation        │"
echo "   │ External Port: 8080                 │"
echo "   │ Internal IP:   $LOCAL_IP           │"
echo "   │ Internal Port: 8000                 │"
echo "   │ Protocol:      TCP                  │"
echo "   └─────────────────────────────────────┘"
echo ""
echo "4. Save and restart router"
echo ""
echo "5. Wait 1-2 minutes, then test:"
echo "   http://snsautomation.duckdns.org:8080"
echo ""

echo "🔧 SOLUTION 2: Use Tunnel (Works Immediately)"
echo "─────────────────────────────────────────────"
echo ""
echo "This works RIGHT NOW without router config:"
echo ""
read -p "Start tunnel? (y/n): " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo ""
    echo "🌍 Starting tunnel..."
    
    # Kill existing tunnel
    pkill -f localtunnel 2>/dev/null
    
    # Start tunnel
    npx -y localtunnel --port 8000 2>&1 | while IFS= read -r line; do
        echo "$line"
        if echo "$line" | grep -qE 'https://[a-zA-Z0-9-]+\.loca\.lt'; then
            TUNNEL_URL=$(echo "$line" | grep -oE 'https://[a-zA-Z0-9-]+\.loca\.lt')
            echo ""
            echo "═══════════════════════════════════════════════════════"
            echo "✅ TUNNEL ACTIVE!"
            echo "═══════════════════════════════════════════════════════"
            echo ""
            echo "🌍 Your website is now accessible at:"
            echo "   $TUNNEL_URL"
            echo ""
            echo "   (Share this URL - works immediately!)"
            echo ""
            echo "Press Ctrl+C to stop"
            echo ""
        fi
    done
fi

echo ""
echo "═══════════════════════════════════════════════════════"

