#!/usr/bin/env bash

set -euo pipefail

readonly source_rel="home/dot_codex/modify_private_config.toml"
readonly script_dir="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
readonly repo_root="$(git -C "$script_dir" rev-parse --show-toplevel)"
readonly source_path="$repo_root/$source_rel"
readonly target_path="$(cd "$repo_root" && chezmoi target-path "$source_rel")"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

pass() {
  printf 'PASS: %s\n' "$1"
}

[[ -f "$source_path" ]] || fail "modify template not found"
[[ -f "$target_path" ]] || fail "target config not found: $target_path"

umask 077
test_tmpdir="$(mktemp -d "${TMPDIR:-/tmp}/verify-codex-config.XXXXXX")"
cleanup() {
  case "$test_tmpdir" in
    "${TMPDIR:-/tmp}"/verify-codex-config.*) rm -rf -- "$test_tmpdir" ;;
  esac
}
trap cleanup EXIT

readonly sanitized_template="$test_tmpdir/modify_private_config.toml"
readonly current_render="$test_tmpdir/current.toml"
readonly fallback_render="$test_tmpdir/fallback.toml"
readonly empty_input="$test_tmpdir/empty.toml"

# Render deterministically without contacting a secret manager or exposing values.
perl -0pe 's/"\{\{\s*onepasswordRead\s+"[^"]+"\s*\}\}"/"REDACTED"/g' \
  "$source_path" > "$sanitized_template"
if rg -q 'onepasswordRead' "$sanitized_template"; then
  fail "an unsupported onepasswordRead expression remains after sanitization"
fi

: > "$empty_input"
chezmoi execute-template --with-stdin -f "$sanitized_template" \
  < "$target_path" > "$current_render"
chezmoi execute-template --with-stdin -f "$sanitized_template" \
  < "$empty_input" > "$fallback_render"
pass "rendered with current and empty input without reading secrets"

for rendered in "$current_render" "$fallback_render"; do
  chezmoi execute-template --with-stdin \
    '{{- fromToml .chezmoi.stdin | toJson -}}' < "$rendered" > /dev/null

  if rg -q '^  ' "$rendered"; then
    fail "rendered TOML contains a line beginning with two spaces"
  fi
  if perl -0ne 'exit(/\n[ \t]*\n[ \t]*\n/ ? 0 : 1)' "$rendered"; then
    fail "rendered TOML contains consecutive blank lines"
  fi
done
pass "both renders are valid TOML with stable whitespace"

readonly projection_template='{{- $v := fromToml .chezmoi.stdin -}}{{- $browser := $v | dig "shell_environment_policy" "set" "NODE_REPL_TRUSTED_BROWSER_CLIENT_SHA256S" "" -}}{{- $nodeRepl := $v | dig "mcp_servers" "node_repl" (dict) -}}{{- $projects := $v | dig "projects" (dict) -}}{{- $bundled := $v | dig "marketplaces" "openai-bundled" (dict) -}}{{- $runtime := $v | dig "marketplaces" "openai-primary-runtime" (dict) -}}{{- $plugins := $v | dig "plugins" (dict) -}}{{- $hooks := $v | dig "hooks" "state" (dict) -}}{{- dict "browser" $browser "nodeRepl" $nodeRepl "projects" $projects "bundledMarketplace" $bundled "primaryRuntimeMarketplace" $runtime "plugins" $plugins "hooksState" $hooks | toJson -}}'

chezmoi execute-template --with-stdin "$projection_template" \
  < "$target_path" > "$test_tmpdir/expected.json"
chezmoi execute-template --with-stdin "$projection_template" \
  < "$current_render" > "$test_tmpdir/actual.json"
cmp -s "$test_tmpdir/expected.json" "$test_tmpdir/actual.json" || \
  fail "app-owned state changed during current-input rendering"
pass "app-owned state is preserved semantically"

if rg -q '^\[hooks\.state(?:\.|\])' "$fallback_render"; then
  fail "empty-input rendering emits hooks.state"
fi
if rg -q '^NODE_REPL_TRUSTED_BROWSER_CLIENT_SHA256S[[:space:]]*=' "$fallback_render"; then
  fail "empty-input rendering emits NODE_REPL_TRUSTED_BROWSER_CLIENT_SHA256S"
fi
if ! rg -q '^# Shell Environment Policy for spawned processes \(table\)$' "$fallback_render"; then
  fail "empty-input rendering omits the shell environment section heading"
fi
if rg -q '^\[shell_environment_policy(?:\.|\])' "$fallback_render"; then
  fail "empty-input rendering emits the shell environment policy table"
fi
if rg -q 'op://[^\n]*NODE_REPL_TRUSTED_BROWSER_CLIENT_SHA256S' "$source_path"; then
  fail "NODE_REPL_TRUSTED_BROWSER_CLIENT_SHA256S still references 1Password"
fi
pass "optional state and browser SHA fallback rules are enforced"

git -C "$repo_root" diff --check -- "$source_rel"
git -C "$repo_root" diff --cached --check -- "$source_rel"
pass "Git whitespace checks passed"
