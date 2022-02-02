#!/bin/bash
if [ $USER != 'root' ];then
    echo '请执行命令:'
    echo '    sudo su'
    echo '以root用户执行本脚本'
    exit 1
fi
QBROOT='/var/packages/qBittorrent/target'
if [ ! -d $QBROOT ]; then
  echo '找不到qbittorrent安装路径'
  exit 1
fi
NOXURL='https://github.com/ChisBread/qbittorrent_skip_patch/releases/download/v0.3/qbittorrent-nox.v4.3.9'
QBUSER=`ls -l $QBROOT/bin/qbittorrent-nox|awk '{print $3":"$4}'`
mkdir /tmp/qbt-skip && cd /tmp/qbt-skip
wget $NOXURL --no-check-certificate -o qbittorrent-nox
cp qbittorrent-nox $QBROOT/bin/qbittorrent-nox
chown $QBUSER $QBROOT/bin/qbittorrent-nox