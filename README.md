# Model Aircraft Library — PWA

An installable, offline-first model aircraft collection manager. Data is always saved locally first. Optional Supabase account sync keeps the same collection on an iPhone and iPad, while JSON and CSV exports remain available.

## Privacy

The GitHub Pages website and its source code are public. Synced collection data is private: Supabase Authentication identifies the owner, and Row Level Security permits each signed-in account to access only its own row. The Supabase publishable/anon key is intentionally safe to use in browser code when the included policies are installed. Do not use or paste a Supabase `service_role` or secret key into the app.

A password gate added directly to GitHub Pages would not be secure because its code and password check would be downloadable. Account authentication plus database Row Level Security is the security boundary.

## One-time Supabase setup

1. Create a free project at https://supabase.com/dashboard.
2. Open **SQL Editor**, create a query, paste all of `supabase-setup.sql`, and press **Run**.
3. Open **Project Settings → API** (in some dashboard versions, **Connect → App Frameworks**).
4. Copy the **Project URL** and the **publishable key**. A legacy `anon` key also works. Never use the `service_role` or secret key.
5. Optional: under **Authentication → Providers → Email**, decide whether new accounts must confirm their email. Leaving confirmation enabled is more secure.

## Connect the two devices

1. Open the app on the first device and go to **Fields & Backup → iPhone & iPad Sync**.
2. Paste the same Project URL and publishable/anon key, enter an email and a strong password, then choose **Create Account**.
3. If email confirmation is enabled, open the confirmation email and then return to the app and choose **Sign In**.
4. On the second device, enter the same Project URL, key, email, and password, then choose **Sign In**.
5. Use **Sync Now** once on each device. After that, saves, edits, deletes, imported backups, and field changes sync automatically. A visible app checks for incoming changes about every 15 seconds and also syncs when it returns online or becomes active.

If both devices change the same model while offline, the most recently edited version wins. Changes to different models are merged. Deleted models are tracked so they are also removed from the other device.

## Offline storage and backups

The app uses IndexedDB locally, with browser-storage fallbacks. It remains usable without an internet connection and queues the current state for the next sync opportunity. Sync is not a replacement for backup: regularly use **Export Backup (.json)**. Import and CSV export continue to work without sync.

Photos are resized before storage and are included in both backups and sync. Large photo collections count toward the Supabase project database quota.

## GitHub Pages

Publish the repository from the `main` branch and repository root. On iPhone/iPad, open the HTTPS Pages address in Safari and choose **Share → Add to Home Screen**.
