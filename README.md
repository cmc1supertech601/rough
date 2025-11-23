# SNS Automation Website

A modern, professional website for SNS Automation - Industrial Automation Solutions.

## Features

- **Homepage**: Hero section, services overview, and company information
- **Services Page**: Detailed information about PLC automation services including:
  - PLC Automation Debugging
  - Production Line Setup using PLC Automation
  - System Integration
  - Custom Program Development
  - Maintenance & Support
  - Training & Consultation
- **Contact Page**: Contact form with email, phone, address, and business hours
- **Responsive Design**: Fully responsive and mobile-friendly
- **Modern UI**: Clean, professional design inspired by industry-leading automation companies

## File Structure

```
snsAutomation/
├── index.html          # Homepage
├── services.html       # Services page
├── contact.html        # Contact page
├── styles.css          # Main stylesheet
├── script.js           # JavaScript for interactivity
└── README.md           # This file
```

## Getting Started

### Running Locally

#### Option 1: Using Python (Recommended)

If you have Python installed:

```bash
# Python 3
python3 -m http.server 8000

# Or Python 2
python -m SimpleHTTPServer 8000
```

Then open your browser and visit: `http://localhost:8000`

#### Option 2: Using Node.js (if you have it installed)

```bash
# Install http-server globally (one time)
npm install -g http-server

# Run the server
http-server -p 8000
```

Then open your browser and visit: `http://localhost:8000`

#### Option 3: Using PHP

```bash
php -S localhost:8000
```

#### Option 4: Simple Double-Click (Limited)

You can double-click `index.html` to open it in your browser, but some features may not work correctly due to browser security restrictions.

### Deploying to the Public

#### Option 1: GitHub Pages (Free & Easy)

1. Create a GitHub account if you don't have one
2. Create a new repository (e.g., `sns-automation-website`)
3. Upload all your files to the repository
4. Go to Settings → Pages
5. Select the branch (usually `main` or `master`)
6. Your site will be live at: `https://yourusername.github.io/sns-automation-website`

#### Option 2: Netlify (Free & Very Easy)

1. Go to [netlify.com](https://www.netlify.com) and sign up
2. Drag and drop your project folder onto Netlify
3. Your site will be live instantly with a free `.netlify.app` domain
4. You can add a custom domain later

#### Option 3: Vercel (Free & Fast)

1. Go to [vercel.com](https://vercel.com) and sign up
2. Install Vercel CLI: `npm i -g vercel`
3. In your project folder, run: `vercel`
4. Follow the prompts
5. Your site will be live instantly

#### Option 4: Cloudflare Pages (Free)

1. Go to [cloudflare.com](https://www.cloudflare.com) and sign up
2. Go to Pages → Create a project
3. Connect your GitHub repository or upload files
4. Your site will be live with a free `.pages.dev` domain

#### Option 5: Traditional Web Hosting

Upload your files via FTP to any web hosting service (Bluehost, HostGator, etc.)

## Customization

### Update Contact Information

Edit the contact information in:
- `contact.html` - Contact page details
- `index.html` - Footer contact info
- `services.html` - Footer contact info

### Update Services

Modify service descriptions in:
- `index.html` - Services overview section
- `services.html` - Detailed services page

### Colors and Styling

Edit CSS variables in `styles.css`:
```css
:root {
    --primary-color: #0066cc;
    --secondary-color: #004499;
    --accent-color: #ff6600;
    /* ... */
}
```

## Browser Support

- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)

## Notes

- The contact form currently shows a success message on submission. To make it functional, you'll need to add backend form handling.
- Phone numbers can be updated in the contact sections of each HTML file.
- Email addresses can be updated throughout the site.

## License

© 2025 SNS Automation | All Rights Reserved

