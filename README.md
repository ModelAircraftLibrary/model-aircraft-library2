# Model Aircraft Library — PWA

This folder is ready to publish as a small static website/PWA.

## Files
- `index.html` — the aircraft collection app
- `manifest.webmanifest` — Home Screen/PWA settings
- `service-worker.js` — offline caching
- `icons/` — iPhone/iPad/Home Screen icons

## Important storage note
Collection data and photos are stored locally in the browser using IndexedDB (with browser-storage fallback).
That means an iPhone and iPad will each have their own separate collection unless you export a backup from one device and import it on the other.

Use **Fields & Backup → Export Backup (.json)** regularly.

## GitHub Pages
Upload all files and folders in this package to a GitHub repository, enable GitHub Pages, then open the resulting HTTPS address in Safari.

On iPhone/iPad:
1. Open the published site in Safari.
2. Tap Share.
3. Choose **Add to Home Screen**.
4. Turn on **Open as Web App** if iOS presents that option.
5. Tap Add.

After installation, launch it from the Home Screen.
