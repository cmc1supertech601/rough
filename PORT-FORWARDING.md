# Port Forwarding Guide - Expose Website Publicly

This guide shows you how to run your website locally and expose it to the public internet.

## 🚀 Quick Start Options

### Option 1: ngrok (Recommended - Most Popular)

**Pros:** Free tier, HTTPS, custom domains (paid), reliable

**Setup:**

1. **Install ngrok:**
   ```bash
   # macOS (using Homebrew)
   brew install ngrok/ngrok/ngrok
   
   # Or download from https://ngrok.com/download
   ```

2. **Sign up for free account:**
   - Go to https://ngrok.com
   - Sign up (free)
   - Get your authtoken from dashboard

3. **Configure ngrok:**
   ```bash
   ngrok config add-authtoken YOUR_AUTH_TOKEN
   ```

4. **Run the script:**
   ```bash
   ./expose-public.sh
   ```

   Or manually:
   ```bash
   # Terminal 1: Start local server
   python3 -m http.server 8000
   
   # Terminal 2: Start ngrok
   ngrok http 8000
   ```

5. **Access your site:**
   - ngrok will give you a URL like: `https://abc123.ngrok.io`
   - Share this URL with anyone!
   - The URL changes each time (unless you have a paid plan)

---

### Option 2: localtunnel (No Signup Required)

**Pros:** Free, no signup, easy to use

**Setup:**

1. **Make sure Node.js is installed:**
   ```bash
   # Check if installed
   node --version
   
   # If not, install from https://nodejs.org/
   ```

2. **Run the script:**
   ```bash
   ./expose-public-alt.sh
   ```

   Or manually:
   ```bash
   # Terminal 1: Start local server
   python3 -m http.server 8000
   
   # Terminal 2: Start tunnel
   npx localtunnel --port 8000
   ```

3. **Access your site:**
   - You'll get a URL like: `https://random-name.loca.lt`
   - Share this URL!

---

### Option 3: Cloudflare Tunnel (Free & Permanent)

**Pros:** Free, permanent URL, no port forwarding needed

**Setup:**

1. **Install cloudflared:**
   ```bash
   # macOS
   brew install cloudflared
   
   # Or download from https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/installation/
   ```

2. **Run tunnel:**
   ```bash
   # Terminal 1: Start local server
   python3 -m http.server 8000
   
   # Terminal 2: Start Cloudflare tunnel
   cloudflared tunnel --url http://localhost:8000
   ```

3. **Access your site:**
   - You'll get a URL like: `https://random-name.trycloudflare.com`
   - This URL stays the same!

---

### Option 4: Router Port Forwarding (Advanced)

**Pros:** Direct access, no third-party service

**Cons:** Requires router access, less secure, dynamic IP issues

**Steps:**

1. **Find your local IP:**
   ```bash
   # macOS/Linux
   ifconfig | grep "inet "
   
   # You'll see something like: 192.168.1.100
   ```

2. **Configure Router:**
   - Access router admin (usually `192.168.1.1` or `192.168.0.1`)
   - Go to Port Forwarding/Virtual Server settings
   - Forward external port (e.g., 8080) to internal IP:8000
   - Protocol: TCP

3. **Find your public IP:**
   ```bash
   curl ifconfig.me
   # Or visit: https://whatismyipaddress.com
   ```

4. **Start local server:**
   ```bash
   python3 -m http.server 8000
   ```

5. **Access from internet:**
   - Use: `http://YOUR_PUBLIC_IP:8080`
   - **Warning:** This exposes your local network - use firewall!

---

## 📋 Comparison Table

| Method | Free | Signup | HTTPS | Permanent URL | Ease |
|--------|------|--------|-------|---------------|------|
| ngrok | ✅ | ✅ | ✅ | ❌ (paid) | ⭐⭐⭐⭐⭐ |
| localtunnel | ✅ | ❌ | ✅ | ❌ | ⭐⭐⭐⭐ |
| Cloudflare Tunnel | ✅ | ❌ | ✅ | ✅ | ⭐⭐⭐⭐ |
| Router Port Forward | ✅ | ❌ | ❌ | ✅ | ⭐⭐ |

---

## 🎯 Recommended: ngrok

**Best for:** Quick testing, demos, sharing with clients

**Quick Start:**
```bash
# 1. Install
brew install ngrok/ngrok/ngrok

# 2. Sign up at ngrok.com and get authtoken

# 3. Configure
ngrok config add-authtoken YOUR_TOKEN

# 4. Run
./expose-public.sh
```

---

## 🔒 Security Notes

⚠️ **Important Security Considerations:**

1. **Temporary URLs:** Most free services give temporary URLs that change
2. **HTTPS:** Services like ngrok provide HTTPS automatically
3. **Firewall:** Router port forwarding exposes your network - be careful!
4. **Local Network:** Only expose what's necessary
5. **Production:** For permanent sites, use proper hosting (GitHub Pages, Netlify, etc.)

---

## 🛠️ Troubleshooting

### Port Already in Use:
```bash
# Use a different port
python3 -m http.server 8080
ngrok http 8080
```

### ngrok Not Found:
```bash
# Add to PATH or use full path
/usr/local/bin/ngrok http 8000
```

### Connection Refused:
- Make sure local server is running first
- Check firewall settings
- Try a different port

### URL Not Working:
- Wait a few seconds for tunnel to establish
- Check if local server is running
- Try restarting the tunnel

---

## 📝 Example Workflow

**For Quick Testing/Demos:**

1. Start local server: `python3 -m http.server 8000`
2. Start ngrok: `ngrok http 8000`
3. Share the ngrok URL with your client
4. When done, press Ctrl+C to stop both

**For Permanent Deployment:**

Use GitHub Pages, Netlify, or Vercel instead (see DEPLOYMENT.md)

---

## 💡 Pro Tips

1. **Keep it running:** Don't close the terminal while sharing the URL
2. **Test first:** Always test the public URL yourself before sharing
3. **Use HTTPS:** Prefer services that provide HTTPS (ngrok, localtunnel)
4. **For production:** Use proper hosting, not port forwarding
5. **Monitor usage:** Free tiers have limits - check your usage

---

## 🆘 Need Help?

- **ngrok Docs:** https://ngrok.com/docs
- **localtunnel:** https://github.com/localtunnel/localtunnel
- **Cloudflare Tunnel:** https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/

---

## ✅ Quick Command Reference

```bash
# Start local server
python3 -m http.server 8000

# ngrok (after setup)
ngrok http 8000

# localtunnel (no setup)
npx localtunnel --port 8000

# Cloudflare tunnel
cloudflared tunnel --url http://localhost:8000

# Or use our scripts
./expose-public.sh        # ngrok
./expose-public-alt.sh    # localtunnel
```

