更新与纠偏
-  exa 已长期不维护，推荐用 eza（兼容 exa 参数，更活跃）。
-  除了 ripgrep (rg)，还可看 ugrep（功能与兼容性很强）与 ripgrep-all (rga)（能搜索 PDF、Office 等二进制/索引文件）。
-  JSON 之外，YAML/TOML/混合格式可用 yq、dasel 统一处理。
-  man 的现代替代不止 tldr，可配合 cheat/navi 做“交互式速查表”。

更多现代替代（补充表）
| 类别 | 传统工具 | 现代替代 | 亮点 |
|---|---|---|---|
| 列表/浏览 | ls | eza / lsd / broot | 彩色、Git 状态、树/预览、图标 |
| 终端文件管理 | mc | yazi / nnn / vifm | 轻量快速、预览、插件生态 |
| 目录跳转 | cd | zoxide | 记忆分数，模糊跳转极快 |
| 查找文件 | find | fd | 直观语法、默认忽略 .gitignore |
| 模糊检索 | - | fzf | 通用模糊选择器，易集成 |
| 文本查看 | cat | bat | 高亮、行号、分页、Git 集成 |
| 十六进制 | xxd/hexdump | hexyl | 彩色分栏、人类友好 |
| JSON 处理 | grep/sed | jq / jaq / fx | 结构化/交互式处理 |
| YAML/TOML | - | yq / dasel | 多格式统一选择器 |
| 全文搜索 | grep | ripgrep / ugrep / ag | 快、忽略规则、递归与高亮 |
| 二进制/多格式搜索 | - | rga (ripgrep-all) | 搜 PDF/Office/epub 等 |
| 文本替换 | sed | sd | 现代语法、速度快 |
| CSV/TSV | cut/awk | xsv / qsv / Miller(mlr) | 列操作、聚合、统计超强 |
| 结构化数据浏览 | - | Visidata | 交互式浏览 CSV/JSON/sql 等 |
| diff/patch | diff | delta / difftastic | 语义 diff、语法高亮 |
| 进程/系统 | top | htop / btop / bottom | TUI 友好、交互强 |
| 进程列表 | ps | procs | 彩色、多列过滤、树形 |
| 磁盘空间 | du | ncdu / dust / dua / gdu | 交互/图形化/超快扫描 |
| 磁盘使用 | df | duf | 彩色表格、排序与分组 |
| 网络带宽 | iftop/nethogs | bandwhich / nethogs | 进程级带宽统计 |
| 延迟/连通 | ping/traceroute | gping / mtr | 图形化延迟曲线/诊断 |
| DNS 查询 | dig | dog | 友好输出、更多协议 |
| HTTP 客户端 | curl/wget | httpie / curlie / xh | 交互友好、彩色、JSON |
| 文件传输 | scp | rsync / rclone / croc | 增量/云端/点对点传输 |
| 远程连接 | ssh | mosh | 弱网/移动网络下稳定 |
| Git TUI | git | lazygit / gitui / tig | 交互式操作、快速提交/变基 |
| 容器 | docker | podman / nerdctl / lazydocker | 无守护进程/Rootless/TUI |
| 镜像分析 | - | dive | 分层体积/差异分析 |
| 终端复用 | tmux | zellij | 现代键位、布局直观 |
| 提示符 | bash/zsh 默认 | starship | 跨壳、快速美观 |
| 历史搜索 | Ctrl+r | atuin / mcfly | 语义/模糊匹配、云同步 |
| 监控“转 JSON” | - | jc | 各种命令输出转 JSON |
| 任务运行器 | make(临时脚本) | just | 更适合日常脚本化任务 |
| 监视执行 | while/inotify | watchexec / entr | 文件变更触发命令 |
| 基准测试 | time | hyperfine | 稳健统计、对比多命令 |
| 文档速查 | man | tldr / tealdeer / cheat / navi | 示例导向/交互式速查 |
| 加密 | gpg | age | 简单、现代、脚本友好 |
| 系统信息 | neofetch | fastfetch | 更快、更活跃维护 |

实用集成示例（放进 shell 配置）
-  eza 替代 ls
  - alias ll="eza -l --icons --group-directories-first"
  - alias lt="eza -T -L 2 --icons"
-  zoxide 智能跳转
  - eval "$(zoxide init zsh)"  # 或 bash/fish
  - cd 项目 -> z 项目名 即可直达
-  fzf × ripgrep：默认检索所有文件
  - export FZF_DEFAULT_COMMAND='rg --files --hidden --follow -g "!.git"'
-  bat 作为 pager
  - export PAGER="bat"
  - git config --global core.pager "bat -p"
-  git diff 更现代
  - git config --global core.pager "delta"
  - git config --global delta.navigate true

安装示例（常见平台）
-  macOS (Homebrew)
  - brew install eza zoxide fd fzf bat ripgrep sd jq yq miller xsv delta btop procs duf dust dog httpie xh mtr bandwhich rclone croc lazygit zellij starship atuin hyperfine jc dive
-  Debian/Ubuntu
  - sudo apt update
  - sudo apt install fd-find ripgrep jq yq ncdu mtr-tiny nethogs rsync rclone bat fzf btop procs duf
  - 其他（eza、delta、zoxide、dust、bandwhich、lazygit、zellij、atuin 等）可用官方 release 或第三方仓库（如 apt repo、brew on Linux、nix）。
-  Arch
  - sudo pacman -S eza zoxide fd fzf bat ripgrep sd jq yq miller xsv delta btop procs duf dust dog httpie mtr nethogs rclone croc lazygit zellij starship atuin hyperfine jc dive
