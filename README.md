# Dotfiles

**English** | [中文](README_CN.md)

My macOS development environment — shell, editors, terminal tools, and window managers, all in one place.

[![macOS](https://img.shields.io/badge/macOS-Dotfiles-blue?style=for-the-badge)]()
[![License: MIT](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)

---

## What's Inside

| Directory | Tools |
|-----------|-------|
| `shell/` | Zsh config, aliases, integrations (Anthropic, Atuin, Starship) |
| `editors/` | Neovim (LazyVim), VS Code, Cursor |
| `terminal/` | Tmux, Alacritty, Kitty, WezTerm |
| `window-managers/` | Hammerspoon, Yabai + skhd |
| `network/` | Clash, proxy rules |
| `integrations/` | Raycast, Alfred |
| `apps/` | Application-specific configs |
| `zsh/` | Shell framework config |

## Structure

```
sync/
├── shell/              ← Zsh, aliases, PATH, integrations
│   ├── zshrc
│   ├── aliases/
│   └── config/
├── editors/            ← Neovim + VS Code + Cursor
│   ├── nvim/
│   ├── vscode/
│   └── cursor/
├── terminal/           ← Terminal emulator configs
├── window-managers/    ← Hammerspoon + Yabai
├── network/            ← Proxy & VPN configs
├── integrations/       ← Raycast, Alfred
└── docs/               ← Documentation & notes
```

## Note

This is a personal configuration. Secrets and API keys are excluded via `.gitignore`. Use it as reference, not a drop-in replacement.

## License

MIT
