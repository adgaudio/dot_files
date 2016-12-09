"""
This file is executed when the Python interactive shell is started if
$PYTHONSTARTUP is in your environment and points to this file. It's just
regular Python commands, so do what you will. Your ~/.inputrc file can greatly
complement this file.
"""
import os

try:
    import readline
    import rlcompleter
    import atexit
except ImportError:
    print("You need readline, rlcompleter, and atexit")


# Make this work properly in Darwin and Linux
if 'libedit' in readline.__doc__:
    readline.parse_and_bind("bind ^I rl_complete")
else:
    readline.parse_and_bind("tab: complete")

class Completer(object):
    def __init__(self):
        # Enable a History
        self.HISTFILE=os.path.expanduser("%s/.pyhistory" % os.environ["HOME"])

        # Read the existing history if there is one
        if os.path.exists(self.HISTFILE):
            readline.read_history_file(self.HISTFILE)

        # Set maximum number of items that will be written to the history file
        readline.set_history_length(300)
        atexit.register(self.savehist)

    def savehist(self):
        import readline
        readline.write_history_file(self.HISTFILE)


c = Completer()

WELCOME=''
# Color Support
class TermColors(dict):
    """Gives easy access to ANSI color codes. Attempts to fall back to no color
for certain TERM values. (Mostly stolen from IPython.)"""

    COLOR_TEMPLATES = (
        ("Black" , "0;30"),
        ("Red" , "0;31"),
        ("Green" , "0;32"),
        ("Brown" , "0;33"),
        ("Blue" , "0;34"),
        ("Purple" , "0;35"),
        ("Cyan" , "0;36"),
        ("LightGray" , "0;37"),
        ("DarkGray" , "1;30"), ("LightRed" , "1;31"),
        ("LightGreen" , "1;32"),
        ("Yellow" , "1;33"),
        ("LightBlue" , "1;34"),
        ("LightPurple" , "1;35"),
        ("LightCyan" , "1;36"),
        ("White" , "1;37"),
        ("Normal" , "0"),
    )

    NoColor = ''
    _base = '\001\033[%sm\002'

    def __init__(self):
        if os.environ.get('TERM') in ('xterm-color', 'xterm-256color', 'linux',
                                    'screen', 'screen-256color', 'screen-bce'):
            self.update(dict([(k, self._base % v) for k,v in self.COLOR_TEMPLATES]))
        else:
            self.update(dict([(k, self.NoColor) for k,v in self.COLOR_TEMPLATES]))
_c = TermColors()



import sys
# Enable Color Prompts
sys.ps1 = '%s>>> %s' % (_c['Green'], _c['Normal'])
sys.ps2 = '%s... %s' % (_c['Red'], _c['Normal'])

# Enable Pretty Printing for stdout
def my_displayhook(value):
    if value is not None:
        try:
            import __builtin__
            __builtin__._ = value
        except ImportError:
            __builtins__._ = value

        import pprint
        pprint.pprint(value)
        del pprint

sys.displayhook = my_displayhook

# Start an external editor with \e
# http://aspn.activestate.com/ASPN/Cookbook/Python/Recipe/438813/


# Pretty print on by default
# from http://stackoverflow.com/questions/17248383/pretty-print-by-default-in-python-repl
import pprint
import sys

orig_displayhook = sys.displayhook

def myhook(value):
    if value != None:
        __builtins__._ = value
        pprint.pprint(value)

__builtins__.pprint_on = lambda: setattr(sys, 'displayhook', myhook)
__builtins__.pprint_off = lambda: setattr(sys, 'displayhook', orig_displayhook)
