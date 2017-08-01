# Automatically create a new session with these windows

#Register sessions that will be created by this script
SESSIONS="cmlab work"
#
#Define logic
#
hassession() {
    tmux has-session -t $1
    rc="$?"
    if [ "$rc" -eq "0" ] ; then
        return 0
    fi
    return 1
}

listsessions() {
    echo $( tmux list-sessions | cut -d: -f1 | sort -r )
}

tryattach()
{
    hassession $1
    rc="$?"
    attached="$( tmux list-clients -t $1 )"

    if [ "$rc" -eq "0" ] && [ ! "$attached" ]; then
        (tmux attach -t $1)
    else
        return 1
    fi
}

except()
{
    if [ "$?" -eq 1 ] ; then
        $@
    fi
}

#
# Session Configuration
#
session3print()
{
    tmux new-session -d -s 3print
    tmux new-window -k -n printer_UI -t 3print:0
    tmux split-window -t 3print:printer_UI
    tmux send-keys -t 3print:printer_UI.0 "printer bash -lc slic3r"
    tmux send-keys -t 3print:printer_UI.1 "printer bash -lc pronterface.py"

    tmux new-window -k -n printer_scad -t 3print:1
    tmux split-window -t 3print:printer_scad -h
    tmux send-keys -t 3print:printer_scad.0 "printer bash -lc openscad"
    tmux send-keys -t 3print:printer_scad.1 "printer"

    # tmux new-window -k -n dev -t 3print:2
    # tmux send-keys -t 3print:dev "dev"
}

sessionwork()
{
    tmux new-session -d -s cmlab
    tmux split-window -t cmlab:1
    tmux send-keys -t cmlab:1.0 "cd s/priv/macl" Enter
    tmux send-keys -t cmlab:1.1 "cd s/priv/macl" Enter

    tmux new-session -d -s work
    tmux new-window -k -n daemons -t work:0
    tmux split-window -t work:daemons
    # tmux send-keys -t work:daemons.0 "cd s/ ; docker start py" Enter
    # tmux send-keys -t work:1 "cd s/ ; docker start blkpydev" Enter
    tmux select-window -t work:1
}

#
# Implementation
#
# Create sessions if they don't exist
for x in $SESSIONS
do
    hassession $x
    except session$x
done

# Attach to any existing session with no attached clients
for x in $(listsessions) ; do
    tryattach $x && exit 0
    echo "Couldn't attach to session $x"
done

# if all sessions already attached to,
# create a new one and attach
tmux new

hassessions() {
    for x in $@ ; do
        tmux has-session -t $x
	rc=$rc+$?
    return rc
    done
}
