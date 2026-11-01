#!/usr/bin/env bash
# Start a quick temporary VNC server (TigerVNC) on a remote machine that goes
# away when you log out and then connect to it. Assumes TigerVNC has been used
# at least once before on server (so that the .vnc/xstartup file is defined).

set -e
set -u

function usage {
    cat <<EOF
usage: $0 [-s] [-k] [-c] [-d x11_display] ssh_hostname

  -s  This option starts a TigerVNC VNC server
  -k  This option kills the VNC server when finished using it.
  -c  If passed, do not try to connect the client. Useful in combination with "-s".
  -d  Choose the X11 display. By default, '-d 2' sets VNC server on DISPLAY=:2 and also listens locally on port 590X, where X=2.
EOF
}

function main {
    local display="2"  # sets DISPLAY=:2 and port to listen on as 590X, where X=2
    local autokill=false
    local client=true
    local start=false

    while getopts "hskd:c" opt; do
        case $opt in
            s) start=true ;;
            k) autokill=true ;;
            d) display="${OPTARG}" ;;
            c) client=false ;;
            h | *) usage ; exit 1 ;;
        esac
    done
    shift $((OPTIND - 1))

    local sshhost=${1:-""}
    if [ -z "$sshhost" ]; then
        echo "ERROR: Missing ssh_hostname"
        usage
        exit 1
    fi

    shift
    if [ "$#" != 0 ] ; then
        echo "ERROR: do not pass args after 'ssh_hostname'"
        usage
        exit 1
    fi

    local sshcmd="ssh -C -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $sshhost"

    # Run the connection sequence in the background
    (
        if [ "$start" = true ] ; then
            ( set -x ; $sshcmd "vncserver :$display" ) || true
        fi

        if [ "$client" = true ] ; then
            set -x
            $sshcmd -f -L "590$display:127.0.0.1:590$display" sleep 10
            set +x
            
            # Wait briefly to ensure the tunnel socket is fully initialized
            sleep 1
            
            # Use a proper VNC client instead of a server binary (wayvnc)
            if command -v wlvncc &> /dev/null; then
                wlvncc 127.0.0.1 "590$display"
            elif command -v vncviewer &> /dev/null; then
                vncviewer 127.0.0.1::"590$display"
            else
                echo "ERROR: Neither 'wlvncc' nor 'vncviewer' client found locally."
                exit 1
            fi
        fi

        if [ "$autokill" = true ] ; then
            set -x
            $sshcmd "vncserver -kill :$display"
            set +x
        fi
    ) &
    disown
}

main "$@"
