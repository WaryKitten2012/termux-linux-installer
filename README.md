# Termux-Linux-Installer

本项目提供在 **Android Termux** 环境中快速部署 **Ubuntu** 和 **Debian** 容器的自动化脚本。所有 rootfs 均基于 `debootstrap` 构建，确保纯净与轻量

## 🚀 特性

- **系统支持**: 可选择安装 Ubuntu 或 Debian
- **版本可选**: 支持 Ubuntu 26.04 (resolute)、24.04 (noble)、22.04 (jammy) 及 Debian 13 (trixie)、12 (bookworm)、14 (testing)、sid (unstable)
- **架构适配**: 目前仅支持arm64

## 📦 安装指南 (Termux)

### 1. 安装依赖
在 Termux 中执行以下命令安装基础工具：

pkg install proot debootstrap wget curl tar -y

