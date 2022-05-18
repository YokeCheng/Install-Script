#!/bin/bash
__current_dir=$(
   cd "$(dirname "$0")"
   pwd
)
args=$@
__os=`uname -a`

function log() {
   message="[Telegraf install Log]: $1 "
   echo -e "${message}" 2>&1 | tee -a ${__current_dir}/install_telegraf.log
}

log "======================= 开始安装 ======================="
#Install telegraf
##Install Latest Stable Telegraf Release
if which telegraf >/dev/null; then
   log "检测到 Telegraf 已安装，跳过安装步骤"
   log "启动 Telegraf "
   sudo systemctl restart telegraf.service 2>&1 | tee -a ${__current_dir}/install_telegraf.log
else
  if [[ -d telegraf ]]; then
    log "... 离线安装 telegraf"
    sudo mkdir -p /etc/telegraf/ || exit 2
    sudo cp -b telegraf/etc/* /etc/telegraf/ || exit 3
    sudo cp -b telegraf/service/telegraf.service /usr/lib/systemd/system/ || exit 4
    sudo chmod 754 /usr/lib/systemd/system/telegraf.service
    sudo cp -b telegraf/bin/* /usr/bin/
    sudo chmod +x /usr/bin/telegraf*

    log "... 启动 telegraf"
    sudo systemctl restart telegraf.service 2>&1 | tee -a ${__current_dir}/install_telegraf.log
  else
    log "暂不支持在线安装 telegraf"
  fi
fi

# 检查docker服务是否正常运行
sudo systemctl status telegraf 1>/dev/null 2>/dev/null

# $?这里表示上一次运行的结果
# 表示上次执行是否成功
if [ $? != 0 ];then
   log "telegraf 未正常启动，请先安装并启动 telegraf 服务后再次执行本脚本"
   exit
fi

echo -e "======================= 安装完成 =======================\n" 2>&1 | tee -a ${__current_dir}/install_telegraf.log