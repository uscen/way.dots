/* ============================================================================= */
/* Options:                                                                      */
/* ============================================================================= */
// Set default startup homepage: =================================================================
user_pref("browser.startup.homepage", "https://startup-page-web.vercel.app/");

// Disable the Twitter/R*ddit/Faceberg ads in the URL bar: =======================================
user_pref("browser.urlbar.suggest.topsites", false);

// Do not suggest web history in the URL bar: ====================================================
user_pref("browser.urlbar.suggest.history", false);

// Do not prefil forms: ==========================================================================
user_pref("signon.prefillForms", false);

// Do not autocomplete in the URL bar: ===========================================================
user_pref("browser.urlbar.autoFill", false);

// Enable the addition of search keywords: =======================================================
user_pref("keyword.enabled", true);

// Enable https-first: ===========================================================================
user_pref("dom.security.https_first", true);

// Allow access to http (i.e. not https) sites: ==================================================
user_pref("dom.security.https_only_mode", false);

// Keep cookies until expiration or user deletion: ===============================================
user_pref("network.cookie.lifetimePolicy", 0);

// Disable push notifications: ===================================================================
user_pref("dom.push.enabled", false);

// Disable Pocket integration: ===================================================================
user_pref("browser.pocket.enabled", false);

// Disable the pocket antifeature: ===============================================================
user_pref("extensions.pocket.enabled", false);

// Don't autodelete cookies on shutdown: =========================================================
user_pref("privacy.clearOnShutdown.cookies", false);

// Fix the issue where right mouse button instantly clicks: ======================================
user_pref("ui.context_menus.after_mouseup", true);

// Disable firefox sync and its menu entries: ====================================================
user_pref("identity.fxaccounts.enabled", false);

// Sets enhanced tracking protection to Strict: ==================================================
user_pref("browser.contentblocking.category", "strict");

// Enable custom userChrome.js: ==================================================================
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Disable Firefox View,: ========================================================================
user_pref("browser.tabs.firefox-view", false);
user_pref("browser.tabs.firefox-view-newIcon", false);
user_pref("browser.tabs.firefox-view-next", false);

// Reduce disk writes: ===========================================================================
user_pref("browser.cache.disk.enable", false);
user_pref("browser.privatebrowsing.forceMediaMemoryCache", true);
user_pref("media.memory_cache_max_size", 65536);
user_pref("browser.sessionstore.interval", 60000);

// Make fullscreen instant: ======================================================================
user_pref("full-screen-api.transition-duration.enter", "0 0");
user_pref("full-screen-api.transition-duration.leave", "0 0");
user_pref("full-screen-api.warning.delay", -1);
user_pref("full-screen-api.warning.timeout", 0);

// Clean up the new tab page: ====================================================================
user_pref("browser.newtabpage.activity-stream.default.sites", "");
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredCheckboxes", false);

// Disable AI features: ==========================================================================
user_pref("browser.ai.control.default", "blocked");
user_pref("browser.ml.enable", false);
user_pref("browser.ml.chat.enabled", false);
user_pref("browser.ml.chat.menu", false);
user_pref("browser.tabs.groups.smart.enabled", false);
user_pref("browser.ml.linkPreview.enabled", false);

// Reduce UI annoyances: =========================================================================
user_pref("ui.key.menuAccessKeyFocuses", false);
user_pref("extensions.getAddons.showPane", false);
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
user_pref("browser.discovery.enabled", false);
user_pref("browser.shell.checkDefaultBrowser", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
user_pref("browser.preferences.moreFromMozilla", false);
user_pref("browser.aboutConfig.showWarning", false);
user_pref("browser.startup.homepage_override.mstone", "ignore");
user_pref("browser.aboutwelcome.enabled", false);
user_pref("browser.profiles.enabled", true);
