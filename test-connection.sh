#!/bin/bash

# Connection Test Script

echo "🔍 Testing SNS Automation Website Connection"
echo "============================================="
echo ""

PUBLIC_IP=$(curl -s ifconfig.me)
LOCAL_IP=$(ifconfig | grep -E "inet " | grep -v 127.0.0.1 | awk '{print $2}' | head -1)

echo "📍 Network Info:"
echo "   Public IP: $PUBLIC_IP"
echo "   Local IP:  $LOCAL_IP"
echo ""

# Test 1: Local server
echo "Test 1: Local server status..."
if lsof -i :8000 | grep -q LISTEN; then
    echo "   ✅ Server is running on port 8000"
else
    echo "   ❌ Server is NOT running"
    exit 1
fi

# Test 2: Local access
echo "Test 2: Local access..."
if curl -s http://localhost:8000 > /dev/null; then
    echo "   ✅ Website accessible locally"
else
    echo "   ❌ Website not accessible locally"
fi

# Test 3: Network access
echo "Test 3: Network access (same network)..."
if curl -s --connect-timeout 2 http://$LOCAL_IP:8000 > /dev/null; then
    echo "   ✅ Website accessible on local network"
else
    echo "   ⚠️  Website not accessible on local network"
    echo "      (Check firewall settings)"
fi

# Test 4: Public IP access
echo "Test 4: Public IP access (port 8080)..."
RESPONSE=$(curl -s --connect-timeout 3 http://$PUBLIC_IP:8080 2>&1)
if echo "$RESPONSE" | grep -q "SNS Automation\|<!DOCTYPE"; then
    echo "   ✅ Website accessible via public IP!"
elif echo "$RESPONSE" | grep -q "Connection refused\|Connection timed out"; then
    echo "   ❌ Port forwarding NOT configured or blocked"
    echo "      Need to configure router port forwarding"
else
    echo "   ⚠️  Cannot reach via public IP"
    echo "      Response: ${RESPONSE:0:50}..."
fi

# Test 5: DNS
echo "Test 5: DNS resolution..."
DNS_IP=$(dig +short snsautomation.duckdns.org 2>/dev/null | tail -1)
if [ "$DNS_IP" == "$PUBLIC_IP" ]; then
    echo "   ✅ DNS is correctly pointing to your IP"
else
    echo "   ⚠️  DNS may not be updated yet"
    echo "      DNS IP: $DNS_IP"
    echo "      Your IP: $PUBLIC_IP"
fi

echo ""
echo "═══════════════════════════════════════════════════════"
echo "🔧 TROUBLESHOOTING STEPS:"
echo "═══════════════════════════════════════════════════════"
echo ""
echo "If public access doesn't work:"
echo ""
echo "1. Configure Router Port Forwarding:"
echo "   - Access router: http://192.168.2.1"
echo "   - External Port: 8080 → Internal: $LOCAL_IP:8000"
echo ""
echo "2. Check Firewall:"
echo "   - macOS: System Settings → Firewall"
echo "   - Allow incoming connections on port 8000"
echo ""
echo "3. Test from different network:"
echo "   - Use mobile data (not WiFi)"
echo "   - Try: http://$PUBLIC_IP:8080"
echo ""
echo "═══════════════════════════════════════════════════════"

