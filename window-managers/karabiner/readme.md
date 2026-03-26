# Karabiner-Elements 配置文件集

This is Ben's configure

这个仓库包含了一系列为 macOS 上强大的键盘自定义工具 Karabiner-Elements 设计的配置文件。

## 概览

Karabiner-Elements 允许您重新映射按键，重新定义它们的功能，并创建复杂的修改。此仓库中的配置文件旨在为各种用例和偏好优化键盘使用体验。

## 配置文件

- `bring-back-grave-accent-and-tilde.json`：在将 ESC 映射后恢复重音符和波浪号按键。
- `caps-enhancement.json`：增强 Caps Lock 键，添加箭头键、Home、End 等附加功能。
- `cmd_h_del.json`：为 Command+H 组合键定制修改，执行删除动作。
- `demo.json`：一个简单示例，将 Caps Lock 映射到 Command 键。
- `hyper-key.json`：将右侧 Command 键映射为超级按键（Shift+Command+Option+Control）。
- `hyper-key1.json` & `hyper-key2.json`：映射 Right Option 和 Fn 键为不同的超级按键组合。
- `only-keyboard-core.json`：将 Tab 键与数字键映射到功能键以及其他组合键实现快捷操作，如快速删除。
- `vimmode.json`：在不同应用程序中自定义 Escape 键行为，如 Arc 浏览器、Notes、Wechat 等。

## 使用方法

使用这些配置文件：

1. 如果您还未安装 [Karabiner-Elements](https://karabiner-elements.pqrs.org/)，请先进行安装。
2. 克隆本仓库或下载您所需的 `.json` 文件。
3. 将配置导入到 Karabiner-Elements 中：
   - 打开 Karabiner-Elements 首选项。
   - 跳转到“复杂修改”标签页。
   - 点击“添加规则”，然后点击“从互联网导入更多规则（打开网页浏览器）”如果您想从官方网站导入，或者如果您直接下载了 `.json` 文件，则点击“导入文件”。
4. 通过点击对应的“启用”按钮来启用您需要的配置。

## 贡献

欢迎您 fork 本仓库并自定义配置文件以满足您的需求。如果您有任何改进建议，请开设一个问题或提交一个合并请求。

## 许可证

本项目在 [MIT 许可证](LICENSE.md) 下开源。