-  Fedora
  - sudo dnf install eza zoxide fd-find fzf bat ripgrep jq yq miller xsv git-delta btop procs duf dust dog httpie mtr nethogs rclone croc lazygit zellij starship atuin hyperfine jc

选择与实践建议
-  生产环境谨慎替换：脚本中保持 POSIX 工具兼容；交互使用可大胆采用现代工具。
-  关注维护活跃度：优先选维护频繁、社区大、文档齐全的项目（如 eza、ripgrep、bat、zoxide、fzf）。
-  形成“组合拳”：fd + rg + fzf + bat + zoxide 能显著提升日常效率。
-  数据管道现代化：结构化优先（jc → jq/yq/mlr），文本管道更稳健、更易测试。

如果你给我常用场景（例如“在大型单仓里搜代码并快速打开”、“定位磁盘大文件并批量删除”、“排查网络延迟与 DNS 问题”等），我可以按场景给你一套更贴身的命令组合与别名。


综合推荐榜（macOS）
| 排名 | 工具 | 替代 | 亮点 | brew 安装名 |
|---|---|---|---|---|
| 1 | ripgrep (rg) | grep | 代码级超快全文搜索，尊重 .gitignore，高亮 | ripgrep |
| 2 | fzf | Ctrl+r/交互选择 | 通用模糊选取器，能嵌入一切工作流 | fzf |
| 3 | zoxide | cd | 目录“记忆分数”跳转，极致省时 | zoxide |
| 4 | eza | ls | 彩色/图标/Git 状态/树形视图 | eza |
| 5 | bat | cat/less | 语法高亮、行号、Git 集成、自动分页 | bat |
| 6 | fd | find | 直观语法、默认快且智能忽略 | fd |
| 7 | lazygit | git（交互） | Git TUI 高效提交/变基/查看差异 | lazygit |
| 8 | delta | diff/less | 语法高亮、侧边行号、Git 友好 | git-delta |
| 9 | btop | top | 漂亮 TUI，CPU/内存/进程可视化强 | btop |
| 10 | httpie | curl/wget | 人类友好，彩色 JSON，命令直观 | httpie |
| 11 | jq | grep/sed 处理 JSON | 结构化查询/过滤/变换 | jq |
| 12 | yq | yml/toml/json | 多格式统一处理（YAML/JSON/TOML） | yq |
| 13 | sd | sed | 现代语法、默认安全、正则简洁 | sd |
| 14 | procs | ps | 彩色高亮、树形与过滤 | procs |
| 15 | duf | df | 彩色表格、排序/分组，读数直观 | duf |
| 16 | dust | du | 目录占用可视化、更快更清晰 | dust |
| 17 | zellij | tmux | 现代复用/布局/键位，易上手 | zellij |
| 18 | starship | shell 提示符 | 跨壳极快美观，信息密度高 | starship |
| 19 | atuin | Ctrl+r 历史 | 云同步/语义搜索/统计 | atuin |
| 20 | just | make(小任务) | 更适合日常命令配方与脚本 | just |
| 21 | hyperfine | time/bench | 稳健基准测试，多轮统计对比 | hyperfine |
| 22 | dog | dig | 更友好的 DNS 查询输出 | dog |
| 23 | bandwhich | iftop/nethogs | 进程/连接级带宽统计 | bandwhich |
| 24 | mosh | ssh（弱网） | 高延迟/抖动环境更稳 | mosh |
| 25 | rclone | scp/rsync(云) | 各云存储/协议统一同步 | rclone |
| 26 | croc | scp/临时共享 | 点对点安全传文件，零配置 | croc |
| 27 | age | gpg | 现代加密，简单脚本友好 | age |
| 28 | jc | 标准命令输出→JSON | 将 ls/ifconfig 等解析为 JSON | jc |
| 29 | Miller (mlr) | awk/cut/csvkit | 表格/记录型数据的瑞士军刀 | miller |
| 30 | yazi | mc/nnn | 超快 TUI 文件管理，预览/跳转强 | yazi |
| 31 | difftastic | diff | 语义差异（按语法树） | difftastic |
| 32 | lazydocker | docker 命令行 | 容器/日志/资源 TUI 管理 | lazydocker |
| 33 | gping | ping | 延迟曲线可视化，直观 | gping |
| 34 | visidata | CSV/JSON/sql 交互 | 终端里数据探索/汇总超强 | visidata |
| 35 | ugrep | grep | 兼容特性全、功能密集 | ugrep |
| 36 | watchexec | while/inotify | 文件变更触发命令，开发友好 | watchexec |
| 37 | dasel | yq/jq 补充 | 单一语法跨 JSON/YAML/TOML 查询 | dasel |
| 38 | dive | 镜像分析 | Docker/OCI 镜像分层体积/差异 | dive |

快速安装（建议先装前 20）
-  一键安装 Top 20:
  - brew install ripgrep fzf zoxide eza bat fd lazygit git-delta btop httpie jq yq sd procs duf dust zellij starship atuin just
-  实用加装:
  - brew install hyperfine dog bandwhich mosh rclone croc age jc miller yazi difftastic lazydocker gping visidata ugrep watchexec dasel dive
  - ripgrep-all（如需搜索 PDF/Office/epub）：brew tap phiresky/ripgrep-all && brew install rga

使用建议
-  交互优先组合（高频提效）：fd + rg + fzf + bat + zoxide + atuin
-  代码协作：lazygit + delta/difftastic
-  数据/配置：jc → jq/yq/mlr，尽量结构化处理
-  生产脚本仍以 POSIX 工具为基线，现代工具用于交互与本机自动化

如果你有具体场景（比如“在大仓库里搜定义并跳到文件”、“排查磁盘暴涨”、“HTTP 接口调试”），我可以按场景给出更贴身的命令组合和别名。

