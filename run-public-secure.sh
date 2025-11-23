#!/bin/bash

# Secure version with password protection using ngrok

echo "🔒 SNS Automation Website - Secure Public Access"
echo "================================================="
echo ""

# Check if ngrok is installed
if ! command -v ngrok &> /dev/null; then
    echo "❌ ngrok is not installed!"
    echo ""
    echo "To add password protection, you need ngrok:"
    echo "  brew install ngrok/ngrok/ngrok"
    echo ""
    echo "Then sign up at https://ngrok.com (free)"
    echo "Get your authtoken and run:"
    echo "  ngrok config add-authtoken YOUR_TOKEN"
    echo ""
    exit 1
fi

# Get password from user
echo "🔐 Set up password protection"
read -sp "Enter username: " USERNAME
echo ""
read -sp "Enter password (8-128 chars): " PASSWORD
echo ""
echo ""

# Kill any existing servers on port 8000
lsof -ti:8000 | xargs kill -9 2>/dev/null

# Start local server
echo "📡 Starting local server on port 8000..."
cd "$(dirname "$0")"
python3 -m http.server 8000 > /tmp/sns-server.log 2>&1 &
SERVER_PID=$!
sleep 2

if ps -p $SERVER_PID > /dev/null; then
    echo "✅ Local server running at: http://localhost:8000"
    echo ""
else
    echo "❌ Failed to start server"
    exit 1
fi

# Start ngrok with password protection
echo "🔒 Starting secure tunnel with password protection..."
echo ""

ngrok http --auth="$USERNAME:$PASSWORD" 8000

# Cleanup
cleanup() {
    echo ""
    echo "🛑 Stopping servers..."
    kill $SERVER_PID 2>/dev/null
    lsof -ti:8000 | xargs kill -9 2>/dev/null
    pkill ngrok 2>/dev/null
    echo "✅ Stopped"
    exit 0
}

trap cleanup SIGINT SIGTERM

wait

