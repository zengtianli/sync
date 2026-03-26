#!/bin/bash

# 窗口定位脚本
# 此脚本提供了将窗口快速定位到屏幕四个角落的功能

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 导入工具函数
source "${SCRIPT_DIR}/../lib/utils.sh"

# 窗口占屏幕的比例（1/4屏幕大小）
WINDOW_RATIO=0.5

# 获取当前显示器信息并计算窗口尺寸
get_display_info_and_window_size() {
    # 获取当前空间所在的显示器信息
    local display_info=$(yabai -m query --displays --display)
    
    # 解析显示器尺寸和位置
    local display_x=$(echo "$display_info" | jq -r '.frame.x | floor')
    local display_y=$(echo "$display_info" | jq -r '.frame.y | floor')
    local display_width=$(echo "$display_info" | jq -r '.frame.w | floor')
    local display_height=$(echo "$display_info" | jq -r '.frame.h | floor')
    
    # 计算窗口尺寸（屏幕的一半）
    local window_width=$(echo "$display_width * $WINDOW_RATIO" | bc | cut -d. -f1)
    local window_height=$(echo "$display_height * $WINDOW_RATIO" | bc | cut -d. -f1)
    
    # 返回计算结果
    echo "$display_x $display_y $display_width $display_height $window_width $window_height"
}

# 调试日志
LOG_FILE="/tmp/yabai_position_debug.log"
debug_log() {
    echo "$(date '+%H:%M:%S') $*" >> "$LOG_FILE"
}

# 确保当前窗口为浮动状态
ensure_window_floating() {
    local win_info=$(yabai -m query --windows --window 2>&1)
    local app=$(echo "$win_info" | jq -r '.app // "ERROR"')
    local wid=$(echo "$win_info" | jq -r '.id // "ERROR"')
    local is_floating=$(echo "$win_info" | jq -r '."is-floating" // "ERROR"')
    local has_ax=$(echo "$win_info" | jq -r '."has-ax-reference" // "ERROR"')
    local can_move=$(echo "$win_info" | jq -r '."can-move" // "ERROR"')
    local can_resize=$(echo "$win_info" | jq -r '."can-resize" // "ERROR"')
    
    debug_log "APP=$app ID=$wid floating=$is_floating ax-ref=$has_ax can-move=$can_move can-resize=$can_resize"
    
    if [ "$is_floating" = "false" ]; then
        local toggle_result=$(yabai -m window --toggle float 2>&1)
        debug_log "toggle float: exit=$? output='$toggle_result'"
    fi
}

# 定位到左上角
position_top_left() {
    echo "正在将窗口定位到左上角..."
    
    ensure_window_floating
    
    read -r display_x display_y display_width display_height window_width window_height <<< $(get_display_info_and_window_size)
    
    # 计算左上角位置
    local x=$display_x
    local y=$display_y
    
    # 移动并调整窗口大小
    yabai -m window --move abs:$x:$y
    yabai -m window --resize abs:$window_width:$window_height
    
    echo "窗口已定位到左上角 (${x}, ${y}) 尺寸: ${window_width}x${window_height}"
}

# 定位到右上角
position_top_right() {
    echo "正在将窗口定位到右上角..."
    
    ensure_window_floating
    
    read -r display_x display_y display_width display_height window_width window_height <<< $(get_display_info_and_window_size)
    
    # 计算右上角位置
    local x=$((display_x + display_width - window_width))
    local y=$display_y
    
    # 移动并调整窗口大小
    yabai -m window --move abs:$x:$y
    yabai -m window --resize abs:$window_width:$window_height
    
    echo "窗口已定位到右上角 (${x}, ${y}) 尺寸: ${window_width}x${window_height}"
}

# 定位到左下角
position_bottom_left() {
    echo "正在将窗口定位到左下角..."
    
    ensure_window_floating
    
    read -r display_x display_y display_width display_height window_width window_height <<< $(get_display_info_and_window_size)
    
    # 计算左下角位置
    local x=$display_x
    local y=$((display_y + display_height - window_height))
    
    # 移动并调整窗口大小
    yabai -m window --move abs:$x:$y
    yabai -m window --resize abs:$window_width:$window_height
    
    echo "窗口已定位到左下角 (${x}, ${y}) 尺寸: ${window_width}x${window_height}"
}

# 定位到右下角
position_bottom_right() {
    echo "正在将窗口定位到右下角..."
    
    ensure_window_floating
    
    read -r display_x display_y display_width display_height window_width window_height <<< $(get_display_info_and_window_size)
    
    # 计算右下角位置
    local x=$((display_x + display_width - window_width))
    local y=$((display_y + display_height - window_height))
    
    # 移动并调整窗口大小
    yabai -m window --move abs:$x:$y
    yabai -m window --resize abs:$window_width:$window_height
    
    echo "窗口已定位到右下角 (${x}, ${y}) 尺寸: ${window_width}x${window_height}"
}