---

TIANLI ZENG: ```
| 1 | ripgrep (rg) | grep | 代码级超快全文搜索，尊重 .gitignore，高亮 | ripgrep |
| 2 | fzf | Ctrl+r/交互选择 | 通用模糊选取器，能嵌入一切工作流 | fzf |
| 3 | zoxide | cd | 目录“记忆分数”跳转，极致省时 | zoxide |
| 4 | eza | ls | 彩色/图标/Git 状态/树形视图 | eza |
| 5 | bat | cat/less | 语法高亮、行号、Git 集成、自动分页 | bat |

Raycast AI: 下面按工具分别给出典型使用场景、常用命令示例和与其他工具的组合建议（macOS 适用）。

### 1) ripgrep (rg) —— 现代全文搜索
适用场景
-  在大型代码库里秒搜符号/函数/报错栈
-  只看某类文件（按语言/后缀）或排除大文件夹
-  查看匹配上下文、跨多行正则（PCRE2）
-  仅列出包含匹配的文件，或统计出现次数

常用示例
```bash
# 基本搜索（遵循 .gitignore，显示行号）
rg "initServer" -n

# 指定语言/类型或排除路径
rg -t js "useQuery"          # 只在 JS 文件搜
rg "TODO" -g '!node_modules' # 排除目录

# 上下文与高亮
rg "panic" -n -C 3           # 上下文各 3 行
rg -P "foo(?s).*bar"         # 跨多行 PCRE2 正则

# 只列出文件/统计
rg -l "FeatureFlag"          # 列出含匹配的文件
rg -c "FeatureFlag"          # 每文件计数
```

组合建议
-  rg + fzf：交互挑选匹配结果并预览/打开
```bash
rg --no-heading --line-number --color=always "pattern" \
| fzf --ansi --delimiter : -n 2 \
      --preview 'bat --color=always {1} --line-range {2}:{2}' \
| awk -F: '{print $1":"$2}'
```
得到的 file:line 可直接喂给编辑器（例如 xargs -r -I{} nvim +{line} {file}）。

---

### 2) fzf —— 通用模糊选择器
适用场景
-  历史命令搜索（Ctrl-r）、路径/命令补全
-  交互挑选文件/分支/进程/容器等任何列表
-  预览选中项内容（结合 bat）

常用示例
```bash
# 全局默认用 rg 列文件（含隐藏，排除 .git）
export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!.git"'

# 选文件并用编辑器打开
fzf | xargs -r nvim

# 预览文件内容（方向键浏览）
fzf --preview 'bat --style=numbers --color=always {}'

# 选进程并终止
ps aux | fzf -m | awk '{print $2}' | xargs -r kill
```

组合建议
-  与 rg/bat/zoxide 深度结合，形成“搜—看—跳”的闭环。
-  运行 /opt/homebrew/opt/fzf/install 启用 Ctrl-r/Ctrl-t/Ctrl-/ 快捷键。

---

### 3) zoxide —— 智能目录跳转
适用场景
-  在多个深层项目目录间快速切换
-  模糊记忆项目名即可直达（越常用越靠前）
-  互动式选择历史目录

常用示例
```bash
# 初始化（zsh 示例）
eval "$(zoxide init zsh)"

# 常用：z 关键字（无需完整路径）
z myproj             # 跳到最常去的 myproj 目录
z src/api            # 模糊匹配到子目录

# 互动选择（配合 fzf）
cd "$(zoxide query -l | fzf)"
```

组合建议
-  配合 fzf 将历史目录可视化选择；与 yazi/nnn 等文件管理器搭配跳转更顺手。

---

### 4) eza —— 现代 ls
适用场景
-  美观且信息密度高的目录浏览（图标、颜色、对齐）
-  快速查看 Git 状态、按修改时间/大小排序
-  树形浏览多级目录结构

常用示例
```bash
# 常用别名
alias ll='eza -l --group-directories-first --icons'
alias lt='eza -T -L 2 --icons'   # 树形显示 2 层

# 查看 Git 状态、按修改时间排序
eza -l --git -s=modified

# 人性化大小单位、显示隐藏文件
eza -la --icons --group-directories-first
```

组合建议
-  与 bat 一起作为预览器（在 yazi/nnn/fzf 的 preview 面板里效果更佳）。

---

### 5) bat —— 带高亮与分页的 cat
适用场景
-  快速阅读配置/代码：语法高亮、行号、Git 背景
-  在 fzf/文件管理器中作为预览器
-  作为系统/ Git 的默认 pager

常用示例
```bash
# 基本阅读（自动分页，高亮与行号）
bat README.md

# 只显示第 100~150 行
bat --line-range 100:150 app.log

# 从标准输入高亮（例如 JSON）
curl -s https://api.github.com | bat -l json

# 作为默认 pager（系统与 Git）
export PAGER="bat"
git config --global core.pager "bat -p"
```

组合建议
-  fzf --preview 'bat --style=numbers --color=always {}' 提升检索—预览效率。
-  与 rg 输出联动，快速定位并高亮上下文查看。

如果你告诉我常用编辑器（如 nvim/VS Code）和具体工作流，我可以把以上 5 个工具串成一套高效别名/函数，贴到你的 shell 配置即可用。

---

TIANLI ZENG: 继续后面5个，使用场景

---

Raycast AI: 下面继续第 6–10 名的“使用场景 + 常用示例 + 组合建议”（macOS 适用）。

### 6) fd —— 现代 find（更直观、更快）
适用场景
-  按文件名/后缀/类型快速找文件或目录（默认遵循 .gitignore）
-  按大小/修改时间筛选，排除特定目录
-  找到后批量执行（配合 -x/-X），或安全地用 NUL 分隔衔接 xargs

常用示例
```bash
# 基本：在当前目录递归找名中含 "config" 的文件
fd config

