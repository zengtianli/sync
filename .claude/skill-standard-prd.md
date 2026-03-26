# Skill 标准化 PRD

## 背景

当前 cursor-shared 的 skills 结构不统一，大部分只有单个 `SKILL.md` 文件。需要建立标准结构规范，并创建一个 `skill-standard` skill 作为模板。

## 目标

1. 创建 `skill-standard` skill，定义四大组成部分规范
2. 作为所有项目创建 skill 的参考模板

## Skill 标准结构

```
skill-name/
├── SKILL.md              # 主文档（必需）
│                         # - YAML frontmatter: name, description
│                         # - 触发条件、核心内容、使用方法
│
├── references/           # 参考资料（可选）
│   └── *.md              # - 详细文档、快捷键表、API 参考
│                         # - 不常变动的知识库
│
├── scripts/              # 实用脚本（可选）
│   └── *.sh / *.py       # - 自动化脚本、检查脚本
│                         # - 可直接执行的工具
│
└── assets/               # 静态资源（可选）
    └── *.json / *.yaml   # - 配置模板、数据文件
                          # - 图片、示例文件
```

## SKILL.md 模板

```markdown
---
name: skill-name
description: 一句话描述。当 xxx 时触发。
---

# Skill 标题

> 路径/定位说明

## 核心内容

主要知识点...

## 使用方法

如何使用...

## 修改规范

如何修改/扩展...
```

## 执行任务

### 任务 1：创建 skill-standard skill

在 `~/cursor-shared/.claude/skills/` 创建：

```
skill-standard/
├── SKILL.md              # 标准结构说明
├── references/
│   └── template.md       # SKILL.md 模板示例
└── scripts/
    └── create.sh         # 一键创建新 skill 脚本
```

**SKILL.md 内容要点**：
- 四大组成部分说明
- 每个部分的用途和规范
- 命名约定

**scripts/create.sh 功能**：
```bash
# 用法: ./create.sh <skill-name> [target-dir]
# 自动创建标准目录结构和模板文件
```

### 任务 2（可选）：升级现有 skills

检查现有 skills，为重要的添加 references/ 或 scripts/：
- `system/architecture` - 可添加 references/
- `dev/shell` - 可添加 scripts/check.sh
- 其他按需处理

## 参考示例

配置部（sync）已创建的 4 个标准 skills：

| Skill | 结构 |
|-------|------|
| `dotfiles` | SKILL.md + references/deploy.md + scripts/deploy.sh |
| `nvim` | SKILL.md + references/keymaps.md + scripts/check.sh |
| `zsh` | SKILL.md + references/shortcuts.md + scripts/check.sh |
| `macos-wm` | SKILL.md + references/shortcuts.md + scripts/check.sh |

可参考 `/Users/tianli/Documents/sync/.claude/skills/` 的实现。

## 验收标准

1. `skill-standard` skill 创建完成
2. `scripts/create.sh` 可正常执行，生成标准结构
3. 文档清晰，AI 能理解并按规范创建新 skills
