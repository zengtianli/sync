根据您提供的 yazi 配置文件，我整理了一份完整的快捷键列表：

## Yazi 快捷键列表

### 基础操作

| 快捷键 | 功能 | 描述 |
|:---|:---|:---|
| `<Esc>` / `<C-[>` | escape | 退出视觉模式、清除选择或取消搜索 |
| `q` | close | 关闭当前标签页，如果是最后一个则退出 |
| `Q` | quit --no-cwd-file | 退出进程且不写入 cwd 文件 |
| `<C-z>` | suspend | 挂起进程 |
| `R` | reload | 刷新当前目录 |

### 光标移动

| 快捷键 | 功能 | 描述 |
|:---|:---|:---|
| `k` / `<Up>` | arrow -1 | 向上移动光标 |
| `j` / `<Down>` | arrow 1 | 向下移动光标 |
| `<C-k>` / `<S-PageUp>` | arrow -50% | 向上移动半页 |
| `<C-j>` / `<S-PageDown>` | arrow 50% | 向下移动半页 |
| `K` | arrow -5 | 向上移动 5 行 |
| `J` | arrow 5 | 向下移动 5 行 |
| `<PageUp>` | arrow -100% | 向上移动一页 |
| `<PageDown>` | arrow 100% | 向下移动一页 |
| `gg` | arrow top | 移动到顶部 |
| `G` | arrow bot | 移动到底部 |

### 导航

| 快捷键 | 功能 | 描述 |
|:---|:---|:---|
| `h` / `<Left>` | leave | 返回父目录 |
| `l` / `<Right>` / `<Enter>` | plugin smart-enter | 进入子目录（智能进入） |
| `H` | back | 返回上一个目录 |
| `L` | forward | 前进到下一个目录 |

### 选择操作

| 快捷键 | 功能 | 描述 |
|:---|:---|:---|
| `<Space>` | toggle + arrow 1 | 切换当前选择状态并向下移动 |
| `v` | toggle_all | 进入视觉模式（选择模式） |
| `V` | visual_mode --unset | 进入视觉模式（取消设置模式） |

### 查找和搜索

| 快捷键 | 功能 | 描述 |
|:---|:---|:---|
| `<C-p>` | plugin fzf | 使用 fzf 跳转目录或显示文件 |
| `zo` | plugin zoxide | 使用 zoxide 跳转目录 |
| `F` | search rg | 使用 ripgrep 按内容搜索文件 |
| `<C-s>` | escape --search | 取消正在进行的搜索 |
| `f` | filter --smart | 过滤文件 |
| `/` | find --smart | 查找下一个文件 |
| `?` | find --previous --smart | 查找上一个文件 |
| `n` | find_arrow | 跳转到下一个查找结果 |
| `N` | find_arrow --previous | 跳转到上一个查找结果 |

### Shell 命令

| 快捷键 | 功能 | 描述 |
|:---|:---|:---|
| `S` | shell "$SHELL" --block --confirm | 打开 Shell |
| `<C-g>` | shell --confirm --block lazygit | 打开 Lazygit |
| `;` | shell --interactive | 运行 Shell 命令 |
| `:` | shell --block --interactive | 运行 Shell 命令（阻塞直到完成） |

### 文件操作

| 快捷键 | 功能 | 描述 |
|:---|:---|:---|
| `r` | open --interactive | 交互式打开选中文件 |
| `T` | create | 创建文件（以 / 结尾创建目录） |
| `M` | create --dir | 创建目录 |
| `zh` | hidden toggle | 切换隐藏文件的可见性 |

### 重命名

| 快捷键 | 功能 | 描述 |
|:---|:---|:---|
| `cw` | rename --empty=all | 重命名选中文件（清空所有） |
| `k` | rename --cursor=start | 重命名选中文件（光标在开始） |
| `a` | rename --cursor=before_ext | 重命名选中文件（光标在扩展名前） |
| `A` | rename --cursor=end | 重命名选中文件（光标在末尾） |

### 复制/剪切/粘贴

| 快捷键 | 功能 | 描述 |
|:---|:---|:---|
| `dd` | yank --cut | 剪切选中文件 |
| `dD` | remove --permanently | 永久删除选中文件 |
| `yy` | yank | 复制选中文件 |
| `yp` | copy path | 复制文件路径 |
| `yd` | copy dirname | 复制目录路径 |
| `yf` | copy filename | 复制文件名 |
| `yn` | copy name_without_ext | 复制不带扩展名的文件名 |
| `yc` | unyank | 取消复制状态 |
| `pp` | paste | 粘贴文件 |
| `pP` | paste --force | 强制粘贴文件（覆盖） |
| `pl` | link | 创建绝对路径符号链接 |
| `pL` | link --relative | 创建相对路径符号链接 |
| `ph` | hardlink | 创建硬链接 |

