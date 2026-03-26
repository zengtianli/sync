# ZSH 配置

基于 Zim 框架的 ZSH 配置，集成现代命令行工具和 FZF 增强功能。

## 项目结构

```
zsh/
├── zshrc                    # 主配置文件
├── zimrc                    # Zim 框架配置
├── gitconfig                # Git 配置
├── config/                  # 配置目录
│   ├── conda.zsh           # Conda 管理
│   ├── fzf.zsh             # FZF 配置
│   ├── mappings.zsh        # 键盘映射
│   ├── modern-tools.zsh    # 现代工具别名
│   └── fzf/                # FZF 工具脚本
│       ├── brew-tools      # Homebrew 管理
│       ├── modern-git      # Git 工具
│       ├── process-tools   # 进程管理
│       └── util           # 工具总览
├── functions/               # 自定义函数
│   └── cd_git_root.zsh     # Git 根目录跳转
└── ssh/                    # SSH 配置
```

## 安装使用

1. 克隆到本地：
```bash
git clone <repository-url> ~/.config/zsh
```

2. 链接配置文件：
```bash
ln -s ~/.config/zsh/zshrc ~/.zshrc
source ~/.zshrc
```

3. 查看可用功能：
```bash
util
```

## 核心功能

### 现代工具替代
- `ls` → `eza` (彩色文件列表)
- `cat` → `bat` (语法高亮)
- `find` → `fd` (更快搜索)
- `du` → `dust` (目录大小可视化)
- `top` → `btop` (系统监控)

### 快捷键
- `Ctrl+G` - LazyGit
- `Ctrl+P` - FZF 文件搜索
- `Ctrl+R` - FZF 历史搜索
- `Ctrl+T` - FZF 目录切换

### 管理工具
- `brew-tools` - Homebrew 包管理
- `process-tools` - 进程管理
- `conda_status` - Conda 状态
- `util` - 功能总览

## 配置选项

### 禁用现代工具
```bash
export ZSH_USE_MODERN_TOOLS="false"
```

### Conda 模式切换
```bash
export ZSH_CONDA_MODE="lazy"  # 延迟加载
export ZSH_CONDA_MODE="eager" # 立即加载
```

## 文档
- `MODERN_TOOLS_GUIDE.md` - 详细工具指南
- `zsh-功能汇总.md` - 功能汇总


