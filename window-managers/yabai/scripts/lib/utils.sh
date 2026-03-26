#!/bin/bash

# 工具函数文件
# 此文件提供了项目中使用的通用工具函数

# 常量定义
DEBUG_LEVEL=1
WINDOW_STATE_DIR="/tmp/yabai"
SPACE_SWITCH_DELAY=0.2
DISPLAY_SWITCH_DELAY=0.3
RULE_APPLY_DELAY=0.1

# 确保临时目录存在
mkdir -p "${WINDOW_STATE_DIR}"

# 调试输出函数
debug() {
    local level=$1
    local message=$2
    if [[ $DEBUG_LEVEL -ge $level ]]; then
        echo "[DEBUG] $message"
    fi
}

# 错误处理函数
handle_error() {
    echo "错误: $1" >&2
    exit 1
}

# 检查依赖（不检查yabai服务状态）
check_dependencies() {
    # 检查yabai是否可用
    if ! command -v yabai &> /dev/null; then
        handle_error "未找到yabai命令。请确保yabai已安装并可用。"
    fi

    # 只获取版本信息用于调试，不依赖服务运行状态
    local yabai_version=$(yabai --version 2>/dev/null || echo "yabai程序已安装")
    debug 1 "yabai版本: $yabai_version"

    # 检查jq是否可用
    if ! command -v jq &> /dev/null; then
        handle_error "未找到jq命令。请运行 'brew install jq' 安装。"
    fi
}

# 列出所有窗口的应用程序名称
list_all_apps() {
    echo "===== 系统中检测到的所有应用程序 ====="
    yabai -m query --windows | jq -r '.[] | .app' | sort | uniq
    echo "===== 应用程序列表结束 ====="
}

# 获取应用程序的详细信息
get_app_details() {
    local app="$1"
    echo "===== 获取 $app 的详细信息 ====="
    yabai -m query --windows | jq -r ".[] | select(.app | contains(\"$app\"))"
    echo "===== $app 详细信息结束 ====="
}

# 获取窗口信息
get_window_info() {
    local window_id=$1
    
    if [ -z "$window_id" ]; then
        # 如果没有提供窗口ID，获取当前窗口信息
        yabai -m query --windows --window
    else
        # 获取指定窗口信息
        yabai -m query --windows --window $window_id
    fi
}

# 获取空间信息
get_space_info() {
    local space_index=$1
    
    if [ -z "$space_index" ]; then
        # 如果没有提供空间索引，获取当前空间信息
        yabai -m query --spaces --space
    else
        # 获取指定空间信息
        yabai -m query --spaces --space $space_index
    fi
}

# 获取显示器信息
get_display_info() {
    local display_index=$1
    
    if [ -z "$display_index" ]; then
        # 如果没有提供显示器索引，获取当前显示器信息
        yabai -m query --displays --display
    else
        # 获取指定显示器信息
        yabai -m query --displays --display $display_index
    fi
}

# 保存窗口状态
save_window_state() {
    local window_id=$1
    local window_info=$2
    local state_file="${WINDOW_STATE_DIR}/window-${window_id}"
    
    echo "$window_info" > "$state_file"
    debug 2 "窗口状态已保存到: $state_file"
}

# 加载窗口状态
load_window_state() {
    local window_id=$1
    local state_file="${WINDOW_STATE_DIR}/window-${window_id}"
    
    if [ -f "$state_file" ]; then
        cat "$state_file"
        debug 2 "窗口状态已从 $state_file 加载"
        return 0
    else
        debug 1 "未找到窗口状态文件: $state_file"
        return 1
    fi
}

# 等待窗口操作完成
wait_for_window_operation() {
    local delay=${1:-$SPACE_SWITCH_DELAY}
    sleep "$delay"
}

# 等待空间切换完成
wait_for_space_switch() {
    local delay=${1:-$SPACE_SWITCH_DELAY}
    sleep "$delay"
}

# 等待显示器切换完成
wait_for_display_switch() {
    local delay=${1:-$DISPLAY_SWITCH_DELAY}
    sleep "$delay"
}

# 等待规则应用完成
wait_for_rule_apply() {
    local delay=${1:-$RULE_APPLY_DELAY}
    sleep "$delay"
}

# 检查窗口是否存在
window_exists() {
    local window_id=$1
    yabai -m query --windows --window $window_id &>/dev/null
}

# 检查空间是否存在
space_exists() {
    local space_index=$1
    yabai -m query --spaces --space $space_index &>/dev/null
}

# 检查显示器是否存在
display_exists() {
    local display_index=$1
    yabai -m query --displays --display $display_index &>/dev/null
}

# 获取窗口标题
get_window_title() {
    local window_id=$1
    yabai -m query --windows --window $window_id | jq -r '.title'
}

# 获取窗口应用程序名称
get_window_app() {
    local window_id=$1
    yabai -m query --windows --window $window_id | jq -r '.app'
}

# 获取窗口进程ID
get_window_pid() {
    local window_id=$1
    yabai -m query --windows --window $window_id | jq -r '.pid'
}

# 检查窗口是否浮动
is_window_floating() {
    local window_id=$1
    local is_floating=$(yabai -m query --windows --window $window_id | jq -r '."is-floating"')
    [ "$is_floating" = "true" ]
}

# 检查窗口是否全屏
is_window_fullscreen() {
    local window_id=$1
    local is_fullscreen=$(yabai -m query --windows --window $window_id | jq -r '."is-native-fullscreen"')
    [ "$is_fullscreen" = "true" ]
}

# 检查窗口是否最小化
is_window_minimized() {
    local window_id=$1
    local is_minimized=$(yabai -m query --windows --window $window_id | jq -r '."is-minimized"')
    [ "$is_minimized" = "true" ]
}

# 检查窗口是否隐藏
is_window_hidden() {
    local window_id=$1
    local is_hidden=$(yabai -m query --windows --window $window_id | jq -r '."is-hidden"')
    [ "$is_hidden" = "true" ]
}

# 检查窗口是否可见
is_window_visible() {
    local window_id=$1
    ! is_window_minimized $window_id && ! is_window_hidden $window_id
}

# 检查窗口是否在当前空间
is_window_in_current_space() {
    local window_id=$1
    local current_space=$(yabai -m query --spaces --space | jq -r '.index')
    local window_space=$(yabai -m query --windows --window $window_id | jq -r '.space')
    [ "$current_space" = "$window_space" ]
}

# 检查窗口是否在当前显示器
is_window_in_current_display() {
    local window_id=$1
    local current_display=$(yabai -m query --displays --display | jq -r '.index')
    local window_display=$(yabai -m query --windows --window $window_id | jq -r '.display')
    [ "$current_display" = "$window_display" ]
}