### 行模式

| 快捷键 | 功能 | 描述 |
|:---|:---|:---|
| `ms` | linemode size | 设置行模式为大小 |
| `mp` | linemode perm | 设置行模式为权限 |
| `mc` | linemode btime | 设置行模式为创建时间 |
| `mm` | linemode mtime | 设置行模式为修改时间 |
| `mo` | linemode owner | 设置行模式为所有者 |
| `mn` | linemode none | 设置行模式为无 |

### 排序

| 快捷键 | 功能 | 描述 |
|:---|:---|:---|
| `oM` | sort mtime --reverse=no + linemode mtime | 按修改时间排序 |
| `om` | sort mtime --reverse + linemode mtime | 按修改时间排序（反向） |
| `oC` | sort btime --reverse=no + linemode btime | 按创建时间排序 |
| `oc` | sort btime --reverse + linemode btime | 按创建时间排序（反向） |
| `oE` | sort extension --reverse=no | 按扩展名排序 |
| `oe` | sort extension --reverse | 按扩展名排序（反向） |
| `oa` | sort alphabetical --reverse=no | 按字母顺序排序 |
| `oA` | sort alphabetical --reverse | 按字母顺序排序（反向） |
| `on` | sort natural --reverse=no | 自然排序 |
| `oN` | sort natural --reverse | 自然排序（反向） |
| `os` | sort size --reverse=no + linemode size | 按大小排序 |
| `oS` | sort size --reverse + linemode size | 按大小排序（反向） |

### 快速跳转

| 快捷键 | 功能 | 描述 |
|:---|:---|:---|
| `gr` | cd / | 跳转到根目录 |
| `gh` | cd ~ | 跳转到主目录 |
| `gc` | cd ~/.config | 跳转到配置目录 |
| `gd` | cd ~/Downloads | 跳转到下载目录 |
| `gD` | cd ~/Desktop | 跳转到桌面目录 |
| `gi` | cd ~/Github | 跳转到 Github 目录 |
| `gff` | cd ~/.config | 跳转到 .config |
| `gfn` | cd ~/.config/nvim | 跳转到 nvim 配置目录 |
| `gfy` | cd ~/.config/yazi | 跳转到 yazi 配置目录 |
| `gfl` | cd ~/.config/jesseduffield/lazygit | 跳转到 lazygit 配置目录 |
| `g<Space>` | cd --interactive | 交互式跳转目录 |

### 标签页

| 快捷键 | 功能 | 描述 |
|:---|:---|:---|
| `tt` | tab_create --current | 在当前目录创建新标签页 |
| `th` | tab_switch -1 --relative | 切换到上一个标签页 |
| `tl` | tab_switch 1 --relative | 切换到下一个标签页 |
| `1-9` | tab_switch 0-8 | 切换到第 1-9 个标签页 |

### 其他功能

| 快捷键 | 功能 | 描述 |
|:---|:---|:---|
| `w` | tasks_show | 显示任务管理器 |
| `~` / `<F1>` | help | 打开帮助 |
| `P` | spot | 打开 spotter |
| `ca` | plugin compress | 压缩选中文件 |
| `'a` | plugin yamb save | 添加书签 |
| `''` | plugin yamb jump_by_fzf | 通过 fzf 跳转书签 |
| `'r` | plugin yamb delete_by_key | 通过键删除书签 |

### 任务管理器快捷键

| 快捷键 | 功能 | 描述 |
|:---|:---|:---|
| `<Esc>` / `<C-[>` / `<C-c>` / `w` | close | 关闭任务管理器 |
| `k` / `<Up>` | arrow -1 | 向上移动光标 |
| `j` / `<Down>` | arrow 1 | 向下移动光标 |
| `<Enter>` | inspect | 检查任务 |
| `x` | cancel | 取消任务 |

### Spotter 快捷键

| 快捷键 | 功能 | 描述 |
|:---|:---|:---|
| `k` | arrow -1 | 向上移动 |
| `j` | arrow 1 | 向下移动 |
| `<Esc>` / `q` | close | 关闭 spotter |
| `<C-k>` | swipe -5 | 向上滑动 5 个文件 |
| `<C-j>` | swipe 5 | 向下滑动 5 个文件 |
| `y` | copy cell | 复制单元格内容 |
### 选择器（Pick）快捷键

| 快捷键 | 功能 | 描述 |
|:---|:---|:---|
| `<Esc>` / `<C-[>` / `<C-c>` | close | 取消选择 |
| `<Enter>` | close --submit | 提交选择 |
| `k` / `<Up>` | arrow -1 | 向上移动光标 |
| `j` / `<Down>` | arrow 1 | 向下移动光标 |
| `~` / `<F1>` | help | 打开帮助 |

