SUDO=""
if (( $EUID != 0 )); then
    SUDO="sudo"
fi

# For current session
echo 0 | $SUDO tee /sys/module/hid_apple/parameters/fnmode

# For after reboot
echo options hid_apple fnmode=0 | $SUDO tee -a /etc/modprobe.d/hid_apple.conf

if command -v mkinitcpio &> /dev/null
then
  $SUDO mkinitcpio -P
elif command -v update-initramfs &> /dev/null
then
  $SUDO update-initramfs -u
elif command -v dracut &> /dev/null
then
  $SUDO dracut --regenerate-all --force
else
  echo "Could not find mkinitcpio, update-initramfs or dracut. Please a find an alternative for your distribution and submit a PR."
fi
