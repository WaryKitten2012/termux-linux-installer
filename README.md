# Termux-Linux-Installer

本项目提供在 **Android Termux** 环境中快速部署 **Linux** 容器的自动化脚本。所有 rootfs 均基于 `debootstrap` 构建，确保纯净与轻量

## 🚀 特性

- **Linux发行版**: Ubuntu、Debian
- **版本可选**: 支持 Ubuntu 26.04 (resolute)、24.04 (noble)、22.04 (jammy) 及 Debian 13 (trixie)、12 (bookworm)、14 (testing)、sid (unstable)
- **架构适配**: 目前仅支持arm64

## 📦 安装指南 (Termux)

### 1. 安装依赖
在 Termux 中执行以下命令安装基础工具：

pkg update

pkg dist-upgrade -y

pkg install proot debootstrap wget curl git tar -y

### 2. 克隆仓库并执行安装脚本

cd ~ && git clone https://github.com/WaryKitten2012/termux-linux-installer.git && cp ~/termux-linux-installer/install.sh && bash install.sh

### 3. 启动Linux容器

如果您安装的是ubuntu，请执行以下命令启动：
./start_ubuntu.sh

如果你安装的是debian,请执行以下命令启动：
./start_debian.sh

### 配置Linux容器（配置国内软件源，中文环境，命令在容器执行）

debian13容器:
./config_debian_trixie.sh
debian12容器:
./config_debian_bookworm.sh
debian14容器:
./config_debian_forky.sh
debian sid容器：
./config_debian_sid.sh
ubuntu26.04容器：
./config_ubuntu_resolute.sh
ubuntu24.04容器：
./config_ubuntu_noble.sh
ubuntu22.04容器：
./config_ubuntu_jammy.sh


## ⚠️ 注意事项

1. **网络环境**: 需要构建容器 (大约30MB ~ 200MB) ，请确保网络通畅。
2. **存储权限**: 建议运行 `termux-setup-storage` 获取存储权限，以便在容器内访问手机存储。
3. **系统服务**: Proot 无法运行 systemd，如需服务管理请使用 `service` 命令或手动启动。

## 📜 许可证

MIT License.

