# ~/.profile: executed by the command interpreter for login shells.
# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022
#
#

if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ] && [ "$TTY" = "/dev/tty1" ]; then

    # val=$(udevadm info -a -n /dev/dri/card1 | grep boot_vga | rev | cut -c 2)
    # WLR_DRM_DEVICES="/dev/dri/card$val" sway
    WLR_DRM_DEVICES=/dev/dri/card1 exec sway --unsupported-gpu
    
  # exec sway --unsupported-gpu
  # exec Hyprland
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

export LANGUAGE="en_US:en"

source_files() {
  if [ -f "$HOME/.bash_profile" ] ; then
    . ~/.bash_profile
  fi
  local sources
  [ -n "$BASH" -o -n "$ZSH_NAME" ]  && sources="1" || sources="0"
  if [ "$sources" = "1" ] ; then
      . ~/.bash_extras
      . ~/.bash_aliases
      . ~/.bash_functions
  fi
}
source_files
