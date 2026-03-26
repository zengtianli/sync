# Tmux 配置

基于 [theniceboy/.config](https://github.com/theniceboy/.config) 改编，适配 QWERTY 键盘 + vim 方向键。

## 安装

```bash
# 1. 软链接（已完成）
ln -sf ~/Documents/sync/tmux/tmux.conf ~/.tmux.conf

# 2. TPM 插件管理器（已完成）
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# 3. 启动 tmux 后安装插件
tmux
# 按 M-s I（prefix + Shift+i）安装插件
```

## 核心概念

tmux 有三层结构：

```
Session（会话）
  └── Window（窗口，类似浏览器 Tab）
        └── Pane（面板，窗口内的分屏）
```

- **Session**：一个工作上下文，断开终端后还在后台跑
- **Window**：底部状态栏显示的标签页
- **Pane**：一个窗口里的多个分屏

## Prefix 键

本配置的 prefix 是 **`m-s`**（opt+s）。

很多操作需要 **先按 prefix，松手，再按功能键**。文档中 `prefix + x` 表示：先按 `M-s`，松手，再按 `x`。

带 `M-`（Alt）前缀的操作 **不需要 prefix**，直接按。

---

## 快捷键总表

### 日常操作（无需 prefix）

| 按键 | 功能 |
|------|------|
| `M-o` | 新建窗口（在当前目录） |
| `M-w` | 关闭当前 pane |
| `M-O` | 把 pane 拆出为独立窗口 |
| `M-f` | 当前 pane 全屏/还原 |
| `M-v` | 进入复制模式 |
| `M-V` | 从系统剪贴板粘贴 |

### 窗口切换（无需 prefix）

| 按键 | 功能 |
|------|------|
| `M-1` ~ `M-9` | 跳到第 N 个窗口 |
| `M-,` | 当前窗口左移 |
| `M-.` | 当前窗口右移 |

### Pane 导航（无需 prefix）

| 按键 | 功能 |
|------|------|
| `M-h` | 跳到左边 pane |
| `M-j` | 跳到下边 pane |
| `M-k` | 跳到上边 pane |
| `M-l` | 跳到右边 pane |

### Pane 大小调整（无需 prefix）

| 按键 | 功能 |
|------|------|
| `M-H` | 向左扩展 3 格 |
| `M-J` | 向下扩展 3 格 |
| `M-K` | 向上扩展 3 格 |
| `M-L` | 向右扩展 3 格 |

### 分屏（prefix + 方向）

| 按键 | 功能 | 助记 |
|------|------|------|
| `prefix h` | 在左边开新 pane | ← |
| `prefix j` | 在下边开新 pane | ↓ |
| `prefix k` | 在上边开新 pane | ↑ |
| `prefix l` | 在右边开新 pane | → |

### Session & 管理（prefix）

| 按键 | 功能 |
|------|------|
| `prefix C-c` | 新建 session |
| `prefix ,` | 重命名当前窗口 |
| `prefix .` | 重命名当前 session |
| `prefix W` | 树形浏览所有 session/window |
| `prefix d` | 断开（detach），tmux 在后台继续跑 |
| `prefix r` | 重载配置文件 |

### Pane 交换 & 布局（prefix）

| 按键 | 功能 |
|------|------|
| `prefix >` | 当前 pane 和下一个交换 |
| `prefix <` | 当前 pane 和上一个交换 |
| `prefix Space` | 切换下一个内置布局 |
| `prefix H/J/K/L` | 选择预设布局 |

### 复制模式

按 `M-v` 进入，操作和 vim 一样：

| 按键 | 功能 |
|------|------|
| `h/j/k/l` | 移动光标 |
| `J/K` | 快速上下移动（5行） |
| `w/e/b` | 按词移动 |
| `0` / `$` | 行首 / 行尾 |
| `C-u` / `C-d` | 向上/向下翻页 |
| `/` / `?` | 向下/向上搜索 |
| `n` / `N` | 下一个/上一个匹配 |
| `v` | 开始选择 |
| `C-v` | 矩形选择 |
| `y` | 复制选区到系统剪贴板 |
| `q` | 退出复制模式 |

---

## 常用场景

### 开始工作

```bash
tmux                    # 启动（或恢复上次 session）
tmux new -s work        # 以 "work" 为名新建 session
```

### 分屏写代码

```
prefix l    → 右边开终端
prefix j    → 下面开终端
M-h/j/k/l  → 在 pane 间跳转
M-f         → 某个 pane 全屏看代码，再按还原
```

### 多窗口

```
M-o         → 新窗口
M-1 ~ M-9  → 切窗口（看状态栏数字）
M-w         → 关掉不用的 pane
```

### 断开与恢复

```bash
prefix d              # 断开，回到普通终端（tmux 后台运行）
tmux attach           # 重新接入
tmux ls               # 列出所有 session
tmux attach -t work   # 接入名为 work 的 session
```

### 复制终端内容

```
M-v         → 进入复制模式
hjkl 移动到起点
v           → 开始选择
移动到终点
y           → 复制（自动退出复制模式，内容已在系统剪贴板）
Cmd+v       → 在任何地方粘贴
```

---

## 插件

| 插件 | 功能 |
|------|------|
| [tpm](https://github.com/tmux-plugins/tpm) | 插件管理器 |
| [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) | 手动保存/恢复 session 布局 |
| [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum) | 每 5 分钟自动保存 |

插件操作：

| 按键 | 功能 |
|------|------|
| `prefix I` | 安装新插件（首次必做） |
| `prefix U` | 更新插件 |
| `prefix s` | 手动保存 session（resurrect） |
| `prefix C-r` | 恢复 session（resurrect） |

---

## 文件结构

```
~/Documents/sync/tmux/
├── tmux.conf          ← 配置文件（本文件）
└── README.md          ← 你在看的这个

~/.tmux.conf           → symlink → sync/tmux/tmux.conf
~/.tmux/plugins/tpm/   ← TPM 插件管理器
```
