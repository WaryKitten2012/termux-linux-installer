#!/data/data/com.termux/files/usr/bin/bash
read -p "This will delete all rootfs data. Continue? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -rf "$HOME/termux-linux/debian"
    rm -rf "$HOME/start_debian.sh"
    rm -rf "$HOME/uninstall_debian.sh"
    echo "Uninstall complete."
else
    echo "Cancelled."
fi