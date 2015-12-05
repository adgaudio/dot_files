# Automatically create a new session with these windows

#Register sessions that will be created by this script
SESSIONS="home work"
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
sessionhome()
{
    tmux new-session -d -s home
    tmux new-window -k -n printer_UI -t home:0
    tmux split-window -t home:printer_UI
    tmux send-keys -t home:printer_UI.0 "printer bash -lc slic3r"
    tmux send-keys -t home:printer_UI.1 "printer bash -lc pronterface.py"

    tmux new-window -k -n printer_scad -t home:1
    tmux split-window -t home:printer_scad -h
    tmux send-keys -t home:printer_scad.0 "printer bash -lc openscad"
    tmux send-keys -t home:printer_scad.1 "printer"

    tmux new-window -k -n dev -t home:2
    tmux send-keys -t home:dev "dev" Enter
}

sessionwork()
{
    tmux new-session -d -s work
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
