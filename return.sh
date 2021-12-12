red(){ echo -e "\033[31m\033[01m$1\033[0m"; }
green(){ echo -e "\033[32m\033[01m$1\033[0m"; }
reading(){ read -rp "$(green "$1")" "$2"; }

ARCHITECTURE="$(arch)"
case $ARCHITECTURE in
x86_64 )  FILE=besttrace;;
aarch64 ) FILE=besttracearm;;
* ) red " 只支持 AMD64 和 ARM64 架构的 VPS 使用，问题反馈:[https://github.com/fscarmen/tools/issues] " && exit 1;;
esac

ip=$1
green " 本脚说明：测 VPS ——> 对端 经过的地区及线路，填本地IP就是测回程，核心测速程序来由: https://www.ipip.net/ ，请知悉！"
[[ -z "$ip" || $ip = '[DESTINATION_IP]' ]] && reading " 请输入目的地 IP: " ip
[[ -f "$FILE" ]] || ( green " 下载 IPIP.net 测线路文件 " && wget -N https://github.com/fscarmen/tools/raw/main/besttrace/$FILE >/dev/null 2>&1 )
chmod +x "$FILE" >/dev/null 2>&1
./"$FILE" "$ip" -g cn
