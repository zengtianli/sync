---
name: dotfiles
description: 配置部总览。目录结构、部署方式、协作规范。当需要了解配置部整体架构时触发。
---

# 配置部 Dotfiles

> 路径：`~/Documents/sync/`
> 定位：一人集团 **配置部**

## 模块总览

| 模块 | 路径 | 部署位置 |
|------|------|----------|
| Neovim | `nvim/` | `~/.config/nvim` |
| Zsh | `zsh/zshrc` | `~/.zshrc` |
| Yabai | `yabai/config/` | `~/.config/yabai` |
| Karabiner | `karabiner/` | `~/.config/karabiner` |
| Yazi | `yazi/` | `~/.config/yazi` |
| Hammerspoon | `hammerspoon/` | `~/.hammerspoon` |

## 部署方式

**软链接部署**（推荐）：
```bash
ln -sf ~/Documents/sync/nvim ~/.config/nvim
ln -sf ~/Documents/sync/zsh/zshrc ~/.zshrc
ln -sf ~/Documents/sync/yabai/config ~/.config/yabai
```

## 配置部约束

**禁止事项**：
- ❌ 不开发脚本（交给开发部）
- ❌ 不配置 LaunchAgent（交给总控）
- ❌ 不直接修改 `~/.xxx`（通过 sync 软链接）

**交付规范**：
- 配置文件
- 配置说明.md
- 生效方式说明

## 提交规范

```
<type>(<scope>): <description>

feat(nvim): 添加 Python LSP 支持
fix(zsh): 修复 FZF 预览乱码
refactor(yabai): 重构窗口移动脚本
docs(karabiner): 更新键位映射说明
```

## 文件命名

| 类型 | 格式 | 示例 |
|------|------|------|
| 主配置 | 小写无后缀 | `zshrc`, `init.lua` |
| 模块配置 | `功能名.扩展名` | `keymaps.lua` |
| 脚本工具 | `动词_名词.sh` | `toggle_window.sh` |
