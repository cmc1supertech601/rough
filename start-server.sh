#!/bin/bash

# Simple HTTP Server Script for SNS Automation Website
# This script helps you run the website locally

echo "🚀 Starting SNS Automation Website Server..."
echo ""

# Check if Python 3 is available
if command -v python3 &> /dev/null; then
    echo "✅ Using Python 3"
    echo "📡 Server starting at http://localhost:8000"
    echo "🌐 Open this URL in your browser"
    echo ""
    echo "Press Ctrl+C to stop the server"
    echo ""
    python3 -m http.server 8000
# Check if Python 2 is available
elif command -v python &> /dev/null; then
    echo "✅ Using Python 2"
    echo "📡 Server starting at http://localhost:8000"
    echo "🌐 Open this URL in your browser"
    echo ""
    echo "Press Ctrl+C to stop the server"
    echo ""
    python -m SimpleHTTPServer 8000
# Check if PHP is available
elif command -v php &> /dev/null; then
    echo "✅ Using PHP"
    echo "📡 Server starting at http://localhost:8000"
    echo "🌐 Open this URL in your browser"
    echo ""
    echo "Press Ctrl+C to stop the server"
    echo ""
    php -S localhost:8000
else
    echo "❌ No suitable server found!"
    echo ""
    echo "Please install one of the following:"
    echo "  - Python 3: https://www.python.org/downloads/"
    echo "  - PHP: https://www.php.net/downloads.php"
    echo ""
    echo "Or use Node.js:"
    echo "  npm install -g http-server"
    echo "  http-server -p 8000"
    exit 1
fi

