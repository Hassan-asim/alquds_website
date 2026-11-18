# Al-Quds website

Static site (no build step) + Supabase (login, database, image storage). Backend is already set up.

## Go live (Vercel via GitHub)
1. Push this folder to a GitHub repository (files at the repo root).
2. Vercel → Add New → Project → import the repo. Framework preset: **Other**. No build command, no output directory.
3. Deploy. Your site is live; the admin is at `/#admin`.

## Create the admin login (one time)
1. Supabase dashboard → Authentication → Users → **Add user** (email + strong password, auto-confirm).
2. Authentication → Sign In / Providers → Email → turn **off** "Allow new users to sign up".
3. SQL Editor, run (with the real email):
   `insert into public.admins (user_id) select id from auth.users where email = 'CLIENT_EMAIL_HERE';`
4. Authentication → URL Configuration → set Site URL to your Vercel domain.

Only users listed in `public.admins` can add/edit/delete listings, change settings or upload images — enforced by database rules.

## Banner photos
Pages show a clean gradient banner until a photo is added. Two ways to add real photos:
1. **Admin panel → Site text & contact → Page background photos** (per page, no code).
2. Or commit photos to an `assets/` folder and list them in `config.js` (`banners` / `banner`).
Use wide landscape photos (about 1920×900, under 500 KB). Only use photos you own or that are licensed for commercial use.

## Admin sessions
The admin signs out automatically when you leave the admin page, close the tab, or after 15 minutes of inactivity.
