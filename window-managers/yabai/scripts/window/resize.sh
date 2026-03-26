#!/bin/bash

# 窗口大小调整脚本
# 此脚本提供了调整窗口大小的功能

# 调整步长（像素）
RESIZE_STEP=100

# 增加窗口大小
increase_window_size() {
    echo "正在增加窗口大小..."
    
    # 向上扩展
    yabai -m window --resize top:0:-${RESIZE_STEP} &
    # 向下扩展
    yabai -m window --resize bottom:0:${RESIZE_STEP} &
    # 向左扩展
    yabai -m window --resize left:-${RESIZE_STEP}:0 &
    # 向右扩展
    yabai -m window --resize right:${RESIZE_STEP}:0 &
    
    wait
    echo "窗口大小已增加"
}

# 减小窗口大小
decrease_window_size() {
    echo "正在减小窗口大小..."
    
    # 向下收缩
    yabai -m window --resize top:0:${RESIZE_STEP} &
    # 向上收缩
    yabai -m window --resize bottom:0:-${RESIZE_STEP} &
    # 向右收缩
    yabai -m window --resize left:${RESIZE_STEP}:0 &
    # 向左收缩
    yabai -m window --resize right:-${RESIZE_STEP}:0 &
    
    wait
    echo "窗口大小已减小"
}

# 调整窗口到指定大小
resize_window_to() {
    local width=$1
    local height=$2
    
    echo "正在调整窗口到指定大小: ${width}x${height}..."
    yabai -m window --resize abs:${width}:${height}
    echo "窗口大小已调整"
}

# 主函数
main() {
    local action=$1
    local width=$2
    local height=$3
    
    case "$action" in
        "increase")
            increase_window_size
            ;;
        "decrease")
            decrease_window_size
            ;;
        "resize")
            if [ -z "$width" ] || [ -z "$height" ]; then
                echo "错误: 调整窗口大小需要指定宽度和高度"
                echo "用法: $0 resize <宽度> <高度>"
                exit 1
            fi
            resize_window_to "$width" "$height"
            ;;
        *)
            echo "错误: 未知的操作 '$action'"
            echo "用法: $0 <increase|decrease|resize> [宽度 高度]"
            exit 1
            ;;
    esac
}

# 如果直接运行脚本（不是被其他脚本导入），则执行主函数
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
