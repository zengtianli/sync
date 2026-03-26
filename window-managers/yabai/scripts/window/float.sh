#!/bin/bash

# 窗口浮动控制脚本
# 此脚本提供了窗口浮动状态的控制功能

# 配置文件目录
CONFIG_DIR="/tmp/yabai-tiling-floating-toggle"
mkdir -p "$CONFIG_DIR"

# 保存窗口状态
save_window_state() {
    local window_id=$1
    local window_pos=$2
    local config_file="$CONFIG_DIR/window-${window_id}"
    
    echo "正在保存窗口状态..."
    echo "$window_pos" > "$config_file"
    echo "窗口状态已保存到: $config_file"
}

# 加载窗口状态
load_window_state() {
    local window_id=$1
    local config_file="$CONFIG_DIR/window-${window_id}"
    
    if [ -f "$config_file" ]; then
        echo "正在加载窗口状态..."
        cat "$config_file"
        echo "窗口状态已加载"
    else
        echo "未找到窗口状态文件: $config_file"
        return 1
    fi
}

# 计算居中位置
calculate_center_position() {
    local display=$1
    
    # 获取显示器尺寸
    read -r displayX displayY displayWidth displayHeight <<< $(yabai -m query --displays --display $display | jq -r '.frame | "\(.x | floor) \(.y | floor) \(.w | floor) \(.h | floor)"')
    
    # 计算窗口尺寸（显示器尺寸的一半）
    local windowWidth=$((displayWidth / 2))
    local windowHeight=$((displayHeight / 2))
    
    # 计算窗口位置（居中）
    local windowX=$((displayX + displayWidth / 4))
    local windowY=$((displayY + displayHeight / 4))
    
    # 返回计算结果
    echo "$windowX $windowY $windowWidth $windowHeight"
}

# 切换窗口浮动状态
toggle_float() {
    echo "正在切换窗口浮动状态..."
    
    # 获取当前窗口信息
    local window_info=$(yabai -m query --windows --window)
    local window_id=$(echo "$window_info" | jq -r '.id')
    local is_floating=$(echo "$window_info" | jq -r '."is-floating"')
    
    # 获取当前空间类型
    local space_type=$(yabai -m query --spaces --space | jq -r '.type')
    
    if [ "$space_type" = "bsp" ]; then
        # 保存当前窗口状态
        save_window_state "$window_id" "$window_info"
        
        # 切换浮动状态
        yabai -m window --toggle float
        
        if [ "$is_floating" = "false" ]; then
            # 如果之前不是浮动状态，切换后居中显示
            local display=$(yabai -m query --spaces --space | jq '.display')
            read -r x y w h <<< $(calculate_center_position "$display")
            
            # 移动和调整窗口
            yabai -m window --move abs:$x:$y
            yabai -m window --resize abs:$w:$h
        else
            # 如果之前是浮动状态，恢复之前的状态
            load_window_state "$window_id"
        fi
    fi
    
    echo "窗口浮动状态切换完成"
}

# 将窗口置于中心
center_window() {
    echo "正在将窗口置于中心..."
    
    # 获取当前显示器
    local display=$(yabai -m query --spaces --space | jq '.display')
    
    # 计算居中位置
    read -r x y w h <<< $(calculate_center_position "$display")
    
    # 移动和调整窗口
    yabai -m window --move abs:$x:$y
    yabai -m window --resize abs:$w:$h
    
    echo "窗口已置于中心"
}

# 主函数
main() {
    local action=$1
    
    case "$action" in
        "toggle")
            toggle_float
            ;;
        "center")
            center_window
            ;;
        *)
            echo "错误: 未知的操作 '$action'"
            echo "用法: $0 <toggle|center>"
            exit 1
            ;;
    esac
}

# 如果直接运行脚本（不是被其他脚本导入），则执行主函数
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
