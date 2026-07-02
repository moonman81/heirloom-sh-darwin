---
name: traditional-bourne-shell-preservation
description: "Preserve traditional pre-POSIX Bourne shell behaviour when porting or maintaining Heirloom sh. No $(...) command substitution — backticks only. No $((...)) arithmetic — use expr(1). No local, no [[ ]], no arrays. Preserving these absences IS the value proposition; supporting them would make Heirloom sh a bash-clone, not a Bourne shell."
gate: 2
version: "1.0.0"
author: moonman81
tags: [heirloom, bourne-shell, posix, backwards-compatibility, sysv]
depends_on: []
allowed-tools:
  - Read
  - Grep
when_to_use: "Invoke when contributing to heirloom-sh-darwin (or any Ritter Bourne port), when a user asks 'why doesn't $() work here?', or when debugging Bourne scripts that fail because the author assumed POSIX/bash extensions. Triggers: 'traditional Bourne', 'pre-POSIX sh', 'no \\$()', 'backticks required', 'SVR4 sh', 'Ritter sh behaviour'."
---

# Traditional Bourne shell preservation

## The value proposition

Heirloom sh is the **pre-POSIX Bourne shell** — the sh that shipped
with SVR4 and earlier. It is deliberately not a POSIX-conformant
shell; that job belongs to `sh(1)` from the toolchest's POSIX
personality, or to bash/zsh, or (on macOS) to `/bin/sh`.

The value of Heirloom sh is precisely that it enforces the older
grammar. Scripts that ran on Sun 3 / SPARCstation-1 / SVR4 boxes in
the 1990s will run identically here. Scripts that require POSIX
extensions will fail cleanly.

## Behaviours to preserve

The following are **not bugs**. Do not "fix" them.

### No `$(...)` command substitution

```sh
$ heirloom-sh -c 'echo $(pwd)'
heirloom-sh: syntax error at line 1: `(' unexpected
```

Correct usage:

```sh
$ heirloom-sh -c 'echo `pwd`'
/some/path
```

Rationale: `$(...)` was standardised only in POSIX.2 (1992). Older
Bourne uses backticks exclusively. Scripts that assume `$(...)`
should be run under a POSIX-conformant shell (`sh` from
`/opt/heirloom/bin/posix/` or `/opt/heirloom/bin/posix2001/`).

### No `$((...))` arithmetic

```sh
$ heirloom-sh -c 'echo $((1+2))'
heirloom-sh: syntax error
```

Correct usage:

```sh
$ heirloom-sh -c 'echo `expr 1 + 2`'
3
```

Rationale: POSIX.2 addition. Use `expr(1)` or `bc(1)`.

### No `local`, `[[ ... ]]`, `((`, arrays, `${var:-...}` extended-glob

All bash extensions. Not in classical Bourne.

### `set -e` behaviour

Traditional Bourne `set -e` fires on the first non-zero exit; it does
not have bash's "if in a compound statement" carve-outs. Scripts that
rely on bash's specific `set -e` semantics will behave differently.

## The `chkbptr` return-type discipline

The `sh/blok.c` `chkbptr()` function had `int` return type with no
return statement (only `abort(N)` exits). The port changed it to
`void` (see `patches/` in heirloom-sh-darwin) because cppcheck flagged
the missing return. Callers ignored the value anyway. **The
behaviour is unchanged**; this was a pure type-correctness fix.

## When to reach for a POSIX shell instead

If a user asks "how do I make this modern shell script work under
Heirloom sh", the honest answer is often: **don't**. Direct them to:

- `/opt/heirloom/bin/posix/sh` — SUSv2 shell
- `/opt/heirloom/bin/posix2001/sh` — SUSv3 shell
- system `/bin/sh` — bash-in-sh-mode on most Linux; dash on Debian;
  various on other systems
- `/bin/bash` or `/bin/zsh` — for interactive-style features

Heirloom sh is a **preservation tool**, not a everyday-shell
recommendation.

## Reference

- Stephen Bourne, "The UNIX Shell" (1978, Bell System Tech Journal).
- Upstream `sh.1` in this repo.
- Gunnar Ritter's zlib-style Heirloom sh port headers.
