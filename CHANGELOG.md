# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.3.0] — 2026-09-15

### Added
- **Info tab** in the menu with:
  - Version number and author
  - Built-in changelog (what was added, changed, fixed)
  - Credits section
  - Warning about bans
- **Version info stored in `_G.PathosVersion`** — read by UI to display changelog
- Changelog format with symbols: `+` Added, `~` Changed, `*` Fixed

### Changed
- Loader version bumped to **1.3.0**
- UI version bumped to **1.3.0**
- Main version bumped to **1.3.0**
- Menu now has 4 tabs: **Mining / ESP / Misc / Info**

### Fixed
- No fixes in this version — only additions

---

## [1.2.0] — 2026-09-15

### Added
- **ESP Tab** in the menu with three new toggles:
  - **Monster ESP** — red outline around monsters (Workspace.Monsters)
  - **Vase ESP** — yellow outline around vases (Workspace.Vases)
  - **Drop ESP** — green outline around dropped materials (Workspace.DroppedMaterials)
- **Instant Mine** toggle — breaks any ore in one hit via ProximityPrompt
- **Dirt** color added to Ore ESP (brown)
- Universal ESP system — one function handles all highlights

### Changed
- Menu reorganized into three tabs: **Mining**, **ESP**, **Misc**
- `main.lua` rewritten with cleaner ESP logic
- Loader version bumped to **1.2.0**
- UI version bumped to **1.2.0**

### Fixed
- Noclip now properly restores collision when toggled off
- Fast Mine now also patches tools stored in Backpack
- Auto Mine no longer targets destroyed ores

---

## [1.0.0] — 2026-09-15

### Added
- **Ore ESP** — highlights every ore type through walls with its own color
  (Coal, Copper, Iron, Nickel, Zinc, Slate, Rock)
- **Fast Mine** — removes pickaxe swing delay
- **Auto Mine** — automatically mines the nearest ore
- **Speed** — faster movement
- **Noclip** — walk through walls
- **Fullbright** — brightens the entire map
- **WindUI menu** with two tabs: Mining and Misc
- **Loader** with animated loading screen and version display

### Notes
- Tested on Arceus X Neo
- Requires executor with hookmetamethod, getrawmetatable and getreg support
- Use on alternate accounts only

---

## Version Format

Versions follow `MAJOR.MINOR.PATCH`:

- **MAJOR** — big changes, may break compatibility
- **MINOR** — new features, backwards compatible
- **PATCH** — small bug fixes

Example: `1.3.0`

## Types of Changes

- **Added** — new features
- **Changed** — changes in existing functionality
- **Fixed** — bug fixes
- **Removed** — removed features
- **Deprecated** — features that will be removed soon
- **Security** — security-related fixes