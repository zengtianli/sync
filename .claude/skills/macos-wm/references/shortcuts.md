# macOS 窗口管理快捷键参考

## Hammerspoon 快捷键

### Finder 专用

| 快捷键 | 功能 |
|--------|------|
| ⌘⌃⇧+T | 终端在此处打开 |
| ⌘⌃⇧+W | IDE 在此处打开 |
| ⌘⌃⇧+I | Nvim 编辑文件 |
| ⌘⇧+N | 创建新文件夹 |
| ⌘⌥+N | 新 Finder 窗口 |
| ⌘⌃⇧+S | 运行选中脚本 |
| ⌘⌃⇧+N | 复制文件名 |
| ⌃⌥+V | 粘贴到 Finder |
| ⌃⌥+C | 压缩选中文件 |

### 媒体控制（全局）

| 快捷键 | 功能 |
|--------|------|
| ⌘⌃⇧+; | 播放/暂停 |
| ⌘⌃⇧+' | 下一首 |
| ⌘⌃⇧+L | 上一首 |
| ⌘⌃⇧+P | 系统媒体控制 |

### 系统工具（全局）

| 快捷键 | 功能 |
|--------|------|
| ⌘⌥+, | 系统设置 |
| ⌃⇧+R | 重启当前应用 |
| ⌘⌃⌥⇧+H | 快捷键帮助 |

## Karabiner 映射

### Hyper Key

右 Command → Shift+Command+Option+Control

### Caps Lock 增强

| 组合键 | 功能 |
|--------|------|
| Caps+H | ← |
| Caps+J | ↓ |
| Caps+K | ↑ |
| Caps+L | → |
| Caps+A | Home |
| Caps+E | End |

### Tab 功能键

| 组合键 | 功能 |
|--------|------|
| Tab+1~0 | F1~F10 |
| Tab+- | F11 |
| Tab+= | F12 |

## Yabai 命令

```bash
# 服务控制
./scripts/service/toggle.sh start
./scripts/service/toggle.sh stop
./scripts/service/toggle.sh restart
./scripts/service/toggle.sh status

# 窗口操作
./scripts/window/resize.sh increase|decrease
./scripts/window/move.sh next|prev|to-space <n>
./scripts/window/float.sh toggle|center

# 空间操作
./scripts/space/create.sh [with-window]
./scripts/space/navigate.sh next|prev|to <n>
```
