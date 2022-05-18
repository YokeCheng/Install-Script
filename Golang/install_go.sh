#!/bin/bash
read -p "Please Enter Installing Golang Package Name(eg:go1.18.1.linux-amd64):" GO_PACK

echo You Have Entered Package $GO_PACK
__current_dir=$(
   cd "$(dirname "$0")"
   pwd
)
args=$@
__os=`uname -a`

function log() {
   message="[Golang install Log]: $1 "
   echo -e "${message}" 2>&1 | tee -a ${__current_dir}/install_telegraf.log
}

log "======================= 开始安装 ======================="

# 检查go服务是否正常运行
sudo go version 1>/dev/null 2>/dev/null

# $?这里表示上一次运行的结果
# 表示上次执行是否成功
if [ $? != 0 ];then
  log "... 下载 go"
  sudo wget https://dl.google.com/go/$GO_PACK.tar.gz
  log "... 安装 go"
  sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf $GO_PACK.tar.gz
  # shellcheck disable=SC2129
  sudo echo 'export GOROOT=/usr/local/go'>>/etc/profile
  sudo echo 'export PATH=$PATH:$GOROOT/bin'>>/etc/profile
  sudo echo 'export GOPATH=$GOROOT/src'>>/etc/profile
  # shellcheck disable=SC2232
  sudo source /etc/profile
fi

# 检查go服务是否正常运行
sudo go version 1>/dev/null 2>/dev/null

# $?这里表示上一次运行的结果
# 表示上次执行是否成功
if [ $? != 0 ];then
   log "go 未正常启动，请先安装并启动 go 服务后再次执行本脚本"
   exit
fi

echo -e "======================= 安装完成 =======================\n" 2>&1 | tee -a ${__current_dir}/install_go.log