# 按上/下两行、每行四列定位
# 用法: position_grid <top|bottom> <1|2|3|4>
position_grid() {
    local row=$1
    local col=$2
    echo "正在将窗口定位到 ${row} 行 第 ${col}/4 列..."

    # 参数校验
    if [ -z "$row" ] || [ -z "$col" ]; then
        echo "错误: 需要指定行(top|bottom)和列索引(1-4)" >&2
        return 1
    fi
    if [ "$row" != "top" ] && [ "$row" != "bottom" ]; then
        echo "错误: 行参数必须为 top 或 bottom" >&2
        return 1
    fi
    if ! echo "$col" | grep -Eq '^[1-4]$'; then
        echo "错误: 列参数必须为 1..4" >&2
        return 1
    fi

    ensure_window_floating

    # 获取显示器尺寸
    local display_info=$(yabai -m query --displays --display)
    local display_x=$(echo "$display_info" | jq -r '.frame.x | floor')
    local display_y=$(echo "$display_info" | jq -r '.frame.y | floor')
    local display_width=$(echo "$display_info" | jq -r '.frame.w | floor')
    local display_height=$(echo "$display_info" | jq -r '.frame.h | floor')

    # 计算单元格尺寸（上/下各一半高度，左右四等分）
    local cell_width=$((display_width / 4))
    local cell_height=$((display_height / 2))

    # 计算位置
    local x=$((display_x + (col - 1) * cell_width))
    local y=$display_y
    if [ "$row" = "bottom" ]; then
        y=$((display_y + cell_height))
    fi

    # 移动并调整窗口大小
    yabai -m window --move abs:$x:$y
    yabai -m window --resize abs:$cell_width:$cell_height

    echo "窗口已定位到 ${row} 行 第 ${col}/4 列 (${x}, ${y}) 尺寸: ${cell_width}x${cell_height}"
}

# 左半屏
position_left() {
    echo "正在将窗口定位到左半屏..."
    
    ensure_window_floating
    
    local display_info=$(yabai -m query --displays --display)
    local display_x=$(echo "$display_info" | jq -r '.frame.x | floor')
    local display_y=$(echo "$display_info" | jq -r '.frame.y | floor')
    local display_width=$(echo "$display_info" | jq -r '.frame.w | floor')
    local display_height=$(echo "$display_info" | jq -r '.frame.h | floor')
    
    local window_width=$((display_width / 2))
    local window_height=$display_height
    
    yabai -m window --move abs:$display_x:$display_y
    yabai -m window --resize abs:$window_width:$window_height
    
    echo "窗口已定位到左半屏 (${display_x}, ${display_y}) 尺寸: ${window_width}x${window_height}"
}

# 右半屏
position_right() {
    echo "正在将窗口定位到右半屏..."
    
    ensure_window_floating
    
    local display_info=$(yabai -m query --displays --display)
    local display_x=$(echo "$display_info" | jq -r '.frame.x | floor')
    local display_y=$(echo "$display_info" | jq -r '.frame.y | floor')
    local display_width=$(echo "$display_info" | jq -r '.frame.w | floor')
    local display_height=$(echo "$display_info" | jq -r '.frame.h | floor')
    
    local window_width=$((display_width / 2))
    local window_height=$display_height
    local x=$((display_x + window_width))
    
    yabai -m window --move abs:$x:$display_y
    yabai -m window --resize abs:$window_width:$window_height
    
    echo "窗口已定位到右半屏 (${x}, ${display_y}) 尺寸: ${window_width}x${window_height}"
}

# 全屏
position_full() {
    echo "正在将窗口全屏..."
    
    ensure_window_floating
    
    local display_info=$(yabai -m query --displays --display)
    local display_x=$(echo "$display_info" | jq -r '.frame.x | floor')
    local display_y=$(echo "$display_info" | jq -r '.frame.y | floor')
    local display_width=$(echo "$display_info" | jq -r '.frame.w | floor')
    local display_height=$(echo "$display_info" | jq -r '.frame.h | floor')
    
    yabai -m window --move abs:$display_x:$display_y
    yabai -m window --resize abs:$display_width:$display_height
    
    echo "窗口已全屏 (${display_x}, ${display_y}) 尺寸: ${display_width}x${display_height}"
}

# 主函数
main() {
    local position=$1
    
    # 检查依赖
    check_dependencies
    
    # 检查bc命令是否可用（用于浮点数计算）
    if ! command -v bc &> /dev/null; then
        handle_error "未找到bc命令。请运行 'brew install bc' 安装。"
    fi
    
    case "$position" in
        "top-left")
            position_top_left
            ;;
        "top-right")
            position_top_right
            ;;
        "bottom-left")
            position_bottom_left
            ;;
        "bottom-right")
            position_bottom_right
            ;;
        "left")
            position_left
            ;;
        "right")
            position_right
            ;;
        "full")
            position_full
            ;;
        "grid")
            position_grid "$2" "$3"
            ;;
        *)
            echo "用法: $0 <top-left|top-right|bottom-left|bottom-right|left|right|full|grid> [参数]"
            echo ""
            echo "位置选项:"
            echo "  top-left      左上角"
            echo "  top-right     右上角"
            echo "  bottom-left   左下角"
            echo "  bottom-right  右下角"
            echo "  left          左半屏"
            echo "  right         右半屏"
            echo "  full          全屏"
            echo "  grid top N    上半屏 第N列 (N=1..4)"
            echo "  grid bottom N 下半屏 第N列 (N=1..4)"
            exit 1
            ;;
    esac
}

# 如果直接运行脚本，则执行主函数
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
