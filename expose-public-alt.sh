#!/bin/bash

# Alternative script using localtunnel (no signup required)

echo "🌐 SNS Automation Website - Public Access (Alternative)"
echo "========================================================="
echo ""

# Check if Node.js/npm is installed
if ! command -v npx &> /dev/null; then
    echo "❌ Node.js/npm is not installed!"
    echo ""
    echo "📥 Please install Node.js from: https://nodejs.org/"
    echo ""
    exit 1
fi

# Check if Python is available for local server
if command -v python3 &> /dev/null; then
    SERVER_CMD="python3 -m http.server 8000"
elif command -v python &> /dev/null; then
    SERVER_CMD="python -m SimpleHTTPServer 8000"
elif command -v php &> /dev/null; then
    SERVER_CMD="php -S localhost:8000"
else
    echo "❌ No suitable server found!"
    echo "Please install Python or PHP"
    exit 1
fi

echo "✅ Starting local server on port 8000..."
echo ""

# Start local server in background
$SERVER_CMD > /dev/null 2>&1 &
SERVER_PID=$!

# Wait a moment for server to start
sleep 2

echo "✅ Local server running at http://localhost:8000"
echo ""
echo "🌍 Starting public tunnel (localtunnel)..."
echo "   (This may take a few seconds)"
echo ""

# Start localtunnel
npx localtunnel --port 8000

# Cleanup function
cleanup() {
    echo ""
    echo "🛑 Stopping servers..."
    kill $SERVER_PID 2>/dev/null
    echo "✅ Servers stopped"
    exit 0
}

# Trap Ctrl+C
trap cleanup SIGINT SIGTERM

# Keep script running
wait

