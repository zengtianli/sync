---
name: zsh-config
description: Zsh 配置管理。别名、FZF、现代工具。当修改 Zsh 配置时触发。
---

# Zsh 配置

> 路径：`~/Documents/sync/zsh/`

## 目录结构

```
zsh/
├── zshrc              # 主配置（软链接到 ~/.zshrc）
├── zimrc              # Zim 框架配置
├── config/            # 模块化配置
│   ├── aliases.zsh    # 别名
│   ├── modern-tools.zsh # 现代工具
│   ├── fzf.zsh        # FZF 配置
│   ├── mappings.zsh   # 快捷键
│   └── conda.zsh      # Conda 环境
├── functions/         # 自定义函数
└── fzf/               # FZF 工具脚本
```

## 核心快捷键

| 快捷键 | 功能 |
|--------|------|
| `Ctrl+P` | FZF 文件搜索 |
| `Ctrl+F` | FZF 内容搜索 |
| `Ctrl+R` | 历史命令搜索 |
| `Ctrl+T` | 目录切换 |
| `Ctrl+G` | LazyGit |
| `Ctrl+O` | 打开 Finder |

## 现代工具替代

| 传统 | 现代 | 说明 |
|------|------|------|
| `ls` | `eza` | 彩色文件列表 |
| `cat` | `bat` | 语法高亮 |
| `find` | `fd` | 快速查找 |
| `du` | `dust` | 磁盘占用 |
| `top` | `btop` | 系统监控 |
| `diff` | `delta` | Git diff |

## 常用别名

```bash
rl          # 重载 zshrc
lg          # lazygit
ra          # yazi
ex          # 设置代理
sync-status # 查看同步状态
```

## 修改规范

1. 新别名添加到 `config/aliases.zsh`
2. 新函数添加到 `functions/`
3. FZF 工具添加到 `fzf/`
4. 改动后运行 `rl` 测试