# 只找特定类型/后缀
fd -t f -e md readme            # 只找 .md 文件
fd -t d src                     # 只找目录，并匹配名含 src

# 排除与深度限制
fd -E node_modules -E dist pattern
fd -d 2 .                       # 最多搜索 2 层

# 显示隐藏文件并不忽略规则
fd --hidden --no-ignore pattern

# 按时间/大小
fd --changed-within 2d .
fd --size +50M -t f             # 大于 50 MB 的文件

# 找到后执行：逐条执行 / 批量执行
fd -e log -x gzip "{}"          # 每个文件各执行一次
fd -e png -X mogrify -strip -interlace Plane -- "{}"  # 批量传参更高效

# 与 xargs 安全衔接（NUL 分隔）
fd -0 -t f -e jpg | xargs -0 -r du -h
```

组合建议
-  fd + fzf：fd 作为候选生成器，fzf 负责交互选择与预览。
-  fd + rg：fd 定位文件集合，rg 在集合内做内容级搜索。

---

### 7) lazygit —— Git TUI（交互式超高效）
适用场景
-  一键查看工作区/暂存区/提交历史/分支图
-  交互式分块暂存、解决冲突、rebase/merge/cherry-pick
-  快速查看/搜索日志、挑选提交、管理 stash

常用示例
```bash
# 打开 TUI（在 Git 仓库内）
lazygit

# 常见操作（在界面内）
# - 查看改动、按块/行暂存，编写提交信息并提交
# - 切换/创建分支，rebase/merge/cherry-pick
# - 查看冲突文件并逐块解决，然后继续 rebase/merge
# - 查看日志（按提交/文件），一键 copy 提交哈希
# 提示：按 ? 查看快捷键与帮助
```

组合建议
-  与 delta 搭配：Git diff/日志在 lazygit 内获得语法高亮与侧边行号（配置 Git 使用 delta 即可）。
-  与编辑器联动：从 lazygit 中按键直接在编辑器打开文件/跳到行，形成“浏览-编辑-提交”闭环。

---

### 8) delta —— 现代 diff pager（Git/文本差异高亮）
适用场景
-  替代 Git 的默认分页器，彩色语法高亮、行号、内联/并排对比
-  提升 diff/日志/合并冲突的可读性，快速导航变更块

常用示例
```bash
# 配置为 Git 的默认分页器
git config --global core.pager "delta"
git config --global delta.navigate true
git config --global delta.line-numbers true
git config --global delta.syntax-theme "Dracula"
git config --global interactive.diffFilter "delta --color-only"
git config --global merge.conflictStyle zdiff3

# 临时并排显示
git -c delta.side-by-side=true diff

# 对比两个“未纳入 Git”的文件
git diff --no-index a.txt b.txt | delta
```

组合建议
-  与 lazygit 联动：在 TUI 内看到 delta 风格的高亮 diff，冲突分块更清晰。
-  与 bat：对非 Git 情况，可先用统一 diff 输出，再用 delta 渲染；查看单文件则用 bat 预览。

---

### 9) btop —— 现代系统/进程监控 TUI
适用场景
-  快速定位高 CPU/内存/IO 的进程并结束
-  实时查看 CPU/内存/磁盘/网络曲线，评估系统瓶颈
-  诊断“风扇狂转/卡顿”，或构建/测试期间的资源使用

常用示例
```bash
# 启动
btop

# 典型操作（界面内）
# - 切换排序（CPU/内存/IO）、过滤进程、结束/发送信号
# - 展开进程树、观察历史曲线与各核心利用率
# - 打开设置切换主题/刷新率/显示项
```

组合建议
-  与 bandwhich/ifstat 等配合：btop 定位整体趋势，bandwhich 细分到“哪个进程占带宽”。
-  与 glances/bottom：在不同环境中任选其一做补充。

---

### 10) httpie —— 人类友好的 HTTP 客户端
适用场景
-  调试/探索 REST API：自动彩色输出、JSON 友好
-  带鉴权、会话、重定向、文件上传/下载
-  将请求与响应串入脚本/管道，配合 jq/bat 做结构化与美观输出

常用示例
```bash
# 基本 GET（自动彩色输出）
http https://httpbin.org/get

# 查询参数、请求头
http GET 'https://api.example.com/users?page=2' X-API-Key:mytoken

# JSON POST：key=value 为字符串；key:=value 为原生 JSON
http POST https://api.example.com/users name=Ray age:=33 active:=true

# 文件上传（multipart）
http POST https://api.example.com/upload file@image.png

# 基本鉴权 / Bearer 鉴权
http -a user:pass GET https://api.example.com/me
http GET https://api.example.com/me Authorization:"Bearer YOUR_TOKEN"

# 会话（保存 cookie 等）
http --session=dev POST https://api.example.com/login user=ray pass=xxx
http --session=dev GET  https://api.example.com/me

# 跟随重定向、下载到文件、超时与详细日志
http --follow GET https://example.com
http --download GET https://example.com/bigfile
http --timeout 10 -v GET https://api.example.com/status

