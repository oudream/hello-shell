#! /bin/bash

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

#ConfFile
iptablesconf='/root/iptables.config.sh'
function rootness() {
  if [[ $EUID -ne 0 ]]; then
    echo "脚本需要以ROOT权限运行!"
    exit 1
  fi
}
function conf_list() {
  cat $iptablesconf
}
function conf_add() {
  if [ ! -f $iptablesconf ]; then
    echo "找不到配置文件!"
    exit 1
  fi
  echo "请输入虚拟机的内网IP"
  read -p "(Default: Exit):" confvmip
  [ -z "$confvmip" ] && exit 1
  echo
  echo "虚拟机内网IP = $confvmip"
  echo
  while true; do
    echo "请输入虚拟机的端口:"
    read -p "(默认端口: 22):" confvmport
    [ -z "$confvmport" ] && confvmport="22"
    expr $confvmport + 0 &>/dev/null
    if [ $? -eq 0 ]; then
      if [ $confvmport -ge 1 ] && [ $confvmport -le 65535 ]; then
        echo
        echo "虚拟机端口 = $confvmport"
        echo
        break
      else
        echo "输入错误，端口范围应为1-65535!"
      fi
    else
      echo "输入错误，端口范围应为1-65535!"
    fi
  done
  echo
  while true; do
    echo "请输入宿主机的端口"
    read -p "(默认端口: 8899):" natconfport
    [ -z "$natconfport" ] && natconfport="8899"
    expr $natconfport + 0 &>/dev/null
    if [ $? -eq 0 ]; then
      if [ $natconfport -ge 1 ] && [ $natconfport -le 65535 ]; then
        echo
        echo "宿主机端口 = $natconfport"
        echo
        break
      else
        echo "输入错误，端口范围应为1-65535!"
      fi
    else
      echo "输入错误，端口范围应为1-65535!"
    fi
  done
  echo "请输入转发协议:"
  read -p "(tcp 或者 udp ,回车默认操作: 退出):" conftype
  [ -z "$conftype" ] && exit 1
  echo
  echo "协议类型 = $conftype"
  echo
  iptablesshell="iptables -t nat -A PREROUTING -i vmbr0 -p $conftype --dport $natconfport -j DNAT --to-destination $confvmip:$confvmport"
  if [ $(grep -c "$iptablesshell" $iptablesconf) != '0' ]; then
    echo "配置已经存在"
    exit 1
  fi
  get_char() {
    SAVEDSTTY=$(stty -g)
    stty -echo
    stty cbreak
    dd if=/dev/tty bs=1 count=1 2>/dev/null
    stty -raw
    stty echo
    stty $SAVEDSTTY
  }
  echo
  echo "回车继续，Ctrl+C退出脚本"
  char=$(get_char)
  echo $iptablesshell >>$iptablesconf
  runreturn=$($iptablesshell)
  echo $runreturn
  echo '配置添加成功'
}
function add_confs() {
  rootness
  conf_add
}
function del_conf() {
  echo
  while true; do
    echo "请输入宿主机的端口"
    read -p "(默认操作: 退出):" confserverport
    [ -z "$confserverport" ] && exit 1
    expr $confserverport + 0 &>/dev/null
    if [ $? -eq 0 ]; then
      if [ $confserverport -ge 1 ] && [ $confserverport -le 65535 ]; then
        echo
        echo "宿主机端口 = $confserverport"
        echo
        break
      else
        echo "输入错误，端口范围应为1-65535!"
      fi
    else
      echo "输入错误，端口范围应为1-65535!"
    fi
  done
  echo
  iptablesshelldel=$(cat $iptablesconf | grep "dport $confserverport")
  if [ ! -n "$iptablesshelldel" ]; then
    echo "配置文件中没有该宿主机的端口"
    exit 1
  fi
  iptablesshelldelshell=$(echo ${iptablesshelldel//-A/-D})
  runreturn=$($iptablesshelldelshell)
  echo $runreturn
  sed -i "/$iptablesshelldel/d" $iptablesconf
  echo '配置删除成功'
}
function del_confs() {
  printf "你确定要删除配置吗？操作是不可逆的(y/n) "
  printf "\n"
  read -p "(默认: n):" answer
  if [ -z $answer ]; then
    answer="n"
  fi
  if [ "$answer" = "y" ]; then
    rootness
    del_conf
  else
    echo "配置删除操作取消"
  fi
}
action=$1
case "$action" in
add)
  add_confs
  ;;
list)
  conf_list
  ;;
del)
  del_confs
  ;;
*)
  echo "参数错误! [${action} ]"
  echo "用法: $(basename $0) {add|list|del}"
  ;;
esac
