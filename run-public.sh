#!/bin/bash

# Complete setup script - Runs server and exposes publicly

echo "🚀 SNS Automation Website - Public Access"
echo "=========================================="
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

# Start public tunnel
echo "🌍 Creating public tunnel..."
echo "   (This may take a few seconds...)"
echo ""

npx -y localtunnel --port 8000 2>&1 | while IFS= read -r line; do
    echo "$line"
    if echo "$line" | grep -qE 'https://[a-zA-Z0-9-]+\.loca\.lt'; then
        URL=$(echo "$line" | grep -oE 'https://[a-zA-Z0-9-]+\.loca\.lt')
        echo ""
        echo "═══════════════════════════════════════════════════════"
        echo "🎉 YOUR WEBSITE IS NOW PUBLIC!"
        echo "═══════════════════════════════════════════════════════"
        echo ""
        echo "📍 Public URL: $URL"
        echo ""
        echo "⚠️  IMPORTANT: First-time visitors need to click"
        echo "   'Click to continue' on the localtunnel page"
        echo ""
        echo "🔗 Share this URL with anyone!"
        echo ""
        echo "═══════════════════════════════════════════════════════"
        echo ""
        echo "Press Ctrl+C to stop the server and tunnel"
        echo ""
    fi
done

# Cleanup
cleanup() {
    echo ""
    echo "🛑 Stopping servers..."
    kill $SERVER_PID 2>/dev/null
    lsof -ti:8000 | xargs kill -9 2>/dev/null
    pkill -f localtunnel 2>/dev/null
    echo "✅ Stopped"
    exit 0
}

trap cleanup SIGINT SIGTERM

wait

