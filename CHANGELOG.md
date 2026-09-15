# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.0.0] — 2026-09-15

### Added
- **Ore ESP** — highlights every ore type through walls with its own color
  (Coal, Copper, Iron, Nickel, Zinc, Slate, Rock)
- **Fast Mine** — removes pickaxe swing delay by setting `TimeBeforeSwing` to 0
- **Auto Mine** — automatically triggers the nearest ore's ProximityPrompt
- **Speed** — faster movement
- **Noclip** — walk through walls
- **Fullbright** — brightens the entire map for visibility in caves
- **WindUI menu** with two tabs: Mining and Misc
- **Loader** with animated loading screen and version display

### Notes
- Tested on Arceus X Neo
- Requires executor with `hookmetamethod`, `getrawmetatable`, `getreg` support
- Use on alternate accounts only

---

## Version Format

Versions follow `MAJOR.MINOR.PATCH`:

- **MAJOR** — big changes, may break compatibility
- **MINOR** — new features, backwards compatible
- **PATCH** — small bug fixes

Example: `1.1.0`

## Types of Changes

- **Added** — new features
- **Changed** — changes in existing functionality
- **Fixed** — bug fixes
- **Removed** — removed features
- **Deprecated** — features that will be removed soon
- **Security** — security-related fixes