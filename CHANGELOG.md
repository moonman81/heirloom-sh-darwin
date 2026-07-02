# Changelog

All notable changes to this Heirloom Darwin port repository are
documented here, per [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)
v1.1.0 with dates in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601)
(`YYYY-MM-DD`).

This project uses [Semantic Versioning](https://semver.org/spec/v2.0.0.html);
the version numbers here describe the **port**, not upstream Heirloom.
The upstream vendor baseline is fixed at the tarball whose date is
encoded in the vendor commit (see below).

Upstream changelog for the pristine heirloom-sh-050706 release is preserved
in the upstream `CHANGES` file (or top-level `README`) inside this
repository — see there for pre-port history.

## [Unreleased]

_No changes since 0.1.0._

## [0.1.0] — 2026-07-02

Initial public release of the Heirloom Bourne shell macOS/Darwin port.

### Added / Changed / Fixed

- **a5f5c1d**: phase 0: Darwin mk.config overlays + top-level driver + PORT.md
- **44c0705**: phase 1: sh — drop unused <ucontext.h> for Darwin build
- **e97c0c5**: phase 7: install + run all brew C linters/checkers/formatters

### Documentation

- **ce443f0**: docs: add README + NOTICE + AI-DISCLOSURE

### Vendor baseline

- **22944b2**: import pristine `heirloom-sh-050706` upstream tarball verbatim
  (Gunnar Ritter, `heirloom.sourceforge.net`).

### Deferred with documented reasoning

- **`devtools/make/vroot/`** — 79 flawfinder level-5 race
  conditions inherent to SVR4 make's virtual-root design. Not
  fixable without a make rewrite. Do not run `heirloom-make` in a
  directory tree an untrusted user can write to.
- **`sunw_PKCS12_create`** (pkgtools) — pkg-signing write side
  stubbed with runtime diagnostic. Read side (parse existing signed
  packages) is real via OpenSSL 3.x. See `p12lib_openssl3.c`.
- **CWE-674 (uncontrolled recursion)** in `nawk`/`oawk`/`bc`
  — universal awk-family behaviour; no interpreter in the family
  bounds recursion. Apply `ulimit -s` before feeding these to
  untrusted scripts.
- **~5,500 flawfinder CWE-120/119 findings** — K&R
  `strcpy`/`sprintf`/`strcat` usage in size-bounded internal
  string manipulation. Individual triage deferred; attacker-
  controlled-fmt CWE-134 sites have all been fixed.

## Links

- Repository: <https://github.com/moonman81/heirloom-sh-darwin>
- Companion workspace repo: <https://github.com/moonman81/heirloom-workspace-darwin>
- Upstream (authoritative): <http://heirloom.sourceforge.net>
- Vendor tarball: `heirloom-sh-050706`

<!--
Format:
  ## [X.Y.Z] — YYYY-MM-DD

  ### Added / Changed / Deprecated / Removed / Fixed / Security

  - **<short-sha>**: subject line

Rules:
  * Newest release at top (below Unreleased).
  * Categories per Keep a Changelog.
  * Dates ISO 8601.
  * Cite the git short-SHA so `git log <sha>` retrieves the full body.
-->
