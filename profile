# ~/.profile: executed by the command interpreter for login shells.
# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022
#
#
if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ] && [ "$TTY" = "/dev/tty1" ]; then

    # val=$(udevadm info -a -n /dev/dri/card1 | grep boot_vga | rev | cut -c 2)
    # WLR_DRM_DEVICES="/dev/dri/card$val" ssh-agent sway
    # WLR_DRM_DEVICES=/dev/dri/card1 exec ssh-agent sway  --unsupported-gpu
    #
 

    #export WLR_DRM_DEVICES=/dev/dri/card1
    # export WLR_RENDERER=vulkan
    # export __GL_GSYNC_ALLOWED=1
    # export WLR_NO_HARDWARE_CURSORS=1
    # export __GL_VRR_ALLOWED=0
    #
    #
    #
    #
    # toggled off:
    # export LIBVA_DRIVER_NAME=nvidia
    # export GBM_BACKEND=nvidia-drm
    # export __GLX_VENDOR_LIBRARY_NAME=nvidia
    # export XDG_SESSION_TYPE=wayland
    # export WLR_DRM_NO_ATOMIC=1
    # export NVD_BACKEND=direct
    # export XWAYLAND_NO_GLAMOR=1
    # export __NV_PRIME_RENDER_OFFLOAD=1 
    # export ELECTRON_OZONE_PLATFORM_HINT=auto  # for hyprland - maybe works for sway too. to fix flickering

    # WLR_DRM_DEVICES=/dev/dri/card1:/dev/dri/card0 
    # exec ssh-agent sway -d --unsupported-gpu &> sway.log
    exec Hyprland
    # ## exec ssh-agent sway
    BROWSER=firefox


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
