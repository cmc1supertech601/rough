# Deployment Guide for SNS Automation Website

This guide will help you deploy your website to the public internet.

## Quick Start - Local Testing

### macOS/Linux:
```bash
./start-server.sh
```

### Windows:
Double-click `start-server.bat`

### Manual Start:
```bash
# Python 3
python3 -m http.server 8000

# Or Python 2
python -m SimpleHTTPServer 8000
```

Then visit: **http://localhost:8000**

---

## 🚀 Deploying to the Public

### Option 1: GitHub Pages (Recommended - Free)

**Pros:** Free, reliable, easy to set up, custom domain support

**Steps:**

1. **Create a GitHub account** (if you don't have one)
   - Go to [github.com](https://github.com) and sign up

2. **Create a new repository**
   - Click the "+" icon → "New repository"
   - Name it: `sns-automation-website`
   - Make it **Public**
   - Click "Create repository"

3. **Upload your files**
   ```bash
   # If you have Git installed:
   cd /Users/harmanattal/Documents/ajay-workspace/snsAutomation
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/sns-automation-website.git
   git push -u origin main
   ```
   
   Or use GitHub Desktop app to drag and drop your files

4. **Enable GitHub Pages**
   - Go to your repository on GitHub
   - Click **Settings** → **Pages** (left sidebar)
   - Under "Source", select **main** branch
   - Click **Save**
   - Wait 1-2 minutes

5. **Your site is live!**
   - Visit: `https://YOUR_USERNAME.github.io/sns-automation-website`
   - Example: `https://johnsmith.github.io/sns-automation-website`

**Custom Domain:** Add a `CNAME` file in your repo with your domain name

---

### Option 2: Netlify (Easiest - Free)

**Pros:** Drag & drop, instant deployment, free SSL, custom domains

**Steps:**

1. Go to [netlify.com](https://www.netlify.com) and sign up

2. **Drag & Drop Method:**
   - Drag your entire `snsAutomation` folder onto Netlify
   - Your site is live instantly!
   - You'll get a URL like: `https://random-name-123.netlify.app`

3. **Git Method (for updates):**
   - Connect your GitHub repository
   - Every time you push changes, site auto-updates

**Custom Domain:**
- Go to Site settings → Domain management
- Add your custom domain
- Update DNS records as instructed

---

### Option 3: Vercel (Fast & Free)

**Pros:** Very fast, great for static sites, free SSL

**Steps:**

1. Go to [vercel.com](https://vercel.com) and sign up

2. **Using CLI:**
   ```bash
   npm install -g vercel
   cd /Users/harmanattal/Documents/ajay-workspace/snsAutomation
   vercel
   ```
   - Follow the prompts
   - Your site will be live in seconds!

3. **Using Web Interface:**
   - Click "Add New Project"
   - Import from GitHub or upload files
   - Deploy!

---

### Option 4: Cloudflare Pages (Free)

**Pros:** Free, fast CDN, great performance

**Steps:**

1. Go to [cloudflare.com](https://www.cloudflare.com) and sign up
2. Go to **Pages** → **Create a project**
3. Connect your GitHub repository or upload files
4. Your site will be live with a `.pages.dev` domain

---

### Option 5: Traditional Web Hosting

**For services like:** Bluehost, HostGator, GoDaddy, etc.

**Steps:**

1. Purchase a hosting plan
2. Get FTP credentials from your host
3. Use an FTP client (FileZilla, Cyberduck) to upload files
4. Upload all files to the `public_html` or `www` folder
5. Your site will be live at your domain

---

## 📝 Important Notes

### Before Deploying:

1. **Test locally first** - Make sure everything works
2. **Check all links** - Ensure navigation works
3. **Test on mobile** - Use browser dev tools
4. **Verify contact info** - Make sure email/phone are correct

### After Deploying:

1. **Test the live site** - Check all pages
2. **Set up custom domain** (optional)
3. **Submit to Google Search Console** (for SEO)
4. **Share your URL!**

---

## 🔧 Troubleshooting

### Local Server Issues:

**Port already in use:**
```bash
# Use a different port
python3 -m http.server 8080
```

**Can't find Python:**
- Install from [python.org](https://www.python.org/downloads/)
- Or use Node.js: `npm install -g http-server && http-server`

### Deployment Issues:

**GitHub Pages not updating:**
- Wait 5-10 minutes
- Clear browser cache
- Check repository settings

**404 errors:**
- Make sure `index.html` is in the root folder
- Check file names (case-sensitive on some servers)

---

## 📞 Need Help?

- **GitHub Pages Docs:** https://docs.github.com/pages
- **Netlify Docs:** https://docs.netlify.com
- **Vercel Docs:** https://vercel.com/docs

---

## 🎉 Recommended: GitHub Pages

For your use case, **GitHub Pages** is recommended because:
- ✅ Completely free
- ✅ Easy to set up
- ✅ Reliable and fast
- ✅ Supports custom domains
- ✅ Easy to update (just push changes)
- ✅ No credit card required

Your website will be live in about 5 minutes!

