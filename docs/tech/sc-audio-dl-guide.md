---
alias: ["SoundCloud音频下载指南", "音频下载技术教程"]
tags: [SoundCloud, yt-dlp, ffmpeg, 音频下载]
summary: SoundCloud音频下载的完整指南，包括yt-dlp工具使用、格式转换、批量下载和常见问题解决，提供跨平台的音频获取方案。
marp: true
theme: gaia
_class: lead
paginate: true
backgroundColor: #fff
backgroundImage: url('https://marp.app/assets/hero-background.svg')
style: |
  section { font-size: 24px; }
  section.small-text { font-size: 24px; }
  table { border-collapse: collapse; margin: 20px auto; font-size: 18px; }
  .auto-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 2px; }
  .auto-grid > div { padding: 1px; border-radius: 5px; }
---

# SoundCloud音频下载指南
## 使用 `yt-dlp` + `ffmpeg` 工具链

---
<div class="auto-grid">
<div>

# 环境准备

| 工具 | 作用 | 安装命令 |
|------|------|----------|
| **yt-dlp** | 音频下载核心工具 | `brew install yt-dlp` |
| **ffmpeg** | 音频格式转换 | `brew install ffmpeg` |

</div>
<div>

## 一键安装和使用
```bash
brew install yt-dlp ffmpeg
yt-dlp -x --audio-format mp3 -o "%(title)s.%(ext)s" "URL"
yt-dlp -x --audio-format mp3 -o "%(title)s.%(ext)s" \
"https://soundcloud.com/elllo-todd/mixer-141-shopping-online"
```

| 参数 | 功能 | 说明 |
|------|------|------|
| `-x` | 仅提取音频 | 去除视频容器，纯音频输出 |
| `--audio-format mp3` | 指定输出格式 | 转换为MP3格式 |
| `-o "%(title)s.%(ext)s"` | 自动命名 | 使用原标题作为文件名 |

**结果**: `Mixer #141 - Shopping Online.mp3`

</div>
</div>

---

<div class="auto-grid">
<div>

## 函数定义
```zsh
# 添加到 ~/.zshrc
scdl() {
  if [ -z "$1" ]; then
    echo "Usage: scdl <soundcloud_url>"
    return 1
  fi
  yt-dlp -x --audio-format mp3 -o "%(title)s.%(ext)s" "$1"
}
```

</div>
<div>

## 使用方式
```bash
# 激活函数
source ~/.zshrc

# 简化使用
scdl "SoundCloud链接"
```

</div>
</div>

<div class="auto-grid">

<div>

# 高级选项

| 需求 | 命令示例 |
|------|----------|
| **指定下载目录** | `yt-dlp -x --audio-format mp3 -o "~/Music/%(title)s.%(ext)s" URL` |
| **批量下载播放列表** | `scdl "播放列表URL"` |
| **下载最高质量** | `yt-dlp -x --audio-format best -o "%(title)s.%(ext)s" URL` |
| **查看可用格式** | `yt-dlp -F URL` |

</div>
<div>

# 故障排除

| 问题 | 解决方案 |
|------|----------|
| **工具版本过旧** | `brew upgrade yt-dlp ffmpeg` |
| **下载失败** | 检查URL是否正确、网络连接 |
| **格式不支持** | 使用 `--audio-format best` |
| **权限问题** | 检查目标目录写入权限 |

</div>
</div>
