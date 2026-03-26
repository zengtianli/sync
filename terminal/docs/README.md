# Yazi 配置文档

> 📍 位置：`~/Documents/sync/yazi/` → 软链接到 `~/.config/yazi/`

---

## 📁 目录结构

```
yazi/
├── init.lua          # 入口配置，加载插件
├── yazi.toml         # 主配置（布局、预览、打开器）
├── keymap.toml       # 快捷键配置 ⭐
├── theme.toml        # 主题颜色
├── starship.toml     # starship 提示符配置
├── package.toml      # 插件包管理（ya pack 自动生成）
├── bookmark          # 书签数据（yamb 自动管理）
├── plugins/          # 插件目录
│   ├── compress.yazi/
│   ├── git.yazi/
│   ├── smart-enter.yazi/
│   ├── starship.yazi/
│   ├── yamb.yazi/
│   └── yaziline.yazi/
├── docs/             # 📁 文档目录
│   ├── README.md     # 本文件
│   ├── keymap.md     # 快捷键详细说明
│   └── plugins.md    # 插件说明
└── .gitignore
```

---

## 🔧 各配置文件用途

| 文件 | 用途 | 修改频率 |
|------|------|----------|
| `init.lua` | 入口，加载插件，自定义 UI 组件 | 低 |
| `yazi.toml` | 主配置：面板比例、预览设置、打开器规则 | 中 |
| `keymap.toml` | **所有快捷键定义** ⭐ | 高 |
| `theme.toml` | 颜色、边框、模式显示样式 | 低 |
| `starship.toml` | 顶部提示符样式（需要 starship） | 低 |
| `package.toml` | 插件版本锁定（`ya pack` 自动生成） | 不手改 |
| `bookmark` | 书签数据文件（yamb 自动管理） | 自动 |

---

## ⌨️ 常用快捷键速查

### 导航（Vim 风格）

| 按键 | 功能 |
|------|------|
| `h` | 返回上级目录 |
| `l` / `Enter` | 进入目录 / 打开文件 |
| `j` / `k` | 下 / 上移动 |
| `J` / `K` | 下 / 上移动 5 行 |
| `Ctrl-j` / `Ctrl-k` | 下 / 上翻半页 |
| `gg` / `G` | 跳到顶部 / 底部 |
| `H` / `L` | 历史后退 / 前进 |

### 文件操作

| 按键 | 功能 |
|------|------|
| `yy` | 复制文件 |
| `dd` | 剪切文件 |
| `pp` | 粘贴 |
| `pP` | 强制粘贴（覆盖） |
| `pl` | 创建软链接 |
| `dD` | 永久删除 |
| `T` | 新建文件/目录 |
| `M` | 新建目录 |
| `cw` | 重命名（清空） |
| `a` / `A` | 重命名（扩展名前/末尾） |

### 搜索 & 跳转

| 按键 | 功能 |
|------|------|
| `Ctrl-p` | FZF 模糊搜索 |
| `zo` | Zoxide 智能跳转 |
| `f` | 过滤文件 |
| `/` / `n` / `N` | 查找 / 下一个 / 上一个 |
| `F` | Ripgrep 内容搜索 |
| `zh` | 切换隐藏文件 |

### 书签（yamb）

| 按键 | 功能 |
|------|------|
| `'a` | 添加书签 |
| `''` | FZF 跳转书签 |
| `'r` | 删除书签 |

### 快速目录（g 前缀）

| 按键 | 目录 |
|------|------|
| `gh` | ~ |
| `gc` | ~/.config |
| `gd` | ~/Downloads |
| `gfn` | ~/.config/nvim |
| `gfy` | ~/.config/yazi |

### 其他

| 按键 | 功能 |
|------|------|
| `Space` | 选择/取消 |
| `v` | 全选切换 |
| `S` | 打开 Shell |
| `Ctrl-g` | Lazygit |
| `w` | **Cursor 打开当前目录** |
| `ca` | 压缩文件 |
| `q` | 关闭/退出 |
| `~` | 帮助 |

---

## 🔌 插件列表

| 插件 | 功能 | 快捷键 |
|------|------|--------|
| **smart-enter** | 智能进入：目录则进入，文件则打开 | `l` / `Enter` |
| **git** | 显示 Git 文件状态（M/A/D 等） | 自动 |
| **yamb** | 书签管理，支持 FZF 模糊搜索 | `'a` / `''` / `'r` |
| **compress** | 压缩选中文件为 zip/tar 等 | `ca` |
| **starship** | 集成 starship 提示符 | 自动 |
| **yaziline** | 美化状态栏（类似 lualine） | 自动 |

详细说明见 [plugins.md](plugins.md)

---

## 📝 修改记录

| 日期 | 修改 |
|------|------|
| 2024-12 | 迁移到 sync 目录，软链接管理 |
| 2024-12 | `w` 改为打开 Cursor |
| 2024-12 | 删除 `k` 的重命名绑定（修复冲突） |











