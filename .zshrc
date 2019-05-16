#zmodload zsh/zprof

export ZSH_DISABLE_COMPFIX=true
source "${HOME}/.zgen/zgen.zsh"

# We can manage zplug itself as a package!
# zplug 'zplug/zplug', hook-build:'zplug --self-manage'

if ! zgen saved; then

    export ZSH_DISABLE_COMPFIX=true
    # oh-my-zsh and its plugins
    zgen oh-my-zsh
    
    zgen oh-my-zsh plugins/docker
    zgen oh-my-zsh plugins/node
    zgen oh-my-zsh plugins/npm
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/dirhistory
    zgen oh-my-zsh plugins/encode64
    zgen oh-my-zsh plugins/bower
    zgen oh-my-zsh plugins/lein
    zgen oh-my-zsh plugins/gradle
    zgen oh-my-zsh plugins/tmux
    zgen oh-my-zsh plugins/cp
    zgen oh-my-zsh plugins/mosh
    zgen oh-my-zsh plugins/urltools

    #zgen load "b4b4r07/enhancd"

    zgen load "zsh-users/zsh-syntax-highlighting"
    zgen load "zsh-users/zsh-autosuggestions"
    zgen load "zsh-users/zsh-history-substring-search"
    zgen load "zsh-users/zsh-completions" src

    zgen load "djui/alias-tips"
    zgen load "horosgrisa/autoenv"
    zgen load "supercrabtree/k"

    zgen load "rupa/z"

    # Theme
    #zplug "dracula/zsh", as:theme
    #zplug "themes/amuse", from:oh-my-zsh, as:theme
    #zplug "themes/agnoster", from:oh-my-zsh, as:theme
    if [[ $- = *i* ]]; then
        zgen load "nojhan/liquidprompt"
    fi

    # generate the init script
    zgen save

fi

### Configurations

export ENHANCD_FILTER=fzy

# Auto-Suggestions

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'

bindkey '^\' autosuggest-execute
bindkey '^ ' autosuggest-accept


# History

HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000

setopt SHARE_HISTORY            # Share history between all sessions.
setopt incappendhistory
setopt HIST_EXPIRE_DUPS_FIRST   # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS         # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS     # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS        # Do not display a line previously found.
setopt HIST_SAVE_NO_DUPS        # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS       # Remove superfluous blanks before recording entry.
setopt EXTENDED_HISTORY		# Additional info on commands' execution. like time.

#bindkey '^[[A' history-substring-search-up
#bindkey '^[[B' history-substring-search-down
#bindkey -M vicmd 'k' history-substring-search-up
#bindkey -M vicmd 'j' history-substring-search-down

# Custom Keys

# vim style line editor

#bindkey -v

# fix delete and backspace

#bindkey '^[[P' delete-char
#bindkey '^[[3~' delete-char
#bindkey '^?' backward-delete-char

# ctrl left/right

#bindkey "^[OC" forward-word
#bindkey "^[OD" backward-word

# home and end
#bindkey "^[[1~" beginning-of-line
#bindkey "^[[4~" end-of-line

# Aliases

alias ls='ls --color=auto'
alias ll='ls -l'
alias lla='ll -A'

alias xsh='sudo -Es'
alias ash='sudo -u admin -Es'

export VST_PATH=$HOME/.vst-bridges/

# Running the real ssh-agent

REAL_SSH_AGENT_FILE="/var/tmp/ssh-agent.lock"

if [[ ! -f $REAL_SSH_AGENT_FILE ]]; then
    FILE_CONTENTS=$(ssh-agent | head -n -1)
    echo $FILE_CONTENTS > $REAL_SSH_AGENT_FILE
    REAL_SSH_AGENT_BIND_COMMANDS=$FILE_CONTENTS
else
    REAL_SSH_AGENT_BIND_COMMANDS=$(cat $REAL_SSH_AGENT_FILE)
fi

eval $REAL_SSH_AGENT_BIND_COMMANDS

source $HOME/.bashrc

if [[ $INSIDE_NETNS_SHELL != '' ]]; then
    export LP_PS1_PREFIX="$(tput setaf 11)($INSIDE_NETNS_SHELL) "
fi
