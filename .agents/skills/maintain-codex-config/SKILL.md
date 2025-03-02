---
name: maintain-codex-config
description: Maintain and verify the chezmoi modify template for Codex config.toml. Use when changing home/dot_codex/modify_private_config.toml or deciding which volatile Codex settings must be preserved; do not use for ordinary Codex configuration outside this chezmoi repository.
---

# Maintain Codex Config

Maintain `home/dot_codex/modify_private_config.toml` as a chezmoi modify template whose input is the existing `~/.codex/config.toml` in `.chezmoi.stdin`.

## Preserve app-owned state

Read these values or tables from `.chezmoi.stdin` and do not overwrite them with fixed source values:

- `shell_environment_policy.set.NODE_REPL_TRUSTED_BROWSER_CLIENT_SHA256S`
- `[mcp_servers.node_repl]` in its entirety
- `[projects]` in its entirety
- `[marketplaces.openai-bundled]` in its entirety
- `[marketplaces.openai-primary-runtime]` in its entirety
- `[plugins]` in its entirety
- `[hooks.state]` in its entirety

Preserving `[mcp_servers.node_repl]` includes fields such as `trusted_hash`, `BROWSER_USE_CODEX_APP_VERSION`, and `NODE_REPL_TRUSTED_SERVICES`. Preserve newly added fields under this table without enumerating them individually.

## Apply fallback behavior

- Emit `NODE_REPL_TRUSTED_BROWSER_CLIENT_SHA256S` only when it exists in the input.
- Never obtain `NODE_REPL_TRUSTED_BROWSER_CLIENT_SHA256S` from 1Password.
- Emit `[hooks.state]` only when it exists in the input.
- For the other preserved tables, use the source defaults only when the corresponding input table is absent or empty.

## Keep rendering stable

- Produce valid TOML for both the current target input and empty input.
- Keep section heading comments outside template conditionals. Put only conditionally emitted TOML tables and values inside the conditional.
- Remove the two-space indentation added by `toToml` when embedding nested tables.
- Do not introduce consecutive blank lines.
- Compare preserved values semantically after TOML parsing, not as raw text.
- Do not print the target config, rendered config, or secret values. Sanitize secret template calls before rendering during tests.

## Work and verify

1. Inspect the existing template and relevant staged and unstaged changes before editing.
2. Make the smallest change that preserves the ownership and fallback rules above.
3. Run `scripts/verify.sh` from any directory in this repository.
4. Report which checks ran. Do not claim checks that were not executed or did not pass.
5. Do not run `chezmoi apply` unless the user explicitly requests it.
