# Hammerspoon 配置

这是一个高度模块化的 Hammerspoon 配置，提供丰富的快捷键和自动化功能，以提高 macOS 的使用效率。

## 功能概览

- **应用控制**：快速在当前目录打开终端/IDE、重启应用等
- **文件操作**：复制文件名、内容、文件压缩等
- **脚本运行**：快速执行脚本文件
- **剪贴板增强**：智能处理剪贴板内容
- **宏录制与播放**：记录和重复鼠标操作序列
- **媒体控制**：控制音乐播放、暂停等

## 核心快捷键

| 快捷键 | 功能 |
|-------|------|
| `⌘⌃⇧+T` | 在当前目录打开终端 |
| `⌘⌃⇧+W` | 在当前目录打开IDE |
| `⌘⌃⇧+S` | 运行选中脚本 |
| `⌘⌃⇧+N` | 复制文件名 |
| `⌘⌃⇧+;` | 音乐播放/暂停 |
| `⌘⌃⌥⇧+H` | 显示所有快捷键帮助 |

更多快捷键请参见帮助面板 (`⌘⌃⌥⇧+H`)。

## 目录结构

```
hammerspoon/
├── init.lua                  # 主入口文件
├── config/                   # 配置管理
│   ├── settings.lua          # 用户设置
│   └── hotkeys.lua           # 快捷键配置
├── modules/                  # 功能模块
│   ├── core/                 # 核心功能
│   │   ├── utils.lua         # 通用工具库
│   │   ├── script.lua        # 脚本执行
│   │   └── hotkeys.lua       # 热键管理
│   ├── apps/                 # 应用控制
│   │   ├── manager.lua       # 应用管理器
│   │   ├── restart.lua       # 应用重启
│   │   └── wechat.lua        # 微信启动器
│   ├── tools/                # 工具集
│   │   ├── clipboard.lua     # 剪贴板工具
│   │   ├── compress.lua      # 文件压缩
│   │   └── system.lua        # 系统工具
│   ├── media/                # 媒体控制
│   │   └── music.lua         # 音乐控制
│   └── macro/                # 宏系统
│       ├── recorder.lua      # 宏录制
│       ├── player.lua        # 宏播放
│       └── hotkeys.lua       # 宏快捷键
├── scripts/                  # 脚本目录
│   ├── apps/                 # 应用相关脚本
│   ├── tools/                # 工具脚本
│   ├── media/                # 媒体脚本
│   └── macro/                # 宏脚本
└── macros/                   # 宏文件存储
```

## 安装与配置

1. 安装 Hammerspoon：`brew install hammerspoon`
2. 克隆此仓库到 `~/.hammerspoon`：
   ```bash
   git clone https://github.com/username/hammerspoon-config.git ~/.hammerspoon
   ```
3. 配置自定义设置：编辑 `config/settings.lua`
4. 启动 Hammerspoon

## 自定义配置

编辑 `config/settings.lua` 文件以配置您偏好的应用：

```lua
-- 用户首选项设置
M.preferred_terminal = "Ghostty"  -- 可选: "Ghostty", "Warp", "Terminal" 
M.preferred_ide = "Windsurf"      -- 可选: "Cursor", "Windsurf", "VSCode"
```

## 开发与扩展

如需添加新功能，请参考以下步骤：

1. 在适当的 `modules/` 子目录下创建新模块
2. 在 `modules/init.lua` 中注册该模块
3. 在 `config/hotkeys.lua` 中添加快捷键定义
4. 重载 Hammerspoon 配置

## 贡献

欢迎提交 Pull Request 或创建 Issue 来改进此配置。 
