# Al-Quds website

Static site (no build step) + Supabase (login, database, image storage). Backend is already set up.

## Go live (Vercel via GitHub)
1. Push this folder to a GitHub repository (files at the repo root).
2. Vercel → Add New → Project → import the repo. Framework preset: **Other**. No build command, no output directory.
3. Deploy. Your site is live; the admin is at `/#admin`.

## Search and AI discovery files
- `robots.txt` tells search crawlers which paths they may visit and points to the sitemap.
- `sitemap.xml` identifies the public site URL.
- `ai.txt` and `llms.txt` give AI systems a concise public summary of the business.
- `404.html` provides a not-found page.
- `.well-known/security.txt` gives security contact information.
- `site.webmanifest` provides basic install metadata.
- `favicon.svg` is the Al-Quds favicon.

Google Search Console: add the Vercel domain, verify ownership, submit `/sitemap.xml`, and add the final domain as the `Site URL` in Supabase if authentication redirects are used.

## Create the admin login (one time)
1. Supabase dashboard → Authentication → Users → **Add user** (email + strong password, auto-confirm).
2. Authentication → Sign In / Providers → Email → turn **off** "Allow new users to sign up".
3. SQL Editor, run (with the real email):
   `insert into public.admins (user_id) select id from auth.users where email = 'CLIENT_EMAIL_HERE';`
4. Authentication → URL Configuration → set Site URL to your Vercel domain.

Only users listed in `public.admins` can add/edit/delete listings, change settings or upload images — enforced by database rules.

## Required images
Place downloaded images in `assets/images/` using plain numbered names such as `1.jpg`, `2.jpg`, or `1.png`. Do not rename with duplicate labels such as `(1)` or copy filenames.

| File | Purpose | Required size | Quantity |
|---|---|---:|---:|
| `1.jpg` | Social sharing/default page preview | 1200 × 630 px | 1 |
| `2.jpg` | Home hero/background | 1920 × 1080 px | 1 |
| `3.jpg` | Buy page banner | 1920 × 900 px | 1 |
| `4.jpg` | Rent page banner | 1920 × 900 px | 1 |
| `5.jpg` | Stays and events banner | 1920 × 900 px | 1 |
| `6.jpg` | Construction banner | 1920 × 900 px | 1 |
| `7.jpg` | Calculator banner | 1920 × 900 px | 1 |
| `8.jpg` | Contact banner | 1920 × 900 px | 1 |
| Listing photos | Property cards and galleries | 1600 × 900 px | 3–8 per listing |

Keep each file under about 500 KB where possible. Export JPG at 80–85% quality, and convert oversized PNG photos to JPG. Use original or commercially licensed real estate photos only. Listing photos can be uploaded directly from the admin panel, while page banners can be mapped in `config.js` or uploaded there.

## Banner photo code template
Use one or more of these entries after downloading the matching files:

```js
banners: {
  home: "assets/images/2.jpg",
  sale: "assets/images/3.jpg",
  rent: "assets/images/4.jpg",
  stay: "assets/images/5.jpg",
  construction: "assets/images/6.jpg",
  calc: "assets/images/7.jpg",
  contact: "assets/images/8.jpg"
}
```

The files in `assets/images/` should be committed to Git. Photos uploaded in the admin panel take priority over these local templates.

## Admin sessions
The admin signs out automatically when they leave the admin page, close the tab, or after 15 minutes of inactivity.
