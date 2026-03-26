# 代理配置 - 端口 7890 (Shadowrocket，原 Clash)
export http_proxy="http://127.0.0.1:7890"
export https_proxy="http://127.0.0.1:7890"
export all_proxy="socks5://127.0.0.1:7890"

# 开关 alias
alias proxy-on='export http_proxy="http://127.0.0.1:7890" https_proxy="http://127.0.0.1:7890" all_proxy="socks5://127.0.0.1:7890" && echo "proxy on"'
alias proxy-off='unset http_proxy https_proxy all_proxy && echo "proxy off"'
