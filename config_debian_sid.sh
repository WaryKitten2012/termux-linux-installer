#!/bin/bash

#配置国内软件源
echo "deb http://mirrors.ustc.edu.cn/debian/ sid main contrib non-free non-free-firmware" >/etc/apt/sources.list

#更新软件源并安装基础包
apt update
apt dist-upgrade -y
apt install -y apt-transport-https ca-certificates curl wget vim nano locales

#配置国内软件源
echo "deb https://mirrors.ustc.edu.cn/debian/ sid main contrib non-free non-free-firmware" >/etc/apt/sources.list

apt update

#配置语言
sed -i 's/# zh_CN.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/' /etc/locale.gen
locale-gen

echo "配置完成！建议重启容器使配置生效"
