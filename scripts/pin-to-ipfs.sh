#!/bin/bash
# IPFS Pinning Script for Sovereign Blog
# Uses web3.storage API (free tier: 5GB)
# 
# Setup:
# 1. Get API token from https://web3.storage
# 2. Set WEB3_STORAGE_TOKEN environment variable
# 3. Run: ./pin-to-ipfs.sh <file-or-directory>

set -euo pipefail

WEB3_STORAGE_API="https://api.web3.storage"
TOKEN="${WEB3_STORAGE_TOKEN:-}"

if [ -z "$TOKEN" ]; then
    echo "ERROR: WEB3_STORAGE_TOKEN not set"
    echo "Get a free token at: https://web3.storage"
    exit 1
fi

TARGET="${1:-.}"

if [ ! -e "$TARGET" ]; then
    echo "ERROR: $TARGET not found"
    exit 1
fi

echo "Pinning $TARGET to IPFS via web3.storage..."

# Upload file or directory
if [ -d "$TARGET" ]; then
    # Directory - create a tar and upload
    TAR_FILE=$(mktemp)
    tar -cf "$TAR_FILE" -C "$(dirname "$TARGET")" "$(basename "$TARGET")"
    
    RESPONSE=$(curl -s -X POST "$WEB3_STORAGE_API/upload" \
        -H "Authorization: Bearer $TOKEN" \
        -H "Content-Type: application/octet-stream" \
        --data-binary "@$TAR_FILE")
    
    rm -f "$TAR_FILE"
else
    # Single file
    RESPONSE=$(curl -s -X POST "$WEB3_STORAGE_API/upload" \
        -H "Authorization: Bearer $TOKEN" \
        -H "Content-Type: application/octet-stream" \
        --data-binary "@$TARGET")
fi

# Parse response
CID=$(echo "$RESPONSE" | grep -o '"cid":"[^"]*"' | cut -d'"' -f4)

if [ -n "$CID" ]; then
    echo "SUCCESS: Pinned to IPFS"
    echo "CID: $CID"
    echo "Gateway: https://w3s.link/ipfs/$CID"
    echo "IPFS URL: ipfs://$CID"
else
    echo "ERROR: Failed to pin"
    echo "Response: $RESPONSE"
    exit 1
fi
