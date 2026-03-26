---
alias:
  - 系统管理指南
  - 系统故障排除
tags:
  - 系统管理
  - Go环境
  - PyInstaller
  - Node
summary: 系统问题的诊断和解决方案，包括网络连接、文件权限和系统性能优化，提供常见故障的排除方法和系统维护最佳实践。
marp: true
theme: gaia
_class: lead
paginate: true
backgroundColor:
backgroundImage: url('https://marp.app/assets/hero-background.svg')
style: |
  section { font-size: 24px; }
  section.small-text { font-size: 24px; }
  table { border-collapse: collapse; margin: 20px auto; font-size: 18px; }
---

# 系统管理与故障排除指南
## 诊断、修复、优化一体化解决方案

---

## Go环境修复流程
| 步骤 | 命令 | 说明 |
|------|------|------|
| **1. 清除环境变量** | `unset {HTTP_PROXY,HTTPS_PROXY,http_proxy,https_proxy,all_proxy}` | 移除代理设置 |
| **2. 清除Go代理** | `go env -w {HTTP_PROXY,HTTPS_PROXY}=` | 重置Go代理 |
| **3. 设置国内代理** | `go env -w GOPROXY=https://goproxy.cn,direct GOSUMDB=sum.golang.google.cn` | 使用可靠源 |
| **4. 清理缓存** | `go clean -modcache` | 清除旧缓存 |
| **5. 测试安装** | `go install github.com/sachaos/todoist@latest` | 验证修复 |

---

## 文件操作最佳实践
| 操作类型 | 推荐命令 | 说明 |
|----------|----------|------|
| **保留权限复制** | `cp -p source destination` | 保持原始权限 |
| **同步复制** | `rsync -av --progress source/ destination/` | 推荐方式 |
| **权限修正** | `sudo chown -R $(whoami) destination/` | 复制后立即修正 |
| **查找重复文件** | `brew install fdupes && fdupes -r /path/to/directory` | 查找重复 |
| **自动删除重复** | `fdupes -r -N /path/to/directory` | 保留第一个 |


| 分析需求       | 命令                                                           | 功能说明       |
| ---------- | ------------------------------------------------------------ | ---------- |
| **目录大小**   | `du -sh /path/to/directory`                                  | 查看指定目录大小   |
| **查找大文件**  | `find /path -size +100M -ls`                                 | 找出100M以上文件 |
| **交互式分析**  | `brew install ncdu && ncdu /path/to/directory`               | 可视化磁盘使用    |
| **系统磁盘使用** | `df -h && du -sh /* 2>/dev/null \| sort -hr`                 | 全系统分析      |
| **重复大文件**  | `fdupes -r -S /path/to/directory \| grep -E "^[0-9]+ bytes"` | 按大小排序重复文件  |

---

## PyInstaller打包解决方案
| 打包需求 | 参数组合 | 说明 |
|----------|----------|------|
| **基本打包** | `pyinstaller your_script.py` | 多文件输出 |
| **单文件打包** | `--onefile` | 生成单个可执行文件 |
| **GUI应用** | `--noconsole` | 无控制台窗口 |
| **添加图标** | `--icon=icon.ico` | 自定义图标 |
| **包含数据文件** | `--add-data "source;dest"` | 打包数据文件 |
| **调试模式** | `--debug=all --clean` | 详细调试信息 |

| 安装方式 | 命令 | 特点 |
|----------|------|------|
| **Homebrew安装** | `brew install node` | 系统级安装 |
| **nvm安装** | `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh \| bash && nvm install node` | 版本管理 |
| **验证安装** | `node --version && npm --version && which node` | 确认安装成功 |
| **安装pnpm** | `npm install -g pnpm` | 高效包管理器 |

| 操作 | 命令 | 说明 |
|------|------|------|
| **列出版本** | `nvm list` | 查看已安装版本 |
| **安装切换** | `nvm install 16 && nvm use 16 && nvm alias default 16` | 安装、使用、设为默认 |

---

## 系统清理自动化
| 清理类型 | 命令 | 说明 |
|----------|------|------|
| **包管理器缓存** | `brew cleanup && npm cache clean --force && pip cache purge` | 清理各种缓存 |
| **系统缓存** | `sudo rm -rf ~/Library/Caches/* /System/Library/Caches/*` | 系统级清理 |
| **下载目录** | `find ~/Downloads -type f -mtime +30 -delete` | 清理30天前文件 |

| 检查项 | 命令 | 说明 |
|--------|------|------|
| **基础工具** | `for cmd in git node python3 pip; do command -v $cmd >/dev/null && echo "✓ $cmd: $($cmd --version)" \|\| echo "✗ $cmd 未安装"; done` | 检查核心工具 |
| **开发工具** | `for cmd in nvim fzf fd rg; do command -v $cmd >/dev/null && echo "✓ $cmd: $($cmd --version \| head -1)" \|\| echo "✗ $cmd 未安装"; done` | 检查编辑器工具 |
| **网络连接** | `ping -c 1 google.com >/dev/null 2>&1 && echo "✓ 网络正常" \|\| echo "✗ 网络异常"` | 网络状态 |

---
# 故障快速诊断

## 常见问题速查表
| 问题类型 | 诊断命令 | 解决方案 |
|----------|----------|----------|
| **权限错误** | `ls -la problematic_file` | `sudo chown $(whoami) problematic_file && chmod u+rwx problematic_file` |
| **网络连接** | `ping target_host && nslookup target_host` | `netstat -an \| grep :port` 检查端口 |
| **包管理问题** | `brew cleanup && brew update` | `npm cache clean --force && pip cache purge` 清理缓存 |
| **环境变量** | `echo $PATH && which command_name` | `export PATH="/new/path:$PATH"` 修正路径 |

## 系统监控与维护
| 监控项 | 命令 | 说明 |
|--------|------|------|
| **磁盘空间** | `df -h && du -sh /* 2>/dev/null \| sort -hr \| head -10` | 磁盘使用分析 |
| **进程监控** | `top -l 1 \| head -20` | 系统进程状态 |
| **网络监控** | `netstat -an \| grep LISTEN` | 监听端口查看 |
| **内存监控** | `vm_stat \| grep "Pages free\|Pages active"` | 内存使用情况 |
