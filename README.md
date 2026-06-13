# sovereign-blog

**E5 Enclave — Sovereign Intelligence.** A Hugo publication for E5 Enclave editorial content (sovereign AI, the mesh, research notes).

## Stack
Hugo 0.147.1 · Cloudflare Pages · RSS + JSON feeds. Posts live in `content/posts/` (e.g. the "Building a Sovereign AI Mesh" series).

## Build & deploy
```bash
hugo   # → public/
```
Deploy: Cloudflare Pages, auto-deploy on push to `master`. Env: `HUGO_VERSION=0.147.1`, `HUGO_ENV=production`.

## ⚠️ Before launch
`theme = ""` is unset — ensure `layouts/` cover every required template, or add a theme, or the build will error.

## Status
Active (real content); deploy pending theme/layout confirmation.
