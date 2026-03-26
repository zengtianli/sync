---
name: nvim-config
description: Neovim 配置管理。LSP、插件、快捷键配置。当修改 Neovim 配置时触发。
---

# Neovim 配置

> 路径：`~/Documents/sync/nvim/`

## 目录结构

```
nvim/
├── init.lua           # 入口文件
├── lua/config/        # 核心配置
│   ├── plugins.lua    # 插件管理 (lazy.nvim)
│   ├── lsp.lua        # LSP 配置
│   ├── keymaps.lua    # 快捷键
│   ├── autocomplete.lua
│   └── telescope.lua
├── lua/plugin/        # 自定义插件
├── lazy-lock.json     # 插件锁定版本
└── KEYMAPS.md         # 快捷键文档
```

## 核心快捷键

| 快捷键 | 功能 |
|--------|------|
| `<Space>` | Leader 键 |
| `S` | 保存文件 |
| `Q` | 退出 |
| `K/J` | 上下 15 行 |
| `H/L` | 行首/行尾 |
| `<C-p>` | 文件搜索 |
| `<C-f>` | 内容搜索 |
| `gd` | 跳转定义 |
| `gr` | 查找引用 |
| `R` | Yazi 文件管理器 |

## LSP 支持

Lua, TypeScript, Python, Go, C/C++, HTML/CSS, JSON, YAML, Terraform, Prisma

## 常用命令

```vim
:Lazy              " 插件管理
:Mason             " LSP 安装器
:checkhealth       " 健康检查
:Telescope         " 搜索面板
```

## 修改规范

1. 快捷键改动需同步更新 `KEYMAPS.md`
2. 新插件添加到 `lua/config/plugins.lua`
3. LSP 配置在 `lua/config/lsp.lua`
