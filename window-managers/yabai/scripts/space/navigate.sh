#!/bin/bash

# 空间导航脚本
# 此脚本提供了在空间之间导航的功能

# 移动到下一个空间
move_to_next_space() {
    echo "正在移动到下一个空间..."
    
    # 获取当前空间和显示器信息
    local current_space_index=$(yabai -m query --spaces --space 2>/dev/null | jq -r '.index // empty')
    local last_space_index=$(yabai -m query --spaces --display 2>/dev/null | jq -r 'last | .index // empty')
    local first_space_index=$(yabai -m query --spaces --display 2>/dev/null | jq -r 'first | .index // empty')
    
    # 检查是否成功获取到空间信息
    if [ -z "$current_space_index" ] || [ -z "$last_space_index" ] || [ -z "$first_space_index" ]; then
        echo "警告: 无法获取空间信息，使用基本导航"
        yabai -m space --focus next 2>/dev/null || echo "无法切换到下一个空间"
        return
    fi
    
    # 如果当前是最后一个空间，移动到第一个空间
    if [ "$current_space_index" -eq "$last_space_index" ]; then
        yabai -m space --focus "$first_space_index"
        echo "已移动到第一个空间（索引: $first_space_index）"
    else
        # 否则移动到下一个空间
        yabai -m space --focus next
        echo "已移动到下一个空间"
    fi
}

# 移动到上一个空间
move_to_prev_space() {
    echo "正在移动到上一个空间..."
    
    # 获取当前空间和显示器信息
    local current_space_index=$(yabai -m query --spaces --space 2>/dev/null | jq -r '.index // empty')
    local first_space_index=$(yabai -m query --spaces --display 2>/dev/null | jq -r 'first | .index // empty')
    local last_space_index=$(yabai -m query --spaces --display 2>/dev/null | jq -r 'last | .index // empty')
    
    # 检查是否成功获取到空间信息
    if [ -z "$current_space_index" ] || [ -z "$first_space_index" ] || [ -z "$last_space_index" ]; then
        echo "警告: 无法获取空间信息，使用基本导航"
        yabai -m space --focus prev 2>/dev/null || echo "无法切换到上一个空间"
        return
    fi
    
    # 如果当前是第一个空间，移动到最后一个空间
    if [ "$current_space_index" -eq "$first_space_index" ]; then
        yabai -m space --focus "$last_space_index"
        echo "已移动到最后一个空间（索引: $last_space_index）"
    else
        # 否则移动到上一个空间
        yabai -m space --focus prev
        echo "已移动到上一个空间"
    fi
}

# 移动到指定空间
move_to_space() {
    local space_index=$1
    
    echo "正在移动到空间 $space_index..."
    
    # 检查空间是否存在
    if ! yabai -m space --focus "$space_index" 2>/dev/null; then
        echo "错误: 空间 $space_index 不存在"
        return 1
    fi
    
    echo "已移动到空间 $space_index"
}

# 移动到最近使用的空间
move_to_recent_space() {
    echo "正在移动到最近使用的空间..."
    yabai -m space --focus recent
    echo "已移动到最近使用的空间"
}

# 主函数
main() {
    local action=$1
    local space_index=$2
    
    case "$action" in
        "next")
            move_to_next_space
            ;;
        "prev")
            move_to_prev_space
            ;;
        "to")
            if [ -z "$space_index" ]; then
                echo "错误: 需要指定目标空间索引"
                echo "用法: $0 to <空间索引>"
                exit 1
            fi
            move_to_space "$space_index"
            ;;
        "recent")
            move_to_recent_space
            ;;
        *)
            echo "错误: 未知的操作 '$action'"
            echo "用法: $0 <next|prev|to|recent> [空间索引]"
            exit 1
            ;;
    esac
}

# 如果直接运行脚本（不是被其他脚本导入），则执行主函数
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
