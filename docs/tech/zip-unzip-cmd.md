---
alias: ["ZIP和UNZIP命令指南", "压缩解压命令参考"]
tags: [zip, unzip, 压缩命令, 批量处理]
summary: ZIP和UNZIP命令的全面指南，包括常用参数、批量处理技巧和实际应用场景，提供全平台通用的压缩解压缩文件管理方法。
marp: true
theme: gaia
_class: lead
paginate: true
backgroundColor: #fff
backgroundImage: url('https://marp.app/assets/hero-background.svg')
style: |
  section { font-size: 30px; }
  section.small-text { font-size: 24px; }
  table { border-collapse: collapse; margin: 20px auto; font-size: 22px; }
  th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
  th { background-color: #f2f2f2; }
---

# ZIP和UNZIP命令指南
## 压缩解压缩文件管理

---

# ZIP命令：创建压缩包

| 功能 | 命令示例 | 参数说明 |
|------|----------|----------|
| **压缩单个文件** | `zip archive.zip file.txt` | 基础压缩 |
| **压缩多个文件** | `zip archive.zip file1.txt file2.log` | 多文件压缩 |
| **压缩目录** | `zip -r project.zip project_docs/` | `-r` 递归包含子目录 |
| **加密压缩** | `zip -er secure.zip confidential/` | `-e` 加密，`-r` 递归 |
| **更新压缩包** | `zip -u archive.zip newfile.txt` | `-u` 更新已有压缩包 |


| 需求 | 命令示例 |
|------|----------|
| **排除特定目录** | `zip -r project.zip project/ -x "project/logs/*"` |
| **排除临时文件** | `zip -r project.zip project/ -x "*.tmp" "*.log"` |
| **排除多种文件** | `zip -r backup.zip src/ -x "*.o" "*/node_modules/*"` |

---

# UNZIP命令：解压缩文件

| 功能 | 命令示例 | 参数说明 |
|------|----------|----------|
| **解压到当前目录** | `unzip archive.zip` | 基础解压 |
| **解压到指定目录** | `unzip archive.zip -d target_dir/` | `-d` 指定目标目录 |
| **查看压缩包内容** | `unzip -l archive.zip` | `-l` 列出文件清单 |
| **解压特定文件** | `unzip archive.zip path/to/file.txt` | 解压指定文件 |
| **覆盖解压** | `unzip -o archive.zip -d target/` | `-o` 覆盖已存在文件 |


| 功能 | 命令示例 | 说明 |
|------|----------|------|
| **排除特定文件** | `unzip archive.zip -x "*.log"` | 解压时排除日志文件 |
| **静默模式** | `unzip -q archive.zip` | `-q` 静默输出 |
| **测试压缩包** | `unzip -t archive.zip` | `-t` 测试完整性 |
| **解压时重命名** | `unzip archive.zip -j` | `-j` 忽略目录结构 |


---

# 实际应用场景

| 场景 | 完整命令 |
|------|----------|
| **备份项目(排除依赖)** | `zip -r project_backup.zip my_project/ -x "*/node_modules/*" "*.log"` |
| **创建源码包** | `zip -r source.zip src/ -x "*.o" "*.exe" "*/.git/*"` |
| **安全文档压缩** | `zip -er confidential.zip documents/` |
| **解压到时间戳目录** | `unzip archive.zip -d "backup_$(date +%Y%m%d)/"` |

# 批量处理技巧

| 需求 | 命令示例 |
|------|----------|
| **压缩多个目录** | `for dir in */; do zip -r "${dir%/}.zip" "$dir"; done` |
| **批量解压** | `for file in *.zip; do unzip "$file" -d "${file%.zip}"; done` |
| **按日期压缩** | `zip "backup_$(date +%Y%m%d).zip" *.txt` |
| **解压所有到单独目录** | `ls *.zip \| xargs -I {} unzip {} -d {%.zip}` |

---

# 故障排除

| 问题 | 原因 | 解决方案 |
|------|------|----------|
| **"zip: command not found"** | 系统未安装zip工具 | `brew install zip` 或 `sudo apt install zip` |
| **权限被拒绝** | 目标目录无写权限 | `chmod 755 target_dir` 或使用sudo |
| **压缩包损坏** | 传输或存储错误 | `unzip -t file.zip` 测试完整性 |
| **中文文件名乱码** | 编码问题 | `unzip -O gbk file.zip` 或 `unzip -O utf8` |

---

# 综合示例：项目备份流程

```bash
# 1. 创建备份目录
mkdir -p /backups/$(date +%Y%m%d)

# 2. 压缩项目(排除不需要的文件)
zip -r my_project_backup.zip my_project/ \
  -x "*/node_modules/*" "*.log" "*/.git/*" "*.tmp"

# 3. 移动到备份目录
mv my_project_backup.zip /backups/$(date +%Y%m%d)/

# 4. 验证压缩包
unzip -t /backups/$(date +%Y%m%d)/my_project_backup.zip
```