# 结合 jq/bat 做结构化与高亮
http https://api.example.com/data | jq '.items[] | {id, name}' | bat -l json
```

组合建议
-  httpie + jq/bat：API 调试信息更清晰（结构化 + 高亮）。
-  httpie + just：把常用 API 调试请求写成 just 任务，复用更高效。

需要的话，我可以把这 5 个工具各自的“高频 alias/函数”打包给你，直接贴进 zsh 配置即可用。

---

TIANLI ZENG: 继续后面5个，使用场景

---

Raycast AI: 下面继续第 11–15 名的“使用场景 + 常用示例 + 组合建议”（macOS 适用）。

11) jq —— JSON 结构化处理与变换
适用场景
-  API 调试结果的筛选、投影、重排与统计
-  将日志/配置转为结构化再处理（和 httpie/curl、jc 搭配）
-  批量修改 JSON 配置（安全、可回滚）
常用示例
```bash
# 漂亮打印 / 原样字符串输出
jq . data.json
jq -r '.items[] | "\(.id)\t\(.name)"' data.json

# 过滤与投影
jq '.items | map(select(.active)) | length' data.json
jq '.users[] | {id, name, email}' data.json

# 默认值、合并文件
jq '.config.timeout // 30' conf.json
jq -s 'add' a.json b.json > merged.json

# 更新字段（写到新文件再替换，避免破坏原始）
jq '.features |= map(select(.enabled == true))' app.json > app.new.json && mv app.new.json app.json

# 与 httpie 联动
http GET https://api.github.com/repos/cli/cli | jq '{stars: .stargazers_count, forks: .forks}'
```
组合建议
-  httpie/curl → jq → bat：调试时结构化+高亮一步到位。
-  jc → jq：将传统命令输出转 JSON，再做筛选与统计。

12) yq —— YAML/TOML/JSON 通吃的查询与编辑
适用场景
-  docker-compose、Kubernetes、GitHub Actions 等 YAML 的查询与批量修改
-  格式互转（YAML ⇄ JSON），方便接入 jq 处理
-  多文件合并/覆盖（overlay）
常用示例（mikefarah/yq v4 语法）
```bash
# 基本查询
yq '.services | keys' docker-compose.yml
yq '.services.web.environment.DB_HOST' docker-compose.yml

# 就地修改（-i）
yq -i '.version = "3.9"' docker-compose.yml
yq -i '.services.web.replicas = 3' k8s/deploy.yml

# 删除键 / 条件筛选
yq -i 'del(.metadata.annotations.owner)' k8s/deploy.yml
yq '.items[] | select(.kind == "Deployment") | .metadata.name' k8s/all.yaml

# 格式互转
yq -o=json '.' config.yml | jq '.app'
yq -P '.' config.json > config.yaml   # -P: pretty YAML

# 叠加合并（base 被 patch 覆盖）
yq -s '.[0] * .[1]' base.yml patch.yml > merged.yml
```
组合建议
-  yq + jq：yq 读/改 YAML，转 JSON 后交给 jq 统计或复杂变换。
-  和 fd/fzf 配合：批量定位 YAML 后统一修改（fd -e yml -X yq -i ...）。

13) sd —— 现代替代 sed 的查找替换
适用场景
-  简单可靠的字符串/正则替换（更友好的语法与默认行为）
-  批量文件、项目范围内的文本替换
-  与 fd 组合进行“只对特定文件集合替换”
常用示例
```bash
# 基本替换（文件就地写入）
sd 'foo' 'bar' app.conf > app.conf.new && mv app.conf.new app.conf

# 正则捕获分组
sd 'user=(\w+)' 'user:$1' auth.cfg > auth.cfg.new && mv auth.cfg.new auth.cfg

# 递归批量替换（用 fd 选文件集合，再 sd 替换）
fd -e js -g '!node_modules' | xargs -I{} sh -c 'sd "var " "let " "{}" > "{}.new" && mv "{}.new" "{}"'

# 针对标准输入
rg -n "TODO" | sd 'TODO' 'DONE'
```
组合建议
-  fd + sd：精准选取文件后替换，比全局替换更安全。
-  rg + sd：先用 rg 确认匹配范围，再执行替换。

14) procs —— 现代进程列表（替代 ps）
适用场景
-  彩色高亮、可读性强的进程列表与过滤
-  快速定位高 CPU/内存进程，查看进程树并结束
-  和 fzf 搭配实现“选中即杀/调试”
常用示例
```bash
# 基本查看、按 CPU 排序、树形视图
procs
procs --sort cpu
procs --tree

# 过滤（按命令/用户）
procs postgres
procs --user "$(whoami)"

# 选中后结束（fzf 交互）
procs | fzf | awk 'NR>1 {print $1}' | xargs -r kill
```
组合建议
-  btop 总览资源趋势，procs 精准定位具体进程。
-  与 lsof/kill/strace（mac 为 dtruss）联动做进一步排查。

15) duf —— 彩色表格显示磁盘使用（替代 df）
适用场景
-  一眼看清各挂载点容量/已用/可用与设备类型
-  过滤只看本地/网络盘、排除无关挂载
-  导出 JSON 后做自动化监控/告警
常用示例
```bash
# 概览（默认就很清晰）
duf

# 只看本地或网络卷，或指定路径
duf -only local
duf -only network
duf /Volumes

# 排除某些挂载点
duf -exclude /System,/private

# 导出 JSON 供监控/脚本
duf --json | jq '.[] | {mount: .mountpoint, used: .used, avail: .avail}'
```
组合建议
-  duf 定位“哪个卷在涨”，dust/ncdu 深入“哪个目录在吃空间”。
-  配合 cron/LaunchAgent 定期采样 duf --json，阈值告警。

需要的话，我可以把这 5 个工具的高频 alias/函数整理成一段可直接贴进你的 ~/.zshrc 的配置。

---

TIANLI ZENG: 继续后面5个，使用场景

---

Raycast AI: 下面继续第 16–20 名的“使用场景 + 常用示例 + 组合建议”（macOS 适用）。

16) dust —— 现代 du（按目录占用可视化）
适用场景
-  快速找出“哪个目录吃空间最多”
-  在清理下载/构建产物/日志前先定向定位大户
-  限定查看层级，避免信息过载

常用示例
```bash
# 当前目录空间占用概览（彩色、条形图）
dust

