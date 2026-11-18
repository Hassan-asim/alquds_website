// Public values only (safe to commit). Security is enforced by the database rules (RLS), not by hiding this key.
window.ALQUDS_CONFIG = {
  supabaseUrl: "https://rwtuaaalynqqrcibxeej.supabase.co",
  supabaseAnonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJ3dHVhYWFseW5xcXJjaWJ4ZWVqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTQ2MzcwMDEsImV4cCI6MjExMDIxMzAwMX0.Z9y-2-o7OFBHecB74wTM6LHmcfUMFM_x0zL6y4w0dW4",
  // Optional page banner photos. Put image files in an "assets" folder in this repo and list them here,
  // e.g. banners: { home: "assets/home.jpg", sale: "assets/buy.jpg" }  — or use one photo for all pages: banner: "assets/banner.jpg".
  // Photos uploaded in the admin panel (Site text tab) take priority over these.
  banners: {
    home: "assets/images/2.jpg",
    sale: "assets/images/3.jpg",
    rent: "assets/images/5.jpg",
    stay: "assets/images/11.jpg",
    construction: "assets/images/4.jpg",
    calc: "assets/images/8.jpg",
    contact: "assets/images/2.jpg",
    admin: "assets/images/1.jpg"
  }
};
