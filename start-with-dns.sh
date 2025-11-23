#!/bin/bash

# Complete setup: Start server + Port forwarding + Dynamic DNS

echo "🚀 SNS Automation - Complete Setup"
echo "==================================="
echo ""

# Check if DNS is configured
CONFIG_FILE="$HOME/.sns-automation-dns"
if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
    echo "✅ Dynamic DNS configured: $DOMAIN"
    
    # Update DNS
    echo "🔄 Updating DNS..."
    "$(dirname "$0")/update-dns.sh"
    echo ""
else
    echo "⚠️  Dynamic DNS not configured yet."
    echo "   Run ./setup-dynamic-dns.sh first for permanent URL"
    echo ""
fi

# Get network info
PUBLIC_IP=$(curl -s ifconfig.me)
LOCAL_IP=$(ifconfig | grep -E "inet " | grep -v 127.0.0.1 | awk '{print $2}' | head -1)

# Kill any existing servers
lsof -ti:8000 | xargs kill -9 2>/dev/null

# Start server
echo "📡 Starting server on port 8000..."
cd "$(dirname "$0")"
python3 -m http.server 8000 > /tmp/sns-server.log 2>&1 &
SERVER_PID=$!
sleep 2

if ps -p $SERVER_PID > /dev/null; then
    echo "✅ Server running"
else
    echo "❌ Failed to start server"
    exit 1
fi

echo ""
echo "═══════════════════════════════════════════════════════"
echo "🌍 YOUR WEBSITE IS RUNNING"
echo "═══════════════════════════════════════════════════════"
echo ""

if [ -f "$CONFIG_FILE" ]; then
    echo "📍 Permanent URL: http://${DOMAIN}:8080"
    echo "   (Updates automatically when IP changes)"
    echo ""
fi

echo "📍 Public IP URL:  http://${PUBLIC_IP}:8080"
echo "📍 Local URL:      http://${LOCAL_IP}:8000"
echo ""
echo "⚠️  Make sure port forwarding is configured:"
echo "   External Port: 8080 → Internal: ${LOCAL_IP}:8000"
echo ""
echo "Press Ctrl+C to stop"
echo ""

# Cleanup function
cleanup() {
    echo ""
    echo "🛑 Stopping server..."
    kill $SERVER_PID 2>/dev/null
    lsof -ti:8000 | xargs kill -9 2>/dev/null
    echo "✅ Stopped"
    exit 0
}

trap cleanup SIGINT SIGTERM

# Keep running
wait