# 仅看一层目录占用（常用于 Downloads、项目根目录）
dust -d 1 ~/Downloads
dust -d 1 .

# 展开两层，排除常见大目录
dust -d 2 -X 'node_modules|.git|dist' .

# 只看前 N 个最大的条目（聚焦清理）
dust -n 20 .

# 查看指定路径列表（对比多个目录）
dust ~/Library/Caches ~/.cargo/registry ~/Library/Logs
```
组合建议
-  duf 总览“哪个卷在涨”，dust 深入到目录层面；
-  fd 辅助定位超大文件后手动确认删除：fd --hidden --no-ignore -S +500M -t f | xargs -I{} du -sh "{}"

17) zellij —— 现代终端复用（替代 tmux）
适用场景
-  在一个终端里分屏/分标签运行多个会话（开发/日志/监控并行）
-  预设布局（如左右/上下/网格）快速进入工作模式
-  不熟悉 tmux 的用户也能快上手（默认键位更直观）

常用示例
```bash
# 启动（默认创建/附着会话）
zellij

# 生成默认配置（可在 ~/.config/zellij/config.kdl 调整主题、键位等）
zellij setup --generate-config

# 使用自定义布局启动（KDL 布局文件）
zellij --layout ~/.config/zellij/layouts/two-pane.kdl

#（在界面内）新建 Pane/Tab、在 Pane 间移动、调节比例、保存布局
# 提示：按 ? 查看内置快捷键与说明
```
组合建议
-  把“构建/测试/日志/监控”分成独立 pane；配合 btop、tail -f、httpie 等形成常驻工作台；
-  与 starship 提示符配合，Pane 标题/信息密度更高（便于区分上下文）。

18) starship —— 跨 Shell 的现代提示符
适用场景
-  一眼看清当前目录、Git 分支/状态、语言版本、虚拟环境等
-  统一 zsh/bash/fish 的提示风格与配置
-  在大型仓库中通过提示符状态减少误操作（脏仓库、分支名、变更数）

常用示例
```bash
# 初始化（zsh）
echo 'eval "$(starship init zsh)"' >> ~/.zshrc

# 配置文件（~/.config/starship.toml）
mkdir -p ~/.config
cat > ~/.config/starship.toml <<'CONF'
format = "$directory$git_branch$git_state$git_status$cmd_duration\n$character"

[character]
success_symbol = "[➜](bold green) "
error_symbol = "[➜](bold red) "

[git_status]
ahead = "⇡${count}"
behind = "⇣${count}"
modified = "!${count}"
staged = "+${count}"
untracked = "?${count}"

[cmd_duration]
min_time = 500
show_milliseconds = true
CONF
```
组合建议
-  与 zoxide、atuin 联动：提示符中展示目录/分支信息，历史搜索和跳转更有上下文；
-  在不同项目定制 Module（如 node/python/rust）显示版本与工具链，减少开错版本的问题。

19) atuin —— 历史命令的“可搜索数据库”
适用场景
-  用 Ctrl-r 进行语义/模糊搜索历史命令（按目录、时间、成功与否等过滤）
-  多设备历史同步（可自建服务器或使用官方服务）
-  统计常用命令、回放复杂命令而不必重打

常用示例
```bash
# 初始化（zsh）
echo 'eval "$(atuin init zsh)"' >> ~/.zshrc

# 导入已有 shell 历史
atuin import auto

# 登录与同步（可跳过登录，仅本地用）
# atuin register 或 atuin login
# atuin sync

# 交互搜索：在终端里直接按 Ctrl-r
# 支持按目录过滤、按时间排序、预览与编辑再执行
```
组合建议
-  与 fzf 对比：fzf 也能做 Ctrl-r，但 atuin 具备“上下文 + 统计 + 同步”的优势；
-  将高频命令固化到 just/别名，低频长命令交给 atuin 记忆与召回。

20) just —— 任务配方（更顺手的 make 替代）
适用场景
-  把常用命令固化为“配方”，一条 just 命令即可复用
-  本地开发脚本化：启动/构建/测试/发布/清理
-  支持变量、参数、依赖、shebang，多语言脚本都能收纳

常用示例
```bash
# 在项目根新建 justfile
cat > justfile <<'JUST'
# 默认任务（无参数）
default:
    @just --list

# 带依赖的组合任务
dev: build run

# 构建/运行
build:
    npm ci && npm run build

run:
    node dist/index.js

# 带参数，提供默认值
test target="all":
    npm test -- --run $(target)

# 使用 shell 脚本片段
fmt:
    cargo fmt --all
JUST

# 使用
just               # 列出可用任务
just dev           # 先 build 再 run
just test target=utils
```
组合建议
-  与 httpie/jq/yq 结合，把 API 调试、配置编排写为标准任务；
-  与 zellij 搭配：一个 pane 跑 just dev，另一个 pane 看日志/测试，形成固定工作台。

如果你需要，我可以把以上 5 个工具各自的“高频 alias/函数/配置模板”整理成一段可直接粘贴到 ~/.zshrc 和 ~/.config 下的文件。

---

TIANLI ZENG: 继续后面5个，使用场景

---

Raycast AI: 下面继续第 21–25 名的“使用场景 + 常用示例 + 组合建议”（macOS 适用）。

21) hyperfine —— 命令基准测试与对比
适用场景
-  对比两种实现/参数哪更快（如 rg vs grep、不同编译参数）。
-  排除冷缓存影响（预热）、提高统计稳健性（多次运行、置信区间）。
-  导出结果到 JSON/Markdown 便于复现与分享。

常用示例
```bash
# 基本对比
hyperfine 'rg pattern' 'grep -R pattern .'

