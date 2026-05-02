#!/bin/bash

#配置国内软件源
echo "deb https://mirrors.ustc.edu.cn/ubuntu-ports/ jammy main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu-ports/ jammy-security main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu-ports/ jammy-updates main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu-ports/ jammy-backports main restricted universe multiverse" >/etc/apt/sources.list

#更新软件源并安装基础包
apt update
apt dist-upgrade -y
apt install -y curl wget vim nano locales

#配置语言
sed -i 's/# zh_CN.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/' /etc/locale.gen
locale-gen

echo "配置完成！建议重启容器使配置生效"
