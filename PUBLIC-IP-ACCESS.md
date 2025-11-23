# Accessing Website via Public IP

## 🌐 Your Public IP Address

Your public IP address is what the internet sees when you connect. This is different from your local IP (like 192.168.x.x).

---

## 📍 Current Status

**Your website is currently accessible via:**
- ✅ Local: `http://localhost:8000`
- ✅ Tunnel: `https://wicked-maps-press.loca.lt`
- ❌ Public IP: **Requires router configuration**

---

## 🔍 Finding Your Public IP

Your public IP address is: **Check the output above or run:**
```bash
curl ifconfig.me
```

**Note:** This IP may change if you have a dynamic IP (most home connections).

---

## ⚠️ Important: Public IP Access Requirements

To access your website via public IP, you need:

### 1. **Router Port Forwarding** (For External Access)

This allows people outside your network to access your website.

**Steps:**

1. **Find your router's admin IP:**
   ```bash
   # Usually one of these:
   # 192.168.1.1
   # 192.168.0.1
   # 10.0.0.1
   ```

2. **Access router admin:**
   - Open browser: `http://192.168.1.1` (or your router IP)
   - Login with admin credentials (check router label)

3. **Set up Port Forwarding:**
   - Go to "Port Forwarding" or "Virtual Server" section
   - Add rule:
     - **External Port:** 8080 (or any port you choose)
     - **Internal IP:** Your computer's local IP (e.g., 192.168.1.100)
     - **Internal Port:** 8000
     - **Protocol:** TCP
     - **Save**

4. **Find your local IP:**
   ```bash
   ifconfig | grep "inet " | grep -v 127.0.0.1
   ```

5. **Start your server:**
   ```bash
   python3 -m http.server 8000
   ```

6. **Access from internet:**
   - URL: `http://YOUR_PUBLIC_IP:8080`
   - Example: `http://123.45.67.89:8080`

---

## 🔒 Security Warning

⚠️ **Exposing your local server via public IP has security risks:**

- Your computer is directly accessible from the internet
- No HTTPS by default
- Firewall must be configured properly
- Only do this if you understand the risks

**Recommendation:** Use tunnel services (ngrok, localtunnel) or proper hosting instead.

---

## ✅ Better Alternatives

### Option 1: Keep Using Tunnel (Current - Recommended)
- ✅ Secure (HTTPS)
- ✅ No router configuration
- ✅ Easy to set up
- ✅ Works behind firewalls

**Current URL:** `https://wicked-maps-press.loca.lt`

### Option 2: Deploy to Hosting (Best for Production)
- ✅ Permanent URL
- ✅ Professional
- ✅ Secure
- ✅ No local server needed

See `DEPLOYMENT.md` for options like GitHub Pages, Netlify, etc.

---

## 🏠 Local Network Access (Same WiFi)

If you just want to access from other devices on the same network:

1. **Find your local IP:**
   ```bash
   ifconfig | grep "inet " | grep -v 127.0.0.1
   ```
   Example: `192.168.1.100`

2. **Start server:**
   ```bash
   python3 -m http.server 8000
   ```

3. **Access from other devices:**
   - URL: `http://192.168.1.100:8000`
   - Works on same WiFi network only

---

## 📋 Quick Comparison

| Method | Access | Security | Setup Difficulty |
|--------|--------|----------|-----------------|
| **Tunnel (Current)** | ✅ Internet | ✅ HTTPS | ⭐ Easy |
| **Public IP + Port Forward** | ✅ Internet | ⚠️ HTTP only | ⭐⭐⭐ Hard |
| **Local Network IP** | ⚠️ Same WiFi only | ⚠️ HTTP only | ⭐ Easy |
| **Hosting (GitHub Pages)** | ✅ Internet | ✅ HTTPS | ⭐⭐ Medium |

---

## 🎯 Recommendation

**For now:** Keep using the tunnel URL - it's secure and works great!

**For production:** Deploy to GitHub Pages or Netlify for a permanent, professional URL.

**Only use public IP if:**
- You understand the security risks
- You have proper firewall configuration
- You need direct access for specific reasons

---

## 🛠️ Quick Commands

```bash
# Find public IP
curl ifconfig.me

# Find local IP
ifconfig | grep "inet " | grep -v 127.0.0.1

# Start server (for local network access)
python3 -m http.server 8000

# Access from same network:
# http://YOUR_LOCAL_IP:8000
```

---

## ❓ FAQ

**Q: Can I access via public IP without port forwarding?**  
A: No, you need port forwarding for external access. For same network, use local IP.

**Q: Is public IP access secure?**  
A: Not as secure as HTTPS tunnels. Use proper firewall and consider HTTPS.

**Q: Why use tunnel instead?**  
A: Tunnels provide HTTPS, work behind firewalls, and are easier to set up.

---

**Your current tunnel setup is the best option for now!** 🎉

