#!/bin/bash

# Script to run website locally and expose it publicly
# This uses ngrok for public access (recommended)

echo "🌐 SNS Automation Website - Public Access Setup"
echo "================================================"
echo ""

# Check if ngrok is installed
if ! command -v ngrok &> /dev/null; then
    echo "❌ ngrok is not installed!"
    echo ""
    echo "📥 Installing ngrok..."
    echo ""
    echo "Option 1: Install via Homebrew (macOS):"
    echo "  brew install ngrok/ngrok/ngrok"
    echo ""
    echo "Option 2: Download from https://ngrok.com/download"
    echo "  1. Go to https://ngrok.com/download"
    echo "  2. Download for macOS"
    echo "  3. Unzip and move to /usr/local/bin/"
    echo "  4. Sign up at https://dashboard.ngrok.com (free)"
    echo "  5. Get your authtoken and run: ngrok config add-authtoken YOUR_TOKEN"
    echo ""
    echo "Option 3: Use npm (if you have Node.js):"
    echo "  npm install -g ngrok"
    echo ""
    read -p "Press Enter after installing ngrok, or Ctrl+C to exit..."
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
echo "🌍 Starting ngrok tunnel..."
echo ""

# Start ngrok
ngrok http 8000

# Cleanup function
cleanup() {
    echo ""
    echo "🛑 Stopping servers..."
    kill $SERVER_PID 2>/dev/null
    pkill ngrok 2>/dev/null
    echo "✅ Servers stopped"
    exit 0
}

# Trap Ctrl+C
trap cleanup SIGINT SIGTERM

# Keep script running
wait

