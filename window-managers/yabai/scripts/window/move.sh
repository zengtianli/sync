#!/bin/bash

# 窗口移动脚本
# 此脚本提供了窗口移动相关的功能

# 移动窗口到下一个空间
move_to_next_space() {
    echo "正在移动窗口到下一个空间..."
    
    # 获取当前空间和显示器信息
    local current_space_index=$(yabai -m query --spaces --space | jq -r '.index')
    local last_space_index=$(yabai -m query --spaces --display | jq -r 'last | .index')
    local first_space_index=$(yabai -m query --spaces --display | jq -r 'first | .index')
    
    # 如果当前是最后一个空间，移动到第一个空间
    if [ "$current_space_index" -eq "$last_space_index" ]; then
        yabai -m window --space "$first_space_index" && \
        yabai -m space --focus "$first_space_index"
    else
        # 否则移动到下一个空间
        yabai -m window --space next && \
        yabai -m space --focus next
    fi
    
    echo "窗口已移动到下一个空间"
}

# 移动窗口到上一个空间
move_to_prev_space() {
    echo "正在移动窗口到上一个空间..."
    
    # 获取当前空间和显示器信息
    local current_space_index=$(yabai -m query --spaces --space | jq -r '.index')
    local first_space_index=$(yabai -m query --spaces --display | jq -r 'first | .index')
    local last_space_index=$(yabai -m query --spaces --display | jq -r 'last | .index')
    
    # 如果当前是第一个空间，移动到最后一个空间
    if [ "$current_space_index" -eq "$first_space_index" ]; then
        yabai -m window --space "$last_space_index" && \
        yabai -m space --focus "$last_space_index"
    else
        # 否则移动到上一个空间
        yabai -m window --space prev && \
        yabai -m space --focus prev
    fi
    
    echo "窗口已移动到上一个空间"
}

# 移动窗口到指定空间
move_to_space() {
    local space_index=$1
    
    echo "正在移动窗口到空间 $space_index..."
    yabai -m window --space "$space_index" && \
    yabai -m space --focus "$space_index"
    echo "窗口已移动到空间 $space_index"
}

# 移动窗口到指定位置
move_to_position() {
    local x=$1
    local y=$2
    
    echo "正在移动窗口到位置 ($x, $y)..."
    yabai -m window --move abs:$x:$y
    echo "窗口已移动到指定位置"
}

# 主函数
main() {
    local action=$1
    local param1=$2
    local param2=$3
    
    case "$action" in
        "next")
            move_to_next_space
            ;;
        "prev")
            move_to_prev_space
            ;;
        "to-space")
            if [ -z "$param1" ]; then
                echo "错误: 需要指定目标空间索引"
                echo "用法: $0 to-space <空间索引>"
                exit 1
            fi
            move_to_space "$param1"
            ;;
        "to-position")
            if [ -z "$param1" ] || [ -z "$param2" ]; then
                echo "错误: 需要指定目标位置的 X 和 Y 坐标"
                echo "用法: $0 to-position <X坐标> <Y坐标>"
                exit 1
            fi
            move_to_position "$param1" "$param2"
            ;;
        *)
            echo "错误: 未知的操作 '$action'"
            echo "用法: $0 <next|prev|to-space|to-position> [参数...]"
            exit 1
            ;;
    esac
}

# 如果直接运行脚本（不是被其他脚本导入），则执行主函数
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
