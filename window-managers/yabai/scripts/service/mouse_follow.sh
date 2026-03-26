#!/bin/bash

# 鼠标追踪开关脚本
# 同步切换以下两个选项：
# - focus_follows_mouse   鼠标移动时焦点跟随
# - mouse_follows_focus   焦点变化时鼠标跟随

# 获取脚本所在目录并导入工具库
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../lib/utils.sh"

get_config() {
    local key=$1
    # yabai -m config <key> 会输出当前值（如 on/off/数字）
    yabai -m config "$key" 2>/dev/null | tr -d '\n' | tr -d '\r'
}

set_config() {
    local key=$1
    local value=$2
    yabai -m config "$key" "$value"
}

print_status() {
    local ffm=$(get_config focus_follows_mouse)
    local mff=$(get_config mouse_follows_focus)
    echo "focus_follows_mouse: ${ffm:-unknown}"
    echo "mouse_follows_focus: ${mff:-unknown}"
}

toggle_both() {
    local ffm=$(get_config focus_follows_mouse)
    local mff=$(get_config mouse_follows_focus)

    # 若读取失败，默认视为 off
    [ -z "$ffm" ] && ffm=off
    [ -z "$mff" ] && mff=off

    local new_ffm=off
    local new_mff=off

    [ "$ffm" = "off" ] && new_ffm=on || new_ffm=off
    [ "$mff" = "off" ] && new_mff=on || new_mff=off

    echo "切换前:"
    print_status

    set_config focus_follows_mouse "$new_ffm"
    set_config mouse_follows_focus "$new_mff"

    echo "切换后:"
    print_status
}

set_on() {
    set_config focus_follows_mouse on
    set_config mouse_follows_focus on
    print_status
}

set_off() {
    set_config focus_follows_mouse off
    set_config mouse_follows_focus off
    print_status
}

main() {
    local action=$1

    # 依赖检查
    check_dependencies

    case "$action" in
        toggle)
            toggle_both
            ;;
        on)
            set_on
            ;;
        off)
            set_off
            ;;
        status|"")
            print_status
            ;;
        *)
            echo "用法: $0 [toggle|on|off|status]"
            exit 1
            ;;
    esac
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi


