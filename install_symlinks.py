#! /usr/bin/env python

import os
join = os.path.join

# source
s = os.path.realpath(os.path.dirname(__file__))
# dest
d = os.environ['HOME']


def maybe(f):
    def tryer(*args, **kwargs):
        try:
            f(*args, **kwargs)
        except Exception, e:
            print e
    return tryer


@maybe
def symlink(x, y, s=s, d=d):
    print join(s, x) + '......' + join(d, y)
    os.symlink(join(s, x), join(d, y))

#########################################
#########################################

if __name__ == '__main__':
    symlink("bash_aliases", ".bash_aliases")
    symlink("bash_functions", ".bash_functions")
    symlink("bash_aliases", ".bash_aliases")
    symlink("bash_extras", ".bash_extras")

    symlink("tmux/tmux.conf", ".tmux.conf")
    symlink("tmux/bash_completion_tmux.sh", ".bash_completion_tmux.sh")

    # Install janus
    #os.system(join(s, "vim/bootstrap_janus"))

