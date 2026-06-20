/* ============================================================================= */
/* Options:                                                                      */
/* ============================================================================= */
// Homepage: =====================================================================================
user_pref("browser.startup.homepage", "https://startup-page-web.vercel.app/");

// Sync: =========================================================================================
user_pref("identity.fxaccounts.enabled", false);

// Tracking: =====================================================================================
user_pref("browser.contentblocking.category", "strict");

// Pocket: =======================================================================================
user_pref("browser.pocket.enabled", false);
user_pref("extensions.pocket.enabled", false);

// Https: ========================================================================================
user_pref("dom.security.https_first", true);
user_pref("dom.security.https_only_mode", true);

// Theme: ========================================================================================
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
user_pref("browser.compactmode.show", true);

// View: =========================================================================================
user_pref("browser.tabs.firefox-view", false);
user_pref("browser.tabs.firefox-view-newIcon", false);
user_pref("browser.tabs.firefox-view-next", false);

// Avoidance: ====================================================================================
user_pref("browser.cache.disk.enable", false);
user_pref("browser.privatebrowsing.forceMediaMemoryCache", true);
user_pref("media.memory_cache_max_size", 65536);
user_pref("browser.sessionstore.interval", 60000);

// Fullscreen: ===================================================================================
user_pref("full-screen-api.transition-duration.enter", "0 0");
user_pref("full-screen-api.transition-duration.leave", "0 0");
user_pref("full-screen-api.warning.delay", -1);
user_pref("full-screen-api.warning.timeout", 0);

// Newtab: =======================================================================================
user_pref("browser.newtabpage.activity-stream.default.sites", "");
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredCheckboxes", false);

// AI: ===========================================================================================
user_pref("browser.ai.control.default", "blocked");
user_pref("browser.ml.enable", false);
user_pref("browser.ml.chat.enabled", false);
user_pref("browser.ml.chat.menu", false);
user_pref("browser.tabs.groups.smart.enabled", false);
user_pref("browser.ml.linkPreview.enabled", false);

// UI: ===========================================================================================
user_pref("extensions.getAddons.showPane", false);
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
user_pref("browser.discovery.enabled", false);
user_pref("browser.shell.checkDefaultBrowser", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false,);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false,);
user_pref("browser.preferences.moreFromMozilla", false);
user_pref("browser.aboutConfig.showWarning", false);
user_pref("browser.startup.homepage_override.mstone", "ignore");
user_pref("browser.aboutwelcome.enabled", false);
user_pref("browser.profiles.enabled", true);
