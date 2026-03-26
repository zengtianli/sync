# Yabai 窗口管理器配置集合

一个精简高效的 Yabai 配置和脚本集合，提供核心窗口管理功能。

## 🚀 项目特点

- **极度精简**：仅保留核心必需功能
- **高度模块化**：按功能分类的清晰目录结构
- **易于维护**：最小化文件数量，最大化实用性
- **直接可用**：通过软链接直接使用配置

## 📁 项目结构

```
yabai/
├── README.md               # 使用文档
├── config/                 # 配置文件 (4个)
│   ├── yabairc            # 主配置文件
│   ├── apps.conf          # 应用规则配置
│   ├── spaces.conf        # 空间配置
│   └── indicator.conf     # 指示器配置
└── scripts/               # 功能脚本 (8个)
    ├── lib/
    │   └── utils.sh       # 工具库
    ├── service/           # yabai服务控制
    │   └── toggle.sh      # 启动/停止/重启/切换/状态
    ├── window/            # 窗口管理 (3个)
    │   ├── resize.sh      # 调整窗口大小
    │   ├── move.sh        # 移动窗口
    │   └── float.sh       # 浮动/平铺切换
    └── space/             # 空间管理 (2个)
        ├── create.sh      # 创建空间
        └── navigate.sh    # 空间导航
```

## 🔧 安装使用

### 方法1: 软链接配置（推荐）
```bash
# 链接主配置文件
ln -sf $(pwd)/config/yabairc ~/.config/yabai/yabairc

# 链接其他配置文件（可选）
ln -sf $(pwd)/config/apps.conf ~/.config/yabai/apps.conf
ln -sf $(pwd)/config/spaces.conf ~/.config/yabai/spaces.conf
ln -sf $(pwd)/config/indicator.conf ~/.config/yabai/indicator.conf
```

### 方法2: 直接复制
```bash
# 复制配置文件到yabai配置目录
cp config/* ~/.config/yabai/
```

## 📖 功能说明

### 🎛️ yabai服务控制

```bash
# 服务管理
./scripts/service/toggle.sh start     # 启动yabai服务
./scripts/service/toggle.sh stop      # 停止yabai服务
./scripts/service/toggle.sh restart   # 重启yabai服务
./scripts/service/toggle.sh toggle    # 切换服务状态
./scripts/service/toggle.sh status    # 查看服务状态
```

### 🪟 窗口管理

```bash
# 调整窗口大小
./scripts/window/resize.sh increase   # 增加窗口大小
./scripts/window/resize.sh decrease   # 减小窗口大小
./scripts/window/resize.sh resize 800 600  # 调整到指定大小

# 移动窗口
./scripts/window/move.sh next         # 移动到下一个位置
./scripts/window/move.sh prev         # 移动到上一个位置
./scripts/window/move.sh to-space 2   # 移动到空间2

# 浮动/平铺切换
./scripts/window/float.sh toggle      # 切换浮动/平铺模式
./scripts/window/float.sh center      # 窗口居中
```

### 🖥️ 空间管理

```bash
# 创建空间
./scripts/space/create.sh             # 创建新空间
./scripts/space/create.sh with-window # 创建空间并移动当前窗口

# 空间导航
./scripts/space/navigate.sh next      # 切换到下一个空间
./scripts/space/navigate.sh prev      # 切换到上一个空间
./scripts/space/navigate.sh to 3      # 切换到空间3
./scripts/space/navigate.sh recent    # 切换到最近使用的空间
```

## ⚙️ 配置文件说明

### `config/yabairc`
主配置文件，包含：
- **基础设置**：分割类型、窗口间隙、边距
- **布局配置**：默认布局模式、自动平衡
- **窗口设置**：阴影、透明度、动画
- **鼠标配置**：修饰键、动作定义

### `config/apps.conf`
应用程序规则配置：
- **不受管理的应用**：系统应用、开发工具、效率工具等
- **特殊规则**：IDE、浏览器等特定窗口行为

### `config/spaces.conf`
空间配置：
- **空间布局**：每个空间的默认布局
- **空间标签**：自定义空间名称

### `config/indicator.conf`
状态指示器配置：
- **显示设置**：指示器样式、位置
- **状态信息**：当前空间、布局模式

## 🎯 核心特性

### ✨ 窗口管理
- **智能调整**：按步长或指定尺寸调整窗口
- **灵活移动**：支持方向性移动和跨空间移动
- **模式切换**：一键切换浮动/平铺模式

### 🏠 空间管理  
- **动态创建**：按需创建新空间
- **快速导航**：支持方向导航和直接跳转
- **窗口迁移**：创建空间时可同步移动窗口

### ⚡ 服务控制
- **状态管理**：完整的启动/停止/重启控制
- **状态查询**：实时显示服务状态和系统信息
- **智能切换**：根据当前状态自动切换

## 📋 简化对比

| 项目 | 简化前 | 简化后 | 改进 |
|------|--------|--------|------|
| 总文件数 | 41个 | 13个 | -68% |
| 目录数量 | 15个 | 7个 | -53% |
| 脚本数量 | 30+个 | 8个 | -73% |
| 核心功能 | 100% | 100% | 无损失 |
| 维护难度 | 复杂 | 简单 | 大幅降低 |

## 🛠️ 自定义配置

### 修改窗口调整步长
```bash
# 编辑 scripts/window/resize.sh
RESIZE_STEP=100  # 修改为你需要的像素值
```

### 添加应用规则
```bash
# 编辑 config/apps.conf
UNMANAGED_APPS+=(
    "YourApp"        # 添加不受管理的应用
)
```

### 自定义空间布局
```bash
# 编辑 config/spaces.conf
# 为特定空间设置默认布局
```

## 🔗 相关链接

- [Yabai 官方文档](https://github.com/koekeishiya/yabai)
- [Yabai Wiki](https://github.com/koekeishiya/yabai/wiki)
- [skhd 快捷键工具](https://github.com/koekeishiya/skhd)

## 📄 许可证

[MIT License](LICENSE)


