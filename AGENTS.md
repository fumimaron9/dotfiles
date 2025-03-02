# Repository instructions

## Codex config.toml

- `home/dot_codex/modify_private_config.toml` is a chezmoi modify template. Preserve Codex app-owned state from `.chezmoi.stdin`; do not replace it with fixed values.
- Treat `.agents/skills/maintain-codex-config/SKILL.md` as the source of truth for state ownership, fallback behavior, and the required workflow.
- After changing the modify template, run `.agents/skills/maintain-codex-config/scripts/verify.sh`.
- Do not print the target config, rendered config, or secret values while inspecting or testing the template.
- Do not run `chezmoi apply` unless the user explicitly requests it.
