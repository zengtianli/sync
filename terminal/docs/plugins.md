# Yazi 插件说明

> 所有插件通过 `ya pack` 管理，配置在 `package.toml`

---

## 📦 已安装插件

### 1. smart-enter.yazi

**来源：** `yazi-rs/plugins:smart-enter`

**功能：** 智能进入 - 一个按键搞定「进入目录」和「打开文件」

**使用场景：**
- 按 `l` 或 `Enter`
- 如果是目录 → 进入目录
- 如果是文件 → 用默认程序打开（如 nvim）

**配置位置：** `keymap.toml` prepend_keymap

---

### 2. git.yazi

**来源：** `yazi-rs/plugins:git`

**功能：** 在文件列表显示 Git 状态标记

**显示标记：**
| 标记 | 含义 |
|------|------|
| M | 已修改 (Modified) |
| A | 已添加 (Added) |
| D | 已删除 (Deleted) |
| ? | 未跟踪 (Untracked) |
| ! | 已忽略 (Ignored) |

**使用场景：**
- 在 Git 仓库中浏览文件时自动显示
- 快速识别哪些文件有改动

**配置位置：** `init.lua` + `yazi.toml` fetchers

---

### 3. yamb.yazi (Yet Another Bookmarks)

**来源：** `h-hg/yamb`

**功能：** 持久化书签管理，支持 FZF 模糊搜索

**快捷键：**
| 按键 | 功能 |
|------|------|
| `'a` | 添加当前目录到书签 |
| `''` | FZF 模糊搜索书签并跳转 |
| `'r` | 删除书签 |

**使用场景：**
- 经常访问的目录，按 `'a` 加入书签
- 随时按 `''` 快速跳转

**数据存储：** `~/.config/yazi/bookmark`

**配置位置：** `init.lua` + `keymap.toml`

---

### 4. compress.yazi

**来源：** `KKV9/compress`

**功能：** 压缩选中的文件/文件夹为归档文件

**支持格式：**
| 格式 | 命令 |
|------|------|
| .zip | zip -r |
| .7z | 7z a |
| .tar | tar rpf |
| .tar.gz | gzip |
| .tar.xz | xz |
| .tar.bz2 | bzip2 |
| .tar.zst | zstd |

**快捷键：** `ca` (compress archive)

**使用场景：**
1. 选中要压缩的文件（Space 选择）
2. 按 `ca`
3. 输入文件名（如 `backup.zip`）
4. 根据扩展名自动选择压缩方式

**配置位置：** `keymap.toml` prepend_keymap

---

### 5. starship.yazi

**来源：** `Rolv-Apneseth/starship`

**功能：** 集成 starship 提示符，显示在 yazi 顶部

**前置要求：** 安装 [starship](https://starship.rs/)

**使用场景：**
- 在 yazi 顶部显示当前路径、Git 分支等信息
- 使用自定义 starship 配置文件

**配置位置：** `init.lua` + `starship.toml`

```lua
-- init.lua
require("starship"):setup {
    config_file = "~/.config/yazi/starship.toml",
}
```

---

### 6. yaziline.yazi

**来源：** `llanosrocas/yaziline`

**功能：** 美化状态栏（底部），类似 Neovim 的 lualine

**显示内容：**
- 左侧：选中文件数、复制/剪切状态、文件名
- 右侧：文件权限、大小、修改时间

**样式选项：**
- `angly` - 尖角样式
- `curvy` - 圆角样式
- `liney` - 线条样式
- `empty` - 无分隔符

**配置位置：** `init.lua`

```lua
-- init.lua
require("yaziline"):setup {
    separator_style = "curvy",
    filename_max_length = 24,
}
```

---

## 🔄 插件管理命令

```bash
# 更新所有插件
ya pack -u

# 安装新插件
ya pack -a <author>/<plugin>

# 查看已安装插件
cat ~/.config/yazi/package.toml
```

---

## 📝 插件加载顺序

在 `init.lua` 中按以下顺序加载：

```lua
-- 1. 状态栏美化
require("yaziline"):setup { ... }

-- 2. starship 提示符
require("starship"):setup { ... }

-- 3. Git 状态
require("git"):setup {}

-- 4. 书签管理
require("yamb"):setup { ... }
```

---

## ⚙️ 当前配置 (init.lua)

```lua
require("yaziline"):setup {
    separator_style = "curvy",
    select_symbol = "",
    yank_symbol = "󰆐",
    filename_max_length = 24,
    filename_trim_length = 6
}

require("starship"):setup {
    config_file = "~/.config/yazi/starship.toml",
}

require("git"):setup {}

-- 自定义状态栏：显示文件所有者
Status:children_add(function()
    local h = cx.active.current.hovered
    if h == nil or ya.target_family() ~= "unix" then
        return ui.Line {}
    end
    return ui.Line {
        ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
        ui.Span(":"),
        ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
        ui.Span(" "),
    }
end, 500, Status.RIGHT)

require("yamb"):setup {
    cli = "fzf",
}
```