### 输入模式快捷键

| 快捷键 | 功能 | 描述 |
|:---|:---|:---|
| `<C-c>` | close | 取消输入 |
| `<Enter>` | close --submit | 提交输入 |
| `<Esc>` / `<C-[>` | escape | 返回正常模式或取消输入 |

#### 模式切换
| 快捷键 | 功能 | 描述 |
|:---|:---|:---|
| `i` | insert | 进入插入模式 |
| `a` | insert --append | 进入追加模式 |
| `I` | move -999 + insert | 移动到行首并进入插入模式 |
| `A` | move 999 + insert --append | 移动到行尾并进入追加模式 |
| `v` | visual | 进入视觉模式 |
| `V` | move -999 + visual + move 999 | 进入视觉模式并选择全部 |

#### 字符移动
| 快捷键 | 功能 | 描述 |
|:---|:---|:---|
| `h` / `<Left>` / `<C-b>` | move -1 | 向后移动一个字符 |
| `l` / `<Right>` / `<C-f>` | move 1 | 向前移动一个字符 |

#### 单词移动
| 快捷键 | 功能 | 描述 |
|:---|:---|:---|
| `b` / `<A-b>` | backward | 移动到当前或上一个单词的开头 |
| `w` | forward | 移动到下一个单词的开头 |
| `e` / `<A-f>` | forward --end-of-word | 移动到当前或下一个单词的结尾 |

#### 行移动
| 快捷键 | 功能 | 描述 |
|:---|:---|:---|
| `0` / `<C-a>` / `<Home>` | move -999 | 移动到行首 |
| `$` / `<C-e>` / `<End>` | move 999 | 移动到行尾 |

#### 删除操作
| 快捷键 | 功能 | 描述 |
|:---|:---|:---|
| `<Backspace>` / `<C-h>` | backspace | 删除光标前的字符 |
| `<Delete>` / `<C-j>` | backspace --under | 删除光标下的字符 |

#### 删除（Kill）操作
| 快捷键 | 功能 | 描述 |
|:---|:---|:---|
| `<C-k>` | kill bol / kill eol | 删除到行首/行尾 |
| `<C-w>` | kill backward | 删除到当前单词开头 |
| `<A-d>` | kill forward | 删除到当前单词结尾 |

#### 剪切/复制/粘贴
| 快捷键 | 功能 | 描述 |
|:---|:---|:---|
| `d` | delete --cut | 剪切选中的字符 |
| `D` | delete --cut + move 999 | 剪切到行尾 |
| `c` | delete --cut --insert | 剪切选中字符并进入插入模式 |
| `C` | delete --cut --insert + move 999 | 剪切到行尾并进入插入模式 |
| `x` | delete --cut + move 1 --in-operating | 剪切当前字符 |
| `y` | yank | 复制选中的字符 |
| `p` | paste | 在光标后粘贴 |
| `P` | paste --before | 在光标前粘贴 |

#### 撤销/重做
| 快捷键 | 功能 | 描述 |
|:---|:---|:---|
| `u` | undo | 撤销上一个操作 |
| `<C-r>` | redo | 重做上一个操作 |

### 自动补全快捷键

| 快捷键 | 功能 | 描述 |
|:---|:---|:---|
| `<C-c>` | close | 取消补全 |
| `<Tab>` | close --submit | 提交补全 |
| `<Enter>` | close --submit + close_input --submit | 提交补全和输入 |
| `<Up>` / `k` | arrow -1 | 向上移动光标 |
| `<Down>` / `j` | arrow 1 | 向下移动光标 |
| `~` / `<F1>` | help | 打开帮助 |

### 帮助界面快捷键

| 快捷键 | 功能 | 描述 |
|:---|:---|:---|
| `<Esc>` / `<C-[>` | escape | 清除过滤器或隐藏帮助 |
| `q` | close | 退出进程 |
| `<C-c>` | close | 隐藏帮助 |
| `k` / `<Up>` | arrow -1 | 向上移动光标 |
| `j` / `<Down>` | arrow 1 | 向下移动光标 |
| `f` | filter | 为帮助项应用过滤器 |

## 特殊说明

1. **组合键**：某些功能需要按顺序按下多个键，如 `gg` 表示先按 `g` 再按 `g`
2. **智能进入**：`l` 和 `<Enter>` 使用了 `smart-enter` 插件，可以智能判断是进入目录还是打开文件
3. **插件功能**：一些功能依赖于插件，如 `fzf`、`zoxide`、`yamb`（书签管理）、`compress`（压缩）等
4. **模式切换**：Yazi 有多种模式（正常模式、视觉模式、输入模式等），不同模式下的快捷键功能可能不同

这份配置文件展示了一个高度定制化的 Yazi 设置，包含了许多 Vim 风格的快捷键绑定。



