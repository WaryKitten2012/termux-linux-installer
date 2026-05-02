#!/data/data/com.termux/files/usr/bin/bash
read -p "This will delete all rootfs data. Continue? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -rf "$HOME/termux-linux/ubuntu"
    rm -rf "$HOME/start_ubuntu.sh"
    rm -rf "$HOME/uninstall_ubuntu.sh"
    echo "Uninstall complete."
else
    echo "Cancelled."
fi