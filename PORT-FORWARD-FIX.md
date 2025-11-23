# 🔧 Port Forwarding Fix Guide

## ❌ Current Problem

Your website is timing out at `http://snsautomation.duckdns.org:8080/`

## 🔍 Issue Identified

Looking at your router port forwarding rule:
- **External Port:** 8000
- **Internal Port:** 8000
- **You're accessing:** Port 8080

**The ports don't match!** You need to forward external port **8080** to internal port **8000**.

---

## ✅ Solution: Update Port Forwarding Rule

### Step 1: Access Router Admin

1. Open your browser
2. Go to: `http://192.168.2.1` (or your router's IP)
3. Login with your admin credentials

### Step 2: Edit the Port Forwarding Rule

1. Find the **"Port forwarding"** section
2. Find the rule named **"sns"** (the one you created)
3. Click **Edit** (pencil icon)

### Step 3: Update the Settings

Change the rule to:
```
Name:              sns
Status:            ON
Protocol:          Both (or TCP)
External Port:     8080 - 8080    ← CHANGE THIS FROM 8000
Internal Port:     8000 - 8000    ← KEEP THIS AS 8000
Local IP address:  [Your Mac's IP]  ← Verify this is correct
```

**Important:** 
- External port must be **8080** (not 8000)
- Internal port stays **8000**
- Make sure the Local IP address matches your Mac's current IP

### Step 4: Save and Wait

1. Click **Save** or **Apply**
2. Wait 1-2 minutes for router to restart
3. Test the connection

---

## 🧪 Verify Your Setup

### Check 1: Is the Server Running?

Run this command:
```bash
cd /Users/harmanattal/Documents/ajay-workspace/snsAutomation
python3 -m http.server 8000
```

If it says "port already in use", the server is running. If not, start it.

### Check 2: Test Local Connection

Open in browser: `http://localhost:8000`

Should show your website. If not, the server isn't running.

### Check 3: Find Your Mac's Local IP

Run:
```bash
ifconfig | grep "inet " | grep -v 127.0.0.1
```

Look for something like `192.168.2.12` or `192.168.1.100`

**Make sure this IP matches the "Local IP address" in your router port forwarding rule!**

### Check 4: Test After Fix

After updating the port forwarding rule, test:

1. **Local:** `http://localhost:8000` ✅
2. **Network:** `http://[YOUR_LOCAL_IP]:8000` ✅
3. **Public:** `http://[YOUR_PUBLIC_IP]:8080` ✅
4. **Domain:** `http://snsautomation.duckdns.org:8080` ✅

---

## 🚀 Quick Start Script

Run this diagnostic script to check everything:

```bash
cd /Users/harmanattal/Documents/ajay-workspace/snsAutomation
./diagnose-connection.sh
```

This will check:
- ✅ Is server running?
- ✅ Is server listening correctly?
- ✅ Port forwarding configuration
- ✅ Network connectivity
- ✅ Firewall status

---

## 🔥 Common Issues & Fixes

### Issue 1: "Connection Timeout"

**Causes:**
- Port forwarding rule has wrong ports
- Server not running
- Wrong local IP in router
- Firewall blocking

**Fix:**
1. Verify port forwarding: External 8080 → Internal 8000
2. Check server is running: `lsof -ti:8000`
3. Verify local IP matches router rule
4. Check macOS firewall settings

### Issue 2: "Server Not Found"

**Causes:**
- Server not running
- Server only listening on localhost

**Fix:**
```bash
# Stop any existing server
lsof -ti:8000 | xargs kill -9

# Start server (Python binds to all interfaces by default)
cd /Users/harmanattal/Documents/ajay-workspace/snsAutomation
python3 -m http.server 8000
```

### Issue 3: "Works Locally But Not Publicly"

**Causes:**
- Port forwarding not configured
- Router firewall blocking
- ISP blocking incoming connections

**Fix:**
1. Double-check port forwarding rule
2. Check router firewall settings
3. Some ISPs block incoming connections (call ISP)

### Issue 4: "IP Changed"

**Causes:**
- Dynamic IP address changed
- Mac got new local IP from router

**Fix:**
1. Check current local IP: `ifconfig | grep "inet " | grep -v 127.0.0.1`
2. Update router port forwarding rule with new IP
3. Update DuckDNS if public IP changed

---

## 📋 Complete Setup Checklist

- [ ] Server is running on port 8000
- [ ] Server is accessible at `http://localhost:8000`
- [ ] Found your Mac's local IP address
- [ ] Router port forwarding rule exists
- [ ] External port is **8080** (not 8000)
- [ ] Internal port is **8000**
- [ ] Local IP in router matches your Mac's IP
- [ ] Protocol is set to "Both" or "TCP"
- [ ] Rule status is "ON"
- [ ] Saved router settings
- [ ] Waited 1-2 minutes after saving
- [ ] Tested `http://snsautomation.duckdns.org:8080`

---

## 🎯 Expected Configuration

**Router Port Forwarding:**
```
Name:              SNS Automation
Status:            ON
Protocol:          Both
External Port:     8080 - 8080
Internal Port:     8000 - 8000
Local IP:          [Your Mac's IP, e.g., 192.168.2.12]
```

**Server:**
- Running on port 8000
- Accessible at `http://localhost:8000`

**Access URLs:**
- Local: `http://localhost:8000`
- Public: `http://snsautomation.duckdns.org:8080`
- Public IP: `http://[YOUR_PUBLIC_IP]:8080`

---

## 🆘 Still Not Working?

1. **Run the diagnostic script:**
   ```bash
   ./diagnose-connection.sh
   ```

2. **Check router logs** (if available) for blocked connections

3. **Try a different external port** (e.g., 8081, 9000) to rule out ISP blocking

4. **Test from a different network** (e.g., mobile data) to rule out local network issues

5. **Check if your ISP blocks incoming connections** - some residential ISPs do this

---

## 💡 Alternative: Use Tunnel (No Router Config)

If port forwarding continues to be problematic, use a tunnel instead:

```bash
# This creates a public URL without router configuration
npx -y localtunnel --port 8000
```

This gives you a URL like `https://xxxxx.loca.lt` that works immediately.

---

**After fixing the port forwarding, your website should be accessible at:**
🌐 `http://snsautomation.duckdns.org:8080`

