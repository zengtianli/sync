---
alias: ["macOS扩展属性与Gatekeeper管理", "macOS安全属性"]
tags: [macOS, xattr, Gatekeeper, 权限管理]
summary: macOS扩展属性与Gatekeeper的管理方法，包括安全属性查看、修改和批量处理，解决应用程序权限和安全限制问题。
marp: true
theme: gaia
_class: lead
paginate: true
backgroundColor: #fff
backgroundImage: url('https://marp.app/assets/hero-background.svg')
style: |
  section { font-size: 30px; }
  section.small-text { font-size: 24px; }
  table { border-collapse: collapse; margin: 2px auto; font-size: 18px; }
  .auto-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 2px; }
  .auto-grid > div { padding: 1px; border-radius: 5px; }
---

# macOS应用权限修复
## `xattr` 命令速查

---


<div class="auto-grid">
<div>

| 问题症状 | 命令解决方案 |
|----------|-------------|
| **"应用已损坏，无法打开"** | `sudo xattr -cr App.app` |
| **"来自身份不明的开发者"** | `sudo xattr -d com.apple.quarantine App.app` |
| **下载工具被系统阻止** | `sudo spctl --master-disable` |
</div>

<div>

| 命令 | 功能 | 使用场景 |
|------|------|----------|
| `xattr -l` | 查看扩展属性 | 🔍 诊断问题 |
| `xattr -cr` | 清除所有属性 | ✅ **推荐首选** |
| `xattr -d com.apple.quarantine` | 清除隔离属性 | 🎯 精确处理 |
| `spctl --master-disable` | 禁用Gatekeeper | ⚠️ 应急使用 |
| `spctl --master-enable` | 启用Gatekeeper | 🔒 恢复安全 |

</div>

</div>

# 参数说明

| 参数 | 作用 | 必要性 |
|------|------|--------|
| `sudo` | 管理员权限 | ✅ 必需 |
| `-c` | 清除隔离标记 | 🎯 核心功能 |
| `-r` | 递归处理子文件 | 📁 处理.app包 |
| `-l` | 列出属性 | 📋 查看状态 |
| `-d` | 删除指定属性 | 🗑️ 精确删除 |
