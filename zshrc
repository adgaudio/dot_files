# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list 'r:|[._-]=** r:|=**'
zstyle :compinstall filename '/home/alex/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=10000
setopt appendhistory autocd extendedglob nomatch
unsetopt beep notify
bindkey -v
# End of lines configured by zsh-newuser-install

if [ -f ~/.local/bin/virtualenvwrapper.sh ] ; then
  source ~/.local/bin/virtualenvwrapper.sh
else
  echo "zshrc warning: virtualenvwrapper.sh not found"
fi


autoload -U colors && colors
autoload -U promptinit && promptinit
setopt correct promptsubst

# zsh tab completion menu
zstyle ':completion:*' menu select

# Add emacs functionality to vi-mode.  wtf isn't this default?
# http://paulgoscicki.com/archives/2012/09/zsh-vi-mode-with-emacs-keybindings/
# VI MODE KEYBINDINGS (ins mode)
bindkey -M viins '^a'    beginning-of-line
bindkey -M viins '^e'    end-of-line
bindkey -M viins '^k'    kill-line
bindkey -M viins '^r'    history-incremental-pattern-search-backward
bindkey -M viins '^s'    history-incremental-pattern-search-forward
bindkey -M viins '^p'    up-line-or-history
bindkey -M viins '^n'    down-line-or-history
bindkey -M viins '^y'    yank
bindkey -M viins '^w'    backward-kill-word
bindkey -M viins '^u'    backward-kill-line
bindkey -M viins '^h'    backward-delete-char
bindkey -M viins '^?'    backward-delete-char
bindkey -M viins '^_'    undo
bindkey -M viins '^x^r'  redisplay
bindkey -M viins '\eOH'  beginning-of-line # Home
bindkey -M viins '\eOF'  end-of-line       # End
bindkey -M viins '\e[2~' overwrite-mode    # Insert
#bindkey -M viins '\ef'   forward-word      # Alt-f
#bindkey -M viins '\eb'   backward-word     # Alt-b
#bindkey -M viins '\ed'   kill-word         # Alt-d

# VI MODE KEYBINDINGS (cmd mode)
bindkey -M vicmd '^a'    beginning-of-line
bindkey -M vicmd '^e'    end-of-line
bindkey -M vicmd '^k'    kill-line
bindkey -M vicmd '^r'    history-incremental-pattern-search-backward
bindkey -M vicmd '^s'    history-incremental-pattern-search-forward
bindkey -M vicmd '^p'    up-line-or-history
bindkey -M vicmd '^n'    down-line-or-history
bindkey -M vicmd '^y'    yank
bindkey -M vicmd '^w'    backward-kill-word
bindkey -M vicmd '^u'    backward-kill-line
bindkey -M vicmd '^h'    backward-delete-char
bindkey -M vicmd '^?'    backward-delete-char
bindkey -M vicmd '^_'    undo
bindkey -M vicmd '/'     vi-history-search-forward
bindkey -M vicmd '?'     vi-history-search-backward
bindkey -M vicmd '^_'    undo
#bindkey -M vicmd '\ef'   forward-word                      # Alt-f
#bindkey -M vicmd '\eb'   backward-word                     # Alt-b
#bindkey -M vicmd '\ed'   kill-word                         # Alt-d
bindkey -M vicmd '\e[5~' history-beginning-search-backward # PageUp
bindkey -M vicmd '\e[6~' history-beginning-search-forward  # PageDown

# in vi search, hitting / or ? followed by esc, there's an annoying delay. remove that delay
vi-search-fix() {
zle vi-cmd-mode
zle .vi-history-search-backward
}
autoload vi-search-fix
zle -N vi-search-fix
bindkey -M viins '\e/' vi-search-fix

. ~/.profile
