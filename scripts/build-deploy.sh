#!/bin/bash
# Sovereign Blog: Build, Deploy, and Pin
# Run after content changes to rebuild and publish

set -euo pipefail

BLOG_DIR="$(cd "$(dirname "$0")/.." && pwd)"
HUGO="${HOME}/.local/bin/hugo"

echo "=== Sovereign Blog Build Pipeline ==="
echo ""

# Step 1: Build
echo "[1/3] Building site..."
cd "$BLOG_DIR"
$HUGO --minify
echo "  Build complete."

# Step 2: Git commit and push (triggers Cloudflare auto-deploy)
echo "[2/3] Publishing to GitHub..."
git add -A
CHANGES=$(git status --porcelain)
if [ -n "$CHANGES" ]; then
    git commit -m "content: auto-publish $(date +%Y-%m-%d)"
    git push origin master
    echo "  Pushed to GitHub."
else
    echo "  No changes to commit."
fi

# Step 3: IPFS pin (if token is set)
echo "[3/3] IPFS pinning..."
if [ -n "${WEB3_STORAGE_TOKEN:-}" ]; then
    # Pin the public directory
    bash "$BLOG_DIR/scripts/pin-to-ipfs.sh" "$BLOG_DIR/public"
else
    echo "  Skipped: WEB3_STORAGE_TOKEN not set"
    echo "  Get a free token at: https://web3.storage"
fi

echo ""
echo "=== Done ==="
echo "Site: https://sovereign-blog.pages.dev (after Cloudflare setup)"
echo "GitHub: https://github.com/IAMGODIAM/sovereign-blog"
echo "JSON Feed: /feed.json"
