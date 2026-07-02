#!/bin/sh
# verify.sh — post-install smoke test for heirloom-sh
set -eu

PREFIX="${1:-/opt/heirloom}"
SH="$PREFIX/bin/sh"

if tty >/dev/null 2>&1; then
	C_OK='\033[32m'; C_FAIL='\033[31m'; C_RESET='\033[0m'
else
	C_OK=''; C_FAIL=''; C_RESET=''
fi

ok()   { printf '  %b✓%b %s\n' "$C_OK" "$C_RESET" "$*"; }
fail() { printf '  %b✗ %s%b\n' "$C_FAIL" "$*" "$C_RESET"; exit 1; }

[ -x "$SH" ] || fail "$SH not executable"
ok "sh installed: $SH"

[ -L "$PREFIX/bin/jsh" ] || fail 'jsh symlink missing'
ok 'jsh symlink present'

out=$("$SH" -c 'echo hello world' </dev/null 2>&1)
[ "$out" = 'hello world' ] || fail "basic echo failed: $out"
ok 'basic echo'

out=$("$SH" -c 'x=hi; echo "$x $x"' </dev/null 2>&1)
[ "$out" = 'hi hi' ] || fail "param expansion failed"
ok 'param expansion'

out=$("$SH" -c 'echo a b c | tr " " "\n" | wc -l' </dev/null 2>&1 | tr -d ' ')
[ "$out" = '3' ] || fail "pipeline failed: got $out"
ok 'pipelines + external commands'

# Preserve traditional Bourne behaviour: $(...) NOT supported
out=$("$SH" -c 'echo $(echo bad)' </dev/null 2>&1 || true)
case "$out" in
	*syntax*|*unexpected*)  ok 'traditional Bourne: no $(...) syntax (correct)' ;;
	*) fail "$(...) unexpectedly supported: $out" ;;
esac

# Backticks work
out=$("$SH" -c 'echo `echo good`' </dev/null 2>&1)
[ "$out" = 'good' ] || fail "backticks failed: $out"
ok 'backticks command substitution'

printf '%bverify: sh OK%b\n' "$C_OK" "$C_RESET"
