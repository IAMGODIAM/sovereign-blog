# Cloudflare Pages Configuration

## Build Settings
- **Framework preset:** Hugo
- **Build command:** `hugo`
- **Build output directory:** `public`
- **Root directory:** `/` (repo root)

## Environment Variables
- `HUGO_VERSION`: `0.147.1`
- `HUGO_ENV`: `production`

## Custom Domain
- Primary: `e5enclave.com/blog/` (requires path rewrite or subdomain)
- Alternative: `blog.e5enclave.com` (subdomain, easier setup)

## Deploy Trigger
- Auto-deploy on push to `master` branch

## Setup Steps
1. Go to Cloudflare Dashboard → Pages → Create a project
2. Connect to GitHub repo: `IAMGODIAM/sovereign-blog`
3. Set build settings as above
4. Deploy

First deploy creates the URL: `sovereign-blog.pages.dev`
Custom domain configured after initial deploy.
