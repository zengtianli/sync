#!/bin/bash

# Yabai 服务控制脚本
# 此脚本提供了启动、停止、重启、切换yabai服务的功能

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 导入工具函数
source "${SCRIPT_DIR}/../lib/utils.sh"

# 检查yabai服务状态
check_yabai_status() {
    if pgrep -x "yabai" > /dev/null; then
        return 0  # 运行中
    else
        return 1  # 未运行
    fi
}

# 检查skhd服务状态
check_skhd_status() {
    if pgrep -x "skhd" > /dev/null; then
        return 0  # 运行中
    else
        return 1  # 未运行
    fi
}

# 启动yabai和skhd服务
start_yabai() {
    echo "正在启动 yabai 和 skhd 服务..."
    
    # 启动 yabai
    if check_yabai_status; then
        echo "yabai 服务已在运行"
    else
        echo "启动 yabai 服务..."
        yabai --start-service
        sleep 2
        # yabairc 配置文件会自动加载，不需要手动设置任何配置
        # 这样确保静默启动，不影响现有窗口
        
        if check_yabai_status; then
            echo "yabai 服务启动成功"
        else
            echo "错误: yabai 服务启动失败"
            return 1
        fi
    fi
    
    # 启动 skhd
    if check_skhd_status; then
        echo "skhd 服务已在运行"
    else
        echo "启动 skhd 服务..."
        skhd --start-service
        sleep 1
        
        if check_skhd_status; then
            echo "skhd 服务启动成功"
        else
            echo "警告: skhd 服务启动失败"
        fi
    fi
    
    echo "服务启动完成"
}

# 停止yabai和skhd服务
stop_yabai() {
    echo "正在停止 yabai 和 skhd 服务..."
    
    # 停止 yabai
    if ! check_yabai_status; then
        echo "yabai 服务未运行"
    else
        echo "停止 yabai 服务..."
        yabai --stop-service
        sleep 2
        
        if ! check_yabai_status; then
            echo "yabai 服务已停止"
        else
            echo "错误: yabai 服务停止失败"
        fi
    fi
    
    # 停止 skhd
    if ! check_skhd_status; then
        echo "skhd 服务未运行"
    else
        echo "停止 skhd 服务..."
        skhd --stop-service
        sleep 1
        
        if ! check_skhd_status; then
            echo "skhd 服务已停止"
        else
            echo "警告: skhd 服务停止失败"
        fi
    fi
    
    echo "服务停止完成"
}

# 重启yabai和skhd服务
restart_yabai() {
    echo "正在重启 yabai 和 skhd 服务..."
    stop_yabai
    sleep 1
    start_yabai
}

# 切换yabai和skhd服务状态
toggle_yabai() {
    echo "正在切换 yabai 和 skhd 服务状态..."
    
    if check_yabai_status; then
        stop_yabai
        echo "已切换到停止状态"
    else
        start_yabai
        echo "已切换到运行状态"
    fi
}

# 查看yabai和skhd服务状态
status_yabai() {
    echo "=== 服务状态 ==="
    
    # yabai 状态
    if check_yabai_status; then
        local yabai_pid=$(pgrep -x "yabai")
        echo "yabai 服务状态: 运行中 (PID: $yabai_pid)"
        
        # 显示版本信息
        local version=$(yabai --version 2>/dev/null || echo "无法获取版本")
        echo "yabai 版本: $version"
        
        # 显示配置信息
        local displays=$(yabai -m query --displays 2>/dev/null | jq length 2>/dev/null || echo "N/A")
        local spaces=$(yabai -m query --spaces 2>/dev/null | jq length 2>/dev/null || echo "N/A")
        echo "显示器数量: $displays"
        echo "空间数量: $spaces"
    else
        echo "yabai 服务状态: 未运行"
    fi
    
    echo ""
    
    # skhd 状态
    if check_skhd_status; then
        local skhd_pid=$(pgrep -x "skhd")
        echo "skhd 服务状态: 运行中 (PID: $skhd_pid)"
        echo "快捷键配置: ~/.config/skhd/skhdrc"
        
        # 检查配置文件是否存在
        if [ -f ~/.config/skhd/skhdrc ]; then
            local hotkey_count=$(grep -c "^[^#].*:" ~/.config/skhd/skhdrc 2>/dev/null || echo "0")
            echo "已配置快捷键数量: $hotkey_count"
        else
            echo "警告: 配置文件不存在"
        fi
    else
        echo "skhd 服务状态: 未运行"
    fi
}

# 主函数
main() {
    local action=$1
    
    # 检查依赖
    check_dependencies
    
    case "$action" in
        "start")
            start_yabai
            ;;
        "stop")
            stop_yabai
            ;;
        "restart")
            restart_yabai
            ;;
        "toggle")
            toggle_yabai
            ;;
        "status")
            status_yabai
            ;;
        *)
            echo "用法: $0 <start|stop|restart|toggle|status>"
            echo ""
            echo "操作:"
            echo "  start    启动 yabai 服务"
            echo "  stop     停止 yabai 服务"
            echo "  restart  重启 yabai 服务"
            echo "  toggle   切换服务运行状态"
            echo "  status   查看服务状态"
            exit 1
            ;;
    esac
}

# 如果直接运行脚本，则执行主函数
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
