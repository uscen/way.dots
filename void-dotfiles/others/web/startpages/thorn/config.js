// ============================================================================== #
// Links:                                                                         #
// ============================================================================== #
const LINKS = [
  {
    icon: "",
    name: "YouTube",
    url: "https://youtube.com",
    color: "var(--thorn-green)",
  },
  {
    icon: "",
    name: "Gmail",
    url: "https://mail.google.com/mail/u/2/#inbox",
    color: "var(--thorn-green)",
  },
  {
    icon: "",
    name: "Reddit",
    url: "https://reddit.com",
    color: "var(--thorn-green)",
  },
  {
    icon: "",
    name: "Claude",
    url: "https://claude.ai/new",
    color: "var(--thorn-green)",
  },
  {
    icon: "",
    name: "GitHub",
    url: "https://github.com",
    color: "var(--thorn-green)",
  },
  {
    icon: "",
    name: "Cloudflare",
    url: "https://dash.cloudflare.com/",
    color: "var(--ctp-mocha-peach)",
  },
];

// ============================================================================== #
// Ports:                                                                         #
// ============================================================================== #
const LOCAL_PORTS = [
  { icon: "󰎙", name: "Node", port: 5000, color: "var(--thorn-green)" },
  { icon: "", name: "Next.js", port: 3000, color: "var(--thorn-green)" },
  { icon: "", name: "Vite", port: 5173, color: "var(--thorn-green)" },
  { icon: "", name: "Astro", port: 4321, color: "var(--thorn-green)" },
  {
    icon: "",
    name: "Supabase API",
    port: 54321,
    color: "var(--thorn-green)",
  },
  {
    icon: "",
    name: "Supabase Studio",
    port: 54323,
    color: "var(--thorn-green)",
  },
];

// ============================================================================== #
// :Engines                                                                       #
// ============================================================================== #
const DEFAULT_ENGINE = "d";
const SEARCH_ENGINES = {
  g: "https://www.google.com/search?q=",
  gi: "https://www.google.com/search?tbm=isch&q=",
  gm: "https://www.google.com/maps/search/",

  d: "https://duckduckgo.com/?q=",
  di: "https://duckduckgo.com/?iax=images&ia=images&q=",

  npm: "https://www.npmjs.com/search?q=",
  yt: "https://www.youtube.com/results?search_query=",

  r: "https://www.reddit.com/search/?q=",
  c: "https://claude.ai/new?q=",

  gh: "https://github.com/search?q=",
};
