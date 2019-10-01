#!/usr/bin/env bash

# start a quick temporary vnc server (tigervnc) on remote machine that goes
# away when you log out and then connect to it.  Assumes tigervnc has been used
# at least once before on server (so that the .vnc/xstartup file is defined)
set -e
set -u

function usage {
cat <<EOF

  usage:  $0  [-k] [-c] [-d x11_display] ssh_hostname"

       -k This option does not kill the VNC server when finished using it.
          If you pass '-k' you must remember to manually exit the vnc server
       -c If passed, do not try to connect the client.  Useful in
          combination with '-k', where '-ck' creates a vnc server
          and then '-c' kills it.
       -d Choose the X11 display.  By default, '-d 2' sets VNC server on
          DISPLAY=:2 and also listens locally on port 590X, where X=2.
EOF
}


function main {
  local display="2"  # this sets DISPLAY=:2 and port to listen on as 590X, where X=2
  local autokill="-autokill"  # by default, quit after vnc client disconnects
  local client=true  # by default, connect using VNC client
  while getopts "hkd:c" opt; do
      case $opt in
          k) local autokill=""  ;;
          d) local display="${OPTARG}";;
          c) local client=false;;
          h | *) usage ; exit 1;;
      esac
  done
  shift $((OPTIND -1))
  local sshhost=$1  # my_vnc_server
  shift
  if [ "$#" != 0 ] ; then
    echo "ERROR: do not pass args after 'ssh_hostname'"
    usage
    exit 1
  fi

  sshcmd="ssh -C \
    -o StrictHostKeyChecking=no \
    -o UserKnownHostsFile=/dev/null \
    $sshhost"

  (
  (set -x ; $sshcmd vncserver :$display $autokill -localhost) || true
  set -x
  $sshcmd -f -L 590$display:127.0.0.1:590$display sleep 10
  set +x
  if [ "$client" = true ] ; then
    vncviewer 127.0.0.1:590$display
  fi
  if [ "$autokill" != "" ] ; then
    set -x
    $sshcmd vncserver -kill :$display
    set +x
  fi
  ) &
  disown
}
main $@
