# Firefox CSS & Configuration Setup

Custom Firefox configurations, including `user.js` for performance/privacy tweaks and custom `chrome/` CSS themes.

Because Firefox generates a random prefix for the default profile directory (e.g., `lml4t5we.default-default`), you must link these configuration files to your active profile after running Firefox for the first time.

---

## Installation

### Prerequisites

1. Open Firefox at least once to allow it to generate your default profile directory.
2. Close Firefox completely before proceeding.

### Symlink Configuration

You can manually link the files by replacing `lml4t5we.default-default` with your actual Firefox profile folder name, or use the automated snippet below.

#### Option A: Automated Symlink (Recommended)

Run this command in your terminal. It automatically detects your active `.default-default` directory and creates the required symlinks:

```bash
ln -s ~/.local/way.dots/void-dotfiles/others/web/mozilla/firefox/thorn.default-default/user.js ~/.config/mozilla/firefox/lml4t5we.default-default/
ln -s ~/.local/way.dots/void-dotfiles/others/web/mozilla/firefox/thorn.default-default/chrome/ ~/.config/mozilla/firefox/lml4t5we.default-default/
```
