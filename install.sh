#!/data/data/com.termux/files/usr/bin/bash
set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 路径定义
ROOTFS_DIR="$HOME/termux-linux"
UBUNTU_DIR="$ROOTFS_DIR/ubuntu"
DEBIAN_DIR="$ROOTFS_DIR/debian"

# 打印信息函数
info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

# 检查架构
check_arch() {
    case $(uname -m) in
        aarch64) ARCH="arm64" ;;
        armv7l|armv8l) ARCH="armhf" ;;
        x86_64) ARCH="amd64" ;;
        i*86) ARCH="i386" ;;
        *) error "Unsupported architecture: $(uname -m)" ;;
    esac
    info "Detected architecture: $ARCH"
}

# 安装必要依赖
install_deps() {
    info "Updating package lists..."
    pkg update -y
    info "Installing dependencies (debootstrap, proot, wget)..."
    pkg install -y debootstrap proot wget
}

# 交互选择配置
select_config() {
    echo -e "${CYAN}Select Linux Distribution:${NC}"
    echo "1) Ubuntu"
    echo "2) Debian"
    read -p "Enter choice (1 or 2): " dist_choice

    case $dist_choice in
        1) 
            DISTRO="ubuntu"
            TARGET_DIR="$UBUNTU_DIR"
            # 版本选择
            echo -e "${CYAN}Select Ubuntu Version:${NC}"
            echo "1) 26.04 (Resolute Raccoon)"
            echo "2) 24.04 (Noble Numbat)"
            echo "3) 22.04 (Jammy Jellyfish)"
            read -p "Enter choice (1 or 3): " ver_choice
            case $ver_choice in
                1) SUITE="resolute" ;;
                2) SUITE="noble" ;;
                3) SUITE="jammy" ;;
                *) SUITE="noble"; warn "Using default: noble" ;;
            esac
            MIRROR="https://mirrors.ustc.edu.cn/ubuntu-ports/"
            ;;
        2) 
            DISTRO="debian"
            TARGET_DIR="$DEBIAN_DIR"
            # 版本选择
            echo -e "${CYAN}Select Debian Version:${NC}"
            echo "1) trixie (stable)"
            echo "2) bookworm (oldstable)"
            echo "3) forky (testing)"
            echo "4) sid (unstable)"
            read -p "Enter choice (1 or 4): " ver_choice
            case $ver_choice in
                1) SUITE="trixie" ;;
                2) SUITE="bookworm" ;;
                3) SUITE="forky" ;;
                4) SUITE="sid" ;;
                *) SUITE="bookworm"; warn "Using default: bookworm" ;;
            esac
            MIRROR="https://mirrors.ustc.edu.cn/debian/"
            ;;
        *) error "Invalid choice" ;;
    esac

    info "Selected: $DISTRO $SUITE"
}

# 构建 rootfs
build_rootfs() {
    info "Building $DISTRO rootfs in $TARGET_DIR..."
    mkdir -p "$TARGET_DIR"

    # 使用 debootstrap 构建基础系统
    # --variant=minbase 保持最小化
    debootstrap --arch=arm64 --no-check-gpg --variant=minbase "$SUITE" "$TARGET_DIR" "$MIRROR"

    info "Rootfs built successfully!"

    # 生成对应的启动脚本
    generate_start_script
}

# 生成启动脚本
generate_start_script() {
    local script_file="$HOME/start_${DISTRO}.sh"
    cp ~/termux-linux-installer/uninstall_${DISTRO}.sh ~/
    cp ~/termux-linux/start_${DISTRO}.sh ~/
    chmod +x start_${DISTRO}.sh
    chmod +x uninstall_${DISTRO}.sh
    cp ~/termux-linux-installer/config_${DISTRO}_${SUITE}.sh ~/termux-linux/ubuntu/root
    chmod +x ~/termux-linux/ubuntu/config_${DISTRO}_${SUITE}.sh
}

# 主流程
main() {
    info "Starting Ubuntu/Debian rootfs installer..."
    check_arch
    install_deps
    select_config
    build_rootfs
    info "Installation complete!"
    echo -e "${GREEN}To start $DISTRO, run: ./start_${DISTRO}.sh${NC}"
    echo -e "${GREEN}To remove $DISTRO run: ./uninstall.sh"
    echo -e "${GREEN}To config $DISTRO at $DISTRO run: ./config_${DISTRO}_${SUITE}.sh"
}

main "$@"
