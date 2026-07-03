# BIBLIOGRAPHY

Reference list of the primary sources, standards documents, and
historical texts that inform the `sh` package (Bourne shell) in
this Heirloom Darwin port.

## Standards + specifications

- **POSIX.1-2001** (IEEE Std 1003.1-2001). Base Definitions +
  System Interfaces + Shell and Utilities. The behavioural target
  for the `posix2001/` personality binaries in this port.
- **POSIX.1-1990** and **XPG3/XPG4** (X/Open). Historical basis
  for the `s42/` (SVID4-subset) and `posix/` (SUS) personalities.
- **SVID Issue 4** — System V Interface Definition, Fourth Edition,
  AT&T 1995. Behavioural reference for the default (SVID3/SVID4)
  personality binaries.
- **RFC 5735**, **RFC 3986** — for URI handling in tools that emit
  or parse network references (mail utilities in toolchest;
  pkgweb.c in pkgtools).
- **FIPS PUB 203, 204, 205** — Post-quantum crypto standards
  (ML-KEM, ML-DSA, SLH-DSA). Relevant to pkgtools' OpenSSL 3.5+
  signature verification path even though not exercised by the
  default sunw_PKCS12_parse code path.

## Foundational Bell Labs + BSD papers

- Kernighan, Brian W. and Rob Pike (1984). *The UNIX Programming
  Environment*. Prentice-Hall. Establishes many of the design
  norms this port preserves.
- McIlroy, M. Douglas (1978). "A Research UNIX Reader: Annotated
  Excerpts from the Programmer's Manual, 1971-1986." Bell Labs
  Computing Science Technical Report No. 139.
- Kernighan, Brian W. and Dennis M. Ritchie (1988). *The C
  Programming Language*, 2nd ed. Prentice-Hall. K&R style still
  appears in some Heirloom sources; the port preserves it.
- Ossanna, Joseph F. (1977). "NROFF/TROFF User's Manual." Bell
  Labs Computing Science Technical Report No. 54. (Relevant to
  doctools even outside that repo, because pkgtools' `pkginfo`
  emits nroff-formatted output.)
- Lions, John (1977). *A Commentary on the UNIX Operating System*.
  Bell Labs internal circulation; later released. Historical
  context for the code style.

## Package-specific references

- Bourne, Stephen R. (1978). "An Introduction to the UNIX Shell."
  Bell System Technical Journal 57(6). The founding paper.
- Bourne, Stephen R. (1978). "The UNIX Shell." Bell System
  Technical Journal 57(6). Companion paper describing implementation.
- Korn, David G. (1994). "ksh - An Extensible High Level Language."
  Proceedings of the USENIX Very High Level Languages Symposium.
  Contextualises the design decisions the Bourne shell made not
  to take.
- IEEE POSIX.2 (1992) — Shell and Utilities. The pre-2001 shell
  standard that Ritter's port respects while preserving the pre-
  POSIX behaviour of backticks-only, no $(...).

## Solaris + Ritter era

- Sun Microsystems (2005). *OpenSolaris source distribution*.
  The CDDL-1.0 fragments that carry the Sun copyright headers
  in this port descend from this drop.
- Ritter, Gunnar (2001-2008). *The Heirloom Project* — patch
  notes and README files inside the upstream tarballs at
  http://heirloom.sourceforge.net/. Definitive semantic authority
  for anything the port did NOT explicitly change.
- Ritter, Gunnar (personal communication, various mailing-list
  posts). Design rationale for the personality tree (SVID3 default
  + POSIX/SUS/SUS3/UCB variants).

## Security + hardening frameworks

- **CWE Top 25** (MITRE, 2024 edition). Referenced by
  `hardening/COVERAGE-MATRIX.md` in the workspace repo.
- **OWASP Top 10** (2021). Referenced likewise.
- **MITRE ATT&CK v14** (2024). Behavioural threat modelling for
  privileged utilities (`su`, `pkgadd`).
- **CAPEC 3.9** (2023). Attack-pattern catalogue used in threat
  modelling.

## Darwin-specific references

- Apple Inc. (2024). *macOS System Programming Guide* — chapters
  on Mach umbrella, libproc, and dyld. Foundation for the ps /
  pgrep / whodo re-implementations.
- IEEE Std 1003.1-2017 (POSIX.1-2017) — the current POSIX revision
  that Darwin claims conformance to. This port targets 2001
  behaviour where the two conflict.
- Apple's XNU source (public releases at
  https://github.com/apple-oss-distributions). Consulted for
  syscall semantics that differ between Darwin and Solaris.

## AI-assisted authorship references

- Anthropic (2026). *Claude Opus 4.7* model card. See
  `AI-DISCLOSURE.md` for how the model contributed to this port.

## Related community work

- Homebrew formulae for `heirloom-mailx`, `heirloom-doctools`,
  `heirloom-toolchest`. Not upstream to this port; independent
  packagings.
- Debian `heirloom-mailx` package (removed in 2018 due to CVE
  history in the upstream `nail` codebase).
- Fedora `heirloom-devtools` retired package.

## How to add to this bibliography

If you patch a specific tool and want to cite a paper or standard
that motivated the fix, append a row under **Package-specific
references** in the source of this file and commit alongside the
patch. Keep entries in APA-adjacent format for consistency.
