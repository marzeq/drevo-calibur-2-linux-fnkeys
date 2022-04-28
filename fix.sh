# For current session
echo 0 | sudo tee /sys/module/hid_apple/parameters/fnmode

# For after reboot
echo options hid_apple fnmode=0 | sudo tee -a /etc/modprobe.d/hid_apple.conf

if command -v mkinitcpio &> /dev/null
then
  sudo mkinitcpio -P
elif command -v update-initramfs &> /dev/null
then
  sudo update-initramfs
else
  echo "Could not find mkinitcpio or update-initramfs. Please a find an alternative for your distribution."
fi