# 预热 3 次、最少运行 10 次
hyperfine -w 3 -m 10 'npm run build'

# 参数列表对比（如并行度）
hyperfine --parameter-list jobs 1,2,4,8 'make -j {jobs}'

# 导出结果
hyperfine 'rg foo' 'ugrep foo' --export-json bench.json
```
组合建议
-  和 just 结合，固化常用基准；与 rg/fd 的不同参数组合进行量化选择。

22) dog —— 更易用的 DNS 查询
适用场景
-  快速查询 A/AAAA/MX/TXT/NS 记录，观察 TTL、权威/递归差异。
-  指定 DNS 服务器对比解析结果；排查企业内网与公共 DNS 差异。
-  递归追踪（trace）权威解析链路，定位卡点。

常用示例
```bash
# 基本查询
dog example.com A
dog example.com AAAA
dog example.com MX

# 指定 DNS 服务器
dog @1.1.1.1 example.com A
dog @8.8.8.8 example.com NS

# 追踪权威链路
dog +trace example.com

# 验证域名所有权/ACME 等常用 TXT
dog _acme-challenge.example.com TXT
```
组合建议
-  与 gping/mtr 配合：先测连通与时延，再确认 DNS 是否是瓶颈。
-  将关键域名的解析检查写入 just/cron 做健康检查。

23) bandwhich —— 进程/连接级带宽占用
适用场景
-  一眼看清“哪个进程/连接在吃带宽”，辅助定位异常流量。
-  按网络接口聚焦（Wi‑Fi/以太网），在拥堵时做快速决策。
-  临时排查下载/同步工具是否按预期限速。

常用示例（macOS 需 root 才能按进程统计）
```bash
# 概览（建议加 sudo）
sudo bandwhich

# 指定网卡（Wi‑Fi 常为 en0）
sudo bandwhich -i en0
```
组合建议
-  与 btop 搭配：btop 看系统总览，bandwhich 精确到进程/连接。
-  结合 rclone/容器下载时观察是否按策略限速或是否异常外连。

24) mosh —— 弱网稳定的远程终端
适用场景
-  高延迟/抖动/切换网络（Wi‑Fi ⇄ 5G）场景下保持 SSH 会话不断开。
-  移动办公或地铁/高铁等网络不稳环境下长时间开发/运维。
-  与终端复用器搭配（zellij/tmux）获得“稳连接 + 会话保持”。

常用示例
```bash
# 基本连接（远端需安装 mosh-server）
mosh user@host

# 指定 SSH 端口
mosh --ssh="ssh -p 2222" user@host
```
注意
-  服务器需开放 UDP 60000–61000（可调），如：ufw allow 60000:61000/udp。
-  mosh 只建控制通道，文件传输仍用 scp/rsync/rclone。

组合建议
-  mosh + zellij：极稳的远程开发环境；偶发断网也不影响会话。
-  与 atuin/starship：远端命令历史与提示符信息更有上下文。

25) rclone —— 多云存储/协议统一同步
适用场景
-  在本地与各云（Google Drive、S3、WebDAV、OneDrive 等）间同步/备份。
-  增量传输、断点续传、带宽/并发控制、校验和校验。
-  挂载远端存储为本地磁盘（macOS 需 macFUSE）。

常用示例
```bash
# 初次配置
rclone config

# 列目录/查看配额
rclone ls gdrive:
rclone about gdrive:

# 同步（先彩排）
rclone sync ~/Projects gdrive:backup/Projects --dry-run --progress
# 实际执行，限制带宽与并发、排除模式
rclone sync ~/Projects gdrive:backup/Projects \
  --progress --bwlimit 5M --transfers 8 --checkers 16 \
  --exclude-from .rcloneignore

# 只复制最近 7 天的 CSV 到本地
rclone copy s3:my-bucket/reports ~/Downloads --include "*.csv" --max-age 7d

# 挂载远端为本地（需安装 macFUSE）
# brew install --cask macfuse
rclone mount gdrive: ~/mnt/gdrive --vfs-cache-mode writes
```
组合建议
-  与 age 结合：先本地加密（或用 rclone crypt 远端加密）再同步，提升安全性。
-  与 bandwhich/btop：大规模传输时实时观察带宽与系统资源。
-  与 just：把常用的备份/同步流程配成任务，一键执行。

需要的话，我可以继续给 26–30（croc、age、jc、Miller、yazi）的使用场景，或按你的具体工作流定制一套别名与 justfile。

---

TIANLI ZENG: 继续后面5个，使用场景

---

Raycast AI: 下面继续第 26–30 名的“使用场景 + 常用示例 + 组合建议”（macOS 适用）。

26) croc —— 点到点安全传文件（穿透友好）
适用场景
-  在不同网络/平台间临时、快速、安全地传目录/文件。
-  不想建共享通道（SCP/网盘/邮件）的临时协作。
-  需端到端加密、可断点续传、可自建中继的场景。

常用示例
```bash
# 发送单个文件或目录（会生成一次性口令）
croc send ./dist.tar.gz
croc send ./my-folder

# 接收方（在另一台机器上执行，输入口令或直接带口令）
croc
# 或：
croc "rosy-horse-7"

# 自定义口令（便于口述/复制）
croc send -c "my-code-2025" ./dist.tar.gz
# 接收方：
croc "my-code-2025"

