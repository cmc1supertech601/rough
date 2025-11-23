#!/bin/bash

# Dynamic DNS Setup Script for SNS Automation Website
# This creates a permanent URL that updates automatically

echo "🌐 Dynamic DNS Setup for SNS Automation"
echo "========================================"
echo ""

# Check if required tools are installed
if ! command -v curl &> /dev/null; then
    echo "❌ curl is required. Please install it first."
    exit 1
fi

# Get current public IP
CURRENT_IP=$(curl -s ifconfig.me)
LOCAL_IP=$(ifconfig | grep -E "inet " | grep -v 127.0.0.1 | awk '{print $2}' | head -1)

echo "📍 Current IP Address: $CURRENT_IP"
echo "📍 Local IP: $LOCAL_IP"
echo ""

echo "═══════════════════════════════════════════════════════"
echo "🔧 DUCK DNS SETUP (Free & Easy)"
echo "═══════════════════════════════════════════════════════"
echo ""
echo "1. Go to https://www.duckdns.org"
echo "2. Sign in with your Google, GitHub, or Reddit account"
echo "3. Create a subdomain (e.g., 'snsautomation')"
echo "4. Copy your token from the DuckDNS page"
echo ""

read -p "Enter your DuckDNS subdomain (e.g., snsautomation): " SUBDOMAIN
read -sp "Enter your DuckDNS token: " TOKEN
echo ""

if [ -z "$SUBDOMAIN" ] || [ -z "$TOKEN" ]; then
    echo "❌ Subdomain and token are required!"
    exit 1
fi

DUCKDNS_DOMAIN="${SUBDOMAIN}.duckdns.org"

echo ""
echo "🔄 Updating DuckDNS..."
UPDATE_URL="https://www.duckdns.org/update?domains=${SUBDOMAIN}&token=${TOKEN}&ip=${CURRENT_IP}"
RESPONSE=$(curl -s "$UPDATE_URL")

if [ "$RESPONSE" == "OK" ]; then
    echo "✅ DuckDNS updated successfully!"
    echo ""
    echo "═══════════════════════════════════════════════════════"
    echo "🌍 YOUR PERMANENT URL:"
    echo "═══════════════════════════════════════════════════════"
    echo ""
    echo "   http://${DUCKDNS_DOMAIN}:8080"
    echo ""
    echo "   (After port forwarding is set up)"
    echo ""
    echo "═══════════════════════════════════════════════════════"
else
    echo "❌ Failed to update DuckDNS: $RESPONSE"
    exit 1
fi

# Save configuration
CONFIG_FILE="$HOME/.sns-automation-dns"
cat > "$CONFIG_FILE" << EOF
SUBDOMAIN=${SUBDOMAIN}
TOKEN=${TOKEN}
DOMAIN=${DUCKDNS_DOMAIN}
EOF

chmod 600 "$CONFIG_FILE"
echo "✅ Configuration saved to $CONFIG_FILE"
echo ""

# Create update script
UPDATE_SCRIPT="/Users/harmanattal/Documents/ajay-workspace/snsAutomation/update-dns.sh"
cat > "$UPDATE_SCRIPT" << 'SCRIPT_EOF'
#!/bin/bash
# Auto-update script for DuckDNS

CONFIG_FILE="$HOME/.sns-automation-dns"
if [ ! -f "$CONFIG_FILE" ]; then
    echo "❌ Configuration file not found. Run setup-dynamic-dns.sh first."
    exit 1
fi

source "$CONFIG_FILE"
CURRENT_IP=$(curl -s ifconfig.me)

UPDATE_URL="https://www.duckdns.org/update?domains=${SUBDOMAIN}&token=${TOKEN}&ip=${CURRENT_IP}"
RESPONSE=$(curl -s "$UPDATE_URL")

if [ "$RESPONSE" == "OK" ]; then
    echo "✅ DNS updated: $DOMAIN -> $CURRENT_IP"
else
    echo "❌ DNS update failed: $RESPONSE"
fi
SCRIPT_EOF

chmod +x "$UPDATE_SCRIPT"
echo "✅ Created auto-update script: $UPDATE_SCRIPT"
echo ""

# Create cron job suggestion
echo "═══════════════════════════════════════════════════════"
echo "⏰ AUTO-UPDATE SETUP"
echo "═══════════════════════════════════════════════════════"
echo ""
echo "To automatically update DNS when IP changes, add to crontab:"
echo ""
echo "  crontab -e"
echo ""
echo "Add this line (updates every 5 minutes):"
echo ""
echo "  */5 * * * * $UPDATE_SCRIPT >> /tmp/dns-update.log 2>&1"
echo ""
echo "Or run manually:"
echo "  $UPDATE_SCRIPT"
echo ""

echo "✅ Setup complete!"
echo ""
echo "Your permanent URL: http://${DUCKDNS_DOMAIN}:8080"
echo "(Make sure port forwarding is configured on your router)"

