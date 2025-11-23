#!/bin/bash
# Auto-update script for DuckDNS
# This script updates your DuckDNS domain with your current public IP

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
    echo "[$(date)] ✅ DNS updated: $DOMAIN -> $CURRENT_IP"
else
    echo "[$(date)] ❌ DNS update failed: $RESPONSE"
    exit 1
fi

