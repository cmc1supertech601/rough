#!/bin/bash

# Diagnostic script to troubleshoot website connection issues

echo "🔍 SNS Automation - Connection Diagnostics"
echo "==========================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get network info
PUBLIC_IP=$(curl -s ifconfig.me 2>/dev/null || echo "Unable to get public IP")
LOCAL_IP=$(ifconfig | grep -E "inet " | grep -v 127.0.0.1 | awk '{print $2}' | head -1)
GATEWAY=$(route -n get default 2>/dev/null | grep gateway | awk '{print $2}' || echo "Unknown")

echo "📍 Network Information:"
echo "   Public IP: $PUBLIC_IP"
echo "   Local IP:  $LOCAL_IP"
echo "   Gateway:   $GATEWAY"
echo ""

# Check if server is running
echo "🔍 Checking if web server is running..."
if lsof -ti:8000 > /dev/null 2>&1; then
    SERVER_PID=$(lsof -ti:8000 | head -1)
    SERVER_CMD=$(ps -p $SERVER_PID -o command= 2>/dev/null | head -1)
    echo -e "${GREEN}✅ Server is running on port 8000${NC}"
    echo "   PID: $SERVER_PID"
    echo "   Command: $SERVER_CMD"
    
    # Check what interface it's listening on
    LISTENING=$(lsof -i:8000 | grep LISTEN | awk '{print $9}' | head -1)
    echo "   Listening on: $LISTENING"
    
    if echo "$LISTENING" | grep -q "127.0.0.1"; then
        echo -e "${YELLOW}⚠️  WARNING: Server is only listening on localhost (127.0.0.1)${NC}"
        echo "   This means it won't accept external connections!"
        echo "   You need to bind to 0.0.0.0 or your local IP"
    fi
else
    echo -e "${RED}❌ Server is NOT running on port 8000${NC}"
    echo "   Start it with: python3 -m http.server 8000"
fi
echo ""

# Test local connection
echo "🔍 Testing local connection..."
if curl -s -o /dev/null -w "%{http_code}" http://localhost:8000 | grep -q "200\|301\|302"; then
    echo -e "${GREEN}✅ Local connection works (localhost:8000)${NC}"
else
    echo -e "${RED}❌ Local connection failed${NC}"
    echo "   Server may not be running or not responding"
fi
echo ""

# Test local network connection
if [ ! -z "$LOCAL_IP" ]; then
    echo "🔍 Testing local network connection..."
    if curl -s -o /dev/null -w "%{http_code}" --max-time 2 http://$LOCAL_IP:8000 | grep -q "200\|301\|302"; then
        echo -e "${GREEN}✅ Local network connection works ($LOCAL_IP:8000)${NC}"
    else
        echo -e "${YELLOW}⚠️  Local network connection failed${NC}"
        echo "   This might be a firewall issue"
    fi
    echo ""
fi

# Check port forwarding
echo "🔍 Port Forwarding Configuration Check:"
echo "   According to your router settings:"
echo "   - External Port: 8000 → Internal Port: 8000"
echo "   - But you're trying to access: port 8080"
echo ""
echo -e "${YELLOW}⚠️  ISSUE FOUND: Port Mismatch!${NC}"
echo ""
echo "   Your router forwards: External 8000 → Internal 8000"
echo "   But you're accessing: snsautomation.duckdns.org:8080"
echo ""
echo "   You need to change your router port forwarding to:"
echo "   - External Port: 8080"
echo "   - Internal IP: $LOCAL_IP"
echo "   - Internal Port: 8000"
echo "   - Protocol: TCP (or Both)"
echo ""

# Test public connection
if [ ! -z "$PUBLIC_IP" ] && [ "$PUBLIC_IP" != "Unable to get public IP" ]; then
    echo "🔍 Testing public IP connection..."
    echo "   Testing: http://$PUBLIC_IP:8080"
    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" --max-time 5 http://$PUBLIC_IP:8080 2>/dev/null)
    
    if [ "$HTTP_CODE" = "200" ] || [ "$HTTP_CODE" = "301" ] || [ "$HTTP_CODE" = "302" ]; then
        echo -e "${GREEN}✅ Public IP connection works!${NC}"
    elif [ "$HTTP_CODE" = "000" ]; then
        echo -e "${RED}❌ Connection timeout${NC}"
        echo "   This usually means:"
        echo "   1. Port forwarding is not configured correctly"
        echo "   2. Firewall is blocking the connection"
        echo "   3. Server is not listening on the right interface"
    else
        echo -e "${YELLOW}⚠️  Got HTTP code: $HTTP_CODE${NC}"
    fi
    echo ""
fi

# Check firewall
echo "🔍 Firewall Check:"
if command -v /usr/libexec/ApplicationFirewall/socketfilterfw &> /dev/null; then
    echo "   macOS Firewall detected"
    FIREWALL_STATUS=$(/usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate 2>/dev/null | grep -i "enabled" || echo "Unknown")
    echo "   Status: $FIREWALL_STATUS"
    if echo "$FIREWALL_STATUS" | grep -qi "enabled"; then
        echo -e "${YELLOW}⚠️  Firewall is enabled - may need to allow Python${NC}"
    fi
else
    echo "   Firewall status: Unknown"
fi
echo ""

# Summary and recommendations
echo "═══════════════════════════════════════════════════════"
echo "📋 SUMMARY & FIXES"
echo "═══════════════════════════════════════════════════════"
echo ""
echo "🔧 FIX 1: Update Port Forwarding Rule"
echo "   1. Go to your router admin: http://$GATEWAY"
echo "   2. Find the port forwarding rule named 'sns'"
echo "   3. Change External Port from 8000 to 8080"
echo "   4. Keep Internal Port as 8000"
echo "   5. Make sure Internal IP is: $LOCAL_IP"
echo "   6. Save and wait for router to restart"
echo ""
echo "🔧 FIX 2: Ensure Server is Running"
if ! lsof -ti:8000 > /dev/null 2>&1; then
    echo "   Run: cd $(dirname "$0") && python3 -m http.server 8000"
else
    echo -e "   ${GREEN}✅ Server is already running${NC}"
fi
echo ""
echo "🔧 FIX 3: Check Server Binding"
echo "   Make sure server is accessible from network"
echo "   If using Python, it should work by default"
echo "   If using other servers, bind to 0.0.0.0:8000"
echo ""
echo "🔧 FIX 4: Test After Changes"
echo "   After updating port forwarding, test:"
echo "   - Local: http://localhost:8000"
echo "   - Network: http://$LOCAL_IP:8000"
echo "   - Public: http://$PUBLIC_IP:8080"
echo "   - Domain: http://snsautomation.duckdns.org:8080"
echo ""
echo "═══════════════════════════════════════════════════════"

