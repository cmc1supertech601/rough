#!/bin/bash
# Install automatic DNS update (runs every 5 minutes)

UPDATE_SCRIPT="/Users/harmanattal/Documents/ajay-workspace/snsAutomation/update-dns.sh"

# Check if already installed
if crontab -l 2>/dev/null | grep -q "update-dns.sh"; then
    echo "✅ Auto-update already installed in crontab"
    exit 0
fi

# Add to crontab
(crontab -l 2>/dev/null; echo "*/5 * * * * $UPDATE_SCRIPT >> /tmp/dns-update.log 2>&1") | crontab -

echo "✅ Auto-update installed!"
echo "   DNS will update every 5 minutes"
echo "   Logs: /tmp/dns-update.log"