# 从/到标准流（打包后直接传输）
tar cz . | croc send --stdin
# 接收方将输出还原
croc --stdout "the-code" | tar xz

# 指定自建中继（也可自建：croc relay）
croc --relay your.relay.com:9009 send file.iso
croc --relay your.relay.com:9009 "the-code"
```
组合建议
-  与 age：先本地加密，再用 croc 传，提高敏感文件安全。
-  与 bandwhich/btop：大文件传输时观察带宽占用与限速效果。

27) age —— 简洁现代的文件加密（替代 gpg）
适用场景
-  对配置/密钥/备份文件进行快速端到端加密解密。
-  团队共享：用收件人公钥加密，任何持私钥者可解密。
-  搭配 rclone/云盘，把加密文件上云。

常用示例
```bash
# 生成密钥对（输出保存为 key.txt；第一行为 recipient 公钥）
age-keygen -o ~/.config/age/key.txt
# 查看公钥（示例以 "age1..." 开头）
grep '^# public key:' ~/.config/age/key.txt

# 使用收件人公钥加密（单文件）
age -r age1qxy... -o secret.txt.age secret.txt

# 解密（使用私钥）
age -d -i ~/.config/age/key.txt -o secret.txt secret.txt.age

# 口令加密（无需密钥对）
age -p -o archive.tar.age archive.tar
age -d -o archive.tar archive.tar.age

# 批量/目录：先打包再加密
tar czf backup.tgz ./configs
age -r age1qxy... -o backup.tgz.age backup.tgz
```
组合建议
-  与 rclone：先 age 加密，再 rclone sync 到云端；或用 rclone crypt 做透明加密。
-  与 just：把加密/解密/上传写成任务，一条命令复用。

28) jc —— “把命令输出变成 JSON”
适用场景
-  自动化脚本：旧命令输出结构化后更好过滤、聚合、告警。
-  可移植运维：跨平台命令输出差异用 jc 统一为 JSON。
-  与 jq/mlr 联动，低成本把系统信息接入数据管道。

常用示例
```bash
# 磁盘/进程/网络信息转 JSON 再筛选
df -h | jc --df | jq '.[] | {mount: .mount, used: .pcent}'
ps aux  | jc --ps | jq '[.[] | select(.pcpu > 50) | {pid, command, pcpu}]'
ifconfig | jc --ifconfig | jq '.[] | {iface: .name, ipv4: .ipv4[0].addr}'

# DNS/连通性
dig example.com any +noall +answer | jc --dig | jq '.[].data'
ping -c 3 example.com | jc --ping | jq '{min:.statistics.rtt_min, avg:.statistics.rtt_avg, max:.statistics.rtt_max}'

# 目录体积扫描
du -k | jc --du | jq '[.[] | select(.size_k > 100000)] | sort_by(.size_k) | reverse | .[0:10]'
```
组合建议
-  jc → jq/mlr：把系统命令接入“现代数据管道”，便于程序化处理。
-  与 duf/dust：宏观看卷（duf），微观看目录（dust），细节再用 du | jc | jq。

29) Miller (mlr) —— CSV/TSV/JSON 的“终端瑞士军刀”
适用场景
-  对表格/日志数据做切列、过滤、聚合、透视、连接、格式转换。
-  比 awk/csvkit 更贴近“列操作思维”，语法直观、性能佳。
-  数据探索与一次性分析脚本。

常用示例
```bash
# 选择/过滤/排序（CSV）
mlr --csv cut -f id,name,bytes then filter '$status==200' then sort -nr bytes file.csv

# 分组统计（均值/分位数等）
mlr --csv stats1 -a count,mean,p50,p95 -f latency_ms -g endpoint logs.csv

# 连接两表（按 id 连接）
mlr --csv join -j id -f users.csv purchases.csv > joined.csv

# 宽 <-> 长 透视
mlr --csv reshape -i item1,item2,item3 -o item,value data.csv   # 宽转长
mlr --csv reshape -s item,value -o item1,item2,item3 data_long.csv  # 长转宽

# 格式转换（CSV -> JSON）
mlr --icsv --ojson cat data.csv | jq '.[0:3]'
```
组合建议
-  与 jc/jq：系统命令 → jc(JSON) → mlr 做统计/透视；或 mlr 先规整再 jq 精细处理。
-  与 visidata：mlr 批处理，visidata 交互探索，互补高效。

30) yazi —— 超快 TUI 文件管理器
适用场景
-  终端内高效浏览/预览/批量操作文件（含图片/多媒体预览）。
-  结合 zoxide/fzf 快速跳转、定位后批量重命名/移动/删除。
-  作为“项目工作台”：左侧目录树、右侧预览 + 外部编辑器联动。

常用示例
```bash
# 打开 yazi（在项目根或任意路径）
yazi .
yazi ~/Downloads

# 常见操作（界面内）
# - 空格/回车：选择/进入；Tab：面板切换；?：帮助/快捷键
# - :shell 命令、:rename 批量重命名、:filter 过滤、:search 搜索
# - 预览文本/图片（在 iTerm2/Kitty 下可图片预览，需启用相关支持）

# 与 shell 同步目录：从 yazi 退出后回到选中的目录（yy 函数）
yy() {
  local tmp="$(mktemp -t "yazi-cwd.")"
  yazi --cwd-file="$tmp" "$@"
  local cwd="$(cat "$tmp")"
  [ -n "$cwd" ] && cd "$cwd"
  rm -f "$tmp"
}
```
组合建议
-  与 bat 作为预览器、rg 作为快速搜索后跳转；与 zoxide 结合“目录记忆”。
-  与 croc：在 yazi 中快速选中大文件后，一键调用外部命令 croc 发送。

