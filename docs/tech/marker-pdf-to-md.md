---
alias: ["Marker工具PDF转Markdown", "PDF标注转换"]
tags: [Marker, PDF, Markdown, 文档转换]
summary: 使用Marker工具将PDF标注转换为Markdown格式，包括安装配置、使用方法和最佳实践，提高学术阅读和笔记整理效率。
marp: true
theme: gaia
_class: lead
paginate: true
backgroundColor: #fff
backgroundImage: url('https://marp.app/assets/hero-background.svg')
style: |
  section { font-size: 30px; }
  section.small-text { font-size: 24px; }
  section.large-text { font-size: 48px; }
  table {
    border-collapse: collapse;
    margin: 20px auto;
    font-size: 22px;
  }
---

# Marker 

**单个文件** 和 **整个目录 (批量处理)**。

| 命令              | 用途     | 基本用法                                                           | 说明                                        |
| --------------- | ------ | -------------------------------------------------------------- | ----------------------------------------- |
| `marker`        | 批量处理   | `marker ./input_pdfs --output_dir ./output_markdown`           | 最常用的命令，递归地查找指定目录下的所有 PDF，并将它们转换为 Markdown |
| `marker_single` | 单个文件处理 | `marker_single my_document.pdf --output_dir ./output_markdown` | 用于转换单个 PDF 文件，适合测试或处理特定文件                 |
