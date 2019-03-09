#!/usr/bin/env bash

# start a quick temporary vnc server (tigervnc) on remote machine that goes
# away when you log out and then connect to it.  Assumes tigervnc has been used
# at least once before on server (so that the .vnc/xstartup file is defined)
set -e
set -u

function main {
  local sshhost=$1
  local display=2  # both port to forward and X display to listen on
  # local sshhost="my_vnc_server"
  # local display=":1"
  # while getopts "h:d:" opt; do
  #     case $opt in
  #         h ) local sshhost="${OPTARG}";;
  #         d ) local display="${OPTARG}";;
  #         *) echo "usage:  $0  [-h ssh_hostname] [-d x11_display]"
  #         exit 1;;
  #     esac
  # done

  sshcmd="ssh -C \
    -o StrictHostKeyChecking=no \
    -o UserKnownHostsFile=/dev/null \
    $sshhost"

  (
  set -x
  $sshcmd vncserver :$display -autokill -localhost
  $sshcmd -f -L 590$display:127.0.0.1:590$display sleep 10
  vncviewer 127.0.0.1:590$display
  $sshcmd vncserver -kill :$display
  ) &
  disown
}
main $@
