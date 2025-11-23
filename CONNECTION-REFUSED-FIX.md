# 🔴 ERR_CONNECTION_REFUSED - Complete Fix Guide

## ❌ Current Error

```
ERR_CONNECTION_REFUSED
snsautomation.duckdns.org refused to connect
```

This means your router is **actively refusing** the connection, not just timing out.

---

## 🔍 Root Cause

Based on diagnostics, your router port forwarding rule is still configured as:
- **External Port: 8000** ❌ (Should be 8080)
- **Internal Port: 8000** ✅
- **You're accessing: Port 8080** ❌

**The ports don't match!** The router is refusing connections on port 8080 because it's only forwarding port 8000.

---

## ✅ Step-by-Step Fix

### Step 1: Access Router Admin Panel

1. Open browser
2. Go to: **http://192.168.2.1**
3. Login with admin credentials

### Step 2: Find and Edit Port Forwarding Rule

1. Navigate to **"Port forwarding"** section
2. Find the rule named **"sns"** (or "SNS Automation")
3. Click the **Edit** button (pencil icon ✏️)

### Step 3: Update the Rule

**Change these settings:**

```
Name:              sns (or SNS Automation)
Status:            ON ✅
Protocol:          Both (or TCP)
External Port:     8080 - 8080    ← CHANGE FROM 8000 TO 8080
Internal Port:     8000 - 8000    ← KEEP AS 8000
Local IP address:  192.168.2.12   ← VERIFY THIS IS CORRECT
```

**Critical Points:**
- External port **MUST** be **8080** (not 8000)
- Internal port stays **8000**
- Verify the Local IP matches your Mac's current IP: `192.168.2.12`

### Step 4: Save and Apply

1. Click **"Save"** or **"Apply"**
2. Wait **2-3 minutes** for router to restart
3. Don't close the router admin page yet

### Step 5: Verify Rule is Active

1. Refresh the port forwarding page
2. Confirm the rule shows:
   - External Port: **8080**
   - Status: **ON**
   - Internal IP: **192.168.2.12**

---

## 🧪 Testing After Fix

### Test 1: Local Connection (Should Work)
```bash
curl http://localhost:8000
```
✅ Should return HTML

### Test 2: Network Connection (Should Work)
```bash
curl http://192.168.2.12:8000
```
✅ Should return HTML

### Test 3: Public IP Direct (Test This After Fix)
```bash
curl http://207.161.65.171:8080
```
✅ Should return HTML (if port forwarding works)

### Test 4: Domain Name (Test This After Fix)
```bash
curl http://snsautomation.duckdns.org:8080
```
✅ Should return HTML (if DNS and port forwarding work)

---

## 🔧 Additional Troubleshooting

### Issue: Rule Still Not Working After Update

**Check 1: Router Firewall**
- Some routers have a separate firewall that blocks forwarded ports
- Look for "Firewall" → "Port Forwarding" or "DMZ" settings
- Temporarily disable firewall to test (then re-enable)

**Check 2: ISP Blocking**
- Some ISPs block common ports (80, 443, 8080, etc.)
- Try a different external port (e.g., 9000, 10000)
- Update router rule to use the new port

**Check 3: Router Needs Full Restart**
- After saving, unplug router for 30 seconds
- Plug back in and wait 2-3 minutes
- Test again

**Check 4: Verify Mac IP Didn't Change**
```bash
ifconfig | grep "inet " | grep -v 127.0.0.1
```
- If IP changed, update router rule with new IP

**Check 5: macOS Firewall**
```bash
# Check firewall status
/usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate

# If enabled, allow Python
/usr/libexec/ApplicationFirewall/socketfilterfw --add /opt/homebrew/bin/python3
/usr/libexec/ApplicationFirewall/socketfilterfw --unblockapp /opt/homebrew/bin/python3
```

---

## 🎯 Quick Verification Checklist

After updating the router, verify:

- [ ] Router rule shows External Port: **8080**
- [ ] Router rule shows Internal Port: **8000**
- [ ] Router rule shows Internal IP: **192.168.2.12**
- [ ] Router rule Status: **ON**
- [ ] Waited 2-3 minutes after saving
- [ ] Server is running: `lsof -ti:8000`
- [ ] Local test works: `curl http://localhost:8000`
- [ ] Network test works: `curl http://192.168.2.12:8000`
- [ ] Public IP test: `curl http://207.161.65.171:8080`
- [ ] Domain test: `curl http://snsautomation.duckdns.org:8080`

---

## 🚨 If Still Not Working

### Option 1: Try Different External Port

Some ISPs block port 8080. Try port 9000:

1. Update router rule:
   - External Port: **9000**
   - Internal Port: **8000**

2. Access via: `http://snsautomation.duckdns.org:9000`

### Option 2: Check Router Logs

1. Go to router admin → Logs
2. Look for blocked/denied connections
3. This will show if firewall is blocking

### Option 3: Test from Different Network

1. Use mobile data (not WiFi)
2. Try accessing: `http://207.161.65.171:8080`
3. If this works, the issue is with your local network/router
4. If this doesn't work, the issue is with port forwarding or ISP

### Option 4: Use Tunnel (Bypass Router)

If port forwarding continues to fail, use a tunnel:

```bash
cd /Users/harmanattal/Documents/ajay-workspace/snsAutomation
npx -y localtunnel --port 8000
```

This gives you a URL like `https://xxxxx.loca.lt` that works immediately without router configuration.

---

## 📋 Expected Router Configuration

**Bell Giga Hub Port Forwarding Rule:**

```
┌─────────────────────────────────────────┐
│ Name:              sns                  │
│ Status:            ON                    │
│ Protocol:          Both                  │
│ External Port:     8080 - 8080           │ ← MUST BE 8080
│ Internal Port:    8000 - 8000           │ ← MUST BE 8000
│ Local IP:          192.168.2.12          │ ← Your Mac's IP
│ Created by:        User                  │
└─────────────────────────────────────────┘
```

---

## 🎯 Summary

**The fix is simple but critical:**

1. ✅ Go to router admin: http://192.168.2.1
2. ✅ Find port forwarding rule "sns"
3. ✅ Change External Port from **8000** to **8080**
4. ✅ Save and wait 2-3 minutes
5. ✅ Test: `http://snsautomation.duckdns.org:8080`

**After this fix, your website should be accessible!** 🎉

---

## 🆘 Still Need Help?

Run the diagnostic script:
```bash
cd /Users/harmanattal/Documents/ajay-workspace/snsAutomation
./diagnose-connection.sh
```

This will show you exactly what's wrong and what to fix.

