@echo off
REM Simple HTTP Server Script for SNS Automation Website (Windows)
REM This script helps you run the website locally

echo.
echo Starting SNS Automation Website Server...
echo.

REM Check if Python 3 is available
python --version >nul 2>&1
if %errorlevel% == 0 (
    echo Using Python
    echo Server starting at http://localhost:8000
    echo Open this URL in your browser
    echo.
    echo Press Ctrl+C to stop the server
    echo.
    python -m http.server 8000
    goto :end
)

REM Check if PHP is available
php --version >nul 2>&1
if %errorlevel% == 0 (
    echo Using PHP
    echo Server starting at http://localhost:8000
    echo Open this URL in your browser
    echo.
    echo Press Ctrl+C to stop the server
    echo.
    php -S localhost:8000
    goto :end
)

echo No suitable server found!
echo.
echo Please install one of the following:
echo   - Python: https://www.python.org/downloads/
echo   - PHP: https://www.php.net/downloads.php
echo.
echo Or use Node.js:
echo   npm install -g http-server
echo   http-server -p 8000
echo.

:end
pause

