---
name: macos-wm
description: macOS 窗口管理配置。Yabai、Hammerspoon、Karabiner。当配置窗口管理或快捷键时触发。
---

# macOS 窗口管理

整合三个工具：Yabai（窗口平铺）、Hammerspoon（自动化）、Karabiner（键盘映射）

## Yabai 窗口管理

> 路径：`~/Documents/sync/yabai/`

```
yabai/
├── config/
│   ├── yabairc        # 主配置
│   ├── apps.conf      # 应用规则
│   └── spaces.conf    # 空间配置
└── scripts/
    ├── service/toggle.sh  # 服务控制
    ├── window/            # 窗口操作
    └── space/             # 空间操作
```

**服务控制**：
```bash
./scripts/service/toggle.sh start|stop|restart|toggle|status
```

## Hammerspoon 自动化

> 路径：`~/Documents/sync/hammerspoon/`

```
hammerspoon/
├── init.lua           # 入口
├── lib/               # 核心框架
│   ├── settings.lua   # 偏好设置
│   ├── hotkeys.lua    # 快捷键定义
│   └── utils.lua      # 工具函数
└── modules/           # 功能模块
    ├── apps.lua       # 应用控制
    ├── media.lua      # 媒体控制
    └── system.lua     # 系统工具
```

**Finder 专用快捷键**：
| 快捷键 | 功能 |
|--------|------|
| ⌘⌃⇧+T | 终端在此处打开 |
| ⌘⌃⇧+W | IDE 在此处打开 |
| ⌘⌃⇧+I | Nvim 编辑文件 |

## Karabiner 键盘映射

> 路径：`~/Documents/sync/karabiner/`

**核心映射**：
- **Hyper Key**：右 Command → Shift+Cmd+Opt+Ctrl
- **Caps Lock 增强**：Caps + HJKL → 方向键
- **Tab 功能键**：Tab + 数字 → F1-F10

## 修改规范

1. Yabai 应用规则改 `config/apps.conf`
2. Hammerspoon 快捷键改 `lib/hotkeys.lua`
3. Karabiner 规则改 `assets/*.json`
